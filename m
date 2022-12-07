Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0F64591E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLGLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:36:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C63C6D9;
        Wed,  7 Dec 2022 03:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670412971; x=1701948971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VvwhIvwaFGUDcYzjVl+wTAcDDnf124tu8EmNNmPTQfQ=;
  b=BTF0Q0E6V33wox1peEsg6wHFA2XHBwX22kSZEPayNjf42lC46F+p7vbf
   /iQ4+SoQXo+LGK5bp1AwfNvFzlsgHFFuujS7XtbNov74y4IywmNt0/Eiw
   +bx4UmdWVBKZD1MfpmbBDhZvP94uId8sk6CX5Ss129fB9iJP/FcP2kxqC
   mZqw28ZUJpEaQroY5gaSbBiB/WcN79X6pXuWziax3/Cy2uOzNJKjsYeC5
   ix4eE49YC2F2Y1Gu1aYkWfVhu2IajE3oAaSbyAq+iP7BYDyOTCigbbx89
   d1b2ScY5SBnUVNO+kciJVlo4jiti7FrTY8TRkXg/plNxm/uhKM9k1fxJz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="379036901"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="379036901"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 03:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="715159275"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="715159275"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2022 03:36:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2siZ-005kA2-10;
        Wed, 07 Dec 2022 13:36:03 +0200
Date:   Wed, 7 Dec 2022 13:36:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, cang1@live.co.uk,
        colin.i.king@gmail.com, phil.edworthy@renesas.com,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v7 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y5B6o5DL7piRnNjy@smile.fi.intel.com>
References: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com>
 <20221207235305.695541-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207235305.695541-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:23:02AM +0530, Kumaravel Thiagarajan wrote:
> Move implementation of setup_port func() to serial8250_pci_setup_port.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(One nit-pick below, though)

...

>  config SERIAL_8250_PCI
>  	tristate "8250/16550 PCI device support"
>  	depends on SERIAL_8250 && PCI
> +	select SERIAL_8250_PCILIB
>  	default SERIAL_8250
>  	help
>  	  This builds standard PCI serial support. You may be able to
> @@ -500,6 +501,9 @@ config SERIAL_8250_MID
>  	  Intel Medfield SOC and various other Intel platforms that is not
>  	  covered by the more generic SERIAL_8250_PCI option.
>  
> +config SERIAL_8250_PCILIB
> +	bool
> +

Not sure why it's here and not just above 8250_PCI, but it's minor thing.

>  	tristate "Support for Pericom and Acces I/O serial ports"
>  	default SERIAL_8250

-- 
With Best Regards,
Andy Shevchenko


