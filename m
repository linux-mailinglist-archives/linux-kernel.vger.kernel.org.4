Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272136461FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLGUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:02:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E352B1EC;
        Wed,  7 Dec 2022 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670443363; x=1701979363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QiA1odkP/pscG7ADNPdd2N2pEJ4aIYrRjeu1tiCya+Q=;
  b=hsGRty4XNVkp+TO0q5smPEFkduI+mtNji1hQzVK6Z+9lrucvzVguOtJo
   2Yxt1z1YlEHWkJAx4rGquIuAdlFGrCKYC7jjKOsqmdzrN8nqsElee07yx
   aDM2KIT8OpETA5f430NCjh7LpYUxfTb5z6sIi/Gt84PmNAKi5WtlIxA9Z
   bJRsuKxqr8xWAxuXRKXM/krFMm1J19AT4dlzvOzd+r4/yq0gc1yZw3eAd
   aOyqY+0tz9tnN9clHRItqqi44bnXehApmuWdxBbl+L9eCcYO5oUT0Yz6G
   e+6MfvlQceuoYCr8vJgdVvZGrwKZRnKB6pBGTQ8ApjqejdpZQRTTgnCA8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381283040"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381283040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 12:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="679261930"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="679261930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2022 12:01:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p30bb-005yGd-17;
        Wed, 07 Dec 2022 22:01:23 +0200
Date:   Wed, 7 Dec 2022 22:01:22 +0200
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
Subject: Re: [PATCH v7 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5DxEszrq0rXVqvl@smile.fi.intel.com>
References: <20221207235305.695541-1-kumaravel.thiagarajan@microchip.com>
 <20221207235305.695541-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207235305.695541-3-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:23:03AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

...

> +static int pci1xxxx_get_physical_port(int subsys_dev, int port)
> +{
> +	static int logical_to_physical_port_idx[][MAX_PORTS] = {
> +		{0, 1, 2, 3},   /* PCI12000 PCI11010 PCI11101 PCI11400 PCI11414 */
> +		{0, 1, 2, 3},   /* PCI4p */
> +		{0, 1, 2, -1},  /* PCI3p012 */
> +		{0, 1, 3, -1},  /* PCI3p013 */
> +		{0, 2, 3, -1},  /* PCI3p023 */
> +		{1, 2, 3, -1},  /* PCI3p123 */
> +		{0, 1, -1, -1}, /* PCI2p01 */
> +		{0, 2, -1, -1}, /* PCI2p02 */
> +		{0, 3, -1, -1}, /* PCI2p03 */
> +		{1, 2, -1, -1}, /* PCI2p12 */
> +		{1, 3, -1, -1}, /* PCI2p13 */
> +		{2, 3, -1, -1}, /* PCI2p23 */
> +		{0, -1, -1, -1},/* PCI1p0 */
> +		{1, -1, -1, -1},/* PCI1p1 */
> +		{2, -1, -1, -1},/* PCI1p2 */
> +		{3, -1, -1, -1},/* PCI1p3 */

You can make columns nicely indented, but it is up to you,

		...
		{0,  1,  2,  3}, /* PCI4p */
		...
		{1,  2,  3, -1}, /* PCI3p123 */
		...
		{2,  3, -1, -1}, /* PCI2p23 */
		{0, -1, -1, -1}, /* PCI1p0 */
		...

> +	};
> +
> +	return logical_to_physical_port_idx[subsys_dev][port];
> +}

...

> +	priv->membase = pcim_iomap(pdev, 0, 0);

Is any of those card can have an IO bar (instead of MEM)?

> +	if (!priv->membase)
> +		return -ENOMEM;

...

> +	if (num_vectors == 4)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
> +		       priv->membase + UART_PCI_CTRL_REG);

If you set this unconditionally when num_vectors < 4, would it still work?

> +	else
> +		uart.port.irq = pci_irq_vector(pdev, 0);

I would move this to the below...

...

> +		if (num_vectors == 4)
> +			uart.port.irq = pci_irq_vector(priv->pdev, port_idx);

...here as IRQ assignment to be seen at one place.

-- 
With Best Regards,
Andy Shevchenko


