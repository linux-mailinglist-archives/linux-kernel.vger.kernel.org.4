Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9B16E9F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDTWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjDTWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:53:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933EA4EC2;
        Thu, 20 Apr 2023 15:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRnXWKIC1gtXfUS2N0aSFqFQuMGEEfsoXDiS8k5ojC865x3bHVCiLAXbrIuoG418Amt+d2AxFBaoWBezKxEzIuIObs6X5OXsB/MUH4OdPbUyYrw2nmUicJaphseq/SFApT5u3tBN+6Aj8B6hF1ucIgC2vRqNbhZaiDvl65aAgL6lU9eBozlDXN0L06djfJkrHG/JIrRsWIUJ4hM/mB4voOTHW4GYY4Uvc7ZIjXMyPU6BYHYTUQuC4HPdNcS6GOB4weotjpPHK6t2H8kzTM7hay0wCuRz+Ys/jhXxNGw5XGT6zI6IJ1dZFEeRRUgKdjUuraQkW8T2mXcgVlceBm0qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hr+N3lnX8pIplr/zrkujbSMwuCccLSs/yFOQ9JViGP8=;
 b=LwT0RhH6ZiBRPqg+WoxsyqQqmx5z/lkkwK+cw0HbOwwu8tXewMaPr766FhpPUWMSqSASqlwBwuOJX1omooNAaFEkks1KDGUgx0bFmAMx95PtvpaAbABwD5M09ez7kH3f+f9D/iAYtMIbv59GEjaDzkM1pWEYgV/+xAmJI9SidOFTIoRXvCNuB4EhDSwnrJ3Q5EnqgP07akXmMpWqvACixoOy6QUsjuvrBIoQ+GJ0idY49/pP89fLitlExI1WM6n34lML+VKOmPQ9Yp6TjQlMZd6Z8E7P4aZ0B2f41ugEy809bQiI41lyGYc/YHVxP1zz1MVwn8u6C1uQdqZTnTlFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr+N3lnX8pIplr/zrkujbSMwuCccLSs/yFOQ9JViGP8=;
 b=xiiF/KefDNKHJH/hMMGT5hnI/nncI2jKvoD0ZqXi+0BKuTeoBp8/NF6YEOoOeUB/BXpti9UwoALzL4PaI/WygwJKEl24FRX37aiMfB74h0rn/sq/LMcFZP5yC6yKyA2+9rOqgvd3/5JNBP4h4awPI8A0js3DA8bW4PLA7nsGnfI=
Received: from MW4PR03CA0096.namprd03.prod.outlook.com (2603:10b6:303:b7::11)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 22:52:58 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::90) by MW4PR03CA0096.outlook.office365.com
 (2603:10b6:303:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 22:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 22:52:58 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 17:52:54 -0500
From:   Brad Larson <blarson@amd.com>
To:     <andy.shevchenko@gmail.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>, <arnd@arndb.de>,
        <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v13 15/15] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Thu, 20 Apr 2023 15:52:47 -0700
