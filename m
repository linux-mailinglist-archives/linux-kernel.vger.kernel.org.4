Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1248625ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiKKM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiKKM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:56:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CF7C8C0;
        Fri, 11 Nov 2022 04:56:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t1so2897110wmi.4;
        Fri, 11 Nov 2022 04:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyUckvB1E1DdFJmN9a9qviosI8tjiRPV3QG4ylvcz1U=;
        b=mw9Akph2xNeOdpTjd2rDtMRdjoLLP/nzxfzfat2AfIG4tPDlnmgtT/2qRvIN0p0WzE
         vrW9O3a4DowHuZ5nEIbOqlCk/i50f7hWkaZbfbUqZugYORqa4CtS11A9EU1ONjFoxh67
         p/b9vEsDFLDWbZQeAmCoRmv8fGKRgNSJ/LL65Y8nDgba+ou9k4p2XJ8N9LHfXzFnNBX0
         72rZlYWX69pAKa46gjlrJup42EqGHgFbEY4KxFEVuPnJK1xIjp0lmTgiflhfGMrPY/YF
         7XuOTPvqTDYms83SBy3weDarjJC6bPkqVo98xC+v3WsHTFZ3MAqrXj6zNdf02NwnLthy
         y6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyUckvB1E1DdFJmN9a9qviosI8tjiRPV3QG4ylvcz1U=;
        b=0seTuVQB4llqENfuDhbHVwgu/tnHClC+6kmsw4g/GghEk69p2PkObpE3zMe7baof3u
         S7eq+lEBUZULCOSRkDZN9Cb9qL6S7nWY5oG1xUXQA2qSNsBtDRtmpM9t7lN9MyIUY9s7
         BlgHjxVZR1Mq5Is/tikvj1vLVz5nk0rNvrGRAM6ZAi9jQA09k7h6eVxg/Cay52zQiQAb
         zO1T5GxP9Jz9kwTJv7awRs+v1CKzSwQMpmvkGKbFA+LuCEqRQKUCIqixxJ5oRrV9NgH0
         gTtxism+w3un0FV/EMcQdH7T+43xAcGU1uvve2Dz46vp5p6s1+348UzOldRe6uibAaXz
         m/kQ==
X-Gm-Message-State: ANoB5pk2HoaRhJN/LEzmKNvuwfCkQtFuD/sbsD6z7F4ezebM7g7XeJXF
        szlWtSqTGlH4YGR5lH1kdrY0wUDbf1U9qPJiV1s=
X-Google-Smtp-Source: AA0mqf5PJPJws3SLJ/BrDAqA7EJGHCdFeg4hTpN9hat+xfw9gfeRro1AljHI0t3KH3u0vSgtu5UqW8eKHH5dQIN/Hjk=
X-Received: by 2002:a05:600c:3496:b0:3cf:cfea:904c with SMTP id
 a22-20020a05600c349600b003cfcfea904cmr1189758wmq.33.1668171385285; Fri, 11
 Nov 2022 04:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20221111094238.1640-1-linux.amoon@gmail.com>
In-Reply-To: <20221111094238.1640-1-linux.amoon@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 11 Nov 2022 07:56:13 -0500
Message-ID: <CAMdYzYp2wSrkOEh-v6Wye32TA9imfNF4CrUdKL7q8pOCQU307g@mail.gmail.com>
Subject: Re: [linux-next-v1 1/3] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A sbc
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
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

On Fri, Nov 11, 2022 at 4:43 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> On rk356x ethernet phy support reduced media independent interface (RMII)
> and reduced gigabit media independent interface (RGMII).
> So set the phy mode to rgmii.

The RTL8211 supports rgmii-id just fine, you only need to go to rgmii
on these boards if you need to tune the delays manually.

>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index ea74ba32fbbd..72e410e3aca8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -253,7 +253,7 @@ &gmac1 {
>         assigned-clock-rates = <0>, <125000000>;
>         clock_in_out = "output";
>         phy-handle = <&rgmii_phy1>;
> -       phy-mode = "rgmii-id";
> +       phy-mode = "rgmii";

You should be setting the delay tuning in this patch as well.

>         pinctrl-names = "default";
>         pinctrl-0 = <&gmac1m1_miim
>                      &gmac1m1_tx_bus2
> --
> 2.38.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
