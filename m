Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEE63429B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiKVRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:38:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41865E3C4;
        Tue, 22 Nov 2022 09:38:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 189-20020a1c02c6000000b003d02dd48c45so616544wmc.0;
        Tue, 22 Nov 2022 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+ftqIfdkSVX9/E+y5CjNrH9E0Z7Pga+p2819VhJF+g=;
        b=EqZFphm6mu/6vZej+M7COtDqt5dpwClyQiLRA4vFvDa3RXQ2e1bOKYrCHrBHZHM2c0
         QmJAO2mpAsh1jWNNJyK+Yvb05EblWec7imFqb40zHbynjXLLTN1+oj5aGzKmDHz4odiv
         uhsbiY2OHCeLV2Og7WDcAHXDjuVJEZoBeq0LdrG5OR7dZ4HHouUzhFljSnDrT/fZYRJY
         6aJwEf+4/3bQQ8d7dZOrXjiT9cdduoikisCib1WHxg46wL8T6DkgAnKIj/KleqogPTT+
         u6wDM3210bf8rpP/g2DP0lZo9PDtmMuYniVXIrDxrdk3WWmvl86qNWWS0cv2AfGegiVH
         GnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+ftqIfdkSVX9/E+y5CjNrH9E0Z7Pga+p2819VhJF+g=;
        b=XDj5R5ziQja8GkxVltf886WcnjhaZ6WU0ENFNqJjPEA9/RS+GteEljpDg6K7vMATD7
         VJW0ZC03kAd7TWUK0LTvE4yXKLV0HDTa2pqWKQEBoZHfupUFdmgZSW7WymAL1zsfk0+7
         ueHKdMqrBSJmCdx5QErSTXA3EZptAEqkox7wK984T2g3kBS8pTr17IClfu9eKvAt82QP
         Fdnx/AyEuu0cp1D8CXIFWT7JWjhnA06MnwdT//Osin5j6Uml6l6L9TXZB0xN/ZXh4x6i
         wTdcsg5mCbcNfUySr8qZlY1uPYiJPlV0IMtfHelH9V23D2pEfu9aEfdqORlag+gMl+Lw
         inMg==
X-Gm-Message-State: ANoB5pn0trCKHcw5cpS3IPaECJjTC/zE652vArphKOC6Gg91Fs7fChct
        f7x8Wf7wjiXdikOotYRBgek=
X-Google-Smtp-Source: AA0mqf7Lcc8odQYBjV/PBGGjFzwvPElZiX4Vw/d75C/ERxuf9H4WD3Ghxg7YYtikN0Eo2Ta6fcNTlg==
X-Received: by 2002:a05:600c:348d:b0:3cf:88e7:f808 with SMTP id a13-20020a05600c348d00b003cf88e7f808mr3503934wmq.200.1669138730275;
        Tue, 22 Nov 2022 09:38:50 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id g15-20020adff40f000000b00241db7deb57sm4886755wro.114.2022.11.22.09.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:38:49 -0800 (PST)
Message-ID: <4a08b689-4592-86cb-7eba-cca49970a489@gmail.com>
Date:   Tue, 22 Nov 2022 18:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] soc: mediatek: pm-domains: Fix the power glitch issue
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
References: <20221014102029.1162-1-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221014102029.1162-1-allen-kh.cheng@mediatek.com>
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



On 14/10/2022 12:20, Allen-KH Cheng wrote:
> From: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> Power reset maybe generate unexpected signal. In order to avoid
> the glitch issue, we need to enable isolation first to guarantee the
> stable signal when power reset is triggered.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Applied to fixes now, thanks!

> ---
>    Resend a PATCH from
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220310011548.2487-1-chun-jie.chen@mediatek.com/
> 
>   [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 09e3c38b8466..474b272f9b02 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -275,9 +275,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>   
>   	/* subsys power off */
> -	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
> +	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
>   	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
>   
