Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B597E671F44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjAROTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjAROSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:18:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511609517F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:59:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v6so49664303edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+9UDLe8IGzJ0ltnHTHAlmb3jmqlL+bWfwS38VOWRDM=;
        b=1Yrklex0hWqxQshAdSOn5FBUHdEwe5v1D2VVJATCsyANedBsekxqZsOgSoIYgMhACk
         jpLi6Kar05vbbfU1QWTm0UaW3DUImpXi/9uulrVC/0iQp3+CEK0VYUbYmoqSkco8U3cH
         1j8GFC6sNuamhEeDfe6v1cDWebJyiUw3tbNDyRflXez3gmckCyB2he4VRTKB9zLNaKdj
         02DCTAi+4PrErw4GtXDNhGsbZIn78tsYhKe/VgiaCZaKGXXhVEahAAt+FrolRj7gBTqd
         9smDDDNk0+rxHLDzgxnPUiQX6taU1RDQhLKFp66Zpc4Hicx0ou4rCvu393+faw+ZspYw
         7L1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+9UDLe8IGzJ0ltnHTHAlmb3jmqlL+bWfwS38VOWRDM=;
        b=H1CWfYAs01VNKc8FFihw7ovcFDh2PCpqk0FSvi6/tP+baFEWhFkqhHRzHWO/CND3q0
         HcmpAoYPxhZLKTdRnDCuXJkbGMaVlw6bfpycfgnnLSROMRP3CklMJemP9KXWK3+9ftVy
         zx6WZZu7ymvCY9xq2h9nxWWr90GIMqorCSe/ii1OKt4Q9qUkMZnmr0sLD74BizZb4ghw
         IVetYpkDFAmZIJSgBPFnfCH3VXkmH2Q8TCJ+vj5qQD2xrOpzr6sVJVJL4e9U5GOL2Ipm
         ng16cmMK2jPmeHRaDP2mtHUo5x7WYZmQTsB7bKOjp64tIdGBQDgbe5GyHGFcfDZbddjn
         WNrw==
X-Gm-Message-State: AFqh2kqr2P/3i4HQOvVxYZbrRNYvHly+1m8+l2MXfuAJWF/L3jl946ZC
        GjQvU7Yd1sz2Q4w+W7HCEbJF5XcHovDshSBXSlxx7Kxx1RxYp5KI
X-Google-Smtp-Source: AMrXdXu/A6FHaef0aqsRpArgPbbmmheGUwPjIIOVBznoNlW1oFKmK0vB8k+GU6/w/NMXHLan+xdJmDueT7V+rkMZSaE=
X-Received: by 2002:a05:6402:1:b0:498:dfe5:49aa with SMTP id
 d1-20020a056402000100b00498dfe549aamr550020edu.398.1674050364722; Wed, 18 Jan
 2023 05:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20230112152855.216072-1-bchihi@baylibre.com> <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
In-Reply-To: <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 18 Jan 2023 14:58:46 +0100
Message-ID: <CAGuA+ooxTf-j957gQ1zRe2-+u2kphaaLGvTDi1=kit5Q3bKOxA@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
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

Hi Angelo,

On Mon, Jan 16, 2023 at 11:50 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
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
> > The interrupt is managed at the thermal controller level, so when an
> > interrupt occurs, the driver has to find out which sensor triggered
> > such an interrupt.
> >
> > The sampling of the thermal can be filtered or immediate. For the
> > former, the LVTS measures several points and applies a low pass
> > filter.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   drivers/thermal/mediatek/Kconfig            |   15 +
> >   drivers/thermal/mediatek/Makefile           |    1 +
> >   drivers/thermal/mediatek/lvts_thermal.c     | 1244 ++++++++++++++++++=
+
> >   include/dt-bindings/thermal/mediatek-lvts.h |   19 +
> >   4 files changed, 1279 insertions(+)
> >   create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
> >   create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
> >

..snip..

