Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2D6A189F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBXJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:20:06 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D581164A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:20:04 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id s1so4182757vsk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIErPNQ+4RoTAfxtc85oSdGiGvNY8d2XkblliVRlj88=;
        b=EsI3t1aKn2uzy3PhReMsj8zr61m1aWNI3Jz88PBVgpknHdWQYwDZpuIXUzjLx4i3Gg
         tAJ+H5isQMGJBnLvGprO+qOkHkolourLmBAuf3jyjbjVTR60xA44119U3YqbjTiv8SKv
         R0xAxsZFmysFWhi4Z6FWtgJCpbVhmqxgn0vU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIErPNQ+4RoTAfxtc85oSdGiGvNY8d2XkblliVRlj88=;
        b=lGvaPdwgKpDFaF/6DdxXO3wyIr+/fDTI7CWjyvDY5qV/+iJLD4aswzu1/9WpQMPI/S
         jiq55Qa+7REuTEZLb5ItsHuc73zMmf8dvEwU2AbcBykuZr9yezeGHvIAyetcuFn2hCxx
         oXDd+9RT3R3ER1soSzvzTrHt9dEWOQZolNAMrzKhEHT66NmDOrB6mgCWNnKxfx1vA+GI
         u3Dtps+Qkd1xv3elDwaKCe+8TZ00GBzeZY3rlf5y0lLlGShg+WkmxLeTqchOkwM9uEYc
         n4YDuW+PnnRfe7g7uzF3O9HFak3qsUVPcWtKXe1lnnBTIi0bVgFxGYj//+ffOBplBBDR
         poZw==
X-Gm-Message-State: AO0yUKVpkR4wYpk7NJ9dVgGmJ+9DCxm54aM2fJGJzs8qPQ4S2iv57WOb
        +ZDK4vK/TirIh9gDn+v0Hw3vhx6023TNob3o3xqCgw==
X-Google-Smtp-Source: AK7set/4I7NL/6Fx/a0lveJQyrNy6DQ6pD3eAfVaTlWQEZeaGIbAFetGOErsZ6Sbu6SQVD0aUWpjuLbzx6uZl1JQPAE=
X-Received: by 2002:a05:6102:1592:b0:412:5424:e58e with SMTP id
 g18-20020a056102159200b004125424e58emr2324416vsv.0.1677230403544; Fri, 24 Feb
 2023 01:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20230223145426.193590-1-angelogioacchino.delregno@collabora.com> <20230223145426.193590-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223145426.193590-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:19:52 +0800
Message-ID: <CAGXv+5E5T3hWs1M2D8QL2SGXYfsevaEw7gzK8XgD2ns2Cx_G9A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: mediatek: cherry: Add platform thermal configuration
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:55 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This platform has three auxiliary NTC thermistors, connected to the
> SoC's ADC pins. Enable the auxadc in order to be able to read the
> ADC values, add a generic-adc-thermal LUT for each and finally assign
> them to the SoC's thermal zones.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 24669093fbed..ae2052a7160d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -104,6 +104,108 @@ ppvar_sys: regulator-ppvar-sys {
>                 regulator-boot-on;
>         };
>
> +       tboard_thermistor1: thermal-sensor-t1 {
> +               compatible = "generic-adc-thermal";
> +               #thermal-sensor-cells = <0>;
> +               io-channels = <&auxadc 0>;
> +               io-channel-names = "sensor-channel";
> +               temperature-lookup-table = <    (-5000) 4241
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
> +               compatible = "generic-adc-thermal";
> +               #thermal-sensor-cells = <0>;
> +               io-channels = <&auxadc 0>;
> +               io-channel-names = "sensor-channel";
> +               temperature-lookup-table = <    (-5000) 4241
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
> +               compatible = "generic-adc-thermal";
> +               #thermal-sensor-cells = <0>;
> +               io-channels = <&auxadc 0>;
> +               io-channel-names = "sensor-channel";
> +               temperature-lookup-table = <    (-5000) 4241
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
>                 compatible = "regulator-fixed";
>                 regulator-name = "usb-vbus";
> @@ -243,6 +345,10 @@ &gpu {
>         mali-supply = <&mt6315_7_vbuck1>;
>  };
>
> +&auxadc {
> +       status = "okay";
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> @@ -1074,6 +1180,24 @@ mt6315_7_vbuck1: vbuck1 {
>         };
>  };
>
> +&thermal_zones {
> +       ap_ntc1 {
> +               polling-delay = <1000>;
> +               polling-delay-passive = <0>;
> +               thermal-sensors = <&tboard_thermistor1>;

Without trip points, this doesn't satisfy the bindings, nor does the
driver probe.

> +       };
> +       ap_ntc2 {
> +               polling-delay = <1000>;
> +               polling-delay-passive = <0>;
> +               thermal-sensors = <&tboard_thermistor2>;
> +       };
> +       ap_ntc3 {
> +               polling-delay = <1000>;
> +               polling-delay-passive = <0>;
> +               thermal-sensors = <&tboard_thermistor3>;
> +       };
> +};
> +
>  &u3phy0 {
>         status = "okay";
>  };
> --
> 2.39.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
