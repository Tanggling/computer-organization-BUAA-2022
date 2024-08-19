/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001092512866_3224323566_init();
    work_m_00000000003679489606_0757879789_init();
    work_m_00000000001965458500_2501999318_init();
    work_m_00000000003292122505_3092946469_init();
    work_m_00000000000022700526_3480269028_init();
    work_m_00000000002979380016_1621229167_init();
    work_m_00000000003063656907_3851022957_init();
    work_m_00000000002546853925_1691318532_init();
    work_m_00000000000143782082_0886308060_init();
    work_m_00000000003688917498_0514157065_init();
    work_m_00000000000747566642_2924402094_init();
    work_m_00000000002373521766_3634784071_init();
    work_m_00000000001570087270_4293230160_init();
    work_m_00000000001286823938_3877310806_init();
    work_m_00000000002047498008_0258635663_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002047498008_0258635663");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}