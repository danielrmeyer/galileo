package galileo.expr

import galileo.environment.Environment

case class ImplicitFunc1(name: String, e: Expr) extends FunF1 {
//  override def eval()(implicit env: Environment): Expr = this

  override def derive(v: Variable): Expr = Derivative(this, v)

  override def toString: String = s"$name(${e.toString})"

  override def variables: List[Variable] = e.variables

  override def info(env: Option[Environment]): String = "ImplicitFunc1(" + e.info() + ")"

  override def substitute(subs: Map[Expr, Expr]): Expr = {
    ImplicitFunc1(name, e.substitute(subs))
  }
}