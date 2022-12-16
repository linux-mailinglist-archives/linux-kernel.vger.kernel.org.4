Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CE64EA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLPLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiLPLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:23:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB35163E8;
        Fri, 16 Dec 2022 03:23:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so2150345wrl.9;
        Fri, 16 Dec 2022 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAWXZ5dwyU4nYzKu6dG0EcB7QJGqDFnb5rKrT6m3dlQ=;
        b=YIIoVlfk6+N9Dbv6UCADP+/Bd66InxDSiBgDL/pp4oE2qCfDcfYSu69isft+voaHrE
         Ywpy6B2xaM3+ri25Rvxc6rNCqM/je85KxvHRRDR73dNAlcS9UyFF9AQekXDYCn33UpMA
         G0RHJkKnoZjmsBoUn0h0n/UZNvW8+rXW9kxCknJiLigfPguCoRPvv2inPOGJuSp8EeqH
         kirpg1188XOrFMgC1+dg9pEY1RkQ3YeCQleVpuJuwZsqyut5k4aKqO0bv789stxc+IHP
         89CUQ46QffrANtTdFgQ6nbWJ1lKAFiSZjinsKgDF3jjVx54Z/l5o8V/y5ExMl+GN+rSt
         9wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAWXZ5dwyU4nYzKu6dG0EcB7QJGqDFnb5rKrT6m3dlQ=;
        b=Noi0yefqOsPZIE1vrvQPi3oPjOjKApqyRN2k1aMK4ufGZ6rnG02jc/BCUjDr5YSvRP
         5z7N7CscLLZWYF/XCuAS3To2ZiXz2/9NdXyK9Z7gwRL++EtK8EmZrC9vbtF92Kbkfveo
         vBCOn8/SEalGR9npuGfhWDyEAReA88ctUhXBKLoyqR6JHTHxvaaM2s3zA58i04MEtFvU
         OTs3326v8kj6JCdj6pBuN7kBZ1SsVeYEh50vVGoC+v/cyGWNtDzNo9aH3gs02sWUnvdy
         8I6uWT60TPdiVCwZ2nma9fcfOgsscnBnWXDRiNVlQ2Ms8UtImiznnMk7aUeWY48fU1LM
         ccTw==
X-Gm-Message-State: ANoB5pnmp+bvpBgXPhNCmwZRbidKm7yi0beHpXce6/Et/aWbYeygbN/b
        Wv1Hd8+Uy3xoIB2ztdgNWJ8=
X-Google-Smtp-Source: AA0mqf48S1sZqP77x7fQ3pVk52VBeYECSdS87vyjHpCEQNGm5ug0+c7NB5eA1qSwlxtF3t3FplvarQ==
X-Received: by 2002:a5d:4242:0:b0:242:5ed6:a09f with SMTP id s2-20020a5d4242000000b002425ed6a09fmr19661776wrr.44.1671189822253;
        Fri, 16 Dec 2022 03:23:42 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d58e4000000b002425be3c9e2sm1985229wrd.60.2022.12.16.03.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:23:41 -0800 (PST)
Message-ID: <bfdb30b7-8540-15e9-678c-3bf0541425b4@gmail.com>
Date:   Fri, 16 Dec 2022 12:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 01/10] arm64: dts: mt8183: Fix Mali GPU clock
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220927101128.44758-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/09/2022 12:11, AngeloGioacchino Del Regno wrote:
> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> The actual clock feeding into the Mali GPU on the MT8183 is from the
> clock gate in the MFGCFG block, not CLK_TOP_MFGPLL_CK from the TOPCKGEN
> block, which itself is simply a pass-through placeholder for the MFGPLL
> in the APMIXEDSYS block.
> 
> Fix the hardware description with the correct clock reference.
> 
> Fixes: a8168cebf1bc ("arm64: dts: mt8183: Add node for the Mali GPU")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Both patches applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index a70b669c49ba..402136bfd535 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1678,7 +1678,7 @@ gpu: gpu@13040000 {
>   				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
>   			interrupt-names = "job", "mmu", "gpu";
>   
> -			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> +			clocks = <&mfgcfg CLK_MFG_BG3D>;
>   
>   			power-domains =
>   				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
