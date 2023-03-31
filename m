Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19286D2B51
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjCaW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:26:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2952D1EA02;
        Fri, 31 Mar 2023 15:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaVr02sTaQcKvJIUHePjdYYSxreBPuvH3BMt3tR+CzoRhGhhdbqauq6hUgwx4apQlnfIL5+r7Zv3aeDMJ91pbcrqwe1yUxbuSaIiRym8jKATSY0ucvwDw+fjWdcF7YOMW9IQvq/si3lC8MBZNoRrXrtgsdGRB3f1rT9y4L1c2iyq5xXBJmeYrvfgnYOKwzID9OAMeZccc3QXRMtR9Z4HDjvYjHAswZl3YGdO1I5+0iDccvFQlLGmiU9fNy+cZAPAXVrcgrzyXJaysgY56laYEjkIXJ+KzNrpuKDK9b08pdW5Dqf0MHOWJvkbXWG+Ya/mTgmikLYs6bVY6WCpewnW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+uGch/gunkBudLYZUnokyTAsyvZyh6X+7w/D5fLpHU=;
 b=nGIJzVS4js86UmevWkCzlXD3V2uUYnzuU6a/5p/0MYcMzLKMeGLEOaYaCJAiH3oOd1ADpZ7dMxiTAc4OL5nmm7oAhGJ0QTli74UbhB5gm8wjtFtmDGLLvMVKUxMCOWJNJKBkCEPkOnWC+w20OjxatRODhEArcvJYh30AJ4H5m5oOqUnVt70JnrqTEaf3j52j8ivGSGPS7KA/xhTN3XLLHqiU3OKnyEU02GJ7y+glzMNVV0lF8SQtr7BTqe86H7WvPU1VmGwDHFjJ3b3cDEYdY4UkhhDj/m490zfJCCPeMwY18c5TcQAL+X5zZZdyFZunjUArRvuI5SX6++h6tYVYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+uGch/gunkBudLYZUnokyTAsyvZyh6X+7w/D5fLpHU=;
 b=2hqV4aROb7/LdwjJxniMEowHiM7iZp52t96WlaoyL1ueHtt9ALv1PNTN+J7LgFMfaDcRPUeCNygEP4QBFQ0D1jt3melvpYDinL9feCJDrBc4lfUYD5R7yUPK4cBNOYapqy5SS2mgmqd/eRh3p5Kpi1s0s+E0K/FI5mRrbsOg9+g=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 22:26:50 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1b) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Fri, 31 Mar 2023 22:26:50 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 31 Mar 2023 17:26:47 -0500
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
Subject: Re: [PATCH v12 15/15] soc: amd: Add support for AMD Pensando SoC Controller
Date:   Fri, 31 Mar 2023 15:26:41 -0700
Message-ID: <20230331222641.38009-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHp75VcbDBUf2cH_6rRqn5RCGSEOWqE85Yn3gDhYiJPhGf1S=Q@mail.gmail.com>
References: <CAHp75VcbDBUf2cH_6rRqn5RCGSEOWqE85Yn3gDhYiJPhGf1S=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: cee2fa23-36eb-444c-7a25-08db323705b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBXLH+xfqQPQ1z4o9OwxtkkkckCYImkvvE35aS/z+ng5TbwOFVaEe570mWBdox+FWo+HWPFWlaQf42QGwWeSpdIiGwVnUilY1L7ZP8NJpZgD+TH1kLXm5VOpBwUObXU5KCcY+FWIWq1MhLHTk9G1dB1dWv6fWA8/RJmLrfWRd8YKIsOa5gh0zvyPcO5BMBPZhiMSETI6HNIcjPbPt/Kt+u0JLtAKwEL5liP3lVtXhTw3SC+ASMYcDqt4ZWpa+NRcg5RZl9asOJo0/ge8s6FzbXN1NRdeK/nbI0haUWM4k3VlKslYgBMlr93IrCs/6walv2odjf0d1z6Ni2meoPP9mOCb2HhtIM12dRnSNoP78gtMjJjsyaWYrKTDDNqiQFg64yz1Ee26iZ5Oh7HoAohdPrTKeyf60BVDoS19qfWoaYYrbavJ9O3kNLPsxTz8aUSw9w7FA++pwzltMYEIz7FiZbzpt2zClk3dqggKkS3gCdOWFcfHm4oIhwFhaQyz103fWciGkEPS41lBzDOsVHHWHB8qBC9sq8VOXcedGxxhBXTQwhHGvZohz5lCT1hXpHv+sYQBxhsTbL46tKVRRsL5moNSe3OTHczmVctW/D32vq+IgXL634U2218Is6KBlaiVOgwgkySivQjRj1JnNd6dFhbWS9hYGvl7/YsqEcNIA3xG8gcOQXiB757lhb9s/mSqfBoiRpY/EWfQRjEwEOibH1Cp1mvEpah9sPSBmB/6FWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(316002)(1076003)(26005)(53546011)(40460700003)(81166007)(356005)(8676002)(36756003)(8936002)(6666004)(41300700001)(70206006)(6916009)(70586007)(5660300002)(4326008)(82740400003)(82310400005)(40480700001)(54906003)(36860700001)(478600001)(7406005)(7416002)(2906002)(47076005)(2616005)(336012)(186003)(66899021)(426003)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:26:50.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee2fa23-36eb-444c-7a25-08db323705b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the review.

