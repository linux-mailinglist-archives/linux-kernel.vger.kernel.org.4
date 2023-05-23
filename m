Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6870D0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEWCOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjEWCON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:14:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247BFA;
        Mon, 22 May 2023 19:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqwHGCUSEsIjUXPhZqoGiaM0xYCvPhTRUIWeqxBeX6INSr+tTqH2nEOsFPa8dPdimvZdIUNUVS3VBIitBhEzIeT4WoCE343NQ4LhQnHqGUkUUywhrrYpEaIRKml+nZBWmeJA1/FstGvwfCaq+ceuUq9C7OKkwx3a+ovdKwC9MUb1VcaALvzOlCxgAUMvakbQ4svSncykRdxbjYlU+YWcKcwPOGeBK3B3yyzDBPmf0bx5eo7NdyJY0Tob4KbiHushisiSteRECSRY0MfFimV1b3Gp4VdtABGMXgZKi8dl2oxr2+ODcdN+pb+ZEydaWDWsZKr3CosUEXJgqU7Gff+1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zu2GQ383m/4VIxXOUWWQoL7bxyBatQ/rEILXH9HOreA=;
 b=A0Iu8jRQ5Gf3wNNXJvE26GiYaOv0W54kD8roS9RCDZV4gEtsj6Zs5c01WCcGwrsNdYqA7erY4oEKYC9qDd7iYSbO8JpufMtN/ZgUpcaMrEbK0MKbA1gmdZKCjEffTgs9kCWpmdnNTo4cj1bAQL23u4Rv6uA1zOszj6d4NrvsoyUwPzur0bDFBXidwLoP8HWPCjs+xw7g3QUjc6ZnjRT181vZMGJ6LSQtX003jIAUJmIIfgPtEpWJMVlIcmu/wqbpPvPbVmSHYjehXislBxpy0vNyFotxCQziUNeQI1eUpxFRJOUoMei8vuxDh5PbBghDAT8bXnBdx2vDSYzf/3psGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zu2GQ383m/4VIxXOUWWQoL7bxyBatQ/rEILXH9HOreA=;
 b=duZ3ytymFqbSwxDBBeNzcnLqgmjN1OQhEwXquMv5K3P+QEVf5ok/BxFjlAUrbKf5HUVx5aYxhdt6HwhzVmT7qgPGwaHzFhumgrW1+5V8rooB1Hf34FmdwjlD7Clr++jIDXcG4mMJ1s6Bb+/txvsZAPGeJKwl1uS5aas41FZo37w=
