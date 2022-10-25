Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF460CED2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiJYOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiJYOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:21:42 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88380EB5;
        Tue, 25 Oct 2022 07:21:40 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so1849323oop.3;
        Tue, 25 Oct 2022 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yko5glIn0tdH0ycCuGOetmeeVh4jbYQFoyxurLJH+28=;
        b=XMKh31YujBGTgFvh/3bL/FJZ9lbvUpwDIv8xizLBI3z3Y3cEyBj3Vg+O3dn4cWst1o
         Idcb+RCS3CRObMpknf+nYdmslkuNrsaVhgu7u4XXCxnKGlaHPJknbKTJG82mOPEwiAK/
         U6RH+TxJ4L4dZUFRbl68MesEhLvyf4iYpNT5IAoFy20seD2+eVGLdgUAcW7Cu6e+mz2b
         vCGWR0JSLSOUL44ocBUVdFHL9AY8iqrXp8EsLgxsRjToJ+K+mLku/7itzfJnuOwz3/uf
         kqyZVQeLl3aUH90BMNryZJmBXKU05Nf097iIFbZKz6dw8lchOahxunWA2Mp/hrNk1hf6
         A06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yko5glIn0tdH0ycCuGOetmeeVh4jbYQFoyxurLJH+28=;
        b=WCE36eZTXobY9MlcGMKc6ZrdgLofI6ykJ+P0f0ktX7xyVzT9fE5q95Zn3nnXvoDrDS
         5TLWaUux6rClJvFCKu9tgCWU9uJ4Lw6wOdW9HmpKhtcazYQObvsjlTUegc92wWwWKgry
         k6r6cowaCTjVASZx71IYcj3gkd0AS1OGHaNbgHqzU4B/pDfzLxi3uuM0wygoVOUw6JUE
         1TQJ0pru7mQYtPo/gDYA/5nRhDrLZgLXpbLxnxQtTa1eDKAqbxBiqTh4yr2d3k9zk0yg
         4DnODlf2PQ1ogBqFPxX0NXrRaWeAXTBeqPlZnNNu43ja8qqt8Sa5AESYiw50izVyX/fq
         s1BQ==
X-Gm-Message-State: ACrzQf3KosCPLx08vw3Lj0ZQzitITQzwCFLyvKlnXf85cfc+RQ6PEtQe
        6O+QDOHRuCYIXOnl+0HBVI8=
X-Google-Smtp-Source: AMsMyM4hC9gdelH7FK9R/Gan9m4AcPKmHPKl3Amx7nPKpEUnC5Z0GnU1uvauhxxxuVj1KRRxg9Aq5g==
X-Received: by 2002:a4a:ab0c:0:b0:47f:653f:693e with SMTP id i12-20020a4aab0c000000b0047f653f693emr17114124oon.86.1666707699384;
        Tue, 25 Oct 2022 07:21:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16-20020a056871059000b0012d939eb0bfsm1598376oan.34.2022.10.25.07.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:21:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bea41e17-0269-d88e-fd22-ad5c5a4b8dac@roeck-us.net>
Date:   Tue, 25 Oct 2022 07:21:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-2-andrej.picej@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
In-Reply-To: <20221025072533.2980154-2-andrej.picej@norik.com>
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

On 10/25/22 00:25, Andrej Picej wrote:
> Putting device into the "Suspend-To-Idle" mode causes watchdog to
> trigger and reset the board after set watchdog timeout period elapses.
> 

s/reset/resets/

> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
> watchdog in WAIT mode. This is done by setting WDW bit in WCR
> (Watchdog Control Register) Watchdog operation is restored after exiting

'.' after ')' missing ?

> WAIT mode as expected. WAIT mode coresponds with Linux's

s/coresponds/corresponds/

> "Suspend-To-Idle".
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes in v2:
>   - validate the property with compatible string, as this functionality
>     is not supported by all devices.
> ---
>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index d0c5d47ddede..dd9866c6f1e5 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -35,6 +35,7 @@
>   
>   #define IMX2_WDT_WCR		0x00		/* Control Register */
>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>   #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>   #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>   #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
>   	bool ext_reset;
>   	bool clk_is_on;
>   	bool no_ping;
> +	bool sleep_wait;
> +};
> +
> +static const char * const wdw_boards[] __initconst = {
> +	"fsl,imx25-wdt",
> +	"fsl,imx35-wdt",
> +	"fsl,imx50-wdt",
> +	"fsl,imx51-wdt",
> +	"fsl,imx53-wdt",
> +	"fsl,imx6q-wdt",
> +	"fsl,imx6sl-wdt",
> +	"fsl,imx6sll-wdt",
> +	"fsl,imx6sx-wdt",
> +	"fsl,imx6ul-wdt",
> +	"fsl,imx7d-wdt",
> +	"fsl,imx8mm-wdt",
> +	"fsl,imx8mn-wdt",
> +	"fsl,imx8mp-wdt",
> +	"fsl,imx8mq-wdt",
> +	"fsl,vf610-wdt",
> +	NULL
>   };
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>   
>   	/* Suspend timer in low power mode, write once-only */
>   	val |= IMX2_WDT_WCR_WDZST;
> +	/* Suspend timer in low power WAIT mode, write once-only */
> +	if (wdev->sleep_wait)
> +		val |= IMX2_WDT_WCR_WDW;
>   	/* Strip the old watchdog Time-Out value */
>   	val &= ~IMX2_WDT_WCR_WT;
>   	/* Generate internal chip-level reset if WDOG times out */
> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>   
>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>   						"fsl,ext-reset-output");
> +
> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
> +		if (of_device_compatible_match(dev->of_node, wdw_boards))
> +			wdev->sleep_wait = 1;

Since sleep_wait is bool:
			wdev->sleep_wait = true;

> +		else {
> +			dev_warn(dev, "Warning: Suspending watchdog during " \
> +				"WAIT mode is not supported for this device.\n");

Do not split strings. "Warning:" is redundant. Please handle the error first.

> +			wdev->sleep_wait = 0;

Unnecessary; false by default. Also, this should fail and return -EINVAL.
Devicetree files should be correct, and warning messages tend to be ignored.

> +		}

All branches of if/else need to wither use {} or no {}.

> +	else
> +		wdev->sleep_wait = 0;
> +
Unnecessary.

I would suggest to replace the above code with something like

	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait")) {
		if (!of_device_compatible_match(dev->of_node, wdw_boards)) {
			dev_err(dev, "Suspending watchdog in WAIT mode is not supported for this device\n");
			return -EINVAL;
		}
		wdev->sleep_wait = true;
	}

>   	/*
>   	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
>   	 * during suspend.

I still wonder how that interacts with fsl,suspend-in-wait, but since we have a
property for that we can leave that for someone else to find out. Maybe add a
comment explaining that interaction with "fsl,suspend-in-wait" is unknown.

Thanks,
Guenter

