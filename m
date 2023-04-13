Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858466E11D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDMQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDMQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:08:43 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E38A5F;
        Thu, 13 Apr 2023 09:08:21 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 83397124;
        Thu, 13 Apr 2023 18:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681402098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LL1fKoLqMxzZZEZIkCBVoKDCW9MJL6lTQYu6NkF9DU=;
        b=zqTgPA3632rYCaZ1xi1OlLMRDI/Tsp7qSQ+3HvuyWlZBcZx+Fe9j8LUZcUBOqp2W0ZGDn+
        vlhXg7Tvrg5ceol0U42dILudQsYrIhLrt7B10785E8t25AGMiNMIHaFiVjc+FbbG3SHQgh
        3drXPiL5phGv4eteNRJsslvFcwHJxsR1JqMETlKYQa7bvfYgrouALv+Q9nWdWT9UqtQOQB
        2qMaw6pddIrkwCZ6AzLBfsIujK8lMguwvwFIMacyjWjV1sKSzc5z7Xrm3Jtp9KEwJtNgc1
        Wbtr/GMKHbgiFFBWFGUMfkRXmxvu7xPpZsuZKOlxLkD4NYnqG1jc8T5HF6Q6Qw==
MIME-Version: 1.0
Date:   Thu, 13 Apr 2023 18:08:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v9 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
In-Reply-To: <20230413105318.6070-2-vaibhaavram.tl@microchip.com>
References: <20230413105318.6070-1-vaibhaavram.tl@microchip.com>
 <20230413105318.6070-2-vaibhaavram.tl@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <51847629489852d493af928580c5a2de@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-13 12:53, schrieb Vaibhaav Ram T.L:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP
> and EEPROM to enable customization of the part in the field.
> This patch adds support to read and write into PCI1XXXX OTP
> via NVMEM sysfs

Thanks for working on that. Now this driver is less of an oddball
one.

