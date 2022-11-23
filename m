Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA95635E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiKWMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiKWMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:52:09 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C087A4F;
        Wed, 23 Nov 2022 04:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJhWO6bx7zv66bjkiQ8X4xbLVIvBd/87xX7of1W7GrgHTL3h+WtrUcTMoqGNItuRhH6Or6WqDLG6zh/js8FIkoG8CB6wf2p1MtaGYfeDxTXYuSqAletcPFREvaYQixtOKS6O3nWz/dsdaK+c7ek0mp4igcK5DPrl3yjQaq9cF0JEGUL3M+8gWBNkchudaMhEeBSYhX0bQ6N1VpM6AiVhZr/CWS7V1W7AYOO75hdlvzYlXNjZgf0Do8goFWOW/imWH+UJERZBtGg1EF38TlPqaOnCn2qqrxJWLjLW67IAnAOvH+FQk/ACKSkcDBl0Trjr98xthb4S5PioAjfV0l+Lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CrhVxLzoL8F9TV+yqYQCITbPgZRXTGwR7NrV1vdFOE=;
 b=n1nU7EEVh1BRzyCPjWAbalxhV1WlCnuz1xQj013ZxHkhr9WXTsL3TKFyQDC0su9+Xh4mcEZvlIIEbSXZDJnLOOSmrQzc6vT8HiYxRWFHl3tX9NXF7KWovm8tTR9s4k9g+QL0NFyHVAf51xtAYMFms4TiGcQazHNBcwTruSlVbLeOsnpDfTAQ8AvhkanTY7EqCvdD0pBcrH0nbCwYAA/yBX1D7YGroEyBe1JyMWVUdqAGmwezf8YLx16R11xHPcdIm3vK48rqFCC5vf8bOKGAn0E+RJ/1U2L/Mzm+1AaNX4hDNh31Iw8iNbPZzzfbd2GB/75S2mC7l58n/PLaMxYJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CrhVxLzoL8F9TV+yqYQCITbPgZRXTGwR7NrV1vdFOE=;
 b=pU9ldDAeKG2vJLHy5xAKneRH06KGnFtQTaFeSKGq9hEvPWzkvzq2hGRXN3qhZLzIEtX2VV+0TXVsjPo5ygr79PSCk2N6JLdeWckrd8uTWwLZ4fhcu1wSvewBnbZyIamRTFbtqzw5vRoo3TmeVtLbr+pcWqAdHAtzUOUbTVvx+1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PA4PR04MB9344.eurprd04.prod.outlook.com (2603:10a6:102:2a8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:44:26 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 12:44:26 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
Date:   Wed, 23 Nov 2022 18:13:33 +0530
Message-Id: <1669207413-9637-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PA4PR04MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 406573f0-e19a-47e0-38bc-08dacd506d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4LdfI8Gk5W8oFgBbNflyvujxz17KRIcWp0UySjHpFKfOs/SGsroXbEg8ohmgnX2amv4JwBTxSjD4MBi/C+XYz3H7LuTv4Lv7v16VjlAnLra3nInLUfdYYICwqSaj/7lzcHAxbIw55pcR33xL+kUYH3boLZ3+AxFw6C160ptLvuq26FWhYfpR2Vyw8UD+00nsc+UpxbvzB6aSWY+cdNl8TPhmS7UVlZZmJTVfevjJRgES/NLY3/XOVhRCz/cy64INUxYvSpPC9Zv91buw1S5Wyig5ijn/GAK2Vt0W2q5RQm4JqIgW8Iw5AcP4wbpCML71afYQpR+qfiUmn/Boh5pyj4PMjlxW7xY/3ETeLYZZqR1+oXgbeFYNzaWFgDEt7txAP98w2hZQ0CWYMmE4ZWeGjS34+XdVVcx6RFoKqPyzfhPlf4+AnjyQcNx8DNGhjm1HkW9yTB1fE232RrPHEEFUTkjU0fwIR/M8mfwAD5uD0YsUIjG1yH+DrFUVdr4M3HBW8lJa1RXYRm1Kg6ssC2XROOqXVwowu/JbdfmGjIgZzKSd4gx22FXrhf41szjC6gYDtbUfxTn8LjoBihBuKMCwstE4eYfO4O6jetjBYF/aT1bj9J2d08tt+Lvk+6r5Yqpe/+U0U+Dq+7csXkDpx+Zw8f3KqytazjkM3i3vl+qe6i1qnBWZItkxfcBgyZEdDokiFlt+kenNAuP1Jb5+ZqY5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(6486002)(4326008)(38100700002)(38350700002)(5660300002)(86362001)(26005)(8936002)(66946007)(6506007)(66476007)(2906002)(66556008)(41300700001)(8676002)(30864003)(186003)(6512007)(2616005)(55236004)(316002)(52116002)(6666004)(83380400001)(6636002)(478600001)(36756003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AuetxWFeZzUb7s6FPAphavpUMb4b4ghBf6TbFn3OMDTSq0eYC6FAL/qkaqsy?=
 =?us-ascii?Q?0VeAYYNAi/QRmiDEPAhO6mPFhfk3QRvfYxLN240fnpWh8pbnBRQaPeHvUQp8?=
 =?us-ascii?Q?sRctA+XjCMrFlilMJK9pP4dR0PcmwchFEmz5M6/m5csHMkWWj6geJzxaxej2?=
 =?us-ascii?Q?KvdxA6hutSg8P0tWLLx2v6r+AG+dExn7msfGGem4QJOqH5//42kVyO0ti2Qn?=
 =?us-ascii?Q?qO7v8mRlXm5EQUgnqOepMmmpSSjO9+7PEIdxts6TnmOxYs6NpJ4zECp5uZci?=
 =?us-ascii?Q?jsyiuZrx0kSrlzjOzVBUwUqtOszNLDdo2IBrqmnKFISG31/beBagxV7sCwov?=
 =?us-ascii?Q?76zJjLJXs1PTYZHwNp+8VPdb8V1+7UH265oS3QqRM9PAyY8MWiqzveiIEbMe?=
 =?us-ascii?Q?fHs6eeADYaHBsaUcA+9IGli13g1Ey30cCVjzT4c4iQI2phmV/5KIgZAbmtxj?=
 =?us-ascii?Q?oIBSV8udx/zoPdjTXSmkihUDqHtljWCvHxGX+jHYbJtWHPVvi0HT5L1+A0kD?=
 =?us-ascii?Q?1R9yXy6CuxJvpUmTM41xqM1SB5BAYK6DV/V6lxYr+xRwMUqP7UISAbOlrgG/?=
 =?us-ascii?Q?k0u+rcNmjuNZTvycSnOp1Xr1DWoM3W2pGII+MEQPKWJ7HXiNIxm2EvRnGFuO?=
 =?us-ascii?Q?1IcvdsLWLTqJ3CSQEQF/ae4dODQ1clDRQaooQKpJ8BcT+Wn5GhBLu3j6l2yg?=
 =?us-ascii?Q?sd7+n9HYLLrlmYD06JXfaYnKGxp+idZRUCszTYoAZHggQqYwXtpKrLb1zu3F?=
 =?us-ascii?Q?+rtS+saLlib6BXYLU+N3c/2mMEGc145Bz/mIk/YRIiTWBSM5ixgZ2veRU+n2?=
 =?us-ascii?Q?PB1vniqcPkOxFNyDpIAjbrASK99kMmlkfv6gYZAiYHrhq8lFIhTIQ+z4j3oH?=
 =?us-ascii?Q?5RLpdoT5o7LfHnI+LFyRTSLH9zsPEzz2Q8xfB9zvDSaE0a9fWaVe9VE/lez8?=
 =?us-ascii?Q?XB5ORjqgZwg0EaqyRKKMOP7DQt7Thp3c61bjFk4DajTUURpBANyf4pLkfJcL?=
 =?us-ascii?Q?ejkBvyu2s9rehmOq8wV1pr7+TwPi/ypXJR3WoAMoCR9xASBaX9ou9sdkaDuw?=
 =?us-ascii?Q?XvUxXeUO6lzeWaX8rDFlZwcJPCKw7CKjhjMN8XYjn6wy8lJ6ZpLMQZNXvNfK?=
 =?us-ascii?Q?cckwJHypOiBwsRfX3DsmpIcLEqzcKtmas+SWoZQTegPNNw7gV7/NxGI5gcAx?=
 =?us-ascii?Q?h/xixa4u4tnkvZq9yTH0kcJnYge1tGlgO2k9EvfLtUbdfWX9U9kTEhf15Lxe?=
 =?us-ascii?Q?QCO3OKDR+oop/3gY8Ga2yvSM4ANQlyXlGUweFyNy9gri8u3mki92lvXAJVHx?=
 =?us-ascii?Q?X4VVzexGlssjUT9RiojSj+kLDRrjwMZ6QbBuy1ObKKu5ED+lZ4bfUpOrn20e?=
 =?us-ascii?Q?cJViR8+SLayE8jUM9JqFuFtGuUDh0Sleay1sJjA/OGnxY2tJc7LfvK5YtaL2?=
 =?us-ascii?Q?8txcSVGHqN+sl/wzZlK9RkhbpYK/OLmArNIhvFgMh36l2NvDlEyJv+Gex3J7?=
 =?us-ascii?Q?Yl4wQELjHSmy7TY3QdYcaLpWhozZ4TN7kit7I1Ic0In/qNLkaNqGjlQxyYSQ?=
 =?us-ascii?Q?8av4Lgikldo3wjCyUs8MJw7GCkg3t+MTlAS7EKLB/WheH31LU0GvN0hKSKYv?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406573f0-e19a-47e0-38bc-08dacd506d05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:44:26.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnj8ZHds+hD1IDL1tU3WZ5xrV267eYmCE0+sy3onT0iVV9HvDapJRktEfXne5+VW9BfCa2/h4FjpidaspFkkZ8WrJaXdhuWDnR/SeZczZRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hci_nxp to the hci_uart module which adds support for the NXP BT
chips. This driver has Power Save feature that will put the NXP bluetooth
chip into sleep state, whenever there is no activity for certain duration
of time (2000ms), and will be woken up when any activity is to be
initiated.

The Power Save feature can (optionally) be configured with the following
set of commands:
hcitool -i hci0 cmd 3F 23 02 00 00    (disable Power Save)
hcitool -i hci0 cmd 3F 23 03 00 00    (enable Power Save)
where,
OGF = 0x3F (vendor specific command)
OCF = 0x23 (command to set Power Save state)
arg[0] = 0x02 (disable Power Save)
arg[0] = 0x03 (enable Power Save)
arg[1,2,...] = XX (don't care)

The sleep/wake-up source can be configured with the following set
of commands:
hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
where,
OGF = 0x3F (vendor specific command)
OCF = 0x53 (command to set sleep and wake-up source)
arg[0] = 0x00 (Chip to host method NONE)
arg[0] = 0x01 (Chip to host method UART DTR)
arg[0] = 0x02 (Chip to host method UART BREAK)
arg[0] = 0x03 (Chip to host method GPIO)
arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
arg[2] = 0x00 (Host to chip method UART DSR)
arg[2] = 0x01 (Host to chip method UART BREAK)
arg[3] = 0xXX (Reserved for future use)

By default, the hci_nxp sets power save enable, chip to host wake-up
source as GPIO and host to chip sleep and wake-up source as UART
break during driver initialization, by sending the respective
commands to the chip.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Changed the subject/summary lines and added more details in the description. (Paul Menzel)
v3: Made internal functions static, optimized the code, added few comments. (Sherry Sun)
---
 MAINTAINERS                   |   6 +
 drivers/bluetooth/Kconfig     |  10 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_nxp.c   | 764 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_nxp.h   | 110 ++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 7 files changed, 904 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_nxp.c
 create mode 100644 drivers/bluetooth/hci_nxp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e55a4d4..70f802d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22591,6 +22591,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+NXP BLUETOOTH WIRELESS DRIVERS
+M:	Amitkumar Karwar <amitkumar.karwar@nxp.com>
+M:	Neeraj Kale <neeraj.sanjaykale@nxp.co>m
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
index 0000000..1508edd
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.c
@@ -0,0 +1,764 @@
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
+/* Builds and sends a PS command packet to chip */
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
+/* Builds and sends an wake up method command packet to chip */
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
+	pcmd->data[3] = 0xFF;
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
+static void ps_start_timer(struct hci_uart *hu)
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
+static void ps_timeout_func(struct timer_list *t)
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
+
+	if (data->tty) {
+		switch (data->cur_wakeupmode) {
+		case WAKEUP_METHOD_DTR:
+			if (ps_state == PS_STATE_AWAKE)
+				set_dtr(data->tty, 1);  /* DTR ON */
+			else
+				set_dtr(data->tty, 0);  /* DTR OFF */
+			break;
+		case WAKEUP_METHOD_BREAK:
+			if (ps_state == PS_STATE_AWAKE)
+				set_break(data->tty, 0); /* break OFF */
+			else
+				set_break(data->tty, 1); /* break ON */
+			break;
+		default:
+			break;
+		}
+		data->ps_state = ps_state;
+
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
+static int ps_init_work(struct hci_uart *hu)
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
+static void ps_init_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	psdata->timer_on = 0;
+	psdata->tty = hu->tty;
+	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
+}
+
+static void ps_cancel_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata) {
+		flush_scheduled_work();
+	if (psdata->timer_on)
+		del_timer(&psdata->ps_timer);
+	if (psdata->cur_psmode == PS_MODE_ENABLE) {
+		switch (psdata->cur_wakeupmode) {
+		case WAKEUP_METHOD_BREAK:
+			set_break(psdata->tty, 0);	/* set_break off */
+			break;
+		case WAKEUP_METHOD_DTR:
+			set_dtr(psdata->tty, 1);	/* dtr on */
+			break;
+		default:
+			break;
+		}
+	}
+	psdata->tty = NULL;
+	kfree(psdata);
+	}
+}
+
+static int ps_wakeup(struct hci_uart *hu)
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
+static void ps_init(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int mode = 0;
+	struct ktermios old_termios;
+
+	if (!psdata || !psdata->tty)
+		return;
+	if (get_cts(psdata->tty) != 1) {
+		/* CTS is not low, chip is either sleeping */
+		/* or flow control is not enabled */
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag &= ~CRTSCTS;  /* Clear the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag |= CRTSCTS;  /* Enable the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+
+		/* Wake up the chip */
+		mode = psdata->cur_wakeupmode;
+		if (mode == WAKEUP_METHOD_INVALID)
+			mode =  wakeupmode;
+		switch (mode) {
+		case WAKEUP_METHOD_BREAK:
+			set_rts(psdata->tty, 1);	/* set RTS */
+			set_break(psdata->tty, 1);	/* break on */
+			set_break(psdata->tty, 0);	/* break off */
+			mdelay(5);
+			break;
+		case WAKEUP_METHOD_DTR:
+			set_rts(psdata->tty, 1);	/* set RTS */
+			set_dtr(psdata->tty, 0);	/* dtr off */
+			set_dtr(psdata->tty, 1);	/* dtr on */
+			mdelay(5);
+			break;
+		default:
+			break;
+		}
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
+static void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb)
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
+			if (!status)
+				psdata->cur_psmode = psdata->ps_mode;
+			else
+				psdata->ps_mode = psdata->cur_psmode;
+			/* if driver has sent the command internally */
+			if (psdata->send_cmd)
+				psdata->send_cmd &= ~SEND_AUTO_SLEEP_MODE_CMD;
+			if (psdata->cur_psmode == PS_MODE_ENABLE)
+				ps_start_timer(hu);
+			else
+				ps_wakeup(hu);
+			BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
+				status, psdata->cur_psmode);
+			break;
+		case HCI_OP_WAKEUP_METHOD:
+			status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
+			if (!status)
+				psdata->cur_wakeupmode = psdata->wakeupmode;
+			else
+				psdata->wakeupmode = psdata->cur_wakeupmode;
+			/* if driver has sent the command internally */
+			if (psdata->send_cmd)
+				psdata->send_cmd &= ~SEND_WAKEUP_METHOD_CMD;
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
+		if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_WAKEUP_METHOD))
+			psdata->wakeupmode = pcmd->data[2];
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
index 0000000..0ed5158
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.h
@@ -0,0 +1,110 @@
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

