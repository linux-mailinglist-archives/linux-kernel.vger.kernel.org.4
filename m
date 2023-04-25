Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578B36EE35F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjDYNp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDYNp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:45:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FD19BC;
        Tue, 25 Apr 2023 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682430325; x=1713966325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/ABWJ2xxNYCYrGZUiTvjqFyFuCe4XdVVI+pcOUNIv8=;
  b=A4CO2wCD+vygGngqhNi+C+Juzoch3wTbsnSvCRehfyXVtkDiuxwfE3WX
   /aB2Ei0evzE/1jAnqfhG7gY77tlwg3Wn71bz5v7aat7PAqiEp2Ybl/M2v
   l3I94t4MXKYonXy3vjfF63iISI6TE8TPiIGiij4p1qY0jCRmxQZk31PaX
   GPwKH12kCprch3WT0xQ5I0R/+mMKBtAILxNi7DdFeZMyRt76FwsAUhUF7
   YpVdPmQfxr1ejB7fGKkZo8Twq/os0cO4Fmp8GB6PYxDYwGdJcDYA87tJJ
   uNb036Bl2REMitKaBq9dnBmCFGaDukrQFTqYtnNFg8fqPSMiuGWqjMtfh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="345521094"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="345521094"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 06:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="724036501"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="724036501"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2023 06:45:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1prIyt-00505G-0n;
        Tue, 25 Apr 2023 16:45:19 +0300
Date:   Tue, 25 Apr 2023 16:45:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <ZEfZbmczXmJjiNPP@smile.fi.intel.com>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <ZEaeoxdWTknLz7lQ@smile.fi.intel.com>
 <47998ed8-5160-69dd-1767-e1746971a9b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47998ed8-5160-69dd-1767-e1746971a9b9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:24:01AM +0300, Matti Vaittinen wrote:
> On 4/24/23 18:22, Andy Shevchenko wrote:
> > On Mon, Apr 24, 2023 at 04:10:09PM +0300, Matti Vaittinen wrote:

...

> > This...
> > 
> > > +#include <linux/bits.h>
> > 
> > ...is guaranteed to be included by this.
> > 
> > > +#include <linux/bitops.h>
> 
> Out of the curiosity - do we have a rule and rationale for explicitly
> including headers with 'stuff' we use Vs. trusting some header being
> included by another one? I've not thought much of this so I don't know if
> there are any pros/cons?

That's what we are starving for actually. Currently this is a tribe knowledge
which one gets while being involved into Linux kernel development for a long
time and being capable of keeping an eye on tree wide, library or similar
changes.

I would love to see some (preferably generated) list of the header
dependencies. Yet, the header dependency hell should be solved meanwhile
(see Ingo's 2k+ patch series).

-- 
With Best Regards,
Andy Shevchenko


