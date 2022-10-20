Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41FF606758
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJTRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:55:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15AFFF87;
        Thu, 20 Oct 2022 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666288514; x=1697824514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VgOcQsFKsb9PTUpe93UzLsTrOEooTIEEIGBTpePY8J4=;
  b=BK/1+lcLBNorC1BzpbSfcmSphmgoyZDD1g5Y/TrO1xHmzrCJ4bqVxAbr
   sPDuVXw7hAjl14zcrd6gJpJtOwvY9n9HTZUly4ajNiKTA1IcYtpbsTuJ4
   DIYgbfEKhuygka4Nlt+f22F/h3+B41eLy7eBWxPS1Sd/uM9PmZlRCfAK7
   0nXcTPKBsJEiTdOOKMIeZPZ5t4UFmWRfydn+XoqPWuc+2sMfZKX/DZA3F
   3M2skzH/uxiTs81PW9LAMYRQy6P2oBh5JOpprWgVnreOCyjPaGMZF7Q+n
   xv1JrQSDvV5dg3rWSLt3oWRkghIQ/AXDWReEArPFH4a10i/FS3ZYz54fV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306784525"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="306784525"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719208411"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="719208411"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 10:55:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olZl0-00AgDi-0z;
        Thu, 20 Oct 2022 20:55:02 +0300
Date:   Thu, 20 Oct 2022 20:55:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GLdp9GCqD7CdfW@smile.fi.intel.com>
References: <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
 <Y1GJL8/YfeoUy8wB@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GJL8/YfeoUy8wB@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:45:19PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 08:41:43PM +0300, Andy Shevchenko wrote:
> 
> > Okay, would it work for you if we check the named resource and only if it's
> > found take a property? In such case we can guarantee (AFAICS) that the 3rd
> > parties (like unknown firmware) won't mess up with the driver.
> 
> Not sure I quite get what you're proposing here but I *think* so,
> assuming you mean checking the values if the property is present (and
> error out if the property isn't there at all and you're instantiating
> via a MFD rather than direct PCI/DT binding I guess)?


When we instantiate via MFD, we (semi-)manually create resources for each of
the children. These resources may or may not have a dedicated names. Those
names can be given _only_ inside the source code in the kernel, so it means
it is _explicit_ telling, that we are know where the device in question comes
from.


In the code it will be like


	if (resource_with_name_present()) {
		ret = device_property_...
		if (ret)
			return ERROR "No mandatory property provided";
	}

Like you said, checking property only when we have resource present _by name_
and bail out if there is none.

-- 
With Best Regards,
Andy Shevchenko


