### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ a1b2c3d4-e5f6-7890-abcd-ef1234567890
begin
    using PlutoUI
    using Plots
    plotly()  # Interactive backend
end

# ╔═╡ b2c3d4e5-f6a7-8901-bcde-f23456789012
md"""
# Interactive Lecture Notes: Newton's Method

**Course:** Analysis I  
**Topic:** Numerical Root Finding  
**Author:** [Your Name]

---

This notebook demonstrates how lecture content can be delivered interactively. Students can:
- Adjust parameters using sliders
- See immediate visual feedback
- Experiment with edge cases
- Build intuition through exploration

---
"""

# ╔═╡ c3d4e5f6-a7b8-9012-cdef-345678901234
md"""
## 1. The Problem

We want to find $x^*$ such that $f(x^*) = 0$.

**Example:** Find $\sqrt{2}$ by solving $f(x) = x^2 - 2 = 0$
"""

# ╔═╡ d4e5f6a7-b8c9-0123-defa-456789012345
md"""
## 2. Newton's Method

Starting from an initial guess $x_0$, we iterate:

$$x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}$$

**Geometric interpretation:** Draw the tangent line at $(x_n, f(x_n))$ and find where it crosses the x-axis.
"""

# ╔═╡ e5f6a7b8-c9d0-1234-efab-567890123456
md"""
## 3. Interactive Exploration

Adjust the starting point and watch the convergence:
"""

# ╔═╡ f6a7b8c9-d0e1-2345-fabc-678901234567
@bind x0 Slider(-3.0:0.1:3.0, default=2.0, show_value=true)

# ╔═╡ 01234567-89ab-cdef-0123-456789abcdef
@bind max_iterations Slider(1:15, default=6, show_value=true)

# ╔═╡ 12345678-9abc-def0-1234-56789abcdef0
md"**Starting point:** $x_0 = $(x0)"

# ╔═╡ 23456789-abcd-ef01-2345-6789abcdef01
md"**Maximum iterations:** $(max_iterations)"

# ╔═╡ 34567890-bcde-f012-3456-789abcdef012
begin
    # Define the function and its derivative
    f(x) = x^2 - 2
    f_prime(x) = 2x
    
    # Newton's method iteration
    function newton_method(x0, f, f_prime, n_iter)
        history = [x0]
        x = x0
        for i in 1:n_iter
            if abs(f_prime(x)) < 1e-10  # Avoid division by zero
                break
            end
            x = x - f(x) / f_prime(x)
            push!(history, x)
        end
        return history
    end
    
    # Run Newton's method
    history = newton_method(x0, f, f_prime, max_iterations)
end;

# ╔═╡ 45678901-cdef-0123-4567-89abcdef0123
begin
    # Create the visualization
    xs = range(-3, 3, length=200)
    
    p = plot(xs, f.(xs), 
        label="f(x) = x² - 2", 
        lw=2, 
        color=:blue,
        xlabel="x",
        ylabel="y",
        title="Newton's Method: Finding √2",
        legend=:topleft,
        size=(700, 500)
    )
    
    # Draw tangent lines
    for i in 1:length(history)-1
        xi = history[i]
        yi = f(xi)
        slope = f_prime(xi)
        
        # Tangent line: y - yi = slope * (x - xi)
        tangent(x) = yi + slope * (x - xi)
        
        # Draw tangent (limited range)
        x_range = range(xi - 1.5, xi + 1.5, length=50)
        plot!(p, x_range, tangent.(x_range), 
            color=:orange, 
            alpha=0.5, 
            lw=1, 
            label=(i==1 ? "Tangent lines" : "")
        )
        
        # Draw vertical drop to next iteration
        plot!(p, [history[i+1], history[i+1]], [0, f(history[i+1])],
            color=:green,
            ls=:dash,
            alpha=0.5,
            label=""
        )
    end
    
    # Mark iteration points
    scatter!(p, history, f.(history), 
        label="Iterations", 
        ms=8, 
        color=:red,
        markerstrokewidth=2
    )
    
    # Draw x-axis
    hline!(p, [0], ls=:dash, color=:gray, label="", lw=1)
    
    # Mark true √2
    vline!(p, [sqrt(2)], color=:green, ls=:dot, label="√2 ≈ 1.414", lw=2)
    vline!(p, [-sqrt(2)], color=:green, ls=:dot, label="", lw=2)
    
    p
end

# ╔═╡ 56789012-def0-1234-5678-9abcdef01234
md"""
## 4. Convergence Analysis
"""

# ╔═╡ 67890123-ef01-2345-6789-abcdef012345
begin
    # Create convergence table
    convergence_data = []
    for (i, x) in enumerate(history)
        error = abs(x - sqrt(2))
        push!(convergence_data, (
            n = i-1,
            xn = round(x, digits=10),
            fxn = round(f(x), digits=10),
            error = error < 1e-15 ? "< 1e-15" : string(round(error, sigdigits=4))
        ))
    end
    convergence_data
