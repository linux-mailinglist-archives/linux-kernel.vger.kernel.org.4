Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B9686C07
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBAQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBAQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:47:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802342BE1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:47:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so52742695ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WidhW0j9oyreNKjenVJf15/ln/O3WmZ+wYHNdhKbVPA=;
        b=VT+K+EGkwBPk97djXSTG+5+fpj8SjanC69I6f6L9WtA/dNxrFSg7dLODH101UMb4mY
         YZWIDQWqzAoqPsmRoQLMvSJMuTbJNUe7Eu00X9bLgfU5j+TeT9ezfbjcvOeZVdOjTzHx
         RodiobjGkAcTcEwSqcfy08ctYyPhdzvoX5rOD2GNEq9Jvtp+PwNj7FISbhV3HBHeoYm9
         T1WGAnz/oeD70L6RCKB5N1ZP5rpu46zAeUBD4OZ48aXbLiUCM0Lit8Rcdt5NhnYuusjX
         ppzRqRG0N9drbMT2yzCI3AR4oBOI+aqxPxA9Y9V2Ukqg3BNcOn59AKlONXVvNrjOViEA
         mhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WidhW0j9oyreNKjenVJf15/ln/O3WmZ+wYHNdhKbVPA=;
        b=jWDTph9Q8YTvR0dqDZiKBSyqtt71mjyB8r2sdlhfqUvLdZtx7h+Jx2iVqn6LckkULn
         1pU+CQSzcafVJjNWs4N1DRzlVNQV84yDSSX5lRYq19xsSA3uS98AyzOxS8oSg6OPDA02
         Sydpw1qa3AtjiI01M/gXdooK/mRFiYmLiOc6ehk3/t1OPejUJXi3FpysYqVdGGlXVqbd
         RGAiTZ6fUH4RcppGpj/dQMkSrw+hEr58cXO7KRJhEY1jKG271A40hyVQ+84bG6+bx83B
         qLx6jN1dMYrnQDiGT+MJZdC9XHG/pzrT6U8/VNTSl+nwfv5+afDxPw4OGhfSd/C+UmFx
         w4fQ==
X-Gm-Message-State: AO0yUKX/4gKCh3hIyb43IbVWg2SAkKuyOmWuH109ADf+oecAc9CW0Q/A
        cWfXs5vwqu5ZD5uIEPQaAvjOQ4SX0Y1l49EYMbeipg==
X-Google-Smtp-Source: AK7set9L1tV4zCtXyud6OUCOrw+Lw9IUU0Y0tCAw7GFssw+qutZsCReW0zljGCGCjkoiyZK3j01sMW9mab0yYFiqTP0=
X-Received: by 2002:a17:906:1803:b0:7c0:f45e:22ff with SMTP id
 v3-20020a170906180300b007c0f45e22ffmr1047488eje.104.1675270026975; Wed, 01
 Feb 2023 08:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-5-bchihi@baylibre.com> <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
In-Reply-To: <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 1 Feb 2023 17:46:30 +0100
Message-ID: <CAGuA+oqLiCxb1g7pwf+RwUTWHV37pXdAWUXHV51TnUy1-xUOXQ@mail.gmail.com>
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you very much for the review!

On Wed, Feb 1, 2023 at 8:55 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> > controllers contained in a thermal domain.
> >
> > A thermal domains can be the MCU or the AP.
> >
> > Each thermal domains contain up to seven controllers, each thermal
> > controller handle up to four thermal sensors.
> >
> > The LVTS has two Finite State Machines (FSM), one to handle the
> > functionin temperatures range like hot or cold temperature and another
> > one to handle monitoring trip point. The FSM notifies via interrupts
> > when a trip point is crossed.
> >
>
> (...)
>
> > +
> > +struct lvts_domain {
> > +     struct lvts_ctrl *lvts_ctrl;
> > +     struct reset_control *reset;
> > +     struct clk *clk;
> > +     int num_lvts_ctrl;
> > +     void __iomem *base;
> > +     size_t calib_len;
> > +     u8 *calib;
> > +};
> > +
> > +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
> > +
> > +static struct dentry *root;
>
> How do you handle two instances of driver?

This root node is the topmost directory for debugfs called 'lvts', the
different driver instances are below this. It is a singleton.

>
> > +
> > +#define LVTS_DEBUG_FS_REGS(__reg)            \
> > +{                                            \
> > +     .name =3D __stringify(__reg),             \
> > +     .offset =3D __reg(0),                     \
> > +}
> > +
>
> (...)
>
> > +
> > +static int lvts_set_trips(struct thermal_zone_device *tz, int low, int=
 high)
