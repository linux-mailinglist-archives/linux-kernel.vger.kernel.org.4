Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81D73DD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjFZL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZL33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:29:29 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49310D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:29:25 -0700 (PDT)
X-ASG-Debug-ID: 1687778961-1eb14e179f04ec0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 1XUFVM3E7TCnD2CA (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 26 Jun 2023 19:29:21 +0800 (CST)
X-Barracuda-Envelope-From: RunaGuo-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 26 Jun
 2023 19:29:21 +0800
Received: from [10.29.8.9] (10.29.8.9) by zxbjmbx1.zhaoxin.com (10.29.252.163)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 26 Jun
 2023 19:29:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.9
Subject: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
References: <1686901766-4928-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <ccabf88b-2e2c-876d-e47a-8d142e27d638@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <LeoLiu@zhaoxin.com>,
        <RunaGuo@zhaoxin.com>
Message-ID: <70853f13-f74e-d9bb-89f7-4c804f1fa8a4@zhaoxin.com>
Date:   Mon, 26 Jun 2023 19:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ccabf88b-2e2c-876d-e47a-8d142e27d638@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.9]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1687778961
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 17197
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110558
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/16 16:34, Damien Le Moal wrote:
> On 6/16/23 16:49, Runa Guo-oc wrote:
>> [PATCH] ata:sata_zhaoxin: Add support for ZhaoXin Serial ATA
> 
> Broken patch: the email subject is your SoB instead of the above line, which
> should not be part of the message (it should be the subject). Please reformat
> and resend.
> 

Okay.

>>
>> Add ZhaoXin Serial ATA support for ZhaoXin CUPs.
> 
> What is "ZhaoXin" ?

Zhaoxin is a Chinese company that has mastered the core technology
of independent general-purpose processors and its system platform chips,
and is committed to providing users with efficient, compatible and secure
independent general-purpose processors, chipsets and other products.
for more information, you can visit here: https://www.zhaoxin.com/.

> And what is "CUPs" ? Please spell this out.
> 

Yes, this is  a spelling error.

>>
>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>> ---
>>  drivers/ata/Kconfig        |   8 +
>>  drivers/ata/Makefile       |   1 +
>>  drivers/ata/sata_zhaoxin.c | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 393 insertions(+)
>>  create mode 100644 drivers/ata/sata_zhaoxin.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 42b51c9..ae327f3 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -553,6 +553,14 @@ config SATA_VITESSE
>>  
>>  	  If unsure, say N.
>>  
>> +config SATA_ZHAOXIN
>> +	tristate "ZhaoXin SATA support"
>> +	depends on PCI
>> +	help
>> +	  This option enables support for ZhaoXin Serial ATA.
>> +
>> +	  If unsure, say N.
>> +
>>  comment "PATA SFF controllers with BMDMA"
>>  
>>  config PATA_ALI
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index 20e6645..4b84669 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -45,6 +45,7 @@ obj-$(CONFIG_SATA_SIL)		+= sata_sil.o
>>  obj-$(CONFIG_SATA_SIS)		+= sata_sis.o
>>  obj-$(CONFIG_SATA_SVW)		+= sata_svw.o
>>  obj-$(CONFIG_SATA_ULI)		+= sata_uli.o
>> +obj-$(CONFIG_SATA_ZHAOXIN)	+= sata_zhaoxin.o
> 
> Please sort this alphabetically.
> 

Like this?
obj-$(CONFIG_SATA_VITESSE)	        += sata_vsc.o
obj-$(CONFIG_SATA_ZHAOXIN)	        += sata_zhaoxin.o

>>  obj-$(CONFIG_SATA_VIA)		+= sata_via.o
>>  obj-$(CONFIG_SATA_VITESSE)	+= sata_vsc.o
>>  
>> diff --git a/drivers/ata/sata_zhaoxin.c b/drivers/ata/sata_zhaoxin.c
>> new file mode 100644
>> index 0000000..ef8c73a
>> --- /dev/null
>> +++ b/drivers/ata/sata_zhaoxin.c
>> @@ -0,0 +1,384 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  sata_zhaoxin.c - ZhaoXin Serial ATA controllers
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/blkdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <scsi/scsi.h>
>> +#include <scsi/scsi_cmnd.h>
>> +#include <scsi/scsi_host.h>
>> +#include <linux/libata.h>
>> +
>> +#define DRV_NAME	"sata_zx"
>> +#define DRV_VERSION	"2.6.1"
> 
> Version is not needed. The driver comes with the kernel...
> 

