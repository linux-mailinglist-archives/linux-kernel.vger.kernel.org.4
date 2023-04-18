Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700626E6BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDRSGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:06:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9BE7B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:06:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1328621wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681841187; x=1684433187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M30du5mqmgKvrK4t9HuuHfHAn0tr6/r+1Nuzg/l+qDw=;
        b=aCFj1du12kahKPc813jpwjYOXhr5FL7OFbCUYDvNavWqd0SK6oPxKM2dMsxip95R6a
         4/03EZc+qS79tO4AruGAqF5tD8wrk3HvYkbuTFMlMKrtCPMvCRs/aNl1bpoJtldQ9HCN
         uOpyl6p8LXdvzbDD4gRNPiQqWyiIA3PDpjIc4XHRaTO4UmWif9MAa21W/tEpYWQFNa9C
         /fbzoBhh+Go6lC97jomf/vHXaJZ40IA+jKnTOkzJ19J1aZ9+dL29RbP7CZVrvTblP8U5
         MQ2yQsE5upoSJ6/BkX3VSoEOQZ3TVAUDzsy63IsUV9Hn1Klx99gVdfbeVcn+mvLuwFZx
         Z8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841187; x=1684433187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M30du5mqmgKvrK4t9HuuHfHAn0tr6/r+1Nuzg/l+qDw=;
        b=GQzT/1hM+hJPuDjPzcxQEgxCRVT7Eitxe/Jq/+jmHe9q92vcIM2ItH3FB4QEAXO8QX
         o5f2DRfyrSE+sQKBpRounu6jrQWc6lyoyo3iQKp+xQyLEOXuSTuw1nkRGfYUaQAZ7Cmd
         JFW4+dDCBCCTazFhVxPcDcMOoLaN0TmeJMvHX5/V9fKE2VSunWVBbfrb19JBE8mO7THc
         LTINHmHrhr7Nyu0His8IiLcJpP3hLM3qukS+DUQVx3Ph7HOMXkt4aCcV44ryG1XICxBU
         Ii2sDT5D7eGELl7fHkpUaPJvC3KNCYjBNr1YHZU6Z9hQaq1AXwsLRXcDRBZEsnpK6T4y
         1KLA==
X-Gm-Message-State: AAQBX9fRXjRKWzuvaLTfzvZ4w25UYjOh/87NJRL4ZwJFC3YMCYrta63B
        1y19o0XMWQUuev9PpEAY3lw=
X-Google-Smtp-Source: AKy350affcKRPRnr6w7/Il+mJ10enRJnyp2KpkDOKh2W7Jw2M7JNi/J3H08mo2ox0CzAMVjiUCBrdg==
X-Received: by 2002:a05:600c:218c:b0:3f1:6980:2cff with SMTP id e12-20020a05600c218c00b003f169802cffmr8162883wme.14.1681841186582;
        Tue, 18 Apr 2023 11:06:26 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d480b000000b002f2783ba25asm13649277wrq.65.2023.04.18.11.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:06:25 -0700 (PDT)
Message-ID: <d05f3ba8-5e89-82f2-73e0-175250e3e8fd@gmail.com>
Date:   Tue, 18 Apr 2023 20:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] phy: mediatek/mt8195: fx mtk_hdmi_pll_calc() return code
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume Ranquet <granquet@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230414075842.4006164-1-arnd@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230414075842.4006164-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 14/04/2023 09:58, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function returns an uninitialized variable:
> 
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> 
> Wire it up to the return code of the function called just before,
> assuming that this was the intention originally.
> 
> Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> index abfc077fb0a8..c8e540665fcb 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -292,7 +292,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
>   	if (!(digital_div <= 32 && digital_div >= 1))
>   		return -EINVAL;
>   
> -	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +	ret = mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
>   			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
>   			    txposdiv, digital_div);
>   	if (ret)

I think this is the third patch that fixes this :) Your solution look quite 
similar to this one:
20230413-fixes-for-mt8195-hdmi-phy-v2-1-bbad62e64321@baylibre.com

Regards,
Mmatthias