Message-ID: <20230420225247.33718-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VewhdOwqkuwHKT9e120Zgfhnp5x-sgaayWJPC4kZ=VxZw@mail.gmail.com>
References: <CAHp75VewhdOwqkuwHKT9e120Zgfhnp5x-sgaayWJPC4kZ=VxZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a1e7e8-ac82-4041-f573-08db41f1fc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqlTyBDD82+CaI1uiTW+Yiy549qugFnXq+eX9+hwzIBqA2WlOQxcQpb/gnHk78lN+iD/jyx8xZtueX1AGCgZ6Qa6l4lyrICfDQxE51SwiqXb9ovbZCbaniKr4Ennt/GNBTMGswOBsk5pgjLLaegYP924sFn57SB+NPymy64o0+54Rm8qIneOEe3JldYbGpLjeoI/+PDXoGUh0xFQgqwa8gBi+vZcxDp7WYG6PfszInjw/nUgR7Olz0Hk6SWhLSeIyH3uPTqhMO63iUKrPtnO9IeYkPO4sT6B5sO4ADhwqSrrreAcuDLMUqj3d+CNCCArok2gkpLvsh3SW4DYxdaXjr2Z/dGxoDSEaQv+uFAsh9gAgb1hO9/QcY4N5r2RukmSUZMBHYhtNw5faA0GfZh7o+BQ/6u/LtPOULPqcgdp4jlMaMrn0qAboHRJQuc5jinpOolNMYHQtclVVBWUqcdKX6dAEGn8rxFaX40ZFP62qtrkNs6O7zgFVsIIyJZ38HMbRA4pJMQ7SwBMVwl+uFjMvGpWabFsm4KdyGf4kU8KLLHb2ojvfSHA+zzRdYJfR2LRtOcLYQwLpnfxOg9DgcF0w994i+zk4e4fGNLv2RJ1yJVdOf+fkd6wtURO2as2022QmGnQbkDDURTp7H/Wo8qiSTRNdvY1/uU3MkiLwPqfeTJXJ5r4viS7cBMbmXWpFL3XTdMlA9pxNnSnR7rqc7vXVxnIRMPmp0fRuFHAHKhLqak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(316002)(70586007)(70206006)(4326008)(6916009)(40480700001)(6666004)(54906003)(82310400005)(478600001)(5660300002)(36756003)(7416002)(7406005)(2616005)(8676002)(8936002)(81166007)(356005)(82740400003)(2906002)(83380400001)(30864003)(47076005)(336012)(426003)(36860700001)(41300700001)(1076003)(26005)(186003)(16526019)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 22:52:58.0688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a1e7e8-ac82-4041-f573-08db41f1fc7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the additional review.

On Tue, Apr 11, 2023 at 12:20:43 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 10, 2023 at 9:48 PM Brad Larson <blarson@amd.com> wrote:
>>
>> The Pensando SoC controller is a SPI connected companion device
>> that is present in all Pensando SoC board designs.  The essential
>> board management registers are accessed on chip select 0 with
>> board mgmt IO support accessed using additional chip selects.
>
> ...
>
>> +#include <linux/cdev.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/spi/spi.h>
>
> + Blank line?

Added blank line

>> +#include <linux/amd-pensando-ctrl.h>
>
> ...
>
>> +struct penctrl_device {
>> +       struct spi_device *spi;
>> +       struct reset_controller_dev rcdev;
>
> Try to swap them and check if the code will be smaller (it depends on
> how often one or another member is being used),

Reversed the order to reduced code size by 8 bytes.

>> +};
>
> ...
>
>> +static long
>> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>> +       void __user *in_arg = (void __user *)arg;
>> +       struct penctrl_device *penctrl;
>> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
>> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];
>> +       struct spi_transfer t[2] = {};
>> +       struct penctrl_spi_xfer *msg;
>> +       struct spi_device *spi;
>> +       unsigned int num_msgs;
>> +       struct spi_message m;
>> +       u32 size;
>> +       int ret;
>> +
>> +       /* Check for a valid command */
>> +       if (_IOC_TYPE(cmd) != PENCTRL_IOC_MAGIC)
>> +               return -ENOTTY;
>> +
>> +       if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
>> +               return -ENOTTY;
>> +
>> +       if (_IOC_DIR(cmd) & _IOC_READ)
>> +               ret = !access_ok(in_arg, _IOC_SIZE(cmd));
>> +       else if (_IOC_DIR(cmd) & _IOC_WRITE)
>> +               ret = !access_ok(in_arg, _IOC_SIZE(cmd));
>
>> +
>
> Unneeded blank line.
>
>> +       if (ret)
>> +               return -EFAULT;
>
> But it seems you can actually rewrite above in less lines:
>
>       if ((_IOC_DIR(cmd) & _IOC_READ) && !access_ok(in_arg, _IOC_SIZE(cmd)))
>         return -EFAULT;
>
>       if ((_IOC_DIR(cmd) & _IOC_WRITE) && !access_ok(in_arg, _IOC_SIZE(cmd)))
>         return -EFAULT;

Yes, changed to save a line.

