Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407AE671E87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjARNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjARNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4910F0;
        Wed, 18 Jan 2023 05:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674048169; x=1705584169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nj0qpQdgtaOkN7UVN/SyAs7hEIf/6xEd/lNQJtbQvrk=;
  b=Xt265l+HwZoCu+7oK//xxbw7qbit/qoOIrcXoamq9d/LT+NEfDwTlLfg
   DWMu4Sq3hy+Z3Q96lDU+CtOt0sRC9l4GQNIV8lGa2EJtoak6RsBDzOx35
   R7551QFIjv7lF+olv/lU7a05xTZlfn22z/gLOud6m/SS3RWbbm+8B9+Xr
   lX6SHjdHwwURW+yNqDmp8DDwDwc/hR7Se0DbcskXPMZNKXzUwZeS1NFqK
   HlVdue+dql9CF7cEBVRE9wdz9EFmCiV9jzdHDCyZiQGC2UykIFS0xB7lk
   n3tRNGXmg0zrNuI5CTKdfskdQbqVHiWbExqMAW/bBn8dKhmH7ue8+Ux78
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="387330412"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387330412"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:22:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="609649791"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="609649791"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2023 05:22:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI8Oo-00BCHY-1j;
        Wed, 18 Jan 2023 15:22:42 +0200
Date:   Wed, 18 Jan 2023 15:22:42 +0200
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
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <Y8fyonSp49QoAb8v@smile.fi.intel.com>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 01:35:28PM +0100, Marijn Suijten wrote:
> On 2023-01-18 12:06:23, Andy Shevchenko wrote:
> > The node name can contain an address part which is unused
> > by the driver. Moreover, this string is propagated into
> > the userspace label, sysfs filenames *and breaking ABI*.
> > 
> > Cut the address part out before assigning the channel name.
> > 
> > Fixes: 4f47a236a23d ("iio: adc: qcom-spmi-adc5: convert to device properties")
> > Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Thank you!

My answers below.

...

> > +	name = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", fwnode);
> 
> Is this better/cleaner than copying the string from fwnode_get_name?

Coying to where? And what would be the lifetime of that string?

With devm_kasprintf():
- we don't care how long the string is
- we don't care about corner cases of lifetime as it's the same as
  device itself (i.o.w. the same as the IIO device container)

...

> > +	name[strchrnul(name, '@') - name] = '\0';
> 
> This is the same as *strchrnul(name, '@') = '\0'; if I'm not mistaken.

Yes, But it's harder to read and understand. I believe the compiler has
enough power to optimize this to the same assembly code.

-- 
With Best Regards,
Andy Shevchenko


