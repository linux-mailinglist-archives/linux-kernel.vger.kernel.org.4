Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23A608C68
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJVLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJVLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:15:39 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCBB186D9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:39:00 -0700 (PDT)
Date:   Sat, 22 Oct 2022 10:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666435138; x=1666694338;
        bh=FSMHblkq3aMPppIFi+ouRLxXT2wvIHP2QO5iAeoXj84=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=tLwhdNXIkkoB5XezU8PTKELoe/kZWk5P+9jMdvXrhE6QvhkfHUg6mGU02qv6myBdg
         W8sWPWFqHoTOcmDCxUK5HAS0MWOfZCNTvUxiMUH0i81dsuh8Ce5B8Xc9PkH6O2SjaN
         zGoH9NkLBdgLAMFSrcACLfaLWn2n7R1ISKEpVHEr+PnfD4euK9HpBqB4KK7/GLk3p0
         oZyCuJ4bfbdExdb/cTVlsAw2Am5EVhBLsCXe0cqF9m2smibJC0C3p+/BswGFQMQrKy
         8PWZqcLIXFOqRjgbtAN5aSuiHR7MCHlGouB/LR5orc75UbwqDMmBnODyBvEztnt4Te
         W/A6bnd4k2r8w==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8996: add support for oneplus3(t)
Message-ID: <wqHFrd3UmaUsRa21931VRDSHnIiusqzv3AIu7nynQkRhvAloHPmNaDvpCCGkdZoeKtZBDI_Rl9As8ehNW4EwpN47yhFJnY3-6hQkurhWy48=@protonmail.com>
In-Reply-To: <78a117d5-b4be-8389-c909-9f8525b151d8@linaro.org>
References: <20221021142242.129276-1-hpausten@protonmail.com> <20221021142242.129276-5-hpausten@protonmail.com> <78a117d5-b4be-8389-c909-9f8525b151d8@linaro.org>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 21st, 2022 at 3:44 PM, Krzysztof Kozlowski <krzysztof.ko=
zlowski@linaro.org> wrote:
[...]
> > +++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
> > @@ -0,0 +1,794 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>=20
>=20
> Are you sure this is GPL-2.0 only? Didn't you derive it from downstream
> OnePlus DTS?

Yes development of these devicetrees was aided by downstream DTS, all of wh=
ich appear to have
GPL-2.0 only headers, e.g. see msm8996-mtp.dts [1].

