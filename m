Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C986F62ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEDC0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEDC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:26:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420B61B4;
        Wed,  3 May 2023 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683167187; x=1714703187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5Qqy4zfq34crqDqF98mIEVqZpWwPPR/pSNlwuUb6NU=;
  b=HoEPhu/rW1ZDShlDudxLVLkpqFsVWFp/Ah3WCh/YMmYL0KGM0ANl7U6g
   RIyOBNdRgtvDv7qju/Q3GBLfjz+KCcoHHWAp+/giTWWfrr/tKzsdfWeP5
   bChFj7Nj7iQ7rO7JqBo7aVyjx1YqweEGPSvMgWfo8cudFdFdLyo6CyUwS
   f1/hQCVRDFnxAP7zwf/IWOCgW3JBGtmPGL1eYuHcUPCuUBkx+DqKF7nHX
   yXB/X45tkWxhGQqdwNA6E5wh3xRgb/xV1ome4SZF1TOvnO5eV38zWlYu6
   LgxVfcP7Ya/CkOS617DM284cIVgcOU56XLWYzT5a2B5NwWMt0qwCyVm+J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="414283203"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="414283203"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 19:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="699669154"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="699669154"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.38])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 19:26:26 -0700
Date:   Wed, 3 May 2023 19:26:24 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Raghu H <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <ZFMX0K4jeUIBOo7D@aschofie-mobl2>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <20230428012235.119333-2-raghuhack78@gmail.com>
 <dtmb3d2dmcqh2djc4jebd2s7uwhw6l7nyfqgo7o34bhn7gzhzd@jmhb5g7edce4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dtmb3d2dmcqh2djc4jebd2s7uwhw6l7nyfqgo7o34bhn7gzhzd@jmhb5g7edce4>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 03:36:50PM -0700, Davidlohr Bueso wrote:
> On Fri, 28 Apr 2023, Raghu H wrote:
> 
> > Issue found with checkpatch
> 
> fyi for both patches, these are not "issues" - you can remove it, or the line altogether.
> 
> Thanks,
> Davidlohr

Hi Raghu,

Perhaps this patchset got you more attention than you may have expected ;)
So, this is an example of when reviewers disagree. I asked you to note
that checkpatch found these 'issues' and David disagrees.

If David had known I'd asked you to update the commit log to include the
checkpatch credit, he may have ignored it, or maybe not. I don't find
the word 'issue' to be misused. There are many flavors of this phrase used
in kernel commit logs that address checkpatch found issues.

The way the next round of reviewers knows what the first round asked
for is by looking at the changelog. (And, if they need more detail, they
pull up the previous patchset discussion.)

The changelog in the cover letter, or per patch, needs to explicitly
say what has changed.

The v2 says this:

>> v2 changes:
>> Thanks Alison, Ira for your comments, modified the v1 patches as suggested.
>> Dropped the patch containing tab changes in port.c

Next time, be more specific, like this:

v2 changes:
- Update commit logs to credit checkpatch (Alison)
- Update commit msgs to conform to subsystem style (Alison)
- Drop the patch containing tab changes in port.c (Ira)

Thanks,
Alison



