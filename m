Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99085EB09B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIZS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIZS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:58:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316B6B8D6;
        Mon, 26 Sep 2022 11:58:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t14so11643651wrx.8;
        Mon, 26 Sep 2022 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=b51V4plCUL4WHeMpsECbX9KPKiOMw0hpDkxBUOciEZk=;
        b=o9i2mXIdY73lmJnAJ2RDSYA0TdnbJhPv9g1pIOieOfsIut5ZXfWi7fka+SVaIVQrpC
         fJhr9SfKXKI1RV8RciAeZuhIHYkAp1YTVjhwul5hjjWl3r5S3EiKFZCPdFZNlYAQVHSr
         aeVCW/ecepoqg/MigdoHcgISD92hmANVAKzmH3rS1AGO/5OUDG/0W7yCNqi6ZkNQ48ix
         8BL1cZD4P4zvLYqkjGRWlAJvrhwrgO0Zz6ec0bcmsJX016ukZb/7b7114DfmerMeWG9K
         eYnnAfBZ2YRDmSW02txAs8BjknaJOR2Ea8am7ywStjdllkw1VwJwJ4tq8gKSMdIQYSek
         vwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=b51V4plCUL4WHeMpsECbX9KPKiOMw0hpDkxBUOciEZk=;
        b=PfCbZaZNbhQnm7164OMwZul07HFHibCa0jKULSkTf1gThOSAqqrJuvCvmyRtiDbqPU
         NS3D9qSkCxNgMz6YMDGgc1UKhyu+bkXvrV/rmGZ+ameemhklWgx9HO4ZNtdfeW2hepEp
         VPoJRDKcNr0tQoaRmTDsF/0K2dBIVvhr1sQyUpOeu9L5/n1Aq4FWmWFEIflEhsAlFKGP
         CzJO72nmxq9XF3yLzb9sT2oTwnld4CuY61Tkgdq7nf7gzBh629sKQKcjfQfXsh4oR7VA
         EO2UhrdlnhwV3lXU3oY/2KrHH0+G/tS9wLWYgcIGBXXNRUCzyVhrG6Ipg6ixraHMNGCZ
         YaAg==
X-Gm-Message-State: ACrzQf3b0QagxzcKc1KtbR7CU2D8nuZYpMxZI4rhzzD9OfNGdg4p/PuB
        H9TqaaChjwWfquJyWjGbE2dseaIi7pqtPP0Bl0M=
X-Google-Smtp-Source: AMsMyM4o9S0JLW31kqivbGPokYf8WNbp2BrtBWO5HLa0mm2Kx/odZjXAP6MdNsYxR4axzpKD2rIlsO351kktMiJ+A5o=
X-Received: by 2002:a05:6000:1882:b0:22a:f7a2:736a with SMTP id
 a2-20020a056000188200b0022af7a2736amr14388076wri.691.1664218694543; Mon, 26
 Sep 2022 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220926183533.1893371-1-aurelien@aurel32.net>
In-Reply-To: <20220926183533.1893371-1-aurelien@aurel32.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 26 Sep 2022 14:58:03 -0400
Message-ID: <CAMdYzYoR2caD2ecN5vGTiHejoE5AhbyKxSgSeU1+SzU7nNVTwg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add missing rockchip,pipe-grf to
 rk3568 PCIe v3 PHY
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
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

On Mon, Sep 26, 2022 at 2:35 PM Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> This commit fixes the error message
>
>   rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap

The pipe grf only is used on the rk3588 device for this phy.

>
> during boot by providing the missing rockchip,pipe-grf property.
>
> Fixes: faedfa5b40f0 ("arm64: dts: rockchip: Add PCIe v3 nodes to rk3568")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index ba67b58f05b7..8818b283ba11 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -56,6 +56,7 @@ pcie30phy: phy@fe8c0000 {
>                 clock-names = "refclk_m", "refclk_n", "pclk";
>                 resets = <&cru SRST_PCIE30PHY>;
>                 reset-names = "phy";
> +               rockchip,pipe-grf = <&pipegrf>;
>                 rockchip,phy-grf = <&pcie30_phy_grf>;
>                 status = "disabled";
>         };
> --
> 2.35.1
>
