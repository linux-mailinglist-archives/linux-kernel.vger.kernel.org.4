Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17C656109
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiLZIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLZIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:14:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61685D50
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:14:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg10so7208078wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCzfV2lLowmRKBZqSSSq8cPnJcFs213oEz2XICgnZKc=;
        b=cOGXV/QWMiQVc+KPExY63omHWJJq1GkeAne7IvJqVDDeJzUsD45+0QWfbck6xSoukW
         OusS1CrZj3uXvPTl3b83aHMJBjzZLi8vqUi7vmT1W9OyEUAhRkM1Z5b/qqB451v4dVB3
         S4To/CWEnSeyDunVqRxMSXEtI9hXhBpmGgK9mPvK/K2VXQYAOd2oZFCKyg5AGD0/Tlkv
         dI6aqOsEbzyYPxUeFNqWgL4cu4UBX8+zwUnTz1dKUcBUcwublooXLdzLzu2bRictfsR4
         C15Z9JXUv8EAeDL3bA5uVTwsr2y2TQyd9kXyoQNLyrVRD7Q1fDMM9ESekFNRhOVV5K2w
         2H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCzfV2lLowmRKBZqSSSq8cPnJcFs213oEz2XICgnZKc=;
        b=UlUWB8ipiZ6kMEaV7FAUGbkdFhl6Y9LYiJ1wwd5Vh7ZaY5s/iMCV4QwGpV1XkalXHD
         N2UuvSXYG67EWinEbr0TqBf/SWVmVdg5fTzcatHWu6y83gV7a9v1iw46IK8MI2xWskD8
         86fNzuH0aeSaxfHMqvzjbHOxpKzBtvQkqQbybRqpFT6Sgk5xx+Csqhw05s3OZJqfvj4t
         mKD042vH+s9bDHrFpL0Ag1+1qn0Mt+s7YumPLr4YL3LeYxJ3yeeoEJpkC97dnHr7VDT8
         DoHPq6DZx6HYKXEUctS9F78tbM8Pv3cMh4KfwhuGur7Tsme/3n8ySOkvcyDMQDD9XEcz
         JISw==
X-Gm-Message-State: AFqh2kqtS0k/eaJExW3GMSOLRmGLQd9fwsXJSub6HslZu7gxo6aHxte6
        /qR94dHsUgbrB4R6dDVFnxj/yw==
X-Google-Smtp-Source: AMrXdXvjwRaGm8hynHIBmBXlnUP4P/nQ1RZiieHLQyJyFU8CAmKYL5GOHlO/UzmI8sLK2KAxvOLYog==
X-Received: by 2002:a05:600c:1d8e:b0:3d6:e23:76a2 with SMTP id p14-20020a05600c1d8e00b003d60e2376a2mr12126175wms.34.1672042464004;
        Mon, 26 Dec 2022 00:14:24 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm19693519wms.11.2022.12.26.00.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 00:14:23 -0800 (PST)
Message-ID: <b35ef623-4914-7bb5-5dde-181f6fe5856e@linaro.org>
Date:   Mon, 26 Dec 2022 10:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Add additional octal-mode page
 program flags to be checked during SFDP 4BAIT parsing
Content-Language: en-US
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-3-nathan.morrison@timesys.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221202135539.271936-3-nathan.morrison@timesys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
> This adds some support for automatically searching a chip's SFDP table for:
you can drop ":"
> 
and this new line
> program commands: 1S-1S-8S, 1S-8S-8S
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>   drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index e4e87815ba94..e1b7547bf81e 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -1089,6 +1089,14 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>   		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_4_4],
>   					SPINOR_OP_PP_1_4_4_4B,
>   					SNOR_PROTO_1_4_4);
> +	if (pp_hwcaps & SNOR_HWCAPS_PP_1_1_8)
> +		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_1_8],
> +					SPINOR_OP_PP_1_1_8_4B,
> +					SNOR_PROTO_1_1_8);
> +	if (pp_hwcaps & SNOR_HWCAPS_PP_1_8_8)
> +		spi_nor_set_pp_settings(&params_pp[SNOR_CMD_PP_1_8_8],
> +					SPINOR_OP_PP_1_8_8_4B,
> +					SNOR_PROTO_1_8_8);

Why did you choose to not add support for reads as well?

>   
>   	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
>   		if (erase_mask & BIT(i))
