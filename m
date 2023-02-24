Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E706A1C03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBXMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBXMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:17:32 -0500
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08F671F0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:17:30 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 3414a7d8-b43d-11ed-bd9b-005056bd6ce9;
        Fri, 24 Feb 2023 14:17:28 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Fri, 24 Feb 2023 14:17:27 +0200
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, tony@atomide.com,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH 2/2] mfd: tps65219: Add gpio cell instance
Message-ID: <Y/iq18rYjLwnkBrp@surfacebook>
References: <20230224113837.874264-1-jneanne@baylibre.com>
 <20230224113837.874264-3-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224113837.874264-3-jneanne@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 24, 2023 at 12:38:37PM +0100, Jerome Neanne kirjoitti:
> tps65219 PMIC GPIOs are exposed in a standard way:
> gpiodetect
> gpiochip0 [tps65219-gpio] (3 lines)
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

Same issues with the commit message as per previous patch.

...

> @@ -267,6 +267,11 @@ static int tps65219_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to add gpio: %d\n", ret);
> +		return ret;
> +	}

Isn't it a dead code?

-- 
With Best Regards,
Andy Shevchenko


