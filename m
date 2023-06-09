Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE1729CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjFIO1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjFIO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:27:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B0B3C2A;
        Fri,  9 Jun 2023 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686320799; x=1717856799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9bI0m+ifES+6k8pQzzNX2KP969ALq4IZ/1G6tuuvLB4=;
  b=K144sWYmy7kS/OcBx/NatGVj1PpWLxBtZHp22ZoTz6O4QTinr5LPDmgj
   qZV1aRqJrUNnKIzdhGP89ybnzJlxJVODjC0FgtG5biHG9FDpi6vemlooa
   TkzgjtlFHjf2qg+d1+/OmMwcdHVhnx6OdiyGz3dMC7MIYmbJGqNz5bH7d
   KFmGV2ZGJQrQEs98UtHcTESAbbK1SRopfH94DClGbkbirVjH8SFJo07dV
   6RVLzUPSQ2EYnwjv9nLbAbdSynMl5xuj8g2IhiZAqoCRv+/yg14fFZ8sQ
   SuSCOo2pr5rTwLi804fLNikna74vUNWoPVT02USYWSSAz+hDr2ppHBusK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355096131"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="355096131"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 07:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780330340"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="780330340"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2023 07:25:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7d3M-002Pzt-31;
        Fri, 09 Jun 2023 17:25:24 +0300
Date:   Fri, 9 Jun 2023 17:25:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <ZIM2VK9MlxGqBfDT@smile.fi.intel.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-2-henning.schild@siemens.com>
 <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
 <20230530171100.75e5b86c@md1za8fc.ad001.siemens.net>
 <ZHjLjU7WPv2W9SuJ@smile.fi.intel.com>
 <20230608173027.GL3572061@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608173027.GL3572061@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 06:30:27PM +0100, Lee Jones wrote:
> On Thu, 01 Jun 2023, Andy Shevchenko wrote:
> > On Tue, May 30, 2023 at 05:11:00PM +0200, Henning Schild wrote:
> > > Am Sat, 27 May 2023 11:54:08 +0300
> > > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > > 
> > > > On Wed, May 24, 2023 at 02:46:25PM +0200, Henning Schild wrote:
> > > > > The entries do not seem to be stricly needed when the number of
> > > > > entries is given via the number of LEDs. But adding them is a
> > > > > safeguard should anyone ever iterate over the tables to their end,
> > > > > it also gets us in line with other drivers that register
> > > > > "leds-gpio" tables.  
> > > > 
> > > > Reported-by?
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > I think we could do
> > > 
> > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > on merge. But i would not want to send the whole series again for that
> > > one line.
> > 
> > Since you added it, `b4` will happily take it, I believe no manual work even
> > needed for that, thank you!
> 
> b4 didn't pick this up.  Nor the whole-series Ack provided by Hans.
> 
> I added both manually.

There is an option to take this

  -t, --apply-cover-trailers
                        Apply trailers sent to the cover letter to all patches

have you tried it?

-- 
With Best Regards,
Andy Shevchenko


