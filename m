Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA662BB80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiKPLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiKPLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:23:27 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA5C528B7;
        Wed, 16 Nov 2022 03:12:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlbsBr7rc8OfcI+j/7Yl3575Dw5PPq5XSFBE4Hf+xD1Bav5sgKQCbMJbGbjczQ7+NrqVaruKXhYfcaDVBTzlsj5wv1N3f8vL7SO+3VluJoI0Oh0sFo9gJPRoyB7SfsoAm5Z3IM/Z2xQFy7iDHjsrllJ/bUH/SgizepNiIBxnkRKCo2C3DQ2g/5STlK6+vojiWRqlwYHPWv9rtFgJ70w2RoPJzaiLxcIniKe0IiuDqrZ513GH3hUvbSvaAQ7bg9AK+YHut85reyddWhMK+3c+0Aj1XFvcB3Z0AUIK8F/ZtcqAhQE+/QoGC65mvr0ZKWc21bVEYINpvBZm4DjWepZunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BRIx+p7Kw1ZSKebjePDTdLG8VRamm659QJev2JT4+8=;
 b=TWnZNbMi0HHdvLU85sH27eGlgiF8oF6OujQAJowfYeeGVwAwzScq0wsj32gWL7OZmVbdIHoDrM+eYHUnxQVVoCc9rJo4wW1kJSrupYwCUfpPyYjP1RDlCUH8spcD7L/oxETS1bUQO3raWdwRQXZ9zcSclQS/lJ9EDjZTTt/oSqTfZ7aOHAjFaw1eFHhIil9HOLJuRQyoO5GXqoz9w22N0q58aPKw5bJcrw39yjBtFPMwAtQnCQXuJ3Q/Ifz4aKwUAEY58qeOpsLWKtbBMwHPvtIPyavJa3CYygU/3TnHMgkGa77YjqOB8KMIIDXR2jtfKki6ejk65csYgXzMWHIiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BRIx+p7Kw1ZSKebjePDTdLG8VRamm659QJev2JT4+8=;
 b=QvO2K35LCq6td5b6FTrIBhDi99Q7zJNToMb3zQrYhQYe3MaKzNxjxUcdTI0im3zWcBt6uc1Ho4fNzPFYSmtfwa+jCE73oijUV3iJ3RV1JTb4SDDVirD4fL//kvMlKMpeUgxsacje8Ayno4Pmayz1xqKBJHuPfb6T2iJCJLbdH+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:12:34 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%6]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 11:12:34 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