> > +
> > +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
> > +{
> > +     irqreturn_t iret =3D IRQ_NONE;
> > +     u32 value, masks[] =3D { 0x0009001F, 0X000881F0, 0x00247C00, 0x1F=
C00000 };
>
> Please, no magic numbers around.
>

These number are explained in the comment bellow.
This is part of it :
      * sensor 3 interrupt: 0001 1111 1100 0000 0000 0000 0000 0000
      *                  =3D> 0x1FC00000
      * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
      *                  =3D> 0x00247C00
      * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
      *                  =3D> 0X000881F0
      * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
      *                  =3D> 0x0009001F

> > +     int i;
> > +
> > +     /*
> > +      * Interrupt monitoring status
> > +      *
> > +      * LVTS_MONINTST
> > +      *
> > +      * Bits:
>
> You're describing the register with nice words, but there's another way t=
o do
> the same that will be even more effective.
>
> /*
>   * LVTS MONINT: Interrupt Monitoring register
>   * Each bit describes the enable status of per-sensor interrupts.
>   */
> #define LVTS_MONINT_THRES_COLD  BIT(0)  /* Cold threshold */
> #define LVTS_MONINT_THRES_HOT   BIT(1)  /* Hot threshold */
> #define LVTS_MONINT_OFFST_LOW   BIT(2)  /* Low offset */
> #define LVTS_MONINT_OFFST_HIGH  BIT(3)  /* High offset */
> #define LVTS_MONINT_OFFST_NTH   BIT(4)  /* Normal To Hot */
> #define EVERYTHING_ELSE ........................
>
> #define LVTS_MONINT_SNS0_MASK   GENMASK( ... )
> #define LVTS_MONINT_SNS1_MASK   GENMASK .....
>
> /* Find a better name for this one */
> #define LVTS_MONINT_EN_IRQS     ( LVTS_MONINT_THRES_COLD | LVTS_MONINT_TH=
RES_HOT |
>                                   LVTS_MONINT_OFFST_LOW ..... etc etc)
>

Given the complexity of the controller and the number of registers,
if we create a define per bits, we will end up with a huge list of
defines (~300).
I don't think that will help for the readability.

> > +      *
> > +      * 31 : Interrupt for stage 3
> > +      * 30 : Interrupt for stage 2
> > +      * 29 : Interrupt for state 1
> > +      * 28 : Interrupt using filter on sensor 3
> > +      *

..snip..

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
>
> Questions for you:
>
> 1. Are the masks always the same for all SoCs?

The LVTS controller is not SoC specific.
The mask is controller specific whatever the SoC version.

> 2. Do they correspond to what we set in lvts_irq_init()?

Not exactly, we set LVTS_MONINT and the controller sets the LVTS_MONINTSTS.
The content will be different with what we set and what we get.

>
> I'd expect future new SoCs to have different masks... and since lvts_irq_=
init() is
> actually "playing with" interrupts register(s), with one of them (LVTS_MO=
NINT)
> having the same layout as this one, I would place all of the initializati=
on in
> that function instead.
>
> This means that we'd initialize those masks at lvts_irq_init() time, in a=
 struct
> member, and read it back in this interrupt handler: like that, we get tha=
t a bit
> more ordered and generally more readable.
>

No. Actually, what will change is on which sensor a thermal zone is tie to,
and that is handled already by the device tree configuration.

> > +                     continue;
> > +
> > +             thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
> > +                                        THERMAL_TRIP_VIOLATED);
> > +             iret |=3D IRQ_HANDLED;
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
> > +     irqreturn_t iret =3D IRQ_NONE;
> > +     int i;
> > +
> > +     for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++)
> > +             iret |=3D lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
>
> Please do *not* OR your function calls! While this is surely fine here in
> this function and for this particular case, it's generally bad practice
> and shall be avoided.
>

I understand that could be prone to errors.
I can propose this alternative but it looks less elegant than OR'ing the re=
sult.
Do you have a suggestion to improve this code snippet?

