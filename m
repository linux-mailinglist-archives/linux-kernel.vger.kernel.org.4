Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861E604AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiJSPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiJSPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:16:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927AE45;
        Wed, 19 Oct 2022 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666192162; x=1697728162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BEhLcDiHCJYoVaxf1jyli6vQ72GwUtyBEW6sFVkFc4w=;
  b=VhGZEJYSkO0J1Jc1yklHaEHVRQuWMPXrbycK+OhTjT1XX7YS5O+RdD/P
   2sHMWkHks/2Jszyfno82wRtnVhtJnmG/qLRk1tKjd2H2Cko2tGwxHnbis
   3BMIYD7+wY0CPRhizZUdtygRRkD3ox0Hi6noBEOHFay1awZFzhqPGfXhk
   3CNQnZIMU8VWJitIz1LgpyZ1K3s76M0MB8mUJYyBj/ddOM90Qmj5UAKSh
   d3w0ApTBvg+aUYV94EztTW5I9g4myBEzKZMWeAOmrduPLeeWsfXGCnJxD
   DfzlRrnd5mVo8vzixIu0NY/XDFLIL942CJrbv8BXN4UhkuMdbe9ffAqmv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="304052076"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="304052076"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="662501612"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="662501612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2022 08:06:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olAdw-009uMs-17;
        Wed, 19 Oct 2022 18:06:04 +0300
Date:   Wed, 19 Oct 2022 18:06:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
 <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06RCxzwrPZwIETp@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:42:03PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:41:24PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 17, 2022 at 06:39:19PM +0100, Mark Brown wrote:

Thank you for your review!

> > > Which board code is this?  The names of the new properties you're adding
> > > is really not at all idiomatic for ACPI and this is pretty old code so
> > > it's surprising that there's not existing systems that don't have this
> > > in their BIOSs.
> 
> > drivers/mfd/intel-lpss-pci.c.
> 
> OK, so this is another push for device properties for passing stuff
> internally.  Please resubmit this series with descriptions of why this
> is being done - I really can't tell what the benefit is here in concrete
> terms, you say it somehow improves identification of which variant is in
> use but don't articulate specifically why.

I have sent a v2.

> You should probably also restructure the code interpreting the device
> IDs so that it's very clear that unknown values are handled well, this
> would split things between multiple subsystems and right now the code is
> a bit fragile.

I'm not sure how better to do this. Any example?

-- 
With Best Regards,
Andy Shevchenko


