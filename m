Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2962DAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiKQM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbiKQM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:27:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B071F3B;
        Thu, 17 Nov 2022 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688019; x=1700224019;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rljqn3gubiECl1NwgXnIOeTLHl7BI8XIr1vkPLeML7U=;
  b=X+G8OTQYx146awHLegoU7g9ZLG/+BoG01rmmnMeCtovGyOZaMgCWYFqG
   4pCr8TRqu1Z4LdLR1pULO/c00rnrMCtTMWnf8ZnDzaiw6wgmq/krJad06
   NFRBB/umtf4I3NKnQYo/DEtTR/+13t0ZTemcdleRg3hFmu8nrb9tI/qtB
   RRo6BicS+UkJvRbXgWuQh27Q2aoFEAEteU503Uft287oODU6B58d+PZih
   InhSRwDt/Xxt+s36remgo8NATsv064r+bxQOrIhnQYgDkWR6a1og0763/
   UShRnbjb+rcJQOs91xcEc1ECMvemFqHHQibIYkSU5IXkTZiKMTBnmNY9S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312849308"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312849308"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:26:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728807351"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="728807351"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.252.61.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:26:54 -0800
Date:   Thu, 17 Nov 2022 14:26:51 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v5 tty-next 2/4] 8250: microchip: pci1xxxx: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
In-Reply-To: <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
Message-ID: <3749f3bc-bc33-d812-1518-612f8eef9be@linux.intel.com>
References: <20221117050126.2966714-1-kumaravel.thiagarajan@microchip.com> <20221117050126.2966714-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Kumaravel Thiagarajan wrote:

