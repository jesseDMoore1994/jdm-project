#include "jdm-project.h"
#include <jdm-log.h>

int main() {
  jdm_log_init();
  if(one() != 0) {
    JDM_LOG_ERROR("Write tests here...");
    return 1;
  }
  jdm_log_cleanup();
}
