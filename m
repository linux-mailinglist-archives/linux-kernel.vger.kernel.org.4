Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC46E7498
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjDSIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjDSIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:03:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEE19BF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:03:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so4750374a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681891401; x=1684483401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EI1YComog4rA7OF+HOwhO9/TQv8utz9ZLP9QGa/GLwE=;
        b=r/ucemiZJuDiA5vpi5XomiHMtv/lGO0GnkLNm4C53kw4jG6ytb+TGNdHO9XTDoGOUs
         VvYJ1X1JtgzaYGi9XgFWXkQ3A+ApT7soIbcGRKyYgdohgGSHg+FXQBGVi2lYvtHABEpB
         clVNwJi+jbDlFxKf3VLEKLlopi/ANA0Fmv3NF92L4LYORYz9mZzAnTOX8y3TzutoC5sj
         Fn8rziK56HOhgMn2XwKJHaiF212rbqN0QSH90ElfqeUrQE3rHGbkZkj3it0VXmJLrWWu
         PX1nELYa8XnMgJIhn+12WFmJ6KBycvtQdJhhwnNq+jL2ndof1UUT6jt92itNAsVCJQmy
         bJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681891401; x=1684483401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EI1YComog4rA7OF+HOwhO9/TQv8utz9ZLP9QGa/GLwE=;
        b=Y/Y19LsGlXuguoOA/qsP0b6n9QCPOxAgi1CqLEZCgdZQICGJWqfnaq+dJHA/qlpKax
         lRdDNAaCIrBdbU/AnKHu7S8wB+c9rG6CTxg/43lrmlxxHDkJr5ohynneaQBSj7leydUe
         pFWYwdDyTdCu/4NYuHn+0t+fjfiDhgTltv4AG1rNJJO0+rnlb8aCLQsn+Nm9F9UWws1o
         jKAgAjqntWDcRMnH8aazMWFaQAuLBE7c0GvFFMFLsu1BOGs3jKzHN6cakJVggkMtePhs
         OmqFXaiPSCO5FYmu8PVQrgQRmatnfTO/WKUKoPCWqvQD/WymAyd+RFTCfLI58tyU7o4y
         ZFLw==
X-Gm-Message-State: AAQBX9dgBT8p2uJ1PLeQF/+yrkc0IoJP5GtlRglNcFt98MMejU+jraK5
        Q1IDikOBcUsOsJrE6BLSEMnbQQ==
X-Google-Smtp-Source: AKy350Z89TV9b5CQ5dMks6JPzzIhSrjODtafrwNBlmUmpvdcv/16ARInRyjVls8RymMBKO3tlwL4KQ==
X-Received: by 2002:aa7:c3c8:0:b0:506:85b4:b14b with SMTP id l8-20020aa7c3c8000000b0050685b4b14bmr4800801edr.29.1681891401444;
        Wed, 19 Apr 2023 01:03:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm7861606edc.44.2023.04.19.01.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:03:21 -0700 (PDT)
Message-ID: <41ebe41f-d773-7cc3-dcad-8574c858645e@linaro.org>
Date:   Wed, 19 Apr 2023 10:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] spi: s3c64xx: changed to PIO mode if there is no
 DMA
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
 <CGME20230419062755epcas2p1370c1ca60d88d6b114a7c7c1de3f15c0@epcas2p1.samsung.com>
 <20230419060639.38853-2-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419060639.38853-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:06, Jaewon Kim wrote:
> Polling mode supported with qurik if there was no DMA in the SOC.

typo: quirk
You missed verb in your first part of sentence. I don't understand it.

> However, there are cased where we cannot or do not want to use DMA.
> To support this case, if DMA is not set, it is switched to polling mode.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c                 | 8 ++++++--
>  include/linux/platform_data/spi-s3c64xx.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 71d324ec9a70..273aa02322d9 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -19,7 +19,6 @@
>  #include <linux/platform_data/spi-s3c64xx.h>
>  
>  #define MAX_SPI_PORTS		12
> -#define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>  #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
>  #define AUTOSUSPEND_TIMEOUT	2000
>  
> @@ -116,7 +115,7 @@
>  #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
>  
>  #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
> -#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
> +#define is_polling(x)	(x->cntrlr_info->polling)
>  
>  #define RXBUSY    (1<<2)
>  #define TXBUSY    (1<<3)
> @@ -1067,6 +1066,11 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
>  		sci->num_cs = temp;
>  	}
>  
> +	if (!of_find_property(dev->of_node, "dmas", NULL)) {
> +		dev_warn(dev, "cannot find DMA, changed to PIO mode\n");

You said it is desired option, so should not be a warning. I would make
it debug at most.

> +		sci->polling = 1;



Best regards,
Krzysztof