> Signed-off-by: Kumaravel Thiagarajan 
> <kumaravel.thiagarajan@microchip.com>
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Co-developed-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> ---
>  MAINTAINERS                                   |   2 +
>  drivers/misc/mchp_pci1xxxx/Kconfig            |   1 +
>  drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
>  .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 301 ++++++++++++++++++
>  4 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a33261b4592f..58e4b9d6ed61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13721,12 +13721,14 @@
> F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
>  F:	drivers/mtd/nand/raw/atmel/*
> 
>  MICROCHIP PCI1XXXX GP DRIVER
> +M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
>  M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
>  L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
>  F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
>  F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> 
>  MICROCHIP OTPC DRIVER
>  M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig
> b/drivers/misc/mchp_pci1xxxx/Kconfig
> index 4abb47de7219..64e457581fb4 100644
> --- a/drivers/misc/mchp_pci1xxxx/Kconfig
> +++ b/drivers/misc/mchp_pci1xxxx/Kconfig
> @@ -2,6 +2,7 @@ config GP_PCI1XXXX
>         tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM 
> manager"
>         depends on PCI
>         depends on GPIOLIB
> +       depends on NVMEM_SYSFS
>         select GPIOLIB_IRQCHIP
>         select AUXILIARY_BUS
>         help
> diff --git a/drivers/misc/mchp_pci1xxxx/Makefile
> b/drivers/misc/mchp_pci1xxxx/Makefile
> index fc4615cfe28b..ae31251dab37 100644
> --- a/drivers/misc/mchp_pci1xxxx/Makefile
> +++ b/drivers/misc/mchp_pci1xxxx/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o
> +obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o
> mchp_pci1xxxx_otpe2p.o
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> new file mode 100644
> index 000000000000..23f44ad6773e
> --- /dev/null
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2022-2023 Microchip Technology Inc.
> +// PCI1xxxx OTP/EEPROM driver
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bio.h>
> +#include <linux/device.h>
> +#include <linux/iopoll.h>
> +#include <linux/kthread.h>

Is this needed? I don't see any threads. Also bio.h. Please double check
your includes.

> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +
> +#include "mchp_pci1xxxx_gp.h"
> +
> +#define AUX_DRIVER_NAME			"PCI1xxxxOTPE2P"
> +#define OTP_NAME			"pci1xxxx_otp"
> +
> +#define PERI_PF3_SYSTEM_REG_ADDR_BASE	0x2000
> +#define PERI_PF3_SYSTEM_REG_LENGTH	0x4000
> +
> +#define OTP_SIZE_BYTES			8192
> +
> +#define CONFIG_REG_ADDR_BASE		0
> +#define OTP_REG_ADDR_BASE		0x1000
> +
> +#define MMAP_OTP_OFFSET(x)		(OTP_REG_ADDR_BASE + x)
> +#define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + x)
> +
> +#define STATUS_READ_DELAY_US		1
> +#define STATUS_READ_TIMEOUT_US		20000
> +
> +#define OTP_ADDR_HIGH_OFFSET		0x04
> +#define OTP_ADDR_LOW_OFFSET		0x08
> +#define OTP_PRGM_DATA_OFFSET		0x10
> +#define OTP_PRGM_MODE_OFFSET		0x14
> +#define OTP_RD_DATA_OFFSET		0x18
> +#define OTP_FUNC_CMD_OFFSET		0x20
> +#define OTP_CMD_GO_OFFSET		0x28
> +#define OTP_PASS_FAIL_OFFSET		0x2C
> +#define OTP_STATUS_OFFSET		0x30
> +
> +#define OTP_FUNC_RD_BIT			BIT(0)
> +#define OTP_FUNC_PGM_BIT		BIT(1)
> +#define OTP_CMD_GO_BIT			BIT(0)
> +#define OTP_STATUS_BUSY_BIT		BIT(0)
> +#define OTP_PGM_MODE_BYTE_BIT		BIT(0)
> +#define OTP_FAIL_BIT			BIT(0)
> +
> +#define OTP_PWR_DN_BIT			BIT(0)
> +#define OTP_PWR_DN_OFFSET		0x00
> +
> +#define CFG_SYS_LOCK_OFFSET		0xA0
> +#define CFG_SYS_LOCK_PF3		BIT(5)
> +
> +#define BYTE_LOW			(GENMASK(7, 0))
> +#define BYTE_HIGH			(GENMASK(12, 8))
> +
> +struct pci1xxxx_otp_eeprom_device {
> +	struct auxiliary_device *pdev;
> +	void __iomem *reg_base;
> +	struct nvmem_config nvmem_config_otp;
> +	struct nvmem_device *nvmem_otp;
> +};
> +
> +static int set_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *sys_lock = priv->reg_base +
> +				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
> +	u8 data;
> +
> +	writel(CFG_SYS_LOCK_PF3, sys_lock);
> +	data = readl(sys_lock);
> +	if (data != CFG_SYS_LOCK_PF3)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static void release_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
> +{
> +	void __iomem *sys_lock = priv->reg_base +
> +				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
> +	writel(0, sys_lock);
> +}
> +
> +static void otp_device_set_address(struct pci1xxxx_otp_eeprom_device 
> *priv,
> +				   u16 address)
> +{
> +	u16 lo, hi;
> +
> +	lo = address & BYTE_LOW;
> +	hi = (address & BYTE_HIGH) >> 8;
> +	writew(lo, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_LOW_OFFSET));
> +	writew(hi, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_HIGH_OFFSET));
> +}
> +
> +static int pci1xxxx_otp_read(void *priv_t, unsigned int off,
> +			     void *buf_t, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
> +	char *buf = buf_t;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +	u8 data;
> +
> +	if (priv != NULL)
> +		rb = priv->reg_base;
> +	else
> +		return -ENODEV;

Unneeded check, priv cannot be NULL, right?

> +
> +	ret = set_sys_lock(priv);
> +	if (ret)
> +		return ret;
> +
> +	for (byte = 0; byte < count; byte++) {
> +		otp_device_set_address(priv, (u16)(off + byte));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		writel(data | OTP_FUNC_RD_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +		writel(data | OTP_CMD_GO_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & OTP_STATUS_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (ret < 0 || data & OTP_FAIL_BIT)
> +			break;

No error handling?

> +
> +		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
> +	}
> +	release_sys_lock(priv);
> +
> +	return byte;
> +}
> +
> +static int pci1xxxx_otp_write(void *priv_t, unsigned int off,
> +			      void *value_t, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
> +	char *value = value_t;
> +	void __iomem *rb;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +	u8 data;
> +
> +	if (priv != NULL)
> +		rb = priv->reg_base;
> +	else
> +		return -ENODEV;

Same as above.

> +
> +	ret = set_sys_lock(priv);
> +	if (ret)
> +		return ret;
> +
> +	for (byte = 0; byte < count; byte++) {
> +		otp_device_set_address(priv, (u16)(off + byte));
> +
> +		/*
> +		 * Set OTP_PGM_MODE_BYTE command bit in OTP_PRGM_MODE register
> +		 * to enable Byte programming
> +		 */
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
> +		writel(data | OTP_PGM_MODE_BYTE_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
> +		writel(*(value + byte), rb + MMAP_OTP_OFFSET(OTP_PRGM_DATA_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		writel(data | OTP_FUNC_PGM_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +		writel(data | OTP_CMD_GO_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & OTP_STATUS_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (ret < 0 || data & OTP_FAIL_BIT)
> +			break;

also here.

> +	}
> +	release_sys_lock(priv);
> +
> +	return byte;
> +}
> +
> +static int pci1xxxx_otp_eeprom_probe(struct auxiliary_device *aux_dev,
> +				     const struct auxiliary_device_id *id)
> +{
> +	struct auxiliary_device_wrapper *aux_dev_wrapper;
> +	struct pci1xxxx_otp_eeprom_device *priv;
> +	struct gp_aux_data_type *pdata;
> +	int ret;
> +	u8 data;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct 
> auxiliary_device_wrapper,
> +				       aux_dev);
> +	pdata = &aux_dev_wrapper->gp_aux_data;
> +	if (!pdata)
> +		return dev_err_probe(&aux_dev->dev, -EINVAL,
> +				     "Invalid data in aux_dev_wrapper->gp_aux_data\n");
> +
> +	priv = devm_kzalloc(&aux_dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(&aux_dev->dev, -ENOMEM,
> +				     "Memory Allocation Failed\n");

Just return -ENOMEM. No need for that message.

-michael
