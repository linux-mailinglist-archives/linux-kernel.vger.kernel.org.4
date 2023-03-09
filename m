Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D746B1A83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCIE4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCIEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:55:59 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03288C95E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:55:56 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id f31so597081vsv.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 20:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678337756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjxqdJHTwKdoqofrVIRX/uslVfOrecmuG0zXjEDMDnE=;
        b=bxbeMG5QYKOQm/zYzvv3/3Hk/JY6JiPYXffsKvdoDYkgJEyLsd5luHWpeBPUeaNVoP
         WI1TBhtSF9SQptos3NJfV1IUazfU2qfANWkdP0qVdaC65vDfQ7EvdHVplXw/nbVz0LqW
         nYySeNJ1BUgFQnIdSq/Z+V4ppkz0S4K7nvdeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678337756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjxqdJHTwKdoqofrVIRX/uslVfOrecmuG0zXjEDMDnE=;
        b=5Vfeg5K4e+6BsqCSewgr5791kj8nblbdamkFaF147QgkzdfSKcrkmiY4q7/KKqUkLB
         JogTg4uhOnB749tuntzu105/7qX3og7src8rrcF933ZFhQ7LTXVmWZg45Le3uVfK3Ewd
         1DCxxv70SQWdMJtiY/4y8higBBdgH80H1YO1Kz/jlkcL8OnU1apeZcExNdhTtFC7vYW1
         7i8uzPHmImJZpNEmgpn0ZPYmfLToXvJfk5zRgkuQjKIQykY0QvoLt6ekEwY5ysIhXYCM
         TNhuCcANv44QbGnyROBr1w5Ro3opUv3/hIruJjYHXooO2TrgSyHzbgUVa5EZFcYBcle2
         wwyw==
X-Gm-Message-State: AO0yUKVPBWfYIld+0cMTCzKdC9W9nsoYA4NxxZKnBnwKiHE31NVHKu5V
        p6wW2c0IjxkkCY48pyUdFrmu32qUEX/W+nChOmTmng==
X-Google-Smtp-Source: AK7set+BT4xEcKY+/uoaOL8KeVBJ3JdWu5Hu+B9F1sIYsvzfRdV29zePdKUttsi2e9i5g7od5M+1fBV0aszBSpO4YhA=
X-Received: by 2002:a05:6102:5599:b0:421:c4a3:b607 with SMTP id
 dc25-20020a056102559900b00421c4a3b607mr14816559vsb.3.1678337756090; Wed, 08
 Mar 2023 20:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com> <20230223145426.193590-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223145426.193590-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 9 Mar 2023 12:55:45 +0800