> > +
> > +     return iret;
> > +}
> > +
> > +static struct thermal_zone_device_ops lvts_ops =3D {
> > +     .get_temp =3D lvts_get_temp,
> > +     .set_trips =3D lvts_set_trips,
> > +};
> > +
>
> ..snip..
>
> > +
> > +static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
> > +{
> > +     u32 value;
> > +
> > +     /*
> > +      * LVTS_PROTCTL : Thermal Protection Sensor Selection
> > +      *
> > +      * Bits:
> > +      *
> > +      * 19-18 : Sensor to base the protection on
> > +      * 17-16 : Strategy:
> > +      *         00 : Average of 4 sensors
> > +      *         01 : Max of 4 sensors
> > +      *         10 : Selected sensor with bits 19-18
> > +      *         11 : Reserved
> > +      */
> > +     value =3D BIT(16);
> > +     writel(value, LVTS_PROTCTL(lvts_ctrl->base));
> > +
> > +     /*
> > +      * LVTS_PROTTA : Stage 1 temperature threshold
> > +      * LVTS_PROTTB : Stage 2 temperature threshold
> > +      * LVTS_PROTTC : Stage 3 temperature threshold
> > +      *
> > +      * Bits:
> > +      *
> > +      * 14-0: Raw temperature threshold
> > +      *
> > +      * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
> > +      * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
> > +      */
> > +     writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base)=
);
> > +
> > +     /*
> > +      * LVTS_MONINT : Interrupt configuration register
> > +      *
> > +      * The LVTS_MONINT register layout is the same as the LVTS_MONINT=
STS
> > +      * register, except we set the bits to enable the interrupt.
> > +      */
> > +     value =3D 0x9FBF7BDE;
>
>         u32 val;
>
>         val =3D FIELD_PREP(LVTS_MONINT_SNS0_MASK, LVTS_MONINT_EN_IRQS);
>         val |=3D FIELD_PREP(LVTS_MONINT_SNS1_MASK, LVTS_MONINT_EN_IRQS);
>
>         ... etc
>
>         writel(val, ...... )
>

OK, I'll change it accordingly.

> > +     writel(value, LVTS_MONINT(lvts_ctrl->base));
> > +
> > +     return 0;
> > +}
> > +
>
> ..snip..
>
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
> ...what is this long list of commands?
>
> Why 0xC103_0000? Describe that please.
>

AFAIU, based on the documentation, the configuration register can be
read or write.
When we write it, we set the different bits corresponding to a write sequen=
ce
which is 0xC1030000.
The documentation gives the register layout but does not explain how it wor=
ks.

> Also, why is this not a platform data constant?
>

It is not a platform data, it is a controller data.
Whatever the SoC the configuration sequence will be the same.

> Example:
> struct lvts_plat {
>         const struct lvts_ctrl_data *ctrl_data;
>         u8 num_ctrl_data;
>         const u16 device_mask;
>         const u16 *init_cmds;
>         u8 num_init_cmds;
> }
>
> where device_mask gets set to 0xc103 and init_cmds is an array containing
> the low-16 (0x0e01, 0x0cfc, ...), and where this function would simply do
> something like
>
>         lvts_write_config(lvts_ctrl, plat->device_mask, init_cmds, num_in=
it_cmds);
>
> ... and where lvts_write_config() does something like:
>
>         for (i =3D 0; i < num_cmds; i++) {
>                 u32 val =3D device_mask | init_cmds[i];
>                 writel(val, LVTS_CONFIG ...)
>         }
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
>
> Can we constify this?
>

Constifying "void __iomem *lvts_edata[]" generates the following
compilation warning :
drivers/thermal/mediatek/lvts_thermal.c:835:47: warning: passing
argument 2 of =E2=80=98writel=E2=80=99 discards =E2=80=98const=E2=80=99 qua=
lifier from pointer target
type [-Wdiscarded-qualifiers]
  835 |   writel(lvts_ctrl->calibration[i], lvts_edata[i]);
      |                                     ~~~~~~~~~~^~~

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
> > +     u32 period_unit =3D (118 * 1000) / (256 * 38);
>
> #define SOMETHING       118
> #define SOMETHING_ELSE  1000
> #define ....
>
> const u32 period_unit =3D (SOMETHING * SOMETHING_ELSE) / ....
>

Constifying "u32 period_unit" generates the following compilation warning :
./include/asm-generic/io.h:273:61: note: expected =E2=80=98volatile void *=
=E2=80=99
but argument is of type =E2=80=98const void *=E2=80=99
  273 | static inline void writel(u32 value, volatile void __iomem *addr)
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~^~~~

