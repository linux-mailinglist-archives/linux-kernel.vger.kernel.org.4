Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD55BD23C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiISQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiISQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:31:38 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828093AE72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:31:34 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so2524427oth.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=5bw400owRwuvLYz6+rV0OFrDuY58Ukr642k17z8Fn8Y=;
        b=FytgnEjKDQyquYVrESyecUGbTVqgHxl/AcE2e44pIba0B8fvQGPuzhl4ApKRmrg86d
         2zh0iQyeFLI+GZnFKTz2+kNsiSrTL6C1MYvwb4TwTDVQyunW5kJDo8lNOKLunr2D94TP
         WJe1M3QTkwe6w3/hIeOSW5fLtRr5nX7vluwiZCseKwKww1nY8R1goN85BZ9K47dH9LDa
         W8B0O0t2MhAGIrH2AZrz7WYy7aXJBPsS5cZUhsYy4kB+eIk8QSgjM/8uLyx1dgkTLxSW
         pUQDF/nHPdcP3IW/7cySpNODF4i0XGpaJgjJ62h7pESRiS6lHSgMfy5G+vl3Y/y02ub1
         N6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5bw400owRwuvLYz6+rV0OFrDuY58Ukr642k17z8Fn8Y=;
        b=qtE1J+C3q+bbJ+7HmLhpdlVStKnp0A46dfRigchTKiUs/thXEukOgtfbGplnQfmlqS
         nqgJabDgffownPaPvCE6WRnCZEf/Ootx8t6URhSjcBbsN6OyGC9bPp12sLS7VUcGAaQi
         j10tAESOj1leMwX34b409P6LnYbbyprqVLjmxD9Xbc7iFvRReQlxSiJMDGdLWX21ralB
         xFUUib07cfNt/X4bwu4Qw7hqwRxqZxde18U9CEQxYIPJkM7+aXBF7StmN6ose5NtQthY
         1c0k4f7aN0qneCo6rWwmKUXYGdi0UkPtv6ejSL0qxPcGHlHkyCOEaGf+uYLjdBUMOQvu
         HGmA==
X-Gm-Message-State: ACrzQf1/nWobKKWDo8+WUrZt8nWPCGv+EaE9zy357ec5DiLbQSsKmeQ6
        u59EEaZ5ZT6gIsYdV+1hPQxmLjJvXbJj0IGMpOZidg==
X-Google-Smtp-Source: AMsMyM7i6P6y2fEduK+MvTiCjq0zA5qYJcQ8yCQL3XSuiDrpGownnL0Mp4iSlhjSeCqEH1uptmLLJ4S9yQvQXiCleCI=
X-Received: by 2002:a9d:b96:0:b0:655:bee5:41d3 with SMTP id
 22-20020a9d0b96000000b00655bee541d3mr8243015oth.139.1663605093621; Mon, 19
 Sep 2022 09:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-5-bchihi@baylibre.com>
 <e2bcc0db-8810-2652-0eba-9cdc096b2054@linaro.org>
In-Reply-To: <e2bcc0db-8810-2652-0eba-9cdc096b2054@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 19 Sep 2022 18:30:56 +0200
Message-ID: <CAGuA+oqu_XWNEbzs5oeZwRN0g=jbFzgt0MhcvyNE2q1f_wOdaA@mail.gmail.com>
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you very much for your time to do this review.
You will find below answers to your questions. And some questions from
my side too.
The comments that are not present in this email, are already implemented.
Please let me know if you have any additional questions.

> > Add LVTS v4 (Low Voltage Thermal Sensor) driver to report junction
> > temperatures in MediaTek SoC mt8192 and register the maximum temperatur=
e
> > of sensors and each sensor as a thermal zone.
>
> As it is a new driver submission, a more detailed hardware description
> of the sensors may help to have a better understanding of the driver
> implementation
>
> I think also the patch size is too big and the driver should be
> submitted with a reduced number of changes.
>
> The header file should be simplified as much as possible. As well as the
> structures.
>
> The driver initialization should be lvts_v4_init -> lvts_init, that
> means one function to init and one to exit. No other functions being
> called from lvts_v4 to lvts
>

Would you please explain this point further?

> Overall the driver is very complex and hard to review. I tried to review
> as much as possible but there is too much code. So I gave up the review
> after digging into too many details to be reworked.
>
> See below
>

[...]

> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/=
mediatek/lvts_thermal.c
> > new file mode 100644
> > index 000000000000..a1681b914c69
> > --- /dev/null
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -0,0 +1,861 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */

[...]

