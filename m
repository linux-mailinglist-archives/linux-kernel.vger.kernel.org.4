Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9846F00C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbjD0G2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjD0G16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:27:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA881988
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:27:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so56818635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682576875; x=1685168875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+Q6Yeni4/TzbxAxTvVHzNKtVswqKwlCXXDuNOp8S9U=;
        b=E1burq30fK2jViySXdTDPkln1s3+moVqNN5Yrb/SmseBcmrokfn6+DwK8NSArF0HE2
         MPpdvVUZQu4RGom+xGVXq2yseM6/zkuQOsZoYxk6tvKeRx8A9s11NgbFM+6n/E8ot/Y4
         uwL0hkLrDqp6Epbx4U3wUl2tZebOgJaU80oPHHEsT1SYJbfUIDDku7VQ+ilO52x+t6rr
         NxDl97e7APP5gxyijUAXNremZfibI3RUGCPGDVHeLGcKizG7Rbk2+H9g8NyxejpUnVKl
         A+38Aj7N6jkTvpB0U74TqmeU3cgKXaomUCMQ9pyZBXevsQQmp+emTlHUegHHE0SyLSKm
         15Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682576875; x=1685168875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+Q6Yeni4/TzbxAxTvVHzNKtVswqKwlCXXDuNOp8S9U=;
        b=bsnwxr8LWQlfjg2mz/2UfHsxiOU2x881wvICCdHbZ37zdEmf0IowObgJQzQ40kV7kf
         OCWm5aRNxYVup/LfCR9MFxeQXy9JYINdXkPM6fBnZqsmyNY7OdP0vdkLeGFY3Q/6m3Rk
         b7xGPCQyZktSWmgDmYAyvaqXlx4oydscaro2Ziow/9SKU4wVTeUlgmUz7aoUhlk7lGep
         2vv/37vnCbewSIPm9E5TvvRdZzX3NRiYj6yHPFI9/zEPexzn6vgdKA2+uO41pMDJP4R0
         /IzMyaUIX7g18jLcyA1IdMXZ7NovFmn/4eyS9MXrLQmWlo9oNi9RuKXJVl58P7gH5wN+
         ikDg==
X-Gm-Message-State: AC+VfDyyfyBdybyHzols3C5fsW0x/h9UAn9a49Wj52VNXEjno/0GeFYo
        6CsDCzL7h/bFxtkFa3iPois=
X-Google-Smtp-Source: ACHHUZ67MU4iq/WyDLqRO35iB0klFuxM2t4I+8VJZbkaravbmfao+YZfKg06zqz4OmEpabV9LldLRA==
X-Received: by 2002:a7b:cbcb:0:b0:3ee:19b4:a2e6 with SMTP id n11-20020a7bcbcb000000b003ee19b4a2e6mr536563wmi.19.1682576875297;
        Wed, 26 Apr 2023 23:27:55 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c028e00b003f18b942338sm19831740wmk.3.2023.04.26.23.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 23:27:54 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:27:51 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev, hvaibhav.linux@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <ZEoV5/S3owfPVil7@khadija-virtual-machine>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
 <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
 <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
 <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 07:29:36AM +0300, Dan Carpenter wrote:
