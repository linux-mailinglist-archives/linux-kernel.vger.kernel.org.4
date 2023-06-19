Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4A73532B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjFSKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjFSKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:41:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7707186;
        Mon, 19 Jun 2023 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687171307; x=1718707307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vj1LZCY5tVAC4efMLkoqqYSvlGvU5CP11qFPl/AedSs=;
  b=iLPFiaIqQcSV7M6vcDE+VWYNHZLTmxrXLzKrzyZinV2CJNBPQa/B8c1Y
   bcJuKCskFy9VAyoEjLmZTeB7kWqTZvCN/AWTf+w0mhOLR7WD9zh8TjEyr
   4ROnaCvKDOMPC8BB2Z3euIpfPoBE3GdTbnOwe/wYjKDGLyk4EYxupwMvx
   SSLnVKxAe4Oi5c5Oz8gbKZjNm1MtH6tSBIR+d555hmwAVg6AiLLT2r4kh
   +t3FXY77gCBkVynYRNnDxIiPCaKs3CcSxWcU1T5Lf/pTbW/Wv9i2B/nuU
   KXPp/3OWy5f83VtLj+QeDJZMHc45WOXZpYKsQi/Mil40Fxc2Th3L2vAAv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="425553083"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="425553083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 03:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="716823168"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716823168"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2023 03:41:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qBCKN-004y5A-1N;
        Mon, 19 Jun 2023 13:41:43 +0300
Date:   Mon, 19 Jun 2023 13:41:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Drop unused domain_ops memeber of GPIO
 IRQ chip
Message-ID: <ZJAw507ODTUX2elD@smile.fi.intel.com>
References: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbPEvVvaehB521gdjkkzh+wFnFxsCNm36PD-hnTb1Na_w@mail.gmail.com>
 <87y1kipeui.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1kipeui.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 11:23:17AM +0100, Marc Zyngier wrote:
> On Sat, 17 Jun 2023 10:08:10 +0100,
> Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Jun 16, 2023 at 3:53 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

(...)

> > > -               /* Some drivers provide custom irqdomain ops */
> > >                 gc->irq.domain = irq_domain_create_simple(fwnode,
> > >                         gc->ngpio,
> > >                         gc->irq.first,
> > > -                       gc->irq.domain_ops ?: &gpiochip_domain_ops,
> > > +                       &gpiochip_domain_ops,
> > 
> > We better run this by Marc Zyngier, and Thierry who introduced it.
> > 
> > But some grepping and looking seems to conclude you are righ!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> No objection from my end. If this is unused, let's kill it.

Grepping by two independent people and so far no complains from CI, I believe
the patch tells truth.

> Acked-by: Marc Zyngier <maz@kernel.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


