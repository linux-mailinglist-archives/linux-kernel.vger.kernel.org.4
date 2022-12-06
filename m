Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B2644E79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLFWSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLFWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:18:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B02326F3;
        Tue,  6 Dec 2022 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670365101; x=1701901101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/olmYmXC19tWhkfaoBMr6nH/+/kzO9cHDjZv6Ovsm9c=;
  b=dy64yFpzJjAZCDhx8RRMNAV6v3ZdH3Lha2teAbsQzMqgwdc/qEI3XXF0
   AVmPDGd41GWW8wnnHxrctXkUTYBkNoF+So+Z7VyNLz03ZAzxHfkkPJ28w
   QUxhd3qQ+W1qQ641W3UrAenbjrc2O+2fHyj83ydn4FkwB7PzaMH5Cq6ay
   7FFda9Jkd/3laE3k5z6BsCychPHucq7nV3d+xDPtbt6akblki/FanyvbJ
   YjWt10qKS7/o7f1fvspRehHH835Y5VfT3TrK0trDUoIX/+wTJZsAHrig/
   5wefsMWHUji8wUTF53zrnUbUyVH0umQCnX4xPbhWGGf/VtMMSiPSlNudD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="318600079"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="318600079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 14:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820738324"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820738324"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2022 14:18:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2gGS-005UOe-1m;
        Wed, 07 Dec 2022 00:18:12 +0200
Date:   Wed, 7 Dec 2022 00:18:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     ilpo.jarvinen@linux.intel.com, Kumaravel.Thiagarajan@microchip.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com
Subject: Re: [PATCH v6 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y4+/pBgrHmAdp4FV@smile.fi.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
 <20221201045146.1055913-2-kumaravel.thiagarajan@microchip.com>
 <1189f5af-aaac-f4c8-b928-cda183e7f90@linux.intel.com>
 <Y4iaC7rRkBhyOIsI@smile.fi.intel.com>
 <PH7PR11MB5958A77F93BB2ABE244123909B1B9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958A77F93BB2ABE244123909B1B9@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 07:09:29PM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, December 1, 2022 5:42 PM

> > > struct pci_dev;
> > 
> > + blank line
> > 
> > struct uart_8250_port;
> 
> Is the blank line required here?

Strictly speaking no, it's not required. But it shows the group of generic
forward declarations and specific to the topic (driver / subsystem).

-- 
With Best Regards,
Andy Shevchenko


