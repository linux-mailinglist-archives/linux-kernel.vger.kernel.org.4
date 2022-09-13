Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F055B65FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIMDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIMDIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:08:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E854F699;
        Mon, 12 Sep 2022 20:08:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so8611262wms.5;
        Mon, 12 Sep 2022 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=I/LkABNzUkU5E30bnzpqmJY49/YZxhzC6X0tA1kqLyY=;
        b=jcgVYcsb+xaUs7vMVDn8c2UAFhupsxGnhWV/Wa0rWLmrrSTluIPH4ljriLDkbb4Pcg
         qwzWl1a9VBm2p/y2jP8JdZ5CfqXScRC0FtV162maHVeT8DqALpc8s3zcKMz1LZAZOvri
         5SrMRyKpo83BQkP2JZHVj9xEBou5GCaH3689GQlCZQt1WJhRT3/MsBFwmOh5qBcOfSY9
         r38vDGhw8jC+HVMXkgZ2cK+ESQqo+ZqLQI/RnUWSHGLv8RBOOoFyDd8IDL1YOl0xIf+T
         YM0UTNfY3U1VD0NuUakd6rxmREC0Z4uEgHeDF+ChA3OJvJnVVzWAXHtM/LpWJuGVMAEK
         X41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I/LkABNzUkU5E30bnzpqmJY49/YZxhzC6X0tA1kqLyY=;
        b=GwHR5ahgeyZC5gIGaAC951sO8ZF6qdljqNcJzWgM02QazEw3UmR4hBNH1JXYrmBlyM
         pRrPuqgSz1K888OK1aAfAJ3Dr5kX0kHp7HikUufEdm/mK3lp9/4YR51ue/ksoO0kzENG
         qktiEnoiPjJINWeY8vtmq7t43vxnGiHzcQnVopRyawDZG++KjYDu6Pqj9n/4NCM76daY
         O4rJTBELtwoDzIcl1c6+g/gf6AnfW+RCHoK0Kj39Aey71IyQ44O/hn8oQLPJH2reIG2e
         t9HcQrAVWZ8iZ62PhNYj9v421ut6TpuSlqGVHPvaeJNXXmLpx8IeDn8lP4C3M+ZyHf28
         D7hQ==
X-Gm-Message-State: ACgBeo1wgeJhM5+9drcBgS9/cwxE6Pda+HczVvSX08hZxsmsd9kF32zq
        tdY1b0GAP8CQSyoQcIx+9UFoMn+j388nw5fj+GM=
X-Google-Smtp-Source: AA6agR6m7vXGYPUDFZXVAbz+1FFnSwvWKUWhXKBWUYIDXCsYNAB+kHmLVEj8rG1CprTsNkNYA42b0bY/ID1ikT4UKfA=
X-Received: by 2002:a05:600c:3482:b0:3a6:e09:1ebf with SMTP id
 a2-20020a05600c348200b003a60e091ebfmr736530wmq.173.1663038513740; Mon, 12 Sep
 2022 20:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <1661742391-11378-1-git-send-email-u0084500@gmail.com>
 <1661742391-11378-3-git-send-email-u0084500@gmail.com> <20220912112652.5zz2bscbtcpiwrjd@mercury.elektranox.org>