> Move implementation of setup_port API to serial8250_pci_setup_port
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v5:
> - This is the new patch added in v5 version of this patchset
> - Moved implementation of setup_port from 8250_pci.c to 8250_pcilib.c
> 
> ---
>  drivers/tty/serial/8250/8250_pci.c      | 24 ++--------------
>  drivers/tty/serial/8250/8250_pci1xxxx.c |  6 ++++
>  drivers/tty/serial/8250/8250_pcilib.c   | 38 +++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_pcilib.h   |  9 ++++++
>  drivers/tty/serial/8250/Kconfig         |  5 ++++
>  drivers/tty/serial/8250/Makefile        |  1 +
>  6 files changed, 61 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
>  create mode 100644 drivers/tty/serial/8250/8250_pcilib.h
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 6f66dc2ebacc..69ff367b08de 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -24,6 +24,7 @@
>  #include <asm/io.h>
>  
>  #include "8250.h"
> +#include "8250_pcilib.h"
>  
>  /*
>   * init function returns:
> @@ -89,28 +90,7 @@ static int
>  setup_port(struct serial_private *priv, struct uart_8250_port *port,
>  	   u8 bar, unsigned int offset, int regshift)
>  {
> -	struct pci_dev *dev = priv->dev;
> -
> -	if (bar >= PCI_STD_NUM_BARS)
> -		return -EINVAL;
> -
> -	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> -		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> -			return -ENOMEM;
> -
> -		port->port.iotype = UPIO_MEM;
> -		port->port.iobase = 0;
> -		port->port.mapbase = pci_resource_start(dev, bar) + offset;
> -		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
> -		port->port.regshift = regshift;
> -	} else {
> -		port->port.iotype = UPIO_PORT;
> -		port->port.iobase = pci_resource_start(dev, bar) + offset;
> -		port->port.mapbase = 0;
> -		port->port.membase = NULL;
> -		port->port.regshift = 0;
> -	}
> -	return 0;
> +	return serial8250_pci_setup_port(priv->dev, port, bar, offset, regshift);
>  }
>  
>  /*
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> index 9dd7aca76e58..02b9c6959dcc 100644
> --- a/drivers/tty/serial/8250/8250_pci1xxxx.c
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -22,6 +22,7 @@
>  #include <asm/byteorder.h>
>  
>  #include "8250.h"
> +#include "8250_pcilib.h"
>  
>  #define PCI_DEVICE_ID_EFAR_PCI12000		0xa002
>  #define PCI_DEVICE_ID_EFAR_PCI11010		0xa012
> @@ -143,6 +144,7 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  {
>  	int first_offset;
>  	int offset;
> +	int ret;
>  
>  	switch (priv->dev->subsystem_device) {
>  	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> @@ -191,6 +193,10 @@ static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
>  	port->port.set_termios = serial8250_do_set_termios;
>  	port->port.get_divisor = pci1xxxx_get_divisor;
>  	port->port.set_divisor = pci1xxxx_set_divisor;
> +	ret = serial8250_pci_setup_port(priv->dev, port, 0, offset, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	writeb(UART_BLOCK_SET_ACTIVE, port->port.membase + UART_ACTV_REG);
>  	writeb(UART_WAKE_SRCS, port->port.membase + UART_WAKE_REG);
>  	writeb(UART_WAKE_N_PIN, port->port.membase + UART_WAKE_MASK_REG);
> diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
> new file mode 100644
> index 000000000000..e5a4a9b22c81
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pcilib.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 8250 PCI library.
> + *
> + * Copyright (C) 2001 Russell King, All Rights Reserved.
> + */
> +#include <linux/errno.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +#include "8250.h"
> +
> +int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
> +		   u8 bar, unsigned int offset, int regshift)
> +{
> +	if (bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
> +	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> +		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> +			return -ENOMEM;
> +
> +		port->port.iotype = UPIO_MEM;
> +		port->port.iobase = 0;
> +		port->port.mapbase = pci_resource_start(dev, bar) + offset;
> +		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
> +		port->port.regshift = regshift;
> +	} else {
> +		port->port.iotype = UPIO_PORT;
> +		port->port.iobase = pci_resource_start(dev, bar) + offset;
> +		port->port.mapbase = 0;
> +		port->port.membase = NULL;
> +		port->port.regshift = 0;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(serial8250_pci_setup_port);
> diff --git a/drivers/tty/serial/8250/8250_pcilib.h b/drivers/tty/serial/8250/8250_pcilib.h
> new file mode 100644
> index 000000000000..41ef01d5c3c5
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pcilib.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * 8250 PCI library header file.
> + *
> + * Copyright (C) 2001 Russell King, All Rights Reserved.
> + */
> +
> +int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port, u8 bar,
> +		   unsigned int offset, int regshift);
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 1c41722d8ac5..f67542470eae 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -132,6 +132,7 @@ config SERIAL_8250_DMA
>  config SERIAL_8250_PCI
>  	tristate "8250/16550 PCI device support"
>  	depends on SERIAL_8250 && PCI
> +	select SERIAL_8250_PCILIB
>  	default SERIAL_8250
>  	help
>  	  This builds standard PCI serial support. You may be able to
> @@ -294,6 +295,7 @@ config SERIAL_8250_HUB6
>  config SERIAL_8250_PCI1XXXX
>  	tristate "Microchip 8250 based serial port"
>  	depends on SERIAL_8250_PCI
> +	select SERIAL_8250_PCILIB
>  	default SERIAL_8250
>  	help
>  	 Select this option if you have a setup with Microchip PCIe
> @@ -510,6 +512,9 @@ config SERIAL_8250_MID
>  	  Intel Medfield SOC and various other Intel platforms that is not
>  	  covered by the more generic SERIAL_8250_PCI option.
>  
> +config SERIAL_8250_PCILIB
> +	bool
> +
>  config SERIAL_8250_PERICOM
>  	tristate "Support for Pericom and Acces I/O serial ports"
>  	default SERIAL_8250
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index fbc7d47c25bd..98202fdf39f8 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
>  8250_base-$(CONFIG_SERIAL_8250_DMA)	+= 8250_dma.o
>  8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
>  8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
> +8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
>  obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
>  obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
>  obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o

You should swap patches 1/4 and 2/4 order so that the pcilib is added 
first so that you can use it directly when adding your driver.

-- 
 i.

