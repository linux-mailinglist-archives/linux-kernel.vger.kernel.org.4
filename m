Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD896CABB1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC0RR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0RRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:17:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097602D7C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679937445; x=1711473445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLxpMM7xRbAJBq6Fhf+2XizhIG+CR14+JMfNOvnK+PE=;
  b=mZVyFG57f6YCJf73aPJ2GrEQoodSKUdvkOp29cZ2SZ3KyaykvoEcDF94
   B/RsyzwIz8MXPDsblrjotz/KbFHQkmgJEhDo3OFr7YOB5tMxb1RJOOFZn
   NLLIvgrkWUlmx3Q4afNQLbOnreR9JrvZ2EhaLHPUS5C5BxcVgSlMStGce
   XePTBpl9nt2kR0H0Eeva71RyAuI2C+npHYaU10dCxkgyi+nA7kWZJpzhG
   kn/q7Hn/Odi7JNolKCu4DLVYnXPxa3+zBupwUfH8pweAe87QFKIYL2T3g
   u5lnr7CQX8k6GP+wsn/HQhirUJLZQm4b6DHfsoMzF+TdKAW3lzqpvB5ln
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426596379"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="426596379"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013193769"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="1013193769"
Received: from srikarja-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.229.96])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:17:24 -0700
Date:   Mon, 27 Mar 2023 10:17:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZCHPokeiKV37uOmr@aschofie-mobl2>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
 <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
 <ZBnc3qWTSeWw0Ulo@aschofie-mobl2>
 <ZCFvTndYXmPvQunt@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCFvTndYXmPvQunt@khadija-virtual-machine>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:26:22PM +0500, Khadija Kamran wrote:
> On Tue, Mar 21, 2023 at 09:35:42AM -0700, Alison Schofield wrote:
> > On Tue, Mar 21, 2023 at 09:21:35PM +0500, Khadija Kamran wrote:
> > > On Mon, Mar 20, 2023 at 01:26:33PM +0500, Khadija Kamran wrote:
> > > > If condition and spin_unlock_...() call is split into two lines, merge
> > > > them to form a single line.
> > > > 
> > > > Suggested-by: Deepak R Varma drv@mailo.com
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > > 
> > > > Changes in v3:
> > > >  - Removing tab to fix line length results in a new checkpatch warning,
> > > >    so let the fix length be as it is.
> > > > Changes in v2:
> > > >  - Rephrased he subject and description
> > > >  - Merged if_condition() and spin_unlock...() into one line
> > > >  - Link to patch:
> > > >  https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/
> > > > 
> > > > Link to first patch:
> > > > https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/
> > > > 
> > > >  drivers/staging/greybus/arche-platform.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > > index fcbd5f71eff2..6890710afdfc 100644
> > > > --- a/drivers/staging/greybus/arche-platform.c
> > > > +++ b/drivers/staging/greybus/arche-platform.c
> > > > @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > > >  				 * Check we are not in middle of irq thread
> > > >  				 * already
> > > >  				 */
> > > > -				if (arche_pdata->wake_detect_state !=
> > > > -						WD_STATE_COLDBOOT_START) {
> > > > +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> > > >  					arche_platform_set_wake_detect_state(arche_pdata,
> > > >  									     WD_STATE_COLDBOOT_TRIG);
> > > > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > > > -							       flags);
> > > > +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > > >  					return IRQ_WAKE_THREAD;
> > > >  				}
> > > >  			}
> > > > --
> > > > 2.34.1
> > > >
> > > 
> > > Hey Outreachy Mentors,
> > > 
> > > Kindly take a look at this patch and let me know if it is okay to work
> > > on this file or should I look for other cleanup patches.
> > 
> > Hi Khadija,
> > 
> > I thought you were abandoning *this* patch, and doing a refactor on
> > the function.  I'd expect that would be a new patch, probably a
> > patchset. One where you align the work based on the 'rising' and
> > 'falling' detection, 
> 
> Hey Alison,
> 
> Can you please elaborate that what do you mean by aligning on the basis
> of rising and falling detection. Are you perhaps saying that I should
> group the rising detection and group the falling detection separately?
> 
> > and perhaps a second patch that centralizes
> > the unlock and return.
> 
> To do this I should make the use of goto statement, right?
> 
> So the next patchset should be:
> Patch 1: merge split lines
> Patch 2: align on the basis of rising and falling detection
> Patch 3: use goto statement to centralize unlock and return
> 
> Kindly guide me.
> 
> Regards,
> Khadija

Hi,

Glad you are picking this back up!
I know Ira sent you some links to refactoring info. Go back and
look at those.

When we submit patches that refactor a function, we try to make
the patches obviously correct and easy to review.

I'll tell you how I approached this one, and you can see how
it works for you:

1. Edit the function until it is just how you'd like it. Hint:
   no lines over 80, minimal indentation.

{
	--snip--

	if (!gpiod_get_value(arche_pdata->wake_detect))
                goto falling;

        /* wake/detect rising */

	

falling:
	/* wake/detect falling */


out:
	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);

        return rc;
}


2. Figure out how you can present that in patches. This function
   is just long enough that I think you have to split it up into
   two or more obvious steps, rather than throwing it into one
   patch.

How about you do Step 1, and send the diff to the Outreachy mailing
list (only) for review. Please start a new thread. 

Alison

> 
> > 
> > Is there some other concern with working on this file?
> > 
> > Alison
> > 
> > > 
> > > Thank you for your time.
> > > Regards,
> > > Khadija
> > > 
> > > 
