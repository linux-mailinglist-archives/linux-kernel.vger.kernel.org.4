Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09CD5EC02E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiI0Kzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiI0Kzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:55:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388D1408E;
        Tue, 27 Sep 2022 03:55:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so2023839pjh.2;
        Tue, 27 Sep 2022 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=ZmmRG6YrZ8hXcye3u5h381H4Djt0FAmwEpe9Y1+zhM0=;
        b=U1u1CvnPZ8uVG534OU/ZOMVlJ5uXseG4UXgCMJt1zuWy4ew3W22D0mYanJ146fF/3M
         Qw39QdCLOXr6hYtZ765c3MHzRGY0KF0fTU8bxqdOZxyVbj+TdfD6Z5YLDsU5R2mZkUpl
         0u6koXreVCQaqFG1YQu7iE3DiwhfQxDFVLiyz0CNZru69NnK/nIB4USCGRFR0HHoW2cl
         PuFjAwBip41LMz1BCNKQ82C35k5e90Iy6uKsz7npF8MFWGPiOaOtm+jHcJFa/dRSCV55
         zvUn3WKP7LWkGbeeOvr+pNWdqhwNj3mAS9a+rtfBCiDpQ27wQixdX4L971GKxc1bFOuP
         /e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ZmmRG6YrZ8hXcye3u5h381H4Djt0FAmwEpe9Y1+zhM0=;
        b=Q+6C0dt9bk2NsntF9czBiRlFadlwscC3CWSReMxts5zeL5CZ0mWrKKn1qqi+knj93P
         dbhKk0wn9oSz1llZlMyhDZMISSLcUopfoCa6rDgC880SObfugWDR3PL9Qv/QSor/GEPz
         0lcrh67NNpio1A5NYbo558jl3WWmR+tbgOrbSI7TKryG10+yfg2k5YW2Qd/AIp4G7zDJ
         ZNEIz2HtDdBxBTR9s3gWczLRquL6Wdb4Zixvxb+MFlpZ6Nr7HJkWme3LrQcd8ea+x1AQ
         u2CFVhJhKvR1spl4Tru2NAMEOOiTnerDzZVNKZ4pt2r9kDY82PZCnGmj3mUaXFmWMTXb
         l0zg==
X-Gm-Message-State: ACrzQf2szVNQlmje/R0q3NDaCicXlOUFW/86mvfSPrGOfS73b94mejzC
        1ApNyMslj9s/WU0rcnSv7qk=
X-Google-Smtp-Source: AMsMyM4vcP/N7bKJubPwbDWnQCwhIR+2O9kSQCkO5h1QunWWNhyPjWEbWS68EqXMAFlkgZG2Dkukgw==
X-Received: by 2002:a17:90b:350d:b0:202:ff91:a0bd with SMTP id ls13-20020a17090b350d00b00202ff91a0bdmr3971878pjb.46.1664276136771;
        Tue, 27 Sep 2022 03:55:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b00177e5d83d3dsm1220916plh.170.2022.09.27.03.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:55:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b308e474-505d-0e53-ff13-fc53f1afa46b@roeck-us.net>
Date:   Tue, 27 Sep 2022 03:55:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] watchdog: twl4030_wdt: add missing of.h include
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-2-dmitry.torokhov@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220927052217.2784593-2-dmitry.torokhov@gmail.com>
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

On 9/26/22 22:22, Dmitry Torokhov wrote:
> The driver is using of_device_id and therefore needs to include
> of.h header. We used to get this definition indirectly via inclusion
> of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
> from unnecessary includes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/twl4030_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
> index 355e428c0b99..e715ac1369a0 100644
> --- a/drivers/watchdog/twl4030_wdt.c
> +++ b/drivers/watchdog/twl4030_wdt.c
> @@ -9,6 +9,7 @@
>   #include <linux/types.h>
>   #include <linux/slab.h>
>   #include <linux/kernel.h>
> +#include <linux/of.h>
>   #include <linux/watchdog.h>
>   #include <linux/platform_device.h>
>   #include <linux/mfd/twl.h>

