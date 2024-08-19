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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/codefield/ISE_Verilog/P5_CPU/dt.v";
static int ng1[] = {1, 0};
static int ng2[] = {0, 0};
static unsigned int ng3[] = {0U, 0U};



static void Always_31_0(char *t0)
{
    char t6[8];
    char t30[8];
    char t31[8];
    char t40[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t28;
    char *t29;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t41;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 3648);
    *((int *)t2) = 1;
    t3 = (t0 + 3360);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);

LAB5:    xsi_set_current_line(32, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = ((char*)((ng1)));
    memset(t6, 0, 8);
    t7 = (t5 + 4);
    t8 = (t4 + 4);
    t9 = *((unsigned int *)t5);
    t10 = *((unsigned int *)t4);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t7);
    t13 = *((unsigned int *)t8);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t8);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB9;

LAB6:    if (t18 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t6) = 1;

LAB9:    t22 = (t6 + 4);
    t23 = *((unsigned int *)t22);
    t24 = (~(t23));
    t25 = *((unsigned int *)t6);
    t26 = (t25 & t24);
    t27 = (t26 != 0);
    if (t27 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(37, ng0);

LAB14:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    memset(t31, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t9 = *((unsigned int *)t3);
    t10 = *((unsigned int *)t2);
    t11 = (t9 ^ t10);
    t12 = *((unsigned int *)t4);
    t13 = *((unsigned int *)t5);
    t14 = (t12 ^ t13);
    t15 = (t11 | t14);
    t16 = *((unsigned int *)t4);
    t17 = *((unsigned int *)t5);
    t18 = (t16 | t17);
    t19 = (~(t18));
    t20 = (t15 & t19);
    if (t20 != 0)
        goto LAB18;

LAB15:    if (t18 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t31) = 1;

LAB18:    memset(t30, 0, 8);
    t8 = (t31 + 4);
    t23 = *((unsigned int *)t8);
    t24 = (~(t23));
    t25 = *((unsigned int *)t31);
    t26 = (t25 & t24);
    t27 = (t26 & 1U);
    if (t27 != 0)
        goto LAB19;

LAB20:    if (*((unsigned int *)t8) != 0)
        goto LAB21;

LAB22:    t22 = (t30 + 4);
    t32 = *((unsigned int *)t30);
    t33 = *((unsigned int *)t22);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB23;

LAB24:    t35 = *((unsigned int *)t30);
    t36 = (~(t35));
    t37 = *((unsigned int *)t22);
    t38 = (t36 || t37);
    if (t38 > 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t22) > 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t30) > 0)
        goto LAB29;

LAB30:    memcpy(t6, t40, 8);

LAB31:    t41 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t41, t6, 0, 0, 2, 0LL);
    xsi_set_current_line(39, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t0 + 2248);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 5);
    xsi_set_current_line(40, ng0);
    t2 = (t0 + 1688U);
    t3 = *((char **)t2);
    t2 = (t0 + 2408);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 5);

LAB12:    goto LAB2;

LAB8:    t21 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(32, ng0);

LAB13:    xsi_set_current_line(33, ng0);
    t28 = ((char*)((ng2)));
    t29 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t29, t28, 0, 0, 2, 0LL);
    xsi_set_current_line(34, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2248);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 5, 0LL);
    xsi_set_current_line(35, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 5, 0LL);
    goto LAB12;

LAB17:    t7 = (t31 + 4);
    *((unsigned int *)t31) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB18;

LAB19:    *((unsigned int *)t30) = 1;
    goto LAB22;

LAB21:    t21 = (t30 + 4);
    *((unsigned int *)t30) = 1;
    *((unsigned int *)t21) = 1;
    goto LAB22;

LAB23:    t28 = ((char*)((ng2)));
    goto LAB24;

LAB25:    t29 = (t0 + 1368U);
    t39 = *((char **)t29);
    t29 = ((char*)((ng1)));
    memset(t40, 0, 8);
    xsi_vlog_unsigned_minus(t40, 32, t39, 2, t29, 32);
    goto LAB26;

LAB27:    xsi_vlog_unsigned_bit_combine(t6, 32, t28, 32, t40, 32);
    goto LAB31;

LAB29:    memcpy(t6, t28, 8);
    goto LAB31;

}


extern void work_m_00000000002546853925_1691318532_init()
{
	static char *pe[] = {(void *)Always_31_0};
	xsi_register_didat("work_m_00000000002546853925_1691318532", "isim/mips_tb_isim_beh.exe.sim/work/m_00000000002546853925_1691318532.didat");
	xsi_register_executes(pe);
}
