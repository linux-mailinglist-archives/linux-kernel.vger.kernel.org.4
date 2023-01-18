Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BA6719C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjARK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjARKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:53:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F288771;
        Wed, 18 Jan 2023 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674036149; x=1705572149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMIDeoU7GnMI0BkDvSAk8CGgIfw46xKlXkg7dZExt5c=;
  b=Dywwg/9A5dLKT1bTSkHbxXxoGRhhnEODif+InpgM63b5zzfpwBKOvUZz
   nFq3OdCGVCX9Yf+Saqsp3For7q6cKsWQon3yqJYwVe8/0HZ8/p9aBGMUm
   ++wR3JuKpGUVG21WMjPLgW2Sue1mItlHTPWKNHz0sSb4ET55TQVkLxj3e
   a9rJ9hkySfa9Lwq422G9FI0SYJ+FyEIXYvC7ZYEpuSOb3NWwzDVsQa5hL
   6HSQexCuhUbRRMRScFZuGlii9Lx6wabtiXepPeOL5uge3c4mg6Q8wkzKh
   NtxlXia0zmHjmxZq/ba17QCw2puG0FyaXWs+yb6roSYr2fhdyDK2LOwEl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="312827268"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312827268"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 02:02:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637218700"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637218700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2023 02:02:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI5Gy-00B714-0l;
        Wed, 18 Jan 2023 12:02:24 +0200
Date:   Wed, 18 Jan 2023 12:02:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y8fDr2aM8z8Nm1z2@smile.fi.intel.com>
References: <20230117093944.72271-1-andriy.shevchenko@linux.intel.com>
 <20230117231204.fpvxryjscosg57a6@SoMainline.org>
 <Y8ejxsqeHL/pBTAY@smile.fi.intel.com>
 <20230118092950.kctzkvz5h6rzi7rp@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118092950.kctzkvz5h6rzi7rp@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:29:50AM +0100, Marijn Suijten wrote:
> On 2023-01-18 09:46:14, Andy Shevchenko wrote:
> > On Wed, Jan 18, 2023 at 12:12:04AM +0100, Marijn Suijten wrote:
> > > On 2023-01-17 11:39:44, Andy Shevchenko wrote:

...

> > > > -	const char *name = fwnode_get_name(fwnode), *channel_name;
> > > > +	const char *name, *channel_name;
> > > 
> > > I don't think this'll compile as name is still a pointer to const data,
> > > while you're assigning (a '\0' char) to it below.
> > 
> > Right, it's always hard for me to compile things for ARM on x86 :-)
> > Thanks for catching this up!
> 
> Thanks for sending this in regardless; as said before I rather break ABI
> and clean the driver up properly (no more extend_name...) than sending a
> fix like this :)

Yes, but we need to backport something and ABI breakage is definitely not
an option for that.

> > But does this fix the issue after compilation fix?
> 
> It does, no more @xx in sysfs filenames nor label contents!

Okay, I'm about to send v2 and hopefully you can give your Tested-by.

-- 
With Best Regards,
Andy Shevchenko


