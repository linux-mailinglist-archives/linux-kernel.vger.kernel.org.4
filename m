Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4B6499FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiLLI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiLLI3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:29:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F86B7F7;
        Mon, 12 Dec 2022 00:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670833787; x=1702369787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4dNviz02Ym3Lpa3zAdpmD6jepk2MvQbhR+/jMPnbllo=;
  b=Tz0y/stPdnSF+Akm1EwlILgFctqr6A+/vCDT5rb1y9PggMhFyoUdBMD1
   iDFo3aqy/MuzIkPq8i7mJEohR5aBaCC7EmUUI/k+W5oJ6pwIZLpL36tsM
   y9MfafckmnbESh1oL0NdJDfoVnFA5kGgNWsv1hRSCuMdnWioyG6ikAMUY
   yZU/JiPxEHSLBHepzi4DBnqMuux1olpBaU00g+LCYUr6x8ns40v39ap63
   7TDomwqgKFrxONjVIIPTDABGEv2DbLqJEe7gx1aKQBVTERjz/4jRvemAR
   tEmqBkP+qgmmKBg4abbqukWGKtWHeFyK1boa4LtEr0pNUHQ9MD2Ovx6Ww
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317827675"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317827675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 00:29:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="625815522"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="625815522"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2022 00:29:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p4eBo-008NYI-12;
        Mon, 12 Dec 2022 10:29:32 +0200
Date:   Mon, 12 Dec 2022 10:29:31 +0200
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
Subject: Re: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5bma3Gp7pr+Ta7U@smile.fi.intel.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
 <Y5T2ymgsCQhggtvz@smile.fi.intel.com>
 <PH7PR11MB5958DC96634CFF28AFA8695D9BE29@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958DC96634CFF28AFA8695D9BE29@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 07:16:55AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Sunday, December 11, 2022 2:45 AM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>

...

> > > +             4,/* PCI1p3 */
> > > +     };
> > 
> > If you move this outside of the function you may use static_assert(), see
> > below why.
> 
> If you move this outside of the function -> Do you suggest to move the array outside
> the function

Yes.

> and make it global?

I don't get this, sorry.
The array is already global, only name is scoped inside the certain function.

...

> >         if (subsys_dev <= ARRAY_SIZE(max_port))
> >                 return max_port[subsys_dev];
> > 
> > (in this case you can make sure it is the same as the above using
> > static_assert(), so it won't compile otherwise)
> 
> I am not getting this. You suggest doing something like this:
> static_assert(subsys_dev <= ARRAY_SIZE(max_port)) ?

No, you need to compare ARRAY_SIZE() to the macro that you removed from
the context here.

...

> > > +     priv->nr = nr_ports;
> > > +     pci_set_master(pdev);
> > > +     max_vec_reqd = pci1xxxx_get_max_port(subsys_dev);
> > 
> > The above needs a bit of reshuffling and perhaps a blank line or lines.
> > Make it ordered and grouped more logically.
> 
> Okay. I will do something like this:
> 	pci_set_master(pdev);
> 	<NL>
> 	priv->pdev = pdev;
> 	priv->nr = nr_ports;
> 	<NL>

> 	subsys_dev = priv->pdev->subsystem_device;

Almost good, but why priv is still here?

> 	max_vec_reqd = pci1xxxx_get_max_port(subsys_dev);
> 	<NL>
> 	num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd, PCI_IRQ_ALL_TYPES);
> 	if (num_vectors < 0)
> 		return num_vectors;

-- 
With Best Regards,
Andy Shevchenko