end

# ╔═╡ 78901234-f012-3456-789a-bcdef0123456
md"""
| n | $x_n$ | $f(x_n)$ | $|x_n - \sqrt{2}|$ |
|---|-------|----------|-------------------|
$(join(["| $(d.n) | $(d.xn) | $(d.fxn) | $(d.error) |" for d in convergence_data], "\n"))
"""

# ╔═╡ 89012345-0123-4567-89ab-cdef01234567
md"""
## 5. Key Observations

**Try these experiments:**

1. **Starting near the root** ($x_0 = 1.5$): How many iterations to converge?

2. **Starting far away** ($x_0 = -3.0$): Does it still converge?

3. **Starting at $x_0 = 0$**: What happens? (Hint: look at $f'(0)$)

4. **Quadratic convergence**: Notice how errors square each iteration once close to the root.

---

**Theoretical result:** For simple roots where $f'(x^*) \neq 0$, Newton's method has **quadratic convergence**:

$$|x_{n+1} - x^*| \leq C |x_n - x^*|^2$$

This means the number of correct digits roughly doubles each iteration!
"""

# ╔═╡ 90123456-1234-5678-9abc-def012345678
md"""
## 6. Self-Check Exercise

**Question:** If $x_0 = 1.5$, what is $x_1$?

Use the formula: $x_1 = x_0 - \frac{f(x_0)}{f'(x_0)}$
"""

# ╔═╡ a0123456-2345-6789-abcd-ef0123456789
@bind student_answer TextField(default="")

# ╔═╡ b0123456-3456-789a-bcde-f01234567890
begin
    correct_answer = 1.5 - f(1.5) / f_prime(1.5)
    
    if isempty(student_answer)
        md"*Enter your answer above*"
    else
        try
            parsed = parse(Float64, student_answer)
            if abs(parsed - correct_answer) < 0.01
                md"✅ **Correct!** $x_1 = $(round(correct_answer, digits=6))"
            else
                md"❌ **Not quite.** Try again! Remember: $x_1 = x_0 - \frac{f(x_0)}{f'(x_0)}$"
            end
        catch
            md"⚠️ Please enter a number"
        end
    end
end

# ╔═╡ c0123456-4567-89ab-cdef-012345678901
md"""
---

## Summary

Newton's method is a powerful root-finding algorithm with:
- **Fast convergence** (quadratic near simple roots)
- **Simple implementation** (just need $f$ and $f'$)
- **Intuitive geometry** (follow tangent lines)

**Potential issues:**
- Division by zero if $f'(x_n) = 0$
- May diverge for bad starting points
- May oscillate or cycle

---

*This interactive notebook was created to demonstrate executable lecture notes.*
"""

# ╔═╡ d0123456-5678-9abc-def0-123456789012
md"""
---
## Technical Notes (for instructors)

This notebook uses:
- `PlutoUI.jl` for interactive widgets (`@bind`, `Slider`, `TextField`)
- `Plots.jl` for visualization
- Markdown cells for exposition
- Self-checking exercises

**Deployment options:**
1. Static HTML via `PlutoSliderServer.export_notebook()`
2. Live server via `PlutoSliderServer.run_notebook()`
3. Via Binder (click "Edit or run" in exported HTML)
"""

# ╔═╡ Cell order:
# ╠═a1b2c3d4-e5f6-7890-abcd-ef1234567890
# ╟─b2c3d4e5-f6a7-8901-bcde-f23456789012
# ╟─c3d4e5f6-a7b8-9012-cdef-345678901234
# ╟─d4e5f6a7-b8c9-0123-defa-456789012345
# ╟─e5f6a7b8-c9d0-1234-efab-567890123456
# ╠═f6a7b8c9-d0e1-2345-fabc-678901234567
# ╠═01234567-89ab-cdef-0123-456789abcdef
# ╟─12345678-9abc-def0-1234-56789abcdef0
# ╟─23456789-abcd-ef01-2345-6789abcdef01
# ╠═34567890-bcde-f012-3456-789abcdef012
# ╠═45678901-cdef-0123-4567-89abcdef0123
# ╟─56789012-def0-1234-5678-9abcdef01234
# ╠═67890123-ef01-2345-6789-abcdef012345
# ╟─78901234-f012-3456-789a-bcdef0123456
# ╟─89012345-0123-4567-89ab-cdef01234567
# ╟─90123456-1234-5678-9abc-def012345678
# ╠═a0123456-2345-6789-abcd-ef0123456789
# ╟─b0123456-3456-789a-bcde-f01234567890
# ╟─c0123456-4567-89ab-cdef-012345678901
# ╟─d0123456-5678-9abc-def0-123456789012
