Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C65E94B9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiIYRQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:16:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32F2A246;
        Sun, 25 Sep 2022 10:16:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w13so4340147plp.1;
        Sun, 25 Sep 2022 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=cAWoSxV01DSqzDLGfFIAIAzJD4q1tgSNRGX94We2sVw=;
        b=Disfb/IA+owXtPNj7O8fZ1BJnd0IKv6cilNgDNxqDEros6eIolf9yaUM6nVBkmh5/V
         yjKNaw90kitG3Ju4egCb8f/I1ONzDTS7HkWMwIMfdbZcwE1XHVEa8V0exl2lwbfbJLmH
         aUIRkEvsnXE/zUiDJ0GVU5uwCtj+p46atsBfo4gBWGTuVVUTduQIFaP5CJrdao+Q7sZ/
         ULGFWEXqwso0ASYsB1uHQFhqoNSSc7Lx4IUotnaG24H7CDqCidt0sAW1KPqym759V9/0
         DH56BamLiCaFYARHik2WdsBQW1jtHX5chm1kQ9eTopezAAOcpjnAk1/ACCKTdNOOfzzl
         rSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cAWoSxV01DSqzDLGfFIAIAzJD4q1tgSNRGX94We2sVw=;
        b=oEXHe+lY+t3GSMSbiwbXMOBYTRi4r/AjiU0bkF4xYsEr+NJepL5Uykr5tEzvtXc/WQ
         HkxGK1FZcGAyiPZbUKixdEPWtewYnFSWQvRMRDenT4uFCYQWLElkwLZESkwQLz3JS5Bk
         Trq4JAE+kXlcgN0bY7QbHbwvqEqPO5bR9I4Wu7vdAnR5Hi+Wf7LO8+DcuZcEwJYT0YaZ
         /Bb+Xw/lg1o7jlV5DKNpQ0++waDn1dI79Td79Yy7eZCGHipz5pphDUGuDzPZZZdkaVQX
         OBH5a2zHX5kGnOzHb1tLrrUlQ2jNzpxWnT+a8IaqOkqaMjuZPyyGg2628iyq0US9lkve
         AU0g==
X-Gm-Message-State: ACrzQf3WHWX+sobpu9LQZqwmvgqH/XkA156/96LgCB4n+c0KY6CsLlri
        usQwdPYrMEG8/atDMpBM4o8=
X-Google-Smtp-Source: AMsMyM6FD4C6LNoTsdyxxqkCYxbOEKdgq/TtrFij4r7TYfj1LHlupvoe52NOIIESWq1Zo836XnANwA==
X-Received: by 2002:a17:902:ce8f:b0:176:e0b3:cf14 with SMTP id f15-20020a170902ce8f00b00176e0b3cf14mr17909884plg.153.1664126177826;
        Sun, 25 Sep 2022 10:16:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b0015e8d4eb219sm9712887ple.99.2022.09.25.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:16:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:16:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        cniedermaier@dh-electronics.com
Subject: Re: [PATCH v5 3/5] watchdog: da9062: reset board on watchdog timeout
Message-ID: <20220925171616.GA1762624@roeck-us.net>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-3-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206064732.280375-3-andrej.picej@norik.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:47:30AM +0100, Andrej Picej wrote:
> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the behaviour
> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
> 
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
> 
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9061/2 multi function device.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Depends on changes to be made in mfd driver.

Guenter

> ---
> Changes in v5:
>  - fix spelling mistake in commit message
> 
> Changes in v4:
>  - move the code to probe function
> 
> Changes in v3:
>  - no changes
> 
> Changes in v2:
>  - don't force the "reset" for all da9062-watchdog users, instead add DT
>    binding where the behavior can be selected
> ---
>  drivers/watchdog/da9062_wdt.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index f02cbd530538..bd85f84b0fd4 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -195,8 +195,11 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	unsigned int timeout;
> +	unsigned int mask;
>  	struct da9062 *chip;
>  	struct da9062_watchdog *wdt;
> +	int ret;
> +	u32 val;
>  
>  	chip = dev_get_drvdata(dev->parent);
>  	if (!chip)
> @@ -236,6 +239,30 @@ static int da9062_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
>  	}
>  
> +	/*
> +	 * Configure what happens on watchdog timeout. Can be specified with
> +	 * "dlg,wdt-sd" dt-binding (0 -> POWERDOWN, 1 -> SHUTDOWN).
> +	 * If "dlg,wdt-sd" dt-binding is NOT set use the default.
> +	 */
> +	ret = device_property_read_u32(dev, "dlg,wdt-sd", &val);
> +	if (!ret) {
> +		if (val)
> +			/* Use da9062's SHUTDOWN mode */
> +			mask = DA9062AA_WATCHDOG_SD_MASK;
> +		else
> +			/* Use da9062's POWERDOWN mode. */
> +			mask = 0x0;
> +
> +		ret = regmap_update_bits(wdt->hw->regmap,
> +						DA9062AA_CONFIG_I,
> +						DA9062AA_WATCHDOG_SD_MASK,
> +						mask);
> +
> +		if (ret)
> +			dev_err(dev, "failed to set wdt reset mode: %d\n",
> +				ret);
> +	}
> +
>  	return devm_watchdog_register_device(dev, &wdt->wdtdev);
>  }
>  
