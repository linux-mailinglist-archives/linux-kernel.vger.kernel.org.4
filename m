Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC666E512
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAQRgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjAQRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:32:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A03A872
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:31:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so132642wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjBci0NKO6ZKB/UXsV/JkzjT1U6s2MxM+6neZRuPmEI=;
        b=A0K9sTPYOa5Ph++RFxGuG0QC3zBv3JfHfHOCOeaMjWO2KPUrfCEfFI0ZAaMlwuADU1
         JfRFkMWNcbsPiRixcvixaDYM/bhNGBEmOAS0Ot7pC3eQnX1MiRywErUCWsHnc7XKuAbF
         Bi5sPlHuLnk806mYRen3cLLTOvPUXAr04cxYVU7PAFJbF67DLE7b5ehWyU0JYJO1Rj9O
         Vnkwb/CTUiwLxZ+wjGJSSmSfibHLgPHxTQwILYuvgotcUgGFPzu0taluYWKOCGXz89Fu
         C7AbLMeR4rCiCyEkN9YKoQ9KFoVWk2OTQQkHbhC8J86mEkH0k+L+no6zVEkVm2Tl6Q94
         tZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjBci0NKO6ZKB/UXsV/JkzjT1U6s2MxM+6neZRuPmEI=;
        b=3JyILvYITYsUTwxP1eP+iKEyDM8y+TKLD8PuyFf3LS6nsLYq5vupRaa1QvFyaHh+pa
         O3nEVkWip2Xle/YgpTkE5z0cgDuHy6eWrQP9c2Lst2xGEqdLHTiZJB2SZfEyxb+ceoEc
         Cg9/zuLWAYkpT80jNzN8nYWNnH4Y93ANzndauakk/mrnn9VG3nGFP41sywcT8faGslUW
         fiCeumDvXbW7fug4wDZ+sFYqP7CdJjW1xtTBPREmNfoHz3Zwx++53OotsNNpA8xvwPsc
         FQo4NR+e0vNhruz7A3S11nWdGMC2rXTmyRuYQaX760jdtA+I6VjoHGx9V1WPkDjwaRdc
         2SmA==
X-Gm-Message-State: AFqh2kpDp8lgWr+on360TKTgfU6IdgwHVtGlV9pDBrNxG5LwREsIONdp
        ZdHbRaaYWzH1CUWNNoXrO9Tkpg==
X-Google-Smtp-Source: AMrXdXtcSOHRDrvSQ58Dprwf1dWakeRE8jAKyCxG3X+wJeaPWvsCw65rqi7N5TAA2i+I7G1TcvprIQ==
X-Received: by 2002:a05:600c:3d06:b0:3da:f945:2354 with SMTP id bh6-20020a05600c3d0600b003daf9452354mr3791985wmb.41.1673976649434;
        Tue, 17 Jan 2023 09:30:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hg11-20020a05600c538b00b003cf6a55d8e8sm36341704wmb.7.2023.01.17.09.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:30:48 -0800 (PST)
Message-ID: <4397b39c-084b-954b-956a-5168a3c8958c@linaro.org>
Date:   Tue, 17 Jan 2023 18:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] mailbox: marvell-mhu: add Marvell MHU
Content-Language: en-US
To:     Wojciech Zmuda <wzmuda@marvell.com>, linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org, sgoutham@marvell.com,
        devicetree@vger.kernel.org,
        Wojciech Bartczak <wbartczak@marvell.com>,
        Sujeet Baranwal <sbaranwal@marvell.com>
References: <20230117171635.16739-1-wzmuda@marvell.com>
 <20230117171635.16739-2-wzmuda@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117171635.16739-2-wzmuda@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 18:16, Wojciech Zmuda wrote:
