Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0E6D3C72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDCE3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDCE3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:29:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A2AF2B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:29:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eh3so111999961edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 21:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+jcEm/umXiKxj33UWcwhHckJKdBkBpU3hyzsLfjMvA=;
        b=Fy8VjOwSwpwI1ksHIQhvJN9cc7dd0AL/usn9dPPsOmfay4L3YpmQxsE/cG4wG67xfn
         3UKcwW41butcDqsY307Gam4LB8cXgR1XAySBqR5J9PE+QsBERuhkcpemfMqJ57w71g0N
         VVmBgCHfysEM6o5aFRkpRgMvCqAaX9zl94fwa+qKHQKkeQlx92QqQysGbsihS7HXcmz1
         yIhe1JzI7i2pIYyBEF8RbMnW53psGCowl+Oa7EXxTN59gUrvxRL3S7g4WlpbmoXJHGpp
         n8otfAtKo0sxMHiIgLVa6xtGECMjNu46UfXPm+51Hue7UdwEz3zwH5kPvEP14rdaGWhl
         gk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+jcEm/umXiKxj33UWcwhHckJKdBkBpU3hyzsLfjMvA=;
        b=MmNIjSeLeLFLGSYsacmGb+St2qBNHuUDlQ68rOD/9RCKz9TrcB9H/1VddV0xD5a/e9
         vSreyWE0v+ZI0/a2Ct5OqcItvjuqUgx77DCf2EPC0+Fv6KJKfnBMhuk3kxWF7U7zkqYv
         ohfgW7MywwrEhzAHiHOEBSIB639imlSzpMhdgtrH86yvM3JexolbbVNruOCpsMcN6wg7
         I+6yxCA7zgLhPZy1bctGd6yqcXkuDb+aasvOAJRTQc1NL0WbP+YgROeDtE1IIo9SAfTm
         nja1n+S8y2EnlaKw9kGcyvGJ5MeKVHhvEMdu6plD4pSkmCimVJStq8747ro0MJPH58rB
         D/NQ==
X-Gm-Message-State: AAQBX9fBauu9XNswNmAOE4tm+vLmyc9U3ULXPdA3Eo4/AeBWsvAfiRps
        CS+8C27qrcGN5ilXUfvg483nN208ODGfrg==
X-Google-Smtp-Source: AKy350Yuy8uDeMonDQ7b86zEISWdqvmRyRD2Bz4PYcHY4udEA3IvmVg6cfFd7ZnAk0dlXK3ghr4PcQ==
X-Received: by 2002:a17:906:ac1:b0:92d:9767:8e0a with SMTP id z1-20020a1709060ac100b0092d97678e0amr30159313ejf.13.1680496181093;
        Sun, 02 Apr 2023 21:29:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906938200b00948a57aac08sm445563ejx.204.2023.04.02.21.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:29:40 -0700 (PDT)
Date:   Mon, 3 Apr 2023 07:29:36 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
 <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
 <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 10:41:58PM +0500, Khadija Kamran wrote:
> On Thu, Mar 30, 2023 at 06:23:19PM +0300, Dan Carpenter wrote:
> > On Thu, Mar 30, 2023 at 07:11:25PM +0500, Khadija Kamran wrote:
> > > Linux kernel coding-style suggests to fix your program if it needs more
> > > than 3 levels of indentation. Due to indentation, line length also
> > > exceeds 100 columns, resulting in issues reported by checkpatch.
> > > 
> > > Refactor the arche_platform_wd_irq() function and reduce the indentation
> > > with the help of goto statement.
> > > 
> > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > >  drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
> > >  1 file changed, 41 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > index a64c1af091b0..dde30c8da1a1 100644
> > > --- a/drivers/staging/greybus/arche-platform.c
> > > +++ b/drivers/staging/greybus/arche-platform.c
> > > @@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  
> > >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> > >  
> > > -	if (gpiod_get_value(arche_pdata->wake_detect)) {
> > > -		/* wake/detect rising */
> > > +	if (!gpiod_get_value(arche_pdata->wake_detect))
> > > +		goto falling;
> > >  
> > > +	/* wake/detect rising */
> > > +
> > > +	/*
> > > +	 * If wake/detect line goes high after low, within less than
> > > +	 * 30msec, then standby boot sequence is initiated, which is not
> > > +	 * supported/implemented as of now. So ignore it.
> > > +	 */
> > > +	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> > > +		goto out;
> > 
> > This checks that we are in WD_STATE_BOOT_INIT state.
> > 
> > > +
> > > +	if (time_before(jiffies,
> > > +			arche_pdata->wake_detect_start +
> > > +			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > +						     WD_STATE_IDLE);
> > > +		got out;
> > > +	}
> > > +
> > > +	/* Check we are not in middle of irq thread already */
> > > +	if (arche_pdata->wake_detect_state !=
> > > +			WD_STATE_COLDBOOT_START) {
> > 
> > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > background?  Can this check be removed?  This might be took tricky to
> > answer but it's important that we understand this before we continue.
> > 
> > 
> > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > +						     WD_STATE_COLDBOOT_TRIG);
> > > +		rc = IRQ_WAKE_THREAD;
> > > +		goto out;
> > > +	}
> > 
> > Let's assume the above check cannot be removed.
> > 
> > In the original code if gpiod_get_value(arche_pdata->wake_detect)
> > returned true and arche_pdata->wake_detect_state == WD_STATE_IDLE then
> > it just returned without doing anything, but now we fall through to the
> > falling: label below.
> 
> Hey Dan,
> 
> Just to clear my undrstanding in the new code, if
> gpiod_get_value(arche_pdata->wake_detect) returned true, we go to the
> rising section. In the rising section if arche_pdata->wake_detect_state
> == WD_STATE_IDLE then the condition,
> if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT) becomes true
> so we goto out label. I do not understand how we go to falling label.
> 
> Regards,
> Khadija

Let me show you in the original code:

STEP 1:	if (gpiod_get_value(arche_pdata->wake_detect)) {

Assume this condition is true.

STEP 2:		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {

Assume this condition is true.

STEP 3:		if (time_before(jiffies, ...)

Assume that time is up.

STEP 4:			if (arche_pdata->wake_detect_state !=
					WD_STATE_COLDBOOT_START) {

Assume that it is equal.  We are done.  return IRQ_HANDLED;

Now in the new code:

STEP 1:	if (!gpiod_get_value(arche_pdata->wake_detect))
		goto falling;

Assume we don't goto falling.

STEP 2:	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)

Assume that it == WD_STATE_BOOT_INIT.

STEP 3:	if (time_before(jiffies, ...)

Assume that time is up.

STEP 4:	if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {

Assume that it is equal.  Before, in the old code it would return
return IRQ_HANDLED; at this point.  But now it does:

STEP 5:	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {

Which seems like it's a contradictory condition with STEP 4 so it's
probably impossible.  But on the other hand, we have already checked
contradictory conditions between STEP 2 and STEP 4 so who knows what's
going on?

This function is very hard to understand.

Also if stuff is changing in the background and there is no way the
locking is correct.

regards,
dan carpenter