>> +       /* Get a reference to the SPI device */
>> +       penctrl = filp->private_data;
>> +       if (!penctrl)
>> +               return -ESHUTDOWN;
>> +
>> +       spi = spi_dev_get(penctrl->spi);
>> +       if (!spi)
>> +               return -ESHUTDOWN;
>> +
>> +       /* Verify and prepare SPI message */
>> +       size = _IOC_SIZE(cmd);
>> +       num_msgs = size / sizeof(struct penctrl_spi_xfer);
>> +       if (size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
>> +               ret = -EINVAL;
>> +               goto done;
>> +       }
>> +       msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
>
>> +       if (!msg) {
>> +               ret = PTR_ERR(msg);
>
> This is strange.

Yes, changed to

        msg = memdup_user((struct penctrl_spi_xfer *)arg, size);
        if (IS_ERR(msg)) {
                ret = PTR_ERR(msg);
                goto out_unlock;
        }

>> +               goto done;
>> +       }
>> +       if (msg->len > PENCTRL_MAX_MSG_LEN) {
>> +               ret = -EINVAL;
>> +               goto done;
>> +       }
>> +
>> +       t[0].tx_buf = tx_buf;
>> +       t[0].len = msg->len;
>> +       if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {
>> +               ret = -EFAULT;
>> +               goto done;
>> +       }
>> +       if (num_msgs > 1) {
>> +               msg++;
>> +               if (msg->len > PENCTRL_MAX_MSG_LEN) {
>> +                       ret = -EINVAL;
>> +                       goto done;
>> +               }
>> +               t[1].rx_buf = rx_buf;
>> +               t[1].len = msg->len;
>> +       }
>> +       spi_message_init_with_transfers(&m, t, num_msgs);
>
> It seems there is no validation for the messages 3+.

The device doesn't support and applications don't use num_msgs > 2, added this check here

        /* Verify and prepare SPI message */
        size = _IOC_SIZE(cmd);
        num_msgs = size / sizeof(struct penctrl_spi_xfer);
        if (num_msgs > 2 || size == 0 || size % sizeof(struct penctrl_spi_xfer)) {
                ret = -EINVAL;
                goto out_unlock;
        }

>> +       /* Perform the transfer */
>> +       mutex_lock(&spi_lock);
>> +       ret = spi_sync(spi, &m);
>> +       mutex_unlock(&spi_lock);
>> +
>> +       if (ret || (num_msgs == 1))
>> +               goto done;
>> +
>> +       if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
>> +               ret = -EFAULT;
>
>> +done:
>
> out_unlock: ?

Changed to out_unlock

