Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939566C3701
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCUQfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCUQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:35:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A650F96
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679416546; x=1710952546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4C2/AuIe0bNckdUCfINRJ7nt+ZejqKOdAwLq7jWVYE=;
  b=TziekbAmY9FiqdxlUol5cWMCsCzof5XnvoSr7XyW6jiLHURMwtAuXXEu
   KzL3MjxqaJrAfzfgiyTNAJ3qpVf3OOwkY1C1Y5B8kSXffsFdhzNUkNHRk
   0nyJkrd2fcCIL2Vlskou/5nXXBHU5auZUB90vaani+ey6w0EQ4eBtS3A0
   pnDLN8DLz+2To7i+NZBzFpGKkyelU9FCcQa48XD3t9cxjYJEnwJcf7mSy
   LSV+rES9HAIubtC/libmlRYhhfN9jYGPyJa+lcUxhhsqcq273aJIa0s24
   jk8DculoD8uVVWTh4ih7PREVtxCXbige8f05IYKWAw9kT8xH/sVFLGSyz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401561085"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="401561085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 09:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="1011010868"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="1011010868"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.21.85])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 09:35:44 -0700
Date:   Tue, 21 Mar 2023 09:35:42 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZBnc3qWTSeWw0Ulo@aschofie-mobl2>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
 <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:21:35PM +0500, Khadija Kamran wrote:
> On Mon, Mar 20, 2023 at 01:26:33PM +0500, Khadija Kamran wrote:
> > If condition and spin_unlock_...() call is split into two lines, merge
> > them to form a single line.
> > 
> > Suggested-by: Deepak R Varma drv@mailo.com
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > 
> > Changes in v3:
> >  - Removing tab to fix line length results in a new checkpatch warning,
> >    so let the fix length be as it is.
> > Changes in v2:
> >  - Rephrased he subject and description
> >  - Merged if_condition() and spin_unlock...() into one line
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/
> > 
> > Link to first patch:
> > https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/
> > 
> >  drivers/staging/greybus/arche-platform.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index fcbd5f71eff2..6890710afdfc 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  				 * Check we are not in middle of irq thread
> >  				 * already
> >  				 */
> > -				if (arche_pdata->wake_detect_state !=
> > -						WD_STATE_COLDBOOT_START) {
> > +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> >  					arche_platform_set_wake_detect_state(arche_pdata,
> >  									     WD_STATE_COLDBOOT_TRIG);
> > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > -							       flags);
> > +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> >  					return IRQ_WAKE_THREAD;
> >  				}
> >  			}
> > --
> > 2.34.1
> >
> 
> Hey Outreachy Mentors,
> 
> Kindly take a look at this patch and let me know if it is okay to work
> on this file or should I look for other cleanup patches.

Hi Khadija,

I thought you were abandoning *this* patch, and doing a refactor on
the function.  I'd expect that would be a new patch, probably a
patchset. One where you align the work based on the 'rising' and
'falling' detection, and perhaps a second patch that centralizes
the unlock and return.

Is there some other concern with working on this file?

Alison

> 
> Thank you for your time.
> Regards,
> Khadija
> 
> 
