Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24AB6D9468
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjDFKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjDFKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:49:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4C5269
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680778181; x=1712314181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCVrnNxvqevVgrRR8ZOMPpw821OWrJFxwk/vHg1afoE=;
  b=CNmU32pkYohw3hRU/7WAI007k1S6fpZhjKsxBj+//6hq5hBmxCtlcgS9
   /nTtzg9xTJ9d6J4R9aZrgqgRKLqe8Y82PGtWbJdH37ODbDhAJLXDg7vrb
   wKtITa+m7PcnM9XPBRfehzJB9nKl3FBSaH1UPqZsyYVpL7Flo6AOiwPzz
   svnZ0Pkz0GDk2FopjBchpGuNlEfnYmOrr8haopAdcNPUfHmtXdL9BjkTe
   d3IDJrXPMO31lhXG2Xi61rGrbcwc9Ev0sgn+G94prZ7EcjzGFEfzhLJlm
   Kjc8h/zIff636XD/HYggFoLA4fvhfU/vZwKXI1wb/ZynI5auKlEtnJjaJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="342712863"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="342712863"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 03:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="687090503"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687090503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 03:49:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pkNBS-00DJj7-1q;
        Thu, 06 Apr 2023 13:49:38 +0300
Date:   Thu, 6 Apr 2023 13:49:38 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        'MyungJoo Ham' <myungjoo.ham@samsung.com>,
        'Chanwoo Choi' <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Message-ID: <ZC6jwsDyTEWP3V9T@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <CGME20230330101146epcas1p2240da3a618b18cea96735bbd6fe3f322@epcas1p2.samsung.com>
 <ZCVgWX2t1fpGzZX9@smile.fi.intel.com>
 <010e01d9636a$8f23edc0$ad6bc940$@samsung.com>
 <9c9ca17a-7211-633d-7072-44992ab6852e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9ca17a-7211-633d-7072-44992ab6852e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 08:17:19AM +0900, Chanwoo Choi wrote:
> On 23. 3. 31. 09:48, Bumwoo Lee wrote:

...

> > Looks fine to me.
> > 
> > Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
> > 
> > MR. Chanwoo, Would you please take a look at this patch series.
> 
> Actually, Acked tag will be replied by Maintainer or the driver owner.  If
> you want to review the mailing list patch, I think that Reviewed-by tag is
> proper.
> 
> Unfortunately, I could not see the any review comment from you even if this
> patchset have the some review contents. Also you didn't review the any
> patches of extcon before.
> 
> I'm always welcome for many reviewers in order to improve the linux kernel.
> But, in this case, I'm not sure that you are reviewing this patchset.
> 
> So that I'm sorry that I cannot take your acked-tag. 

I probably need to update this in the v3 of the rest of the patches I have sent
as v2. Btw, can you review those before, so if any comments I can address in
v3?

-- 
With Best Regards,
Andy Shevchenko


