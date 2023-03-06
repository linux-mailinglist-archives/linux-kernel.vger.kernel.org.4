Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22C56ACC27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCFSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCFSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:13:09 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53872004;
        Mon,  6 Mar 2023 10:12:27 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so5853883otv.0;
        Mon, 06 Mar 2023 10:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678126345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o7Km6hVvpMwQf3BH6QKV5d3OIkWTdrcEhgUdK5/6J5o=;
        b=okzJ5YZnheB7snQPTqYQW0cPiclZFjBXoKgKvNTuBPRZbt12uAUdPDgGSKkjiax/18
         fjQ6J45Eg2X5HgN2Pai2Z6DLdheGzMTzyZRdQDXoitag0vGvQEss/1zuL3GjFbUo45IW
         Rdf7Qzd3G8iTfXYvN0Ihh/poCwYHE6UpB9bWmZVzjJouF9YHGEw+LX76P88NELY1e1dl
         mvlRBMu6TdjiCzclsua6rrgjk+519lADGPdNuzNMM2ZTnQZEBy5gYgkrqCBerHvbeRrk
         HooiWDTkRIT9qQSnr3GxqZlA+cuMnil1PYEJuO5wf5hdRXLGpw0RIboGY3a+tKpjvNY9
         7Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7Km6hVvpMwQf3BH6QKV5d3OIkWTdrcEhgUdK5/6J5o=;
        b=Ut69X31021GGkNHx3ZnazxfGcofPEbheVNZs6YI6qQo31JiwfMvOy8PMOFOrz2Gn5B
         4n26GOC/Pw4Xfp0lWsJG4+HM4nNWehyR726qjph/WaFEzQdPcL66nfoFdtcGjOf5Mct3
         Izy1gptkhb4LyBpBWk0/Rd6X04oo5SabsaIN1so+A8MCzIFETLnzzjCSmi9UGS6GIEUx
         t1XBR7DpKXcAYFxvxMEHN0taEZddQj0uHj01Re0jVzZPugGhAx/Sghp0fd2DAHNJjHQH
         YEgpsMLjzbfSnCJJGbvoNjNoGxuuVokVWPNiAULV9onuNHx+qovTmOuWb/CjdGKnonvh
         uXeQ==
X-Gm-Message-State: AO0yUKVaK3YEGN9IL2AIY+HOuNfqxeWHYFaRR7T+rJrujuChit5pYgDs
        gH7RrRuYTHAFjdGdu4RMAhFDlvmSvYY=
X-Google-Smtp-Source: AK7set8e/m9EnPl8NU14A3zQ+BZVcmdRM6XsDa6I9Gzu56p0s1AGJrkOm52a1riMYorovfX7dt8ULA==
X-Received: by 2002:a9d:1b6e:0:b0:684:e788:eca9 with SMTP id l101-20020a9d1b6e000000b00684e788eca9mr5163671otl.17.1678126344814;
        Mon, 06 Mar 2023 10:12:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a056830078a00b00670461b8be4sm4373867ots.33.2023.03.06.10.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:12:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eef4ad5a-17d5-c118-7807-f1054ed78c2d@roeck-us.net>
Date:   Mon, 6 Mar 2023 10:12:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] watchdog: s3c2410_wdt: Fold
 s3c2410_get_wdt_drv_data() into only caller
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel@pengutronix.de, Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
 <20230306090919.2206871-2-u.kleine-koenig@pengutronix.de>
 <312e57b8-d47f-1269-a463-d2a4ef19b212@roeck-us.net>
 <20230306174722.rl2fws2p7pseo465@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230306174722.rl2fws2p7pseo465@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 09:47, Uwe Kleine-König wrote:
> On Mon, Mar 06, 2023 at 09:17:23AM -0800, Guenter Roeck wrote:
>> On 3/6/23 01:09, Uwe Kleine-König wrote:
>>> s3c2410_get_wdt_drv_data() is only called by s3c2410wdt_probe(), so the
>>> implementation of the former can move to the latter.
>>>
>>> scripts/bloat-o-meter reports for this change (on an ARCH=arm
>>> allmodconfig build):
>>>
>>> 	add/remove: 1/1 grow/shrink: 0/2 up/down: 4/-129 (-125)
>>>
>>
>> The reason for separating functions in this case wasn't that the separate function
>> would be called several times. It was to improve code readability. If anything,
>> I would argue that it might sense to split the already lengthy probe function
>> further instead of combining it.
> 
> Agreed. For dev_err_probe() to work the following would be alternatively
> possible:
> 

That looks ok to me.

Thanks,
Guenter

> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 58b262ca4e88..564919717761 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -579,8 +579,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>   	return 0;
>   }
>   
> -static inline const struct s3c2410_wdt_variant *
> -s3c2410_get_wdt_drv_data(struct platform_device *pdev)
> +static inline int
> +s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
>   {
>   	const struct s3c2410_wdt_variant *variant;
>   	struct device *dev = &pdev->dev;
> @@ -603,24 +603,26 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>   					   "samsung,cluster-index", &index);
>   		if (err) {
>   			dev_err(dev, "failed to get cluster index\n");
> -			return NULL;
> +			return -EINVAL;
>   		}
>   
>   		switch (index) {
>   		case 0:
> -			return variant;
> +			break;
>   		case 1:
> -			return (variant == &drv_data_exynos850_cl0) ?
> +			variant = (variant == &drv_data_exynos850_cl0) ?
>   				&drv_data_exynos850_cl1 :
>   				&drv_data_exynosautov9_cl1;
> +			break;
>   		default:
>   			dev_err(dev, "wrong cluster index: %u\n", index);
> -			return NULL;
> +			return -EINVAL;
>   		}
>   	}
>   #endif
> +	wdt->drv_data = variant;
>   
> -	return variant;
> +	return 0;
>   }
>   
>   static void s3c2410wdt_wdt_disable_action(void *data)
> @@ -644,9 +646,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   	spin_lock_init(&wdt->lock);
>   	wdt->wdt_device = s3c2410_wdd;
>   
> -	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
> -	if (!wdt->drv_data)
> -		return -EINVAL;
> +	ret = s3c2410_get_wdt_drv_data(pdev, wdt);
> +	if (ret)
> +		return ret;
>   
>   	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>   		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> 
> I didn't check if it's the same as for my initial patch #1, but for an
> allmodconfig ARCH=arm build this also has a nice bloatometer output:
> 
> 	add/remove: 1/1 grow/shrink: 0/1 up/down: 4/-104 (-100)
> 
> This would allow to make use of dev_err_probe() in
> s3c2410_get_wdt_drv_data() and still maintain the split into two
> functions.
> 
> Best regards
> Uwe
> 

