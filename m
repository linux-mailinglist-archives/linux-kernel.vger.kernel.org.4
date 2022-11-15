Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80844629388
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiKOIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiKOIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:46:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87653644E;
        Tue, 15 Nov 2022 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668501994; x=1700037994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qGN+O5tIcIPTk+XlnzxUZYtuaJ/yP+7c+eD0AhYkpI=;
  b=QzfSX9Na6rYfL9rFr74qONkeHoW2iI5c/yy0M9Cna5wk+NfIm4UHYbj9
   ZGln64t9ktuUHe2jNUm6+O8mXOTAlc46bDHk4e3FEsKrSqx5zVdGRbwpg
   y/Xx3Pk7rZ0xu5rEKJNsLVIbf1npIsVZiBzNTewyeiOtncm4uFw5vUQ51
   utbm9S//8xR0l8AsRm5HMYT/joey4ORm+8XBTA8MD9rpon9UWIpcI8B5K
   GT4Dmc84HbnPAVvo/BeWf5BbFwPx4TPrE2wQUPtCImZdLgDKMkXqyz1QZ
   z9Dlb/Zmcx3VYV1zplQ2oKgosZPI8TM09koh+YNDp1oLfk/DCruTn2BuD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="338995695"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="338995695"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 00:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967916320"
X-IronPort-AV: E=Sophos;i="5.96,165,1665471600"; 
   d="scan'208";a="967916320"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2022 00:46:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouraM-00CXqk-2v;
        Tue, 15 Nov 2022 10:46:26 +0200
Date:   Tue, 15 Nov 2022 10:46:26 +0200
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
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y3NR4jVJyhYzn0SV@smile.fi.intel.com>
References: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
 <20221111161130.2043882-2-kumaravel.thiagarajan@microchip.com>
 <Y256r//s3DCBI07+@smile.fi.intel.com>
 <PH7PR11MB59582DB8BA01F82441DF04439B049@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59582DB8BA01F82441DF04439B049@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:20:25AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, November 11, 2022 10:09 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
> > quad-uart support.
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > > +F:   drivers/tty/serial/8250/8250_pci1xxxx.c
> > 
> > Have you checked if 8250_pcilib.c needs to be added to the MAINTAINERS?
> > That's why it's better to split that change from this patch.
> 
> Code in 8250_pcilib.c (serial8250_pci_serial_port API) is taken from
> 8250_pci.c which is under copyright of Russell King. In the maintainers file,
> I was not able to find 8250_pci.c. Since, it is not developed by us, it is
> not optimal to add this file under 'MICROCHIP PCIe UART DRIVER' section.
> Where would you suggest adding this new file (8250_pcilib.c) in the
> Maintainers file?

No need, let's just keep a status quo.

-- 
With Best Regards,
Andy Shevchenko


