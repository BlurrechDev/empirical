part of entity;

abstract class Living {
  num health = 100;
  num maxHealth = 100;
  LivingEntity murderer;
  
  hurt(num damage, [LivingEntity attacker]) {
    health -= damage;
    if (health < 0) {
      death(murderr: attacker);
      health = 0;
    }
  }
  
  death({LivingEntity murderr});
  
  healBy(num healthIncrease) {
    health += healthIncrease;
    capHealth();
  }
  
  healTo(num newHealth) {
    health = newHealth;
    capHealth();
  }
  
  vitalize(num vitality) {
    maxHealth += vitality;
  }
  
  capHealth() {
    if (health > maxHealth) health = maxHealth;
  }

}