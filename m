Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6A64E9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiLPKzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:55:05 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2592F643
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:55:04 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id c14so1432709qvq.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrKknhuGa3KVuISNQ+0ldCwT2QjtfcVWcXhLlx6f2eg=;
        b=d7a8PH68eC6OkPo1s2NDnur3yDuiRN2nKhYrrQ8VkeONotStBBQyQ/FhW5JqTQuVRZ
         0XuH2oEqemwTZNMa1tPrxQ9HRbZjbE3fr3H7eGNK/O3APxMvbCtXnNHNc9yViasf/DdK
         GCA2Rn7POemoUp0cqESl3r4eZN2iAVgRTU0mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrKknhuGa3KVuISNQ+0ldCwT2QjtfcVWcXhLlx6f2eg=;
        b=VU2MbJ51fu6nse2Ou7FFOWgFejNIToE53uA0pp6uJCZtfqMKv5bJ7ld5ThFfs+6CEe
         GdYlPpevWHUgG0Ewv5kA0BiX9r+pDiT1uwkrT1Lx7SjOz6Ba/brEf5w4iJg5knxLMBI3
         sPNMoFBdhIcaBQFdc9KUj7GwpYXp7CO3VekhbKvhZLiUZ78BzayNLUkYBKj/IJdBOgaP
         9O73dy+gHDsEiHBD+dqa+10gAngnCUzKjLldvquLf81JOJdo3e3dnpjGn7WcqpWXVx4A
         Iez2RwNy40Kr2CmrrTOHs6jQdqTQc5EA6bWL7YhfaZ66t9ycnzDBOdJsCyFtZ9dqo6Mg
         Pr2w==
X-Gm-Message-State: AFqh2krIMBw5RBTEoM7Issk39s2b0uhxVotnDqTJHjrJpJ7qeE/QSiBo
        +eYuMkMK8uKFiDu8UnP0PjQxr/qC6sH1gB/jika6Zg==
X-Google-Smtp-Source: AMrXdXtxD2Dw69BXa3t7U8lA/jGeC3BWlJLYa99HnQcGLG9/wzipb95sBWc/+IdjkbP22LWRyfQhXpR7BrZhhq7VTQo=
X-Received: by 2002:a05:6214:3283:b0:4ff:d079:307c with SMTP id
 mu3-20020a056214328300b004ffd079307cmr55075qvb.18.1671188103515; Fri, 16 Dec
 2022 02:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20220527045353.2483042-1-hsinyi@chromium.org>
In-Reply-To: <20220527045353.2483042-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 16 Dec 2022 18:54:37 +0800
Message-ID: <CAJMQK-jWwDm4dy-ELzJ5gzLby37Ztqn9qhGT9zqFhmowdok51g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Split out keyboard node and
 describe detachables
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:54 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Kukui devices krane, kodana, and kakadu use detachable keyboards, which
> only have switches to be registered.
>
> Change the keyboard node's compatible of those boards to the newly
> introduced "google,cros-ec-keyb-switches", which won't include matrix
> properties.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

hi Matthias,

Kindly ping on this patch. Thanks.


>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 ++
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  | 6 ++++++
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi  | 6 ++++++
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi   | 6 ++++++
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi         | 1 -
>  5 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 2d7a193272ae..981c889a22ea 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -4,6 +4,8 @@
>   */
>
>  #include "mt8183-kukui.dtsi"
> +/* Must come after mt8183-kukui.dtsi to modify cros_ec */
> +#include <arm/cros-ec-keyboard.dtsi>
>
>  / {
>         panel: panel {
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> index 28966a65391b..4b419623c8dc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
> @@ -372,6 +372,12 @@ pen_eject {
>         };
>  };
>
> +&cros_ec {
> +       keyboard-controller {
> +               compatible = "google,cros-ec-keyb-switches";
> +       };
> +};
> +
>  &qca_wifi {
>         qcom,ath10k-calibration-variant = "GO_KAKADU";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> index 06f8c80bf553..4864c39e53a4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
> @@ -339,6 +339,12 @@ touch_pin_reset: pin_reset {
>         };
>  };
>
> +&cros_ec {
> +       keyboard-controller {
> +               compatible = "google,cros-ec-keyb-switches";
> +       };
> +};
> +
>  &qca_wifi {
>         qcom,ath10k-calibration-variant = "GO_KODAMA";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> index a7b0cb3ff7b0..d5f41c6c9881 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
> @@ -343,6 +343,12 @@ rst_pin {
>         };
>  };
>
> +&cros_ec {
> +       keyboard-controller {
> +               compatible = "google,cros-ec-keyb-switches";
> +       };
> +};
> +
>  &qca_wifi {
>         qcom,ath10k-calibration-variant = "LE_Krane";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8d5bf73a9099..db1388550f98 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -986,5 +986,4 @@ hub@1 {
>         };
>  };
>
> -#include <arm/cros-ec-keyboard.dtsi>
>  #include <arm/cros-ec-sbs.dtsi>
> --
> 2.36.1.124.g0e6072fb45-goog
>