Received: from DS7PR03CA0115.namprd03.prod.outlook.com (2603:10b6:5:3b7::30)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 02:13:43 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::69) by DS7PR03CA0115.outlook.office365.com
 (2603:10b6:5:3b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 02:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 02:13:42 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 22 May 2023 21:13:02 -0500
From:   Brad Larson <blarson@amd.com>
To:     <andy.shevchenko@gmail.com>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>, <arnd@arndb.de>,
        <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <conor+dt@kernel.org>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Mon, 22 May 2023 19:12:56 -0700
Message-ID: <20230523021256.61690-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VdsfcHOOUHuAVA38kdUyq+vwMKFYCNxScogGAJDM8ywBQ@mail.gmail.com>
References: <CAHp75VdsfcHOOUHuAVA38kdUyq+vwMKFYCNxScogGAJDM8ywBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 199c5e3c-c56e-44cf-9d7e-08db5b3354e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wwt8GiBxXF/u7TP59Rb/voHy/xI53hYZpiBG5DBCTA1rFSOdEPpmMpWvdSKnNZnVehpHTvCXSNAU8PE/nxDtcEkFTmpLn5E4eYOPRiQ3WmJTk3fGv40uyDQDlxf5NXhk1m7CvDvK8lPGhZnpJqa9DWyGcuNbFGobpZi3z/o6BTJm2Ye14uZ6hPfGchmW+DbZWsa4xtrzGlU35zyOQpwRdIIANZWD2G/uxD1aavIWC2EZSz5Sl+53XJ58B8fE0UCacsKOn7aVhkcBNf08ezcbD41fnzvmDSndKzp4QyThRiOoUeyVFM7/7ESsxvsC4D3DsxChP35LeKvK6+2WLuDA8nXaeNz8tibWskSZRLxj84xEC1PtWbjIBm414LpOr2JgrPQwBrpAZe6ojIeg6An1uQctHkoZP7JiRZkDhAIHAUxk7au/6Uq5ZG39PRpN6cytgtTAk5dXYcOR/9ye3w48eSjbP/ztMUX1sSPn4zxwKA9gQ/dOOacdQycjiiNYyvNDmd28tNWcnKi8QrELebtguhyROIB0z8ygbqQH9gAdbW0lasHWL4xDII5tjgF+xSrtGLX7totesEKCbuStP+Cquex7LQ1RIhpYS+DND3ncuX73YBI8taOb/8lVcQpwLTXTrcEhN+d0nu7HCdu/FQ8QuZ9LYA+oukbWFTP/YT93i1Rc4v5ah8Sainm+WeyF1MGP91nmWXMhKVd5CWRVUEdBj8w/i9Ct4uWZdkfebD0w6kHY2bx9KClyLUPuD2B9eZ3PVzeTx5Hn8N46GPGYhmAeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(40460700003)(8936002)(8676002)(1076003)(26005)(53546011)(2906002)(83380400001)(2616005)(47076005)(426003)(336012)(36860700001)(36756003)(16526019)(186003)(7416002)(7406005)(40480700001)(6916009)(4326008)(70206006)(70586007)(81166007)(356005)(82740400003)(316002)(54906003)(478600001)(41300700001)(6666004)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:13:42.7873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199c5e3c-c56e-44cf-9d7e-08db5b3354e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, May 16, 2023 at 00:05:32 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, May 15, 2023 at 9:18 PM Brad Larson <blarson@amd.com> wrote:
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
>
>> +#include <linux/of.h>
>
> Unneeded inclusion.

Removed

>> +#include <linux/reset-controller.h>
>> +#include <linux/spi/spi.h>
>
> ...
>
>
>> +       u8 tx_buf[PENCTRL_MAX_MSG_LEN];
>> +       u8 rx_buf[PENCTRL_MAX_MSG_LEN];
>
> Does it need to be DMA-capable?

Doesn't need to be DMA-capable

> ...
>
>> +       spi->chip_select = current_cs;
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[current_cs];
>
> Nowadays these require API calls instead of direct assignments.

Changed to:
	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[current_cs]);

> ...
>
>> +static int penctrl_release(struct inode *inode, struct file *filp)
>> +{
>> +       filp->private_data = NULL;
>> +       return 0;
>> +}
>
> Is it possible to unload the module without releasing the device node?

If the refcount is not zero the kernel prevents the module from being unloaded.

> ...
>
>> +       u8 txbuf[3];
>> +       u8 rxbuf[1];
>
> Same question about DMA.

Not DMA-capable

> ...
>
>> +       ret = spi_sync(spi, &m);
>
>> +       if (ret == 0)
>> +               *val = rxbuf[0];
>> +
>> +       return ret;
>
> Can also be written in more usual way:
>
>  if (ret)
>    return ret;
>  ...
>  return 0;

Yes, changed to:
        ret = spi_sync(spi, &m);
        if (ret)
                return ret;

        *val = rxbuf[0];
        return 0;

> ...
>
>> +       u8 txbuf[4];
>
> DMA?

Not DMA-capable

> ...
>
>> +       spi->chip_select = 0;
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[0];
>
> Setter APIs.

Changed to:
	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[0]);

>
> ...
>
>> +       spi->chip_select = 0;
>> +       spi->cs_gpiod = spi->controller->cs_gpiods[0];
>
> Ditto.

Changed to:
	spi_set_csgpiod(spi, 0, spi->controller->cs_gpiods[0]);

>> +       ret = device_property_read_u32(spi->dev.parent, "num-cs", &num_cs);
>> +       if (ret)
>> +               return dev_err_probe(&spi->dev, ret,
>> +                                    "number of chip-selects not defined\n");
>
> Hmm... Shouldn't SPI core take care of this in a generic way? Yes, I
> understand that you need the number for the allocation, but I would
> expect something like spi_fw_get_num_cs() to exist (seems not?).
>

No need to look into the parent node, changed to this:

        num_cs = spi->controller->num_chipselect;

> ...
>
>> +       penctrl->rcdev.of_node = spi->dev.of_node;
>
> Use device_set_node(). It helps to modify the data types beneath.

Added:
	device_set_node(penctrl->rcdev.dev, dev_fwnode(&spi->dev));

Regards,
Brad
