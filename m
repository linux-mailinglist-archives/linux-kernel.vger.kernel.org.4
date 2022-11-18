Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E262F2CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiKRKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiKRKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:43:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FA9708C;
        Fri, 18 Nov 2022 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668768187; x=1700304187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZcv2hJ7U6AltpTNE/mtbJDFHOvOl2qQG65nN6vxtwU=;
  b=FUVvze8p4yCyjrMk8DeSSZ2mBxVmvQRIaDEBzG82PBKt764qYfX11t/m
   aYZ56gZ69KfbW1feCLOr64StW13FaVLwhoIeNa9N8+UspeiDx6LDbYr/N
   ddqXZn7FCdWO1H14NfyOo37Lag98/GeVgddZFoaJ9mngxFqM78H0hxmY6
   5d83yL6hpXtrPi3uYa1CmrMiopOuYOmIzZs0nVx77OiF8h5+VTCqtbsSQ
   zmLIAeSojC5FGYFjRMxId3qMbTNdjr8QOPfFGcbNjQ+SpagHXwroCQRJo
   w7vTRa597yMOmwblVJuHibD7rUUv76IKyKpE+BF/uiL6Bm6A7P3oafiiB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300645759"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="300645759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 02:43:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="969237827"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="969237827"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Nov 2022 02:43:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovypl-00E02x-2M;
        Fri, 18 Nov 2022 12:42:57 +0200
Date:   Fri, 18 Nov 2022 12:42:57 +0200
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
Subject: Re: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y3dhsULdJmoWN+TZ@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
 <Y3Xv6XOwddNq6Gmr@smile.fi.intel.com>
 <PH7PR11MB5958D56C366F39F5F044E11B9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958D56C366F39F5F044E11B9B099@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 09:37:02AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, November 17, 2022 1:55 PM

...

> > default?
> 
> Do you suggest using default case even if nothing needs to be done there?

Depends on the how critical the default case is. If nothing should be done and
it's okay, then

	default:
		break;

is what I meant. Otherwise you need to put something else instead of 'break;'
statement.

-- 
With Best Regards,
Andy Shevchenko


