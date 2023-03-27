Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8606CB039
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjC0VAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjC0VAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:00:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AF1BD1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:00:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o32so5763224wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxHAeSRmvmOJM7L4xuCcGB4JYeN7eUOth0obgJagveg=;
        b=OFxDCJ00sKrXWuZpBpo1/2sLI8XscM7kjI7zfuUzce86Ua2/IJPxdxon8Ade68rDUu
         QWCCDYf0er65HRXHKmqc+pDQkJXonuy0P3Ha7zfq2AChR7jiMX9zliTN6OcqqvF1qg/e
         r/eEsvLDxK4Lsbc3OwdNIQz3ARG1CnaBGDRoCtw3QjyUk6PETEBstRKk3eyww7i30pZj
         UnE/nRwK858ImDsi90jc13KJ4Xs57u670YLMFbx6NErvyR8A/2nISp7/UYZW9cIBm5ew
         9BAgxUbLcDzuCbE1LYmdTOSpJNEW8qF1zDADRqnRvNOswp/Wq8NCufcXvG0cxWJJPMEH
         R2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxHAeSRmvmOJM7L4xuCcGB4JYeN7eUOth0obgJagveg=;
        b=kJT1n/fqm8uFqDmsWRl0FjJi7gzNFz2jYTMKy+jl4c+vwVcDCmps8MdWf6UV/cO4qn
         SyIeC6wu7YJPhs2pZyQoPxHjRr7VRp5nMWjbvr0Y5luxsVsWZfCjL6UZ/PF/lKvUEK0H
         u3vfN7gz0OPl/mlHI1KC5a4ugZIasYfPqSW3sejgKeC7i0O3S3NiQrEo2cFlRSZOj2O1
         dUmyoTB6VzshMAoTj9FfXT+TuMZXs3Y/Czyc7KidcGXdzQeKR0DJdxnG6gUVjc6ty2Qo
         TWlTDeEFTJO0QgMCeI0sENHgVkYc/P/2H1kGVb4m4sT2sTs8QG7QgTxsgx90Ad+XJ0PZ
         lZag==
X-Gm-Message-State: AO0yUKUgYxfA71Y7HXiDi6cyS0n0qfgZ4N3v1B4uR5zu/rhfojHH+69E
        cRtbAs9CKb71z3aAzdif+py1D1m0rzk1FvN9uRc=
X-Google-Smtp-Source: AK7set+aO3K1IkWIVR3WucMal2t2FuelYtWE7IhhNpxFyGBukHpajR9/zQQZsR0pHGHyefvQt8fgcQ==
X-Received: by 2002:a7b:c44f:0:b0:3ed:d3a7:7077 with SMTP id l15-20020a7bc44f000000b003edd3a77077mr9782042wmi.40.1679950831480;
        Mon, 27 Mar 2023 14:00:31 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b003ee610d1ce9sm10115062wmo.34.2023.03.27.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:00:31 -0700 (PDT)
Date:   Tue, 28 Mar 2023 02:00:28 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZCID7MUrIHy8+qb4@khadija-virtual-machine>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
 <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
 <ZBnc3qWTSeWw0Ulo@aschofie-mobl2>
 <ZCFvTndYXmPvQunt@khadija-virtual-machine>
 <ZCHPokeiKV37uOmr@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCHPokeiKV37uOmr@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:17:22AM -0700, Alison Schofield wrote:
