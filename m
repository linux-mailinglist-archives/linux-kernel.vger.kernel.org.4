Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20068602BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJRMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:42:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F7A87A7;
        Tue, 18 Oct 2022 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666096932; x=1697632932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsAE7+/Uvyq9EmYiyG/WgM2cVqod6GgSrZuR7R1V7Ro=;
  b=CF7pSVCYQINFfR9vaYRXFbFjnsRgkjIEbQoBegnabnrnWcNXUKCSa6Ui
   kNQyIJcs9/KfhaMcfVdlxY03SDsVwY3QJxQOUX92OBTudmTnczIvHFvLM
   HLTWRFa5hGZBqqU85ajXxuQA0A/VnS4aoba1xOoFBrbhRt4oU+52X0nLc
   tlkaqZWDeVCWC0PTGOh3+0wrXdWbknPHYBgeJnquUCUx3jUuRbvyGwAQG
   Rgd01Dpl9NpAgmSbUcDeQfAxzG7ZdxROc117Ct2KhQ/tTBHEhJ0Xf7Pca
   /o/vtMSRDxOJdtP/Ed9Cg3seftDqudVIJxNQMpzxFE3BaKKW6+a/mi2iK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="304829082"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="304829082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 05:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606520561"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="606520561"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 05:42:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oklv4-009MLZ-33;
        Tue, 18 Oct 2022 15:42:06 +0300
Date:   Tue, 18 Oct 2022 15:42:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y06fHg6JdSA2GbII@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <20221009133351.6ff4894b@jic23-huawei>
 <Y0O4fiQQX0M317h/@smile.fi.intel.com>
 <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
 <20221014142232.000038df@huawei.com>
 <b7017e04-83a0-da3e-4ea7-28a2d34febc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7017e04-83a0-da3e-4ea7-28a2d34febc8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:27:20PM +0300, Matti Vaittinen wrote:
> On 10/14/22 16:22, Jonathan Cameron wrote:
> > On Tue, 11 Oct 2022 09:10:21 +0000
> > "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> > > On 10/10/22 09:15, Andy Shevchenko wrote:
> > > > On Sun, Oct 09, 2022 at 01:33:51PM +0100, Jonathan Cameron wrote:
> > > > > On Thu, 6 Oct 2022 21:32:11 +0300 Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:

...

> > > > > > > +module_param(g_kx022a_use_buffer, bool, 0);
> > > > > > > +MODULE_PARM_DESC(g_kx022a_use_buffer, +		 "Buffer samples. Use
> > > > > > > at own risk. Fifo must not overflow");
> // snip
> 
> > > This would be a way to have the FIFO disabled by default and warn users
> > > via dt-binding docs if they decide to explicitly enable the FIFO.
> > > (Besides, I believe the FIFO is usable on at least some of the Kionix
> > > sensors - because I've heard it is used on a few platforms).
> > > 
> > > This could give us safe defaults while not shutting the doors from those
> > > who wish to use the FIFO. Sure we need a buy-in from Krzysztof / Rob,
> > > but that may be less of an obstacle compared to the module param if Greg
> > > is so strongly oppsoing those. (And the dt-property could also provide
> > > some technical merites as these sensors seem to really have differencies
> > > in FIFOs).
> > 
> > I'm dubious about having this for known broken parts - but I guess you
> > can propose it and see what the dt-maintainers say.
> > 
> > I don't want to see fifo size in the dt binding though.
> 
> // snip
> 
> > > > Also it needs some communication
> > > >   with a vendor to clarify the things.
> > > 
> > > I do communication with the vendor on a daily basis :] Nowadays Kionix
> > > is part of ROHM, and Finland SWDC has been collaboration with Kionix
> > > even before they "merged" (but I have not been part of the "sensor team"
> > > back then).
> > > 
> > > Unfortunately, reaching the correct people inside the company is hard
> > > and occasionally impossible - long story...
> > 
> > :)
> 
> Just a note. I have done some further investigation (further testing
> combined with tracing the SPI lines) and also got some answer(s) from the
> ASIC designers. First thing is that the underlying FIFO is 258 bytes and can
> hold up-to 43 HiRes samples. This is also fixed in the recent data-sheet.
> The register informing how many bytes of data is stored in FIFO is still
> only 8bits. When FIFO is full, the magic value 255 is used to indicate the
> 258 bytes of data. This explains the strange 42,5 samples (255 bytes) of
> data being reported.
> 
> Furthermore, I've noticed that the FIFO appearing to be "stuck", eg. amount
> of data stored in FIFO not decreasing when data is read is 100%
> reproducible. The condition is that the PC1 bit (accelerometer state
> control) is toggled before the FIFO is read. The issue does not seem to be
> reproducible if the PC1 is not touched. I have also asked if this is a known
> limitation.
> 
> Anyways, it seems we have a solution to the problem. We simply handle the
> case when 255 bytes is reported correctly (by reading 258 bytes of valid
> data) - and we prevent changing the sensor configuration when FIFO is
> enabled.
> 
> I will implement these changes to the v3 and drop both the module-param and
> the dt-property. Sorry for the hassle and thanks for the patience/support!

This is very good news, Matti, thanks for pushing this forward and finding
better solution!

-- 
With Best Regards,
Andy Shevchenko


