Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4784262D4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiKQIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiKQIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:25:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573383F06A;
        Thu, 17 Nov 2022 00:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668673522; x=1700209522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NQ50HG/r1HiZzg5yGcXYjfciQ4IDQuB+FY0bVqYYGEc=;
  b=dzsyHRa1iDNAOnz1wnY6jV8bem65x89N75f235+sx4JbNUJrKHKCNkng
   6mma4JoMR8EGHMf2HnYwpSp+f83B7gpI0QxzyYtXX9kV7khrNb27QCDwr
   /I2w11H7yTepZqK9Z3CrILmb0BayWQGwg6RV70lEh19CNnAJooBqfMl9c
   j201QYq2XE9A5qeX8ACubCr+tCdYjajiNIVYAxEDRGbIRmHmfrUZKj0TA
   USf1369QP30y70/o1iR3Vg8XdvdgckMkBie1lAd4+Vi+hRUK3OUX+VpN2
   7bUkebeGc0dea2cBXqMLqj72qNLXvPffh6I047XWrrlz6wMcaaEFidqlm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312806070"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312806070"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590536828"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590536828"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 00:25:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovaCv-00DUjG-2Q;
        Thu, 17 Nov 2022 10:25:13 +0200
Date:   Thu, 17 Nov 2022 10:25:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v5 tty-next 1/4] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y3Xv6XOwddNq6Gmr@smile.fi.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com>
 <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117050126.2966714-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:31:23AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

Getting better!

...

> +struct pci1xxxx_8250 {
> +	struct pci_dev *dev;

Call it pdev to distinguish with regular struct device.

> +	unsigned int nr;
> +	void __iomem *membase;
> +	int line[];
> +};

...

> +static int pci1xxxx_get_num_ports(struct pci_dev *dev)
> +{
> +	switch (dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:

> +	default:

You can even start with a default, so it will be more visible.
But the way it's now is also okay.

> +		return 1;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
> +		return 2;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
> +		return 3;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> +		return 4;
> +	}
> +}

...

> +	quot = (NSEC_PER_SEC / (baud * UART_BIT_SAMPLE_CNT));

Too many parentheses.

> +	*frac = (((NSEC_PER_SEC - (quot * baud * UART_BIT_SAMPLE_CNT)) /

Ditto.

> +		  UART_BIT_SAMPLE_CNT) * 255) / baud;

...

> +	switch (priv->dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
> +		first_offset = 256;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
> +		first_offset = 512;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
> +		first_offset = 768;
> +		break;

> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +		first_offset = 256;
> +		break;

Can't it be moved to the above list?

> +	default:
> +		first_offset = 0;
> +		break;
> +	}

...

> +	switch (priv->dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
> +		if (idx > 0)
> +			idx++;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
> +		if (idx > 0)
> +			idx += 2;
> +		break;

> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +		if (idx > 0)
> +			idx++;
> +		break;

Can it be moved to the above list?

> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +		if (idx > 1)
> +			idx++;
> +		break;

default?

> +	}

...

> +	switch (priv->dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
> +	default:
> +		irq_idx = 0;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> +		irq_idx = 1;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +		irq_idx = 2;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
> +		irq_idx = 3;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:

> +		irq_idx = idx;

This line is duplicated. I told you how to avoid duplication.
Use -1 outside of the switch-case and check that after.

> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
> +		if (idx > 0)
> +			idx++;
> +		irq_idx = idx;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
> +		if (idx > 0)
> +			idx += 2;
> +		irq_idx = idx;
> +		break;

> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
> +		irq_idx = idx + 1;
> +		break;


> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +		if (idx > 0)
> +			idx += 1;
> +		irq_idx = idx + 1;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
> +		irq_idx = idx + 2;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
> +		irq_idx = idx;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +		if (idx > 1)
> +			idx++;
> +		irq_idx = idx;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
> +		if (idx > 0)
> +			idx++;
> +		irq_idx = idx;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
> +		irq_idx = idx + 1;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> +		irq_idx = idx;
> +		break;

Try to make this entire switch-case more compact. It's possible.

> +	}

...

> +	dev = &pdev->dev;

You can do it in the definition block above, since we know that dev is always
valid at this point.

...

> +	priv->membase = pcim_iomap(pdev, 0, 0);

Never fails?

...

> +	for (i = 0; i < nr_ports; i++) {
> +		if (num_vectors == 4)
> +			pci1xxxx_irq_assign(priv, &uart, i);
> +
> +		rc = pci1xxxx_setup(priv, &uart, i);
> +		if (rc) {
> +			dev_warn(dev, "Failed to setup port %u\n", i);
> +			break;

If it's not a fatal error, why break? Don't you need to continue for the rest?
Otherwise use

	return dev_err_probe(...);

pattern.

> +		}
> +		priv->line[i] = serial8250_register_8250_port(&uart);
> +		if (priv->line[i] < 0) {
> +			dev_err(dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, priv->line[i]);
> +			break;

Ditto.

> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


