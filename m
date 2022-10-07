Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30095F73F4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGFcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:32:01 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B9C90C9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 22:31:56 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id j2so1533207vkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNq4dcrPynbjDUY9NBAK0cAjdzUU7wUb0WdhYznSYVQ=;
        b=WUNskmoKUQucRJduGseQ3VKsAWVYCrmyme7UroKDBlcUl6wHhhdNsJfFgEvuNaVpdX
         RlQkG55xusHzVkcl0ZASciIKWVmRWq0mEUpRjAZiDY85ouyvF6+Yfbwp8koEA99LH28B
         FI/xQnypWhbM2L0Xcd8f0A+jST3g7Whrh8oRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNq4dcrPynbjDUY9NBAK0cAjdzUU7wUb0WdhYznSYVQ=;
        b=gBdXnX8o1zfkRmz4X8G0Zt7VMq3q+NjxRQ5GybunkXnxRxepLyX0xslZ/WA5Z2FO6u
         M9Luhpx/6BDr8Rj8WoIJF24lW1n04d1W6ErWqkYE8+Y0AnP1b+5zssmUrT2eLh9TskFU
         a/HG2n3HMCiWBUaKi0j3FVyjFz9nEXVcdH/viinCtTM38vZuHnMuJoQIOs8lm/kbuI4A
         ZOJh0xW3wguQGA0SCzpSL3az2TWvCqeD+uLNzOVuXvKLSkjoYRFRfR/Mm7S5un9Df5L+
         t/MeucLHPQ6Xi189cQaIsLwfqD1M+qxw7vMwSIZQ7xHhaM20Lw825opkyO0uMAEpN6Od
         5lpQ==
X-Gm-Message-State: ACrzQf2H5lm0t389AIrPWeKc34/J4fAcuxo1p6O8pzJlL68qYxoPww76
        JcyBpItshXSHTDj8lsGwuY89ZfBaWal28zwrkCiTJA==
X-Google-Smtp-Source: AMsMyM5JBgPDE4c1thYDVfNOz5HCCFIE7+5xlX7JfJPYpElINrVos0va5CgZHtsdqTUdT8hD3ImU3phN3RJdyZBLaGw=
X-Received: by 2002:a1f:9cc5:0:b0:3a2:bd20:8fc6 with SMTP id
 f188-20020a1f9cc5000000b003a2bd208fc6mr1835693vke.22.1665120715519; Thu, 06
 Oct 2022 22:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221006212528.103790-1-nfraprado@collabora.com> <20221006212528.103790-5-nfraprado@collabora.com>
In-Reply-To: <20221006212528.103790-5-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Oct 2022 13:31:43 +0800
Message-ID: <CAGXv+5Fz1f2tzxJzYZDtSiXA5H84aF9Uz1vC-dF=ALkNUA3uKQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: mediatek: asurada: Enable audio support
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Fri, Oct 7, 2022 at 5:25 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Enable audio support for the Asurada platform. This consists of the
> machine sound card, the rt1015p codec for the speakers, the rt5682 codec
> for the headset, and the dmic codec for the internal microphone.

It should be noted that there's a new revision of Hayato and Spherion
that switch to using the RT5682S codec. These are mt8192-hayato-rev5-sku2.d=
ts
and mt8192-spherion-rev4.dts in the downstream kernel.

ChenYu


