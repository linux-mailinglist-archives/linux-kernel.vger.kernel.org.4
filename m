Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD95F760A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJGJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:19:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7236C972;
        Fri,  7 Oct 2022 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665134364; x=1696670364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoHyGOlZw7mT9PchNcyohGTzSrqH9AYZczrdE0VAU4M=;
  b=kyCvqBubOBZezdH4TXrbtP66CK3UlyUQMU9C7cPYB3JOtRsdCM8vWUvb
   oILIO7/RWD0qYRN4H792aarVY8yq7XVBGxNmdQgCUOE8PIYvkXcJ0IcXO
   XTafkxrVhl4nrw6KrxEy0d4gMDqqyPGd5Zx9JmtDuojcliTB/QhLKpNPc
   FJ8t4TjaxfgAmZ0o0L1CGGzcWubBo9s96B7go8eLTiBUcFcxoUsiUdliQ
   Dxzkolt3zaGPSq2rKE4r9h6waaXg831bN6KrnmjI/21yqwdL6v8zTBc9B
   A7nNHU6DjvqFwAbgQmlLTAI4ldbsPVqOazJWaZeGhOI9jpBFmlaCSdIHi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303672950"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="303672950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 02:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="620197894"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="620197894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2022 02:19:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogjVm-003Xxs-1k;
        Fri, 07 Oct 2022 12:19:18 +0300
Date:   Fri, 7 Oct 2022 12:19:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
Subject: Re: [PATCH v13 5/5] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Message-ID: <Yz/vFml0mwaF0+f9@smile.fi.intel.com>
References: <cover.1664991040.git.chiaen_wu@richtek.com>
 <1bcd19dbd09650ddac7b96b0fe2932698be2731e.1664991040.git.chiaen_wu@richtek.com>
 <Yz11bkxz9lK4wOHE@smile.fi.intel.com>
 <CABtFH5J2r=Qq1kNb=yp6Hf7=oKJH9qeiwsO+4ejy5m9N+ZODXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtFH5J2r=Qq1kNb=yp6Hf7=oKJH9qeiwsO+4ejy5m9N+ZODXg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 09:28:17AM +0800, ChiaEn Wu wrote:
> On Wed, Oct 5, 2022 at 8:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > > +config LEDS_MT6370_FLASH
> > > +     tristate "Flash LED Support for MediaTek MT6370 PMIC"
> >
> > > +     depends on LEDS_CLASS && OF
> >
> > Why do you have OF dependency?
> >
> 
> Hi Andy,
> The original idea is to use the "fwnode_property_*" related function.
> But this side may only consider just "Build Pass" (?)

Yes, you increase a compile test coverage by dropping that dependency.

> I will remove "OF" in the v14 patch.

-- 
With Best Regards,
Andy Shevchenko


