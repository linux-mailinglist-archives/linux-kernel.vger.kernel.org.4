Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5C6EB05D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDURNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDURNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:13:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A968E79;
        Fri, 21 Apr 2023 10:13:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b733fd00bso2099273b3a.0;
        Fri, 21 Apr 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682097201; x=1684689201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtv/plYjg6t5+KIhqn4HLpoeS3qH6YTzNA/OWZvr4S0=;
        b=FjEVhsbuInMEEPWXdLhRhcGP7c0Mf3zoia/8MpkI3FFi8bXXeWe4n6ptt+1a4zdrg5
         FNqYWJH1xCmVEZhstLN2AY9j/okpz1gYfJeSgdtNavogVsNgAQ5R8ZrEmOeH9LRu9LZ8
         FkvW9GQk6BZqdH44lftdYbIwBPC3Z4QCmMjJg12Yt7CJ2UvD21aHSDyI6cqr0NPtz2Od
         xglJwazptN44LPeHcJJjTDu2mrW5MEeUfV5ul8U1vlx9SIjIlN0N5LeTPodvIpPNG7HS
         NY6kGx+cCheUAowDO9nGtRHddThNXORJLc8DkvNUmRM7XeJCoOhtQsFLA2muTX8IIU0T
         IFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097201; x=1684689201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtv/plYjg6t5+KIhqn4HLpoeS3qH6YTzNA/OWZvr4S0=;
        b=H2KVl4tz8/8w2stM+fbx9KxKAqSMNrfSyfmmTtjh6Nj0FsegR/+1rKQayTecX1GVsy
         NouaPcaaL7rEJEecTQUmK3JVGSvNUd0HE8+Q8Zc262dF7ZiacGpDTJA8mciskbV7dF8O
         dJABDmin8b62Y8bytgy/0av3tsi01xDdT7FYY/t8SYLHVUNs8oefH6kUHHSi5x5SV6Bf
         WDKbRJ5LHUgpJY0p11Tdlc5aUGNn2TxR61vlTJekNb2bEUkxDKnVrHanNqsSxRQJ32q3
         0SmoonUPe6zwlREpV30+wsrRn+jvg00mg0eNy1Z/bBgi70bJmUaFWq+G5+BQFv/bVg1j
         kkgA==
X-Gm-Message-State: AAQBX9f3l5NnFYFoaMvRc+KgKS064OA5ps126k/v3T8d6SImXzqRfVdO
        jCzKiagrx50MuuU/IP/+Obc=
X-Google-Smtp-Source: AKy350aW0P/FC8UFKP2uDVDZSV2ognzE+Ons42k3+QvxKksi2a70BP+43x0RqhleMO7/CgeLtZL1Fw==
X-Received: by 2002:a17:90a:9708:b0:22c:59c3:8694 with SMTP id x8-20020a17090a970800b0022c59c38694mr5906384pjo.44.1682097201450;
        Fri, 21 Apr 2023 10:13:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y18-20020a17090aa41200b00244991b3f7asm5549150pjp.1.2023.04.21.10.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:13:20 -0700 (PDT)
Message-ID: <24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com>
Date:   Fri, 21 Apr 2023 10:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>
Cc:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
References: <20230420121615.967487-1-d-gole@ti.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230420121615.967487-1-d-gole@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 05:16, Dhruva Gole wrote:
> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> it may introduce build issues with certain configs where it maybe disabled
> This is because if above config is not enabled the suspend-resume
> functions are never part of the code but the bcm63xx_spi_pm_ops struct
> still inits them to non-existent suspend-resume functions.
> 
> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   drivers/spi/spi-bcm63xx.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 96633a0051b1..99395932074c 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -617,7 +617,6 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
>   	clk_disable_unprepare(bs->clk);
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int bcm63xx_spi_suspend(struct device *dev)

Don't we need a __maybe_unused here?
-- 
Florian

