Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540D85EA98E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiIZPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiIZPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:03:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B746796AD;
        Mon, 26 Sep 2022 06:35:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l10so6243875plb.10;
        Mon, 26 Sep 2022 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=ggD7TnpsXJGJofAIp7vE7bs8eiKRPjvoWblh+5pKku8=;
        b=ZG4kVIGBwye4Y7d4nsK3abL0LxIzjAzdVzWwH5UtgeOjhwIVUULv7bC7uAp5Ujin8l
         NG1dbQdpiFwKPkvj3atnp9Ng/8AnxVFur8UZ4jlkjsVp4Kzk9b+7JqC2RRYtiS0o/N6c
         X4ri1s/Me0uQB+5b/94Ji8Z32bOrfuuM8Ax4YiuScpqtazi8HXz6+BD50VvohT26uiP7
         qidVIvjWe5WokFM9ChiYKXliYZLL5WJfepYjsLc0DssSuq9HdiY20nf46Xu2qA/F/EID
         Tg9jpogO4WyWBdm2KY6YPavqot1QCgr7qbs+Sd9MrFD0U6r+UzcWtoLyMKNUXLKxYX2Z
         HTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ggD7TnpsXJGJofAIp7vE7bs8eiKRPjvoWblh+5pKku8=;
        b=Ww2PFMH8doqoaEq7nLCtAAlIDaCbt6tjVWfMGIFG2TMTS/CdVl5DQ2BgrsgypCg8AO
         IM+9ncpXpdaIORADYcdCOFCl6CDvmDDpmoBeNWPyoDIGvnJ1XpAkJhLwc/UwTXz17mU6
         36L5ztjy0rebYyXCJOlnk5InXORnkxQr1SWn2gRUKTlgR2J7x9LctQIzRUWMdIaSgxvl
         AFtv1zutRK6HezDV1Gub7UeNhuKV4gu7L9syJZJYyT4SZNjmk/ghyWLblr7kWCMPmTXg
         lIFPadbIM+/uSPLJkBsEa6yVzP2omES8muPhjwCWt7AOwnqbDjuGhU3V5QigVZ0a3nU9
         jZZw==
X-Gm-Message-State: ACrzQf2X+2r+ps/DWPPIVwIJI/LA/CCUKxbh/L8G5HXZT5z2Oq+LMHPc
        7ldXla2CxawzoHh+4wp1vbM6vXsnJtbJ7A==
X-Google-Smtp-Source: AMsMyM57kpidT0oeR+JvYrfDyLqexl2FjlsbFqkrVjc62PEDPHuI6PLBmRu7zlQBCKch6hndYzIFBw==
X-Received: by 2002:a17:902:e5c1:b0:176:c2b3:6a4c with SMTP id u1-20020a170902e5c100b00176c2b36a4cmr22036289plf.87.1664199352367;
        Mon, 26 Sep 2022 06:35:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001755e4278a6sm11118310plk.261.2022.09.26.06.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:35:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8d685b80-d0a1-c3ed-173e-e482f00d8e67@roeck-us.net>
Date:   Mon, 26 Sep 2022 06:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] watchdog: Add __init/__exit annotations to module
 init/exit funcs
Content-Language: en-US
To:     ruanjinjie <ruanjinjie@huawei.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926120429.1333802-1-ruanjinjie@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220926120429.1333802-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 05:04, ruanjinjie wrote:
> Add missing __init/__exit annotations to module init/exit funcs
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

There are way too many patches lately which don't reflect the affected
driver in the subject line. I am not going to respond to those
anymore and ignore them.

Guenter

> ---
>   drivers/watchdog/cpu5wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
> index 688b112e712b..3e4534e8fa4b 100644
> --- a/drivers/watchdog/cpu5wdt.c
> +++ b/drivers/watchdog/cpu5wdt.c
> @@ -242,7 +242,7 @@ static int cpu5wdt_init(void)
>   	return err;
>   }
>   
> -static int cpu5wdt_init_module(void)
> +static int __init cpu5wdt_init_module(void)
>   {
>   	return cpu5wdt_init();
>   }
> @@ -261,7 +261,7 @@ static void cpu5wdt_exit(void)
>   
>   }
>   
> -static void cpu5wdt_exit_module(void)
> +static void __exit cpu5wdt_exit_module(void)
>   {
>   	cpu5wdt_exit();
>   }

