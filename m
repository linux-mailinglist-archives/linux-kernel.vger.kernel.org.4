Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7AC6879AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjBBKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBBKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:00:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A23F2E0E0;
        Thu,  2 Feb 2023 02:00:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so926133wms.2;
        Thu, 02 Feb 2023 02:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S47R+5rjRzxXYMzXp1UK6jVO2A8+OORRyssP8k3OTaU=;
        b=NT8sqyUpXMd+sQ8nCZdKb3Jk3hikUSHqIRfmLogoNwWuN5GC4a763Nodacy2zqJyiA
         kBUghR/YVoJblY5B0z1E/QUNJ7c/Ee4LtL3jil40RJWy9ZFzyBIUNXh41jX8I96wbSJ2
         R5uFZac87cAbS+vh5hw1gxwJvmQLMNcjGFrqon62cdME66SIgYDxmuu5vCnLdBTeC1Le
         uyqXM4rKS+UgC8BPhpNaA2SD1L5er+kxZacitNRCAIB+81g6l95r6PUoCoPmj0QvA9Zk
         DOXBNjCzXiLnCG5p+paRsr/dFD/6IqnsvvwrCavKWzrqxgob36gdq6beYBGVPMYygQDe
         EYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S47R+5rjRzxXYMzXp1UK6jVO2A8+OORRyssP8k3OTaU=;
        b=JZi/6SgTP9CWQG2tr9w4n/nIDiniQGcN7WZ3ePjEVDyrMuNigFfwsgub1VTVHyQCDI
         tdG1WtIaoYnpsoI2k8WQOBiH2Zol3P4qW5ZumI60dUKVFT8j7Qw3Luvf/Z+AvoS46F5b
         25xCcH10LjNxxYHdi4SQQRgkj2f5/JKCVqaddbqsKCF+49nTSoTFyGpCC01Etixekt3v
         Bh95QgiX4rCG8jXEP/X42/qz5fjxyy55WBvyd/lua1cY8BWV+w/6DwIbUfd/EKpO2Mv1
         DrlzZga+ta3XeObfGzKLIDY40MDYUdTVFQsGkao5BrwtMy6QjO4cWKAljJgXZhXW8IG1
         X+hQ==
X-Gm-Message-State: AO0yUKVEhzMHVfUKv3socwcu7FcC81hYZBzRaGpIJOagNJZExlkwUzfJ
        +T2O0HJDpdqTYkMoQhZJ0JQGAw30RsgohA==
X-Google-Smtp-Source: AK7set/hxDQtpBD/6sU2EWJnbnwSchb6GxrEplpuJIeN++ZLnKBZ4/9GOA5kj/HCSL0RzR1bzSURMw==
X-Received: by 2002:a05:600c:3ba7:b0:3df:50eb:7ca6 with SMTP id n39-20020a05600c3ba700b003df50eb7ca6mr3409069wms.15.1675332010587;
        Thu, 02 Feb 2023 02:00:10 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003dc3f07c876sm4419673wmk.46.2023.02.02.02.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 02:00:09 -0800 (PST)
Message-ID: <5698df33-c3f8-19bf-7f99-5091931e5af2@gmail.com>
Date:   Thu, 2 Feb 2023 11:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next] clk: mediatek: clk-mtk: Remove unneeded semicolon
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230202010750.79515-1-yang.lee@linux.alibaba.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230202010750.79515-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2023 02:07, Yang Li wrote:
> ./drivers/clk/mediatek/clk-mtk.c:518:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3926
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/mediatek/clk-mtk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index c90c0a6b501b..14e8b64a32a3 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -515,7 +515,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>   					   mcd->clk_lock, clk_data);
>   		if (r)
>   			goto unregister_factors;
> -	};
> +	}
>   
>   	if (mcd->composite_clks) {
>   		/* We don't check composite_lock because it's optional */
