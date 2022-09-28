Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B65EDE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiI1OGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI1OGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:06:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247952829;
        Wed, 28 Sep 2022 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664374010; x=1695910010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/pDTZWoio171lecPqnLxeIbxprX6qX01McJBcMLCRU=;
  b=UrZVbhXVVCN492Yh0D3yl0wAIjXTs5dsyft+r1h2TWLOP7GcmhgS3BY3
   2WIVPjF2J3iYDIxS1l5Nf6Eo22QaWW25Q1R9W7Z9vrPWqjinD8C7xG+ZW
   SRgpl0yH0UzMKDrD8HHnSKuAKb1uCVw9dtxozmx7ngGRi2AjMgjBSx6sM
   EQ1iPP0qRtRTiQvIR8I0i29js3SnBB6M3Q5tndjxXDbklSyngTw9Tobm3
   0r88Z0Zr2JPAZqzfjbiTuJcUOUv+2ZctS7OGYeyjfekjaaX6Cjmj0x9/E
   ChWz9H0OLGRnB49yYtkICgZofryFvLj8jI4Hjaq1heGaJNBMk+hnaxq7P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363449995"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="363449995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="573047545"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="573047545"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 07:06:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odXi1-008xWy-24;
        Wed, 28 Sep 2022 17:06:45 +0300
Date:   Wed, 28 Sep 2022 17:06:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <YzRU9aRNReonSqbg@smile.fi.intel.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
 <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:14:14PM +0300, Matti Vaittinen wrote:
> On 9/22/22 20:03, Jonathan Cameron wrote:
> > On Wed, 21 Sep 2022 14:45:35 +0300

...

> > > +		dev_err(dev, "no regmap\n");
> > 
> > Use dev_err_probe() for all dev_err() stuff in probe paths.
> > It ends up cleaner and we don't care about the tiny overhead
> > of checking for deferred.
> 
> This one bothers me a bit. It just does not feel correct to pass -EINVAL for
> the dev_err_probe() so the dev_err_probe() can check if -EINVAL !=
> -EPROBE_DEFER. I do understand perfectly well the consistent use of
> dev_err_probe() for all cases where we get an error-code from a function and
> return it - but using dev_err_probe() when we hard-code the return value in
> code calling the dev_err_probe() does not feel like "the right thing to do"
> (tm).
> 
> Eg, I agree that
> return dev_err_probe(dev, ret, "bar");
> is nice even if we know the function that gave us the "ret" never requests
> defer (as that can change some day).
> 
> However, I don't like issuing:
> return dev_err_probe(dev, -EINVAL, "bar");

This case specifically was added into documentation by 7065f92255bb ("driver
core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER").

> Well, please let me know if you think the dev_err_probe() should be used
> even in cases where we hard code the return to something...

And this should be, of course, maintainer's decision.

-- 
With Best Regards,
Andy Shevchenko


