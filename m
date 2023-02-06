Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675B68BBDC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBFLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBFLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:40:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A4718173;
        Mon,  6 Feb 2023 03:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675683637; x=1707219637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8OVquFP/YCCQ6V8/1cK5P4W0ja+voevSOxp98+9pDo=;
  b=IL/PYYsaKaiAWwHSKRU54Vo0jKZki//RZfzcXXv60hXN3J3B0qVE44jr
   9nC3xK+bWkwfn+witA/gqKIt4JzmStIh4x4eMvxuIJb+KK4/IKWWqp4dG
   w2PwnT/8qTaCulTyPfsarLJOzDlZArWFTURQWM67qF9LUFtmHvfXxei3s
   ik/Ywqar753XppGmF6GK2S0LW7d9aufnxudZ8eN4niEn6abCRt9xOHe8v
   jYvTo78LqArqBJzw1fuaw8qNSoHrXx1b84UvCXLiaTXjXmedj/RQlYUC1
   JewkkFLSSvuDtRxH0EVeQeqSxPNQCiQlrxR7KXhiDmQUBM3UMlkKhZ+RJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="327817581"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327817581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="911896152"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="911896152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2023 03:40:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pOzrK-0039SN-0o;
        Mon, 06 Feb 2023 13:40:30 +0200
Date:   Mon, 6 Feb 2023 13:40:29 +0200
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
Subject: Re: [PATCH v11 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y+DnLV6Zfdy2Bz8S@smile.fi.intel.com>
References: <20230204053138.2520105-1-kumaravel.thiagarajan@microchip.com>
 <20230204053138.2520105-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204053138.2520105-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 11:01:35AM +0530, Kumaravel Thiagarajan wrote:
> Move implementation of setup_port func() to serial8250_pci_setup_port.

...

> +++ b/drivers/tty/serial/8250/8250_pcilib.c

> +#include <linux/errno.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +#include "8250.h"

Ah, of course, you missed

#include "8250_pcilib.h"

here.

-- 
With Best Regards,
Andy Shevchenko


