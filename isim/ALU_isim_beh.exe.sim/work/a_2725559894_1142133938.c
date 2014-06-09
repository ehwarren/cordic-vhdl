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

/* This file is designed for use with ISim build 0x2f00eba5 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//samba.engr.uvic.ca/home/austin/441/cordic-vhdl/ALU.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);
char *ieee_p_1242562249_sub_3064532541_1035706684(char *, char *, char *, char *, int );
char *ieee_p_1242562249_sub_3273497107_1035706684(char *, char *, char *, char *, char *, char *);
char *ieee_p_1242562249_sub_3273568981_1035706684(char *, char *, char *, char *, char *, char *);


static void work_a_2725559894_1142133938_p_0(char *t0)
{
    char t11[16];
    char t14[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t12;
    char *t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    static char *nl0[] = {&&LAB14, &&LAB14, &&LAB12, &&LAB13, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14};

LAB0:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3564);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 592U);
    t5 = *((char **)t1);
    t1 = (t0 + 1776U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    memcpy(t1, t5, 32U);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t1 = (t0 + 1844U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(68, ng0);
    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t1 = (t0 + 1912U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(69, ng0);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t1 = (t0 + 6500U);
    t7 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t1);
    t5 = (t0 + 1980U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    *((int *)t5) = t7;
    xsi_set_current_line(71, ng0);
    t1 = (t0 + 1328U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t8 = (t4 == (unsigned char)3);
    if (t8 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(72, ng0);
    t5 = (t0 + 1236U);
    t6 = *((char **)t5);
    t10 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t10);
    goto **((char **)t5);

LAB8:    t1 = (t0 + 1304U);
    t9 = xsi_signal_has_event(t1);
    t3 = t9;
    goto LAB10;

LAB11:    goto LAB6;

LAB12:    xsi_set_current_line(74, ng0);
    t12 = (t0 + 1776U);
    t13 = *((char **)t12);
    t12 = (t0 + 6580U);
    t15 = (t0 + 1844U);
    t16 = *((char **)t15);
    t15 = (t0 + 6580U);
    t17 = (t0 + 1980U);
    t18 = *((char **)t17);
    t7 = *((int *)t18);
    t17 = ieee_p_1242562249_sub_3064532541_1035706684(IEEE_P_1242562249, t14, t16, t15, t7);
    t19 = ieee_p_1242562249_sub_3273497107_1035706684(IEEE_P_1242562249, t11, t13, t12, t17, t14);
    t20 = (t0 + 3624);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    t23 = (t22 + 40U);
    t24 = *((char **)t23);
    memcpy(t24, t19, 32U);
    xsi_driver_first_trans_fast_port(t20);
    goto LAB11;

LAB13:    xsi_set_current_line(76, ng0);
    t1 = (t0 + 1776U);
    t2 = *((char **)t1);
    t1 = (t0 + 6580U);
    t5 = (t0 + 1844U);
    t6 = *((char **)t5);
    t5 = (t0 + 6580U);
    t12 = (t0 + 1980U);
    t13 = *((char **)t12);
    t7 = *((int *)t13);
    t12 = ieee_p_1242562249_sub_3064532541_1035706684(IEEE_P_1242562249, t14, t6, t5, t7);
    t15 = ieee_p_1242562249_sub_3273568981_1035706684(IEEE_P_1242562249, t11, t2, t1, t12, t14);
    t16 = (t0 + 3624);
    t17 = (t16 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 40U);
    t20 = *((char **)t19);
    memcpy(t20, t15, 32U);
    xsi_driver_first_trans_fast_port(t16);
    goto LAB11;

LAB14:    xsi_set_current_line(78, ng0);
    t1 = (t0 + 7076);
    t5 = (t0 + 3624);
    t6 = (t5 + 32U);
    t12 = *((char **)t6);
    t13 = (t12 + 40U);
    t15 = *((char **)t13);
    memcpy(t15, t1, 32U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB11;

}

static void work_a_2725559894_1142133938_p_1(char *t0)
{
    char t11[16];
    char t14[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t12;
    char *t13;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    static char *nl0[] = {&&LAB14, &&LAB14, &&LAB13, &&LAB12, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14};

LAB0:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3572);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 592U);
    t5 = *((char **)t1);
    t1 = (t0 + 2048U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    memcpy(t1, t5, 32U);
    xsi_set_current_line(93, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t1 = (t0 + 2116U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(94, ng0);
    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t1 = (t0 + 2184U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(95, ng0);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t1 = (t0 + 6500U);
    t7 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t1);
    t5 = (t0 + 2252U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    *((int *)t5) = t7;
    xsi_set_current_line(97, ng0);
    t1 = (t0 + 1328U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t8 = (t4 == (unsigned char)3);
    if (t8 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(98, ng0);
    t5 = (t0 + 1236U);
    t6 = *((char **)t5);
    t10 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t10);
    goto **((char **)t5);

LAB8:    t1 = (t0 + 1304U);
    t9 = xsi_signal_has_event(t1);
    t3 = t9;
    goto LAB10;

LAB11:    goto LAB6;

LAB12:    xsi_set_current_line(100, ng0);
    t12 = (t0 + 2116U);
    t13 = *((char **)t12);
    t12 = (t0 + 6596U);
    t15 = (t0 + 2048U);
    t16 = *((char **)t15);
    t15 = (t0 + 6596U);
    t17 = (t0 + 2252U);
    t18 = *((char **)t17);
    t7 = *((int *)t18);
    t17 = ieee_p_1242562249_sub_3064532541_1035706684(IEEE_P_1242562249, t14, t16, t15, t7);
    t19 = ieee_p_1242562249_sub_3273497107_1035706684(IEEE_P_1242562249, t11, t13, t12, t17, t14);
    t20 = (t0 + 3660);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    t23 = (t22 + 40U);
    t24 = *((char **)t23);
    memcpy(t24, t19, 32U);
    xsi_driver_first_trans_fast_port(t20);
    goto LAB11;

LAB13:    xsi_set_current_line(102, ng0);
    t1 = (t0 + 2116U);
    t2 = *((char **)t1);
    t1 = (t0 + 6596U);
    t5 = (t0 + 2048U);
    t6 = *((char **)t5);
    t5 = (t0 + 6596U);
    t12 = (t0 + 2252U);
    t13 = *((char **)t12);
    t7 = *((int *)t13);
    t12 = ieee_p_1242562249_sub_3064532541_1035706684(IEEE_P_1242562249, t14, t6, t5, t7);
    t15 = ieee_p_1242562249_sub_3273568981_1035706684(IEEE_P_1242562249, t11, t2, t1, t12, t14);
    t16 = (t0 + 3660);
    t17 = (t16 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 40U);
    t20 = *((char **)t19);
    memcpy(t20, t15, 32U);
    xsi_driver_first_trans_fast_port(t16);
    goto LAB11;

LAB14:    xsi_set_current_line(104, ng0);
    t1 = (t0 + 7108);
    t5 = (t0 + 3660);
    t6 = (t5 + 32U);
    t12 = *((char **)t6);
    t13 = (t12 + 40U);
    t15 = *((char **)t13);
    memcpy(t15, t1, 32U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB11;

}

static void work_a_2725559894_1142133938_p_2(char *t0)
{
    char t11[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    int t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    static char *nl0[] = {&&LAB14, &&LAB14, &&LAB12, &&LAB13, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14};

LAB0:    xsi_set_current_line(117, ng0);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 3580);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(118, ng0);
    t1 = (t0 + 592U);
    t5 = *((char **)t1);
    t1 = (t0 + 2320U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    memcpy(t1, t5, 32U);
    xsi_set_current_line(119, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t1 = (t0 + 2388U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(120, ng0);
    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t1 = (t0 + 2456U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 32U);
    xsi_set_current_line(121, ng0);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t1 = (t0 + 6500U);
    t7 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t1);
    t5 = (t0 + 2524U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    *((int *)t5) = t7;
    xsi_set_current_line(123, ng0);
    t1 = (t0 + 1328U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t8 = (t4 == (unsigned char)3);
    if (t8 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(125, ng0);
    t5 = (t0 + 1236U);
    t6 = *((char **)t5);
    t10 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t10);
    goto **((char **)t5);

LAB8:    t1 = (t0 + 1304U);
    t9 = xsi_signal_has_event(t1);
    t3 = t9;
    goto LAB10;

LAB11:    goto LAB6;

LAB12:    xsi_set_current_line(127, ng0);
    t12 = (t0 + 2456U);
    t13 = *((char **)t12);
    t12 = (t0 + 6612U);
    t14 = (t0 + 960U);
    t15 = *((char **)t14);
    t14 = (t0 + 6516U);
    t16 = ieee_p_1242562249_sub_3273497107_1035706684(IEEE_P_1242562249, t11, t13, t12, t15, t14);
    t17 = (t0 + 3696);
    t18 = (t17 + 32U);
    t19 = *((char **)t18);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t16, 32U);
    xsi_driver_first_trans_fast_port(t17);
    goto LAB11;

LAB13:    xsi_set_current_line(129, ng0);
    t1 = (t0 + 2456U);
    t2 = *((char **)t1);
    t1 = (t0 + 6612U);
    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t5 = (t0 + 6516U);
    t12 = ieee_p_1242562249_sub_3273568981_1035706684(IEEE_P_1242562249, t11, t2, t1, t6, t5);
    t13 = (t0 + 3696);
    t14 = (t13 + 32U);
    t15 = *((char **)t14);
    t16 = (t15 + 40U);
    t17 = *((char **)t16);
    memcpy(t17, t12, 32U);
    xsi_driver_first_trans_fast_port(t13);
    goto LAB11;

LAB14:    xsi_set_current_line(131, ng0);
    t1 = (t0 + 7140);
    t5 = (t0 + 3696);
    t6 = (t5 + 32U);
    t12 = *((char **)t6);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 32U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB11;

}


extern void work_a_2725559894_1142133938_init()
{
	static char *pe[] = {(void *)work_a_2725559894_1142133938_p_0,(void *)work_a_2725559894_1142133938_p_1,(void *)work_a_2725559894_1142133938_p_2};
	xsi_register_didat("work_a_2725559894_1142133938", "isim/ALU_isim_beh.exe.sim/work/a_2725559894_1142133938.didat");
	xsi_register_executes(pe);
}
