Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F364E820
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLPI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:26:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B6E0A9;
        Fri, 16 Dec 2022 00:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671179177; x=1702715177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vM5A9CqvPeqje6H8CYXLm2+IRrn5FrUkt/f4Pyg/fvg=;
  b=Fs/uvHeAuSSSrEg828Z0Qco5wVKPj3d1gK51biErHUjPkVRUNzYD+GMm
   Qpi2zJG5gnsFJOF5KJfC7iNKs/tpLjX8UQ5Od+RTx702U9hFbD4AAJreU
   748yRKxc73+bBKUzdXvv1t4b8xVxNCmW7pHJCK4C1I/QO58nI+v6vYXpA
   CQAOxitHrmihVTfbt0QtCHwYKorBzK3SHmLjL7B5YboLhne+T19kgV4Oz
   NINP7sEaGpBU3X8vKVGjGkvA2kAN+6bF0TL25140cV8D5QkZtHlPvw229
   RoHKCogMLlhwge1yqHHOfn/dCh9CoENmXZvgZktXLDB/2zzTTG/smwdDs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="317612042"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="317612042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 00:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="978538954"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="978538954"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2022 00:26:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p662h-00AkMH-2T;
        Fri, 16 Dec 2022 10:26:07 +0200
Date:   Fri, 16 Dec 2022 10:26:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, cang1@live.co.uk, colin.i.king@gmail.com,
        phil.edworthy@renesas.com, biju.das.jz@bp.renesas.com,
        geert+renesas@glider.be, lukas@wunner.de,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
 <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 05:40:31AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, December 15, 2022 11:13 PM

...

> > > +     ret = serial8250_pci_setup_port(pdev, port, 0, port_idx * 256,
> > > + 0);
> > 
> > Actually isn't 0x100 better (show that there is an offset rather than a value of
> > an register)?
> 
> Okay, I will so something like this,
> #define PORT_OFFSET 0x100
> ret = serial8250_pci_setup_port(pdev, port, 0, PORT_OFFSET * port_idx, 0);

Makes sense.

...

> > > +     num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd,
> > PCI_IRQ_ALL_TYPES);
> > > +     if (num_vectors < 0) {
> > 
> > > +             pci_iounmap(pdev, priv->membase);
> > 
> > Here is inconsistency on how you interpret pci_*() calls when
> > pcim_enable_device() has been used. I.e. for IRQ you don't deallocate
> > resources explicitly (yes, it's done automatically anyway), but you explicitly
> > call pci_iounmap(). Choose a single approach for all of them.
> 
> AFAIK call to pci_iounmap cannot be avoided since pci_ioremap_bar is not 'managed' API.
> You suggest calling pci_free_irq_vectors (even though it is not mandatory)?

Why is it not mandatory?

-- 
With Best Regards,
Andy Shevchenko


