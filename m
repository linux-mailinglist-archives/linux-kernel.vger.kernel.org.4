Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4686EA42D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDUG5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDUG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:57:39 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740119B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:57:38 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-76dae081228so733267241.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682060257; x=1684652257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJKGDTicdDOydwAyS5XLugqVzczoGrGZVxyOPeyI0mE=;
        b=Idit8eCqCgTG3r3YDXJ4riHvsH9dFKDnOm4WUrpndwWlD5IUcVzFvKa9odfDNhtPfP
         1aco9mVjUHcqvupq4gv2tRpyTSeCR91veQ0NNgA6NppySxMU22vOB4DF3UhsVTL5PeiF
         46bvAdmy4tRKYKlptuX6lbpjqLIh+0srq8WnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682060257; x=1684652257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJKGDTicdDOydwAyS5XLugqVzczoGrGZVxyOPeyI0mE=;
        b=h67HvMdIjUBGehGJuRsIEGYPiTT7Yg9Aq3xCHaJjd4ITj/D/0l/oEs6+GOBMZtTmOz
         b46JsOYhKfHTNkgzyAFKS3o2qoqHSMR8zjGgOIUEWiICXu+fSw2dVdEHRoszGB5XwHEr
         yaz4cPFfj4lIceC4R7IbBXuS0w7rrGbMiNPLBgGSP03bfEqMbTLEdwke7TEU0A+/HvbL
         l/5U6urpB1XOJc2/xg2WY+COr/fgkDQ29yAHBiBGH+epC7N/6MQQY6NRLNAmFtb4mZJm
         382Mi1+Sjc00Qsm8dLJWeh9UL7c8ntCiAD/SkBIKD6TLvOZQ8NCMoVB11bbwexZh2rbx
         UKmA==
X-Gm-Message-State: AAQBX9f6zsH7Ge9Jo/ajDMM5nJrpGoU5VdJJv57EZAK4vuwfryvdefPs
        FvHGms/KmtkxdrHCtttsj2e3c0DZC3ywfK/67/m5ag==
X-Google-Smtp-Source: AKy350baBuLFoDL6dTLHo8N9DcJGnnvarEUOSLvi+u2GONsBq5/4u9NgF9Gejms6x5qeKN4B4rq7fak2/O9S3xQEQDE=
X-Received: by 2002:a1f:4349:0:b0:43f:cc0e:6eae with SMTP id
 q70-20020a1f4349000000b0043fcc0e6eaemr533384vka.10.1682060257462; Thu, 20 Apr
 2023 23:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com> <20230420094433.42794-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230420094433.42794-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 21 Apr 2023 14:57:26 +0800
Message-ID: <CAGXv+5GXuvw+o=JEjLP+hkKzL=stzmEHWZ18N2RJDbcWeioxnQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: mediatek: cherry: Configure eDP and
 internal display
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add the required nodes to enable the DisplayPort interface, connected
> to the Embedded DisplayPort port, where we have an internal display.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195-cherry.dtsi
> index 918380697a9a..46f1c8091498 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -49,6 +49,18 @@ memory@40000000 {
>                 reg =3D <0 0x40000000 0 0x80000000>;
>         };
>
> +       pp3300_disp_x: regulator-pp3300-disp-x {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp3300_disp_x";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;

From the schematics:
                  vin-supply =3D <&pp3300_z2>;

Also, this is an RT9742. The datasheet says the typical enable time is
2.1ms. For a bit of margin, I'd say we could model it as 2.5ms? So:

                  regulator-enable-ramp-delay =3D <2500>;

ChenYu

> +               enable-active-high;
> +               gpio =3D <&pio 55 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&panel_fixed_pins>;
> +               regulator-always-on;
> +       };
> +
>         /* system wide LDO 3.3V power rail */
>         pp3300_z5: regulator-pp3300-ldo-z5 {
>                 compatible =3D "regulator-fixed";
> @@ -290,6 +302,20 @@ port@1 {
>                         reg =3D <1>;
>                         edp_out: endpoint {
>                                 data-lanes =3D <0 1 2 3>;
> +                               remote-endpoint =3D <&panel_in>;
> +                       };
> +               };
> +       };
> +
> +       aux-bus {
> +               panel {
> +                       compatible =3D "edp-panel";
> +                       power-supply =3D <&pp3300_disp_x>;
> +                       backlight =3D <&backlight_lcd0>;
> +                       port {
> +                               panel_in: endpoint {
> +                                       remote-endpoint =3D <&edp_out>;
> +                               };
>                         };
>                 };
>         };
> @@ -929,6 +955,12 @@ pins-cs {
>                 };
>         };
>
> +       panel_fixed_pins: panel-pwr-default-pins {
> +               pins-vreg-en {
> +                       pinmux =3D <PINMUX_GPIO55__FUNC_GPIO55>;
> +               };
> +       };
> +
>         pio_default: pio-default-pins {
>                 pins-wifi-enable {
>                         pinmux =3D <PINMUX_GPIO58__FUNC_GPIO58>;
> --
> 2.40.0
>
>
