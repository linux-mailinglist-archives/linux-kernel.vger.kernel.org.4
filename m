Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDFF63287F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKUPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKUPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:43:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0DB9636
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:43:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x17so7000675wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2lIGlwcvsCZa9IcKo7MgrHT6cVmzxMA6TTWsMTFuyA=;
        b=SQNXv+al5NAgzXmoSIlSRMh5Az4zjemYDhPwzrQdgHLcKwZu8w5OIBKViycqriQkBN
         Vdh2og/8cCf8/66kVpPm9A7+27DN/9Fiunvp7VRXEmuESt9CD33tmWiGwvuZNXdoZU6y
         7kElMsvfa4SbhSZc/QNGhVtL/geinCVN7vgzKEnGnxA3AhUbZoMFJ5DYh8UHZ34mN46M
         +IqEVxe6lyYVhjK4JezThrxx17x6d54Vh3VUMPjqjLosdBP9B3fThzxIg9aF3EEuvt6I
         a94QmISZX0Da8eT5Bou71jh1CKbkmYKX9PFNimWF/48lg09R5E1ZnZoFC5z/VvbCoTWY
         aQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2lIGlwcvsCZa9IcKo7MgrHT6cVmzxMA6TTWsMTFuyA=;
        b=uIKQb+oa/8dAHJGNhDhgitYfBdvhaYZCntA4Yv9f+XT7DhXIoegDBiASxQCWU9f0A/
         +mZLUyMt+RwcT9PE2066Nx05T1PyQ9SQGIkYwn7R54wRYXHVdlx0rSoizP6UXHVPzq83
         4oQ93LQvNnRn6VNapxiddk6YeMKqtDN+rTE9OQdUH9oZ43KgKChdSz8i+b4cpFouv5zG
         duFzzh16M2AA1IA32dlaSDPTJwClHD31Pkm9wrpigA8RITK+R6Dcb/3LVfbyIpRfsO+T
         nielMYSTIFTtqjwowdj5cec+zwThnmW32+JEkacJOv3I3qaXWSiL3z3TUoO97IMXqx0W
         rx5Q==
X-Gm-Message-State: ANoB5pmriPb4+NgiHBxLMzlR2cxHhl7hX5sGwkpiw+roP5RfDA0KOigd
        ZnkUbGyPj7LCYrgJEp25Vc1CoZ0ZWQq/iw==
X-Google-Smtp-Source: AA0mqf4ntZh4kH2zh2P3K0YmZa58vopdhnQOfQpnr59oiFjsoJ9dGaVRr6/+xEXN+ItxC32qiL7gqw==
X-Received: by 2002:a5d:58cc:0:b0:236:5c6c:1e06 with SMTP id o12-20020a5d58cc000000b002365c6c1e06mr709597wrf.156.1669045407991;
        Mon, 21 Nov 2022 07:43:27 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003cf9bf5208esm20551850wmb.19.2022.11.21.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:43:27 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:43:25 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Message-ID: <Y3ucncQOBNHpZaxn@linaro.org>
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-28 14:41:08, Rasmus Villemoes wrote:
> We have an imx8mp-based board with an external gpio-triggered
> watchdog. Currently, we don't get to handle that in time before it
> resets the board.
> 
> The probe of the watchdog device gets deferred because the SOC's GPIO
> controller is not yet ready, and the probe of that in turn gets deferred
> because its clock provider (namely, this driver) is not yet
> ready. Altogether, the watchdog does not get handled until the late
> initcall deferred_probe_initcall has made sure all leftover devices
> have been probed, and that's way too late.
> 
> Aside from being necessary for our board, this also reduces total boot
> time because fewer device probes get deferred.
> 

I'm gonna be honest here. I can't say I'm happy with this.
I would suggest finding a solution to disable the external watchdog
before booting the kernel, up until the driver probes, would be preferable
to me.

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> It would probably be reasonable to do the same to the other imx8m* clk
> drivers, but I don't have any such hardware to test on.
> 
>  drivers/clk/imx/clk-imx8mp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index e89db568f5a8..9ddd39a664cc 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -734,7 +734,19 @@ static struct platform_driver imx8mp_clk_driver = {
>  		.of_match_table = imx8mp_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mp_clk_driver);
> +
> +static int __init imx8mp_clk_init(void)
> +{
> +	return platform_driver_register(&imx8mp_clk_driver);
> +}
> +arch_initcall(imx8mp_clk_init);
> +
> +static void __exit imx8mp_clk_exit(void)
> +{
> +	platform_driver_unregister(&imx8mp_clk_driver);
> +}
> +module_exit(imx8mp_clk_exit);
> +
>  module_param(mcore_booted, bool, S_IRUGO);
>  MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
>  
> -- 
> 2.37.2
> 