Date:   Wed, 16 Nov 2022 22:12:11 +0530
Message-Id: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PAXPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 08adb6b5-9cf8-4ca9-b4c2-08dac7c375f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9idtCjSFKk72+oTvlEzICBgANIjka+++SLrXSglBGpyRGWRoXZTy6wN/SvLoP3ft8JdXCYBm/X0QOGCqa1U7PeixaOm0CJOkqmuadLJcrKvfpa03eURgyIwTlI4LhnGLNsbqCNKBO++SY9nxEDSkLaL8LxBbLBAhOM7KRWF/FOulw/aKag0r+2QwnxWCDe4yWpKTqXdgTONWoDSK3jygq2/UvIgqIwsvZYzcPYC1YSsdOPKHLk6G3vSBoQcXWGepO9S5WTPbzWrvrw62YTFCks6bJofthHFTS3qSxWr+YvITpCQ8mCIs11HlPbhVBsuCfmZ/NxhhHprKzSbXURZTWquVOJ5TWmt+i41HTr7ZSjPOgqfoYeHUqR6yr9YerZ6UhF3f5VYTACV+XZAMFfhuw6FCIuCsyyBk8XkaqwhP0o3pM11pGS5NQ7W89gweZADfdk8LW2R2FQVTR1Vxl4y9I6JVpzAVoQ3CbTvQJh2ig7WmtbYSRad24bJVmRe+QVt+sFg+9gjHfK5oC10XXPH9XRuUAHT4UUUgjpcGvA/FVEwTeA1UEMn/IMuFGHmidXxuniJvTXm4OwWblq6nU6QoMzQ+j1eXIUAzj4M7tKgUvls0dgVNhyD7/kEuQTOzcJYcUHGAwpAo9zrbhZlxX8qqoW2mja7IsSsIgBQDC5aPqOGRjG8xDkFr3HA7nVMUp9UKTKttAu35ibGW/50ntyQj9qa8dhLWaCwR1rdXSdZoy5AsquHYW0MtUGNwMJOmonj5Po8JQ6f5t1Y3r1Ev7IaAJHu+KTMJ7fa2YeXwV6WgGjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(36756003)(38350700002)(478600001)(38100700002)(83380400001)(86362001)(30864003)(2616005)(2906002)(55236004)(26005)(6512007)(52116002)(6636002)(66946007)(6506007)(8936002)(6486002)(5660300002)(4326008)(8676002)(186003)(66476007)(41300700001)(66556008)(316002)(6666004)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNW4cEtUjPhyQ8NldpgwBuST4NGk7O73BkXVVheQbPvzMut02iXfqBExrdXA?=
 =?us-ascii?Q?93dcoBjmCB8AcZdBC3slEnZLmR4xO+u3PskMoYovA2pDxaJzyqRbedxi8PGa?=
 =?us-ascii?Q?FMpMJKzeq7r0r3AlQVsxxQMy1OWARTFxGFcbk+qH7GkaCgQzjH998XUAAvZi?=
 =?us-ascii?Q?rzcGes/cTTYLphZ2+ozIROJ6iqp5e/11OKPpa7p0YjeOrxn/P10pJ6iI0G5n?=
 =?us-ascii?Q?VOumTqEVJZYM9KEqOzao6t9WqE1Z1VifIM/THeRpcabFycPx2Z804sXNWXDn?=
 =?us-ascii?Q?lLWF8s5ahCSAly+Y6EyF9/J6hTHw7528/h7Rz77Sv2mw2Chy9+8JqwXnEAB0?=
 =?us-ascii?Q?CYLkRGl2yUuV5sNDBBruS16af8SnANJpByfN8oCUNOX5eprPYXpBx7eXPiky?=
 =?us-ascii?Q?zx3m6FSYhKXcogmHL1nIIlrA57EunNdm/mUBoCJ1yfG1dFzJKZRxv1I/gUP9?=
 =?us-ascii?Q?eLJ88eFYaReEfn2vC3r2qKwfZM2/59LryQ/+iex9ZjhbQzMABfSbT9ROXJ3P?=
 =?us-ascii?Q?OoL2PYiJ5MfaOJG3tYU8uMZ3jw+7pqwU1NibrqL5AzikUNGS5iorzgAWGrjT?=
 =?us-ascii?Q?Xmu7mNVpH940RUWgIu00gVIz69rIy2FWXYifIr4hTIjVwQmUWgVMhP7I1YYa?=
 =?us-ascii?Q?K3b8WwCsh1a3F/YarPMasHjwjHJXUlgoXen4sx+ZoSpNs72AGj0UAD5DCoOr?=
 =?us-ascii?Q?1Hc1y4mM79FQbLVtNOMT5gIOBJPcQ9DwoCH2sVXM4/MZqIDmtUVpUISdWnW/?=
 =?us-ascii?Q?Zzag/8J5hJ0TjTUysS2tvihM64bH96LRhY84JfLKuBbyVNEN/f3UGmlOpCNr?=
 =?us-ascii?Q?aS4FJ3MYkdNJ5s6UsVp4FA1IS5yL7MFKomGE1FxI284RDB3XVgdTRy5kW1ew?=
 =?us-ascii?Q?IRS4Fp87OIIISFNq/8atvAPflwmLcD1c+56swWsAbd5Jzyi61wwqcla9ewsx?=
 =?us-ascii?Q?4EyBEpeLjJcWHDGH1XYLa4u/+h9j6O+lyP+qouuztIi9TxmxNzqNdjcZ5sT1?=
 =?us-ascii?Q?TtQ3m6UCtg5ptdEZ9XvdUKa3hde/fw30y2F6/nmEJFqwTz1AvZ8HNnrFhlY7?=
 =?us-ascii?Q?VhC/dWm+0CEMDs3WXuoylsLuqeuSKxrNSFfKMqjsgr4dxZ35o4irDjKTmqrQ?=
 =?us-ascii?Q?QHu68NzMSRw/yBYdCNBkUW4U5Hzsap+heoCywMB8Qj1Cm+y8bqY2GcMYnKwM?=
 =?us-ascii?Q?okvKieBUl9XI4hDA7zHZ1fm1Zu4JWGGXjQdq9JUz0W4+2r+CHN/NzxQbYhH0?=
 =?us-ascii?Q?qPe7fOBZMHpDLBV5WSdL1Ta3uyOdxjNvFmHrf0c14a4MHzSIx+w8N92DM24d?=
 =?us-ascii?Q?pzmyKsWOYSGHuNcIlEd3n5WU0nEPmjDxR0dyoJzxn2NW/BaSOENsJLDYjdBI?=
 =?us-ascii?Q?VEcot7qr6YDIgBEwJKc4pa2+ppLUwSnIe4vNnm6LvNStr4/2A/+OyBObkG2v?=
 =?us-ascii?Q?0qjCEUdutldnZh/XKk9VUlRAVucJZkpga5j2Qb6ZjTMaa28vR+2BmfX1Uj/A?=
 =?us-ascii?Q?r6GlUh2wkxwet34p47H1cPGEl0DH0CjiJgxC6Smyx+Z7PGcpG31ysdK5v+l7?=
 =?us-ascii?Q?FnehletETz4VzTt7ObmQpEuIIsiPHkQz1VdTI4rD5XE58C2eDPV7ZVZKukHn?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08adb6b5-9cf8-4ca9-b4c2-08dac7c375f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:12:34.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2Hm0iSpumtUOi3ZUJ7vJH0ekRHVHAbFY2KFQPgpKkYT2GjObtHAkkxR5JL/7V0vbUSJqJ673IA/8iTpofLkAx41R5TAchBGew5I5A9bL2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8957
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added proprietary hci_uart driver code to the linux hci uart sub-system as
hci_nxp. This driver has Power Save feature that will put the NXP bluetooth
chip into sleep state, whenever there is no activity for certain duration
of time (2000ms), and will be woken up when any activity is to be
initiated.

