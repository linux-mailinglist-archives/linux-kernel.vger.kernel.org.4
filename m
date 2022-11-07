Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3161E817
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKGA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:58:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B00B7CA;
        Sun,  6 Nov 2022 16:58:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id cl5so14067633wrb.9;
        Sun, 06 Nov 2022 16:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SUjrVNjYpQ4FGX+sVZmnlqoqrxVRTW7jwTovMJReUo=;
        b=lqbltCqrY+FRt+9AmsTb7o1R9vs/00guDt0qQbM8gWwdbdwavbxrUbxVvmjL1zkbNx
         xKUHAEMJcs+nrDC033nDYlsxCE5bkJ8xmWeFWsouQpiuRy+ZPIdEgj7Y3b70IlYOaAbb
         K4E7tnd68EJLj+RQGOKR+bsw/YRiFjzRFrpVxHq627eoIq9fHdTZcGvr+kk+eN0q6FvA
         NPDvvR9wkM4dS5WaRidyiEoDqCrMd/ZQK7o8ODVnQsK2bAjT05ytuNyKTYBO+Gh4d57C
         5nMDQK8Z/7D543qOrKlWfGBwy9cj5hhShQiyujPBHvfT+LjrtF4ds3W2gqkSbMsfdwst
         cD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SUjrVNjYpQ4FGX+sVZmnlqoqrxVRTW7jwTovMJReUo=;
        b=nYQC5S933ewvnR/MNSSqkYFYsqm0ajlCAHfEM314UDA3AfrYMJlmuwua8IXqAsbga5
         tJp6Mz5LNHBn+jnhiPcRiZjSWGZtBxUalEttDuRG2/9nAwMlEV+rYD7c4nJ4CDkuqE6V
         Q73YYcBeE1xKRGPJEyFAbXzfenspq0S8t2ryE51SyjMMw5JGvBHCFNStypc4hxTmvv7p
         ncen19e4JdUoxP10JsQ1Y809C01t4q1Tfi+lLonHLdcs8MxDEhG+rG1Hu3FwtrGTuPoQ
         LjnAFBrwHOEIekj1pBNu4Pr9TINBlAFm4AtP9Tc6DxJbDmeYeQ45ozk2Lcp4Gr+okETD
         w2kQ==
X-Gm-Message-State: ACrzQf2kAdmxPt8bWOryiz9tk/hl1ES8xAVfFIZGzIGrMMu2fAkj9X6s
        2f0zvqk4UEprpWpPiKCoWODAoFFVLh6J5RsNI/0=
X-Google-Smtp-Source: AMsMyM5oGZnKz4jdnVIz9fRd6FjjmcWKsJdz9cqrYMtzAtJH2bfQLsbI3jNtHgiCJHWVsISzHqMRM8QZuwvgVzNDOgE=
X-Received: by 2002:a5d:604c:0:b0:236:6deb:6d31 with SMTP id
 j12-20020a5d604c000000b002366deb6d31mr29321862wrt.282.1667782731107; Sun, 06
 Nov 2022 16:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20221106161513.4140-1-wens@kernel.org>
In-Reply-To: <20221106161513.4140-1-wens@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 6 Nov 2022 19:58:37 -0500
Message-ID: <CAMdYzYqP+0B5Q_7bfNREx7MvxZxawMGD+jRTfSSb8X6N8LCL=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
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

On Sun, Nov 6, 2022 at 11:15 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Ths PMIC's interrupt line is tied to GPIO0_A3. This is described
> correctly for the pinmux setting, but incorrectly for the interrupt.
>
> Correct the interrupt setting so that interrupts from the PMIC get
> delivered.
>
> Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Good catch, thanks!
Reviewed-by: Peter Geis <pgwipeout@gmail.com>

> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> index 77b179cd20e7..b276eb0810c7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
> @@ -246,7 +246,7 @@ rk809: pmic@20 {
>                 compatible = "rockchip,rk809";
>                 reg = <0x20>;
>                 interrupt-parent = <&gpio0>;
> -               interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> +               interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
>                 assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
>                 assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
>                 clock-names = "mclk";
> --
> 2.34.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
