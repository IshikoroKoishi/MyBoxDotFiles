require "cairo"

function conky_main()
    if conky_window == nil
    then
        return
    end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    cr = cairo_create(cs)
    
    local updates = tonumber(conky_parse("${updates}"))
    if updates == 1
    then
        cpu_graph = {
            width = 50,
            length = 75,
            radius = 225,
            center = {
                x = 305,
                y = 305
            }
        }
        
        num_cpu_core = 4
        cpu_table_len = 360 / num_cpu_core
        cpu_table = {}

        for i = 1, num_cpu_core
        do
            cpu_table[i] = {}
        end
    elseif updates > 1
    then
        draw_cpu_graph()
    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cs, cr = nil
end

function line(pt1, pt2, color, thickness)
    cairo_set_source_rgba(cr, color.red, color.green, color.blue, color.alpha)
    cairo_set_line_width(cr, thickness)
    cairo_move_to(cr, pt1.x, pt1.y)
    cairo_line_to(cr, pt2.x, pt2.y)
    cairo_stroke(cr)
end

function update_cpu_table()
    for i = 1, cpu_table_len
    do
        for j = 1, num_cpu_core
        do
            if cpu_table[j][i] == nil
            then
                cpu_table[j][i] = 0
            end
        end
    end
    for i = cpu_table_len, 2, -1
    do
        for j = 1, num_cpu_core
        do
            cpu_table[j][i] = cpu_table[j][i - 1]
        end
    end
    for i = 1, num_cpu_core
    do
        local cpu_value = tonumber(conky_parse(string.format("${cpu cpu%d}", i)))
        if cpu_value ~=nil
        then
            cpu_table[i][1] = cpu_value
            print(cpu_value)
        else
            cpu_table[i][1] = 0
        end
    end
end

function draw_cpu_graph()
    update_cpu_table()
    local offset = cpu_graph.radius - (cpu_graph.width / 2)
    for i = 1, num_cpu_core
    do
        for j = 1, cpu_table_len
        do
            local length = cpu_graph.width / 180 * cpu_table[i][j]
            local pt = (360 / num_cpu_core / cpu_table_len) * (i * cpu_table_len + j - 1) * math.pi / 180.0
            local pt1 = {
                x = offset * math.sin(pt) + cpu_graph.center.x,
                y = offset * math.cos(pt) + cpu_graph.center.y
            }
            local pt2 = {
                x = (offset + length) * math.sin(pt) + cpu_graph.center.x,
                y = (offset + length) * math.cos(pt) + cpu_graph.center.y
            }
            local color = {
                red = 1,
                green = 1,
                blue = 1,
                alpha = 1
            }
            line(pt1, pt2, color, 1)
        end
    end
end