On Thu, Mar 23, 2023 at 13:06 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 23, 2023 at 2:11 AM Brad Larson <blarson@amd.com> wrote:
>>
>> The Pensando SoC controller is a SPI connected companion device
>> that is present in all Pensando SoC board designs.  The essential
>> board management registers are accessed on chip select 0 with
>> board mgmt IO support accessed using additional chip selects.
>
> ...
>
>> +config AMD_PENSANDO_CTRL
>> +       tristate "AMD Pensando SoC Controller"
>> +       depends on SPI_MASTER=y
>> +       depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
>> +       default y if ARCH_PENSANDO
>
>       default ARCH_PENSANDO

Changed to default ARCH_PENSANDO

>> +       select REGMAP_SPI
>> +       select MFD_SYSCON
>
> ...
>
>> +/*
>> + * AMD Pensando SoC Controller
>> + *
>> + * Userspace interface and reset driver support for SPI connected Pensando SoC
>> + * controller device.  This device is present in all Pensando SoC designs and
>> + * contains board control/status regsiters and management IO support.
>
> registers ?

Fixed the typo

> ...
>
>> +#include <linux/cdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>
> Seems semi-random. Are you sure you use this and not missing mod_devicetable.h?

Added mod_devicetable.h.
Removed delay.h, fs.h and of_device.h

>> +#include <linux/reset-controller.h>
>> +#include <linux/spi/spi.h>
>
>...
>
>> +struct penctrl_device {
>> +       struct spi_device *spi_dev;
>> +       struct reset_controller_dev rcdev;
>
> Perhaps swapping these two might provide a better code generation.

Its a 96 byte struct with pointer followed by the reset controller.
The spi_device variable is accessed frequently and rcdev during
boot and ideally never again so if rcdev is mostly missing from
cache that is fine.  Likely the address of spi_dev is also in 
cache given it is periodically accessed.

> ...
>
>> +       struct spi_transfer t[2] = { 0 };
>
> 0 is not needed.

Dropped the 0.

> ...
>
>> +       if (_IOC_DIR(cmd) & _IOC_READ)
>> +               ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
>> +       else if (_IOC_DIR(cmd) & _IOC_WRITE)
>> +               ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
>
>
> Maybe you should create a temporary variable as
>
>    void __user *in = ... arg;

Yes, created temp variable.

>
>> +       if (ret)
>> +               return -EFAULT;
>
> ...
>
>> +       /* Verify and prepare spi message */
>
> SPI

Changed to SPI

>> +       size = _IOC_SIZE(cmd);
>> +       if ((size % sizeof(struct penctrl_spi_xfer)) != 0) {
>
> ' != 0' is redundant.

Fixed

>
>> +               ret = -EINVAL;
>> +               goto done;
>> +       }
>> +       num_msgs = size / sizeof(struct penctrl_spi_xfer);
>
>> +       if (num_msgs == 0) {
>> +               ret = -EINVAL;
>> +               goto done;
>> +       }
>
> Can be unified with a previous check as
>
> if (size == 0 || size % ...)

Yes, made this change.