Right, I'll remove it next time.

>> +
>> +enum board_ids_enum {
>> +	zx100s,
>> +};
>> +
>> +enum {
>> +	SATA_CHAN_ENAB		= 0x40, /* SATA channel enable */
>> +	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
>> +	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
>> +	PATA_UDMA_TIMING	= 0xB3, /* PATA timing for DMA/ cable detect */
>> +	PATA_PIO_TIMING		= 0xAB, /* PATA timing register */
>> +
>> +	PORT0			= (1 << 1),
>> +	PORT1			= (1 << 0),
>> +	ALL_PORTS		= PORT0 | PORT1,
>> +
>> +	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
>> +
>> +	SATA_EXT_PHY		= (1 << 6), /* 0==use PATA, 1==ext phy */
>> +};
>> +
>> +static int zx_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
>> +static int zx_scr_read(struct ata_link *link, unsigned int scr, u32 *val);
>> +static int zx_scr_write(struct ata_link *link, unsigned int scr, u32 val);
>> +static int zx_hardreset(struct ata_link *link, unsigned int *class,
>> +				unsigned long deadline);
>> +
>> +static void zx_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
>> +
>> +static const struct pci_device_id zx_pci_tbl[] = {
>> +	{ PCI_VDEVICE(ZHAOXIN, 0x9002), zx100s },
>> +	{ PCI_VDEVICE(ZHAOXIN, 0x9003), zx100s },
>> +
> 
> Blank line not needed.
>>> +	{ }	/* terminate list */
> 
> Comment not needed.
> 

The purpose of writing like this is convenient to add new device IDs in
the future.
Considering that this is not likely, remove it also fine.

>> +};
>> +
>> +static struct pci_driver zx_pci_driver = {
>> +	.name			= DRV_NAME,
>> +	.id_table		= zx_pci_tbl,
>> +	.probe			= zx_init_one,
>> +#ifdef CONFIG_PM_SLEEP
>> +	.suspend		= ata_pci_device_suspend,
>> +	.resume			= ata_pci_device_resume,
>> +#endif
>> +	.remove			= ata_pci_remove_one,
>> +};
>> +
>> +static struct scsi_host_template zx_sht = {
>> +	ATA_BMDMA_SHT(DRV_NAME),
>> +};
>> +
>> +static struct ata_port_operations zx_base_ops = {
>> +	.inherits		= &ata_bmdma_port_ops,
>> +	.sff_tf_load		= zx_tf_load,
>> +};
>> +
>> +static struct ata_port_operations zx_ops = {
>> +	.inherits		= &zx_base_ops,
>> +	.hardreset		= zx_hardreset,
>> +	.scr_read		= zx_scr_read,
>> +	.scr_write		= zx_scr_write,
>> +};
>> +
>> +static struct ata_port_info zx100s_port_info = {
>> +	.flags		= ATA_FLAG_SATA | ATA_FLAG_SLAVE_POSS,
>> +	.pio_mask	= ATA_PIO4,
>> +	.mwdma_mask	= ATA_MWDMA2,
>> +	.udma_mask	= ATA_UDMA6,
>> +	.port_ops	= &zx_ops,
>> +};
>> +
>> +
> 
> Extra blank line not needed.
> 

I see

>> +static int zx_hardreset(struct ata_link *link, unsigned int *class,
>> +				unsigned long deadline)
> 
> Please align the arguments together.
> 

Okay.

