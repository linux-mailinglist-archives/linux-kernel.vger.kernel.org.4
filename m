Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D05F7619
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJGJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJGJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:22:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FECCA8BB;
        Fri,  7 Oct 2022 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665134549; x=1696670549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y6QovZnXopByWxgIdjW4Tq1EYB20Z0xAuPpsuOHfho8=;
  b=hiJ13tI+3/e3P42NHs/q2OWrkofHkTZbq4V69KiKn0G4iq2R2Aw3Vsst
   sPoeyJLe+GvjzHgNk9YyeU1d24i8j3o43+tQqG0QzSGvquPVk9HDX8znL
   8iJWWgwczGD0L0QZXJDW9RWmtaGAEddtJSbA0loJ1dC6ZHv1rz4Be9Y0Y
   HpXz65HwAs0627oAUYqSoOQDUp7wyhWr+mAmD1cWSrIDGwSQHorf9ZMT3
   N+f7SRqHjh4xr3d0NVazCMZ1ahxvFANe4ufMb4/w8iQkWhNfPrKfZIiO+
   bIOkfJz52iXLHSgbTCZPMDKrTVv3xwU0qt7I8I1xxuBusMVI+3nHGLF5a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="305275186"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="305275186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 02:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767518301"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="767518301"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2022 02:22:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogjYj-003Y19-1q;
        Fri, 07 Oct 2022 12:22:21 +0300
Date:   Fri, 7 Oct 2022 12:22:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Yz/vzV038AA1UUD1@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <c83f7ad5b5f67da86bec222f970305a1990e8181.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83f7ad5b5f67da86bec222f970305a1990e8181.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:04:20AM -0700, Joe Perches wrote:
> On Thu, 2022-10-06 at 21:32 +0300, Andy Shevchenko wrote:
> > On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:
> > > KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
> > > include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> > > tap/motion detection, wake-up & back-to-sleep events, four acceleration
> > > ranges (2, 4, 8 and 16g) and probably some other cool features.
> []
> > > +/*
> > > + * Threshold for deciding our HW fifo is unrecoverably corrupt and should be
> > > + * cleared
> > 
> > Multi-line comments have to follow English grammar and punctuation,
> > i.e. trailing period.
> 
> I disagree.  I think that would be a silly rule to enforce.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-style-notes

-- 
With Best Regards,
Andy Shevchenko