>=20
> > +/*
> > + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include "msm8996.dtsi"
> > +#include "pm8994.dtsi"
> > +#include "pmi8994.dtsi"
> > +#include "pmi8996.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/sound/qcom,q6afe.h>
> > +#include <dt-bindings/sound/qcom,q6asm.h>
> > +#include <dt-bindings/sound/qcom,wcd9335.h>
> > +
> > +/ {
> > + aliases {
> > + serial0 =3D &blsp1_uart2;
> > + serial1 =3D &blsp2_uart2;
> > + };
> > +
> > + battery: battery {
> > + compatible =3D "simple-battery";
> > +
> > + constant-charge-current-max-microamp =3D <3000000>;
> > + voltage-min-design-microvolt =3D <3400000>;
> > + };
> > +
> > + chosen {
> > + stdout-path =3D "serial1:115200n8";
> > + };
> > +
> > + clocks {
> > + compatible =3D "simple-bus";
>=20
>=20
> This is not a bus of clocks...

Will remove in v2.

>=20
> > +
> > + divclk4: divclk4 {
>=20
>=20
> Use common suffix or prefix for node names and generic name.
>=20
> This clock is anyway a bit weird - same frequency as sleep clk.
>=20
> > + compatible =3D "fixed-clock";
> > + pinctrl-names =3D "default";
> > + pinctrl-0 =3D <&divclk4_pin_a>;
>=20
>=20
> This is a PMIC pin? So is it a PMIC clk?

These two clocks are described in the same way as other current MSM8996 DTs=
 (e.g. apq8096-db820c.dts
and msm8996-xiaomi-common.dtsi). Happy to change if you think there is a be=
tter way to describe them?
Yes, these clocks originate from within the PM8994 PMIC as per the datashee=
t [2]. GPIO_15 is
configured with the DIV_CLK1 alt function and routes to the MCLK pin of the=
 WCD9225 audio codec.
GPIO_18 is configured with the SLEEP_CLK5 alt function and provides the SUS=
CLK_32KHZ input to the
Atheros QCA6174 WiFi/BT chip.

>=20
> > + #clock-cells =3D <0>;
> > + clock-frequency =3D <32768>;
> > + clock-output-names =3D "divclk4";
> > + };
> > +
> > + div1_mclk: divclk1 {
> > + compatible =3D "gpio-gate-clock";
> > + pinctrl-names =3D "default";
> > + pinctrl-0 =3D <&audio_mclk>;
> > + #clock-cells =3D <0>;
> > + clocks =3D <&rpmcc RPM_SMD_DIV_CLK1>;
> > + enable-gpios =3D <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
> > + };
> > + };
> > +
> > + reserved-memory {
> > + ramoops@ac000000 {
> > + compatible =3D "ramoops";
> > + reg =3D <0 0xac000000 0 0x200000>;
> > + record-size =3D <0x20000>;
> > + console-size =3D <0x100000>;
> > + pmsg-size =3D <0x80000>;
> > + };
> > + };
> > +
> > + vph_pwr: vph-pwr-regulator {
> > + compatible =3D "regulator-fixed";
> > + regulator-name =3D "vph_pwr";
> > + regulator-min-microvolt =3D <3700000>;
> > + regulator-max-microvolt =3D <3700000>;
> > + regulator-always-on;
> > + regulator-boot-on;
> > + };
> > +
> > + wlan_en: wlan-en-1-8v {
>=20
>=20
> Use common suffix or prefix. You already used "-regulator" suffix before.

Will fix in v2.

>=20
> > + compatible =3D "regulator-fixed";
> > + pinctrl-names =3D "default";
> > + pinctrl-0 =3D <&wlan_en_gpios>;
> > + regulator-name =3D "wlan-en-regulator";
> > + regulator-min-microvolt =3D <1800000>;
> > + regulator-max-microvolt =3D <1800000>;
> > +
> > + gpio =3D <&pm8994_gpios 8 GPIO_ACTIVE_HIGH>;
> > +
> > + /* WLAN card specific delay */
> > + startup-delay-us =3D <70000>;
> > + enable-active-high;
> > + };
> > +};
> > +
> > +&adsp_pil {
> > + status =3D "okay";
> > +};
> > +
> > +&blsp1_i2c3 {
> > + status =3D "okay";
> > +
> > + tfa9890_amp: audio-codec@36 {
> > + compatible =3D "nxp,tfa9890";
> > + reg =3D <0x36>;
> > + #sound-dai-cells =3D <0>;
> > + };
> > +};
> > +
> > +&blsp1_i2c6 {
> > + status =3D "okay";
> > +
> > + bq27541: fuel-gauge@55 {
> > + compatible =3D "ti,bq27541";
> > + reg =3D <0x55>;
> > + };
> > +};
> > +
> > +&blsp1_uart2 {
> > + label =3D "BT-UART";
> > + status =3D "okay";
>=20
>=20
> Status is a last property.

Will fix all of these in v2.

>=20
> Best regards,
> Krzysztof

Thanks for the review!
Harry

[1]: https://github.com/OnePlusOSS/android_kernel_oneplus_msm8996/blob/onep=
lus3/6.0.1/arch/arm/boot/dts/qcom/msm8996-mtp.dtsi
[2]: https://developer.qualcomm.com/qfile/35466/lm80-p2751-5_c.pdf