>> +       spi_dev_put(spi);
>> +       return ret;
>> +}
>> +
>> +static int penctrl_open(struct inode *inode, struct file *filp)
>> +{
>> +       struct spi_device *spi;
>> +       u8 current_cs;
>
>> +       if (!penctrl)
>> +               return -ENODEV;
>
> Is it possible?

No, removed as a non-existent device can't be opened.

>> +       filp->private_data = penctrl;
>> +       current_cs = iminor(inode);
>> +       spi = penctrl->spi;
>> +       spi->chip_select = current_cs;
>
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[current_cs];
>
> Hmm... Why do you need this one? Isn't it a job of SPI core?

When the four device tree nodes, one per cs, was squashed into the parent the
SPI core no longer handles this and the driver needs to do it. 

>> +       spi_setup(spi);
>> +       return stream_open(inode, filp);
>> +}
>
>> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg, u32 *val)
>> +{
>> +       struct spi_device *spi = penctrl->spi;
>> +       struct spi_transfer t[2] = {};
>> +       struct spi_message m;
>> +       u8 txbuf[3];
>> +       u8 rxbuf[1];
>> +       int ret;
>> +
>> +       txbuf[0] = PENCTRL_SPI_CMD_REGRD;
>> +       txbuf[1] = reg;
>> +       txbuf[2] = 0;
>> +       t[0].tx_buf = txbuf;
>> +       t[0].len = 3;
>
> sizeof(txbuf) ?

Changed to sizeof()

>> +       rxbuf[0] = 0;
>> +       t[1].rx_buf = rxbuf;
>> +       t[1].len = 1;
>
> sizeof(rxbuf) ?

Changed to sizeof()

>> +       spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
>> +       ret = spi_sync(spi, &m);
>> +       if (ret == 0)
>> +               *val = rxbuf[0];
>> +
>> +       return ret;
>> +}
>> +
>> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg, u32 val)
>> +{
>> +       struct spi_device *spi = penctrl->spi;
>> +       struct spi_transfer t;
>> +       struct spi_message m;
>> +       u8 txbuf[4];
>> +
>> +       txbuf[0] = PENCTRL_SPI_CMD_REGWR;
>> +       txbuf[1] = reg;
>> +       txbuf[2] = val;
>> +       txbuf[3] = 0;
>> +
>> +       t.tx_buf = txbuf;
>> +       t.len = 4;
>
> sizeof(txbuf) ?

Changed to sizeof()

>> +       spi_message_init_with_transfers(&m, &t, 1);
>> +       return spi_sync(spi, &m);
>> +}
>> +
>> +static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
>> +                               unsigned long id)
>> +{
>> +       struct penctrl_device *penctrl =
>> +               container_of(rcdev, struct penctrl_device, rcdev);
>> +       struct spi_device *spi = penctrl->spi;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       mutex_lock(&spi_lock);
>> +       spi->chip_select = 0;
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[0];
>> +       spi_setup(spi);
>> +       ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
>> +       if (ret) {
>> +               dev_err(&spi->dev, "error reading ctrl0 reg\n");
>> +               goto done;
>> +       }
>> +
>> +       val |= BIT(6);
>> +       ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
>> +       if (ret)
>> +               dev_err(&spi->dev, "error writing ctrl0 reg\n");
>
>> +done:
>
> out_unlock: ?

Changed to out_unlock

>> +       mutex_unlock(&spi_lock);
>> +       return ret;
>> +}
>> +
>> +static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
>> +                                 unsigned long id)
>> +{
>> +       struct penctrl_device *penctrl =
>> +               container_of(rcdev, struct penctrl_device, rcdev);
>> +       struct spi_device *spi = penctrl->spi;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       mutex_lock(&spi_lock);
>> +       spi->chip_select = 0;
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[0];
>> +       spi_setup(spi);
>> +       ret = penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
>> +       if (ret) {
>> +               dev_err(&spi->dev, "error reading ctrl0 reg\n");
>> +               goto done;
>> +       }
>> +
>> +       val &= ~BIT(6);
>> +       ret = penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
>> +       if (ret)
>> +               dev_err(&spi->dev, "error writing ctrl0 reg\n");
>
>> +done:
>
> out_unlock: ?

Changed to out_unlock

>> +       mutex_unlock(&spi_lock);
>> +       return ret;
>> +}
>
>> +static int penctrl_spi_probe(struct spi_device *spi)
>> +{
>> +       struct device *dev;
>> +       struct cdev *cdev;
>> +       u32 num_cs;
>> +       int ret;
>> +       u32 cs;
>> +
>> +       ret = device_property_read_u32(spi->dev.parent, "num-cs", &num_cs);
>> +       if (ret)
>> +               return dev_err_probe(&spi->dev, ret,
>> +                                    "number of chip-selects not defined\n");
>> +
>> +       ret = alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
>> +       if (ret)
>> +               return dev_err_probe(&spi->dev, ret,
>> +                                    "failed to alloc chrdev region\n");
>> +
>> +       penctrl_class = class_create(THIS_MODULE, "penctrl");
>> +       if (IS_ERR(penctrl_class)) {
>> +               ret = dev_err_probe(&spi->dev, PTR_ERR(penctrl_class),
>> +                                   "failed to create class\n");
>> +               goto unregister_chrdev;
>> +       }
>> +
>> +       cdev = cdev_alloc();
>> +       if (!cdev) {
>> +               ret = dev_err_probe(&spi->dev, -ENOMEM,
>> +                                   "allocation of cdev failed\n");
>> +               goto destroy_class;
>> +       }
>> +       cdev->owner = THIS_MODULE;
>> +       cdev_init(cdev, &penctrl_fops);
>> +
>> +       ret = cdev_add(cdev, penctrl_devt, num_cs);
>> +       if (ret) {
>> +               ret = dev_err_probe(&spi->dev, ret,
>> +                                   "register of cdev failed\n");
>> +               goto free_cdev;
>> +       }
>> +
>> +       /* Allocate driver data */
>> +       penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
>> +       if (!penctrl) {
>> +               ret = -ENOMEM;
>> +               goto free_cdev;
>> +       }
>> +       penctrl->spi = spi;
>> +       mutex_init(&spi_lock);
>> +
>> +       /* Create a device for each chip select */
>> +       for (cs = 0; cs < num_cs; cs++) {
>> +               dev = device_create(penctrl_class,
>> +                                   &spi->dev,
>> +                                   MKDEV(MAJOR(penctrl_devt), cs),
>> +                                   penctrl,
>> +                                   "penctrl0.%d",
>> +                                   cs);
>> +               if (IS_ERR(dev)) {
>> +                       ret = dev_err_probe(&spi->dev, PTR_ERR(dev),
>> +                                           "error creating device\n");
>> +                       goto destroy_device;
>> +               }
>> +               dev_dbg(&spi->dev, "created device major %u, minor %d\n",
>> +                       MAJOR(penctrl_devt), cs);
>> +       }
>> +
>> +       /* Register emmc hardware reset */
>> +       penctrl->rcdev.nr_resets = 1;
>> +       penctrl->rcdev.owner = THIS_MODULE;
>> +       penctrl->rcdev.dev = &spi->dev;
>> +       penctrl->rcdev.ops = &penctrl_reset_ops;
>
>> +       penctrl->rcdev.of_node = spi->dev.of_node;
>
> Either redundant or wrong. Shouldn't you first have the firmware node
> to be set for spi->dev?

The spi device firmware node is set on entry to penctrl_spi_probe().  Just the
reset controller of_node needs to be set like this

        penctrl->rcdev.dev = &spi->dev;
        penctrl->rcdev.ops = &penctrl_reset_ops;
        penctrl->rcdev.owner = THIS_MODULE;
        penctrl->rcdev.of_node = spi->dev.of_node;
        penctrl->rcdev.nr_resets = 1;

        ret = reset_controller_register(&penctrl->rcdev);

which is similar to other reset controllers for example reset-sunplus.c:

static int sp_reset_probe(struct platform_device *pdev)
{
        struct device *dev = &pdev->dev;
...
        reset->rcdev.ops = &sp_reset_ops;
        reset->rcdev.owner = THIS_MODULE;
        reset->rcdev.of_node = dev->of_node;
        reset->rcdev.nr_resets = resource_size(res) / 4 * BITS_PER_HWM_REG;

        ret = devm_reset_controller_register(dev, &reset->rcdev);
}

for of_node at the same level as dev in reset_controller_dev 

struct reset_controller_dev {
        const struct reset_control_ops *ops;
	...
        struct device *dev;
        struct device_node *of_node;
	...
};

>> +       device_set_node(&spi->dev, dev_fwnode(dev));
>> +
>> +       ret = reset_controller_register(&penctrl->rcdev);
>> +       if (ret)
>> +               return dev_err_probe(&spi->dev, ret,
>> +                                    "failed to register reset controller\n");
>> +       return 0;
>> +
>> +destroy_device:
>> +       for (cs = 0; cs < num_cs; cs++)
>> +               device_destroy(penctrl_class, MKDEV(MAJOR(penctrl_devt), cs));
>> +       kfree(penctrl);
>> +free_cdev:
>> +       cdev_del(cdev);
>> +destroy_class:
>> +       class_destroy(penctrl_class);
>> +unregister_chrdev:
>> +       unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
>> +
>> +       return ret;
>> +}
>
> ...
>
>> +++ b/include/uapi/linux/amd-pensando-ctrl.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Userspace interface for /dev/penctrl
>> + *
>> + * This file can be used by applications that need to communicate
>> + * with the AMD Pensando SoC controller device via the ioctl interface.
>> + */
>> +#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H
>> +#define _UAPI_LINUX_AMD_PENSANDO_CTRL_H
>
>> +#include <linux/ioctl.h>
>
> Not used header.

Removed

>> +#include <linux/types.h>
>> +
>> +#define PENCTRL_SPI_CMD_REGRD  0x0b
>> +#define PENCTRL_SPI_CMD_REGWR  0x02
>> +#define PENCTRL_IOC_MAGIC      'k'
>> +#define PENCTRL_IOC_MAXNR      0
>> +#define PENCTRL_MAX_MSG_LEN    16
>> +#define PENCTRL_MAX_REG                0xff
>> +#define PENCTRL_REG_CTRL0      0x10
>> +
>> +struct penctrl_spi_xfer {
>> +       __u64 tx_buf;
>> +       __u64 rx_buf;
>> +       __u32 len;
>> +       __u32 speed_hz;
>> +       __u64 compat;
>> +};
>> +
>> +#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */
