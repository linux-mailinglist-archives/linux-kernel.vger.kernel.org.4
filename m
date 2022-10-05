Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080FF5F5A74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJETOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJETN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:13:28 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9208F7E310;
        Wed,  5 Oct 2022 12:13:26 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso11461702ooq.6;
        Wed, 05 Oct 2022 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=yv72EL1E0BJtogUOENI0IkscDOlgQ0N5OuUGdosiZuo=;
        b=UF1czuAdrhQKrVo+OrE+AyU+JcQZet2otdbUodHSI6BSc+1JiXf4eDnQseSRuWoNne
         jZEA26L8NH8J7ZbYKVwEajsQ4OeY8iRwLavip+8Ns559hi3iVWqheloMYO9qvR09DTUt
         54egTgjcOCLE2L1d3NeE2SC1qE2VEAr93GdgA77EWUCKlCUO8cHaxeA8depaWFFoPV6R
         JOv1p/He+T0CJQnoIDNldP1Pz3lCcwO2eyDHK9Mmn0JzmwRycB3CPJWOwsAqBl9ffkkT
         3sVD4YOyvm/t9FvbVGItK2enZfVdLesFr5er+x107BPjRDK7vzpD14up9WtTEavtvNR/
         gBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yv72EL1E0BJtogUOENI0IkscDOlgQ0N5OuUGdosiZuo=;
        b=03vsPR1CoPwJU7k1dpdmZgzUuRzyI5ElqBpJiABF2tydesVATjCxPXFjtRCmZokVmr
         Qtd0wZ7gYo40cXaj1sSHjnUXnDHgknFkuX53in+Da+sgzc5ERwKOfiZw9QWupVQZ4jTX
         aH0++N7vN3vYkkQaEGuYDZkCAXlQHa71DRMSBMqbfcGe/ThSbLXzz+jUrMzwiBrh5Zp5
         7URXj4+5qcPdJ4gu7O94XZK1QPxrWZs1fcyDB6GcLejJtxMNe/Efl/7Hu7c357MuSJqz
         vz8F88d3RfDyTH+IloA7iufguJtomMN8Ca7V1HM5tPNJ3Y8bVFwJH/NTGPfiL6EXInDF
         uAXA==
X-Gm-Message-State: ACrzQf3aScxWMhQyW+ITdyYnvKtsc7+MtT5e4NBPpbiq0T1yHUZyHr5I
        sUC3V2uAXlHmy8r6XSoE/DJ9TF3JfHo/kQcizzp/kIs4hKQ=
X-Google-Smtp-Source: AMsMyM5wG+AGAukrKmaLGmYZeWxD682k8TxkvMm4by55WT/EUp117T2cd8IEvuXoKWnW28JzngW7LkOZQCgH9BR60P4=
X-Received: by 2002:a9d:7d16:0:b0:656:578:24ae with SMTP id
 v22-20020a9d7d16000000b00656057824aemr422391otn.152.1664997205703; Wed, 05
 Oct 2022 12:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221005181528.1038629-1-dsankouski@gmail.com> <20221005181528.1038629-3-dsankouski@gmail.com>
In-Reply-To: <20221005181528.1038629-3-dsankouski@gmail.com>
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Wed, 5 Oct 2022 22:13:14 +0300
Message-ID: <CABTCjFBJEOQdYvOjwArkEj9o-LNYAESFUdsm+OPambDzTkWQEA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

compilation fails for this patch version, please, heed on to version 7 seri=
es

=D1=81=D1=80, 5 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 21:15, Dzmitry Sank=
ouski <dsankouski@gmail.com>:
>
> New device support - Xiaomi Mi6 phone
>
> What works:
> - storage
> - usb
> - power regulators
>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 681 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
>  3 files changed, 690 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom=
/Makefile
> index 1d86a33de528..0460aabf1b59 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_QCOM)       +=3D msm8998-oneplus-dump=
ling.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D msm8998-sony-xperia-yoshino-lilac.dt=
b
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D msm8998-sony-xperia-yoshino-maple.dt=
b
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D msm8998-sony-xperia-yoshino-poplar.d=
tb
> +dtb-$(CONFIG_ARCH_QCOM)        +=3D msm8998-xiaomi-sagit.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        +=3D qrb5165-rb5.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm=
64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> new file mode 100644
> index 000000000000..e44f6a745a2c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> @@ -0,0 +1,681 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Xiaomi Mi 6 (sagit) device tree source based on msm8998-mtp.dtsi
> + *
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Degdag Mohamed <degdagmohamed@gmail.com>
> + * Copyright (c) 2022, Dzmitry Sankouski <dsankouski@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8998.dtsi"
> +#include "pm8005.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/*
> + * Delete following upstream (msm8998.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &mpss_mem;
> +/delete-node/ &venus_mem;
> +/delete-node/ &mba_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &ipa_gsi_mem;
> +/delete-node/ &gpu_mem;
> +/delete-node/ &wlan_msa_mem;
> +
> +/ {
> +       model =3D "Xiaomi Mi 6";
> +       compatible =3D "xiaomi,sagit", "qcom,msm8998";
> +       chassis-type =3D "handset";
> +       /* Required for bootloader to select correct board */
> +       qcom,board-id =3D <30 0>;
> +
> +       reserved-memory {
> +               /*
> +                * The following memory regions on downstream are "dynami=
cally allocated"
> +                * but given the same addresses every time. Hard code the=
m as these addresses
> +                * are where the Xiaomi signed firmware expects them to b=
e.
> +                */
> +               ipa_fws_region: ipa@f7800000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0x0 0xf7800000 0x0 0x5000>;
> +                       no-map;
> +               };
> +
> +               zap_shader_region: gpu@f7900000 {
> +                       compatible =3D "shared-dma-pool";
> +                       reg =3D <0x0 0xf7900000 0x0 0x2000>;
> +                       no-map;
> +               };
> +
> +               mpss_mem: memory@8d000000 {
> +                       reg =3D <0x0 0x8d000000 0x0 0x7000000>;
> +                       no-map;
> +               };
> +
> +               venus_mem: memory@94000000 {
> +                       reg =3D <0x0 0x94000000 0x0 0x500000>;
> +                       no-map;
> +               };
> +
> +               mba_mem: memory@94500000 {
> +                       reg =3D <0x0 0x94500000 0x0 0x200000>;
> +                       no-map;
> +               };
> +
> +               slpi_mem: memory@94700000 {
> +                       reg =3D <0x0 0x94700000 0x0 0x10000>;
> +                       no-map;
> +               };
> +
> +               ipa_fw_mem: memory@95600000 {
> +                       reg =3D <0x0 0x95600000 0x0 0x10000>;
> +                       no-map;
> +               };
> +
> +               ipa_gsi_mem: memory@95610000 {
> +                       reg =3D <0x0 0x95610000 0x0 0x5000>;
> +                       no-map;
> +               };
> +
> +               gpu_mem: memory@95615000 {
> +                       reg =3D <0x0 0x95615000 0x0 0x100000>;
> +                       no-map;
> +               };
> +
> +               wlan_msa_mem: memory@95715000 {
> +                       reg =3D <0x0 0x95715000 0x0 0x100000>;
> +                       no-map;
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible =3D "gpio-keys";
> +               label =3D "Volume buttons";
> +               autorepeat;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&vol_up_key_default>;
> +
> +               key-vol-up {
> +                       label =3D "Volume up";
> +                       gpios =3D <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_VOLUMEUP>;
> +                       debounce-interval =3D <15>;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       gpio-hall-sensor {
> +               compatible =3D "gpio-keys";
> +               label =3D "Hall effect sensor";
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&hall_sensor_default_state>;
> +
> +               event-hall-sensor {
> +                       label =3D "Hall Effect Sensor";
> +                       gpios =3D <&tlmm 124 GPIO_ACTIVE_LOW>;
> +                       linux,input-type =3D <EV_SW>;
> +                       linux,code =3D <SW_LID>;
> +                       linux,can-disable;
> +                       wakeup-source;
> +               };
> +       };
> +
> +       vph_pwr: vph-pwr-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vph_pwr";
> +               regulator-min-microvolt =3D <3700000>;
> +               regulator-max-microvolt =3D <3700000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       disp_vddts_vreg: disp-vddts-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "disp-vddts-regulator";
> +               gpio =3D <&tlmm 50 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-boot-on;
> +       };
> +};
> +
> +&blsp1_i2c5 {
> +       pinctrl-names =3D "default", "sleep";
> +
> +       touchscreen@20 {
> +               compatible =3D "syna,rmi4-i2c";
> +               reg =3D <0x20>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               interrupt-parent =3D <&tlmm>;
> +               interrupts =3D <125 IRQ_TYPE_EDGE_FALLING>;
> +
> +               pinctrl-names =3D "default", "sleep";
> +               pinctrl-0 =3D <&ts_active_state>;
> +               pinctrl-1 =3D <&ts_int_suspend_state &ts_reset_suspend_st=
ate>;
> +
> +               vdd-supply =3D <&disp_vddts_vreg>;
> +               vio-supply =3D <&vreg_l6a_1p8>;
> +
> +               syna,reset-delay-ms =3D <20>;
> +               syna,startup-delay-ms =3D <20>;
> +
> +               rmi4-f01@1 {
> +                       reg =3D <0x01>;
> +                       syna,nosleep-mode =3D <1>;
> +               };
> +
> +               rmi4-f12@12 {
> +                       reg =3D <0x12>;
> +                       touchscreen-x-mm =3D <64>;
> +                       touchscreen-y-mm =3D <114>;
> +                       syna,sensor-type =3D <1>;
> +                       syna,rezero-wait-ms =3D <20>;
> +               };
> +
> +               rmi4-f1a@1a {
> +                       reg =3D <0x1a>;
> +                       syna,codes =3D <KEY_BACK KEY_APPSELECT>;
> +               };
> +       };
> +       status =3D "okay";
> +};
> +
> +&blsp1_i2c5_sleep {
> +       /delete-property/ bias-pull-up;
> +       bias-disable;
> +};
> +
> +&blsp1_uart3 {
> +       bluetooth {
> +               compatible =3D "qcom,wcn3990-bt";
> +
> +               vddio-supply =3D <&vreg_s4a_1p8>;
> +               vddxo-supply =3D <&vreg_l7a_1p8>;
> +               vddrf-supply =3D <&vreg_l17a_1p3>;
> +               vddch0-supply =3D <&vreg_l25a_3p3>;
> +               max-speed =3D <3200000>;
> +       };
> +       status =3D "okay";
> +};
> +
> +&blsp1_uart3_on {
> +       rx {
> +               /delete-property/ bias-disable;
> +               /*
> +                * Configure a pull-up on 46 (RX). This is needed to
> +                * avoid garbage data when the TX pin of the Bluetooth
> +                * module is in tri-state (module powered off or not
> +                * driving the signal yet).
> +                */
> +               bias-pull-up;
> +       };
> +
> +       cts {
> +               /delete-property/ bias-disable;
> +               /*
> +                * Configure a pull-down on 47 (CTS) to match the pull
> +                * of the Bluetooth module.
> +                */
> +               bias-pull-down;
> +       };
> +};
> +
> +&blsp2_uart1 {
> +       status =3D "okay";
> +};
> +
> +&pm8005_regulators {
> +       compatible =3D "qcom,pm8005-regulators";
> +
> +       vdd_s1-supply =3D <&vph_pwr>;
> +
> +       pm8005_s1: s1 { /* VDD_GFX supply */
> +               regulator-min-microvolt =3D <524000>;
> +               regulator-max-microvolt =3D <1100000>;
> +               regulator-enable-ramp-delay =3D <500>;
> +
> +               /* hack until we rig up the gpu consumer */
> +               regulator-always-on;
> +       };
> +};
> +
> +&pm8998_gpio {
> +       vol_up_key_default: vol-up-key-default-state {
> +               pins =3D "gpio6";
> +               function =3D "normal";
> +               bias-pull-up;
> +               input-enable;
> +               qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_NO>;
> +       };
> +
> +       audio_mclk_pin: audio-mclk-pin-active-state {
> +               pins =3D "gpio13";
> +               function =3D "func2";
> +               power-source =3D <0>;
> +       };
> +};
> +
> +&qusb2phy {
> +       vdda-pll-supply =3D <&vreg_l12a_1p8>;
> +       vdda-phy-dpdm-supply =3D <&vreg_l24a_3p075>;
> +       status =3D "okay";
> +};
> +
> +&rpm_requests {
> +       regulators-0 {
> +               compatible =3D "qcom,rpm-pm8998-regulators";
> +
> +               vdd_s1-supply =3D <&vph_pwr>;
> +               vdd_s2-supply =3D <&vph_pwr>;
> +               vdd_s3-supply =3D <&vph_pwr>;
> +               vdd_s4-supply =3D <&vph_pwr>;
> +               vdd_s5-supply =3D <&vph_pwr>;
> +               vdd_s6-supply =3D <&vph_pwr>;
> +               vdd_s7-supply =3D <&vph_pwr>;
> +               vdd_s8-supply =3D <&vph_pwr>;
> +               vdd_s9-supply =3D <&vph_pwr>;
> +               vdd_s10-supply =3D <&vph_pwr>;
> +               vdd_s11-supply =3D <&vph_pwr>;
> +               vdd_s12-supply =3D <&vph_pwr>;
> +               vdd_s13-supply =3D <&vph_pwr>;
> +               vdd_l1_l27-supply =3D <&vreg_s7a_1p025>;
> +               vdd_l2_l8_l17-supply =3D <&vreg_s3a_1p35>;
> +               vdd_l3_l11-supply =3D <&vreg_s7a_1p025>;
> +               vdd_l4_l5-supply =3D <&vreg_s7a_1p025>;
> +               vdd_l6-supply =3D <&vreg_s5a_2p04>;
> +               vdd_l7_l12_l14_l15-supply =3D <&vreg_s5a_2p04>;
> +               vdd_l9-supply =3D <&vreg_bob>;
> +               vdd_l10_l23_l25-supply =3D <&vreg_bob>;
> +               vdd_l13_l19_l21-supply =3D <&vreg_bob>;
> +               vdd_l16_l28-supply =3D <&vreg_bob>;
> +               vdd_l18_l22-supply =3D <&vreg_bob>;
> +               vdd_l20_l24-supply =3D <&vreg_bob>;
> +               vdd_l26-supply =3D <&vreg_s3a_1p35>;
> +               vdd_lvs1_lvs2-supply =3D <&vreg_s4a_1p8>;
> +
> +               vreg_s3a_1p35: s3 {
> +                       regulator-min-microvolt =3D <1352000>;
> +                       regulator-max-microvolt =3D <1352000>;
> +               };
> +
> +               vreg_s4a_1p8: s4 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               vreg_s5a_2p04: s5 {
> +                       regulator-min-microvolt =3D <1904000>;
> +                       regulator-max-microvolt =3D <2040000>;
> +               };
> +
> +               vreg_s7a_1p025: s7 {
> +                       regulator-min-microvolt =3D <900000>;
> +                       regulator-max-microvolt =3D <1028000>;
> +               };
> +
> +               vreg_l1a_0p875: l1 {
> +                       regulator-min-microvolt =3D <880000>;
> +                       regulator-max-microvolt =3D <880000>;
> +               };
> +
> +               vreg_l2a_1p2: l2 {
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <1200000>;
> +               };
> +
> +               vreg_l3a_1p0: l3 {
> +                       regulator-min-microvolt =3D <1000000>;
> +                       regulator-max-microvolt =3D <1000000>;
> +               };
> +
> +               vreg_l5a_0p8: l5 {
> +                       regulator-min-microvolt =3D <800000>;
> +                       regulator-max-microvolt =3D <800000>;
> +               };
> +
> +               vreg_l6a_1p8: l6 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +               };
> +
> +               vreg_l7a_1p8: l7 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +               };
> +
> +               vreg_l8a_1p2: l8 {
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <1200000>;
> +               };
> +
> +               vreg_l9a_1p8: l9 {
> +                       regulator-min-microvolt =3D <1808000>;
> +                       regulator-max-microvolt =3D <2960000>;
> +               };
> +
> +               vreg_l10a_1p8: l10 {
> +                       regulator-min-microvolt =3D <1808000>;
> +                       regulator-max-microvolt =3D <2960000>;
> +               };
> +
> +               vreg_l11a_1p0: l11 {
> +                       regulator-min-microvolt =3D <1000000>;
> +                       regulator-max-microvolt =3D <1000000>;
> +               };
> +
> +               vreg_l12a_1p8: l12 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +               };
> +
> +               vreg_l13a_2p95: l13 {
> +                       regulator-min-microvolt =3D <1808000>;
> +                       regulator-max-microvolt =3D <2960000>;
> +               };
> +
> +               vreg_l14a_1p8: l14 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +               };
> +
> +               vreg_l15a_1p8: l15 {
> +                       regulator-min-microvolt =3D <1800000>;
> +                       regulator-max-microvolt =3D <1800000>;
> +               };
> +
> +               vreg_l16a_2p7: l16 {
> +                       regulator-min-microvolt =3D <2704000>;
> +                       regulator-max-microvolt =3D <2704000>;
> +               };
> +
> +               vreg_l17a_1p3: l17 {
> +                       regulator-min-microvolt =3D <1304000>;
> +                       regulator-max-microvolt =3D <1304000>;
> +               };
> +
> +               vreg_l18a_2p7: l18 {
> +                       regulator-min-microvolt =3D <2704000>;
> +                       regulator-max-microvolt =3D <2704000>;
> +               };
> +
> +               vreg_l19a_3p0: l19 {
> +                       regulator-min-microvolt =3D <3008000>;
> +                       regulator-max-microvolt =3D <3008000>;
> +               };
> +
> +               vreg_l20a_2p95: l20 {
> +                       regulator-min-microvolt =3D <2960000>;
> +                       regulator-max-microvolt =3D <2960000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               vreg_l21a_2p95: l21 {
> +                       regulator-min-microvolt =3D <2960000>;
> +                       regulator-max-microvolt =3D <2960000>;
> +                       regulator-system-load =3D <800000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               vreg_l22a_2p85: l22 {
> +                       regulator-min-microvolt =3D <2864000>;
> +                       regulator-max-microvolt =3D <2864000>;
> +               };
> +
> +               vreg_l23a_3p3: l23 {
> +                       regulator-min-microvolt =3D <3312000>;
> +                       regulator-max-microvolt =3D <3312000>;
> +               };
> +
> +               vreg_l24a_3p075: l24 {
> +                       regulator-min-microvolt =3D <3088000>;
> +                       regulator-max-microvolt =3D <3088000>;
> +               };
> +
> +               vreg_l25a_3p3: l25 {
> +                       regulator-min-microvolt =3D <3104000>;
> +                       regulator-max-microvolt =3D <3312000>;
> +               };
> +
> +               vreg_l26a_1p2: l26 {
> +                       regulator-min-microvolt =3D <1200000>;
> +                       regulator-max-microvolt =3D <1200000>;
> +                       regulator-allow-set-load;
> +               };
> +
> +               vreg_l28_3p0: l28 {
> +                       regulator-min-microvolt =3D <3008000>;
> +                       regulator-max-microvolt =3D <3008000>;
> +               };
> +
> +               vreg_lvs1a_1p8: lvs1 { };
> +
> +               vreg_lvs2a_1p8: lvs2 { };
> +       };
> +
> +       regulators-1 {
> +               compatible =3D "qcom,rpm-pmi8998-regulators";
> +
> +               vdd_bob-supply =3D <&vph_pwr>;
> +
> +               vreg_bob: bob {
> +                       regulator-min-microvolt =3D <3312000>;
> +                       regulator-max-microvolt =3D <3600000>;
> +               };
> +       };
> +};
> +
> +&tlmm {
> +       gpio-reserved-ranges =3D <0 4>, <81 4>;
> +
> +       cci1_default_state: cci1-default-state {
> +               pins =3D "gpio19", "gpio20";
> +               function =3D "cci_i2c";
> +               bias-disable;
> +               drive-strength =3D <2>;
> +       };
> +
> +       cdc_reset_n_state: cdc-reset-n-state {
> +               pins =3D "gpio64";
> +               function =3D "gpio";
> +               bias-pull-down;
> +               drive-strength =3D <16>;
> +               output-high;
> +       };
> +
> +       hall_sensor_default_state: hall-sensor-default-state {
> +               pins =3D "gpio124";
> +               function =3D "gpio";
> +               drive-strength =3D <2>;
> +               bias-disable;
> +               input-enable;
> +       };
> +
> +       mdss_dsi_active_state: mdss-dsi-active-state {
> +               pins =3D "gpio94";
> +               function =3D "gpio";
> +               drive-strength =3D <8>;
> +               bias-disable;
> +       };
> +
> +       mdss_dsi_suspend_state: mdss-dsi-suspend-state {
> +               pins =3D "gpio94";
> +               function =3D "gpio";
> +               drive-strength =3D <2>;
> +               bias-pull-down;
> +       };
> +
> +       mdss_te_active_state: mdss-te-active-state {
> +               pins =3D "gpio10";
> +               function =3D "mdp_vsync_a";
> +               drive-strength =3D <2>;
> +               bias-pull-down;
> +       };
> +
> +       mdss_te_suspend_state: mdss-te-suspend-state {
> +               pins =3D "gpio10";
> +               function =3D "mdp_vsync_a";
> +               drive-strength =3D <2>;
> +               bias-pull-down;
> +       };
> +
> +       msm_mclk0_active_state: msm-mclk0-active-state {
> +               pins =3D "gpio13";
> +               function =3D "cam_mclk";
> +               drive-strength =3D <2>;
> +               bias-disable;
> +       };
> +
> +       msm_mclk0_suspend_state: msm-mclk0-suspend-state {
> +               pins =3D "gpio13";
> +               function =3D "cam_mclk";
> +               drive-strength =3D <2>;
> +               bias-pull-down;
> +       };
> +
> +       msm_mclk1_active_state: msm-mclk1-active-state {
> +               pins =3D "gpio14";
> +               function =3D "cam_mclk";
> +               drive-strength =3D <2>;
> +               bias-disable;
> +       };
> +
> +       msm_mclk1_suspend_state: msm-mclk1-suspend-state {
> +               pins =3D "gpio14";
> +               function =3D "cam_mclk";
> +               drive-strength =3D <2>;
> +               bias-pull-down;
> +       };
> +
> +       nfc_int_active_state: nfc-int-active-state {
> +               pins =3D "gpio92";
> +               function =3D "gpio";
> +               drive-strength =3D <6>;
> +               bias-pull-up;
> +       };
> +
> +       nfc_int_suspend_state: nfc-int-suspend-state {
> +               pins =3D "gpio92";
> +               function =3D "gpio";
> +               drive-strength =3D <6>;
> +               bias-pull-up;
> +       };
> +
> +       nfc_enable_active_state: nfc-enable-active-state {
> +               pins =3D "gpio12", "gpio116";
> +               function =3D "gpio";
> +               drive-strength =3D <6>;
> +               bias-pull-up;
> +       };
> +
> +       nfc_enable_suspend_state: nfc-enable-suspend-state {
> +               pins =3D "gpio12", "gpio116";
> +               function =3D "gpio";
> +               drive-strength =3D <6>;
> +               bias-disable;
> +       };
> +
> +       ts_active_state: ts-active-state {
> +               pins =3D "gpio89", "gpio125";
> +               function =3D "gpio";
> +               drive-strength =3D <16>;
> +               bias-pull-up;
> +               input-enable;
> +       };
> +
> +       ts_int_suspend_state: ts-int-suspend-state {
> +               pins =3D "gpio125";
> +               function =3D "gpio";
> +               drive-strength =3D <2>;
> +               bias-disable;
> +       };
> +
> +       ts_reset_suspend_state: ts-reset-suspend-state {
> +               pins =3D "gpio89";
> +               function =3D "gpio";
> +               drive-strength =3D <2>;
> +               bias-disable;
> +       };
> +
> +       wcd_int_n_state: wcd-int-n-state {
> +               pins =3D "gpio54";
> +               function =3D "gpio";
> +               bias-pull-down;
> +               drive-strength =3D <2>;
> +               input-enable;
> +       };
> +
> +       wsa_leftspk_pwr_n_state: wsa-leftspk-pwr-n-state {
> +               pins =3D "gpio65";
> +               function =3D "gpio";
> +               bias-disable;
> +               drive-strength =3D <2>;
> +               output-low;
> +       };
> +
> +       wsa_rightspk_pwr_n_state: wsa-rightspk-pwr-n-state {
> +               pins =3D "gpio66";
> +               function =3D "gpio";
> +               bias-disable;
> +               drive-strength =3D <2>;
> +               output-low;
> +       };
> +};
> +
> +&pm8998_resin {
> +       linux,code =3D <KEY_VOLUMEDOWN>;
> +};
> +
> +&ufshc {
> +       vcc-supply =3D <&vreg_l20a_2p95>;
> +       vccq-supply =3D <&vreg_l26a_1p2>;
> +       vccq2-supply =3D <&vreg_s4a_1p8>;
> +       vcc-max-microamp =3D <750000>;
> +       vccq-max-microamp =3D <560000>;
> +       vccq2-max-microamp =3D <750000>;
> +       status =3D "okay";
> +};
> +
> +&ufsphy {
> +       vdda-phy-supply =3D <&vreg_l1a_0p875>;
> +       vdda-pll-supply =3D <&vreg_l2a_1p2>;
> +       vddp-ref-clk-supply =3D <&vreg_l26a_1p2>;
> +       status =3D "okay";
> +};
> +
> +&usb3 {
> +       /* Disable USB3 clock requirement as the device only supports USB=
2 */
> +       qcom,select-utmi-as-pipe-clk;
> +       status =3D "okay";
> +};
> +
> +&usb3_dwc3 {
> +       /* Drop the unused USB 3 PHY */
> +       phys =3D <&qusb2phy>;
> +       phy-names =3D "usb2-phy";
> +
> +       /* Fastest mode for USB 2 */
> +       maximum-speed =3D "high-speed";
> +
> +       /* Force to peripheral until we can switch modes */
> +       dr_mode =3D "peripheral";
> +};
> +
> +&wifi {
> +       vdd-0.8-cx-mx-supply =3D <&vreg_l5a_0p8>;
> +       vdd-1.8-xo-supply =3D <&vreg_l7a_1p8>;
> +       vdd-1.3-rfa-supply =3D <&vreg_l17a_1p3>;
> +       vdd-3.3-ch0-supply =3D <&vreg_l25a_3p3>;
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/q=
com/pm8998.dtsi
> index d09f2954b6f9..7929fa64e1ef 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -52,6 +52,14 @@ pm8998_pwrkey: pwrkey {
>                                 bias-pull-up;
>                                 linux,code =3D <KEY_POWER>;
>                         };
> +
> +                       pm8998_resin: resin {
> +                               compatible =3D "qcom,pm8941-resin";
> +                               bias-pull-up;
> +                               interrupts =3D <GIC_SPI 0x8 1 IRQ_TYPE_ED=
GE_BOTH>;
> +                               debounce =3D <15625>;
> +                               status =3D "disabled";
> +                       };
>                 };
>
>                 pm8998_temp: temp-alarm@2400 {
> --
> 2.30.2
>
