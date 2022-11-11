Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74486625E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiKKPWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiKKPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:21:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DEB12D39
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:20:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ft34so13172950ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8E9Cs3yaXWgz5mOChIlIQoUDfwsWjoZPtNVw+9K0m3M=;
        b=mmcX345GCDy3+LQ6q+Pzy0ZCoNRRPkcF3ifoBsQAl68YLYZ10/NiQVgutItk1xYMaL
         7IpvVyhFokDN+fcDLMgYYQQvESiT1V94tZbiKwBnIwhS5k7dciPLhbow33wC0dcD1Hse
         g1yCT9x2epWf+2mHnesm6kOmE5FS0XjWFyzeqBNezQPZijMZLOh5LBRB2mr5qzqMyKkT
         Zc7VZjiPmDYc60LEcsLoRmTX71rq7dzSQziWDaMazdAaLxHE8bm0EvGaiARlfQnCs+sG
         TLD2wzWUqo4dnNQ2byCnVQEndzseTqwfeKlho10WOkqYgpJ0hHVFAdrwaABZFsnrm2ON
         qbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E9Cs3yaXWgz5mOChIlIQoUDfwsWjoZPtNVw+9K0m3M=;
        b=WWA3LuZmJLGRch/NQ0kfDGo1YMHLFCEa1QPaLGR9qBqn6XJKDYEbUFJCdK+PvAUKX5
         1p2PuoIbfdBFFFNSE+EVrtTS1m4sMSEmCt1OBxE4nVQObHlSfvL4Z+ZoXUxnk3BfCO3/
         Ec97gEOU0f1PkE+VKS0z+46PQg8v9pfJRw/LJEkMnffsaVoDIw7PlBuPi0VmWoAReK4d
         ok1PgBnReXh/KxY6YOZYTdXvIv2Pw/8zJgjoaeFPRQO1xQw+lO1fxGgOMmNrLkNtVNE1
         2pk3iMmKNhrJDaHG8LJ1Kus5gbJo/Mi6J4Tc8crtpBItaWqrr4DK4RTA1MuZsJZofY3J
         g8Sg==
X-Gm-Message-State: ANoB5pmxzoQ5yDHuV8/VYY/SYanRG81zIiwl6BRSQ/g05IuZZzFBL1o7
        52jYOu550JeULEzVuTT7q/uG0m+XcT67G5OxO56Klw==
X-Google-Smtp-Source: AA0mqf5F1dF3oI4lEMZel6lUNLdl92gcf9qtQZbBA0ZEZW8n4zJvZRo9IKm7wRimlZusvKqtya6WCuvYLzPh4/aStTM=
X-Received: by 2002:a17:906:2ecf:b0:778:f9b6:6fc with SMTP id
 s15-20020a1709062ecf00b00778f9b606fcmr2245177eji.580.1668180051848; Fri, 11
 Nov 2022 07:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-10-robert.foss@linaro.org> <408b7b0c-ce30-134e-9b1f-f77c1f03f5c9@linaro.org>
