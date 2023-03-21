Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1B6C3A77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCUTaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCUTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:30:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133A23A56;
        Tue, 21 Mar 2023 12:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57FA4B818CC;
        Tue, 21 Mar 2023 19:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461AAC433D2;
        Tue, 21 Mar 2023 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679426992;
        bh=OKN8kbSWPpvrhUxtqKypraEhkhHF4MVPJBKr6a5Rd8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZsG76/AKO+1mjoywTNx+ON7pPgx4fKOyDHJ1IHyP09vljcFCuVPkqr0mB5SKRAj4
         GggNjVDUkd/BY5WV9ynO5fRx6d1/F9iGU9A3gjEX5dzLOvGUItc5d+mFQnp3E8U7S7
         f11PN0v5bvMQuhY/rBLjpbuxwKaH9cXPU2lVmODR/60cVVeNR1tyXtsTWFK/eD/bAk
         BbscdXNkpzbb7ZN+j5miO+0EfQEdRst+tOybJU1/qo8mw/YBaEq2hnApnku+891vPJ
         tVccg84ybCoWmF20YG5Vp3GBqN3txAH/U4rkBTaICc0j8vKAfuHDIm8eUnhLr6qdoR
         b8dnOVavu9e1g==
Date:   Tue, 21 Mar 2023 20:29:49 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] watchdog: s3c2410: remove unused freq_to_wdt and
 s3c2410wdt_is_running functions
Message-ID: <20230321192949.rlegmetszb7rnury@intel.intel>
References: <20230321183439.1826823-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321183439.1826823-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Mar 21, 2023 at 02:34:39PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/watchdog/s3c2410_wdt.c:311:35: error: unused function
>   'freq_to_wdt' [-Werror,-Wunused-function]
> static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
>                                   ^
> drivers/watchdog/s3c2410_wdt.c:446:19: error: unused function
>   's3c2410wdt_is_running' [-Werror,-Wunused-function]
> static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
>                   ^
> These functions are not used, so remove them.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 200ba236a72e..6394dda7a5dc 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -308,11 +308,6 @@ static inline unsigned int s3c2410wdt_max_timeout(struct s3c2410_wdt *wdt)
>  				       / S3C2410_WTCON_MAXDIV);
>  }
>  
> -static inline struct s3c2410_wdt *freq_to_wdt(struct notifier_block *nb)
> -{
> -	return container_of(nb, struct s3c2410_wdt, freq_transition);
> -}
> -
>  static int s3c2410wdt_disable_wdt_reset(struct s3c2410_wdt *wdt, bool mask)
>  {
>  	const u32 mask_val = BIT(wdt->drv_data->mask_bit);
> @@ -443,11 +438,6 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
>  	return 0;
>  }
>  
> -static inline int s3c2410wdt_is_running(struct s3c2410_wdt *wdt)
> -{
> -	return readl(wdt->reg_base + S3C2410_WTCON) & S3C2410_WTCON_ENABLE;
> -}
> -

there is only one instance where this can be actually used in the
driver, but it's inside a dev_info, so no point having it around.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi

>  static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd,
>  				    unsigned int timeout)
>  {
> -- 
> 2.27.0
> 
