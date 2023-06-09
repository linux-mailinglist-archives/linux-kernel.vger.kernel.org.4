Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2AE72A35B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFITso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFITsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:48:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF25211C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:48:41 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-569386b7861so47900397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1686340120; x=1688932120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7eC2UbdSpv6D7XYzv5m8P1xj9eUlOU6FuqagpqnPV0=;
        b=5Ma3NOEKgVdMbuUbUZDPNpcKauvik3RebwIXG0erT7DyZZM8kPPFDjfB9HhNtvC2wp
         skvMxy3FMaZjyVK0NUXx25+mBR+r/U1YYWesHeFJK1By7baOckAfDGCfe35JQnJg6cDv
         yBzz5M+Ur+p9T8zKlvBcx4y0GJ5h6SM9fbK1a0k7DIni9Ey0Zhbvup8R2iEMkqQEmwza
         EVpZMie0ihQk+2Vidxl4lCjNK6zuh5KCecx2htUseJvooNqkuWBcM7ZL8yl8qtnOmAmr
         RT/9aMUvLki6fXYWdTR+e58XAEASY9JW7a5SU1XO6h+M2vtVJLmrP+AHrfLs3gT08P8l
         BIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340120; x=1688932120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7eC2UbdSpv6D7XYzv5m8P1xj9eUlOU6FuqagpqnPV0=;
        b=Fx1FjswkIb/SCSz5F9xZIBGU7n1ov3JXeWCP2Er2HaIk1Pt6eNT6KLBIO84qQEoFFx
         Zl337vTt7kdFcVmisJXQApB4BGHuNliG5DB912bUGnMhohw7y+sEteO5Z00Rz/TeDrYH
         T+CGfJCh0H9NLGCyGcOMrS3Mpluhq96RHVvdZCxY18nKiW3kfovN8EEfdkYuzqKT5CgG
         zPWBWHvgxCVeT3vV8FVv2cCK8E5aWbU6zJtq/xOSbsZoiKHAZrvgXGSxnNHC7bJHceEH
         gnC7kN3AlvsFCB/NjyAA30a4xX53GgjDF4PIB7Nmv/8RnFFOH1evoQbViCdkeSqmEAlq
         B90A==
X-Gm-Message-State: AC+VfDwEytovXx3+I4Ddod+AxCxvRyoypiXwsD0c5dA8FtQf4ecKhOEp
        ISFf3thZI0Pe+nh09pDgWU4jLFxHbfGX42QJSM5aIA==
X-Google-Smtp-Source: ACHHUZ5GnAX1IZtcu2cCAQwJH2Hq5Jpab8hykjHKKVTuWdukncw3t/QVKYim2sGgA6/Ob9IJsnnAoB1PD4idQYUGQKE=
X-Received: by 2002:a0d:d5c9:0:b0:568:f050:7c47 with SMTP id
 x192-20020a0dd5c9000000b00568f0507c47mr4681126ywd.0.1686340120617; Fri, 09
 Jun 2023 12:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230606152652.1447659-1-tharvey@gateworks.com> <20230609143803.GC4199@dragon>
In-Reply-To: <20230609143803.GC4199@dragon>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 9 Jun 2023 12:48:29 -0700
Message-ID: <CAJ+vNU2thdOMSA8jD2zNq--G79D9mVvmASCG4S8cCC-kRT50LA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp-venice-gw74xx: update to revB PCB
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 7:38=E2=80=AFAM Shawn Guo <shawnguo@kernel.org> wrot=
e:
>
> On Tue, Jun 06, 2023 at 08:26:52AM -0700, Tim Harvey wrote:
> > Update the imx8mp-venice-gw74xx for revB:
> >  - add CAN1
> >  - add TIS-TPM on SPI2
> >  - add FAN controller
> >  - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
> >    backward compatible option)
> >  - M2 socket GPIO's moved
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> ../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:402.4-17: Warni=
ng (reg_format): /soc@0/bus@30800000/i2c@30a20000/gsc@20/fan-controller@a:r=
eg: property has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-c=
ells =3D=3D 1)
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (pci_devi=
ce_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (pci_devi=
ce_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (i2c_bus_=
reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (spi_bus_=
reg): Failed prerequisite 'reg_format'
> ../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:400.20-403.5: W=
arning (avoid_default_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20/f=
an-controller@a: Relying on default #address-cells value
> ../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:400.20-403.5: W=
arning (avoid_default_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20/f=
an-controller@a: Relying on default #size-cells value
>

Shawn,

Looks like I'm missing an '#address-cells' and '#size-cells' in the
gsc node. I will send a v3.

How do you filter through all the known (and ignored?) warnings that
are failing dtbs_check because various dt-binding yamls which are
either missing or need updates such as the following:

/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
timer@302d0000: compatible: 'oneOf' conditional failed, one must be
fixed:
['fsl,imx8mp-gpt', 'fsl,imx6dl-gpt'] is too long
'fsl,imx1-gpt' was expected
'fsl,imx21-gpt' was expected
'fsl,imx27-gpt' was expected
'fsl,imx31-gpt' was expected
'fsl,imx8mp-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt',
'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
'fsl,imx6dl-gpt' was expected
'fsl,imx8mp-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt',
'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/timer/fsl,imxgpt.yaml
^^^ get this for all the imx gpt timers

arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb:
/soc@0/bus@30800000/spba-bus@30800000/spi@30820000/tpm@0: failed to
match any schema with compatible: ['tcg,tpm_tis-spi']
/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
accelerometer@19: 'interrupt-names' does not match any of the regexes:
'pinctrl-[0-9]+'
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/iio/st,st-sensors.yaml
^^^ is 'interrupt-names =3D "INT1"' really invalid here?

/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
switch@5f: Unevaluated properties are not allowed ('interrupt-parent',
'interrupts' were unexpected)
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/net/dsa/microchip,ksz.yaml
^^^ microchip,ksz.yaml doesn't describe interrupts yet the driver uses them

/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
['cypress,cyw4373-fmac'] is too short
'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac',
'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425',
'pci14e4,4433']
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/net/wireless/brcm,bcm4329-fmac.yaml
^^^ This one I don't understand at all - brcm,bcm4329-fmac.yaml
defines 'cypress,cyw4373-fmac under oneOf/items/enum but not
oneOf/enum???

/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
pcie@33800000: Unevaluated properties are not allowed
('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks'
were unexpected)
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/pci/fsl,imx6q-pcie.yaml
^^^ we get this on all imx with pcie

/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
usb@32f10100: usb@38100000: Unevaluated properties are not allowed
('connector' was unexpected)
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/usb/fsl,imx8mp-dwc3.yaml
/usr/src/venice/linux-master/arch/arm64/boot/dts/freescale/imx8mp-venice-gw=
74xx.dtb:
usb@38100000: Unevaluated properties are not allowed ('connector' was
unexpected)
From schema: /usr/src/venice/linux-master/Documentation/devicetree/bindings=
/usb/snps,dwc3.yaml
^^^ fsl,imx8mp-dwc3.yaml doesn't document connector nodes

arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: /pps: failed
to match any schema with compatible: ['pps-gpio']
^^^ need a pps-gpio.yaml

Is there a way to skip certain schemas or some multi-line grep -v
pattern you are using?

I've noticed a lot of contributors putting time into dt-bindings to
pass schema checks and things are getting cleaned up fairly quickly.

Best Regards,

Tim