Message-ID: <CAGXv+5FAcySm3fC1oV9R7FYP0N1z95BaMHXGFJvhi0jDTbSXtg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: mediatek: cherry: Add platform thermal configuration
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:55=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This platform has three auxiliary NTC thermistors, connected to the
> SoC's ADC pins. Enable the auxadc in order to be able to read the
> ADC values, add a generic-adc-thermal LUT for each and finally assign
> them to the SoC's thermal zones.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195-cherry.dtsi
> index 24669093fbed..ae2052a7160d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -104,6 +104,108 @@ ppvar_sys: regulator-ppvar-sys {
>                 regulator-boot-on;
>         };
>
> +       tboard_thermistor1: thermal-sensor-t1 {
> +               compatible =3D "generic-adc-thermal";
> +               #thermal-sensor-cells =3D <0>;
> +               io-channels =3D <&auxadc 0>;
> +               io-channel-names =3D "sensor-channel";
> +               temperature-lookup-table =3D <    (-5000) 4241
> +                                               0 4063
> +                                               5000 3856
> +                                               10000 3621
> +                                               15000 3364
> +                                               20000 3091
> +                                               25000 2810
> +                                               30000 2526
> +                                               35000 2247
> +                                               40000 1982
> +                                               45000 1734
> +                                               50000 1507
> +                                               55000 1305
> +                                               60000 1122
> +                                               65000 964
> +                                               70000 827
> +                                               75000 710
> +                                               80000 606
> +                                               85000 519
> +                                               90000 445
> +                                               95000 382
> +                                               100000 330
> +                                               105000 284
> +                                               110000 245
> +                                               115000 213
> +                                               120000 183
> +                                               125000 161>;
> +       };
> +
> +       tboard_thermistor2: thermal-sensor-t2 {
> +               compatible =3D "generic-adc-thermal";
> +               #thermal-sensor-cells =3D <0>;
> +               io-channels =3D <&auxadc 0>;

You are reusing the same channel for all three sensors. That doesn't
make a lot of sense.

Furthermore, the design only has two thermistors, connected to the first
two ADC channels. The first one is located near the SoC; the second one
is near the PMIC.

ChenYu

> +               io-channel-names =3D "sensor-channel";
> +               temperature-lookup-table =3D <    (-5000) 4241
> +                                               0 4063
> +                                               5000 3856
> +                                               10000 3621
> +                                               15000 3364
> +                                               20000 3091
> +                                               25000 2810
> +                                               30000 2526
> +                                               35000 2247
> +                                               40000 1982
> +                                               45000 1734
> +                                               50000 1507
> +                                               55000 1305
> +                                               60000 1122
> +                                               65000 964
> +                                               70000 827
> +                                               75000 710
> +                                               80000 606
> +                                               85000 519
> +                                               90000 445
> +                                               95000 382
> +                                               100000 330
> +                                               105000 284
> +                                               110000 245
> +                                               115000 213
> +                                               120000 183
> +                                               125000 161>;
> +       };
> +
> +       tboard_thermistor3: thermal-sensor-t3 {
> +               compatible =3D "generic-adc-thermal";
> +               #thermal-sensor-cells =3D <0>;
> +               io-channels =3D <&auxadc 0>;
> +               io-channel-names =3D "sensor-channel";
> +               temperature-lookup-table =3D <    (-5000) 4241
> +                                               0 4063
> +                                               5000 3856
> +                                               10000 3621
> +                                               15000 3364
> +                                               20000 3091
> +                                               25000 2810
> +                                               30000 2526
> +                                               35000 2247
> +                                               40000 1982
> +                                               45000 1734
> +                                               50000 1507
> +                                               55000 1305
> +                                               60000 1122
> +                                               65000 964
> +                                               70000 827
> +                                               75000 710
> +                                               80000 606
> +                                               85000 519
> +                                               90000 445
> +                                               95000 382
> +                                               100000 330
> +                                               105000 284
> +                                               110000 245
> +                                               115000 213
> +                                               120000 183
> +                                               125000 161>;
> +       };
> +
>         usb_vbus: regulator-5v0-usb-vbus {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "usb-vbus";
> @@ -243,6 +345,10 @@ &gpu {
>         mali-supply =3D <&mt6315_7_vbuck1>;
>  };
>
> +&auxadc {
> +       status =3D "okay";
> +};
> +
>  &i2c0 {
>         status =3D "okay";
>
> @@ -1074,6 +1180,24 @@ mt6315_7_vbuck1: vbuck1 {
>         };
>  };
>
> +&thermal_zones {
> +       ap_ntc1 {
> +               polling-delay =3D <1000>;
> +               polling-delay-passive =3D <0>;
> +               thermal-sensors =3D <&tboard_thermistor1>;
> +       };
> +       ap_ntc2 {
> +               polling-delay =3D <1000>;
> +               polling-delay-passive =3D <0>;
> +               thermal-sensors =3D <&tboard_thermistor2>;
> +       };
> +       ap_ntc3 {
> +               polling-delay =3D <1000>;
> +               polling-delay-passive =3D <0>;
> +               thermal-sensors =3D <&tboard_thermistor3>;
> +       };
> +};
> +
>  &u3phy0 {
>         status =3D "okay";
>  };
> --
> 2.39.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