> > +static void lvts_reset(struct lvts_data *lvts_data)
>
> error handling: static int ...
>
> > +{
> > +     if (lvts_data->reset)
> > +             reset_control_assert(lvts_data->reset);
>
> error handling
>
> > +
> > +     if (lvts_data->reset)
> > +             reset_control_deassert(lvts_data->reset);
>
> error handling
>
> It is the same condition, both calls can go under the same block.
>
>
> BTW, why assert + deassert ?
>

For more than one reset signal.

> > +}
> > +
> > +static void device_identification(struct lvts_data *lvts_data)
>
> error handling: static int ...
>
> > +{
> > +     void __iomem *base;
> > +     struct device *dev =3D lvts_data->dev;
> > +     unsigned int i, data;
> > +
> > +     for (i =3D 0; i < lvts_data->num_tc; i++) {
> > +             base =3D GET_BASE_ADDR(lvts_data, i);
> > +             writel(ENABLE_LVTS_CTRL_CLK, LVTSCLKEN_0 + base);
>
> Isn't it already done with the clk framework ?
>

No. this is the LVTS hardware internal clock :
The clocks of the Thermal Controllers.

> > +             lvts_write_device(lvts_data, RESET_ALL_DEVICES(lvts_data)=
, i);
>
> Why a call to RESET_*ALL*_DEVICES in the loop? I'm confused, it is
> resetting all the devices but with a 'tc_id' passed as parameter
>
> Is it possible to use the assert reset for that ?
>

=E2=80=9CALL=E2=80=9D means all sensors (TS) in this Thermal Controller (TC=
).

> > +             writel(READ_BACK_DEVICE_ID(lvts_data), LVTS_CONFIG_0 + ba=
se);
>
> What means READ_BACK?
>

Read and update the sensor in the TC.

> > +             usleep_range(20, 30);
>
> Why is that needed ?
>

Wait for the hardware to be ready.
it has been reduced to the lowest possible value "usleep_range(2, 4)",
but it can't be removed : lower than that the hardware malfunctions.

> > +             /* Check LVTS device ID */
> > +             data =3D (readl(LVTS_ID_0 + base) & DEVICE_REG_DATA);
> > +             if (data !=3D (lvts_data->tc->dev_id + i))
> > +                     dev_err(dev, "LVTS_TC_%d, Device ID should be 0x%=
x, but 0x%x\n",
> > +                             i, (lvts_data->tc->dev_id + i), data);
>
> I'm confused, what is the purpose of the device_identification()
> function if you already know the id? When this situation can happen?
>

It=E2=80=99s a hardware initialization flow to identify if the correct
hardware module exists and is ready for initialization.

> > +     }
> > +}

[...]

> > +static void set_hw_filter(struct lvts_data *lvts_data, int tc_id)
> > +{
> > +     void __iomem *base =3D GET_BASE_ADDR(lvts_data, tc_id);
> > +     struct device *dev =3D lvts_data->dev;
> > +     const struct lvts_tc_settings *tc =3D lvts_data->tc;
> > +     unsigned int option =3D tc[tc_id].hw_filter & 0x7;
> > +
> > +     /*
> > +      * hw filter
> > +      * 000: Get one sample
> > +      * 001: Get 2 samples and average them
> > +      * 010: Get 4 samples, drop max and min, then average the rest of=
 2 samples
> > +      * 011: Get 6 samples, drop max and min, then average the rest of=
 4 samples
> > +      * 100: Get 10 samples, drop max and min, then average the rest o=
f 8 samples
> > +      * 101: Get 18 samples, drop max and min, then average the rest o=
f 16 samples
> > +      */
> > +     option =3D (option << 9) | (option << 6) | (option << 3) | option=
;
>
> I'm missing to understand, can you explain this bit changes?
>

The 3 bits are one set defined by hardware usage.

> > +     writel(option, LVTSMSRCTL0_0 + base);
> > +     dev_dbg(dev, "lvts_tc_%d, LVTSMSRCTL0_0=3D 0x%x\n", tc_id, readl(=
LVTSMSRCTL0_0 + base));
> > +}
> > +
>
> This function deserves an explanation. Why a dominator index exists?
>

The dominator index is the Thermal Sensor that will be used as a
sensing point to reboot the HW in critical temperature.
This function sets a thermal sensor for that purpose.

[...]

