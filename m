Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020315EF063
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiI2I0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiI2IZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8075CE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:25:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 955A86601EB5;
        Thu, 29 Sep 2022 09:25:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439952;
        bh=3A84Wc+eg1AMQCBr54TYwsN/qp6rBrOdcI/Bnlj9wfE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kXiNgHz1yy3n7U6IHiM76d2/ZGgtGz4AhHPR0I0KcgQSFX0thGdBfn83o4WrTNMei
         apz9Kl8blrh6FnN/tNA20gKFQSFfcYMOTFVsijZFkr0CCVgPX+AuJd8jrtgf6FFCbe
         JVzdZMsxSqIbi4D6OOmh9TMa+ldDjqoeACwwokQO61xK/d6CLwfmG/xWvIjzFtpFNt
         ku1o1/6Wf3NHtER29OZmypjPHGDwzeREgpuH4SQNRmFEniCtfyCplu/vWWN5ntibP4
         kY34mSru+GUPn1jBlXaUKF4xejMoDapQ+jKAtzsI1GU8MQeijYtdKcvN8OYvZShnLs
         VUIuAZuzt8lcQ==
Message-ID: <3c4612cb-31bd-2bc2-6a91-313771869f8f@collabora.com>
Date:   Thu, 29 Sep 2022 10:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/8] soc: mediatek: mtk-svs: improve readability of
 platform_probe
Content-Language: en-US
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-3-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-3-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> If a compatible misses a match data entry, then something is wrong in
> the development phase, we don't need to check for that at runtime.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
>   drivers/soc/mediatek/mtk-svs.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index fd0f636e8644..52bb4f8bbe6d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2332,10 +2332,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	svsp_data = of_device_get_match_data(&pdev->dev);

Changing that to device_get_match_data() (so, dropping of_) would be a plus
to this cleanup, perhaps...

In any case:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> -	if (!svsp_data) {
> -		dev_err(&pdev->dev, "no svs platform data?\n");
> -		return ERR_PTR(-EPERM);
> -	}
>   
>   	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
>   	if (!svsp)

