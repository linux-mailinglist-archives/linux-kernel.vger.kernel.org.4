Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704676F0C91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbjD0Tcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245449AbjD0TcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:32:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510C1B6;
        Thu, 27 Apr 2023 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682623941; x=1714159941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zk7dQkZTymm3lghn5X3BxiYDvSRwelkIPmA1EV/BJG8=;
  b=jP5a2dTBdj6TOe9E27ycYUN25Z/1DMGX0ER48hdDOupjhTFnGdMZP6Yy
   AMoFfAR/kSdIMZotnaLYujCG2rGNCvbRsX+zWrYbsfn6JWyQCdVwSH26U
   bDqQ4Ze5HdWnUkY2M4jB6NjfxDnOySgyEAImmrhQcaiG0ct0btYJwSyWr
   W6kfeswxx8VOWQZ9vPjD1BzMUUHMlOWnKRbMOZW5U6u33b2t7LJNF+Fxa
   a0Izr6pW+iYQUaWJ6yVlma9nvPGG9aXttoLRWRS5KBzvND2PCQeehLqsk
   r9l3v++5xG9w6gImG/fpONHXNOPHTTkQ0Y/z2rHyiiJNPCfiNS7U2ajDK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412904616"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412904616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="727246338"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="727246338"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:32:19 -0700
Date:   Thu, 27 Apr 2023 12:32:18 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Raghu H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [STYLE v1 1/3] cxl/mbox: remove redundant debug msg
Message-ID: <ZErNwolUDQ2HMZYa@aschofie-mobl2>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-2-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419111443.231151-2-raghuhack78@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:14:41AM +0000, Raghu H wrote:
> A return of errno should be good enough if the memory allocation fails,
> the debug message here is redundatant as per the coding style, removing it.

Hi Raghu,

Thanks for the patch. The code change looks fine.

Here is some feedback on the commit msg and log:

This removes a dev_err() not a debug message, dev_dbg()

Commit msg can be clearer like:
cxl/mbox: Remove redundant dev_err() after failed mem alloc

Please include PATCH in the subject line.
See Documentation/process/submitting-patches.rst or peruse other
patches on the mailing list and subsystem to see examples.

Alison


> 
> Signed-off-by: Raghu H <raghuhack78@gmail.com>
> ---
>  drivers/cxl/core/mbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..11ea145b4b1f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1112,10 +1112,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	struct cxl_dev_state *cxlds;
>  
>  	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds) {
> -		dev_err(dev, "No memory available\n");
> +	if (!cxlds)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
> -- 
> 2.39.2
> 