This Power Save feature will be enabled by default and can be disabled and
re-enabled by the following set of commands:
hcitool -i hci0 cmd 3F 23 02 00 00    (disable Power Save)
hcitool -i hci0 cmd 3F 23 03 00 00    (enable Power Save)

The Power Save feature uses UART break signal by default as chip sleep and
wake-up source, and can be set with the following set of commands:
hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
hcitool -i hci0 cmd 3F 53 03 14 02 15    (set chip's GPIO[20] method)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 MAINTAINERS                   |   6 +
 drivers/bluetooth/Kconfig     |  10 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_nxp.c   | 763 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_nxp.h   | 118 +++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 7 files changed, 911 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_nxp.c
 create mode 100644 drivers/bluetooth/hci_nxp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e55a4d4..6b2c264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22591,6 +22591,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+NXP BLUETOOTH WIRELESS DRIVERS
+M:	amitkumar.karwar@nxp.com
+M:	neeraj.sanjaykale@nxp.com
+S:	Maintained
+F:	drivers/bluetooth/hci_nxp*
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 89b4d47..7f6d1dc 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -273,6 +273,16 @@ config BT_HCIUART_MRVL
 
 	  Say Y here to compile support for HCI MRVL protocol.
 
+config BT_HCIUART_NXP
+        bool "NXP protocol support"
+        depends on BT_HCIUART
+        help
+          NXP is serial protocol for communication between Bluetooth
+          device and host. This protocol is required for most NXP Bluetooth
+          devices with UART interface.
+
+          Say Y here to compile support for HCI NXP protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 3321a8a..bc80329 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -48,4 +48,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
+hci_uart-$(CONFIG_BT_HCIUART_NXP)	+= hci_nxp.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 865112e..f3c85c2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -882,6 +882,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_MRVL
 	mrvl_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_NXP
+	nxp_init();
+#endif
 
 	return 0;
 }
@@ -918,6 +921,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_MRVL
 	mrvl_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_NXP
+	nxp_deinit();
+#endif
 
 	tty_unregister_ldisc(&hci_uart_ldisc);
 }
