Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A962490B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKJSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiKJSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:06:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393713F93;
        Thu, 10 Nov 2022 10:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC9B61DE9;
        Thu, 10 Nov 2022 18:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9630FC433C1;
        Thu, 10 Nov 2022 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668103602;
        bh=ymv93fw8232T14FWYerOXLO1Sz8xk73G0SrPUp5YyFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w0ZgmvOVNVz88EXwMg6+3V2sp0eufwrD5nFsj/vWptph9gzMbo82Aty5S3v1zcZkL
         KGxC18QCrb4plIrQDE0IRqqN6KTEAQUtXGYaPZLrbm4L2K3hACbd7fycbgOckOqdsf
         fz32MmuoS5QixOs/P2/CTw4tyaj2NDJbQemj2rtg=
Date:   Thu, 10 Nov 2022 19:06:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y209rznr0BB633rY@kroah.com>
References: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
 <20221107124517.1364484-2-kumaravel.thiagarajan@microchip.com>
 <Y2uWftt5b2AWyTtX@kroah.com>
 <BN8PR11MB366816A34B16BE29A5FD7912E9019@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB366816A34B16BE29A5FD7912E9019@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:18:46PM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, November 9, 2022 5:31 PM
> > To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
> > quad-uart support.
> >  
> > On Mon, Nov 07, 2022 at 06:15:15PM +0530, Kumaravel Thiagarajan wrote:
> > > +++ b/drivers/tty/serial/8250/8250_pcilib.c
> > > @@ -0,0 +1,31 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Microchip pci1xxxx 8250 library. */
> > 
> > Better name and a copyright line?
> Yes Greg. I think "8250 PCI library" would be the correct name. Is that fine?

That would be good as obviously it's not a microchip-only thing here.

> Regarding the copyright, we moved the "setup_port" function from 8250_pci.c to this new file.
> Can I use the same copyright statement from 8250_pci.c "Copyright (C) 2001 Russell King, All Rights Reserved."?

Yes, that would be good.

thanks,

greg k-h
