Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A9625FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:39:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2B5BD6D;
        Fri, 11 Nov 2022 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668184760; x=1699720760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ppfZzZrap1y0VfS4gxKbKyWl0vZ/i/TC1KLN7Uc2TU=;
  b=Luj5k1XGo4qIMmtWsp4kOgoWwEWmbLkVkzeeffO1gIqefg+XLljOxT5v
   P5bI7/OUQasZJ3fPmi2UU7sMblJDEVJck4STYk+yTU3SRBtsY5Zn5Qidc
   e33UXTJd7fjBdkQ20DKku4ap4yYgXcH+NYngcMo4zFfStdM6Z6FfdGMuP
   LlKn1etdKo3diwuDLdNNRTIDWDxmSxiZaewwgYbl86OYAHV+gIy9f81bn
   GfJ1nc24JX093RLCZ2P242rS17D/vX0o39zfhA6lMxGuFoawj2q0qKKUy
   RnwCISlKOa7ZnBQaegu3981MaNXjj6GlRT4S2jWnIZYuTNlCg/u1FqClE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="292032686"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="292032686"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 08:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670793072"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="670793072"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2022 08:39:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otX3g-00AncE-0C;
        Fri, 11 Nov 2022 18:39:12 +0200
Date:   Fri, 11 Nov 2022 18:39:11 +0200
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
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v4 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y256r//s3DCBI07+@smile.fi.intel.com>
References: <20221111161130.2043882-1-kumaravel.thiagarajan@microchip.com>
 <20221111161130.2043882-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111161130.2043882-2-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 09:41:28PM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

Are you submitter only and not a co-developer?

...

> +MICROCHIP PCIe UART DRIVER
> +M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> +M:	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	drivers/tty/serial/8250/8250_pci1xxxx.c

Have you checked if 8250_pcilib.c needs to be added to the MAINTAINERS?
That's why it's better to split that change from this patch.

...

> +#include <asm/byteorder.h>

