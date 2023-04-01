Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375D6D32ED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDARmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDARmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:42:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DB1164C
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:42:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so16980556wmq.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680370921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=merQPvph7q/x0aOQVRyhO3lhqdf/YVeXNljQsqoNaGE=;
        b=iZ/0wIrvRaQE+pW0fOMWY8n4BHZXr3w94OZk29xHka93TM8zs2r9QYKR9PdypbN5qZ
         CsqLeQp9OsjGuyLkOQQhRyECOaU4x6gWu1eYfccBv0YapvVl2JaYL468EC9DieToFnCx
         GAdL86atXpyFRJmJ42i9oiYjjqCmsKmZAssrE2OjU0T6O3yuo8bgAgyNtT1/6Fp3GnSI
         uS1oshFIvtTl9C+sXrPz4+ioqFMHGZKr3Ogp8ki7KU+/ZChCLqwDzpKdbcS77nN8MMQk
         D7gXccjvDpdfV7F2QS1jh+NDqdFG7Dz1QuV8Dnu+MCiCdLcnyIcts17f9bekmb4zrmzH
         DURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680370921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=merQPvph7q/x0aOQVRyhO3lhqdf/YVeXNljQsqoNaGE=;
        b=SOue235qe68Sx/xGCxm+xJUNlZnsb03aiJ3TUQyWzdbiKVAbNOuCcWfUDXh+EPV9rl
         zRXsUdQ/ZSNZwLomx44oGgrsggnpbVO40IyuewzhA5rfab4D+o5qaYKYPO/i+jL+05hH
         16X9hnt2cDyiRl1NNdLgGdb1JHdNCOpV2ZiagrcGde/ZlL6dwAtLL4dhPfrLMv5j6oyS
         VmYOdvALOaMUxL8xVBxkgMF27CS0K24UPugl6EGmv+TuA4MuMPY5n7LDvvuLo2Z0RhOe
         qABNrE0/qBtq25oWREqu5ssf6itDf63JzCWzCePA3VQl7XbQQg4WZ2fZwOf2CABj5cYp
         Ok6A==
X-Gm-Message-State: AO0yUKXdnaDsAjM/7OInAbEutymE6IP6GzKZaIpS6lTyto1JzFToxl8y
        bjVbgyfjIVbeOvsIFIKUyLQ=
X-Google-Smtp-Source: AK7set9gbqxU+g3zXQ8niV5jxCprtZqMtFtF+kWWCEH+NTnuB7UVU8Zomtsfk89ArKgHnEiXFy6Wtg==
X-Received: by 2002:a05:600c:20f:b0:3eb:5ab3:b6d0 with SMTP id 15-20020a05600c020f00b003eb5ab3b6d0mr22258209wmi.6.1680370920878;
        Sat, 01 Apr 2023 10:42:00 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003edff838723sm6703814wml.3.2023.04.01.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 10:42:00 -0700 (PDT)
Date:   Sat, 1 Apr 2023 22:41:58 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
 <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:23:19PM +0300, Dan Carpenter wrote:
