Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C69463F034
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiLAMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLAMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:12:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176519FEC6;
        Thu,  1 Dec 2022 04:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669896725; x=1701432725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+nyqNhr3DjrxmbKqi/W9O0lEzuiL8DE0wvsWkUYbdww=;
  b=Wt2OqPrbz+ba6aAM4OoVzuT35Ir4pXNwsQkts9y4DVh1b9UuZe9dSg6W
   W27lbaJ6B9qh6J39GCcK5mbR3ggNUYAr9Q1jetN0dAFcHbgx0BkCrcZtq
   Uvo7TMIi3iaXxpJe01Ex78Y/yQPo5+htBT77+4H56C79B+kb5P1JTzOqD
   srh1JeENmCWCikD2hBOxtDvGnzc6RpXl/SM5saAf5sE1peC0B8h9cBjgG
   kDsc4mRLtLFEKhCfuIdNcZs5UQDum0tZKqYtYeht+awROXM2XVnxYaT5J
   gYFTaeY/HQszwjtPQWKnRmY/r2Yn+4dwvEymyglKTZRlNhEg89GS938AD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="315693966"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="315693966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 04:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="677196479"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="677196479"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2022 04:11:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0iQ0-002mBm-0l;
        Thu, 01 Dec 2022 14:11:56 +0200
Date:   Thu, 1 Dec 2022 14:11:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y4iaC7rRkBhyOIsI@smile.fi.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
 <1189f5af-aaac-f4c8-b928-cda183e7f90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1189f5af-aaac-f4c8-b928-cda183e7f90@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:06:53AM +0200, Ilpo Järvinen wrote:
> On Thu, 1 Dec 2022, Kumaravel Thiagarajan wrote:
...

> > +/*
> > + * 8250 PCI library header file.
> > + *
> > + * Copyright (C) 2001 Russell King, All Rights Reserved.
> > + */
> 
> You shouldn't depend on .c file having things included for you. So
> please add these:

> #include "8250.h"

TBH I don't see how this is used here, but types.h for sure is missing.

> struct pci_dev;

+ blank line

struct uart_8250_port;

> Other than that,
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> > +int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
> > +		   unsigned int offset, int regshift);


-- 
With Best Regards,
Andy Shevchenko


