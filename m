Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B6371EF74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjFAQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjFAQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:47:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A060D1;
        Thu,  1 Jun 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638034; x=1717174034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mwd7Xa2qyhdeHinpRyrfZnTV5zF/HG4nOp7b7yy8waE=;
  b=EMBV4H1ux5GDpre7NTiIDR0j0JvZDUXwsDWEyHnqOqXWEaHCCXjDWx+C
   aLykyR2AFd0pSNNAur2LEohK3hWNmuWMzo1oY+zJpZJkzIpzSzdZULDiH
   xzFjfF+MUxcOXZzAuFPgD+T3y1EQ45i5rm5GbVaIPaY/QutmQEnmO3gpX
   KpyPtKPn1nPX5aY6fW7TrNb+eee5cC6gHCHSaLlrCEzvJ2drJHmvO0YH0
   DGMz5fdnX+6gkDR11qX1hbz4sh244tbFqSwFsLHXOXBgdxjsGMYvoEYwQ
   PFGNbaCiJe2lDfMC+9fMITwsT5ESK1Hp97aDg/+eQZdTOAdiGXlFHjAN0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353109928"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="353109928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="684920986"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="684920986"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2023 09:47:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q4lS9-000Smc-1o;
        Thu, 01 Jun 2023 19:47:09 +0300
Date:   Thu, 1 Jun 2023 19:47:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 1/4] leds: simatic-ipc-leds-gpio: add terminating
 entries to gpio tables
Message-ID: <ZHjLjU7WPv2W9SuJ@smile.fi.intel.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-2-henning.schild@siemens.com>
 <ZHHFMPEYNz9jBBRd@smile.fi.intel.com>
 <20230530171100.75e5b86c@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530171100.75e5b86c@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 05:11:00PM +0200, Henning Schild wrote:
> Am Sat, 27 May 2023 11:54:08 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > On Wed, May 24, 2023 at 02:46:25PM +0200, Henning Schild wrote:
> > > The entries do not seem to be stricly needed when the number of
> > > entries is given via the number of LEDs. But adding them is a
> > > safeguard should anyone ever iterate over the tables to their end,
> > > it also gets us in line with other drivers that register
> > > "leds-gpio" tables.  
> > 
> > Reported-by?
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I think we could do
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> on merge. But i would not want to send the whole series again for that
> one line.

Since you added it, `b4` will happily take it, I believe no manual work even
needed for that, thank you!

-- 
With Best Regards,
Andy Shevchenko


