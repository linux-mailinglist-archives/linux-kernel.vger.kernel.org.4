Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C764261152B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJ1Out (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJ1Oud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:50:33 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8EC1D87;
        Fri, 28 Oct 2022 07:50:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so3111176otu.1;
        Fri, 28 Oct 2022 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PIsFWzKBPVEUKp5GiGJa8VKu9kPacu1VoLKvCZdTuaA=;
        b=FAHuOAWPC9JSwUoGzF91sXEPX9Voc9tPREcj73XHI0EbQGXuMW/x7P/1DoB9YQCWfL
         DMUGe1GQdXb+vF8nS//0nLPtCQymCGtR48OPds+K92uwfVxD5h2e6XrGVkkSHyvtHI/f
         GX7gs6XtES/8EI6JoowoCdgoHTRrAaTRlkkNVxOfCXi8AefkseFCXfi5OmGC6dVc0E2V
         zFOOWPaUk1cRRw/R0/MgtJBIFcoOPU69fwXaTGQi6zZ4l8dkbTeaA3snDm8F+/csb/5d
         v3ojE3aRkkFGhw9oVEd+uIBpPu6PJ8++IU7rMPc/M/Hp04xjVoCpUoU21soQ9EzBZ2cX
         Vmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIsFWzKBPVEUKp5GiGJa8VKu9kPacu1VoLKvCZdTuaA=;
        b=bNq9MVVhKKoiKGyKuzPQgw8U+0Gb3/2KHMlmb0Av8pcxV/aqgPZQfwIaaY6M53E1Mz
         O8LyoLPowXPte5c/ALhQ7n7mjSElWLxnCQDlAzQ1MXX6R+EgW6QHH+aQCvASiY9cVkcm
         B+K9LgCaiM5ihl9gibi89UPAdOKNd4oBWt8I50j4hHjvYpXKbPJ7lk+IXszGsYyyDscB
         QIraEmGXqRrizAuE7X8mPyo2YaZ+3R9OWPZ6ZD/LnaH6G12Kko0a8SnER8boUTc7RE80
         bwUQT2hPoYLAwSEfOeQiCpIlqa40JQEBoMHXdU79iUG+S77rrwGB4cspdQ0GlZBkjeGF
         /DPQ==
X-Gm-Message-State: ACrzQf2AyMXh6mNVK0ZA3Qqptkz4j6dhmWlhqdKTf8jzXClNLFML/OCy
        aj53GbtKIa7U38OqnOrp9CU=
X-Google-Smtp-Source: AMsMyM5m+3Xw5nly6PEeRDudB3P8tOGILWCNzskNhgonkPYs8D7M8sG2HfQKwXWJ0dPv/TSpfjb3FQ==
X-Received: by 2002:a9d:6b86:0:b0:661:9fde:b0d0 with SMTP id b6-20020a9d6b86000000b006619fdeb0d0mr27706787otq.43.1666968631712;
        Fri, 28 Oct 2022 07:50:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020acab305000000b00354932bae03sm1578086oif.10.2022.10.28.07.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:50:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <67150d82-458e-fd04-1ee4-3c7036b101eb@roeck-us.net>
Date:   Fri, 28 Oct 2022 07:50:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] watchdog: rn5t618: add support for read out bootstatus
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028075019.2757812-1-marcus.folkesson@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221028075019.2757812-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 00:50, Marcus Folkesson wrote:
> The PMIC does store the power-off factor internally.
> Read it out and report it as bootstatus.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rn5t618_wdt.c | 12 ++++++++++++
>   include/linux/mfd/rn5t618.h    |  9 +++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
> index 6e524c8e26a8..40d8ebd8c0ac 100644
> --- a/drivers/watchdog/rn5t618_wdt.c
> +++ b/drivers/watchdog/rn5t618_wdt.c
> @@ -144,6 +144,8 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
>   	struct rn5t618 *rn5t618 = dev_get_drvdata(dev->parent);
>   	struct rn5t618_wdt *wdt;
>   	int min_timeout, max_timeout;
> +	int ret;
> +	unsigned int val;
>   
>   	wdt = devm_kzalloc(dev, sizeof(struct rn5t618_wdt), GFP_KERNEL);
>   	if (!wdt)
> @@ -160,6 +162,16 @@ static int rn5t618_wdt_probe(struct platform_device *pdev)
>   	wdt->wdt_dev.timeout = max_timeout;
>   	wdt->wdt_dev.parent = dev;
>   
> +	/* Read out previous power-off factor */
> +	ret = regmap_read(wdt->rn5t618->regmap, RN5T618_POFFHIS, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & RN5T618_POFFHIS_VINDET)
> +		wdt->wdt_dev.bootstatus = WDIOF_POWERUNDER;
> +	else if (val & RN5T618_POFFHIS_WDG)
> +		wdt->wdt_dev.bootstatus = WDIOF_CARDRESET;
> +
>   	watchdog_set_drvdata(&wdt->wdt_dev, wdt);
>   	watchdog_init_timeout(&wdt->wdt_dev, timeout, dev);
>   	watchdog_set_nowayout(&wdt->wdt_dev, nowayout);
> diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
> index 8aa0bda1af4f..aacb6d51e99c 100644
> --- a/include/linux/mfd/rn5t618.h
> +++ b/include/linux/mfd/rn5t618.h
> @@ -227,6 +227,15 @@
>   #define RN5T618_WATCHDOG_WDOGTIM_S	0
>   #define RN5T618_PWRIRQ_IR_WDOG		BIT(6)
>   
> +#define RN5T618_POFFHIS_PWRON		BIT(0)
> +#define RN5T618_POFFHIS_TSHUT		BIT(1)
> +#define RN5T618_POFFHIS_VINDET		BIT(2)
> +#define RN5T618_POFFHIS_IODET		BIT(3)
> +#define RN5T618_POFFHIS_CPU		BIT(4)
> +#define RN5T618_POFFHIS_WDG		BIT(5)
> +#define RN5T618_POFFHIS_DCLIM		BIT(6)
> +#define RN5T618_POFFHIS_N_OE		BIT(7)
> +
>   enum {
>   	RN5T618_DCDC1,
>   	RN5T618_DCDC2,

