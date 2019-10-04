
import SpriteKit

class MenuScene: SKScene, SKPhysicsContactDelegate{

var viewController : GameViewController?
var score : Int = 0
//var gameState = GameState.ready
var lastTime: TimeInterval = 0
var dt: TimeInterval = 0
var backgroundLayer: RepeatingLayer!
var gameSceneDelegate : GameSceneDelegate?
var myLabel : SKLabelNode!
var myScore : SKLabelNode!
var coinGotten = 200
var gotHit = -100
var time = Timer()
var finish = Timer()
var timerIsOn = false
var pullrequest = true
let button = SKSpriteNode(imageNamed: "pug0")
let pug = SKSpriteNode(imageNamed: "pug0")

override func didMove(to view: SKView) {
    createLayers()
    pugSprite()
    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "doaSegue"), object: nil)
}
    
func createLayers(){
    
    backgroundLayer = RepeatingLayer()
    addChild(backgroundLayer)
    
    for i in 0...1{
        let backgroundImage = SKSpriteNode(imageNamed: "DBZBackground")
        backgroundImage.name = String(i)
        backgroundImage.scale(to: frame.size)
        backgroundImage.anchorPoint = CGPoint.zero
        backgroundImage.position = CGPoint(x:0.0 + CGFloat(i) * backgroundImage.size.width, y:0.0)
        backgroundLayer.addChild(backgroundImage)
    }
    backgroundLayer.layerVelocity = CGPoint(x:-30, y: 0)
}

    func pugSprite(){
        let pug = SKTexture.init(imageNamed: "pug0")
        let pug1 = SKTexture.init(imageNamed: "pug1")
        let frame: [SKTexture] = [pug, pug1]
        button.name = "pug"
        button.size.width = 100
        button.size.height = 100
        button.position = CGPoint(x: 320, y: 140)
       // button.anchorPoint = CGPoint(x: 7.5, y: 6.5)
       // button.position = CGPoint (x: self.size.width/5, y: self.size.height/2)

       // button.position = CGPoint(x: 20, y: 10)
        let animations = SKAction.animate(with: frame, timePerFrame: 0.5)
        button.run(SKAction.repeatForever(animations))
        addChild(button)
    }


override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    let positionInScene = touch!.location(in: self)
    let touchedNode = self.atPoint(positionInScene)
    
    
    if let name = touchedNode.name{
        if name == "pug"{
            let newScene = Game(size: size)
            newScene.scaleMode = scaleMode
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            view?.presentScene(newScene, transition: reveal)
        }
                    }
                }
            }
