Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F665A64C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiLaT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:28:55 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD16548;
        Sat, 31 Dec 2022 11:28:54 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-14fb3809eaeso22307595fac.1;
        Sat, 31 Dec 2022 11:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQ7AyfPAer4tHocfkNpIoTnoiBqH9igwtR2LChVO5ZY=;
        b=ntbKTLsP/wy+ydxusGAX+olVNcJT4ABXdyAi1O5WXf+oRtgBxMrNarkM6Q6N2Nr/xW
         jKW7ksQY3LCGixsldffJOmKYi+0etUvIYX0i28L69/iMEcW7JS90tO9B5/m3hz1Aysfy
         fp6zhJzIRjyHpdyHoIUs0xSFkKYCSz3Gef5XIyNoxGrb3DcF/DN7RdS9tZi4f4GZYdFz
         PQ2cfoR05JmwjnxDfn2WWWXZVmOUVkaHGyv6SLisOTg8tXtBMbuiLA0vdl5WXyy/7Y5t
         fWnx7jUXQft30SpqE2BCT7fWeKsxvxx6J14XbjOpyJgJkOTsIVlnvBVNoR4ICE1ijtso
         OT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ7AyfPAer4tHocfkNpIoTnoiBqH9igwtR2LChVO5ZY=;
        b=u32fGOhzmoxDKO2d1YQcNegUdSscM96KMhdceFeRdD6JdNUnO8x++wcDKESSjcWJ45
         /mTxZ4DBqFnbnqrjYGhltlRnCUpt3eIzF0DU8a4eTo5pl6LgJKp+nWekPADdY7c9qvqo
         rdQMhpKgU41HW9hsigOrdIPlsL72IHuQ1dyunZU0gKYE9wYYx7fWiBNAhhGWuhV57ane
         hfU6iZNYnxfyE1KLzHkafWKW7zXVyOXhVI6x6dfu6r4NPmWxHruXLHNZgD5ADhL739b+
         ibi+hIk3bbREik2IKpYVS2uvYldvYZOMN6Drz366cC1V5JU9ZaDxzvJpztQurrXNahsB
         Im/Q==
X-Gm-Message-State: AFqh2koSSFVca1l+bIfiQcsWs2BL4WJKvx8BfVjvpJJGr/jZMk+VUMJx
        6/KQm4A43hKkncO0p4jp7BM=
X-Google-Smtp-Source: AMrXdXtTH5C2RwI0QuopDmQc59sKqwNLJxOinyUl5HHLseIlN0TTVwobMCVQ1Eb2GZpMw+tJDaLMTA==
X-Received: by 2002:a05:6870:88f:b0:150:21db:43e9 with SMTP id fx15-20020a056870088f00b0015021db43e9mr8171872oab.21.1672514933910;
        Sat, 31 Dec 2022 11:28:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k11-20020a056870350b00b0012b298699dbsm11252071oah.1.2022.12.31.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 11:28:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 31 Dec 2022 11:28:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: armada_37xx: Use devm_clk_get_enabled() helper
Message-ID: <20221231192852.GB3434944@roeck-us.net>
References: <ccb096879a1309b9918ae956d6bdb9668c69bcda.1672473617.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb096879a1309b9918ae956d6bdb9668c69bcda.1672473617.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 09:00:31AM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/armada_37xx_wdt.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
> index ac9fed1ef681..e58652939f8a 100644
> --- a/drivers/watchdog/armada_37xx_wdt.c
> +++ b/drivers/watchdog/armada_37xx_wdt.c
> @@ -246,11 +246,6 @@ static const struct watchdog_ops armada_37xx_wdt_ops = {
>  	.get_timeleft = armada_37xx_wdt_get_timeleft,
>  };
>  
> -static void armada_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static int armada_37xx_wdt_probe(struct platform_device *pdev)
>  {
>  	struct armada_37xx_watchdog *dev;
> @@ -280,18 +275,10 @@ static int armada_37xx_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* init clock */
> -	dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	dev->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
>  
> -	ret = clk_prepare_enable(dev->clk);
> -	if (ret)
> -		return ret;
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       armada_clk_disable_unprepare, dev->clk);
> -	if (ret)
> -		return ret;
> -
>  	dev->clk_rate = clk_get_rate(dev->clk);
>  	if (!dev->clk_rate)
>  		return -EINVAL;
> -- 
> 2.34.1
> 