In-Reply-To: <20220912112652.5zz2bscbtcpiwrjd@mercury.elektranox.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 13 Sep 2022 11:08:22 +0800
Message-ID: <CADiBU3-uCLCDQ_2MvTPgJaLH7jeXJCwJc3AWF4JL1oFGXXpjsg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] power: supply: rt9471: Add Richtek RT9471 charger driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2022=E5=B9=B4=
9=E6=9C=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A7:26=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Mon, Aug 29, 2022 at 11:06:30AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add support for the RT9471 3A 1-Cell Li+ battery charger.
> >
> > The RT9471 is a highly-integrated 3A switch mode battery charger with
> > low impedance power path to better optimize the charging efficiency.
> >
> > Co-developed-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v4:
> > - Remove the line for the owner field in driver.
> >
> > Since v2:
> > - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to=
_chip function.
> > - Specify the member name directly for the use of linear range.
> >
> > ---
>
> Thanks, driver looks mostly good.
>
> >  drivers/power/supply/Kconfig  |  16 +
> >  drivers/power/supply/Makefile |   1 +
> >  drivers/power/supply/rt9471.c | 952 ++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/power/supply/rt9471.h |  76 ++++
> >  4 files changed, 1045 insertions(+)
> >  create mode 100644 drivers/power/supply/rt9471.c
> >  create mode 100644 drivers/power/supply/rt9471.h
> >
> > [...]
> > +static inline int rt9471_set_hiz(struct rt9471_chip *chip, int enable)
> > +{
> > +     return regmap_field_write(chip->rm_fields[F_HZ], enable);
> > +}
> > +
> > +static inline int rt9471_set_ichg(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_ICHG_REG,
> > +                                            RT9471_RANGE_ICHG, microam=
p);
> > +}
> > +
> > +static inline int rt9471_get_ichg(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_ICHG_REG,
> > +                                            RT9471_RANGE_ICHG, microam=
p);
> > +}
> > +
> > +static inline int rt9471_set_cv(struct rt9471_chip *chip, int microvol=
t)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_VBAT_REG,
> > +                                            RT9471_RANGE_VCHG, microvo=
lt);
> > +}
> > +
> > +static inline int rt9471_get_cv(struct rt9471_chip *chip, int *microam=
p)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_VBAT_REG,
> > +                                            RT9471_RANGE_VCHG, microam=
p);
> > +}
> > +
> > +static inline int rt9471_set_mivr(struct rt9471_chip *chip, int microv=
olt)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_MIVR,
> > +                                            RT9471_RANGE_MIVR, microvo=
lt);
> > +}
> > +
> > +static inline int rt9471_get_mivr(struct rt9471_chip *chip, int *micro=
volt)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_MIVR,
> > +                                            RT9471_RANGE_MIVR, microvo=
lt);
> > +}
> > +
> > +static inline int rt9471_set_aicr(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_AICR, RT9471_RANGE=
_AICR,
> > +                                            microamp);
> > +}
> > +
> > +static inline int rt9471_get_aicr(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_AICR, RT9471_RANGE=
_AICR,
> > +                                            microamp);
> > +}
> > +
> > +static inline int rt9471_set_iprechg(struct rt9471_chip *chip, int mic=
roamp)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_IPRE_CHG,
> > +                                            RT9471_RANGE_IPRE, microam=
p);
> > +}
> > +
> > +static inline int rt9471_get_iprechg(struct rt9471_chip *chip, int *mi=
croamp)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_IPRE_CHG,
> > +                                            RT9471_RANGE_IPRE, microam=
p);
> > +}
> > +
> > +static inline int rt9471_set_ieoc(struct rt9471_chip *chip, int microa=
mp)
> > +{
> > +     return rt9471_set_value_by_field_range(chip, F_IEOC_CHG,
> > +                                            RT9471_RANGE_IEOC, microam=
p);
> > +}
> > +
> > +static inline int rt9471_get_ieoc(struct rt9471_chip *chip, int *micro=
amp)
> > +{
> > +     return rt9471_get_value_by_field_range(chip, F_IEOC_CHG,
> > +                                            RT9471_RANGE_IEOC, microam=
p);
> > +}
> > +
> > +static inline int rt9471_set_chg_enable(struct rt9471_chip *chip, int =
enable)
> > +{
> > +     return regmap_field_write(chip->rm_fields[F_CHG_EN], !!enable);
> > +}
>
> Please drop these one line wrappers.
Will only keep set_ieoc/get_ieoc function, remove 'inline'
declaration, and integrate CHG_TE switch state.
>
> > [...]
> > diff --git a/drivers/power/supply/rt9471.h b/drivers/power/supply/rt947=
1.h
> > new file mode 100644
> > index 00000000..f3d8e23
> > --- /dev/null
> > +++ b/drivers/power/supply/rt9471.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (C) 2022 Richtek Technology Corp. */
> > +
> > +#ifndef __RT9471_CHARGER_H
> > +#define __RT9471_CHARGER_H
> > +
> > +#define RT9471_IRQ_BC12_DONE 0
> > +#define RT9471_IRQ_DETACH    1
> > +#define RT9471_IRQ_RECHG     2
> > +#define RT9471_IRQ_CHG_DONE  3
> > +#define RT9471_IRQ_BG_CHG    4
> > +#define RT9471_IRQ_IE0C              5
> > +#define RT9471_IRQ_CHG_RDY   6
> > +#define RT9471_IRQ_VBUS_GD   7
> > +#define RT9471_IRQ_CHG_BATOV 9
> > +#define RT9471_IRQ_CHG_SYSOV 10
> > +#define RT9471_IRQ_CHG_TOUT  11
> > +#define RT9471_IRQ_CHG_BUSUV 12
> > +#define RT9471_IRQ_CHG_THREG 13
> > +#define RT9471_IRQ_CHG_AICR  14
> > +#define RT9471_IRQ_CHG_MIVR  15
> > +#define RT9471_IRQ_SYS_SHORT 16
> > +#define RT9471_IRQ_SYS_MIN   17
> > +#define RT9471_IRQ_AICC_DONE 18
> > +#define RT9471_IRQ_PE_DONE   19
> > +#define RT9471_IRQ_JEITA_COLD        20
> > +#define RT9471_IRQ_JEITA_COOL        21
> > +#define RT9471_IRQ_JEITA_WARM        22
> > +#define RT9471_IRQ_JEITA_HOT 23
> > +#define RT9471_IRQ_OTG_FAULT 24
> > +#define RT9471_IRQ_OTG_LBP   25
> > +#define RT9471_IRQ_OTG_CC    26
> > +#define RT9471_IRQ_WDT               29
> > +#define RT9471_IRQ_VAC_OV    30
> > +#define RT9471_IRQ_OTP               31
> > +
> > +#define RT9471_REG_OTGCFG    0x00
> > +#define RT9471_REG_TOP               0x01
> > +#define RT9471_REG_FUNC              0x02
> > +#define RT9471_REG_IBUS              0x03
> > +#define RT9471_REG_VBUS              0x04
> > +#define RT9471_REG_PRECHG    0x05
> > +#define RT9471_REG_VCHG              0x07
> > +#define RT9471_REG_ICHG              0x08
> > +#define RT9471_REG_CHGTMR    0x09
> > +#define RT9471_REG_EOC               0x0A
> > +#define RT9471_REG_INFO              0x0B
> > +#define RT9471_REG_JEITA     0x0C
> > +#define RT9471_REG_PUMP_EXP  0x0D
> > +#define      RT9471_REG_DPDMDET      0x0E
> > +#define RT9471_REG_ICSTAT    0x0F
> > +#define      RT9471_REG_STAT0        0x10
> > +#define RT9471_REG_STAT1     0x11
> > +#define RT9471_REG_STAT2     0x12
> > +#define RT9471_REG_IRQ0              0x20
> > +#define RT9471_REG_MASK0     0x30
> > +
> > +#define RT9471_OTGCV_MASK    GENMASK(7, 6)
> > +#define RT9471_OTGCC_MASK    BIT(0)
> > +#define RT9471_OTGEN_MASK    BIT(1)
> > +#define RT9471_CHGFAULT_MASK GENMASK(4, 1)
> > +
> > +/* Device ID */
> > +#define RT9470_DEVID         0x09
> > +#define RT9470D_DEVID                0x0A
> > +#define RT9471_DEVID         0x0D
> > +#define RT9471D_DEVID                0x0E
> > +
> > +#define RT9471_NUM_IRQ_REGS  4
> > +#define RT9471_OTGCV_MINUV   4850000
> > +#define RT9471_OTGCV_STEPUV  150000
> > +#define RT9471_NUM_VOTG              4
> > +#define RT9471_VCHG_MAXUV    4700000
> > +#define RT9471_ICHG_MAXUA    3150000
> > +
> > +#endif /* __RT9471_CHARGER_H */
>
> Please merge this into rt9471.c
>
> > --
> > 2.7.4
> >