> > +     u32 grp_interval =3D 1;
> > +     u32 flt_interval =3D 1;
> > +     u32 sensor_interval =3D 1;
> > +     u32 hw_filter =3D 0x2;
> > +     u32 value;
> > +
>
> ...snip...
>
> > +
> > +static struct lvts_ctrl_data mt819x_lvts_data_ctrl[] =3D {
>
> No wildcards. Please, rename this to give the name of the oldest SoC
> that uses these values. Assuming that it is MT8192.... mt8192_lvts_data_c=
trl[]
>

OK, it Will be mt8195_lvts_data_ctrl[].

> > +     {
> > +             .cal_offset =3D { 0x4, 0x7 },
> > +             .lvts_sensor =3D {
> > +                     { .dt_id =3D MT819x_MCU_BIG_CPU0 },
> > +                     { .dt_id =3D MT819x_MCU_BIG_CPU1 }
> > +             },
> > +             .num_lvts_sensor =3D 2,
> > +             .offset =3D 0x0,
> > +             .hw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT8195,
> > +     },
> > +

..snip..

> > +static struct lvts_data mt819x_lvts_mcu_data =3D {
>
> Same here.
>

OK, it Will be mt8195_lvts_mcu_data.

> > +     .lvts_ctrl      =3D mt819x_lvts_data_ctrl,
> > +     .num_lvts_ctrl  =3D ARRAY_SIZE(mt819x_lvts_data_ctrl),
> > +};
> > +
> > +static const struct of_device_id lvts_of_match[] =3D {
> > +     { .compatible =3D "mediatek,mt8195-lvts-mcu", .data =3D &mt819x_l=
vts_mcu_data },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, lvts_of_match);
> > +
> > +static struct platform_driver lvts_driver =3D {
> > +     .probe =3D lvts_probe,
> > +     .remove =3D lvts_remove,
> > +     .driver =3D {
> > +             .name =3D "mtk-lvts-thermal",
> > +             .of_match_table =3D lvts_of_match,
> > +     },
> > +};
> > +module_platform_driver(lvts_driver);
> > +
> > +MODULE_AUTHOR("Balsam CHIHI <bchihi@baylibre.com>");
> > +MODULE_DESCRIPTION("MediaTek LVTS Thermal Driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-b=
indings/thermal/mediatek-lvts.h
> > new file mode 100644
> > index 000000000000..80d060400236
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/mediatek-lvts.h
>
> Bindings go in a different commit: add this in your patch [2/6], where yo=
u are
> adding the yaml binding.
>

OK, it will be moved to :
[2/6] dt-bindings/thermal/mediatek: Add dt-binding document for LVTS
thermal controllers

> Also, please follow binding names: rename this file to mediatek,mt8192-lv=
ts.h.
>

LVTS is SoC independent (only available on MT8192 and MT8195).
Should not we leave this file name SoC indemendent too "mediatek-lvts.h",
just like "mediatek,lvts-thermal.yaml"?

> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (c) 2023 MediaTek Inc.
> > + * Author: Balsam CHIHI <bchihi@baylibre.com>
> > + */
> > +
> > +#ifndef __MEDIATEK_LVTS_DT_H
> > +#define __MEDIATEK_LVTS_DT_H
> > +
> > +#define MT819x_MCU_BIG_CPU0  0
>
> No wildcards: MT8192_MCU_BIG_CPU0
>

OK, it Will be MT8195_MCU_BIG_CPU0.

>
> > +#define MT819x_MCU_BIG_CPU1  1
> > +#define      MT819x_MCU_BIG_CPU2     2
> > +#define      MT819x_MCU_BIG_CPU3     3
> > +#define      MT819x_MCU_LITTLE_CPU0  4
> > +#define      MT819x_MCU_LITTLE_CPU1  5
> > +#define      MT819x_MCU_LITTLE_CPU2  6
> > +#define      MT819x_MCU_LITTLE_CPU3  7
> > +
> > +#endif /* __MEDIATEK_LVTS_DT_H */
>
> Regards,
> Angelo

Best regards,
Balsam
