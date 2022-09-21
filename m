Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B852A5BFFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIUOVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIUOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:20:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC76870A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:20:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd10so5635235ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+0L9+eR75Qih9B7js8i6qvLYG82sOJdIDqqwTjLBiIQ=;
        b=gBI8Il0wjJ4k9W8uDcY2WywCdYlFRc1TCFvzuNI+feU6F5t0q+zxJE36hFlqju4hy2
         K3hEiABSToSDcSynJH5Bz+GzyxT7TlJu8jRLKvTtesUiy/sbNFIpXCBFAWVDhjLJIIJH
         GxCFpmeZ/71CS5p5Hm1xwpER1PCxCjh4/NqMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+0L9+eR75Qih9B7js8i6qvLYG82sOJdIDqqwTjLBiIQ=;
        b=p+RB69xQMzCD10cPb9CGnNqJLzFtgRVUtG7Rt9BKlMGWwT4BwyedPmGP0YaYW7UikN
         +s/F3gkS2Cu4V421XBxqVT+crCJTYkefkdlc9BeAlpQf6GkZTCc/9KXPnmbmetKFYR1A
         YbhEFWEF12WvZMhg7BGgCiOWpeG/ZgnSpb4nimxJwAtdzbz7XXkYbLdHdAKQKEDsuj9t
         wobl6hYnio5H8X376NEHzJZTtiJwD2Ug0iOY54kUhR/PBEt+AETvpSG49Y+SSzlEzJPX
         0WIZ4trc22iEBZCSqpMhcJ1pgymTmcAUGvlmdvmRmJytV423YLqSvlo5WErEgwa4htE/
         mqwg==
X-Gm-Message-State: ACrzQf12X+MX2E/MHkvE7K+bePkFKpIU5kg1lR1+K3z/ULLB892K7UVF
        IVy/2AnNrv8DrynScFfAfhCO3JFaulUeWy3I5FwIIg==
X-Google-Smtp-Source: AMsMyM5/L+7UhSWc2DAc+lhVwYvbNwvoBs8veYUQz8kxwfOWmWK0C/jE27btL5ZxCDIBgKX69XN3rLhPSpA/NJMdfzU=
X-Received: by 2002:a17:907:7f93:b0:781:dbee:dece with SMTP id
 qk19-20020a1709077f9300b00781dbeedecemr5468821ejc.323.1663770054748; Wed, 21
 Sep 2022 07:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220908171153.670762-1-nfraprado@collabora.com> <20220908171153.670762-2-nfraprado@collabora.com>
In-Reply-To: <20220908171153.670762-2-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 21 Sep 2022 22:20:43 +0800
Message-ID: <CAGXv+5FErSBT-t6vz_2naApuPoC4PympWft-9Gd_MMPUTN+CsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: asurada: Add display regulators
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 9, 2022 at 1:12 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add the regulators present on the Asurada platform that are used to
> power the internal and external displays.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index 4b314435f8fd..1d99e470ea1a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -23,6 +23,42 @@ memory@40000000 {
>                 reg =3D <0 0x40000000 0 0x80000000>;
>         };
>
> +       pp1000_dpbrdg: regulator-1v0-dpbrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp1000_dpbrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp1000_dpbrdg_en_pins>;
> +               regulator-min-microvolt =3D <1000000>;
> +               regulator-max-microvolt =3D <1000000>;

This is fed by a rail called PP1350_VS2, which is from the MT6359 PMIC.
And this regulator is a proper LDO.

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 19 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       pp1000_mipibrdg: regulator-1v0-mipibrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp1000_mipibrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp1000_mipibrdg_en_pins>;
> +               regulator-min-microvolt =3D <1000000>;
> +               regulator-max-microvolt =3D <1000000>;

This is fed by a rail called PP1350_VS2, which is from the MT6359 PMIC.
And this regulator is a proper LDO.

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 129 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       pp1800_dpbrdg: regulator-1v8-dpbrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp1800_dpbrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp1800_dpbrdg_en_pins>;
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;

This regulator is only a power switch. Please drop the min/max properties.
This is fed by a rail called PP1800_VIO18_U, which is from an LDO on the
MT6359 PMIC.

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 126 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         /* system wide LDO 1.8V power rail */
>         pp1800_ldo_g: regulator-1v8-g {
>                 compatible =3D "regulator-fixed";
> @@ -34,6 +70,30 @@ pp1800_ldo_g: regulator-1v8-g {
>                 vin-supply =3D <&pp3300_g>;
>         };
>
> +       pp1800_mipibrdg: regulator-1v8-mipibrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp1800_mipibrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp1800_mipibrdg_en_pins>;
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;

This regulator is only a power switch. Please drop the min/max properties.
This is fed by a rail called PP1800_VIO18_U, which is from an LDO on the
MT6359 PMIC.

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 128 GPIO_ACTIVE_HIGH>;
> +       };
> +
> +       pp3300_dpbrdg: regulator-3v3-dpbrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp3300_dpbrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp3300_dpbrdg_en_pins>;
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;

This regulator is only a power switch. Please drop the min/max properties.
This is fed by a rail called PP3300_G, which is already described below.

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 26 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         /* system wide switching 3.3V power rail */
>         pp3300_g: regulator-3v3-g {
>                 compatible =3D "regulator-fixed";
> @@ -56,6 +116,18 @@ pp3300_ldo_z: regulator-3v3-z {
>                 vin-supply =3D <&ppvar_sys>;
>         };
>
> +       pp3300_mipibrdg: regulator-3v3-mipibrdg {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp3300_mipibrdg";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pp3300_mipibrdg_en_pins>;
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;

This regulator is only a power switch. Please drop the min/max properties.
This is fed by a rail called PP3300_G, which is already described above.

ChenYu

> +               enable-active-high;
> +               regulator-boot-on;
> +               gpio =3D <&pio 127 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         /* separately switched 3.3V power rail */
>         pp3300_u: regulator-3v3-u {
>                 compatible =3D "regulator-fixed";
> @@ -719,6 +791,48 @@ pins-wifi-kill {
>                 };
>         };
>
> +       pp1000_dpbrdg_en_pins: pp1000-dpbrdg-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO19__FUNC_GPIO19>;
> +                       output-low;
> +               };
> +       };
> +
> +       pp1000_mipibrdg_en_pins: pp1000-mipibrdg-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO129__FUNC_GPIO129>;
> +                       output-low;
> +               };
> +       };
> +
> +       pp1800_dpbrdg_en_pins: pp1800-dpbrdg-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO126__FUNC_GPIO126>;
> +                       output-low;
> +               };
> +       };
> +
> +       pp1800_mipibrdg_en_pins: pp1800-mipibrd-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO128__FUNC_GPIO128>;
> +                       output-low;
> +               };
> +       };
> +
> +       pp3300_dpbrdg_en_pins: pp3300-dpbrdg-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO26__FUNC_GPIO26>;
> +                       output-low;
> +               };
> +       };
> +
> +       pp3300_mipibrdg_en_pins: pp3300-mipibrdg-en-pins {
> +               pins-en {
> +                       pinmux =3D <PINMUX_GPIO127__FUNC_GPIO127>;
> +                       output-low;
> +               };
> +       };
> +
>         pp3300_wlan_pins: pp3300-wlan-pins {
>                 pins-pcie-en-pp3300-wlan {
>                         pinmux =3D <PINMUX_GPIO143__FUNC_GPIO143>;
> --
> 2.37.3
>
