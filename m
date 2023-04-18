Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251E36E6009
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDRLio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjDRLil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:38:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A7B86AD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:38:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34a14a54so663802066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681817896; x=1684409896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WGHQ4pweNGFtMFZrNERPvaF8bW/gfHqLJ3MdOLvojw=;
        b=3mZQM680g0A4oB1bUKqA10kScudEElxU2M7gQ1uvBHeX69gO2MxAZ0Agmm4SNRZbqk
         qdK9Lx2i/qXcIaueNhcKnXaR312LCujuN6wB9Q1E7S1a+2LThlnsIUIFv+N2x0wNub46
         9iDZEsBM1xd9gjcERF8PzUh8ev8oEK9IFLwn6SiTFZ5/DABvohDm9FKNxE9gVshIPqtR
         UqBS9/6ZfdEM/U/8fbEsR5MuKdMyA5v9HksOhXKPnKDd7/POMnjecbKl4AxlwKcBmEX2
         Nz68Fj4vDLcEmPq3lhtW5m9au0njJiEi4yCJv+aS70X+p8b2aYD//l4P4fvHBOinGBT4
         cZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817896; x=1684409896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WGHQ4pweNGFtMFZrNERPvaF8bW/gfHqLJ3MdOLvojw=;
        b=WhOftUsDekTxtWbA5jby3uKgjN88agwWwrDbHZ1it523V0KGH+6i7/dyfgs1rEC8wU
         CtrsM0nKj/RmjFCVfOVeqV+hj1CdQIc+3wx2uBngQVjzZKzqKzT176da287juJaCHzYu
         iV/VIebenJJkeDwUUUkV6+w5vmIVlYH/7d8DW5sZAgJf7bX5ZIh7bgBqtD8CEnQqvyVF
         9tDpLKOkn2Q7lPiYTknZKVjHvLp1M4UW40VfzmEqVnzjAXfgOpn0Llt4zQlRc7aA44DC
         KO6MGvc/s9GYvZ+xvaGk6yF1qcpMX8xJ9Xb4J+hjymbBuckMrdMLHXUPJWhvF53hstYc
         V+4A==
X-Gm-Message-State: AAQBX9fwazRtjU8aKYGW2oRajByY7qSWeQlSqIuWM/JFlEwAPUY2m16d
        NvWNit1uRS208bjt5d/oMTViC8w/N0yOqFYGxEEtiw==
X-Google-Smtp-Source: AKy350bxplDJsnCYTxx+swlOy0CuJ8Mz3uz9/H8MY7xPsfi1oVIkmtQZ/ETJiRYiVhn57K0pafXhmOVzHZQ3zZIpUz8=
X-Received: by 2002:aa7:db97:0:b0:501:d43e:d1e5 with SMTP id
 u23-20020aa7db97000000b00501d43ed1e5mr1682237edt.2.1681817895745; Tue, 18 Apr
 2023 04:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230405100907.53740-1-bchihi@baylibre.com>
In-Reply-To: <20230405100907.53740-1-bchihi@baylibre.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 18 Apr 2023 13:37:41 +0200
Message-ID: <CAGuA+orohjh8YrO18jAntZif-OyYOkzMQEAOjC8_X2wUqEfckw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 12:09=E2=80=AFPM <bchihi@baylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add AP Domain thermal zones for the mt8195 and
> specify the targeted temperature thresholds.
>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>
> ---
> This patch squashes and replaces
>
> [PATCH 3/4] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
> https://lore.kernel.org/all/20230307154524.118541-4-bchihi@baylibre.com/
>
> and
>
> [PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain temperature thres=
holds
> https://lore.kernel.org/all/20230307154524.118541-5-bchihi@baylibre.com/
>
> of the series
>
> [PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
> https://lore.kernel.org/all/20230307154524.118541-1-bchihi@baylibre.com/
> ---
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 180 +++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index 972c5b86ddae..75da456c512b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2909,5 +2909,185 @@ map0 {
>                                 };
>                         };
>                 };
> +
> +               vpu0-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_VPU0>;
> +
> +                       trips {
> +                               vpu0_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               vpu0_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               vpu1-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_VPU1>;
> +
> +                       trips {
> +                               vpu1_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               vpu1_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               gpu0-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_GPU0>;
> +
> +                       trips {
> +                               gpu0_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               gpu0_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               gpu1-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_GPU1>;
> +
> +                       trips {
> +                               gpu1_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               gpu1_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               vdec-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_VDEC>;
> +
> +                       trips {
> +                               vdec_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               vdec_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               img-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_IMG>;
> +
> +                       trips {
> +                               img_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               img_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               infra-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_INFRA>;
> +
> +                       trips {
> +                               infra_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               infra_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               cam0-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_CAM0>;
> +
> +                       trips {
> +                               cam0_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               cam0_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
> +
> +               cam1-thermal {
> +                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <250>;
> +                       thermal-sensors =3D <&lvts_ap MT8195_AP_CAM1>;
> +
> +                       trips {
> +                               cam1_alert: trip-alert {
> +                                       temperature =3D <85000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "passive";
> +                               };
> +
> +                               cam1_crit: trip-crit {
> +                                       temperature =3D <100000>;
> +                                       hysteresis =3D <2000>;
> +                                       type =3D "critical";
> +                               };
> +                       };
> +               };
>         };
>  };
> --
> 2.34.1
>

Hello Matthias,

Is there any news about this patch?

Best regards,
Balsam