>> +{
>> +	int rc;
>> +
>> +	rc = sata_std_hardreset(link, class, deadline);
>> +	if (!rc || rc == -EAGAIN) {
>> +		struct ata_port *ap = link->ap;
>> +		int pmp = link->pmp;
>> +		int tmprc;
>> +
>> +		if (pmp) {
>> +			ap->ops->sff_dev_select(ap, pmp);
>> +			tmprc = ata_sff_wait_ready(&ap->link, deadline);
>> +		} else {
>> +			tmprc = ata_sff_wait_ready(link, deadline);
>> +		}
>> +		if (tmprc)
>> +			ata_link_err(link, "COMRESET failed for wait (errno=%d)\n",
>> +					rc);
>> +		else
>> +			ata_link_err(link, "wait for bsy success\n");
> 
> Remove this. If it worked, be silent.
> 

Okay.

>> +
>> +		ata_link_err(link, "COMRESET success (errno=%d) ap=%d link %d\n",
>> +					rc, link->ap->port_no, link->pmp);
>> +	} else {
>> +		ata_link_err(link, "COMRESET failed (errno=%d) ap=%d link %d\n",
>> +					rc, link->ap->port_no, link->pmp);
> 
> Reverse the if condition and exit early for this case. That will make the
> function code nicer. And you can drop the error message as well since
> sata_std_hardreset() prints one.
> 

Yes, I agree with your. I'll adjust the above codes like these?

if(!rc || rc == -EAGAIN){
                struct ata_port *ap = link->ap;
                int pmp = link->pmp;
                int tmprc;
                if(pmp){
                        ap->ops->sff_dev_select(ap,pmp);
                        tmprc=ata_sff_wait_ready(&ap->link,deadline);
                }else
                        tmprc=ata_sff_wait_ready(link,deadline);

                if(tmprc)
                        ata_link_err(link,"COMRESET failed for
wait(errno=%d)\n",rc);

                ata_link_err(link,"COMRESET success (errno=%d) ap=%d
link%d\n",
                                  rc,link->ap->port_no,link->pmp);

>> +	}
>> +	return rc;
>> +}
>> +
>> +static int zx_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
>> +{
>> +	static const u8 ipm_tbl[] = { 1, 2, 6, 0 };
>> +	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
>> +	int slot = 2 * link->ap->port_no + link->pmp;
>> +	u32 v = 0;
>> +	u8 raw;
>> +
>> +	switch (scr) {
>> +	case SCR_STATUS:
>> +		pci_read_config_byte(pdev, 0xA0 + slot, &raw);
>> +
>> +		/* read the DET field, bit0 and 1 of the config byte */
>> +		v |= raw & 0x03;
>> +
>> +		/* read the SPD field, bit4 of the configure byte */
>> +		v |= raw & 0x30;
>> +
>> +		/* read the IPM field, bit2 and 3 of the config byte */
>> +		v |= ((ipm_tbl[(raw >> 2) & 0x3])<<8);
>> +		break;
>> +
>> +	case SCR_ERROR:
>> +		/* devices other than 5287 uses 0xA8 as base */
>> +		WARN_ON(pdev->device != 0x9002 && pdev->device != 0x9003);
>> +		pci_write_config_byte(pdev, 0x42, slot);
>> +		pci_read_config_dword(pdev, 0xA8, &v);
>> +		break;
>> +
>> +	case SCR_CONTROL:
>> +		pci_read_config_byte(pdev, 0xA4 + slot, &raw);
>> +
>> +		/* read the DET field, bit0 and bit1 */
>> +		v |= ((raw & 0x02) << 1) | (raw & 0x01);
>> +
>> +		/* read the IPM field, bit2 and bit3 */
>> +		v |= ((raw >> 2) & 0x03) << 8;
>> +
> 
> remove this blank line.
> 

Okay.

>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	*val = v;
>> +	return 0;
>> +}
>> +
>> +static int zx_scr_write(struct ata_link *link, unsigned int scr, u32 val)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(link->ap->host->dev);
>> +	int slot = 2 * link->ap->port_no + link->pmp;
>> +	u32 v = 0;
>> +
>> +	WARN_ON(pdev == NULL);
> 
> Warning about a null pointer and still dereferenceing it below is useless. The
> kernel will crash... This should not happen, right ? So remove this.
> 

Okay.

>> +
>> +	switch (scr) {
>> +	case SCR_ERROR:
>> +		/* devices 0x9002 uses 0xA8 as base */
>> +		WARN_ON(pdev->device != 0x9002 && pdev->device != 0x9003);
>> +		pci_write_config_byte(pdev, 0x42, slot);
>> +		pci_write_config_dword(pdev, 0xA8, val);
>> +		return 0;
>> +
>> +	case SCR_CONTROL:
>> +		/* set the DET field */
>> +		v |= ((val & 0x4) >> 1) | (val & 0x1);
>> +
>> +		/* set the IPM field */
>> +		v |= ((val >> 8) & 0x3) << 2;
>> +
>> +
>> +		pci_write_config_byte(pdev, 0xA4 + slot, v);
>> +
>> +
> 
> Way too many blank lines.
> 

I see

>> +		return 0;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +
>> +/**
>> + *	zx_tf_load - send taskfile registers to host controller
>> + *	@ap: Port to which output is sent
>> + *	@tf: ATA taskfile register set
>> + *
>> + *	Outputs ATA taskfile to standard ATA host controller.
>> + *
>> + *	This is to fix the internal bug of zx chipsets, which will
>> + *	reset the device register after changing the IEN bit on ctl
>> + *	register.
>> + */
>> +static void zx_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>> +{
>> +	struct ata_taskfile ttf;
>> +
>> +	if (tf->ctl != ap->last_ctl)  {
>> +		ttf = *tf;
>> +		ttf.flags |= ATA_TFLAG_DEVICE;
>> +		tf = &ttf;
> 
> This is very strange... Why the need for the extra local copy ? A comment would
> be nice.
> 

tf, pointer to const, the content it pointed to is constant and cannot
be changed
directly.
ttf, it is a variable.
Firstly, we change its content based on *tf;
Then, make tf pointed to it;
Lastly, *tf's content will be changed undirectly.

>> +	}
>> +	ata_sff_tf_load(ap, tf);
>> +}
>> +
>> +static const unsigned int zx_bar_sizes[] = {
>> +	8, 4, 8, 4, 16, 256
>> +};
>> +
>> +static const unsigned int zx100s_bar_sizes0[] = {
>> +	8, 4, 8, 4, 16, 0
>> +};
>> +
>> +static const unsigned int zx100s_bar_sizes1[] = {
>> +	8, 4, 0, 0, 16, 0
>> +};
>> +
>> +static int zx_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
>> +{
>> +	const struct ata_port_info *ppi0[] = {
>> +		&zx100s_port_info, NULL
>> +	};
>> +	const struct ata_port_info *ppi1[] = {
>> +		&zx100s_port_info, &ata_dummy_port_info
>> +	};
>> +	struct ata_host *host;
>> +	int i, rc;
>> +
>> +	if (pdev->device == 0x9002)
>> +		rc = ata_pci_bmdma_prepare_host(pdev, ppi0, &host);
>> +	else if (pdev->device == 0x9003)
>> +		rc = ata_pci_bmdma_prepare_host(pdev, ppi1, &host);
>> +	else
>> +		rc = -EINVAL;
>> +
> 
> Remove the blank line here.
> 

Okay.

>> +	if (rc)
>> +		return rc;
>> +
>> +	*r_host = host;
>> +
>> +	/* 9002 hosts four sata ports as M/S of the two channels */
>> +	/* 9003 hosts two sata ports as M/S of the one channel */
> 
> Multi-line comment format:
> 
> 	/*
>  	 * ...
> 	 * ...
> 	 */
> 

I got it.

>> +	for (i = 0; i < host->n_ports; i++)
>> +		ata_slave_link_init(host->ports[i]);
>> +
>> +	return 0;
>> +}
>> +
>> +static void zx_configure(struct pci_dev *pdev, int board_id)
>> +{
>> +	u8 tmp8;
>> +
>> +	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
>> +	dev_info(&pdev->dev, "routed to hard irq line %d\n",
>> +		 (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
>> +
>> +	/* make sure SATA channels are enabled */
>> +	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
>> +	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
>> +		dev_dbg(&pdev->dev, "enabling SATA channels (0x%x)\n",
>> +			(int)tmp8);
>> +		tmp8 |= ALL_PORTS;
>> +		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
>> +	}
>> +
>> +	/* make sure interrupts for each channel sent to us */
>> +	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
>> +	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
>> +		dev_dbg(&pdev->dev, "enabling SATA channel interrupts (0x%x)\n",
>> +			(int) tmp8);
>> +		tmp8 |= ALL_PORTS;
>> +		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
>> +	}
>> +
>> +	/* make sure native mode is enabled */
>> +	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
>> +	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
>> +		dev_dbg(&pdev->dev,
>> +			"enabling SATA channel native mode (0x%x)\n",
>> +			(int) tmp8);
>> +		tmp8 |= NATIVE_MODE_ALL;
>> +		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
>> +	}
>> +}
>> +
>> +static int zx_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +	unsigned int i;
>> +	int rc;
>> +	struct ata_host *host = NULL;
>> +	int board_id = (int) ent->driver_data;
>> +	const unsigned int *bar_sizes;
>> +	int legacy_mode = 0;
>> +
>> +	ata_print_version_once(&pdev->dev, DRV_VERSION);
>> +
>> +	if (pdev->device == 0x9002 || pdev->device == 0x9003) {
>> +		if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
>> +			u8 tmp8, mask;
>> +
>> +			/* TODO: What if one channel is in native mode ... */
> 
> I do not know... What about it ? If this is not expected to work/not supported,
> then return an error.
> 

Yes, you're right. Zhaoxin sata controllers do not support legacy mode.
So we return an error here.

Based on the latest kernel code, this part may be adjusted like these:

	u8 tmp8, mask = 0;
     	pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
                if (!ata_port_is_dummy(host->ports[0]))
                        mask |= (1 << 0);
                if (!ata_port_is_dummy(host->ports[1]))
                        mask |= (1 << 2);
                if ((tmp8 & mask) != mask)
                        legacy_mode = 1;

>> +			pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
>> +			mask = (1 << 2) | (1 << 0);
>> +			if ((tmp8 & mask) != mask)
>> +				legacy_mode = 1;
>> +		}
>> +		if (legacy_mode)
>> +			return -EINVAL;
>> +	}
>> +
>> +	rc = pcim_enable_device(pdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (board_id == zx100s && pdev->device == 0x9002)
>> +		bar_sizes = &zx100s_bar_sizes0[0];
>> +	else if (board_id == zx100s && pdev->device == 0x9003)
>> +		bar_sizes = &zx100s_bar_sizes1[0];
>> +	else
>> +		bar_sizes = &zx_bar_sizes[0];
>> +
>> +	for (i = 0; i < ARRAY_SIZE(zx_bar_sizes); i++) {
>> +		if ((pci_resource_start(pdev, i) == 0) ||
>> +		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
>> +			if (bar_sizes[i] == 0)
>> +				continue;
>> +
>> +			dev_err(&pdev->dev,
>> +				"invalid PCI BAR %u (sz 0x%llx, val 0x%llx)\n",
>> +				i,
>> +				(unsigned long long)pci_resource_start(pdev, i),
>> +				(unsigned long long)pci_resource_len(pdev, i));
>> +
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	switch (board_id) {
>> +	case zx100s:
>> +		rc = zx_prepare_host(pdev, &host);
>> +		break;
>> +	default:
>> +		rc = -EINVAL;
>> +	}
>> +	if (rc)
>> +		return rc;
>> +
>> +	zx_configure(pdev, board_id);
>> +
>> +	pci_set_master(pdev);
>> +	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
>> +				 IRQF_SHARED, &zx_sht);
>> +}
>> +
>> +module_pci_driver(zx_pci_driver);
>> +
>> +MODULE_AUTHOR("Yanchen:YanchenSun@zhaoxin.com");
>> +MODULE_DESCRIPTION("SCSI low-level driver for ZX SATA controllers");
> 
> This is not a scsi driver...
> 

I treat it as a scsi driver for the following reasons,  which may be not
accurate.
1, IO path: vfs->fs->block layer->scsi layer->this driver;
2, Extracted from the following link:
"SCSI Lower level drivers (LLDs) are variously called host bus adapter
(HBA) drivers and host drivers (HD)."

https://www.kernel.org/doc/html/latest/scsi/scsi_mid_low_api.html

Maybe I shall delete it next time.

>> +MODULE_LICENSE("GPL");
>> +MODULE_DEVICE_TABLE(pci, zx_pci_tbl);
>> +MODULE_VERSION(DRV_VERSION);
> 

