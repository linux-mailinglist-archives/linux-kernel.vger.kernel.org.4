Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74E630E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKSMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:05:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4633C;
        Sat, 19 Nov 2022 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668859525; x=1700395525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ap6fgQbCs+mHikafYbBi+Rw0G7AkI7HJ7FsfJMI09M=;
  b=dZCinf/JvZ8sOaCTkoStO1aWqOdDCj2FwhFVsyHgJhy23PmUOWLdOgDI
   coJjL8UKvYLy5fBEeV9HvrWdzoS2QnaZJrCNKbO7/XfTiNNIV26PGH7L4
   gL8FE+hJPzcr+qnjEK8YU1SecBohXd/XjlbVy6mTP7PtpkHmkCQVGJE3m
   KcNnXJPuKyfLaDBgdemqLYUFRDIUBrHUTbwVyrBuFBqnbcF85WEsvNHoc
   p3aTq1OZuZjWXj+HSi0yDKarEZKJG/l2a/yRbgITRobxF0kG7D1Lpev3A
   myGm4seec+ca1KActJOCJlIWCW/agTlnyX7KjFHlfW30Z1m2+oQUFUNui
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="377576220"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="377576220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2022 04:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="640518529"
X-IronPort-AV: E=Sophos;i="5.96,176,1665471600"; 
   d="scan'208";a="640518529"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2022 04:05:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1owMay-00ERUl-2i;
        Sat, 19 Nov 2022 14:05:16 +0200
Date:   Sat, 19 Nov 2022 14:05:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com
Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y3jGfO5wboXe66KB@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
 <Y3Xa9fRP3GGygiVj@smile.fi.intel.com>
 <PH7PR11MB59582CE57CE17F20A041157F9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y3dh4UlWKP2FzTpq@smile.fi.intel.com>
 <PH7PR11MB595845BBDBD65FB114018C339B089@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB595845BBDBD65FB114018C339B089@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 03:50:02AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, November 18, 2022 4:14 PM
> > To: Tharunkumar Pasumarthi - I67821 <Tharunkumar.Pasumarthi@microchip.com>

...

> > > > Don't you have a dependency issue here?
> > >
> > > Okay, I will explain the need for the changes done in commit description.
> > 
> > What I meant is that the 8250_pci patch should be _prerequisite_ to your
> > stuff and not otherwise.
> 
> Hi Andy,
> So, do you suggest having these changes done as first patch of the patchset prior to patches
> specific for our driver?

Yes.

-- 
With Best Regards,
Andy Shevchenko


