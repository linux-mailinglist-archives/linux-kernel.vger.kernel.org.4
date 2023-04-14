Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D36E2731
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:43:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58559A5CD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:43:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15so1051220wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681487030; x=1684079030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIbNvnDJkbKIDG9W40wHYyYsAJM6e0/VxMfL2/QQhNY=;
        b=QXpobAtYXuuja8eAnUitUYYdJFXqaConoab7s3RSbwHCOgxUoVFacXpnQJBcpA+JQb
         5N5tvC74yxQMqIqvqsop1XuZ4P+M7IaoRPqSbiY/1c2NeOfnuh57dPnBNRYtuvpOuOYQ
         d4ovTXDqN0R67vvA11ZrTveMDsLXR57NkWxMv0PtrbwpGTIEWGxabu7b6Kc4D1VC/yVL
         ftBSnh4ajvZ0aKZhcFea4GRL9sEGf22K7vufTD/WbjkwkdvB2NQi/q4ApF1oXBGDeC/I
         rZ1ZyK37G8LoSePqAYSqaAqTRIwbVHk0FT/40JaT1ZT4QJ2nRUPTFVGP/TsKf+MDR3mA
         gvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487030; x=1684079030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIbNvnDJkbKIDG9W40wHYyYsAJM6e0/VxMfL2/QQhNY=;
        b=YrKMIaGfWH+LZP7o2mkzQ/CO9Y6D4tPBqHMneIkTJSH9cG01LzAvIkQRGjOqZfZ9rr
         ib0SBg4/pWc6HgXpTYO74XNMBUOJJBGDDNB4aowr3+v+3vNXZk6n8sYgUopqqTa8Vdnq
         1aOWXB+Od4wUxmJxMHZ5ZcDQY5BLyTfHfq61+mYU8diVrFSR7WttXRd4UVfHvsumFmHX
         AVELUwAZ/ah3J9rT2Lwz8gKOmOFYcdrxrNGd/W2aWH89ucj6inG6NFjSl7KHgM8jyfc1
         L8bQKvkjCMo7beY1FaJIVm2o3lID5RO94ZumIrpgtL5SS677gEU3TjyZ5VE1CddY0ISf
         CFoQ==
X-Gm-Message-State: AAQBX9clikew/yLHL+RlK79efnNxBR/mzjc+BnEjWGO//e6WmMKLYPng
        78EdxaV1oY1rfemE8CDkJL46thW5m1Wrhg==
X-Google-Smtp-Source: AKy350a/b5Qg3ihzSVs/aHO9rCG1Yz359ZRWoVzo+MEmLSGdlhob8RT2eGiZbxTyHZHZZ5H4owZGGA==
X-Received: by 2002:a1c:770d:0:b0:3ed:95a5:3257 with SMTP id t13-20020a1c770d000000b003ed95a53257mr5261946wmi.2.1681487029517;
        Fri, 14 Apr 2023 08:43:49 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b003f0a090d798sm6510629wmo.18.2023.04.14.08.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 08:43:48 -0700 (PDT)
Message-ID: <3242b862-0e7c-b7e9-14cd-3fbcbb87ba04@gmail.com>
Date:   Fri, 14 Apr 2023 17:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org,
        angelogioacchino.delregno@collabora.com, nathan@kernel.org,
        ndesaulniers@google.com, granquet@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230414122253.3171524-1-trix@redhat.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230414122253.3171524-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 14:22, Tom Rix wrote:
> clang reports
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
>    'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>          if (ret)
>              ^~~
> ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.
> 
> Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..c63294e451d6 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -292,9 +292,9 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	if (!(digital_div <= 32 && digital_div >= 1))
>   		return -EINVAL;
>   
> -	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> -			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> -			    txposdiv, digital_div);
> +	ret = mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +				  PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> +				  txposdiv, digital_div);
>   	if (ret)
>   		return -EINVAL;
>   