asm/* are usually going after linux/*...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/units.h>
> +#include <linux/tty.h>

...like here (as a separate group).

> +#include "8250.h"
> +#include "8250_pcilib.h"

...

> +#define PCI_DEVICE_ID_EFAR_PCI12000 0xa002
> +#define PCI_DEVICE_ID_EFAR_PCI11010 0xa012
> +#define PCI_DEVICE_ID_EFAR_PCI11101 0xa022
> +#define PCI_DEVICE_ID_EFAR_PCI11400 0xa032
> +#define PCI_DEVICE_ID_EFAR_PCI11414 0xa042
> +
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p 0x0001
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012 0x0002
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013 0x0003
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023 0x0004
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123 0x0005
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01 0x0006
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02 0x0007
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03 0x0008
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12 0x0009
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13 0x000a
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23 0x000b
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0 0x000c
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1 0x000d
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2 0x000e
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3 0x000f
> +
> +#define PCI_SUBDEVICE_ID_EFAR_PCI12000 0xa002
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11010 0xa012
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11101 0xa022
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11400 0xa032
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11414 0xa042

With TAB delimiter(s) the values would be easier to read / parse.
Ditto for the rest.

...

> +#define UART_WAKE_SRCS (UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)

With above in mind this can be written as

#define UART_WAKE_SRCS	\
	UART_WAKE_SRCS (UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)

...

> +	switch (dev->subsystem_device) {
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

> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
> +	default:
> +		return 1;

You can put this block the first one, so they will be ordered by the returned
value.

> +	}

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
> +		first_offset = 256;
> +		if (idx > 0)
> +			idx++;
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +		if (idx > 1)
> +			idx++;
> +		break;
> +	default:
> +		first_offset = 0;
> +		break;
> +	}

I would split this to two switch-cases, one for idx, one for first_offset.

...

> +	switch (priv->dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:

> +		uart->port.irq = pci_irq_vector(priv->dev, 1);

This can be deduplicated by assigning irq_idx in the switch and maybe using idx
when it's not assigned (like -1).

> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +		uart->port.irq = pci_irq_vector(priv->dev, 2);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
> +		uart->port.irq = pci_irq_vector(priv->dev, 3);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
> +		if (idx > 0)
> +			idx++;
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
> +		if (idx > 0)
> +			idx += 2;
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +		if (idx > 0)
> +			idx += 1;
> +		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx + 2);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +		if (idx > 1)
> +			idx++;
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
> +		if (idx > 0)
> +			idx++;
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx + 1);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> +		uart->port.irq = pci_irq_vector(priv->dev, idx);
> +		break;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
> +	default:
> +		uart->port.irq = pci_irq_vector(priv->dev, 0);
> +		break;
> +	}

...

> +static int pci1xxxx_serial_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *ent)

You can replace ent by id as it's more usual for this parameter.

> +{
> +	unsigned int nr_ports, i, j;
> +	struct pci1xxxx_8250 *priv;
> +	struct uart_8250_port uart;

> +	int num_vectors = 0;

Why do you need this assignment?

> +	int rc;
> +
> +	rc = pcim_enable_device(dev);
> +	if (rc)
> +		return rc;
> +
> +	nr_ports = pci1xxxx_get_num_ports(dev);
> +
> +	priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports),
> +			    GFP_KERNEL);

You can place it on one line, but even better all these will look when you use
pdev for PCI device (parameter to this function) and define a temporary
variable

	struct device *dev = &pdev->dev;

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->membase = pcim_iomap(dev, 0, 0);
> +	priv->dev = dev;
> +	priv->nr = nr_ports;
> +	pci_set_master(dev);
> +
> +	num_vectors = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0)
> +		return num_vectors;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
> +	uart.port.uartclk = UART_CLOCK_DEFAULT;
> +	uart.port.dev = &dev->dev;
> +
> +	if (num_vectors == 4)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
> +		       priv->membase + UART_PCI_CTRL_REG);
> +	else
> +		uart.port.irq = pci_irq_vector(dev, 0);
> +
> +	for (i = 0; i < nr_ports; i++) {
> +		if (num_vectors == 4)
> +			pci1xxxx_irq_assign(priv, &uart, i);

> +		priv->line[i] = -ENOSPC;

Why do you need this?

> +		rc = pci1xxxx_setup(priv, &uart, i);
> +		if (rc) {
> +			dev_err(&dev->dev, "Failed to setup port %u\n", i);
> +			break;

It's not an error? Perhaps dev_warn()? Ditto for the below.

> +		}

> +		priv->line[i] = serial8250_register_8250_port(&uart);

> +

This blank line is in a wrong place, should be after conditional.

> +		if (priv->line[i] < 0) {

> +			for (j = i + 1; j < nr_ports; j++)
> +				priv->line[j] = -ENOSPC;

Instead, you may once assign this to all beforehand:

	memset32(prov->line, -ENOSPC, nr_ports);

> +			dev_err(&dev->dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, priv->line[i]);
> +			break;
> +		}
> +	}
> +
> +	pci_set_drvdata(dev, priv);
> +
> +	return 0;
> +}

...

> +static struct pci_driver pci1xxxx_pci_driver = {
> +	.name = "pci1xxxx serial",
> +	.probe = pci1xxxx_serial_probe,
> +	.remove = pci1xxxx_serial_remove,
> +	.id_table = pci1xxxx_pci_tbl,
> +};

> +

Redundant blank line.

> +module_pci_driver(pci1xxxx_pci_driver);

...

> +++ b/drivers/tty/serial/8250/8250_pcilib.c

Yeah, please split this to a separate change, with the changes in 8250_pci.c.

> +#include <linux/pci.h>

Missing errno.h.
Missing ioport.h.
Missing types.h.

+ Blank line.

> +#include "8250.h"

...

> +++ b/drivers/tty/serial/8250/8250_pcilib.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Microchip pci1xxxx 8250 library header file. */

Microchip?! I thought you have fixed this.
Another point why this change should be separated.

-- 
With Best Regards,
Andy Shevchenko


