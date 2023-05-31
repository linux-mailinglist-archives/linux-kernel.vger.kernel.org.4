Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865B717889
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEaHpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjEaHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:45:20 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DAB113
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:45:19 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-456fa6f1f79so1599978e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685519118; x=1688111118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWRIv7ahwL+JVt40YGh2V+e+QRGkb/3rzTT1hhmniWo=;
        b=JHcGb3jqfdzeEPXj3RBeei+OqeOA4cy537d2XrfvMglw1E//7aPkV7C1Rf57VQrraV
         Fr6FBCsz3VhF3QiR3PaMMHxq0WrBrXuD0DQqmMqwWMr3NJZw76ILzOPXRpeYanlPBzoG
         bEw/PQDaQQiGd9H4j7jbuT61Dg49CyT/34Qwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519118; x=1688111118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWRIv7ahwL+JVt40YGh2V+e+QRGkb/3rzTT1hhmniWo=;
        b=Uy8B4u8VtdDm2yZK6YEdQm1KQxB1mkmg2WHg3QlwbxDRyT5xN7zsOMV68IRU2msT7g
         5LRJ3QSRNHNewbkm9MsB/CAo5tilUSu34R/DOXd4gURfNjalR8tmTQJeO1ckMVmwSF/Q
         UF8yLiat4++KKjYZyqjCcuV2Hd6RiuoHCN45JGXTdk73M5ujdmonXsphWsZW7k5cNBPq
         FO/l7jInJ9TR90ZWh1aKH2ZmZ3BUmvXTauCUQafgfGDdCjz+PTvXMSRZhkWNqZim+OcZ
         newWI9rJXsYjl/xsC+vP7fF1VGNmP7W9AS+YBM3eX6nlVhTiqncyMzVgqN52t3Y+3mhP
         XpcQ==
X-Gm-Message-State: AC+VfDxINCAZU1L4g5wMnGdWOyE6o71YsaN+KLCES3DQbI6jQcIDNbsy
        U3WLMikElDj72HVVocLjfGFPiq7OOLbrZoBvoPFhSQ==
X-Google-Smtp-Source: ACHHUZ6yCTtFZ55WQ/KfJtVO0V1vLqGmehSeEHzWpEOQlxEK0cS7uF4ewxo8rtL7EZyMT4ejaOmPFCtP8oonb1HbHCo=
X-Received: by 2002:a05:6102:3015:b0:437:df4f:ac81 with SMTP id
 s21-20020a056102301500b00437df4fac81mr1624221vsa.29.1685519118389; Wed, 31
 May 2023 00:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230530195132.2286163-1-bero@baylibre.com> <20230530195132.2286163-5-bero@baylibre.com>
In-Reply-To: <20230530195132.2286163-5-bero@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 31 May 2023 15:45:07 +0800
Message-ID: <CAGXv+5H5uqy362Ums3Se-bwgdDvHsfiZUUOW1g4i1-krKLaq0A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] arm64: dts: mediatek: mt8192: Add thermal nodes
 and thermal zones
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:51=E2=80=AFAM Bernhard Rosenkr=C3=A4nzer <bero@ba=
ylibre.com> wrote:
>
> From: Balsam CHIHI <bchihi@baylibre.com>
>
> Add thermal nodes and thermal zones for the mt8192.
> The mt8192 SoC has several hotspots around the CPUs.
> Specify the targeted temperature threshold to apply the mitigation
> and define the associated cooling devices.
>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> [bero@baylibre.com: cosmetic changes, reduce lvts_ap size]
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 454 +++++++++++++++++++++++
>  1 file changed, 454 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8192.dtsi
> index 65bc8b4046211..82d6629e38c26 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -14,6 +14,8 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8192-power.h>
>  #include <dt-bindings/reset/mt8192-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>
>  / {
>         compatible =3D "mediatek,mt8192";
> @@ -71,6 +73,7 @@ cpu0: cpu@0 {
>                         d-cache-sets =3D <128>;
>                         next-level-cache =3D <&l2_0>;
>                         capacity-dmips-mhz =3D <530>;
> +                       #cooling-cells =3D <2>;

FYI these changes (for all the CPU cores) will conflict with the cpufreq
patch that Matthias just merged.

ChenYu
