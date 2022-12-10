Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E86490CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 22:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLJVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 16:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:15:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9A13E87;
        Sat, 10 Dec 2022 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670706899; x=1702242899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTHzlu07EReOStPNYo6Zt9UjnYvA8xXuJZx2IneZddI=;
  b=QlH5Pndxd6Ty6nrNknscUt5ntVt2vivSCylPo5es0/EgCSFSSsuqVKfV
   DHAQMJLS3NxxUTy6Wlh1k17na2/XKfLOtjL/nm3y/6/XKEmoxpOvExSNH
   9RRZyQbhf63756nfFI8610EUts5QZI8gcKGMGvuFAnjOa4Khr7F9dR7wQ
   2bjLPBz2qF/PUPErf69KVEttkj0zdgA2jXOgyHFfYWWPJIKQfSrS1Bz00
   PZskY/3FzHOJk6CQRfmoLivtdh4LH2PQBFCogNql20CLlaKH2tZ6QsqYn
   0grX9f9xt0m2XH1+dQmeNYrD9TcILzMDhylP/CWMIJzPJVfpexSizihYd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="301072123"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="301072123"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 13:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="736543155"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="736543155"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2022 13:14:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p47BL-007gRz-15;
        Sat, 10 Dec 2022 23:14:51 +0200
Date:   Sat, 10 Dec 2022 23:14:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, cang1@live.co.uk,
        colin.i.king@gmail.com, phil.edworthy@renesas.com,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5T2ymgsCQhggtvz@smile.fi.intel.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 07:17:28AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

...

> +static int pci1xxxx_get_max_port(int subsys_dev)
> +{
> +	static int max_port[] = {
> +		1,/* PCI12000 PCI11010 PCI11101 PCI11400 */

I would put the commas in between in the comment, or is it the name of a single
product?

> +		4,/* PCI4p */
> +		3,/* PCI3p012 */
> +		4,/* PCI3p013 */
> +		4,/* PCI3p023 */
> +		4,/* PCI3p123 */
> +		2,/* PCI2p01 */
> +		3,/* PCI2p02 */
> +		4,/* PCI2p03 */
> +		3,/* PCI2p12 */
> +		4,/* PCI2p13 */
> +		4,/* PCI2p23 */
> +		1,/* PCI1p0 */
> +		2,/* PCI1p1 */
> +		3,/* PCI1p2 */
> +		4,/* PCI1p3 */
> +	};

If you move this outside of the function you may use static_assert(), see below
why.

> +	if (subsys_dev > PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3)
> +		if (subsys_dev != PCI_SUBDEVICE_ID_EFAR_PCI11414)
> +			return max_port[0];
> +		else
> +			return 4;
> +	else
> +		return max_port[subsys_dev];

Too many redundant 'else'.

	if (subsys_dev <= PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3)
		return max_port[subsys_dev];

(however better to compare with your size of the array)

	if (subsys_dev <= ARRAY_SIZE(max_port))
		return max_port[subsys_dev];

(in this case you can make sure it is the same as the above using
 static_assert(), so it won't compile otherwise)

	if (subsys_dev != PCI_SUBDEVICE_ID_EFAR_PCI11414)
		return max_port[0];

	return 4;

> +}

...

> +static int pci1xxxx_logical_to_physical_port_translate(int subsys_dev, int port)
> +{
> +	static int logical_to_physical_port_idx[][MAX_PORTS] = {
> +		{0,  1,  2,  3},/* PCI12000 PCI11010 PCI11101 PCI11400 PCI11414 */
> +		{0,  1,  2,  3},/* PCI4p */
> +		{0,  1,  2, -1},/* PCI3p012 */
> +		{0,  1,  3, -1},/* PCI3p013 */
> +		{0,  2,  3, -1},/* PCI3p023 */
> +		{1,  2,  3, -1},/* PCI3p123 */
> +		{0,  1, -1, -1},/* PCI2p01 */
> +		{0,  2, -1, -1},/* PCI2p02 */
> +		{0,  3, -1, -1},/* PCI2p03 */
> +		{1,  2, -1, -1},/* PCI2p12 */
> +		{1,  3, -1, -1},/* PCI2p13 */
> +		{2,  3, -1, -1},/* PCI2p23 */
> +		{0, -1, -1, -1},/* PCI1p0 */
> +		{1, -1, -1, -1},/* PCI1p1 */
> +		{2, -1, -1, -1},/* PCI1p2 */
> +		{3, -1, -1, -1},/* PCI1p3 */
> +	};
> +
> +	if (subsys_dev > PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3)
> +		return logical_to_physical_port_idx[0][port];
> +	else
> +		return logical_to_physical_port_idx[subsys_dev][port];

Similar comments as per above function.

> +}

...

> +	priv->membase = pcim_iomap(pdev, 0, 0);

You issued a new version of the series without settling on this.
As you said there will be no hardware that uses IO ports, why do
you need pci_iomap()? I guess what you may use pci_ioremap_bar().

> +	if (!priv->membase)
> +		return -ENOMEM;

...

> +	priv->pdev = pdev;

> +	subsys_dev = priv->pdev->subsystem_device;

Why use priv?

> +	priv->nr = nr_ports;
> +	pci_set_master(pdev);
> +	max_vec_reqd = pci1xxxx_get_max_port(subsys_dev);

The above needs a bit of reshuffling and perhaps a blank line or lines.
Make it ordered and grouped more logically.

...

> +	num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd,
> +					    PCI_IRQ_ALL_TYPES);

I would leave this on a single line (you have such a long lines already in your
code).

> +	if (num_vectors < 0)
> +		return num_vectors;

...

> +static const struct pci_device_id pci1xxxx_pci_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11400) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11414) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI12000) },

Can be simplified a bit by PCI_VDEVICE().

> +	{}
> +};


-- 
With Best Regards,
Andy Shevchenko