> > +{
> > +     struct lvts_sensor *lvts_sensor =3D tz->devdata;
> > +     void __iomem *base =3D lvts_sensor->base;
> > +     u32 raw_low =3D lvts_temp_to_raw(low);
> > +     u32 raw_high =3D lvts_temp_to_raw(high);
> > +
> > +     /*
> > +      * Hot to normal temperature threshold
> > +      *
> > +      * LVTS_H2NTHRE
> > +      *
> > +      * Bits:
> > +      *
> > +      * 14-0 : Raw temperature for threshold
> > +      */
> > +     if (low !=3D -INT_MAX) {
> > +             dev_dbg(&tz->device, "Setting low limit temperature inter=
rupt: %d\n", low);
> > +             writel(raw_low, LVTS_H2NTHRE(base));
> > +     }
> > +
> > +     /*
> > +      * Hot temperature threshold
> > +      *
> > +      * LVTS_HTHRE
> > +      *
> > +      * Bits:
> > +      *
> > +      * 14-0 : Raw temperature for threshold
> > +      */
> > +     dev_dbg(&tz->device, "Setting high limit temperature interrupt: %=
d\n", high);
> > +     writel(raw_high, LVTS_HTHRE(base));
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
> > +{
> > +     irqreturn_t iret =3D IRQ_NONE;
> > +     u32 value, masks[] =3D {
>
> Don't mix different types in one declaration. u32 and a pointer are
> quite different types.

I'm not sure to understand.
LVTS_INT_SENSORx are not pointers but register values.

>
> > +             LVTS_INT_SENSOR0,
> > +             LVTS_INT_SENSOR1,
> > +             LVTS_INT_SENSOR2,
> > +             LVTS_INT_SENSOR3
> > +     };
> > +     int i;
> > +
> > +     /*
> > +      * Interrupt monitoring status
> > +      *
> > +      * LVTS_MONINTST
> > +      *
> > +      * Bits:
> > +      *
> > +      * 31 : Interrupt for stage 3
> > +      * 30 : Interrupt for stage 2
> > +      * 29 : Interrupt for state 1
> > +      * 28 : Interrupt using filter on sensor 3
> > +      *
> > +      * 27 : Interrupt using immediate on sensor 3
> > +      * 26 : Interrupt normal to hot on sensor 3
> > +      * 25 : Interrupt high offset on sensor 3
> > +      * 24 : Interrupt low offset on sensor 3
> > +      *
> > +      * 23 : Interrupt hot threshold on sensor 3
> > +      * 22 : Interrupt cold threshold on sensor 3
> > +      * 21 : Interrupt using filter on sensor 2
> > +      * 20 : Interrupt using filter on sensor 1
> > +      *
> > +      * 19 : Interrupt using filter on sensor 0
> > +      * 18 : Interrupt using immediate on sensor 2
> > +      * 17 : Interrupt using immediate on sensor 1
> > +      * 16 : Interrupt using immediate on sensor 0
> > +      *
> > +      * 15 : Interrupt device access timeout interrupt
> > +      * 14 : Interrupt normal to hot on sensor 2
> > +      * 13 : Interrupt high offset interrupt on sensor 2
> > +      * 12 : Interrupt low offset interrupt on sensor 2
> > +      *
> > +      * 11 : Interrupt hot threshold on sensor 2
> > +      * 10 : Interrupt cold threshold on sensor 2
> > +      *  9 : Interrupt normal to hot on sensor 1
> > +      *  8 : Interrupt high offset interrupt on sensor 1
> > +      *
> > +      *  7 : Interrupt low offset interrupt on sensor 1
> > +      *  6 : Interrupt hot threshold on sensor 1
> > +      *  5 : Interrupt cold threshold on sensor 1
> > +      *  4 : Interrupt normal to hot on sensor 0
> > +      *
> > +      *  3 : Interrupt high offset interrupt on sensor 0
> > +      *  2 : Interrupt low offset interrupt on sensor 0
> > +      *  1 : Interrupt hot threshold on sensor 0
> > +      *  0 : Interrupt cold threshold on sensor 0
> > +      *
> > +      * We are interested in the sensor(s) responsible of the
> > +      * interrupt event. We update the thermal framework with the
> > +      * thermal zone associated with the sensor. The framework will
> > +      * take care of the rest whatever the kind of interrupt, we
> > +      * are only interested in which sensor raised the interrupt.
> > +      *
> > +      * sensor 3 interrupt: 0001 1111 1100 0000 0000 0000 0000 0000
> > +      *                  =3D> 0x1FC00000
> > +      * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
> > +      *                  =3D> 0x00247C00
> > +      * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
> > +      *                  =3D> 0X000881F0
> > +      * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
> > +      *                  =3D> 0x0009001F
> > +      */
> > +     value =3D readl(LVTS_MONINTSTS(lvts_ctrl->base));
> > +
> > +     /*
> > +      * Let's figure out which sensors raised the interrupt
> > +      *
> > +      * NOTE: the masks array must be ordered with the index
> > +      * corresponding to the sensor id eg. index=3D0, mask for
> > +      * sensor0.
> > +      */
> > +     for (i =3D 0; i < ARRAY_SIZE(masks); i++) {
> > +
> > +             if (!(value & masks[i]))
> > +                     continue;
> > +
> > +             thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
> > +                                        THERMAL_TRIP_VIOLATED);
> > +             iret =3D IRQ_HANDLED;
> > +     }
> > +
> > +     /*
> > +      * Write back to clear the interrupt status (W1C)
> > +      */
> > +     writel(value, LVTS_MONINTSTS(lvts_ctrl->base));
> > +
> > +     return iret;
> > +}
> > +
> > +/*
> > + * Temperature interrupt handler. Even if the driver supports more
> > + * interrupt modes, we use the interrupt when the temperature crosses
> > + * the hot threshold the way up and the way down (modulo the
> > + * hysteresis).
> > + *
> > + * Each thermal domain has a couple of interrupts, one for hardware
> > + * reset and another one for all the thermal events happening on the
> > + * different sensors.
> > + *
> > + * The interrupt is configured for thermal events when crossing the
> > + * hot temperature limit. At each interrupt, we check in every
> > + * controller if there is an interrupt pending.
> > + */
> > +static irqreturn_t lvts_irq_handler(int irq, void *data)
> > +{
> > +     struct lvts_domain *lvts_td =3D data;
> > +     irqreturn_t aux, iret =3D IRQ_NONE;
> > +     int i;
> > +
> > +     for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
> > +
> > +             aux =3D lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
> > +             if (aux !=3D IRQ_HANDLED)
> > +                     continue;
> > +
> > +             iret =3D IRQ_HANDLED;
> > +     }
> > +
> > +     return iret;
> > +}
> > +
> > +static struct thermal_zone_device_ops lvts_ops =3D {
> > +     .get_temp =3D lvts_get_temp,
> > +     .set_trips =3D lvts_set_trips,
> > +};
> > +
> > +static int __init lvts_sensor_init(struct device *dev,
> > +                                struct lvts_ctrl *lvts_ctrl,
> > +                                struct lvts_ctrl_data *lvts_ctrl_data)
> > +{
> > +     struct lvts_sensor *lvts_sensor =3D lvts_ctrl->sensors;
> > +     void __iomem *msr_regs[] =3D {
> > +             LVTS_MSR0(lvts_ctrl->base),
> > +             LVTS_MSR1(lvts_ctrl->base),
> > +             LVTS_MSR2(lvts_ctrl->base),
> > +             LVTS_MSR3(lvts_ctrl->base)
> > +     };
> > +
> > +     void __iomem *imm_regs[] =3D {
> > +             LVTS_IMMD0(lvts_ctrl->base),
> > +             LVTS_IMMD1(lvts_ctrl->base),
> > +             LVTS_IMMD2(lvts_ctrl->base),
> > +             LVTS_IMMD3(lvts_ctrl->base)
> > +     };
> > +
> > +     int i;
> > +
> > +     for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
> > +
> > +             int dt_id =3D lvts_ctrl_data->lvts_sensor[i].dt_id;
> > +
> > +             /*
> > +              * At this point, we don't know which id matches which
> > +              * sensor. Let's set arbitrally the id from the index.
> > +              */
> > +             lvts_sensor[i].id =3D i;
> > +
> > +             /*
> > +              * The thermal zone registration will set the trip
> > +              * point interrupt in the thermal controller
> > +              * register. But this one will be reset in the
> > +              * initialization after. So we need to post pone the
> > +              * thermal zone creation after the controller is
> > +              * setup. For this reason, we store the device tree
> > +              * node id from the data in the sensor structure
> > +              */
> > +             lvts_sensor[i].dt_id =3D dt_id;
> > +
> > +             /*
> > +              * We assign the base address of the thermal
> > +              * controller as a back pointer. So it will be
> > +              * accessible from the different thermal framework ops
> > +              * as we pass the lvts_sensor pointer as thermal zone
> > +              * private data.
> > +              */
> > +             lvts_sensor[i].base =3D lvts_ctrl->base;
> > +
> > +             /*
> > +              * Each sensor has its own register address to read from.
> > +              */
> > +             lvts_sensor[i].msr =3D lvts_ctrl_data->mode =3D=3D LVTS_M=
SR_IMMEDIATE_MODE ?
> > +                     imm_regs[i] : msr_regs[i];
> > +     };
> > +
> > +     lvts_ctrl->num_lvts_sensor =3D lvts_ctrl_data->num_lvts_sensor;
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * The efuse blob values follows the sensor enumeration per thermal
> > + * controller. The decoding of the stream is as follow:
> > + *
> > + *                        <--?-> <----big0 ???---> <-sensor0-> <-0->
> > + *                        ------------------------------------------
> > + * index in the stream: : | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 |
> > + *                        ------------------------------------------
> > + *
> > + *                        <--sensor1--><-0-> <----big1 ???---> <-sen
> > + *                        ------------------------------------------
> > + *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
> > + *                        ------------------------------------------
> > + *
> > + *                        sor0-> <-0-> <-sensor1-> <-0-> ..........
> > + *                        ------------------------------------------
> > + *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
> > + *                        ------------------------------------------
> > + *
> > + * And so on ...
> > + *
> > + * The data description gives the offset of the calibration data in
> > + * this bytes stream for each sensor.
> > + *
> > + * Each thermal controller can handle up to 4 sensors max, we don't
> > + * care if there are less as the array of calibration is sized to 4
> > + * anyway. The unused sensor slot will be zeroed.
> > + */
> > +static int __init lvts_calibration_init(struct device *dev,
> > +                                     struct lvts_ctrl *lvts_ctrl,
> > +                                     struct lvts_ctrl_data *lvts_ctrl_=
data,
> > +                                     u8 *efuse_calibration)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
> > +             memcpy(&lvts_ctrl->calibration[i],
> > +                    efuse_calibration + lvts_ctrl_data->cal_offset[i],=
 2);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * The efuse bytes stream can be split into different chunk of
> > + * nvmems. This function reads and concatenate those into a single
> > + * buffer so it can be read sequentially when initializing the
> > + * calibration data.
> > + */
> > +static int lvts_calibration_read(struct device *dev, struct lvts_domai=
n *lvts_td,
> > +                              struct lvts_data *lvts_data)
> > +{
> > +     struct device_node *np =3D dev_of_node(dev);
> > +     struct nvmem_cell *cell;
> > +     struct property *prop;
> > +     const char *cell_name;
> > +
> > +     of_property_for_each_string(np, "nvmem-cell-names", prop, cell_na=
me) {
> > +             size_t len;
> > +             u8 *efuse;
> > +
> > +             cell =3D of_nvmem_cell_get(np, cell_name);
> > +             if (IS_ERR(cell)) {
> > +                     dev_dbg(dev, "Failed to get cell '%s'\n", cell_na=
me);
>
> Is this an error? If so, why debug? dbg is not for errors.

AFAIK using dev_dbg does not increase ELF size when DEBUG is disabled.
If this is not a good reason for you, then I will change it to dev_err.

>
> > +                     return PTR_ERR(cell);
> > +             }
> > +
> > +             efuse =3D nvmem_cell_read(cell, &len);
> > +
> > +             nvmem_cell_put(cell);
> > +
> > +             if (IS_ERR(efuse)) {
> > +                     dev_dbg(dev, "Failed to read cell '%s'\n", cell_n=
ame);
> > +                     return PTR_ERR(efuse);
> > +             }
> > +
> > +             lvts_td->calib =3D devm_krealloc(dev, lvts_td->calib,
> > +                                            lvts_td->calib_len + len, =
GFP_KERNEL);
> > +             if (!lvts_td->calib)
> > +                     return -ENOMEM;
> > +
> > +             memcpy(lvts_td->calib + lvts_td->calib_len, efuse, len);
> > +
> > +             lvts_td->calib_len +=3D len;
> > +
> > +             kfree(efuse);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init lvts_golden_temp_init(struct device *dev, u32 *value=
)
>
> You did not test it, right? Build with section mismatch analysis...

I'm not sure to fully understand this comment.
Would you explain, please?

>
> > +{
> > +     u32 gt;
> > +
> > +     gt =3D (*value) >> 24;
> > +
> > +     if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
> > +             golden_temp =3D gt;
> > +
> > +     coeff_b =3D golden_temp * 500 + LVTS_COEFF_B;
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init lvts_ctrl_init(struct device *dev,
>
> Same problem.

Would you explain, please?

>
> > +                              struct lvts_domain *lvts_td,
> > +                              struct lvts_data *lvts_data)
> > +{
> > +     size_t size =3D sizeof(*lvts_td->lvts_ctrl) * lvts_data->num_lvts=
_ctrl;
> > +     struct lvts_ctrl *lvts_ctrl;
> > +     int i, ret;
> > +
>
> > +
> > +static inline int lvts_ctrl_enable(struct device *dev, struct lvts_ctr=
l *lvts_ctrl)
> > +{
> > +     return lvts_ctrl_set_enable(lvts_ctrl, 1);
>
> Drop the wrapper, it's useless. true or false for enable are quite obviou=
s.

OK.

>
> > +}
> > +
> > +static inline int lvts_ctrl_disable(struct device *dev, struct lvts_ct=
rl *lvts_ctrl)
> > +{
> > +     return lvts_ctrl_set_enable(lvts_ctrl, 0);
>
> Drop the wrapper.

OK.

>
> > +}
> > +
> > +static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvt=
s_ctrl)
> > +{
> > +     u32 id, cmds[] =3D { 0xC103FFFF, 0xC502FF55 };
> > +
> > +     lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
> > +
> > +     /*
> > +      * LVTS_ID : Get ID and status of the thermal controller
> > +      *
> > +      * Bits:
> > +      *
> > +      * 0-5  : thermal controller id
> > +      *   7  : thermal controller connection is valid
> > +      */
> > +     id =3D readl(LVTS_ID(lvts_ctrl->base));
> > +     if (!(id & BIT(7)))
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *=
lvts_ctrl)
> > +{
> > +     /*
> > +      * Write device mask: 0xC1030000
> > +      */
> > +     u32 cmds[] =3D {
> > +             0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F=
1,
> > +             0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC103030=
0,
> > +             0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300A=
C,
> > +             0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
> > +     };
> > +
> > +     lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
> > +
> > +     return 0;
> > +}
> > +
> > +static int lvts_ctrl_calibrate(struct device *dev, struct lvts_ctrl *l=
vts_ctrl)
> > +{
> > +     int i;
> > +     void __iomem *lvts_edata[] =3D {
> > +             LVTS_EDATA00(lvts_ctrl->base),
> > +             LVTS_EDATA01(lvts_ctrl->base),
> > +             LVTS_EDATA02(lvts_ctrl->base),
> > +             LVTS_EDATA03(lvts_ctrl->base)
> > +     };
> > +
> > +     /*
> > +      * LVTS_EDATA0X : Efuse calibration reference value for sensor X
> > +      *
> > +      * Bits:
> > +      *
> > +      * 20-0 : Efuse value for normalization data
> > +      */
> > +     for (i =3D 0; i < LVTS_SENSOR_MAX; i++)
> > +             writel(lvts_ctrl->calibration[i], lvts_edata[i]);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *l=
vts_ctrl)
> > +{
> > +     u32 value;
> > +
> > +     /*
> > +      * LVTS_TSSEL : Sensing point index numbering
> > +      *
> > +      * Bits:
> > +      *
> > +      * 31-24: ADC Sense 3
> > +      * 23-16: ADC Sense 2
> > +      * 15-8 : ADC Sense 1
> > +      * 7-0  : ADC Sense 0
> > +      */
> > +     value =3D LVTS_TSSEL_CONF;
> > +     writel(value, LVTS_TSSEL(lvts_ctrl->base));
> > +
> > +     /*
> > +      * LVTS_CALSCALE : ADC voltage round
> > +      */
> > +     value =3D 0x300;
> > +     value =3D LVTS_CALSCALE_CONF;
> > +
> > +     /*
> > +      * LVTS_MSRCTL0 : Sensor filtering strategy
> > +      *
> > +      * Filters:
> > +      *
> > +      * 000 : One sample
> > +      * 001 : Avg 2 samples
> > +      * 010 : 4 samples, drop min and max, avg 2 samples
> > +      * 011 : 6 samples, drop min and max, avg 4 samples
> > +      * 100 : 10 samples, drop min and max, avg 8 samples
> > +      * 101 : 18 samples, drop min and max, avg 16 samples
> > +      *
> > +      * Bits:
> > +      *
> > +      * 0-2  : Sensor0 filter
> > +      * 3-5  : Sensor1 filter
> > +      * 6-8  : Sensor2 filter
> > +      * 9-11 : Sensor3 filter
> > +      */
> > +     value =3D LVTS_HW_FILTER << 9 |  LVTS_HW_FILTER << 6 |
> > +                     LVTS_HW_FILTER << 3 | LVTS_HW_FILTER;
> > +     writel(value, LVTS_MSRCTL0(lvts_ctrl->base));
> > +
> > +     /*
> > +      * LVTS_MSRCTL1 : Measurement control
> > +      *
> > +      * Bits:
> > +      *
> > +      * 9: Ignore MSRCTL0 config and do immediate measurement on senso=
r3
> > +      * 6: Ignore MSRCTL0 config and do immediate measurement on senso=
r2
> > +      * 5: Ignore MSRCTL0 config and do immediate measurement on senso=
r1
> > +      * 4: Ignore MSRCTL0 config and do immediate measurement on senso=
r0
> > +      *
> > +      * That configuration will ignore the filtering and the delays
> > +      * introduced below in MONCTL1 and MONCTL2
> > +      */
> > +     if (lvts_ctrl->mode =3D=3D LVTS_MSR_IMMEDIATE_MODE) {
> > +             value =3D BIT(9) | BIT(6) | BIT(5) | BIT(4);
> > +             writel(value, LVTS_MSRCTL1(lvts_ctrl->base));
> > +     }
> > +
> > +     /*
> > +      * LVTS_MONCTL1 : Period unit and group interval configuration
> > +      *
> > +      * The clock source of LVTS thermal controller is 26MHz.
> > +      *
> > +      * The period unit is a time base for all the interval delays
> > +      * specified in the registers. By default we use 12. The time
> > +      * conversion is done by multiplying by 256 and 1/26.10^6
> > +      *
> > +      * An interval delay multiplied by the period unit gives the
> > +      * duration in seconds.
> > +      *
> > +      * - Filter interval delay is a delay between two samples of
> > +      * the same sensor.
> > +      *
> > +      * - Sensor interval delay is a delay between two samples of
> > +      * different sensors.
> > +      *
> > +      * - Group interval delay is a delay between different rounds.
> > +      *
> > +      * For example:
> > +      *     If Period unit =3D C, filter delay =3D 1, sensor delay =3D=
 2, group delay =3D 1,
> > +      *     and two sensors, TS1 and TS2, are in a LVTS thermal contro=
ller
> > +      *     and then
> > +      *     Period unit time =3D C * 1/26M * 256 =3D 12 * 38.46ns * 25=
6 =3D 118.149us
> > +      *     Filter interval delay =3D 1 * Period unit =3D 118.149us
> > +      *     Sensor interval delay =3D 2 * Period unit =3D 236.298us
> > +      *     Group interval delay =3D 1 * Period unit =3D 118.149us
> > +      *
> > +      *     TS1    TS1 ... TS1    TS2    TS2 ... TS2    TS1...
> > +      *        <--> Filter interval delay
> > +      *                       <--> Sensor interval delay
> > +      *                                             <--> Group interva=
l delay
> > +      * Bits:
> > +      *      29 - 20 : Group interval
> > +      *      16 - 13 : Send a single interrupt when crossing the hot t=
hreshold (1)
> > +      *                or an interrupt everytime the hot threshold is =
crossed (0)
> > +      *       9 - 0  : Period unit
> > +      *
> > +      */
> > +     value =3D LVTS_GROUP_INTERVAL << 20 | LVTS_PERIOD_UNIT;
> > +     writel(value, LVTS_MONCTL1(lvts_ctrl->base));
> > +
> > +     /*
> > +      * LVTS_MONCTL2 : Filtering and sensor interval
> > +      *
> > +      * Bits:
> > +      *
> > +      *      25-16 : Interval unit in PERIOD_UNIT between sample on
> > +      *              the same sensor, filter interval
> > +      *       9-0  : Interval unit in PERIOD_UNIT between each sensor
> > +      *
> > +      */
> > +     value =3D LVTS_FILTER_INTERVAL << 16 | LVTS_SENSOR_INTERVAL;
> > +     writel(value, LVTS_MONCTL2(lvts_ctrl->base));
> > +
> > +     return lvts_irq_init(lvts_ctrl);
> > +}
> > +
> > +static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_=
ctrl)
> > +{
> > +     struct lvts_sensor *lvts_sensors =3D lvts_ctrl->sensors;
> > +     struct thermal_zone_device *tz;
> > +     u32 sensor_map =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < lvts_ctrl->num_lvts_sensor; i++) {
> > +
> > +             int dt_id =3D lvts_sensors[i].dt_id;
> > +
> > +             tz =3D devm_thermal_of_zone_register(dev, dt_id, &lvts_se=
nsors[i],
> > +                                                &lvts_ops);
> > +             if (IS_ERR(tz)) {
> > +                     /*
> > +                      * This thermal zone is not described in the
> > +                      * device tree. It is not an error from the
> > +                      * thermal OF code POV, we just continue.
> > +                      */
> > +                     if (PTR_ERR(tz) =3D=3D -ENODEV)
> > +                             continue;
> > +
> > +                     return PTR_ERR(tz);
> > +             }
> > +
> > +             /*
> > +              * The thermal zone pointer will be needed in the
> > +              * interrupt handler, we store it in the sensor
> > +              * structure. The thermal domain structure will be
> > +              * passed to the interrupt handler private data as the
> > +              * interrupt is shared for all the controller
> > +              * belonging to the thermal domain.
> > +              */
> > +             lvts_sensors[i].tz =3D tz;
> > +
> > +             /*
> > +              * This sensor was correctly associated with a thermal
> > +              * zone, let's set the corresponding bit in the sensor
> > +              * map, so we can enable the temperature monitoring in
> > +              * the hardware thermal controller.
> > +              */
> > +             sensor_map |=3D BIT(i);
> > +     }
> > +
> > +     /*
> > +      * Bits:
> > +      *      9: Single point access flow
> > +      *    0-3: Enable sensing point 0-3
> > +      *
> > +      * The initialization of the thermal zones give us
> > +      * which sensor point to enable. If any thermal zone
> > +      * was not described in the device tree, it won't be
> > +      * enabled here in the sensor map.
> > +      */
> > +     writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
> > +
> > +     return 0;
> > +}
> > +
> > +static int lvts_domain_init(struct device *dev, struct lvts_domain *lv=
ts_td,
> > +                         struct lvts_data *lvts_data)
> > +{
> > +     struct lvts_ctrl *lvts_ctrl;
> > +     int i, ret;
> > +
> > +     ret =3D lvts_ctrl_init(dev, lvts_td, lvts_data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D lvts_domain_reset(dev, lvts_td->reset);
> > +     if (ret) {
> > +             dev_dbg(dev, "Failed to reset domain");
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
> > +
> > +             lvts_ctrl =3D &lvts_td->lvts_ctrl[i];
> > +
> > +             /*
> > +              * Initialization steps:
> > +              *
> > +              * - Enable the clock
> > +              * - Connect to the LVTS
> > +              * - Initialize the LVTS
> > +              * - Prepare the calibration data
> > +              * - Select monitored sensors
> > +              * [ Configure sampling ]
> > +              * [ Configure the interrupt ]
> > +              * - Start measurement
> > +              */
> > +             ret =3D lvts_ctrl_enable(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to enable LVTS clock");
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D lvts_ctrl_connect(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to connect to LVTS controlle=
r");
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D lvts_ctrl_initialize(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to initialize controller");
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D lvts_ctrl_calibrate(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to calibrate controller");
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D lvts_ctrl_configure(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to configure controller");
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D lvts_ctrl_start(dev, lvts_ctrl);
> > +             if (ret) {
> > +                     dev_dbg(dev, "Failed to start controller");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return lvts_debugfs_init(dev, lvts_td);
> > +}
> > +
> > +static int lvts_probe(struct platform_device *pdev)
> > +{
> > +     struct lvts_data *lvts_data;
> > +     struct lvts_domain *lvts_td;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct resource *res;
> > +     int irq, ret;
> > +
> > +     lvts_td =3D devm_kzalloc(dev, sizeof(*lvts_td), GFP_KERNEL);
> > +     if (!lvts_td)
> > +             return -ENOMEM;
> > +
> > +     lvts_data =3D (struct lvts_data *)of_device_get_match_data(dev);
>
> Why do you need case?

Would you explain, please?

>
> > +     if (!lvts_data) {
> > +             dev_dbg(dev, "No platforme
>
> Drop. How is it even possible?

OK,
All "dev_dbg" in "probe" function will be replaced by "dev_err_probe"

>
> > +             return -ENODATA;
> > +     };
> > +
> > +     lvts_td->clk =3D devm_clk_get_enabled(dev, NULL);
> > +     if (IS_ERR(lvts_td->clk)) {
> > +             dev_dbg(dev, "Failed to retrieve clock\n");
>
> Drop all debug statements. Either this is an error (so return
> dev_err_probe) or core handles messages.

I will change it to dev_err_probe.

>
> > +             return PTR_ERR(lvts_td->clk);
> > +     }
> > +
> > +     res =3D platform_get_mem_or_io(pdev, 0);
> > +     if (!res) {
> > +             dev_dbg(dev, "No IO resource\n");
>
> Ditto
>
> > +             return -ENXIO;
> > +     }
> > +
> > +     lvts_td->base =3D devm_ioremap_resource(dev, res);
>
> Why not using single wrapper for this?

OK,
I will chnagne it to "lvts_td->base =3D
devm_platform_get_and_ioremap_resource(pdev, 0, &res);"

>
> > +     if (IS_ERR(lvts_td->base)) {
> > +             dev_dbg(dev, "Failed to map io resource\n");
>
> Ditto

I will change it to dev_err_probe.

>
> > +             return PTR_ERR(lvts_td->base);
> > +     }
> > +
> > +     lvts_td->reset =3D devm_reset_control_get_by_index(dev, 0);
> > +     if (IS_ERR(lvts_td->reset)) {
> > +             dev_dbg(dev, "Failed to get reset control\n");
>
> Ditto

I will change it to dev_err_probe.

>
> > +             return PTR_ERR(lvts_td->reset);
> > +     }
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_dbg(dev, "No irq resource\n");
>
> Ditto

I will change it to dev_err_probe.

>
> > +             return irq;
> > +     }
> > +
> > +     ret =3D lvts_domain_init(dev, lvts_td, lvts_data);
> > +     if (ret) {
> > +             dev_dbg(dev, "Failed to initialize the lvts domain\n");
>
> Why this is debug?

I will change it to dev_err_probe.

>
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * At this point the LVTS is initialized and enabled. We can
> > +      * safely enable the interrupt.
> > +      */
> > +     ret =3D devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handle=
r,
> > +                                     IRQF_ONESHOT, dev_name(dev), lvts=
_td);
> > +     if (ret) {
> > +             dev_dbg(dev, "Failed to request interrupt\n");
>
> Ditto

I will change it to dev_err_probe.

>
> > +             return ret;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, lvts_td);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lvts_remove(struct platform_device *pdev)
> > +{
> > +     struct lvts_domain *lvts_td;
> > +     struct device *dev =3D &pdev->dev;
> > +     int i;
> > +
> > +     lvts_td =3D platform_get_drvdata(pdev);
> > +
> > +     for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> > +             lvts_ctrl_disable(dev, &lvts_td->lvts_ctrl[i]);
> > +
> > +     lvts_debugfs_exit();
> > +
> > +     return 0;
> > +}
> > +
> > +static struct lvts_ctrl_data mt8195_lvts_data_ctrl[] =3D {
>
> Why this cannot be const?

I've got the following warning when I added "const"
drivers/thermal/mediatek/lvts_thermal.c:1286:27: warning:
initialization discards =E2=80=98const=E2=80=99 qualifier from pointer targ=
et type
[-Wdiscarded-qualifiers]
 1286 |         .lvts_ctrl      =3D mt8195_lvts_data_ctrl,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
Still working on it.
Any suggestion will be helpful, thanks!

>
> > +     {
> > +             .cal_offset =3D { 0x4, 0x7 },
> > +             .lvts_sensor =3D {
> > +                     { .dt_id =3D MT8195_MCU_BIG_CPU0 },
> > +                     { .dt_id =3D MT8195_MCU_BIG_CPU1 }
> > +             },
> > +             .num_lvts_sensor =3D 2,
> > +             .offset =3D 0x0,
> > +             .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
> > +     },
> > +
>
> Drop blank line

OK,
I will do the same for other blank lines.

>
> > +     {
>
> Best regards,
> Krzysztof
>

Best regards,
Balsam.
