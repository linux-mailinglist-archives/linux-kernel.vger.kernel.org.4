Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082EF6D3971
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDBR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDBR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:27:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921FF7DBA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:27:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so27036774wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680456467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lai18srKbEc5Y0N4kYNIKail00meRifHOIv93tm0RKQ=;
        b=H5kzva5gJTiQugbxCd+mPDSr2M8sn7syUsd+AtHXjqG6foGeeA7tlI2rqEsg+0tWUc
         z3bifdzCQVsPYVE4w3pRaWKDiy5Wnb1RgOBtLuH5dwX0no6qXmDlm01mCdYS7gauTau6
         jPGXNF9IQI4FnXjT5bBFtKFxeYlviF3GlwLIh7tBDVbzT9kTNQd74UG83dgBENj4++dk
         5Ad9dN7vA2Gfv9DUxXyO/y3k/3pyo/QrdUUU6LAmhagxEv2W7yhd1CjLdryAVRUlhFYa
         em1XkbLyZ85vYA8VWxuoO9xyvyKaJaZqpTwlbGIE/WiCRaqSr2gphweeToSYEhUXi44E
         y6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680456467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lai18srKbEc5Y0N4kYNIKail00meRifHOIv93tm0RKQ=;
        b=AaUblhWP5WzUgcp/RTiOIkHjbq/DVI5eBG4FklcIwVYTZaDJb4XUz1LYGOYdrhU+l0
         HNYVtmae7Lv1bdbaVSgiAQToGSdxQMWF3OONQnupYMmxJuPGQ1cy5t7rDahIzI+g2SpD
         17NoloU6hhnYxzca8TY9BkufsRC9XaXTUcGgDNaWmCo9FtI+wPNRUXxQGhmNzxOfQuiD
         U51ssRktA7w6kVb3xM2lZrZSj39f8rw0YnRlojvQ8XhPFUD+D4EZCXvpLYiQQrxjlY5I
         1g2b1X2gC+MbBKQtvKBM7hiCKIyWUeJtamiTzRIu/NE5z/ttBdWzCe7y54aV9gVvL0UP
         YVzw==
X-Gm-Message-State: AAQBX9fvtpWZGUmh5L0f6T4mPP55wsPMMcx7FIwyUDuHEL8T1yKnZ3oi
        dzdlXGNGK5p16rnpto+zM/g=
X-Google-Smtp-Source: AKy350asqwgosYo2Ay67urHCg7UlZ6Ng3fTeNs8dbZe8pt7MI3H1IEgw2cVLmmpGwV7AU+CwwzCNxA==
X-Received: by 2002:adf:ef87:0:b0:2d1:bbe3:29b8 with SMTP id d7-20020adfef87000000b002d1bbe329b8mr11729952wro.28.1680456466852;
        Sun, 02 Apr 2023 10:27:46 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000100c00b002cea8664304sm7610629wrx.91.2023.04.02.10.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 10:27:45 -0700 (PDT)
Message-ID: <b656b070-28e6-48ae-5a17-f9ee3b25baae@gmail.com>
Date:   Sun, 2 Apr 2023 19:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: mediatek: mutex: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <202303241017290414354@zte.com.cn>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <202303241017290414354@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2023 03:17, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 7751527fc30d..05c8ad3c2664 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -1014,11 +1014,8 @@ static int mtk_mutex_probe(struct platform_device *pdev)
> 
>   	if (!mtx->data->no_clk) {
>   		mtx->clk = devm_clk_get(dev, NULL);
> -		if (IS_ERR(mtx->clk)) {
> -			if (PTR_ERR(mtx->clk) != -EPROBE_DEFER)
> -				dev_err(dev, "Failed to get clock\n");
> -			return PTR_ERR(mtx->clk);
> -		}
> +		if (IS_ERR(mtx->clk))
> +			return dev_err_probe(dev, PTR_ERR(mtx->clk), "Failed to get clock\n");
>   	}
> 
>   	mtx->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
