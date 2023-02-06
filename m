Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17568BCBF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBFMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBFMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:23:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63009126F8;
        Mon,  6 Feb 2023 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675686183; x=1707222183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ry0VCACyy2TSCeYzgySUR4+4oUdolFw8BbatCEgmyHg=;
  b=CVq9iefHBnBm63oQd4lo2akw70NmoANhjhq014MabyV+IKvJiJJ5yKJy
   KLSims16H+M4iwQewqlI6rfNwbBl/F+8oN9sIXLV/fyknZTb+C5Way1Ov
   HbLVEfX98JB8kHJAtvpem+cv+emmS2m4JujHUjtFWOFelhjtCqrcvm6pz
   vwt6+UeSIvzPD0RsiEKOB6gclwLnR/2tLXtKd3F17gJN9rN82vtHBMQMO
   2hYyzUYGvTzRXWM4DjqcSV8JF/kJclRjrBO+ZCbmouSwPedim91ZjfpKc
   0Mf2wFdyl0aSphRaX075t9cbj/0iR/uyw9AJNdUPwxd2wOFtx6zA8uA7o
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="326880278"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="326880278"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 04:23:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="696858397"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696858397"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 04:22:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pP0WM-003ASn-2q;
        Mon, 06 Feb 2023 14:22:54 +0200
Date:   Mon, 6 Feb 2023 14:22:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, lukas@wunner.de,
        cang1@live.co.uk, matthew.gerlach@linux.intel.com, deller@gmx.de,
        phil.edworthy@renesas.com, geert+renesas@glider.be,
        marpagan@redhat.com, u.kleine-koenig@pengutronix.de,
        etremblay@distech-controls.com, wander@redhat.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v12 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y+DxHsudEDlMEoH6@smile.fi.intel.com>
References: <20230206172614.2928838-1-kumaravel.thiagarajan@microchip.com>
 <20230206172614.2928838-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172614.2928838-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:56:10PM +0530, Kumaravel Thiagarajan wrote:
> Move implementation of setup_port func() to serial8250_pci_setup_port.

...

>  #include "8250.h"
> +#include "8250_pcilib.h"

...

> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include "8250_pcilib.h"
> +
> +#include "8250.h"

I would expect consistency as per above.

-- 
With Best Regards,
Andy Shevchenko