> From: Wojciech Bartczak <wbartczak@marvell.com>
> 
> Add support for Message Handling Units on Marvell OcteonTx and OcteonTx2
> platforms. The module uses mailbox controller interface to provide
> communication between SCP and AP using SCMI protocol over a single
> shared memory communication channel.
> 
> Signed-off-by: Sujeet Baranwal <sbaranwal@marvell.com>
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
> ---
>  MAINTAINERS                   |   8 +
>  drivers/mailbox/Kconfig       |  10 ++
>  drivers/mailbox/Makefile      |   2 +
>  drivers/mailbox/marvell_mhu.c | 295 ++++++++++++++++++++++++++++++++++
>  4 files changed, 315 insertions(+)
>  create mode 100644 drivers/mailbox/marvell_mhu.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7af5cd38d7c1..650a198cce24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11322,6 +11322,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  F:	drivers/mmc/host/sdhci-xenon*
>  
> +MARVELL MHU MAILBOX DRIVER
> +M:	Sujeet Baranwal <sbaranwal@marvell.com>
> +M:	Sunil Goutham <sgoutham@marvell.com>
> +M:	Wojciech Bartczak <wbartczak@marvell.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mailbox/mvl_mhu.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c9fc06c7e685..af916007db2c 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -160,6 +160,16 @@ config MAILBOX_TEST
>  	  Test client to help with testing new Controller driver
>  	  implementations.
>  
> +config MARVELL_MHU
> +	tristate "Marvell Message Handling Unit"
> +	depends on OF
> +	help
> +	  This driver adds support for Marvell MHU controller.
> +	  The MHU mailbox is used by SCMI for OcteonTX and OcteonTX2
> +	  to control various aspects of platform operation like cpufreq
> +	  or sensors. The controller supports single channel to SCP.
> +	  Say Y here to build this module. If unsure say N.
> +
>  config POLARFIRE_SOC_MAILBOX
>  	tristate "PolarFire SoC (MPFS) Mailbox"
>  	depends on HAS_IOMEM
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c2089f04887e..50468444123b 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -41,6 +41,8 @@ obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
>  
>  obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
>  
> +obj-$(CONFIG_MARVELL_MHU)	+= marvell_mhu.o
> +
>  obj-$(CONFIG_POLARFIRE_SOC_MAILBOX)	+= mailbox-mpfs.o
>  
>  obj-$(CONFIG_QCOM_APCS_IPC)	+= qcom-apcs-ipc-mailbox.o
> diff --git a/drivers/mailbox/marvell_mhu.c b/drivers/mailbox/marvell_mhu.c
> new file mode 100644
> index 000000000000..82f9f9eefe55
> --- /dev/null
> +++ b/drivers/mailbox/marvell_mhu.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Marvell Message Handling Unit
> + *
> + * Copyright (c) 2023 Marvell
> + *
> + * https://spdx.org/licenses/GPL-2.0-only.html

Drop

> + */
> +
> +#define DRIVER_NAME	"marvell-mhu"
> +
> +#define pr_fmt(fmt)	DRIVER_NAME ": " fmt
> +
> +

One blank line.

