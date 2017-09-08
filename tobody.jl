using Plots
forcefactor = 1.0
dt = 0.05
T = 4.0


type Particle
    mass::Float64
    x::Float64
    y::Float64
    vx::Float64
    vy::Float64
    ax::Float64
    ay::Float64
end

function calcforce(p1::Particle,p2::Particle)
  distn2=1/((p1.x-p2.x)^2+(p1.y-p2.y)^2)
  theta = atan(p2.y-p1.y)/(p2.x-p1.x)
  return distn2*forcefactor*[cos(theta),sin(theta)]
end

pos1x= Array{Float64}(floor(Int,T/dt))
pos2x= Array{Float64}(floor(Int,T/dt))
pos1y= Array{Float64}(floor(Int,T/dt))
pos2y= Array{Float64}(floor(Int,T/dt))

p1=Particle(10.0,-1.0,0.0,0.0,0.0,0.0,0.0)
p2=Particle(1.0,1.0,0.0,0.0,-0.9,0.0,0.0)

for i=1:floor(Int,T/dt)
  Force=calcforce(p1,p2)
  p2.ax=-Force[1]/p2.mass
  p2.ay=-Force[2]/p2.mass
  p1.ax=Force[1]/p1.mass
  p1.ay=Force[2]/p1.mass
  p1.vx+=p1.ax*dt*0.5
  p1.vy+=p1.ay*dt*0.5
  p2.vx+=p2.ax*dt*0.5
  p2.vy+=p2.ay*dt*0.5
# Second Step
  p1.vx+=p1.ax*dt*0.5
  p1.vy+=p1.ay*dt*0.5
  p2.vx+=p2.ax*dt*0.5
  p2.vy+=p2.ay*dt*0.5
  p1.x+=p1.vx*dt
  p1.y+=p1.vy*dt
  p2.x+=p2.vx*dt
  p2.y+=p2.vy*dt
  pos1x[i]=p1.x
  pos1y[i]=p1.y
  pos2x[i]=p2.x
  pos2y[i]=p2.y
end

gr()
ys = Vector[pos1y,pos2y]
xs = Vector[pos1x,pos2x]
plot(xs,ys,color=[:black :orange],line=(:dot,0.004),marker=([:hex :d],0.0012,0.008))

# display(plot)
# plot(pos1x,pos1y,"r",pos2x,pos2y,"b")