>> +       msg = memdup_user((struct penctrl_spi_xfer __user *)arg, size);
>> +       if (!msg) {
>> +               ret = PTR_ERR(msg);
>> +               goto done;
>> +       }
>
>...
>
>> +       if (copy_from_user((void *)(uintptr_t)tx_buf,
>> +                          (void __user *)msg->tx_buf, msg->len)) {
>
> Why are all these castings here?

Yes, overkill, changed to:

        if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len)) {

> ...
>
>> +       if (copy_to_user((void __user *)msg->rx_buf,
>> +                        (void *)(uintptr_t)rx_buf, msg->len))
>> +               ret = -EFAULT;
>
> Ditto.

Changed to:

        if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))

> ...
>
>> +       struct spi_transfer t[2] = { 0 };
>
> 0 is redundant.

Dropped the 0.

> ...
>
>> +       struct spi_transfer t[1] = { 0 };
>
> Ditto.

Dropped the 0.

> Why is this an array?

Fixed, it's a single message and shouldn't be an array.

> ...
>
>> +       ret = spi_sync(spi_dev, &m);
>> +       return ret;
>
> return spi_sync(...);

Fixed.

> ...
>
>> +       np = spi_dev->dev.parent->of_node;
>> +       ret = of_property_read_u32(np, "num-cs", &num_cs);
>
> Why not simply device_property_read_u32()?

It can be and removed two lines with below result. Also changed the
variable spi_dev to spi which is the more common usage.

        ret = device_property_read_u32(spi->dev.parent, "num-cs", &num_cs);
        if (ret)
                return dev_err_probe(&spi->dev, ret,
                                     "number of chip-selects not defined\n");

> ...
>
>> +       cdev = cdev_alloc();
>> +       if (!cdev) {
>> +               dev_err(&spi_dev->dev, "allocation of cdev failed");
>> +               ret = -ENOMEM;
>
> ret = dev_err_probe(...);

Fixed.

>> +               goto cdev_failed;
>> +       }
>
> ...
>
>> +       ret = cdev_add(cdev, penctrl_devt, num_cs);
>> +       if (ret) {
>
>> +               dev_err(&spi_dev->dev, "register of cdev failed");
>
> dev_err_probe() ?

Fixed.

>> +               goto cdev_delete;
>> +       }
>
> ...
>
>> +       penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
>> +       if (!penctrl) {
>
>> +               ret = -ENOMEM;
>> +               dev_err(&spi_dev->dev, "allocate driver data failed");
>
> ret = dev_err_probe();
> But we do not print memory allocation failure messages.

Fixed this way

        penctrl = kzalloc(sizeof(*penctrl), GFP_KERNEL);
        if (!penctrl) {
                ret = -ENOMEM;
                goto free_cdev;
        }

> ...
>
>> +               if (IS_ERR(dev)) {
>> +                       ret = IS_ERR(dev);
>> +                       dev_err(&spi_dev->dev, "error creating device\n");
>
> ret = dev_err_probe();

Fixed.

> ...
>
> +       spi_set_drvdata(spi_dev, penctrl);
>
> Is it in use?

Not used and now dropped.

> ...
>
>> +       penctrl->rcdev.of_node = spi_dev->dev.of_node;
>
> device_set_node();

Added: device_set_node(&spi->dev, dev_fwnode(dev));

> ...
>
>> +       ret = reset_controller_register(&penctrl->rcdev);
>> +       if (ret)
>> +               return dev_err_probe(&spi_dev->dev, ret,
>> +                                    "failed to register reset controller\n");
>> +       return ret;
>
> return 0;

Yes, changed.

> ...
>
>> +       device_destroy(penctrl_class, penctrl_devt);
>
> Are you sure this is the correct API?

Yes, however a probe error could call up to 5 APIs to clean up which resulted
in this update:

destroy_device:
        for (cs = 0; cs < num_cs; cs++)
                device_destroy(penctrl_class, MKDEV(MAJOR(penctrl_devt), cs));
        kfree(penctrl);
free_cdev:
        cdev_del(cdev);
destroy_class:
        class_destroy(penctrl_class);
unregister_chrdev:
        unregister_chrdev(MAJOR(penctrl_devt), "penctrl");

        return ret;

> ...
>
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>
> Sorted?

Swapped these

Regards,
Brad
