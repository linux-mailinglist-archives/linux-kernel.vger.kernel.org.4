Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7D606733
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJTRly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:41:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FF1E3EEC;
        Thu, 20 Oct 2022 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666287708; x=1697823708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zqa3NpmLVBg/x7SRY7szp/6WhofOON8ApSrqA1GEnjA=;
  b=SO7ayA3+8xhO7pWhbW7V0SENQkLwMiZ5VBD2LfPekRqmD7cvcW0bS3xQ
   rFC4lkhjpTL2myc/A7NZYZ8AWQ9TVy68QvtAts1qtvfudPeWcunu0LvDG
   4qN6fvDgrLV6ZbinXfE/PoaUo+p9Ap5KBAfbXbzn0EkmepjW0ke3L48FI
   htEIMXafB+hrpD5irzjTscOw6nAJw85EiBVGwVhD/rnHxNjN85HYRDCLT
   WaqwVGQBQFYtIAPDptwps98g4HD/joYAYnIH9H8622/bqFq1LetpcHf5f
   hvauVLw0vJ+fuRyovpQxzhUl1pshnBN5Tx3YR/5eQNdcwbkeQwAPL/VZY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333357804"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333357804"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 10:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719202001"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="719202001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 10:41:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olZY7-00Afrb-33;
        Thu, 20 Oct 2022 20:41:43 +0300
Date:   Thu, 20 Oct 2022 20:41:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
References: <Y02TxHp53XQo34ql@smile.fi.intel.com>
 <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1GEqa07/b25utui@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:26:01PM +0100, Mark Brown wrote:
> On Thu, Oct 20, 2022 at 08:03:37PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 20, 2022 at 05:58:39PM +0100, Mark Brown wrote:
> 
> > > The driver won't even match and therefore load if it doesn't have a
> > > lookup for the device with the current code, the type code comes from
> > > the match.  If it has to go querying a device property then the driver
> > > can load but end up with a device property it hasn't ever heard of and
> > > end up misbehaving as a result.
> 
> > That's how all MFD devices work nowadays, right? What's so special about
> > this driver? It's being used as a child by MFD. If what you are telling
> > is a real concern, we have to have a way to assure that all drivers that
> > are children of the MFDs should provide a match. IIRC there is no such
> > mechanism exists in the kernel these days.
> 
> Most of the MFDs don't actually have multiple options for a given child
> driver, and it's common where there are multiple options to either bind
> with a different name representing the different child device or have
> something that looks like a switch statement for the IDs which will
> error out if it hits an ID that's not one the driver knows about (like
> spi-pxa2xx-pci does with lpss_spi_setup()).

Okay, would it work for you if we check the named resource and only if it's
found take a property? In such case we can guarantee (AFAICS) that the 3rd
parties (like unknown firmware) won't mess up with the driver.

-- 
With Best Regards,
Andy Shevchenko