diff --git a/drivers/bluetooth/hci_nxp.c b/drivers/bluetooth/hci_nxp.c
new file mode 100644
index 0000000..58911a1
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  Bluetooth HCI UART driver
+ *  Copyright 2018-2022 NXP
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+#include <asm/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+#include "hci_nxp.h"
+
+/** NXP Power Save Feature **/
+struct BT_CMD {
+	u16	ocf_ogf;
+	u8	length;
+	u8	data[4];
+} __packed;
+
+/* Power Save feature will be enabled and wakeup method will be break signal by default */
+int wakeupmode = WAKEUP_METHOD_BREAK;
+int ps_mode = PS_MODE_ENABLE;
+
+static int is_device_ready(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = NULL;
+
+	if (!hu) {
+		BT_ERR("hu is NULL");
+		return -ENODEV;
+	}
+	if (!hu->proto || !hu->hdev || !hu->tty) {
+		BT_ERR("Device not ready! proto=%p, hdev=%p, tty=%p", hu->proto, hu->hdev, hu->tty);
+		return -ENODEV;
+	}
+	hdev = hu->hdev;
+	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
+		BT_ERR("HCI_RUNNING is not set");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+/* Builds and sends an PS command packet */
+static int send_ps_cmd(u8 cmd, struct hci_uart *hu)
+{
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct BT_CMD *pcmd;
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCILL packet");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pcmd = (struct BT_CMD *)skb->data;
+	pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_AUTO_SLEEP_MODE;
+	pcmd->length = 1;
+	if (cmd ==  PS_MODE_ENABLE)
+		pcmd->data[0] = BT_PS_ENABLE;
+	else
+		pcmd->data[0] = BT_PS_DISABLE;
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
+	skb->dev = (void *)hu->hdev;
+
+	/* send packet */
+	hu->proto->enqueue(hu, skb);
+	hci_uart_tx_wakeup(hu);
+
+out:
+	return err;
+}
+
+/* Builds and sends an wake up method command packet */
+static int send_wakeup_method_cmd(u8 cmd, struct hci_uart *hu)
+{
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct BT_CMD *pcmd;
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCILL packet");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pcmd = (struct BT_CMD *)skb->data;
+	pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_WAKEUP_METHOD;
+	pcmd->length = 4;
+	pcmd->data[0] = BT_HOST_WAKEUP_METHOD_NONE;
+	pcmd->data[1] = BT_HOST_WAKEUP_DEFAULT_GPIO;
+	switch (cmd) {
+	case WAKEUP_METHOD_DTR:
+		pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_DSR;
+		break;
+	case WAKEUP_METHOD_BREAK:
+	default:
+		pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_BREAK;
+		break;
+	}
+	pcmd->data[3] = BT_CTRL_WAKEUP_DEFAULT_GPIO;
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+
+	skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
+	skb->dev = (void *)hu->hdev;
+
+	/* send packet */
+	hu->proto->enqueue(hu, skb);
+	hci_uart_tx_wakeup(hu);
+
+out:
+	return err;
+}
+
+void ps_timeout_func(struct timer_list *t)
+{
+	struct ps_data *data = from_timer(data, t, ps_timer);
+	struct tty_struct *tty = data->tty;
+	struct hci_uart *hu = NULL;
+
+	data->timer_on = 0;
+	if (!data->tty)
+		return;
+
+	hu = (struct hci_uart *)tty->disc_data;
+
+	if (!hu)
+		return;
+
+	if (test_bit(HCI_UART_SENDING, &hu->tx_state)) {
+		ps_start_timer(hu);
+	} else {
+		data->ps_cmd = PS_CMD_ENTER_PS;
+		schedule_work(&data->work);
+	}
+}
+
+static void set_dtr(struct tty_struct *tty, int on_off)
+{
+	u32 old_state = 0;
+	u32 new_state = 0;
+
+	if (TTY_FUNC->tiocmget) {
+		old_state = TTY_FUNC->tiocmget(tty);
+		if (on_off)
+			new_state = old_state | TIOCM_DTR;
+		else
+			new_state = old_state & ~TIOCM_DTR;
+		if (new_state == old_state)
+			return;
+		if (TTY_FUNC->tiocmset) {
+			if (on_off)
+				TTY_FUNC->tiocmset(tty, TIOCM_DTR, 0);  /* DTR ON */
+			else
+				TTY_FUNC->tiocmset(tty, 0, TIOCM_DTR);  /* DTR OFF */
+		}
+	}
+}
+
+static void set_break(struct tty_struct *tty, int on_off)
+{
+	if (TTY_FUNC->break_ctl) {
+		if (on_off)
+			TTY_FUNC->break_ctl(tty, -1); /* turn on break */
+		else
+			TTY_FUNC->break_ctl(tty, 0);  /* turn off break */
+	}
+}
+
+static int get_cts(struct tty_struct *tty)
+{
+	u32 state = 0;
+	int ret = -1;
+
+	if (TTY_FUNC->tiocmget) {
+		state = TTY_FUNC->tiocmget(tty);
+		if (state & TIOCM_CTS)
+			ret = 1;   /* CTS LOW */
+		else
+			ret = 0;   /* CTS HIGH */
+	}
+	return ret;
+}
+
+static void set_rts(struct tty_struct *tty, int on_off)
+{
+	u32 old_state = 0;
+	u32 new_state = 0;
+
+	if (TTY_FUNC->tiocmget) {
+		old_state = TTY_FUNC->tiocmget(tty);
+		if (on_off)
+			new_state = old_state | TIOCM_RTS;
+		else
+			new_state = old_state & ~TIOCM_RTS;
+		if (new_state == old_state)
+			return;
+		if (TTY_FUNC->tiocmset) {
+			if (on_off)
+				TTY_FUNC->tiocmset(tty, TIOCM_RTS, 0);    /* RTS ON */
+			else
+				TTY_FUNC->tiocmset(tty, 0, TIOCM_RTS);    /* RTS OFF */
+		}
+	}
+}
+
+static void ps_control(struct ps_data *data, u8 ps_state)
+{
+	struct hci_uart *hu = NULL;
+
+	if (data->ps_state == ps_state)
+		return;
+	if (data->tty) {
+		switch (data->cur_wakeupmode) {
+		case WAKEUP_METHOD_DTR:
+			if (ps_state == PS_STATE_AWAKE)
+				set_dtr(data->tty, 1);  /* DTR ON */
+			else
+				set_dtr(data->tty, 0);  /* DTR OFF */
+			data->ps_state = ps_state;
+			break;
+		case WAKEUP_METHOD_BREAK:
+			if (ps_state == PS_STATE_AWAKE)
+				set_break(data->tty, 0); /* break OFF */
+			else
+				set_break(data->tty, 1); /* break ON */
+			data->ps_state = ps_state;
+			break;
+		default:
+			break;
+		}
+		if (ps_state == PS_STATE_AWAKE) {
+			hu = (struct hci_uart *)data->tty->disc_data;
+			if (hu)
+				hci_uart_tx_wakeup(hu);
+		}
+	}
+}
+
+static void ps_work_func(struct work_struct *work)
+{
+	struct ps_data *data = container_of(work, struct ps_data, work);
+
+	if (data->tty) {
+		if (data->ps_cmd == PS_CMD_ENTER_PS && data->cur_psmode == PS_MODE_ENABLE)
+			ps_control(data, PS_STATE_SLEEP);
+		else  if (data->ps_cmd == PS_CMD_EXIT_PS)
+			ps_control(data, PS_STATE_AWAKE);
+	}
+}
+
+int ps_init_work(struct hci_uart *hu)
+{
+	struct ps_data *psdata = kzalloc(sizeof(*psdata), GFP_KERNEL);
+	struct nxp_struct *nxp = hu->priv;
+
+	if (!psdata) {
+		BT_ERR("Can't allocate control structure");
+		return -ENFILE;
+	}
+	nxp->psdata = psdata;
+
+	memset(psdata, 0, sizeof(*psdata));
+	psdata->interval = DEFAULT_TIME_PERIOD;
+	psdata->timer_on    = 0;
+	psdata->tty = NULL;
+	psdata->ps_state = PS_STATE_AWAKE;
+	psdata->ps_mode = ps_mode;
+	psdata->ps_cmd = 0;
+	psdata->send_cmd = 0;
+	switch (wakeupmode) {
+	case WAKEUP_METHOD_DTR:
+		psdata->wakeupmode =  WAKEUP_METHOD_DTR;
+		break;
+	case  WAKEUP_METHOD_BREAK:
+	default:
+		psdata->wakeupmode =  WAKEUP_METHOD_BREAK;
+		break;
+	}
+
+	psdata->cur_psmode = PS_MODE_DISABLE;
+	psdata->cur_wakeupmode = WAKEUP_METHOD_INVALID;
+
+	INIT_WORK(&psdata->work, ps_work_func);
+	return 0;
+}
+
+void ps_init_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	psdata->timer_on = 0;
+	psdata->tty = hu->tty;
+	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
+}
+
+void ps_start_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata->cur_psmode ==  PS_MODE_ENABLE) {
+		psdata->timer_on = 1;
+		mod_timer(&psdata->ps_timer, jiffies + (psdata->interval * HZ) / 1000);
+	}
+}
+
+void ps_cancel_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata) {
+		flush_scheduled_work();
+	if (psdata->timer_on)
+		del_timer(&psdata->ps_timer);
+	if (psdata->cur_psmode ==  PS_MODE_ENABLE &&
+	    psdata->cur_wakeupmode ==  WAKEUP_METHOD_BREAK) {
+		/* set_break off */
+		set_break(psdata->tty, 0);
+	}
+	psdata->tty = NULL;
+	kfree(psdata);
+	}
+}
+
+int ps_wakeup(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int ret = 1;
+
+	if (psdata->ps_state == PS_STATE_AWAKE)
+		ret = 0;
+	psdata->ps_cmd = PS_CMD_EXIT_PS;
+	schedule_work(&psdata->work);
+	return ret;
+}
+
+void ps_init(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int mode = 0;
+	struct ktermios old_termios;
+
+	if (!psdata || !psdata->tty)
+		return;
+	if (get_cts(psdata->tty) != 1) {
+		/* firmware is sleeping */
+		mode = psdata->cur_wakeupmode;
+		if (mode == WAKEUP_METHOD_INVALID)
+			mode =  wakeupmode;
+		switch (mode) {
+		case WAKEUP_METHOD_BREAK:
+			/* set RTS */
+			set_rts(psdata->tty, 1);
+			/* break on */
+			set_break(psdata->tty, 1);
+			/* break off */
+			set_break(psdata->tty, 0);
+			mdelay(5);
+			break;
+		case WAKEUP_METHOD_DTR:
+			/* set RTS */
+			set_rts(psdata->tty, 1);
+			set_dtr(psdata->tty, 0);
+			set_dtr(psdata->tty, 1);
+			mdelay(5);
+			break;
+		default:
+			break;
+		}
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag &= ~CRTSCTS;  /* Clear the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag |= CRTSCTS;  /* Enable the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+	}
+
+	psdata->send_cmd = 0;
+	if (!is_device_ready(hu)) {
+		if (psdata->cur_wakeupmode != psdata->wakeupmode) {
+			psdata->send_cmd |= SEND_WAKEUP_METHOD_CMD;
+			send_wakeup_method_cmd(psdata->wakeupmode, hu);
+		}
+		if (psdata->cur_psmode != psdata->ps_mode) {
+			psdata->send_cmd |= SEND_AUTO_SLEEP_MODE_CMD;
+			send_ps_cmd(psdata->ps_mode, hu);
+		}
+	}
+}
+
+void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_ev_cmd_complete *ev = NULL;
+	u8 event = hdr->evt;
+	u16 opcode;
+	u8 status = 0;
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (event == HCI_EV_CMD_COMPLETE) {
+		ev = (void *)(skb->data + sizeof(struct hci_event_hdr));
+		opcode = __le16_to_cpu(ev->opcode);
+		switch (opcode) {
+		case HCI_OP_AUTO_SLEEP_MODE:
+			status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
+			/* if hci_nxp has sent the command internally */
+			if (psdata->send_cmd) {
+				if (!status)
+					psdata->cur_psmode = psdata->ps_mode;
+				else
+					psdata->ps_mode = psdata->cur_psmode;
+				psdata->send_cmd &= ~SEND_AUTO_SLEEP_MODE_CMD;
+			} else {
+				if (!status)
+					psdata->cur_psmode = psdata->ps_mode;
+			}
+			if (psdata->cur_psmode == PS_MODE_ENABLE)
+				ps_start_timer(hu);
+			else
+				ps_wakeup(hu);
+			BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
+				status, psdata->cur_psmode);
+			break;
+		case HCI_OP_WAKEUP_METHOD:
+			status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
+			/* if hci_nxp has sent the command internally */
+			if (psdata->send_cmd) {
+				psdata->send_cmd &= ~SEND_WAKEUP_METHOD_CMD;
+				if (!status)
+					psdata->cur_wakeupmode = psdata->wakeupmode;
+				else
+					psdata->wakeupmode = psdata->cur_wakeupmode;
+			} else {
+				psdata->cur_wakeupmode = ev->ncmd;
+			}
+			BT_INFO("Set Wakeup Method response: status=%d, wakeupmode=%d",
+				status, psdata->cur_wakeupmode);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+/** NXP proto **/
+
+/* Initialize protocol */
+static int nxp_open(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp;
+
+	BT_DBG("hu %p", hu);
+
+	nxp = kzalloc(sizeof(*nxp), GFP_KERNEL);
+	if (!nxp)
+		return -ENOMEM;
+
+	skb_queue_head_init(&nxp->txq);
+
+	hu->priv = nxp;
+
+	if (ps_init_work(hu) == 0)
+		ps_init_timer(hu);
+
+	return 0;
+}
+
+/* Flush protocol data */
+static int nxp_flush(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&nxp->txq);
+
+	return 0;
+}
+
+/* Close protocol */
+static int nxp_close(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	ps_cancel_timer(hu);
+
+	skb_queue_purge(&nxp->txq);
+
+	kfree_skb(nxp->rx_skb);
+
+	hu->priv = NULL;
+	kfree(nxp);
+
+	return 0;
+}
+
+/* Enqueue frame for transmission (padding, crc, etc) */
+static int nxp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	struct BT_CMD *pcmd = (struct BT_CMD *)skb->data;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+		if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_AUTO_SLEEP_MODE)) {
+			if (pcmd->data[0] == BT_PS_ENABLE)
+				psdata->ps_mode = PS_MODE_ENABLE;
+			else if (pcmd->data[0] == BT_PS_DISABLE)
+				psdata->ps_mode = PS_MODE_DISABLE;
+		}
+	}
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	skb_queue_tail(&nxp->txq, skb);
+
+	return 0;
+}
+
+static const struct h4_recv_pkt nxp_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
+};
+
+static struct sk_buff *nxp_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+				    const unsigned char *buffer, int count,
+						const struct h4_recv_pkt *pkts,
+						int pkts_count)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	u8 alignment = hu->alignment ? hu->alignment : 1;
+
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
+	while (count) {
+		int i, len;
+
+		/* remove padding bytes from buffer */
+		for (; hu->padding && count > 0; hu->padding--) {
+			count--;
+			buffer++;
+		}
+		if (!count)
+			break;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
+
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
+				break;
+			}
+
+			/* Check for invalid packet type */
+			if (!skb)
+				return ERR_PTR(-EILSEQ);
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+
+		/* Check for partial packet */
+		if (skb->len < hci_skb_expect(skb))
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
+
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			default:
+				/* Unsupported variable length */
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
+			}
+
+			if (!dlen) {
+				hu->padding = (skb->len - 1) % alignment;
+				hu->padding = (alignment - hu->padding) % alignment;
+
+				/* No more data, complete frame */
+				if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
+					ps_check_event_packet(hu, skb);
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			hu->padding = (skb->len - 1) % alignment;
+			hu->padding = (alignment - hu->padding) % alignment;
+
+			/* Complete frame */
+			if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
+				ps_check_event_packet(hu, skb);
+			(&pkts[i])->recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
+
+static int nxp_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	ps_start_timer(hu);
+
+	nxp->rx_skb = nxp_recv_buf(hu->hdev, nxp->rx_skb, data, count,
+				   nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
+	if (IS_ERR(nxp->rx_skb)) {
+		int err = PTR_ERR(nxp->rx_skb);
+
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		nxp->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static struct sk_buff *nxp_dequeue(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	if (ps_wakeup(hu)) {
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		return 0;
+	}
+	ps_start_timer(hu);
+	return skb_dequeue(&nxp->txq);
+}
+
+static int nxp_setup(struct hci_uart *hu)
+{
+	ps_init(hu);
+	return 0;
+}
+
+static const struct hci_uart_proto nxpp = {
+	.id		= HCI_UART_NXP,
+	.name		= "NXP",
+	.open		= nxp_open,
+	.close		= nxp_close,
+	.recv		= nxp_recv,
+	.enqueue	= nxp_enqueue,
+	.dequeue	= nxp_dequeue,
+	.flush		= nxp_flush,
+	.setup		= nxp_setup,
+};
+
+int __init nxp_init(void)
+{
+	return hci_uart_register_proto(&nxpp);
+}
+
+int __exit nxp_deinit(void)
+{
+	return hci_uart_unregister_proto(&nxpp);
+}
diff --git a/drivers/bluetooth/hci_nxp.h b/drivers/bluetooth/hci_nxp.h
new file mode 100644
index 0000000..8cd0f3c
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  Bluetooth HCI UART driver
+ *  Copyright 2018-2022 NXP
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+#ifndef _HCI_NXP_H_
+#define _HCI_NXP_H_
+
+#define TTY_FUNC tty->ops
+
+struct ps_data {
+	u32    ps_mode;
+	u32    cur_psmode;
+	u32    ps_state;
+	u32    ps_cmd;
+	u32    interval;
+	u32    wakeupmode;
+	u32    cur_wakeupmode;
+	u32    send_cmd;
+	struct work_struct work;
+	struct tty_struct *tty;
+	struct timer_list ps_timer;
+	u32    timer_on;
+};
+
+struct nxp_struct {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct list_head        nxp_list_head;
+	unsigned char           id;
+	struct ps_data          *psdata;
+};
+
+/** Default ps timeout period in milli-second */
+#define DEFAULT_TIME_PERIOD     2000
+
+/** wakeup method DTR */
+#define WAKEUP_METHOD_DTR       0
+/** wakeup method break */
+#define WAKEUP_METHOD_BREAK     1
+/** wake up method EX break */
+#define WAKEUP_METHOD_EXT_BREAK  2
+/** wake up method RTS */
+#define WAKEUP_METHOD_RTS       3
+/** wakeup method invalid */
+#define  WAKEUP_METHOD_INVALID  0xff
+
+/** ps mode disable */
+#define PS_MODE_DISABLE         0
+/** ps mode enable */
+#define PS_MODE_ENABLE          1
+
+/** ps cmd exit ps  */
+#define PS_CMD_EXIT_PS          1
+/** ps cmd enter ps */
+#define PS_CMD_ENTER_PS         2
+
+/** ps state awake */
+#define PS_STATE_AWAKE          0
+/** ps state SLEEP */
+#define PS_STATE_SLEEP          1
+
+/** OGF */
+#define OGF				        0x3F
+/** Bluetooth command : Sleep mode */
+#define BT_CMD_AUTO_SLEEP_MODE		0x23
+/** Bluetooth command: Wakeup method */
+#define BT_CMD_WAKEUP_METHOD    0x53
+
+/** Bluetooth Power State : Enable */
+#define BT_PS_ENABLE			0x02
+/** Bluetooth Power State : Disable */
+#define BT_PS_DISABLE			0x03
+
+/** Bluetooth Host Wakeup Methods **/
+#define BT_HOST_WAKEUP_METHOD_NONE      0x00
+#define BT_HOST_WAKEUP_METHOD_DTR       0x01
+#define BT_HOST_WAKEUP_METHOD_BREAK     0x02
+#define BT_HOST_WAKEUP_METHOD_GPIO      0x03
+#define BT_HOST_WAKEUP_DEFAULT_GPIO     5
+
+/** Bluetooth Chip Wakeup Methods **/
+#define BT_CTRL_WAKEUP_METHOD_DSR       0x00
+#define BT_CTRL_WAKEUP_METHOD_BREAK     0x01
+#define BT_CTRL_WAKEUP_METHOD_GPIO      0x02
+#define BT_CTRL_WAKEUP_METHOD_EXT_BREAK  0x04
+#define BT_CTRL_WAKEUP_METHOD_RTS       0x05
+#define BT_CTRL_WAKEUP_DEFAULT_GPIO     4
+
+#define  HCI_OP_AUTO_SLEEP_MODE         0xfc23
+#define  HCI_OP_WAKEUP_METHOD           0xfc53
+
+/** send cmd flags **/
+#define SEND_WAKEUP_METHOD_CMD          0x01
+#define SEND_AUTO_SLEEP_MODE_CMD        0x02
+
+int ps_init_work(struct hci_uart *hu);
+void ps_init_timer(struct hci_uart *hu);
+void ps_start_timer(struct hci_uart *hu);
+void ps_cancel_timer(struct hci_uart *hu);
+int ps_wakeup(struct hci_uart *hu);
+void ps_init(struct hci_uart *hu);
+void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb);
+
+#endif /* _HCI_UART_H_ */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0..17d271c 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -20,7 +20,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	12
+#define HCI_UART_MAX_PROTO	13
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -34,6 +34,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -200,3 +201,8 @@ int ag6xx_deinit(void);
 int mrvl_init(void);
 int mrvl_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_NXP
+int nxp_init(void);
+int nxp_deinit(void);
+#endif
-- 
2.7.4

