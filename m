Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5AF60158E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJQRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJQRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:41:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856E10FDE;
        Mon, 17 Oct 2022 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666028488; x=1697564488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8osIpt6gksLnp3R/Qc2SbxWd+wklyrVWCqfv6YEVIxQ=;
  b=gsQrNdCWcUu6b7Ob4B84IUhwx4m6zE0/cHTSUqECdVkz3x88kakhEtB8
   NwssmfQWEV/TCEJaRb3uNwFanTc7vNCrelgBJoYHse4lhi5NrkiqGBBLB
   bDmg/EIM9BKMJ0F82H0Jo1QZsVbHrzRrzmG/tlMo5uBHZ4jKs5BxtElK8
   3EFDJwrtNNqa6olQ8fWsZYzxYtaO5/yjRGVRKhjyIctOjwPb8TMpXb+CH
   H6s/NRBs4yWJ5nz9l+oqbZdzGewNa4SG6ksTNQqeRjcVcDUKanB+Z1f/o
   sY6fD47pjwlMQHv+Pg1mCYwzEukE6StvtIE+5uoh2rbgu7/hosOiHI76A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="286262596"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="286262596"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="606208803"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="606208803"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2022 10:41:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okU7A-008wjI-1a;
        Mon, 17 Oct 2022 20:41:24 +0300
Date:   Mon, 17 Oct 2022 20:41:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y02TxHp53XQo34ql@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-3-andriy.shevchenko@linux.intel.com>
 <Y02ObkYoUQlY9oG/@sirena.org.uk>
 <Y02SVH04iiu7Rj+8@smile.fi.intel.com>
 <Y02TR0UBseEKUjq8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02TR0UBseEKUjq8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:39:19PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:35:16PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 17, 2022 at 06:18:38PM +0100, Mark Brown wrote:
> > > On Mon, Oct 17, 2022 at 08:12:40PM +0300, Andy Shevchenko wrote:
> 
> > > > Since the PCI enumerated devices provide a property with SSP type,
> > > > there is no more necessity to bear the copy of the ID table here.
> > > > Remove it for good.
> 
> > > They do?  How?  Are you sure that this is true for all existing devices?
> 
> > Currently the board code assures that the property is always there for all
> > existing devices.
> 
> Which board code is this?  The names of the new properties you're adding
> is really not at all idiomatic for ACPI and this is pretty old code so
> it's surprising that there's not existing systems that don't have this
> in their BIOSs.

drivers/mfd/intel-lpss-pci.c.

-- 
With Best Regards,
Andy Shevchenko


