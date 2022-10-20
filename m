Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE75606812
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJTSTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:19:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6921E5767;
        Thu, 20 Oct 2022 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666289950; x=1697825950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtFi0IdneB9mqNUg/wvuCL4g5v4DiS3LPtKl7NyWaS8=;
  b=lm+vGm+M4mM2AQNvoTUkF/V4/HbFnAKl/q+QH2VPtDU5oyWVdvXsr1Lx
   /54AB6Zf7Sv7iZv8bo3iHaW74gGb2kTjWElozBXwUWbhbTFr8SYEEAr0v
   5u4jmAMxL9M1HQNWZOl1MQAyUiQi9v+Tf6I/TcjgZljMZI9JReO2nI5rl
   b7nWZvl0nDIVHvnHyzoGrc8SSbYSfcxonVKZzXTsbjBqlRe25oO4WH3P0
   PNy6sC7p659mQR81YTsrBPe4lsxsBOBRUQv0A8gKy1srF1uHGLtbcfC5k
   9+janaedmdmzt9JWbvsj6TxKKflfwqQVDGuAl8uhm+1m2KNqJqlw8u20G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308480431"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="308480431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772529591"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="772529591"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2022 11:19:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ola8I-00Agpt-2X;
        Thu, 20 Oct 2022 21:19:06 +0300
Date:   Thu, 20 Oct 2022 21:19:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GRGrt8EvhoeV0z@smile.fi.intel.com>
References: <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
 <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
 <Y1GOTtYIeOFmrmm7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GOTtYIeOFmrmm7@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:07:10PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 08:55:02PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 06:45:19PM +0100, Mark Brown wrote:
> 
> > > Not sure I quite get what you're proposing here but I *think* so,
> > > assuming you mean checking the values if the property is present (and
> > > error out if the property isn't there at all and you're instantiating
> > > via a MFD rather than direct PCI/DT binding I guess)?
> 
> > When we instantiate via MFD, we (semi-)manually create resources for each of
> > the children. These resources may or may not have a dedicated names. Those
> > names can be given _only_ inside the source code in the kernel, so it means
> > it is _explicit_ telling, that we are know where the device in question comes
> > from.
> 
> > 	if (resource_with_name_present()) {
> > 		ret = device_property_...
> 
> > Like you said, checking property only when we have resource present _by name_
> > and bail out if there is none.
> 
> Remember that device_property backs onto fwnode so properties can come
> from _DSD properties too since fwnode will query any source of
> properties (and further remember that things will be going through
> multiple trees so even with stuff purely in the kernel things could get
> out of sync).

> I think the code would have to also check that it was a
> MFD child at least,

That's exactly what I'm talking about when said "named resource check".

> you couldn't get _DSD on a child node so that should
> be fine.

So, I guess we settled down this. I'll prepare v4 with the discussed changes.

-- 
With Best Regards,
Andy Shevchenko


