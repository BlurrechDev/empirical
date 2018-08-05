part of entity;

class LivingEntity extends Entity with Living, Moving {
  
  LivingEntity(String spriteSrc) : super(spriteSrc);
  
  death({LivingEntity murderr}) {
    murderer = murderr;
    dead = true;
  }
  
}