In-Reply-To: <408b7b0c-ce30-134e-9b1f-f77c1f03f5c9@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 11 Nov 2022 16:20:40 +0100
Message-ID: <CAG3jFytHzSNohr85R_uOHqn6eeour37c4=MXkaS=0JzKK4-z9Q@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc
 dsi-hdmi bridge
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 at 00:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2022 08:08, Robert Foss wrote:
> > The sm8350-hdk ships with the LT9611 UXC DSI/HDMI bridge chip.
> >
> > In order to toggle the board to enable the HDMI output,
> > switch #7 & #8 on the rightmost multi-switch package have
> > to be toggled to On.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 106 ++++++++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > index 6e07feb4b3b2..6666b38b58f8 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> > @@ -20,6 +20,17 @@ chosen {
> >               stdout-path = "serial0:115200n8";
> >       };
> >
> > +     hdmi-out {
>
> Generic node names, so hdmi-connector or just connector.

Ack.

>
> > +             compatible = "hdmi-connector";
> > +             type = "a";
> > +
> > +             port {
> > +                     hdmi_con: endpoint {
> > +                             remote-endpoint = <&lt9611_out>;
> > +                     };
> > +             };
> > +     };
> > +
> >       vph_pwr: vph-pwr-regulator {
> >               compatible = "regulator-fixed";
> >               regulator-name = "vph_pwr";
> > @@ -29,6 +40,32 @@ vph_pwr: vph-pwr-regulator {
> >               regulator-always-on;
> >               regulator-boot-on;
> >       };
> > +
> > +     lt9611_1v2: lt9611-1v2 {
>
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Ack.

>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "LT9611_1V2";
> > +
> > +             vin-supply = <&vph_pwr>;
> > +             regulator-min-microvolt = <1200000>;
> > +             regulator-max-microvolt = <1200000>;
> > +             gpio = <&tlmm 49 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +     };
> > +
> > +     lt9611_3v3: lt9611-3v3 {
>
> Ditto

Ack.

>
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "LT9611_3V3";
> > +
> > +             vin-supply = <&vreg_bob>;
> > +             gpio = <&tlmm 47 GPIO_ACTIVE_HIGH>;
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             enable-active-high;
> > +             regulator-boot-on;
> > +             regulator-always-on;
> > +     };
> >  };
> >
> >  &adsp {
> > @@ -220,6 +257,15 @@ &dispcc {
> >  &dsi0 {
> >       status = "okay";
> >       vdda-supply = <&vreg_l6b_1p2>;
> > +
> > +     ports {
> > +             port@1 {
> > +                     endpoint {
> > +                             remote-endpoint = <&lt9611_a>;
> > +                             data-lanes = <0 1 2 3>;
> > +                     };
> > +             };
> > +     };
> >  };
> >
> >  &dsi0_phy  {
> > @@ -231,6 +277,48 @@ &gpi_dma1 {
> >       status = "okay";
> >  };
> >
> > +&i2c15 {
> > +     status = "okay";
>
> status is the last property

Ack.

>
> > +     clock-frequency = <400000>;
> > +
> > +     lt9611_codec: hdmi-bridge@2b {
> > +             compatible = "lontium,lt9611uxc";
> > +             reg = <0x2b>;
> > +             status = "okay";
>
> Why status?

It should be removed. Fixing in v2.

>
> > +
> > +             interrupts-extended = <&tlmm 50 IRQ_TYPE_EDGE_FALLING>;
> > +             reset-gpios = <&tlmm 48 GPIO_ACTIVE_HIGH>;
> > +
> > +             vdd-supply = <&lt9611_1v2>;
> > +             vcc-supply = <&lt9611_3v3>;
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
> > +
> > +             ports {
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> > +                     port@0 {
> > +                             reg = <0>;
> > +
> > +                             lt9611_a: endpoint {
> > +                                     remote-endpoint = <&dsi0_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@2 {
> > +                             reg = <2>;
> > +
> > +                             lt9611_out: endpoint {
> > +                                     remote-endpoint = <&hdmi_con>;
> > +                             };
> > +                     };
> > +
>
> No need for blank line

Ack

>
> > +             };
> > +     };
> > +};
> > +
> >  &mdss {
> >       status = "okay";
> >  };
> > @@ -248,6 +336,10 @@ &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > +&qupv3_id_2 {
> > +     status = "okay";
> > +};
> > +
> >  &slpi {
> >       status = "okay";
> >       firmware-name = "qcom/sm8350/slpi.mbn";
> > @@ -544,4 +636,18 @@ usb_hub_enabled_state: usb-hub-enabled-state {
> >               drive-strength = <2>;
> >               output-low;
> >       };
> > +
> > +     lt9611_rst_pin: lt9611-rst-state {
> > +             pins = "gpio48";
> > +             function = "normal";
> > +
> > +             output-high;
> > +             input-disable;
> > +     };
> > +
> > +     lt9611_irq_pin: lt9611-irq {
>
> Missing suffix 'state'.

Ack.

>
> Does not look like you tested the DTS against bindings. Please run `make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).

v1 was missing the bindings, v2 will include bindings for there parts.

>
> Rebase your changes on last linux-next.

Ack.

>
> Best regards,
> Krzysztof
>
