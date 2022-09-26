Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909015E97C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiIZBrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiIZBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:47:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039A2A72A;
        Sun, 25 Sep 2022 18:47:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t14so7982527wrx.8;
        Sun, 25 Sep 2022 18:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NFlUObOfmCqD6lJ8Qd3bAP3UmGiZcM4xx6wMJp41J5o=;
        b=Ow9S5prFYWmPvtPiKpPe0bfqYYKLrAlTlMASu5wBK5xmZIfU9TUzNle9zSSgolbeZI
         IL7U6CufgfIZINiu8eSv6RJOpG0KwXho4peAP4jsByWxJTz95KFvuvyLdfAUQnNOLkD2
         1R6PDNQS1+j1GrLd/PuTVMtwSkQbSuIJNYfcVLdk8wYr5ciiz9PlKjr8L4+OerxSQXQU
         bANqVqM3jGFCdp0pEoCCH5rrdzxjbUS44KD0NRt17ufml395GqZ8Xovk1JQMFfFvheBR
         1/61MrBAjQduYc91XoR44lLVPU35GxLESNISBHvIxD3AbSTTOV44b6b9RLMn1m4403Vp
         c9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NFlUObOfmCqD6lJ8Qd3bAP3UmGiZcM4xx6wMJp41J5o=;
        b=xn42ima4d1wM+23FGdvYOlUO/3tDSOq2XyLorsBxKDw3tGorjteewqKzACyRbF1HG9
         o4RQHBG9OstxLu+KQix7Vb3R1hZJ2UfLobR3qk3lnJ9B6DNY/WBCzuFh2CO8mhwaDMOv
         UXFZEacXXqPyz98/pq6veHXns8wck6wAeqmY4Inr2zGiFrw30cQYPvJttrZ3PNrMNcvk
         R45R7WPby5wEcGXmk47qsvE+qJU+X+7TuwBRI5jY2kc8s/Oo6DxlA2UOEJzQil/6tTqu
         Dkrsa86byKajXsrV+IYOn6ntRgOmI+VPHs9nBcq9Tqm62Oab/pxZ3sYQzJ5XWdLtwUsR
         odeQ==
X-Gm-Message-State: ACrzQf0n8ngvicomWcGgSuZ95vpxIIY1fGTqvGZpWsMJ9OjCqrcA6cV4
        xQqlloweh5xzTME3uUDIzLffynTXayUK7I6vOkw=
X-Google-Smtp-Source: AMsMyM6f9ZiPqjhD4Ybc4bqIH6+zzZy7lakyFrC5SdA3CUJhZw6ijSwE078FUZGOhv5nLeNCyPEz3gquCHSkmYFOLUY=
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id
 p8-20020a5d6388000000b00228c792aabemr11741732wru.689.1664156820093; Sun, 25
 Sep 2022 18:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <ce61fb9a-dcf4-27a2-ac03-62060a1512f9@manjaro.org> <20220925124825.71786-1-leo@nabam.net>
In-Reply-To: <20220925124825.71786-1-leo@nabam.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 25 Sep 2022 21:46:47 -0400
Message-ID: <CAMdYzYpdhJ-wWN9UAppQvaNqK8Y_RadYv2v67gD5S_u=1ZXw0Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix quartz64-a bluetooth configuration
To:     Lev Popov <leo@nabam.net>
Cc:     Dan Johansen <strit@manjaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 8:48 AM Lev Popov <leo@nabam.net> wrote:
>
> For "Quartz64 Model A" add missing RTS line to the UART interface used by
> bluetooth and swap bluetooth host-wakeup and device-wakeup gpio pins to
> match the boards physical layout. This changes are necessary to make
> bluetooth provided by the wireless module work.
>
> Fixes:  cd414d5ac1fdeecf0617737e688a1af00858253a (arm64: dts: rockchip: rename Quartz64-A bluetooth gpios)

Good Evening,

That patch only renamed the lines to comply with the dt-bindings, the
correct patch is the one that introduced the original line layout:
Fixes: b33a22a1e7c4 ("arm64: dts: rockchip: add basic dts for Pine64
Quartz64-A")

Very Respectfully,
Peter

>
> Signed-off-by: Lev Popov <leo@nabam.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index a05460b92415..91908081c5ed 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -740,7 +740,7 @@ &uart0 {
>
>  &uart1 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
> +       pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
>         status = "okay";
>         uart-has-rtscts;
>
> @@ -748,8 +748,8 @@ bluetooth {
>                 compatible = "brcm,bcm43438-bt";
>                 clocks = <&rk817 1>;
>                 clock-names = "lpo";
> -               device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> -               host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> +               host-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> +               device-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
>                 shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> --
> 2.37.3
>
