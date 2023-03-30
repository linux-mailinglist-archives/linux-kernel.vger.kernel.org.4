Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B16D098B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjC3P3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjC3P3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:29:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88DFD53F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:28:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t4so14264060wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680190078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joCip0hgL7xwcz+Q/IuuPNmM7IZjW2wMJ1D/KD8FBM0=;
        b=XG5T7gYrQqnnoZ6a7ie67subhNP3NBDLbOnqq4gAt3xMuOrUggu3eNyGIoS0+k++7D
         KUL990rertiK5NROjffUp6UE9h9/5APy1PxLijrtQp7B0ZCWleyRJLnxOMD7DO6fDAsg
         VZGeEOonocrBNs5OH61vuOgfjVk1O9f2oZN+uo1AI/UEMSY9s0snZrblN22Wix5Js4no
         ymCU3lWDdBC9X1iu2ttDjyYxH310+8rE5KuZ5ifSDrLhhJmG5hXSeucFNR3Ncaqw7Dvo
         hhscCDzX03MQBZa2zPBtNE5ud+WJgEiLOVBG3sOblP4gAyzCuJfgOT8gHZmhDJBWIkyH
         hzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joCip0hgL7xwcz+Q/IuuPNmM7IZjW2wMJ1D/KD8FBM0=;
        b=VWP381XwlX6OjJH9CF1s9O/jeK/upbYyGSwrpJ2xD/Y0SJ/5FJCNuroWsr62o6NLrh
         /J3kjpwL9Z87ArsvIQquEWK5wTJfqHNLgiwywQwBidpcVfXKxr/usqyxzMEdLjw95zH8
         zggKlTBRwUivKuz3FodKAnJ/a34wewWrKAATXw9MGF85mh+uv/cHyZIvOmfQiJsESrpG
         VTMppigM4adbX7EC+sEh4AXm/f93A24QDypBSCWVWDwFmQffVFsxYIDyB71EV8aMJodw
         uEkfEV9JS30Ej+oHXD3MsIkcbr3nlcfhNk3jcfXhCcRiLsaMd/+twwGU6b18sU+mAtKX
         WBvg==
X-Gm-Message-State: AAQBX9eFAaJ6AQTmvjzSfWyp8Em7TElu9dWNnbkz1aNeSKzJi1bvwTfS
        g8+I1dWlLiFdvhd+/5uT9A8=
X-Google-Smtp-Source: AKy350ZaFyyyVCzmsQ+2q2PRy65fh3V8kfaKnSsDy0pCnxxiCi+rX7kC+5asDy/aNlXMF1OrZTGtcg==
X-Received: by 2002:a05:6000:c:b0:2c7:ae57:5acc with SMTP id h12-20020a056000000c00b002c7ae575accmr18052849wrx.26.1680190077878;
        Thu, 30 Mar 2023 08:27:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm6566254wmb.28.2023.03.30.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:27:57 -0700 (PDT)
Date:   Thu, 30 Mar 2023 18:23:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:11:25PM +0500, Khadija Kamran wrote:
> Linux kernel coding-style suggests to fix your program if it needs more
> than 3 levels of indentation. Due to indentation, line length also
> exceeds 100 columns, resulting in issues reported by checkpatch.
> 
> Refactor the arche_platform_wd_irq() function and reduce the indentation
> with the help of goto statement.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
>  1 file changed, 41 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index a64c1af091b0..dde30c8da1a1 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  
>  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
>  
> -	if (gpiod_get_value(arche_pdata->wake_detect)) {
> -		/* wake/detect rising */
> +	if (!gpiod_get_value(arche_pdata->wake_detect))
> +		goto falling;
>  
> +	/* wake/detect rising */
> +
> +	/*
> +	 * If wake/detect line goes high after low, within less than
> +	 * 30msec, then standby boot sequence is initiated, which is not
> +	 * supported/implemented as of now. So ignore it.
> +	 */
> +	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> +		goto out;

This checks that we are in WD_STATE_BOOT_INIT state.

> +
> +	if (time_before(jiffies,
> +			arche_pdata->wake_detect_start +
> +			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> +		arche_platform_set_wake_detect_state(arche_pdata,
> +						     WD_STATE_IDLE);
> +		got out;
> +	}
> +
> +	/* Check we are not in middle of irq thread already */
> +	if (arche_pdata->wake_detect_state !=
> +			WD_STATE_COLDBOOT_START) {

This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
we going to be in COLDBOOT if we are in INIT?  Is this changing in the
background?  Can this check be removed?  This might be took tricky to
answer but it's important that we understand this before we continue.


> +		arche_platform_set_wake_detect_state(arche_pdata,
> +						     WD_STATE_COLDBOOT_TRIG);
> +		rc = IRQ_WAKE_THREAD;
> +		goto out;
> +	}

Let's assume the above check cannot be removed.

In the original code if gpiod_get_value(arche_pdata->wake_detect)
returned true and arche_pdata->wake_detect_state == WD_STATE_IDLE then
it just returned without doing anything, but now we fall through to the
falling: label below.

So this patch seems like it introduces a bug, but actually it might just
have a dead code problem.

regards,
dan carpenter

> +
> +falling:
> +	/* wake/detect falling */
> +	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> +		arche_pdata->wake_detect_start = jiffies;
>  		/*
> -		 * If wake/detect line goes high after low, within less than
> -		 * 30msec, then standby boot sequence is initiated, which is not
> -		 * supported/implemented as of now. So ignore it.
> +		 * In the beginning, when wake/detect goes low
> +		 * (first time), we assume it is meant for coldboot
> +		 * and set the flag. If wake/detect line stays low
> +		 * beyond 30msec, then it is coldboot else fallback
> +		 * to standby boot.
>  		 */
> -		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
> -			if (time_before(jiffies,
> -					arche_pdata->wake_detect_start +
> -					msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> -				arche_platform_set_wake_detect_state(arche_pdata,
> -								     WD_STATE_IDLE);
> -			} else {
> -				/*
> -				 * Check we are not in middle of irq thread
> -				 * already
> -				 */
> -				if (arche_pdata->wake_detect_state !=
> -						WD_STATE_COLDBOOT_START) {
> -					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> -					rc = IRQ_WAKE_THREAD;
> -				}
> -			}
> -		}
> -	} else {
> -		/* wake/detect falling */
> -		if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> -			arche_pdata->wake_detect_start = jiffies;
> -			/*
> -			 * In the beginning, when wake/detect goes low
> -			 * (first time), we assume it is meant for coldboot
> -			 * and set the flag. If wake/detect line stays low
> -			 * beyond 30msec, then it is coldboot else fallback
> -			 * to standby boot.
> -			 */
> -			arche_platform_set_wake_detect_state(arche_pdata,
> -							     WD_STATE_BOOT_INIT);
> -		}
> +		arche_platform_set_wake_detect_state(arche_pdata,
> +						     WD_STATE_BOOT_INIT);
>  	}
>  
> +out:
>  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>  
>  	return rc;
> -- 
> 2.34.1
> 
