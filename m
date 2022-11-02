Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30CF616643
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiKBPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiKBPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:34:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7957F22B0D;
        Wed,  2 Nov 2022 08:34:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10500736otb.6;
        Wed, 02 Nov 2022 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GckXSNY66qLUlaXFal++02U/PNrnU1gN7yG5tlmII/k=;
        b=H1d6hzkWCTZSz07fVH0JK1wSFwf49DWsTTfJ+BTwLrbrYk2ZCPvM0x0AsQV41MAqda
         3ogcQb7zS3Hu8sxJ111rZjBNKlbfb67PjLe+Kzf8rHAqDGi2nxoU6zBoDQBMRwbtDFKT
         /aL5qgPFvD03LsdeLgtBAPbMuIFb3ckim+UQgYTHYDo7GWTkuC04eXoy8Ggikm/9hoL1
         CsObX6Rmfz5LAVSHawc0EUqE8Ls/LGIEn2Yf5errau+WxcjKr6Tkt8tKafJ1p/GYVAjy
         MqdS1gzhtaXbkc9Yghixj3KyDSHHu1mR8NnZuD/e3kSlGIQBw76DkDb2teSohI6oa1Kv
         wlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GckXSNY66qLUlaXFal++02U/PNrnU1gN7yG5tlmII/k=;
        b=CUvcZVl9AptYfS1K8n0n9iUGbjqYAEn2rwsf5vkyh0oGlWuKkzxhWDrMay9Vldr5b/
         /yZXP3JVtH8wwHfPNl3pM6lCQ2/g72g12r1ZDfxiQQwYZKHyiJIai8VKZYbhdBFWiLN2
         mzIp5KzBli6G4qH8p8EQtmZk5l1y1050cUKXyNPYwqIINrj2dZYmELodIDzSoS0u15zU
         Bb6W2qzXtghwehPrS6ggz7FbdTBlvpxdF1i4fTNt42ZnNqnHNcCllXg8o9hYecv/FP4d
         zf5wBzMWWdovvgw5/Y0m3e8FRv3mani0nTkvb8jteYX8oro0bJtfdwfQLEkt5nkbcpAX
         5lTA==
X-Gm-Message-State: ACrzQf2N8nexG8ymVkaIVLkPG39PWBw3x1qbXTbqPg9Hz957aBEr2+Y4
        QDKVKiHkDEch8IUgcDWkL3uIA5tgYJdiwlQYHSjcUEkIR08=
X-Google-Smtp-Source: AMsMyM70iTRMqVYh3xA2HJEBMWNBao6iYBXD3uS4hbeT/MBKp7VY/8CLpTkdGz7Jhw1JQfhpYDaNjnvhogEE2JFtZWk=
X-Received: by 2002:a05:6830:660c:b0:661:bc04:7486 with SMTP id
 cp12-20020a056830660c00b00661bc047486mr12708039otb.152.1667403245769; Wed, 02
 Nov 2022 08:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221024174233.1650028-1-dsankouski@gmail.com> <fcb4acfa-9992-53f4-32d7-505abaad87e4@linaro.org>
In-Reply-To: <fcb4acfa-9992-53f4-32d7-505abaad87e4@linaro.org>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Wed, 2 Nov 2022 18:33:54 +0300
Message-ID: <CABTCjFBjYcyi1Y8d1jSmn2hfSZ4Zfjd-TAwLRuEL7e+029Hgfw@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I rebased on 6.1-rc3, and found 1 issue related to sagit - missing
regulator in qusb2phy node.

=D0=BF=D0=BD, 24 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 23:54, Krzysztof K=
ozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 24/10/2022 13:42, Dzmitry Sankouski wrote:
> > New device support - Xiaomi Mi6 phone
> >
> > What works:
> > - storage
> > - usb
> > - power regulators
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> > Changes for v2:
> > - remove memory nodes before redefining
> > - add board compatible to schema
> > - remove board msm-id, add chassis type
> > - remove common dtsi
> > - move resin to pm8998 dtsi file
> > - dts formatting
> > - unsupported properties removed
> > - add copyright
> > - rebase on latest master(6.0.0-rc6)
> > Changes for v3:
> > - regulators nodes renamed to match pattern 'regulators-[01]'
> > - duplicate cci1-default node deleted
> > - add state suffix to '.*(active|suspend|default)' pinctrl
> > - rebase on latest master(6.0.0)
> > Changes for v4:
> > - fix dts compilation errors(rename pinctrl label usages)
> > Changes for v5:
> > - use pm8005_regulators label
> > Changes for v6:
> > - add state suffix to all pinctrl
> > - move status nodes to last position
> > - disable resin node by default
> > - move the debounce param to pm8998.dtsi file
> > - place this patch after dt-binding patch
> > Changes for v7:
> > - fix Properties must precede subnodes dts compilation error
> > Changes for v8:
> > - enable resin node
> > - rename nodes in reserved memory to comply with 'memory@.*' pattern
> > Changes for v9: none
> > Changes for v10:
> > - reorder resin node content
> > - reorder reserved memory nodes
> > - increase reserved memory for adsp to comply with vendor kernel
> > - new line in blsp1_uart3 node
> >
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 710 ++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
> >  3 files changed, 719 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qc=
om/Makefile
> > index 1d86a33de528..0460aabf1b59 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_QCOM)     +=3D msm8998-oneplus-dump=
ling.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D msm8998-sony-xperia-yoshino-lilac.dt=
b
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D msm8998-sony-xperia-yoshino-maple.dt=
b
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D msm8998-sony-xperia-yoshino-poplar.d=
tb
> > +dtb-$(CONFIG_ARCH_QCOM)      +=3D msm8998-xiaomi-sagit.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D qcs404-evb-1000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D qcs404-evb-4000.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      +=3D qrb5165-rb5.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/a=
rm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> > new file mode 100644
> > index 000000000000..ea66583fe74d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> > @@ -0,0 +1,710 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Xiaomi Mi 6 (sagit) device tree source based on msm8998-mtp.dtsi
> > + *
> > + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2022, Degdag Mohamed <degdagmohamed@gmail.com>
> > + * Copyright (c) 2022, Dzmitry Sankouski <dsankouski@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "msm8998.dtsi"
> > +#include "pm8005.dtsi"
> > +#include "pm8998.dtsi"
> > +#include "pmi8998.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +
> > +/*
> > + * Delete following upstream (msm8998.dtsi) reserved
> > + * memory mappings which are different in this device.
> > + */
> > +/delete-node/ &adsp_mem;
> > +/delete-node/ &mpss_mem;
> > +/delete-node/ &venus_mem;
> > +/delete-node/ &mba_mem;
> > +/delete-node/ &slpi_mem;
> > +/delete-node/ &ipa_fw_mem;
> > +/delete-node/ &ipa_gsi_mem;
> > +/delete-node/ &gpu_mem;
> > +/delete-node/ &wlan_msa_mem;
> > +
> > +/ {
> > +     model =3D "Xiaomi Mi 6";
> > +     compatible =3D "xiaomi,sagit", "qcom,msm8998";
> > +     chassis-type =3D "handset";
> > +     /* Required for bootloader to select correct board */
> > +     qcom,board-id =3D <30 0>;
> > +
> > +     reserved-memory {
> > +             /*
> > +              * Xiaomi's ADSP firmware requires 30 MiB in total, so in=
crease the adsp_mem
> > +              * region by 4 MiB to account for this while relocating t=
he other now
> > +              * conflicting memory nodes accordingly.
> > +              */
> > +             adsp_mem: memory@8b200000 {
> > +                     reg =3D <0x0 0x8b200000 0x0 0x1e00000>;
> > +                     no-map;
> > +             };
> > +
> > +             mpss_mem: memory@8d000000 {
> > +                     reg =3D <0x0 0x8d000000 0x0 0x7000000>;
> > +                     no-map;
> > +             };
> > +
> > +             venus_mem: memory@94000000 {
> > +                     reg =3D <0x0 0x94000000 0x0 0x500000>;
> > +                     no-map;
> > +             };
> > +
> > +             mba_mem: memory@94500000 {
> > +                     reg =3D <0x0 0x94500000 0x0 0x200000>;
> > +                     no-map;
> > +             };
> > +
> > +             slpi_mem: memory@94700000 {
> > +                     reg =3D <0x0 0x94700000 0x0 0xf00000>;
> > +                     no-map;
> > +             };
> > +
> > +             ipa_fw_mem: memory@95600000 {
> > +                     reg =3D <0x0 0x95600000 0x0 0x10000>;
> > +                     no-map;
> > +             };
> > +
> > +             ipa_gsi_mem: memory@95610000 {
> > +                     reg =3D <0x0 0x95610000 0x0 0x5000>;
> > +                     no-map;
> > +             };
> > +
> > +             gpu_mem: memory@95615000 {
> > +                     reg =3D <0x0 0x95615000 0x0 0x100000>;
> > +                     no-map;
> > +             };
> > +
> > +             wlan_msa_mem: memory@95715000 {
> > +                     reg =3D <0x0 0x95715000 0x0 0x100000>;
> > +                     no-map;
> > +             };
> > +
> > +             /* Bootloader display framebuffer region */
> > +             cont_splash_mem: memory@9d400000 {
> > +                     reg =3D <0x0 0x9d400000 0x0 0x2400000>;
> > +                     no-map;
> > +             };
> > +
> > +             /* For getting crash logs using Android downstream kernel=
s */
> > +             ramoops@ac000000 {
> > +                     compatible =3D "ramoops";
> > +                     reg =3D <0x0 0xac000000 0x0 0x200000>;
> > +                     console-size =3D <0x80000>;
> > +                     pmsg-size =3D <0x40000>;
> > +                     record-size =3D <0x8000>;
> > +                     ftrace-size =3D <0x20000>;
> > +             };
> > +
> > +             /*
> > +              * The following memory regions on downstream are "dynami=
cally allocated"
> > +              * but given the same addresses every time. Hard code the=
m as these addresses
> > +              * are where the Xiaomi signed firmware expects them to b=
e.
> > +              */
> > +             ipa_fws_region: memory@f7800000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x0 0xf7800000 0x0 0x5000>;
> > +                     no-map;
> > +             };
> > +
> > +             zap_shader_region: memory@f7900000 {
> > +                     compatible =3D "shared-dma-pool";
> > +                     reg =3D <0x0 0xf7900000 0x0 0x2000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible =3D "gpio-keys";
> > +             label =3D "Volume buttons";
> > +             autorepeat;
> > +
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&vol_up_key_default>;
> > +
> > +             key-vol-up {
> > +                     label =3D "Volume up";
> > +                     gpios =3D <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> > +                     linux,code =3D <KEY_VOLUMEUP>;
> > +                     debounce-interval =3D <15>;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +
> > +     gpio-hall-sensor {
> > +             compatible =3D "gpio-keys";
> > +             label =3D "Hall effect sensor";
> > +
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&hall_sensor_default_state>;
> > +
> > +             event-hall-sensor {
> > +                     label =3D "Hall Effect Sensor";
> > +                     gpios =3D <&tlmm 124 GPIO_ACTIVE_LOW>;
> > +                     linux,input-type =3D <EV_SW>;
> > +                     linux,code =3D <SW_LID>;
> > +                     linux,can-disable;
> > +                     wakeup-source;
> > +             };
> > +     };
> > +
> > +     vph_pwr: vph-pwr-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vph_pwr";
> > +             regulator-min-microvolt =3D <3700000>;
> > +             regulator-max-microvolt =3D <3700000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     disp_vddts_vreg: disp-vddts-regulator {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "disp-vddts-regulator";
> > +             gpio =3D <&tlmm 50 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             regulator-boot-on;
> > +     };
> > +};
> > +
> > +&blsp1_i2c5 {
> > +     pinctrl-names =3D "default", "sleep";
> > +     status =3D "okay";
> > +
> > +     touchscreen@20 {
> > +             compatible =3D "syna,rmi4-i2c";
> > +             reg =3D <0x20>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             interrupt-parent =3D <&tlmm>;
> > +             interrupts =3D <125 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +             pinctrl-names =3D "default", "sleep";
> > +             pinctrl-0 =3D <&ts_active_state>;
> > +             pinctrl-1 =3D <&ts_int_suspend_state &ts_reset_suspend_st=
ate>;
> > +
> > +             vdd-supply =3D <&disp_vddts_vreg>;
> > +             vio-supply =3D <&vreg_l6a_1p8>;
> > +
> > +             syna,reset-delay-ms =3D <20>;
> > +             syna,startup-delay-ms =3D <20>;
> > +
> > +             rmi4-f01@1 {
> > +                     reg =3D <0x01>;
> > +                     syna,nosleep-mode =3D <1>;
> > +             };
> > +
> > +             rmi4-f12@12 {
> > +                     reg =3D <0x12>;
> > +                     touchscreen-x-mm =3D <64>;
> > +                     touchscreen-y-mm =3D <114>;
> > +                     syna,sensor-type =3D <1>;
> > +                     syna,rezero-wait-ms =3D <20>;
> > +             };
> > +
> > +             rmi4-f1a@1a {
> > +                     reg =3D <0x1a>;
> > +                     syna,codes =3D <KEY_BACK KEY_APPSELECT>;
> > +             };
> > +     };
> > +};
> > +
> > +&blsp1_i2c5_sleep {
> > +     /delete-property/ bias-pull-up;
> > +     bias-disable;
> > +};
> > +
> > +&blsp1_uart3 {
> > +     status =3D "okay";
> > +
> > +     bluetooth {
> > +             compatible =3D "qcom,wcn3990-bt";
> > +
> > +             vddio-supply =3D <&vreg_s4a_1p8>;
> > +             vddxo-supply =3D <&vreg_l7a_1p8>;
> > +             vddrf-supply =3D <&vreg_l17a_1p3>;
> > +             vddch0-supply =3D <&vreg_l25a_3p3>;
> > +             max-speed =3D <3200000>;
> > +     };
> > +};
> > +
> > +&blsp1_uart3_on {
> > +     rx {
>
> You need to rebase your changes. This won't work.
>
> If you test your DTS with dtbs_check, you will see the warnings.
>
>
>
> Best regards,
> Krzysztof
>
