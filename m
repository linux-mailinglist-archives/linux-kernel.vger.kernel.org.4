Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB568F1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjBHPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjBHPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:10:43 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39438E95;
        Wed,  8 Feb 2023 07:10:39 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-16aa71c1600so1636455fac.11;
        Wed, 08 Feb 2023 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rMOh+YWDoT20q0bU4h7O0uaMSnzV9l0gaPz7VD0hjmg=;
        b=N6T/xM1nlVfGtGs71rjZQEgiZQqzArFXPD/VIVvWYLf2GmnmRRj7h0H0qfzLr7KWWv
         Fy1N/0e2ua24zuT6QvppM/D0ixY5y8WQ0AFWGWSWQ5iVTHyzQVEh9CUrJFId93eIS4m0
         hfQs2IBYhT+48RV9fP5F5lBed7iDCCrdY4QQagI2tuBzWA75UW5XhZ5CbKCr4Qv53dUH
         9A6ReNKAV+Val/OM5gY7YnOl/2egJPAK1r9UIn470LdXUW6Gql/Ru9SV8eXVQqZSrIKX
         ELb1JrrZWMvMqELVENPg+OA/+Y+WuG94LBZMddvQ9/upsjoBtGsQueM5n1ikaxHgfl2/
         iVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMOh+YWDoT20q0bU4h7O0uaMSnzV9l0gaPz7VD0hjmg=;
        b=g9Umt26rHYJYhFLY8V9Vn1N2b9rSuE4Op+6wh3YfYpuQV0Z0XRG9+H6Pw70/1vv+qJ
         L0Nagvjc9Z1w/vfQVn1hRqOplAuICVO1XX+zfDzQyC3p79XT6NUMseaJinFxNZJldAYe
         b++YSdZ0Lbfbxfg9XZcelHF4Hb6bhECZbp+CH98uPt1zd6GzK9tbLvjbR0mrYor5821A
         Lq6J9PgcpqGBoY2IJMMkcwgqiOcdzlZRBRbHrXjPPsm1RNp38KjS+x5KdjFYvSEZaErm
         6YPi/Su0JhEz9MOdn99ZeOaz7n9OnRnFAENn4lfRRPyxsS4gmyjtaA0djHUryNiqpT+6
         xp3w==
X-Gm-Message-State: AO0yUKUvjdRWBdg/mY1X+C0/GeBzHYJ4bEJvbnatqA/mpJulEX4cilsd
        YDju6ye4PgVMG3NDg2A7NGs8SFMf2Wc=
X-Google-Smtp-Source: AK7set8g6X8ya1YyHzAHzThnVsGac9b1O1Rt71iMRSbGd/7Y2f1fG0XZzjJv6emprULtB+eFs2EpSQ==
X-Received: by 2002:a05:6871:8e:b0:16a:af93:9ae6 with SMTP id u14-20020a056871008e00b0016aaf939ae6mr134955oaa.9.1675869038204;
        Wed, 08 Feb 2023 07:10:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d70c1000000b006863c59f685sm8229834otj.28.2023.02.08.07.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:10:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2f2dcb7c-e5bc-7e97-71e0-eebdc72fbd03@roeck-us.net>
Date:   Wed, 8 Feb 2023 07:10:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout programming
 is within the limits
Content-Language: en-US
To:     George Cherian <george.cherian@marvell.com>,
        wim@linux-watchdog.org, zhangshaokun@hisilicon.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208083736.1237256-1-george.cherian@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230208083736.1237256-1-george.cherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 00:37, George Cherian wrote:
> Make sure to honour the max_hw_heartbeat_ms while programming the timeout
> value to WOR. Clamp the timeout passed to sbsa_gwdt_set_timeout() to
> make sure the programmed value is within the permissible range.
> 
> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> ---
>   drivers/watchdog/sbsa_gwdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 9791c74aebd4..ee1039a652f1 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -149,6 +149,7 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>   {
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
>   
> +	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
>   	wdd->timeout = timeout;
>   

Wrong order. wdd->timeout should still contain the requested timeout.

Guenter

