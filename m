Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE36637FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAJECq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 23:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjAJECj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 23:02:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B2FCF8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 20:02:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s8so3561433plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 20:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Coka7hAOYzARe/xcghtsc60l2UEKbV33rmZ4o8eYoM=;
        b=JiLRLa2a7kAmcgWy8jhB2AmEifcjgFrHTsh6bx0X6F/l32+W8hFjU3Qr/RkmIc6Qco
         z/MaQLfEl8aX4I/db8Ocgw0fvLmpg9RhUKV23TPXaDjQdmCrJhQ3G9PBSZWW0qfVzwHc
         trc36HvaCZVNdbjlqvoSlUUeCX5ygigezg1twjVFLINICSeMNesUKjCAvKW6gR0RmDfp
         a4gfkgN9Yl2ffkvhtWWRBEYY1YKH4kjGGGEwy/4iiGmBHXffEMEPvQsBT5vkzFPkSAof
         WAwXx2wjETK9OsIqP5O0u7cfEL0AReSm7cBYzATPQ4zZLCvUBJgu+ie5NOuQvpKggVkz
         LpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Coka7hAOYzARe/xcghtsc60l2UEKbV33rmZ4o8eYoM=;
        b=ThK8+NHGll+lDIz6MZ4GG55YYDoqV+yrMOFewimn5d453Nc/MLhAJ83jWyCf16LvtS
         Aj5DJxA5ZfC2u9acH2uIf51mxXLiKfcq7jIekIqsZNS57Phgqr5wo9zzvmh8hzWZOiB+
         amlO64xbNWNTUd20w/AumW9LEZoxltTxSGV88BJSpOkt8ylUwZbiEdlBw2vGFBlHVECI
         mGlfvs6S6kl8iO+WgIPj1ENi9m9B7ZsnduP1dowMxlIsIYVArkrmWF5W4376d8ngw9gE
         FwrDYOXow8xRbzzxVl527kLRiqumck+I3J+IU555M8Y/46X5wVfsn2OqeobJKFdTiwYy
         xh8w==
X-Gm-Message-State: AFqh2kr7lb2wkKaJ1s+opfCYyX9qkOSvNGb8eg44FGjmnNTpggmZTatk
        MFubrkUHwSlfyXaeNQ0bIimk5A==
X-Google-Smtp-Source: AMrXdXs1xjzrEaB+nt4ps7YBC4mvRJDyu5uxWxiV2DXp/xxfR5X++ZGtkijDXSTFJWPjIaCxJAjM8w==
X-Received: by 2002:a17:902:b493:b0:189:cb73:75f0 with SMTP id y19-20020a170902b49300b00189cb7375f0mr61280351plr.8.1673323356576;
        Mon, 09 Jan 2023 20:02:36 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001929827731esm6861059plg.201.2023.01.09.20.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 20:02:35 -0800 (PST)
Date:   Tue, 10 Jan 2023 09:32:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: armada-37xx: stop using 0 as NULL pointer
Message-ID: <20230110040233.dm6ldb5qgl2ksiht@vireshk-i7>
References: <20230110031252.5014-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110031252.5014-1-miles.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-23, 11:12, Miles Chen wrote:
> Use NULL for NULL pointer to fix the following sparse warning:
> drivers/cpufreq/armada-37xx-cpufreq.c:448:32: sparse: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index c10fc33b29b1..b74289a95a17 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -445,7 +445,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  		return -ENODEV;
>  	}
>  
> -	clk = clk_get(cpu_dev, 0);
> +	clk = clk_get(cpu_dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
>  		return PTR_ERR(clk);

Applied. Thanks.

-- 
viresh
