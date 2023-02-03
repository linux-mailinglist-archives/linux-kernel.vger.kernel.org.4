Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0168A212
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBCSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:36:13 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CDC9EF6;
        Fri,  3 Feb 2023 10:36:12 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15fe106c7c7so7651850fac.8;
        Fri, 03 Feb 2023 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LlHQ1B1QTLPeQlfxsLk6odPLDyO6zb4BJDmUSvIRHT8=;
        b=FNuw0HzzH7DYNxsB5DqqG9B0w1WiQ2dwB7ukC4gITJBqFxxsc3legZ8u/4bsBpywul
         R2zwsSHdvGg2QFLUOZJVVhFLCxltXVw3u3+Dwz3Zlp3dBuyA9G4tlherY8If+Dd7HH/s
         KaXVdEiXZFpIl+6ci91sIVCLspFYlMC9Ucz4Qe6fQBV317C5/Bq3XO8FjALAF2Dv0GVv
         beGzqafEfOKS2FCNCiOcbrFWxOOwJ2B5YAKE6KvLgyeRTa0TPKUcsGVjtxHRkPrUkYjS
         /EwvmnpBv9GvMwSTUCFu8Dx7XsF5ilu5QgpdRv3fvcjM662Pm3VZ8eBTSpA1LijOwN9G
         vzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlHQ1B1QTLPeQlfxsLk6odPLDyO6zb4BJDmUSvIRHT8=;
        b=h7qU8IHG9MgngelWoeQXgrI6QmBWFlWTfZBTbEU+GeKdRrJv53M2xb8kqOgnLSG/J0
         KyqhQqWOfXcCrabDusMKj1hzXoKmzf8D2UzRb9JTSD8Ay9sliF3iiLjBKTwzqlhBhxY5
         991t3J9y+bMz+vbV3CLEE5mzKpRvxT/jztnT5alHL4BBoYZGVixFEY1vUtWqNIdwvj7q
         NeWti0IKeHgwZAcxdeLg77GMcjSSkSYMAlvW4/Bmy4v1BPq2dalnHjBLZJcsvGd/3w9O
         brC2p6RkLDsLrzN1WRhBCd6gjJprBr87cYUhbEgYWrNkNbSJesdie1KT0Sa0haJVWycG
         oJ3A==
X-Gm-Message-State: AO0yUKV5sWsp22P5DFjEfo1csmoAVN5FnSqqxJuUlmhKDhJsmKgRGnAz
        8sr22TeP7ydfwvGGAZb8p3k=
X-Google-Smtp-Source: AK7set8lK4eYQCvIyJS8sko63vywubvSJA5p7hruViXSmz6kTBm3Cjea5Lbj1zlLS7xVzWvKGUmygQ==
X-Received: by 2002:a05:6870:a40a:b0:15e:e1e1:be5a with SMTP id m10-20020a056870a40a00b0015ee1e1be5amr5808677oal.40.1675449371705;
        Fri, 03 Feb 2023 10:36:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a056870618400b0014fc049fc0asm1070930oah.57.2023.02.03.10.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:36:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b86ecef8-c1ed-fd3c-ad5e-e4b3f91b0a8b@roeck-us.net>
Date:   Fri, 3 Feb 2023 10:36:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/5] watchdog: diag288_wdt: de-duplicate diag_stat_inc()
 calls
Content-Language: en-US
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <20230203073958.1585738-5-egorenar@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230203073958.1585738-5-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 23:39, Alexander Egorenkov wrote:
> Call diag_stat_inc() from __diag288() to reduce code duplication.
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/diag288_wdt.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index c717f47dd4c3..a29ad164b27a 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -78,6 +78,8 @@ static int __diag288(unsigned int func, unsigned int timeout,
>   	union register_pair r3 = { .even = action, .odd = len, };
>   	int err;
>   
> +	diag_stat_inc(DIAG_STAT_X288);
> +
>   	err = -EINVAL;
>   	asm volatile(
>   		"	diag	%[r1],%[r3],0x288\n"
> @@ -100,14 +102,12 @@ static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
>   	ASCEBC(cmd_buf, MAX_CMDLEN);
>   	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
>   
> -	diag_stat_inc(DIAG_STAT_X288);
>   	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
>   }
>   
>   static int __diag288_lpar(unsigned int func, unsigned int timeout,
>   			  unsigned long action)
>   {
> -	diag_stat_inc(DIAG_STAT_X288);
>   	return __diag288(func, timeout, action, 0);
>   }
>   
> @@ -135,12 +135,7 @@ static int wdt_start(struct watchdog_device *dev)
>   
>   static int wdt_stop(struct watchdog_device *dev)
>   {
> -	int ret;
> -
> -	diag_stat_inc(DIAG_STAT_X288);
> -	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
> -
> -	return ret;
> +	return __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
>   }
>   
>   static int wdt_ping(struct watchdog_device *dev)