> On Thu, Mar 30, 2023 at 07:11:25PM +0500, Khadija Kamran wrote:
> > Linux kernel coding-style suggests to fix your program if it needs more
> > than 3 levels of indentation. Due to indentation, line length also
> > exceeds 100 columns, resulting in issues reported by checkpatch.
> > 
> > Refactor the arche_platform_wd_irq() function and reduce the indentation
> > with the help of goto statement.
> > 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
> >  1 file changed, 41 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index a64c1af091b0..dde30c8da1a1 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  
> >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> >  
> > -	if (gpiod_get_value(arche_pdata->wake_detect)) {
> > -		/* wake/detect rising */
> > +	if (!gpiod_get_value(arche_pdata->wake_detect))
> > +		goto falling;
> >  
> > +	/* wake/detect rising */
> > +
> > +	/*
> > +	 * If wake/detect line goes high after low, within less than
> > +	 * 30msec, then standby boot sequence is initiated, which is not
> > +	 * supported/implemented as of now. So ignore it.
> > +	 */
> > +	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> > +		goto out;
> 
> This checks that we are in WD_STATE_BOOT_INIT state.
> 
> > +
> > +	if (time_before(jiffies,
> > +			arche_pdata->wake_detect_start +
> > +			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> > +		arche_platform_set_wake_detect_state(arche_pdata,
> > +						     WD_STATE_IDLE);
> > +		got out;
> > +	}
> > +
> > +	/* Check we are not in middle of irq thread already */
> > +	if (arche_pdata->wake_detect_state !=
> > +			WD_STATE_COLDBOOT_START) {
> 
> This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> background?  Can this check be removed?  This might be took tricky to
> answer but it's important that we understand this before we continue.
> 
> 
> > +		arche_platform_set_wake_detect_state(arche_pdata,
> > +						     WD_STATE_COLDBOOT_TRIG);
> > +		rc = IRQ_WAKE_THREAD;
> > +		goto out;
> > +	}
> 
> Let's assume the above check cannot be removed.
> 
> In the original code if gpiod_get_value(arche_pdata->wake_detect)
> returned true and arche_pdata->wake_detect_state == WD_STATE_IDLE then
> it just returned without doing anything, but now we fall through to the
> falling: label below.

Hey Dan,

Just to clear my undrstanding in the new code, if
gpiod_get_value(arche_pdata->wake_detect) returned true, we go to the
rising section. In the rising section if arche_pdata->wake_detect_state
== WD_STATE_IDLE then the condition,
if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT) becomes true
so we goto out label. I do not understand how we go to falling label.

Regards,
Khadija

> So this patch seems like it introduces a bug, but actually it might just
> have a dead code problem.
> 
> regards,
> dan carpenter
> 
> > +
> > +falling:
> > +	/* wake/detect falling */
> > +	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> > +		arche_pdata->wake_detect_start = jiffies;
> >  		/*
> > -		 * If wake/detect line goes high after low, within less than
> > -		 * 30msec, then standby boot sequence is initiated, which is not
> > -		 * supported/implemented as of now. So ignore it.
> > +		 * In the beginning, when wake/detect goes low
> > +		 * (first time), we assume it is meant for coldboot
> > +		 * and set the flag. If wake/detect line stays low
> > +		 * beyond 30msec, then it is coldboot else fallback
> > +		 * to standby boot.
> >  		 */
> > -		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
> > -			if (time_before(jiffies,
> > -					arche_pdata->wake_detect_start +
> > -					msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> > -				arche_platform_set_wake_detect_state(arche_pdata,
> > -								     WD_STATE_IDLE);
> > -			} else {
> > -				/*
> > -				 * Check we are not in middle of irq thread
> > -				 * already
> > -				 */
> > -				if (arche_pdata->wake_detect_state !=
> > -						WD_STATE_COLDBOOT_START) {
> > -					arche_platform_set_wake_detect_state(arche_pdata,
> > -									     WD_STATE_COLDBOOT_TRIG);
> > -					rc = IRQ_WAKE_THREAD;
> > -				}
> > -			}
> > -		}
> > -	} else {
> > -		/* wake/detect falling */
> > -		if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> > -			arche_pdata->wake_detect_start = jiffies;
> > -			/*
> > -			 * In the beginning, when wake/detect goes low
> > -			 * (first time), we assume it is meant for coldboot
> > -			 * and set the flag. If wake/detect line stays low
> > -			 * beyond 30msec, then it is coldboot else fallback
> > -			 * to standby boot.
> > -			 */
> > -			arche_platform_set_wake_detect_state(arche_pdata,
> > -							     WD_STATE_BOOT_INIT);
> > -		}
> > +		arche_platform_set_wake_detect_state(arche_pdata,
> > +						     WD_STATE_BOOT_INIT);
> >  	}
> >  
> > +out:
> >  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> >  
> >  	return rc;
> > -- 
> > 2.34.1
> > 
