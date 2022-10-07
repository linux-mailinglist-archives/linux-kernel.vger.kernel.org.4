Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E425F7623
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJGJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJGJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:23:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB405DED39;
        Fri,  7 Oct 2022 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665134609; x=1696670609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wF0L8JKp6G/b7hzsjOLcyP2vJYun72D+/xZPLLlg6gw=;
  b=QKyNHLVBJHJk0tNpQzm5cYUMZDsApUsOBaRn8fVAHw7olrgQ30QgEqRy
   67+sSD0odeGbYa6obVHzQGecmqWkQ6pp+JykrzC2/xrUgo69JZzyi0AuF
   YelQsSSycYkf2nPuGqPWs9ouLSCtAsa55/IqmFtzVpHBLXBeKhfCH1v2x
   VfGxeV2B7e5aM40r0XbG0Jn3ZP5OVmQ5Crcd6fbrwN2gq0FB3eIXttoJJ
   nIL8nLnXb3Xg5q3KutZ0g9zGcvNtCs84hojZ8XfM+Y4CySwb3ruF468cL
   eGnGRu2dGaCVKBQazXEYKmK1s8B37zkL7+jK0avutDKYDwkAiqn6hMnx6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="301292357"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="301292357"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 02:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="602805095"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="602805095"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2022 02:23:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogjZk-003Y2X-0a;
        Fri, 07 Oct 2022 12:23:24 +0300
Date:   Fri, 7 Oct 2022 12:23:23 +0300
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
Message-ID: <Yz/wC6vgeWKmlAc7@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <c83f7ad5b5f67da86bec222f970305a1990e8181.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83f7ad5b5f67da86bec222f970305a1990e8181.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

First, you have to read that submission and find at least inconsistency between
styles used for different multi-line comment blocks.

-- 
With Best Regards,
Andy Shevchenko


