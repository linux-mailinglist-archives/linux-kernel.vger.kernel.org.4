Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B966C62FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCWJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjCWJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:12:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9081ABCF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:12:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so655681wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679562771;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pcJdmtSJI8n1Nq4yaF0gcqHdFoOGhaeQhrSp6datg7Q=;
        b=tezoRFywjrJYM2cPo82G+050C9EqrtNYasjj5H1ILpRj5RBay2nsOggrjKWGe4qLj8
         lIgP+6tc/tjRto2YBQA7h0jgpS45PvUqdAwymVi+STSGo4kXR6KH9yc7ksik6lxNsHh6
         tCLHi+TcF4zPCwUv6nabo08VTbBxbc5ZFx62ZnnJ2ywW5X4LAClQVPutjWPNXZw45KPi
         Cqb8PJYuZULxR7ybkuPi63oRqbNubnOZ18U8agVCoNDsO8gcG2Ffq2tFtTzLXM0SYgfU
         MfI+rqF7pUpmdyczAq8YmFBKAsP1w7y+IjM1qUu/zPxSe6o84oAgyRpOwjTL4aTHDoHI
         yt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562771;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcJdmtSJI8n1Nq4yaF0gcqHdFoOGhaeQhrSp6datg7Q=;
        b=tSnsZL1wJJN0VJV7LvtP3WOHkd0d2lNya8PVk78HD7Pc5IYc3oCA/bzLiF1obisjO7
         gVWCj+ZPuBe1BDov33n2adoCYafjpX4pqpvsme50BEWa81tk12NYgvsnVVDaPCdJpyrb
         /DaFVAbyopdGqZv/bdifge8+PLz4/weBTZ9RgMeZlXUED3qzH8xI0i10rlUgAxidvywC
         BgkKsD7LwqZPWbjWU7BPOj50deWdgyzQ+hxTdyIMOlC4nSmTXVYYOwtijYdiB9qXvdaH
         E7GpPl9ocj2SLEDr8Rdxd4DeA1/JZBWL+6oTiDZ5+W6lcMvtZ6Enzr5oa6+nTFh4p3x1
         GaZQ==
X-Gm-Message-State: AO0yUKUxnMYOn1Ib+at1wbiUqxS5FRJ30BiJw70+1TyXsESdBhprhs4B
        zj7K6Z5TCvmaD9qfPhCh+iK5NQ==
X-Google-Smtp-Source: AK7set+qyjI4dIR56davAs0GyezEM9aqtToFTFnrHhfYp3ZawBnpARGrcbNhyJtgjLQ9swrPeOYQ9A==
X-Received: by 2002:a7b:c4d1:0:b0:3e2:662:ade6 with SMTP id g17-20020a7bc4d1000000b003e20662ade6mr1757659wmk.26.1679562771430;
        Thu, 23 Mar 2023 02:12:51 -0700 (PDT)
Received: from [192.168.7.188] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b003ede03e4369sm1264366wmq.33.2023.03.23.02.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:12:51 -0700 (PDT)
Message-ID: <f4a85c43-a4d3-c1b4-de12-76e7781d8d76@linaro.org>
Date:   Thu, 23 Mar 2023 10:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH -next] phy: dphy: Use devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     khilman@baylibre.com, vkoul@kernel.org, kishon@kernel.org,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230323073534.75037-1-yang.lee@linux.alibaba.com>
Organization: Linaro Developer Services
In-Reply-To: <20230323073534.75037-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 08:35, Yang Li wrote:
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> index 32d1ff09befb..6e9af79e152c 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> @@ -335,7 +335,6 @@ static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct phy_provider *phy_provider;
> -	struct resource *res;
>   	struct phy_meson_axg_mipi_dphy_priv *priv;
>   	struct phy *phy;
>   	void __iomem *base;
> @@ -348,8 +347,7 @@ static int phy_meson_axg_mipi_dphy_probe(struct platform_device *pdev)
>   	priv->dev = dev;
>   	platform_set_drvdata(pdev, priv);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