> > +static void disable_hw_reboot_interrupt(struct lvts_data *lvts_data, i=
nt tc_id)
> > +{
> > +     void __iomem *base =3D GET_BASE_ADDR(lvts_data, tc_id);
> > +     unsigned int temp;
> > +
> > +     /*
> > +     * LVTS thermal controller has two interrupts for thermal HW reboo=
t.
> > +     * One is for AP SW and the other is for RGU.
>
> May be reword "thermal controller" to something like "thermal domain" or
> whatever. It is confusing with the thermal controller contained in
> lvts_data.
>
> > +     * The interrupt of AP SW can be turned off by a bit of a register=
,
> > +     * but the other for RGU cannot.
> > +     * To prevent rebooting device accidentally, we are going to add
> > +     * a huge offset 0x3FFF to LVTS and make it always report extremel=
y low temperature.
> > +     * LVTS always adds the offset 0x3FFF to MSR_RAW.
> > +     * When MSR_RAW is larger, SW will convert lower temperature.
>
> I'm not sure to fully understand the explanation and the goal.
>

Hardware constraint.

> > +     */ > +  temp =3D readl(LVTSPROTCTL_0 + base);
> > +     writel(temp | 0x3FFF, LVTSPROTCTL_0 + base);
> > +
> > +     /* Disable the interrupt of AP SW */
> > +     temp =3D readl(LVTSMONINT_0 + base);
> > +     writel(temp & ~(STAGE3_INT_EN), LVTSMONINT_0 + base);
> > +}

[...]

> > +static void set_tc_hw_reboot_threshold(struct lvts_data *lvts_data, in=
t trip_point, int tc_id)
> > +{
> > +     void __iomem *base =3D GET_BASE_ADDR(lvts_data, tc_id);
> > +     struct device *dev =3D lvts_data->dev;
> > +     unsigned int msr_raw, temp, config, d_index;
> > +
> > +     d_index =3D get_dominator_index(lvts_data, tc_id);
> > +
> > +     dev_dbg(dev, "lvts_tc_%d: dominator sensing point =3D %d\n", tc_i=
d, d_index);
> > +
> > +     disable_hw_reboot_interrupt(lvts_data, tc_id);
> > +     temp =3D readl(LVTSPROTCTL_0 + base);
> > +     if (d_index =3D=3D ALL_SENSING_POINTS) {
> > +             /* Maximum of 4 sensing points */
> > +             config =3D (0x1 << 16);
> > +             writel(config | temp, LVTSPROTCTL_0 + base);
> > +
> > +     } else {
> > +             /* Select protection sensor */
> > +             config =3D ((d_index << 2) + 0x2) << 16;
> > +             writel(config | temp, LVTSPROTCTL_0 + base);
> > +     }
>
> So if ALL_SENSING_POINTS is set, the hardware is able to reboot on the
> first sensors reaching the hw reboot temp, otherwise it is the specified
> sensor which triggers the hw reboot? Do I read it correctly?
>

Yes. Will reboot on the first sensors reaching the hardware reboot
temp. But tc need have 4 sensors.

> Why not use the ALL_SENSING_POINTS for all the cases?
>

Not all TCs have 4 sensors.
And ALL_SENSING_POINTS need more hardware resource/time to check 4
sensors. So we use one sensor for usage.

> > +     msr_raw =3D lvts_temp_to_raw(&lvts_data->coeff, trip_point);
> > +     writel(msr_raw, LVTSPROTTC_0 + base);
> > +     enable_hw_reboot_interrupt(lvts_data, tc_id);
> > +}

[...]