> On Mon, Mar 27, 2023 at 03:26:22PM +0500, Khadija Kamran wrote:
> > On Tue, Mar 21, 2023 at 09:35:42AM -0700, Alison Schofield wrote:
> > > On Tue, Mar 21, 2023 at 09:21:35PM +0500, Khadija Kamran wrote:
> > > > On Mon, Mar 20, 2023 at 01:26:33PM +0500, Khadija Kamran wrote:
> > > > > If condition and spin_unlock_...() call is split into two lines, merge
> > > > > them to form a single line.
> > > > > 
> > > > > Suggested-by: Deepak R Varma drv@mailo.com
> > > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > > ---
> > > > > 
> > > > > Changes in v3:
> > > > >  - Removing tab to fix line length results in a new checkpatch warning,
> > > > >    so let the fix length be as it is.
> > > > > Changes in v2:
> > > > >  - Rephrased he subject and description
> > > > >  - Merged if_condition() and spin_unlock...() into one line
> > > > >  - Link to patch:
> > > > >  https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/
> > > > > 
> > > > > Link to first patch:
> > > > > https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/
> > > > > 
> > > > >  drivers/staging/greybus/arche-platform.c | 6 ++----
> > > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > > > index fcbd5f71eff2..6890710afdfc 100644
> > > > > --- a/drivers/staging/greybus/arche-platform.c
> > > > > +++ b/drivers/staging/greybus/arche-platform.c
> > > > > @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > > > >  				 * Check we are not in middle of irq thread
> > > > >  				 * already
> > > > >  				 */
> > > > > -				if (arche_pdata->wake_detect_state !=
> > > > > -						WD_STATE_COLDBOOT_START) {
> > > > > +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> > > > >  					arche_platform_set_wake_detect_state(arche_pdata,
> > > > >  									     WD_STATE_COLDBOOT_TRIG);
> > > > > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > > > > -							       flags);
> > > > > +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > > > >  					return IRQ_WAKE_THREAD;
> > > > >  				}
> > > > >  			}
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > 
> > > > Hey Outreachy Mentors,
> > > > 
> > > > Kindly take a look at this patch and let me know if it is okay to work
> > > > on this file or should I look for other cleanup patches.
> > > 
> > > Hi Khadija,
> > > 
> > > I thought you were abandoning *this* patch, and doing a refactor on
> > > the function.  I'd expect that would be a new patch, probably a
> > > patchset. One where you align the work based on the 'rising' and
> > > 'falling' detection, 
> > 
> > Hey Alison,
> > 
> > Can you please elaborate that what do you mean by aligning on the basis
> > of rising and falling detection. Are you perhaps saying that I should
> > group the rising detection and group the falling detection separately?
> > 
> > > and perhaps a second patch that centralizes
> > > the unlock and return.
> > 
> > To do this I should make the use of goto statement, right?
> > 
> > So the next patchset should be:
> > Patch 1: merge split lines
> > Patch 2: align on the basis of rising and falling detection
> > Patch 3: use goto statement to centralize unlock and return
> > 
> > Kindly guide me.
> > 
> > Regards,
> > Khadija
> 
> Hi,
> 
> Glad you are picking this back up!
> I know Ira sent you some links to refactoring info. Go back and
> look at those.
> 
> When we submit patches that refactor a function, we try to make
> the patches obviously correct and easy to review.
> 
> I'll tell you how I approached this one, and you can see how
> it works for you:
> 
> 1. Edit the function until it is just how you'd like it. Hint:
>    no lines over 80, minimal indentation.
> 
> {
> 	--snip--
> 
> 	if (!gpiod_get_value(arche_pdata->wake_detect))
>                 goto falling;
> 
>         /* wake/detect rising */
> 
> 	
> 
> falling:
> 	/* wake/detect falling */
> 
> 
> out:
> 	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> 
>         return rc;
> }
> 
> 
> 2. Figure out how you can present that in patches. This function
>    is just long enough that I think you have to split it up into
>    two or more obvious steps, rather than throwing it into one
>    patch.
> 
> How about you do Step 1, and send the diff to the Outreachy mailing
> list (only) for review. Please start a new thread. 
>

Hey Alison,

I am sorry about sending a new patch instead of sending a diff for
discussion. I realize that I did not read your message carefully and
misunderstood its contents. 

Let me start a new thread. Sorry for the inconvenience.

Regards,
Khadija 

> Alison
> 
> > 
> > > 
> > > Is there some other concern with working on this file?
> > > 
> > > Alison
> > > 
> > > > 
> > > > Thank you for your time.
> > > > Regards,
> > > > Khadija
> > > > 
> > > > 
