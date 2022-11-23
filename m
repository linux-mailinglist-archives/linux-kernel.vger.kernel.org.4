Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31F6366EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiKWRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKWRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:24:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C158DA6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224274; x=1700760274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NyVkE3sL58mSNMW6pWyx9t4p0LbxgewwoJOaWOkziW8=;
  b=Ea64tARio1TRvV8g0iTTnauyj/UUb1tN4GpMru0q++BO6EvrFJ4oiamR
   aOMMAxZwVWokFw9gtbmcZoglAnKMz9OkIaoaOdxMLSm2N4I9tFE7UQxjI
   pUu4hAz8x+MDW9CLbI6ed+Mae8USJicPwEytP6Ap+OP9vOQhTJ6SRzPXU
   8FGRCc0zfP6g7PPkzeNXM3XsNBJiPklYeywsPqj+vNsPmKgW0OM5Y3AdL
   g+NtJidMrOPIwMxf4sWSncAlj5+M1hx0OEAAy6GMEAooA7gQZeuC11T9h
   Up+ksoGj+GZe2ELzUVVajSrL4jiRx+vpW66Lmyis4Dv64fCu8/tRqFCUX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="341005591"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="341005591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:24:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="970940231"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="970940231"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2022 09:24:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxtU1-00GNgn-09;
        Wed, 23 Nov 2022 19:24:25 +0200
Date:   Wed, 23 Nov 2022 19:24:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rahul Tanwar <rtanwar@maxlinear.com>, bigeasy@linutronix.de,
        robh@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-lgm-soc@maxlinear.com
Subject: Re: [PATCH v3 1/4] x86/of: Convert Intel's APIC bindings to YAML
 schema
Message-ID: <Y35XSFXJS0UOzuxJ@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <0cf089495a422b945ac4fc9c980ddb5429a711c3.1669100394.git.rtanwar@maxlinear.com>
 <ce1bf2fd-4080-4952-cf02-6d5b64da8b28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1bf2fd-4080-4952-cf02-6d5b64da8b28@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 05:02:33PM +0100, Krzysztof Kozlowski wrote:
> On 22/11/2022 08:39, Rahul Tanwar wrote:

...

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You miss not only people but also lists, meaning this will not be
> automatically tested.

It seems that v4 manages to get the testing (and it's a good thing since
it found some issues).

-- 
With Best Regards,
Andy Shevchenko


