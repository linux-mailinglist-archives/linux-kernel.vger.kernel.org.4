Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81396E6BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjDRSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjDRSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:20:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C22D322;
        Tue, 18 Apr 2023 11:20:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a6817adde4so19150575ad.0;
        Tue, 18 Apr 2023 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681842056; x=1684434056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AH0TpKDtLnnoQWPri1ZhhTxjG7Fc+I3Y2nyNsAN+4Fw=;
        b=IvYjB71pbcp0z+78PrlZ2Y5TymaWlrTw3SBJs+TZmwsH9pWcCptejiPv/mltgkT3EJ
         OOBaqI9nh7U3cOVTj+rVEdvZyPSlgCS6wRaZf1DuHRki7s4IVGUK5Ig9paGUqhoW+xbU
         bNyZdPRqaY6hnZ3ZKOKO8vMY62eWrnRcX/o7ReUpl0pE/2DgAsB5+IbnTZ4+FuWrVbH4
         4vrgvJyDlKwasBKuOfbZxaMRO95c3sFusPrdQYEPQ0XAlF/HMY7eW51pcekpBZB0iX0h
         A3R+CEkz2NeewJ6H2KyPqHQK/h2OEaSjdSPPhiw6h+CgacRhkOYYDAnwzjoxu7jU/iUl
         +qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842056; x=1684434056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH0TpKDtLnnoQWPri1ZhhTxjG7Fc+I3Y2nyNsAN+4Fw=;
        b=I8MoN445iVO5vx/P9o0LU5/Vw7gB85nZ505M0aosot2JMq+4qx09n7pevI7SJcDT15
         LenHuSD7LTUdT/BkBj1Tktjmm8vWEAfJJH62gPuXGQW1cVBigY+F51c0g7qJ2n2J0d7d
         ipMaBqxdwmlXFWi21CbSLPvcxAGc4C5L8K0Hr4Fs2KIENymqiCBqOwH8n36I0udaXt3b
         VwQouejANwmoAGq84ILF/BcwL8d/t04bAcsxiqlpAyo4hctjhjAd90+8VdBnd8YcnTAL
         qoamVSP+J+CZW4ZNyrt0LU2+gpPhp8NN99eLFPxcEHN0/4QOgNk7wBh1+5JtiId20Bes
         yhcw==
X-Gm-Message-State: AAQBX9evnoP6LEIDqLg3SpmUIlnyvO2zUNCQmWSYPek6aMGOGcwQ0m6V
        wOXV1UYA3EEi/eosWhywDzc=
X-Google-Smtp-Source: AKy350bQm5yZ8CsJoiZ77tZLOb/9F1nbeG+sxzgbvOQHJ1GYVHnlI+vSTOHHgK0C06T9ktSJKdt2JA==
X-Received: by 2002:a17:902:e887:b0:1a2:85f0:e73d with SMTP id w7-20020a170902e88700b001a285f0e73dmr3241496plg.33.1681842056173;
        Tue, 18 Apr 2023 11:20:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b001a634e79af0sm9816371plb.283.2023.04.18.11.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:20:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed83c3a3-1189-3d8d-08b5-014bcfce88cc@roeck-us.net>
Date:   Tue, 18 Apr 2023 11:20:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] watchdog: menz069_wdt: fix watchdog initialisation
Content-Language: en-US
To:     Johannes Thumshirn <jth@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230418172531.177349-1-jth@kernel.org>
 <20230418172531.177349-2-jth@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230418172531.177349-2-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 10:25, Johannes Thumshirn wrote:
> Doing a 'cat /dev/watchdog0' with menz069_wdt as watchdog0 will result in
> a NULL pointer dereference.
> 
> This happens because we're passing the wrong pointer to
> watchdog_register_device(). Fix this by getting rid of the static
> watchdog_device structure and use the one embedded into the driver's
> per-instance private data.
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/menz69_wdt.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
> index 8973f98bc6a5..bca0938f3429 100644
> --- a/drivers/watchdog/menz69_wdt.c
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -98,14 +98,6 @@ static const struct watchdog_ops men_z069_ops = {
>   	.set_timeout = men_z069_wdt_set_timeout,
>   };
>   
> -static struct watchdog_device men_z069_wdt = {
> -	.info = &men_z069_info,
> -	.ops = &men_z069_ops,
> -	.timeout = MEN_Z069_DEFAULT_TIMEOUT,
> -	.min_timeout = 1,
> -	.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ,
> -};
> -
>   static int men_z069_probe(struct mcb_device *dev,
>   			  const struct mcb_device_id *id)
>   {
> @@ -125,15 +117,19 @@ static int men_z069_probe(struct mcb_device *dev,
>   		goto release_mem;
>   
>   	drv->mem = mem;
> +	drv->wdt.info = &men_z069_info;
> +	drv->wdt.ops = &men_z069_ops;
> +	drv->wdt.timeout = MEN_Z069_DEFAULT_TIMEOUT;
> +	drv->wdt.min_timeout = 1;
> +	drv->wdt.max_timeout = MEN_Z069_WDT_COUNTER_MAX / MEN_Z069_TIMER_FREQ;
>   
> -	drv->wdt = men_z069_wdt;
>   	watchdog_init_timeout(&drv->wdt, 0, &dev->dev);
>   	watchdog_set_nowayout(&drv->wdt, nowayout);
>   	watchdog_set_drvdata(&drv->wdt, drv);
>   	drv->wdt.parent = &dev->dev;
>   	mcb_set_drvdata(dev, drv);
>   
> -	return watchdog_register_device(&men_z069_wdt);
> +	return watchdog_register_device(&drv->wdt);
>   
>   release_mem:
>   	mcb_release_mem(mem);