> On Sat, Apr 01, 2023 at 10:41:58PM +0500, Khadija Kamran wrote:
> > On Thu, Mar 30, 2023 at 06:23:19PM +0300, Dan Carpenter wrote:
> > > On Thu, Mar 30, 2023 at 07:11:25PM +0500, Khadija Kamran wrote:
> > > > Linux kernel coding-style suggests to fix your program if it needs more
> > > > than 3 levels of indentation. Due to indentation, line length also
> > > > exceeds 100 columns, resulting in issues reported by checkpatch.
> > > > 
> > > > Refactor the arche_platform_wd_irq() function and reduce the indentation
> > > > with the help of goto statement.
> > > > 
> > > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > >  drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
> > > >  1 file changed, 41 insertions(+), 38 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > > index a64c1af091b0..dde30c8da1a1 100644
> > > > --- a/drivers/staging/greybus/arche-platform.c
> > > > +++ b/drivers/staging/greybus/arche-platform.c
> > > > @@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > > >  
> > > >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> > > >  
> > > > -	if (gpiod_get_value(arche_pdata->wake_detect)) {
> > > > -		/* wake/detect rising */
> > > > +	if (!gpiod_get_value(arche_pdata->wake_detect))
> > > > +		goto falling;
> > > >  
> > > > +	/* wake/detect rising */
> > > > +
> > > > +	/*
> > > > +	 * If wake/detect line goes high after low, within less than
> > > > +	 * 30msec, then standby boot sequence is initiated, which is not
> > > > +	 * supported/implemented as of now. So ignore it.
> > > > +	 */
> > > > +	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> > > > +		goto out;
> > > 
> > > This checks that we are in WD_STATE_BOOT_INIT state.
> > > 
> > > > +
> > > > +	if (time_before(jiffies,
> > > > +			arche_pdata->wake_detect_start +
> > > > +			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> > > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > > +						     WD_STATE_IDLE);
> > > > +		got out;
> > > > +	}
> > > > +
> > > > +	/* Check we are not in middle of irq thread already */
> > > > +	if (arche_pdata->wake_detect_state !=
> > > > +			WD_STATE_COLDBOOT_START) {
> > > 
> > > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > > background?  Can this check be removed?  This might be took tricky to
> > > answer but it's important that we understand this before we continue.
> > > 
> > > 
> > > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > > +						     WD_STATE_COLDBOOT_TRIG);
> > > > +		rc = IRQ_WAKE_THREAD;
> > > > +		goto out;
> > > > +	}
> > > 
> > > Let's assume the above check cannot be removed.
> > > 
> > > In the original code if gpiod_get_value(arche_pdata->wake_detect)
> > > returned true and arche_pdata->wake_detect_state == WD_STATE_IDLE then
> > > it just returned without doing anything, but now we fall through to the
> > > falling: label below.
> 
> Let me show you in the original code:
> 
> STEP 1:	if (gpiod_get_value(arche_pdata->wake_detect)) {
> 
> Assume this condition is true.
> 
> STEP 2:		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
> 
> Assume this condition is true.
> 
> STEP 3:		if (time_before(jiffies, ...)
> 
> Assume that time is up.
> 
> STEP 4:			if (arche_pdata->wake_detect_state !=
> 					WD_STATE_COLDBOOT_START) {
> 
> Assume that it is equal.  We are done.  return IRQ_HANDLED;
> 
> Now in the new code:
> 
> STEP 1:	if (!gpiod_get_value(arche_pdata->wake_detect))
> 		goto falling;
> 
> Assume we don't goto falling.
> 
> STEP 2:	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> 
> Assume that it == WD_STATE_BOOT_INIT.
> 
> STEP 3:	if (time_before(jiffies, ...)
> 
> Assume that time is up.
> 
> STEP 4:	if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> 
> Assume that it is equal.  Before, in the old code it would return
> return IRQ_HANDLED; at this point.  But now it does:
> 
> STEP 5:	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> 
> Which seems like it's a contradictory condition with STEP 4 so it's
> probably impossible.  But on the other hand, we have already checked
> contradictory conditions between STEP 2 and STEP 4 so who knows what's
> going on?


Hey Dan!

Sorry about the delay in the reply. I want to continue working on the
completion of this thread. 

Thank you for the above steps, they clearly explain the problem you
addressed in the new code. Can't this problem be resolved by "goto out;"
right above the 'falling:' label?

I'm copy pasting your mail here,

On Mon, Apr 03, 2023 at 07:29:36AM +0300, Dan Carpenter wrote:
> > > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > > background?  Can this check be removed?

> It turned out the answer was yes, it can be removed.

> > Also if stuff is changing in the background and there is no way the
> > locking is correct.

> The locking is correct.  Take a look at it.

> We are holding the &arche_pdata->wake_lock in arche_platform_wd_irq()
> and every place that calls arche_platform_set_wake_detect_state() takes
> that lock first.  So it can't change in the background.

> Delete the check like so.

If we delete the check then the indentation problem would be
automatically addressed. Also, there would be a single exit path to the
function. Should I send a patch or is there anything else that should be
addressed. 

Thank you!

Regards,
Khadija

> 
> This function is very hard to understand.
> 
> Also if stuff is changing in the background and there is no way the
> locking is correct.
> 
> regards,
> dan carpenter