> > +static void tc_irq_handler(struct lvts_data *lvts_data, int tc_id)
> > +{
> > +     void __iomem *base =3D GET_BASE_ADDR(lvts_data, tc_id);
> > +     const struct device *dev =3D lvts_data->dev;
> > +     unsigned int ret =3D readl(LVTSMONINTSTS_0 + base);
> > +
> > +     /* Write back to clear interrupt status */
> > +     writel(ret, LVTSMONINTSTS_0 + base);
> > +     dev_dbg(dev, "LVTS thermal controller %d, LVTSMONINTSTS=3D0x%08x\=
n", tc_id, ret);
> > +     if (ret & THERMAL_PROTECTION_STAGE_3)
>
> That means ?
>

It=E2=80=99s hardware design for clearing the interrupt status. (write
register to clear interrupt status)

> > +             dev_dbg(dev, "Thermal protection stage 3 interrupt trigge=
red\n");
>
> When do we notify the thermal zone an interrupt happened because of a
> trip point?
>

Just to print log to let the software know that the highest/reboot
temperature has happened.

> > +}
> > +
> > +static irqreturn_t irq_handler(int irq, void *dev_id)
> > +{
> > +     void __iomem *base;
> > +     struct lvts_data *lvts_data =3D (struct lvts_data *)dev_id;
> > +     struct device *dev =3D lvts_data->dev;
> > +     const struct lvts_tc_settings *tc =3D lvts_data->tc;
> > +     unsigned int i, irq_bitmap;
> > +
> > +     base =3D lvts_data->base;
> > +     irq_bitmap =3D readl(THERMINTST + base);
> > +     dev_dbg(dev, "THERMINTST =3D 0x%x\n", irq_bitmap);
>
> IIUC, there is one interrupt happening when a temperature threshold is
> crossed but we don't know which sensor it is. So we retrieve the bit
> mask of interrupt pending, right ? ...
>

The interrupt belongs to TC.

> > +     for (i =3D 0; i < lvts_data->num_tc; i++) {
> > +             if (tc[i].irq_bit =3D=3D 0)
>
> ... but then what do we do with this bitmap ?
>

The bitmap is used to store values of AP and MCU.

> > +                     tc_irq_handler(lvts_data, i);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}

[...]

> > diff --git a/drivers/thermal/mediatek/lvts_thermal.h b/drivers/thermal/=
mediatek/lvts_thermal.h
> > new file mode 100644
> > index 000000000000..a94ce46acccd
> > --- /dev/null
> > +++ b/drivers/thermal/mediatek/lvts_thermal.h
> > @@ -0,0 +1,385 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */

[...]

> > +
> > +struct lvts_data;
>
> This forward declaration should not be needed
>

This is needed because "struct platform_ops" uses "struct lvts_data" as arg=
s.
removing it causes a compilation error.
and "struct lvts_data" also uses "struct platform_ops" as a member.
Do you have any suggestions on removing this forward declaration, if
it must be removed?

[...]

> > +struct lvts_tc_settings {
> > +     unsigned int dev_id;
> > +     unsigned int addr_offset;
> > +     unsigned int num_sensor;
> > +     unsigned int ts_offset;
> > +     unsigned int sensor_map[ALL_SENSING_POINTS];    /* In sensor ID *=
/
>
> Can you explain what is for the sensor_map?
>

A controller contains up to 4 sensors.
Example :
...
.sensor_map =3D {MT8195_TS1_0, MT8195_TS1_1},
...
.sensor_map =3D {MT8195_TS3_0, MT8195_TS3_1, MT8195_TS3_2, MT8195_TS3_3},

> > +     struct lvts_speed_settings *tc_speed;
> > +     /*
> > +      * HW filter setting
> > +      * 000: Get one sample
> > +      * 001: Get 2 samples and average them
> > +      * 010: Get 4 samples, drop max and min, then average the rest of=
 2 samples
> > +      * 011: Get 6 samples, drop max and min, then average the rest of=
 4 samples
> > +      * 100: Get 10 samples, drop max and min, then average the rest o=
f 8 samples
> > +      * 101: Get 18 samples, drop max and min, then average the rest o=
f 16 samples
> > +      */
> > +     unsigned int hw_filter;
>
> Isn't possible to specify a latency constraint instead of a hw_filter
> and deduce this one?
>

These are hardware pre-defined settings.

> > +     /*
> > +      * Dominator_sensing point is used to select a sensing point
> > +      * and reference its temperature to trigger Thermal HW Reboot
> > +      * When it is ALL_SENSING_POINTS, it will select all sensing poin=
ts
> > +      */
> > +     int dominator_sensing_point;
>
> replace int by the enum, hopefully 'clang' can detect enum mismatches
>
> > +     int hw_reboot_trip_point;               /* -274000: Disable HW re=
boot */
>
> It is not necessary to specify the hw_reboot_trip_point, it is all the
> same in the declaration.
>

Because new chips in the future may have different settings for
different modules,
in order to maintain flexibility, it is recommended to keep
hw_reboot_trip_point in the struct

> > +     unsigned int irq_bit;
> > +};

[...]

> > +
> > +struct lvts_data {
>
> IMO it would make sense to rename the lvts_data to lvts_thermal_domain
>
> > +     struct device *dev;
> > +     struct clk *clk;
> > +     void __iomem *base;                             /* LVTS base addr=
esses */
> > +     unsigned int irq_num;                   /* LVTS interrupt numbers=
 */
>
> The probe function can be reworked to get the irq and the pass it the
> register function. No need to store it in this structure.
>

Still working on it...
But, it will be good to give me a little help.

> > +     struct reset_control *reset;
> > +     int num_tc;                                             /* Number=
 of LVTS thermal controllers */
> > +     const struct lvts_tc_settings *tc;
> > +     int counting_window_us;                 /* LVTS device counting w=
indow */
> > +     int num_sensor;                                 /* Number of sens=
ors in this platform */
> > +     void __iomem **reg;
> > +     struct platform_ops ops;
> > +     int feature_bitmap;                             /* Show what feat=
ures are enabled */
> > +     unsigned int num_efuse_addr;
> > +     unsigned int *efuse;
> > +     unsigned int num_efuse_block;   /* Number of contiguous efuse ind=
exes */
> > +     struct lvts_sensor_cal_data cal_data;
>
> Everything related to the initialization must be somehow removed from
> this structure.
>

Still working on it...
But, it will be good to give me a little help.

> > +     struct lvts_formula_coeff coeff;
> > +};

[...]

Best regards,
Balsam