> +#include <linux/pci.h>
> +#include <linux/acpi.h>
> +#include <linux/mailbox_controller.h>
> +
> +#define BAR0		0
> +#define SCP_INDEX	0x0
> +#define DEV_AP0		0x2
> +#define SCP_TO_AP_INTERRUPT	2
> +#define INT_VECS_MIN	0
> +#define INT_VECS_MAX	3
> +
> +#define XCPX_DEVY_XCP_MBOX_LINT_OFFSET	0x000E1C00
> +#define XCP_TO_DEV_XCP_MBOX_LINT(xcp_core, device_id)  \
> +	(XCPX_DEVY_XCP_MBOX_LINT_OFFSET | \
> +	((uint64_t)(xcp_core) << 36) | \
> +	((uint64_t)(device_id) << 4))
> +
> +#define AP0_TO_SCP_MBOX_LINT    XCP_TO_DEV_XCP_MBOX_LINT(SCP_INDEX, DEV_AP0)
> +
> +/*
> + * Doorbell-Register: XCP(0..1)_DEV(0..7)_XCP_MBOX
> + * Communication data from devices to XCP. When written, sets
> + * XCP(0..1)_DEV(0..7)_XCP_MBOX.
> + * PS: it doesn't matter what is written into this register,
> + * Attempting to writing 'anything' would cause an interrupt
> + * to the target!
> + */
> +
> +#define XCPX_DEVY_XCP_MBOX_OFFSET	0x000E1000
> +#define XCP_TO_DEV_XCP_MBOX(xcp_core, device_id) \
> +	(XCPX_DEVY_XCP_MBOX_OFFSET | \
> +	((uint64_t)(xcp_core) << 36) | \
> +	((uint64_t)(device_id) << 4))
> +
> +/* AP0-to-SCP doorbell */
> +#define AP0_TO_SCP_MBOX         XCP_TO_DEV_XCP_MBOX(SCP_INDEX, DEV_AP0)
> +
> +/*  Register offset: Enable interrupt from SCP to AP */
> +#define XCP0_XCP_DEV0_MBOX_RINT_ENA_W1S	0x000D1C40
> +#define XCP0_XCP_DEV1_MBOX_RINT_ENA_W1S	0x000D1C50
> +#define XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S	0x000D1C60
> +#define XCP0_XCP_DEV3_MBOX_RINT_ENA_W1S	0x000D1C70
> +
> +/* Rx interrupt from SCP to Non-secure AP (linux kernel) */
> +#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET 0x000D1C00
> +#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
> +	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
> +	((uint64_t)(xcp_core) << 36) | \
> +	((uint64_t)(device_id) << 4))
> +
> +/* The interrupt status register */
> +#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
> +
> +#define XCPX_XCP_DEVY_MBOX_RINT_OFFSET	0x000D1C00
> +#define XCPX_XCP_DEVY_MBOX_RINT(xcp_core, device_id) \
> +	(XCPX_XCP_DEVY_MBOX_RINT_OFFSET | \
> +	((uint64_t)(xcp_core) << 36) | \
> +	((uint64_t)(device_id) << 4))
> +
> +#define SCP_TO_AP0_MBOX_RINT  XCPX_XCP_DEVY_MBOX_RINT(SCP_INDEX, DEV_AP0)
> +#define SCP_TO_DEV0 XCPX_XCP_DEVY_MBOX_RINT(0, 0)
> +#define SCP_TO_DEV1 XCPX_XCP_DEVY_MBOX_RINT(0, 1)
> +#define SCP_TO_DEV2 XCPX_XCP_DEVY_MBOX_RINT(0, 2)
> +#define SCP_TO_DEV3 XCPX_XCP_DEVY_MBOX_RINT(0, 3)
> +
> +struct mhu {
> +	struct device *dev;
> +
> +	/* SCP link information */
> +	void __iomem *base; /* tx_reg, rx_reg */
> +	struct mbox_chan *chan;
> +};
> +
> +static irqreturn_t mhu_rx_interrupt(int irq, void *p)
> +{
> +	struct mhu *mhu = (struct mhu *)p;
> +	u64 val;
> +
> +	/* Read interrupt status register */
> +	val = readq_relaxed(mhu->base + SCP_TO_AP0_MBOX_RINT);
> +	if (val) {
> +		/* Clear the interrupt : Write on clear */
> +		writeq_relaxed(1ul, mhu->base + SCP_TO_AP0_MBOX_RINT);
> +		/* Poke mbox */
> +		mbox_chan_received_data(mhu->chan, (void *)&val);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int mhu_send_data(struct mbox_chan *chan, void *data)
> +{
> +	const u64 doorbell = 0xff;  /* Arbitrary value, SCP requires a value */
> +	struct mhu *mhu = chan->con_priv;
> +
> +	/* signal SCP */
> +	iowrite64(doorbell, mhu->base + AP0_TO_SCP_MBOX);
> +
> +	return 0;
> +}
> +
> +static bool mhu_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct mhu *mhu = chan->con_priv;
> +	u64 status;
> +
> +	status = ioread64(mhu->base + XCPX_XCP_DEVY_MBOX_RINT(0, 2));
> +
> +	return status != 0;
> +}
> +
> +static int mhu_startup(struct mbox_chan *chan)
> +{
> +	struct mhu *mhu = chan->con_priv;
> +
> +	/* Enable interrupts only if there is client for data */
> +	writeq_relaxed(1ul, mhu->base + XCP0_XCP_DEV2_MBOX_RINT_ENA_W1S);
> +
> +	return 0;
> +}
> +
> +/* Define operations related to mbox */
> +static const struct mbox_chan_ops mhu_chan_ops = {
> +	.startup = mhu_startup,
> +	.send_data = mhu_send_data,
> +	.last_tx_done = mhu_last_tx_done,
> +};
> +
> +static struct mbox_chan mhu_chan = {};
> +
> +static struct mbox_controller mhu_mbox_ctrl = {

Why do you have static/file scope variables? This makes it unusuable
with multiple instances.

> +	.chans = &mhu_chan,
> +	.num_chans = 1,
> +	.txdone_irq = false,
> +	.txdone_poll = true,
> +	.txpoll_period = 100,
> +	.ops = &mhu_chan_ops,
> +};
> +
> +static int mhu_setup_mbox(struct device *dev)
> +{
> +	struct mhu *mhu;
> +	struct mbox_chan *chan;
> +
> +	mhu = dev_get_drvdata(dev);
> +
> +	chan = &mhu_mbox_ctrl.chans[0];
> +	chan->con_priv = mhu;
> +	mhu->chan = chan;
> +	mhu_mbox_ctrl.dev = dev;
> +
> +	return mbox_controller_register(&mhu_mbox_ctrl);
> +}
> +
> +static int mhu_setup_irq(struct pci_dev *pdev)
> +{
> +	struct device *dev;
> +	struct mhu *mhu;
> +	int irq, ret, nvec;
> +
> +	mhu = pci_get_drvdata(pdev);
> +	dev = &pdev->dev;
> +
> +	nvec = pci_alloc_irq_vectors(pdev, INT_VECS_MIN, INT_VECS_MAX, PCI_IRQ_MSIX);
> +	if (nvec < 0)
> +		return nvec;
> +
> +	irq = pci_irq_vector(pdev, SCP_TO_AP_INTERRUPT);
> +	if (irq < 0) {
> +		ret = irq;
> +		goto irq_err;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, mhu_rx_interrupt, 0, "mvl-mhu", mhu);
> +	if (ret)
> +		goto irq_err;
> +
> +	return 0;
> +
> +irq_err:
> +	pci_free_irq_vectors(pdev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mhu_dt_ids[] = {
> +	{ .compatible = "marvell,octeontx-mhu" },
> +	{ .compatible = "marvell,octeontx2-mhu" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mhu_dt_ids);
> +
> +static const struct pci_device_id mhu_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA067) },
> +	{ 0 },
> +};
> +MODULE_DEVICE_TABLE(pci, mhu_ids);
> +
> +

Only one blank line.

> +static int mhu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct mhu *mhu;
> +	struct device *dev;
> +	int ret;
> +
> +	/* This driver doesn't support ACPI */
> +	if (!acpi_disabled)
> +		return -ENODEV;

Why do you need this? It is the first driver doing such dance.

> +
> +	dev = &pdev->dev;

This goes to declaration.

> +	/* Enable only configured instances */

Hm, what does it mean? Can you reach here without OF bind? How the
driver would bind then? Via PCI ids?

> +	if (!dev->of_node)
> +		return -ENODEV;
> +	if (!of_match_node(mhu_dt_ids, dev->of_node))
> +		return -EINVAL;
> +
> +	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> +	if (!mhu)
> +		return -ENOMEM;
> +
> +	/* Enable PCI device */

Drop, obvious.

> +	pci_set_drvdata(pdev, mhu);
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_request_region(pdev, BAR0, DRIVER_NAME);
> +	if (ret)
> +		return ret;
> +
> +	mhu->base = pcim_iomap(pdev, BAR0, pci_resource_len(pdev, BAR0));
> +	if (!mhu->base)
> +		return -EINVAL;
> +
> +	/* Configure IRQ from SCP to AP */
> +	ret = mhu_setup_irq(pdev);
> +	if (ret)
> +		goto irq_err;
> +	/* Configure mbox controller */
> +	ret = mhu_setup_mbox(dev);
> +	if (!ret) /* Success */

Drop comment, obvious. Anyway this is not Linux coding style. Return 0
or jump to error handling block.

> +		return 0;
> +
> +	/* In case of error, release the resources */

Drop comment, obvious.

> +	pci_free_irq_vectors(pdev);
> +irq_err:
> +	pci_release_region(pdev, BAR0);
> +
> +	return ret;
> +}
> +
> +static void mhu_remove(struct pci_dev *pdev)

Functions should have some local/driver specific name. Not generic.
> +{
> +	struct mhu *mhu;
> +
> +	mhu = pci_get_drvdata(pdev);
> +	mbox_controller_unregister(&mhu_mbox_ctrl);
> +
> +	pci_free_irq_vectors(pdev);
> +	pcim_iounmap(pdev, mhu->base);
> +	pci_release_region(pdev, BAR0);
> +}
> +
> +static struct pci_driver mhu_driver = {

Variables should have some local/driver specific name.

> +	.name = DRIVER_NAME,
> +	.id_table = mhu_ids,
> +	.probe = mhu_probe,
> +	.remove = mhu_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = mhu_dt_ids,
> +	},
> +};
> +
> +module_pci_driver(mhu_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Marvell Message Handling Unit");
> +MODULE_AUTHOR("Sujeet Baranwal <sbaranwal@marvell.com>");
> +MODULE_AUTHOR("Wojciech Bartczak <wbartczak@marvell.com>");

Best regards,
Krzysztof

