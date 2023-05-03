Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286A46F6103
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjECWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECWDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:03:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAD7DB0;
        Wed,  3 May 2023 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683151390; x=1714687390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J3S7+Z2Bb+TaVT5MbkGNBgkG899lTs0nMS79YuENME8=;
  b=N/a22sK45untpCKDl72rrW3lBnu+PVG7pjy62zW1VdKd3J/ATm0FghQF
   YKV2ddo5MtIgEMinn/RMj/87owomEMTJZ7GhvX4S0PaQIONmsAQ/cNghM
   BrtzZZB8pSENg2EP5AZzDy6pIaaaadf0cvhbLxCQjk+tFgCQ+ebxJOmdI
   FeirHTXqUqxofm5x8v+xdMmhbOJADnuW5R1OzUDOd20L41vYbAIQNTJFO
   GnsFOwwOiC9nSYV/6nte8KppeP55Q5EBb1QvK8TQgnZtVxNEDK24MnY3D
   Nmh6ruuB02kWJocuaPzNyKiEWaaeqQmzIn2FYJh4+LMdyD5hVnvOryEfW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="333144699"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="333144699"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 15:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="820915544"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="820915544"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.38])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 15:03:08 -0700
Date:   Wed, 3 May 2023 15:03:07 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        raghuhack78@gmail.com
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <ZFLaG8jHHXmRp67w@aschofie-mobl2>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-2-raghuhack78@gmail.com>
 <3235466.44csPzL39Z@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3235466.44csPzL39Z@suse>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 08:32:37PM +0200, Fabio wrote:
> On venerdì 28 aprile 2023 03:22:34 CEST Raghu H wrote:
> > Issue found with checkpatch
> > 
> > A return of errno should be good enough if the memory allocation fails,
> > the error message here is redundatant
> 
> Typo: it's "redundant". No problem, I think you shouldn't resend only for the 
> purpose to fix this. But...
> 

Raghu,
checkpatch --codespell will catch misspellings in the commit log, when
run on the HEAD^ commit or on the formatted patch file.

> > as per the coding style, removing it.
> > 
> > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> 
> Is "Raghu H" the name you sign legal documents with? 
> 

Fabio,
Rather than asking a specific question to determine if this is a
valid SOB, let's just point folks to the documentation to figure
it out themselves. I'm aware that the 'sign legal documents' test
has been used in the past, but kernel only actually requires a
known identity.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md



> If not, please send a new version signed-off-by your full legal name. 
> Otherwise... sorry for the noise.
> 
> Thanks,
> 
> Fabio
> 
> > ---
> >  drivers/cxl/core/mbox.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index f2addb457172..11ea145b4b1f 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct
> > device *dev) struct cxl_dev_state *cxlds;
> > 
> >  	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> > -	if (!cxlds) {
> > -		dev_err(dev, "No memory available\n");
> > +	if (!cxlds)
> >  		return ERR_PTR(-ENOMEM);
> > -	}
> > 
> >  	mutex_init(&cxlds->mbox_mutex);
> >  	mutex_init(&cxlds->event.log_lock);
> > --
> > 2.39.2
> 
> 
> 
> 