> HDMI audio support is left out for now since the DisplayPort chip
> required isn't enabled yet.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added this commit
>
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 282 ++++++++++++++++++
>  1 file changed, 282 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index ace44827de17..dac2d4f5e670 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -33,6 +33,12 @@ backlight_lcd0: backlight-lcd0 {
>                 default-brightness-level =3D <576>;
>         };
>
> +       dmic_codec: dmic-codec {
> +               compatible =3D "dmic-codec";
> +               num-channels =3D <2>;
> +               wakeup-delay-ms =3D <50>;
> +       };
> +
>         pp1000_dpbrdg: regulator-1v0-dpbrdg {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "pp1000_dpbrdg";
> @@ -196,6 +202,79 @@ wifi_restricted_dma_region: wifi@c0000000 {
>                         reg =3D <0 0xc0000000 0 0x4000000>;
>                 };
>         };
> +
> +       rt1015p: rt1015p {
> +               compatible =3D "realtek,rt1015p";
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&rt1015p_pins>;
> +               sdb-gpios =3D <&pio 147 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells =3D <0>;
> +       };
> +
> +       sound: mt8192-sound {
> +               compatible =3D "mediatek,mt8192_mt6359_rt1015p_rt5682";
> +               mediatek,platform =3D <&afe>;
> +               pinctrl-names =3D "aud_clk_mosi_off",
> +                               "aud_clk_mosi_on",
> +                               "aud_dat_mosi_off",
> +                               "aud_dat_mosi_on",
> +                               "aud_dat_miso_off",
> +                               "aud_dat_miso_on",
> +                               "vow_dat_miso_off",
> +                               "vow_dat_miso_on",
> +                               "vow_clk_miso_off",
> +                               "vow_clk_miso_on",
> +                               "aud_nle_mosi_off",
> +                               "aud_nle_mosi_on",
> +                               "aud_dat_miso2_off",
> +                               "aud_dat_miso2_on",
> +                               "aud_gpio_i2s3_off",
> +                               "aud_gpio_i2s3_on",
> +                               "aud_gpio_i2s8_off",
> +                               "aud_gpio_i2s8_on",
> +                               "aud_gpio_i2s9_off",
> +                               "aud_gpio_i2s9_on",
> +                               "aud_dat_mosi_ch34_off",
> +                               "aud_dat_mosi_ch34_on",
> +                               "aud_dat_miso_ch34_off",
> +                               "aud_dat_miso_ch34_on",
> +                               "aud_gpio_tdm_off",
> +                               "aud_gpio_tdm_on";
> +               pinctrl-0 =3D <&aud_clk_mosi_off_pins>;
> +               pinctrl-1 =3D <&aud_clk_mosi_on_pins>;
> +               pinctrl-2 =3D <&aud_dat_mosi_off_pins>;
> +               pinctrl-3 =3D <&aud_dat_mosi_on_pins>;
> +               pinctrl-4 =3D <&aud_dat_miso_off_pins>;
> +               pinctrl-5 =3D <&aud_dat_miso_on_pins>;
> +               pinctrl-6 =3D <&vow_dat_miso_off_pins>;
> +               pinctrl-7 =3D <&vow_dat_miso_on_pins>;
> +               pinctrl-8 =3D <&vow_clk_miso_off_pins>;
> +               pinctrl-9 =3D <&vow_clk_miso_on_pins>;
> +               pinctrl-10 =3D <&aud_nle_mosi_off_pins>;
> +               pinctrl-11 =3D <&aud_nle_mosi_on_pins>;
> +               pinctrl-12 =3D <&aud_dat_miso2_off_pins>;
> +               pinctrl-13 =3D <&aud_dat_miso2_on_pins>;
> +               pinctrl-14 =3D <&aud_gpio_i2s3_off_pins>;
> +               pinctrl-15 =3D <&aud_gpio_i2s3_on_pins>;
> +               pinctrl-16 =3D <&aud_gpio_i2s8_off_pins>;
> +               pinctrl-17 =3D <&aud_gpio_i2s8_on_pins>;
> +               pinctrl-18 =3D <&aud_gpio_i2s9_off_pins>;
> +               pinctrl-19 =3D <&aud_gpio_i2s9_on_pins>;
> +               pinctrl-20 =3D <&aud_dat_mosi_ch34_off_pins>;
> +               pinctrl-21 =3D <&aud_dat_mosi_ch34_on_pins>;
> +               pinctrl-22 =3D <&aud_dat_miso_ch34_off_pins>;
> +               pinctrl-23 =3D <&aud_dat_miso_ch34_on_pins>;
> +               pinctrl-24 =3D <&aud_gpio_tdm_off_pins>;
> +               pinctrl-25 =3D <&aud_gpio_tdm_on_pins>;
> +
> +               headset-codec {
> +                   sound-dai =3D <&rt5682>;
> +               };
> +
> +               speaker-codecs {
> +                   sound-dai =3D <&rt1015p>;
> +               };
> +       };
>  };
>
>  &dsi0 {
> @@ -227,6 +306,19 @@ &i2c1 {
>         clock-frequency =3D <400000>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&i2c1_pins>;
> +
> +       rt5682: rt5682@1a {
> +               compatible =3D "realtek,rt5682i";
> +               reg =3D <0x1a>;
> +               interrupts-extended =3D <&pio 18 IRQ_TYPE_LEVEL_LOW>;
> +               realtek,jd-src =3D <1>;
> +               realtek,btndet-delay =3D <16>;
> +               #sound-dai-cells =3D <0>;
> +
> +               AVDD-supply =3D <&mt6359_vio18_ldo_reg>;
> +               MICVDD-supply =3D <&pp3300_g>;
> +               VBAT-supply =3D <&pp3300_ldo_z>;
> +       };
>  };
>
>  &i2c2 {
> @@ -660,6 +752,165 @@ pins-in {
>                 };
>         };
>
> +       aud_clk_mosi_off_pins: aud-clk-mosi-off-pins {
> +               pins-mosi-off {
> +                       pinmux =3D <PINMUX_GPIO214__FUNC_GPIO214>,
> +                                <PINMUX_GPIO215__FUNC_GPIO215>;
> +               };
> +       };
> +
> +       aud_clk_mosi_on_pins: aud-clk-mosi-on-pins {
> +               pins-mosi-on {
> +                       pinmux =3D <PINMUX_GPIO214__FUNC_AUD_CLK_MOSI>,
> +                                <PINMUX_GPIO215__FUNC_AUD_SYNC_MOSI>;
> +                       drive-strength =3D <10>;
> +               };
> +       };
> +
> +       aud_dat_miso_ch34_off_pins: aud-dat-miso-ch34-off-pins {
> +               pins-miso-off {
> +                       pinmux =3D <PINMUX_GPIO199__FUNC_GPIO199>;
> +               };
> +       };
> +
> +       aud_dat_miso_ch34_on_pins: aud-dat-miso-ch34-on-pins {
> +               pins-miso-on {
> +                       pinmux =3D <PINMUX_GPIO199__FUNC_AUD_DAT_MISO2>;
> +               };
> +       };
> +
> +       aud_dat_miso_off_pins: aud-dat-miso-off-pins {
> +               pins-miso-off {
> +                       pinmux =3D <PINMUX_GPIO218__FUNC_GPIO218>,
> +                                <PINMUX_GPIO219__FUNC_GPIO219>;
> +               };
> +       };
> +
> +       aud_dat_miso_on_pins: aud-dat-miso-on-pins {
> +               pins-miso-on {
> +                       pinmux =3D <PINMUX_GPIO218__FUNC_AUD_DAT_MISO0>,
> +                                <PINMUX_GPIO219__FUNC_AUD_DAT_MISO1>;
> +                       drive-strength =3D <10>;
> +               };
> +       };
> +
> +       aud_dat_miso2_off_pins: aud-dat-miso2-off-pins {
> +               pins-miso-off {
> +                       pinmux =3D <PINMUX_GPIO199__FUNC_GPIO199>;
> +               };
> +       };
> +
> +       aud_dat_miso2_on_pins: aud-dat-miso2-on-pins {
> +               pins-miso-on {
> +                       pinmux =3D <PINMUX_GPIO199__FUNC_AUD_DAT_MISO2>;
> +               };
> +       };
> +
> +       aud_dat_mosi_ch34_off_pins: aud-dat-mosi-ch34-off-pins {
> +               pins-mosi-off {
> +                       pinmux =3D <PINMUX_GPIO196__FUNC_GPIO196>;
> +               };
> +       };
> +
> +       aud_dat_mosi_ch34_on_pins: aud-dat-mosi-ch34-on-pins {
> +               pins-mosi-on {
> +                       pinmux =3D <PINMUX_GPIO196__FUNC_AUD_DAT_MOSI2>;
> +               };
> +       };
> +
> +       aud_dat_mosi_off_pins: aud-dat-mosi-off-pins {
> +               pins-mosi-off {
> +                       pinmux =3D <PINMUX_GPIO216__FUNC_GPIO216>,
> +                                <PINMUX_GPIO217__FUNC_GPIO217>;
> +               };
> +       };
> +
> +       aud_dat_mosi_on_pins: aud-dat-mosi-on-pins {
> +               pins-mosi-on {
> +                       pinmux =3D <PINMUX_GPIO216__FUNC_AUD_DAT_MOSI0>,
> +                                <PINMUX_GPIO217__FUNC_AUD_DAT_MOSI1>;
> +                       drive-strength =3D <10>;
> +               };
> +       };
> +
> +       aud_gpio_i2s3_off_pins: aud-gpio-i2s3-off-pins {
> +               pins-i2s3-off {
> +                       pinmux =3D <PINMUX_GPIO32__FUNC_GPIO32>,
> +                                <PINMUX_GPIO33__FUNC_GPIO33>,
> +                                <PINMUX_GPIO35__FUNC_GPIO35>;
> +               };
> +       };
> +
> +       aud_gpio_i2s3_on_pins: aud-gpio-i2s3-on-pins {
> +               pins-i2s3-on {
> +                       pinmux =3D <PINMUX_GPIO32__FUNC_I2S3_BCK>,
> +                                <PINMUX_GPIO33__FUNC_I2S3_LRCK>,
> +                                <PINMUX_GPIO35__FUNC_I2S3_DO>;
> +               };
> +       };
> +
> +       aud_gpio_i2s8_off_pins: aud-gpio-i2s8-off-pins {
> +               pins-i2s8-off {
> +                       pinmux =3D <PINMUX_GPIO10__FUNC_GPIO10>,
> +                                <PINMUX_GPIO11__FUNC_GPIO11>,
> +                                <PINMUX_GPIO12__FUNC_GPIO12>,
> +                                <PINMUX_GPIO13__FUNC_GPIO13>;
> +               };
> +       };
> +
> +       aud_gpio_i2s8_on_pins: aud-gpio-i2s8-on-pins {
> +               pins-i2s8-on {
> +                       pinmux =3D <PINMUX_GPIO10__FUNC_I2S8_MCK>,
> +                                <PINMUX_GPIO11__FUNC_I2S8_BCK>,
> +                                <PINMUX_GPIO12__FUNC_I2S8_LRCK>,
> +                                <PINMUX_GPIO13__FUNC_I2S8_DI>;
> +               };
> +       };
> +
> +       aud_gpio_i2s9_off_pins: aud-gpio-i2s9-off-pins {
> +               pins-i2s9-off {
> +                       pinmux =3D <PINMUX_GPIO29__FUNC_GPIO29>;
> +               };
> +       };
> +
> +       aud_gpio_i2s9_on_pins: aud-gpio-i2s9-on-pins {
> +               pins-i2s9-on {
> +                       pinmux =3D <PINMUX_GPIO29__FUNC_I2S9_DO>;
> +               };
> +       };
> +
> +       aud_gpio_tdm_off_pins: aud-gpio-tdm-off-pins {
> +               pins-tdm-off {
> +                       pinmux =3D <PINMUX_GPIO0__FUNC_GPIO0>,
> +                                <PINMUX_GPIO1__FUNC_GPIO1>,
> +                                <PINMUX_GPIO2__FUNC_GPIO2>,
> +                                <PINMUX_GPIO3__FUNC_GPIO3>;
> +               };
> +       };
> +
> +       aud_gpio_tdm_on_pins: aud-gpio-tdm-on-pins {
> +               pins-tdm-on {
> +                       pinmux =3D <PINMUX_GPIO0__FUNC_TDM_LRCK>,
> +                                <PINMUX_GPIO1__FUNC_TDM_BCK>,
> +                                <PINMUX_GPIO2__FUNC_TDM_MCK>,
> +                                <PINMUX_GPIO3__FUNC_TDM_DATA0>;
> +               };
> +       };
> +
> +       aud_nle_mosi_off_pins: aud-nle-mosi-off-pins {
> +               pins-nle-mosi-off {
> +                       pinmux =3D <PINMUX_GPIO197__FUNC_GPIO197>,
> +                                <PINMUX_GPIO198__FUNC_GPIO198>;
> +               };
> +       };
> +
> +       aud_nle_mosi_on_pins: aud-nle-mosi-on-pins {
> +               pins-nle-mosi-on {
> +                       pinmux =3D <PINMUX_GPIO197__FUNC_AUD_NLE_MOSI1>,
> +                                <PINMUX_GPIO198__FUNC_AUD_NLE_MOSI0>;
> +               };
> +       };
> +
>         cr50_int: cr50-irq-default-pins {
>                 pins-gsc-ap-int-odl {
>                         pinmux =3D <PINMUX_GPIO171__FUNC_GPIO171>;
> @@ -932,6 +1183,13 @@ pins-inhibit {
>                 };
>         };
>
> +       rt1015p_pins: rt1015p-default-pins {
> +               pins {
> +                       pinmux =3D <PINMUX_GPIO147__FUNC_GPIO147>;
> +                       output-low;
> +               };
> +       };
> +
>         scp_pins: scp-pins {
>                 pins-vreq-vao {
>                         pinmux =3D <PINMUX_GPIO195__FUNC_SCP_VREQ_VAO>;
> @@ -987,6 +1245,30 @@ pins-report-sw {
>                         output-low;
>                 };
>         };
> +
> +       vow_clk_miso_off_pins: vow-clk-miso-off-pins {
> +               pins-miso-off {
> +                       pinmux =3D <PINMUX_GPIO219__FUNC_GPIO219>;
> +               };
> +       };
> +
> +       vow_clk_miso_on_pins: vow-clk-miso-on-pins {
> +               pins-miso-on {
> +                       pinmux =3D <PINMUX_GPIO219__FUNC_VOW_CLK_MISO>;
> +               };
> +       };
> +
> +       vow_dat_miso_off_pins: vow-dat-miso-off-pins {
> +               pins-miso-off {
> +                       pinmux =3D <PINMUX_GPIO218__FUNC_GPIO218>;
> +               };
> +       };
> +
> +       vow_dat_miso_on_pins: vow-dat-miso-on-pins {
> +               pins-miso-on {
> +                       pinmux =3D <PINMUX_GPIO218__FUNC_VOW_DAT_MISO>;
> +               };
> +       };
>  };
>
>  &pmic {
> --
> 2.37.3
>
