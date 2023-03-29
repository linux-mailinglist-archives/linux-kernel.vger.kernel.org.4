Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBFB6CF015
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjC2RER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC2REQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:04:16 -0400
X-Greylist: delayed 1560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 10:04:14 PDT
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA12108;
        Wed, 29 Mar 2023 10:04:14 -0700 (PDT)
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TFRUIs009647;
        Wed, 29 Mar 2023 10:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=gUjLDCf7RH1rMUv6TdadxaQY5SbhrkMkOq+zEASda9M=;
 b=x7bxKXqA/CwxH1vIZgZX9x65tpLfawMLzs4ydCo/AxDNwZEjTjyRfAdw4XT3U8onvpx0
 HjZ56GFcw1kvCv4dfx9/bbb4aSzrsIBR5d5BbZH2j4/BEyr2gJKwx+FA+JU3fkr6Z69l
 EG0eX1d4oivauvzPl4G/lzYFzOT+2DWSI4F44uMFWsgG2rjDiFVB1miIHWMKF4Yh8TO1
 lzRAX/LgIWK0zynnVi6Qf8/i1O00BTA1ctoIEeXtScRBdGjQV75v3wn40N2aD/NN/KJK
 b8xfcqFRBINVegWpFaX2kJcmLbT7OMrfZpKo27xe+OwS0EibCD38Hv40bKAdO4UBd1dj Gw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3phwx17dgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 10:44:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLW2WRt/Ql/40WVmranjwjW5ovl4smd4DUvjUu8KIqKid16kdGkuB8FbcPYEz6YuC3eFHrmGTSLqaCW70ZWK+LD/95dwVLv5/jq7F19UZ4nbuwYYGWcTH/2B591DsdUVK/mroVCaOzG6ynLhT78I0UiljPierC/TamwSPCS3JIelYcx6Yaznc4yPYR5K2S2lGRdMm41NJlrbeRXmY8c8w8LoY90qDTSt7ppX8aIW9TLAZcL1ZIaBQYkaGiv/g7ohnLCbh/jbxMO18tIh5pj/K2Slpe7JuefBkDZ8+3etUUv1SALrjsRz3ZynSJHAYnh9GlsxAPUarBN1pKEk9JyuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUjLDCf7RH1rMUv6TdadxaQY5SbhrkMkOq+zEASda9M=;
 b=Ri6iqjdR4lj/qv/7L9h2yUPMR9Bc01OYHndWk6leJGNDDBWlpG49mM2OAyV0UU3ObXzh6CdhsLTIOBp4qcMiR1RxvWMCt0jHAcU8go7Cr8V0lhwvi+AlX77zfxrHzAVc4hhw4UpAatQd5t4zZ2yAwCnd42ShHC3a7AygMnNM7+WQu3tfkuWhjN1O3j7bKEDD2ylkWDEDaVPFL+OnukDV1YMG1Job39v9gmvLXyKzPRI3WJgWcNDBxcnDvxOlBc6WmI4WoG5y7R8AecLMPTANvVBaOT9mQ9/yrddoA5zZDzyvQl2TQZpu487DfGXuaW91VDmZbzesz/zRKdmog1HIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUjLDCf7RH1rMUv6TdadxaQY5SbhrkMkOq+zEASda9M=;
 b=tEZT1rqkDQX9SJDnmMUg2irAyC3PI33MZrbAkCNOEMfx4vxlAo18EqiI6oanyu8cjEFLEUnPAdcQ8/i4Neh7HcvnXvQPTpIVNTrYqOasmn0fMa//9rlvWvtH/X15yc8hvElnAM+QW8c/4878mgsEoGPafF492zDPWhrAI/RuQyY=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM8PR04MB8021.namprd04.prod.outlook.com (2603:10b6:8:f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Wed, 29 Mar 2023 15:44:11 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%6]) with mapi id 15.20.6222.029; Wed, 29 Mar 2023
 15:44:11 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Date:   Wed, 29 Mar 2023 10:42:35 -0500
Message-Id: <20230329154235.615349-3-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329154235.615349-1-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::23) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM8PR04MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 7626b50a-a247-4a5d-b423-08db306c70ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+hahHdSDt1j/qUUh7xeTpdWtIddbaMugtE8q5jQBjZCAnyMBVd4iYfhZeT8sqDIczAyAl0KZ99Yndt/TaTNw9+bGSVPHhM3H58NnXu3fTnEq28ZnSq0L9o4A0a5z+4ereEz1X7GRhYMDy5F2iDmjo2cvTX1TenEHqDyxJaw+2iNforXOLNJrlUgUClJI1/Amwk0tTvVHSFeVj7C3B8p0gIfWHY9Wnq/g+vO1x2njHUnkwKaV4rEp2SScH66zV3eQsDpnpQCZQ9GSVVlgbdnHGRNfQ/d+mn+ObguhhqFiAjM1DWDwq+NAD2RWaGCgFv2LhxvamTkT2QMlMNXWjwML55LIqUJo+PJyc4cfWZXYyC+APbMQfBfmF5qQ1gAGxWVYHyIdu+uaqEIJ2OwdpO0ah18R8JpUyS9ieghWyWhGZJjQyl1mvR2g4z70gNKIwUngwXiHdIlQ2pwpyGzKxweu40E1EYZe2TcadMkwHJEFhINYswUkZL8QV1bOdvX4Exjti6qYD1K17s0Q8XgejVEOldHaya9oy5OvMRXX7hv3o38JtQUe2ilVBD9IPf1v4QItQyUq6dDFToZ3CraRdjQB9+UYfnxcRovH20wmyz5xHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(109986019)(2906002)(2616005)(83380400001)(6512007)(8676002)(66946007)(66476007)(4326008)(66556008)(478600001)(54906003)(1076003)(316002)(26005)(6506007)(186003)(6666004)(44832011)(30864003)(36756003)(38100700002)(86362001)(41300700001)(5660300002)(6486002)(8936002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6cXLykuIM8MN4IEoisvM9vF1skWqN/6rP/XxRlyTmSijxUW48A2xFiIECz6?=
 =?us-ascii?Q?MxqXE6wjI6OFAefHIWYh0aA+G0oG2za9CVjjgj1bjJYjPJ+ANnlKSaUgHRgy?=
 =?us-ascii?Q?9woySDvLjAA//IVJ9mzZT4XFWSquJGbrTLQSCLGBadbZ5Oits2xYmeVKqU+R?=
 =?us-ascii?Q?h1kA1+zV4AWH4v5nufWrLZLR7yst5iyVkShQDCgn0IvNYTa2LqIKl0kgF67Y?=
 =?us-ascii?Q?rn7z0SQjjSdE5lEKjVsdrpsdny7/ACrHXkR0n8fGq8vqoVzYSAX1HhJof0Oj?=
 =?us-ascii?Q?g1O74n9L7A45jwLIPDkObmaf+vjAjawhqjZSJPEi4LZbZmQL4VuA2O1oQONf?=
 =?us-ascii?Q?4ObXwXkN1UeJc4Mds7H0mUSkBF8JCOpYeS9B7KsKclXJhyKdzndh75eyaiOg?=
 =?us-ascii?Q?URWwHh37mIc4zyyak7NjfKA4Dv0enuLkhGCmnoNpoZmHFVK+VjARo2nPnEVR?=
 =?us-ascii?Q?sJSF09i6uH73gNlXHr9/oTrnzO656kieeoz5gB7HSExmygFKCGtcypdQKony?=
 =?us-ascii?Q?yq1slOYBNj/GexoFg9Yf99i10lXqEU3zQp2RHFew9Hmb6ipEd6UjKGad2OsV?=
 =?us-ascii?Q?Ry4+uLfu2Iy50WsNDBFUh8ZIJKJMcWGu/AEbD4hhNgvrMuFeDXmnIQekcvmN?=
 =?us-ascii?Q?haRcXkOdys25v0KnkrcAhexs4Lp5+jjRxwV2ANF8VJJI/bBTEYZPtanYvKAo?=
 =?us-ascii?Q?JkPX7dHgf9LVawoh/Z50YUaZhrtZAWt/+0Vj4Pm4h4RMNnBuZXn9oiOXPlQA?=
 =?us-ascii?Q?HHFfG28hP4/kWzGVlKA7RIMq59Dg637mG1ZCVPllAJL4NjUXKEiL1UlTKxuR?=
 =?us-ascii?Q?G5gsY9CK8Gl5eLujcxAAkXPhdGf6EhLV/4RWL89497q57WPDLsFZKzpl/zFq?=
 =?us-ascii?Q?n75+kNZWVvyCI1BRXnBebLBVLcZ+xoMTegH+PKzBQxoLHp4vfwcJKniPqQ++?=
 =?us-ascii?Q?2rXMNukP1P0+DJiY1kUyP9RF+x+LAcGCXIweeGiR7NXu2y/aJkIWqGgd1Dzd?=
 =?us-ascii?Q?Px/kwX2EU6LjqC0eO4hTHc4HkD4gF46wrxkq3K1gmCXzZTG8rbPmFmY+1Xf5?=
 =?us-ascii?Q?mfCl3++kVH/xyzt+PPEA0Uhj0GfT94H37OtLiPt//qORKnuMqR3uk7KDsIAo?=
 =?us-ascii?Q?MRupAcXb68v0nh/SjClov4TkLjatHPTXfFK42yeqJpxY6LaQPIviQRV7Gmbb?=
 =?us-ascii?Q?5OaiQkk28oCiEp1MvN9TIbrMT/tB9SXEr1C6k9vwOAImHD6IdgwKb5lK3tqU?=
 =?us-ascii?Q?AF79cW+J+jQTsvHkeBEbBCOo5bdonvomPhtmWmsF1ZoyGeNveXvhXN4Y9xie?=
 =?us-ascii?Q?igXTZ9SV9fA7wzq9yEmF6scMRMtQ5+YuJVpSyOIxF4HWPiKx9sbc5wUqMA9C?=
 =?us-ascii?Q?VrO1twtIZEiAZtvJArHC9k5Fy5sgdXJFFi3fR+h/07sAZRYxHv3dLLwBy6Ph?=
 =?us-ascii?Q?X70/Q8WCpFSQxNlSPZKj2KOFOoyXRIwC8VW73tXWCtNlocpCXA57a039ksXz?=
 =?us-ascii?Q?wg2s2v2Da8SoQGLofVryX6x1LDDploxhQTigxRJO+jH88w4bdnpPuSdQYuMN?=
 =?us-ascii?Q?BJfdlRHtzPrJ8NfnaPtyDKENcZF/Ad030lfysNj1?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7626b50a-a247-4a5d-b423-08db306c70ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:44:10.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9bfyQyxPCNt6g26WSmqafNomn58ssHo7lJXv1lqQcs7RkFiI1P54dwi+ajTj1Z1QTyW8h38bJBqY3EGn12EzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8021
X-Proofpoint-GUID: 8AAqt5vbtYIv9SHRRIexveUgsynGEauS
X-Proofpoint-ORIG-GUID: 8AAqt5vbtYIv9SHRRIexveUgsynGEauS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_09,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290124
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The National Instruments (NI) 16550 is a 16550-like UART with larger
FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
patch adds a driver that can operate this UART, which is used for
onboard serial ports in several NI embedded controller designs.

Portions of this driver were originally written by Jaeden Amero and
Karthik Manamcheri, with extensive cleanups and refactors since.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Jason Smith <jason.smith@ni.com>
---
 MAINTAINERS                       |   7 +
 drivers/tty/serial/8250/8250_ni.c | 447 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |   9 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 464 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab595b2a..c5283a7385fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14322,6 +14322,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
 F:	drivers/mtd/nand/
 F:	include/linux/mtd/*nand*.h
 
+NATIONAL INSTRUMENTS SERIAL DRIVER
+M:	Brenda Streiff <brenda.streiff@ni.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/ni,ni16550.yaml
+F:	drivers/tty/serial/8250/8250_ni.c
+
 NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
new file mode 100644
index 000000000000..8bd9768576a7
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NI 16550 UART Driver
+ *
+ * The National Instruments (NI) 16550 is a UART that is compatible with the
+ * TL16C550C and OX16C950B register interfaces, but has additional functions
+ * for RS-485 transceiver control. This driver implements support for the
+ * additional functionality on top of the standard serial8250 core.
+ *
+ * Copyright 2012-2023 National Instruments Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+
+#include "8250.h"
+
+/* Extra bits in UART_ACR */
+#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
+
+/* TFS - TX FIFO Size */
+#define NI16550_TFS_OFFSET	0x0C
+/* RFS - RX FIFO Size */
+#define NI16550_RFS_OFFSET	0x0D
+
+/* PMR - Port Mode Register */
+#define NI16550_PMR_OFFSET	0x0E
+/* PMR[1:0] - Port Capabilities */
+#define NI16550_PMR_CAP_MASK			0x03
+#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
+#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
+#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
+#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */
+/* PMR[4] - Interface Mode */
+#define NI16550_PMR_MODE_MASK			0x10
+#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
+#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */
+
+/* PCR - Port Control Register */
+#define NI16550_PCR_OFFSET	0x0F
+#define NI16550_PCR_RS422			0x00
+#define NI16550_PCR_ECHO_RS485			0x01
+#define NI16550_PCR_DTR_RS485			0x02
+#define NI16550_PCR_AUTO_RS485			0x03
+#define NI16550_PCR_WIRE_MODE_MASK		0x03
+#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
+#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
+
+/* flags for ni16550_device_info */
+#define NI_HAS_PMR		BIT(0)
+
+struct ni16550_device_info {
+	unsigned int uartclk;
+	uint8_t prescaler;
+	unsigned int flags;
+};
+
+struct ni16550_data {
+	int line;
+};
+
+static int ni16550_enable_transceivers(struct uart_port *port)
+{
+	uint8_t pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_disable_transceivers(struct uart_port *port)
+{
+	uint8_t pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_rs485_config(struct uart_port *port,
+				struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	uint8_t pcr;
+	struct uart_8250_port *up = container_of(port, struct uart_8250_port,
+						 port);
+
+	/* "rs485" should be given to us non-NULL. */
+	if (WARN_ON(rs485 == NULL))
+		return -EINVAL;
+
+	pcr = serial_in(up, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* RS-485 */
+		dev_vdbg(port->dev, "2-wire Auto\n");
+		pcr |= NI16550_PCR_AUTO_RS485;
+		up->acr |= NI16550_ACR_AUTO_DTR_EN;
+	} else {
+		/* RS-422 */
+		dev_vdbg(port->dev, "4-wire\n");
+		pcr |= NI16550_PCR_RS422;
+		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
+	}
+
+	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
+	serial_out(up, NI16550_PCR_OFFSET, pcr);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return 0;
+}
+
+static bool is_pmr_rs232_mode(struct uart_8250_port *up)
+{
+	uint8_t pmr = serial_in(up, NI16550_PMR_OFFSET);
+
+	/*
+	 * If the PMR is not implemented, then by default NI UARTs are
+	 * connected to RS-485 transceivers
+	 */
+	if ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_NOT_IMPL)
+		return false;
+
+	if ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_CAP_DUAL)
+		/*
+		 * If the port is dual-mode capable, then read the mode bit
+		 * to know the current mode
+		 */
+		return ((pmr & NI16550_PMR_MODE_MASK)
+					== NI16550_PMR_MODE_RS232);
+	else
+		/*
+		 * If it is not dual-mode capable, then decide based on the
+		 * capability
+		 */
+		return ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_CAP_RS232);
+}
+
+static void ni16550_config_prescaler(struct uart_8250_port *up,
+				     uint8_t prescaler)
+{
+	/*
+	 * Page in the Enhanced Mode Registers
+	 * Sets EFR[4] for Enhanced Mode.
+	 */
+	uint8_t lcr_value;
+	uint8_t efr_value;
+
+	lcr_value = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr_value = serial_in(up, UART_EFR);
+	efr_value |= UART_EFR_ECB;
+
+	serial_out(up, UART_EFR, efr_value);
+
+	/* Page out the Enhanced Mode Registers */
+	serial_out(up, UART_LCR, lcr_value);
+
+	/* Set prescaler to CPR register. */
+	serial_out(up, UART_SCR, UART_CPR);
+	serial_out(up, UART_ICR, prescaler);
+}
+
+static const struct serial_rs485 ni16550_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+};
+
+static void ni16550_rs485_setup(struct uart_port *port)
+{
+	port->rs485_config = ni16550_rs485_config;
+	port->rs485_supported = ni16550_rs485_supported;
+	/*
+	 * The hardware comes up by default in 2-wire auto mode and we
+	 * set the flags to represent that
+	 */
+	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+}
+
+static int ni16550_port_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	return ni16550_enable_transceivers(port);
+}
+
+static void ni16550_port_shutdown(struct uart_port *port)
+{
+	ni16550_disable_transceivers(port);
+
+	serial8250_do_shutdown(port);
+}
+
+static int ni16550_get_regs(struct platform_device *pdev,
+			    struct uart_port *port)
+{
+	struct resource *regs;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		port->iotype = UPIO_PORT;
+		port->iobase = regs->start;
+
+		return 0;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (regs) {
+		port->iotype  = UPIO_MEM;
+		port->mapbase = regs->start;
+		port->mapsize = resource_size(regs);
+		port->flags   |= UPF_IOREMAP;
+
+		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
+					     port->mapsize);
+		if (!port->membase)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	dev_err(&pdev->dev, "no registers defined\n");
+	return -EINVAL;
+}
+
+static int ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
+{
+	/*
+	 * Very old implementations don't have the TFS or RFS registers
+	 * defined, so we may read all-0s or all-1s. For such devices,
+	 * assume a FIFO size of 128.
+	 */
+	int value = serial_in(uart, reg);
+
+	if (value == 0x00 || value == 0xFF)
+		return 128;
+
+	return value;
+}
+
+static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	mctrl |= UART_MCR_CLKSEL;
+
+	serial8250_do_set_mctrl(port, mctrl);
+}
+
+static int ni16550_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = {};
+	struct ni16550_data *data;
+	const struct ni16550_device_info *info;
+	int ret = 0;
+	int irq;
+	int rs232_property = 0;
+	unsigned int prescaler;
+	const char *transceiver;
+	int txfifosz, rxfifosz;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&uart.port.lock);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = ni16550_get_regs(pdev, &uart.port);
+	if (ret < 0)
+		return ret;
+
+	/* early setup so that serial_in()/serial_out() work */
+	serial8250_set_defaults(&uart);
+
+	info = device_get_match_data(dev);
+
+	uart.port.dev		= dev;
+	uart.port.irq		= irq;
+	uart.port.irqflags	= IRQF_SHARED;
+	uart.port.flags		|= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.startup	= ni16550_port_startup;
+	uart.port.shutdown	= ni16550_port_shutdown;
+
+	/*
+	 * Hardware instantiation of FIFO sizes are held in registers.
+	 */
+	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
+	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
+
+	dev_dbg(dev, "NI 16550 has TX FIFO size %d, RX FIFO size %d\n",
+		txfifosz, rxfifosz);
+
+	uart.port.type		= PORT_16550A;
+	uart.port.fifosize	= txfifosz;
+	uart.tx_loadsz		= txfifosz;
+	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
+	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
+
+	/*
+	 * OF device-tree and NIC7A69 ACPI can declare clock-frequency,
+	 * but may be missing for other instantiations, so this is optional.
+	 * If present, override what we've defined in this driver.
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
+	if (!uart.port.uartclk) {
+		dev_err(dev, "unable to determine clock frequency!\n");
+		return -ENODEV;
+	}
+
+	if (info->prescaler)
+		prescaler = info->prescaler;
+	device_property_read_u32(dev, "clock-prescaler", &prescaler);
+
+	if (prescaler != 0) {
+		uart.port.set_mctrl = ni16550_set_mctrl;
+		ni16550_config_prescaler(&uart, (uint8_t)prescaler);
+	}
+
+	/*
+	 * The determination of whether or not this is an RS-485 or RS-232 port
+	 * can come from the "transceiver" device property (if present), or it
+	 * can come from the PMR (if it is present), and otherwise we're solely
+	 * an RS-485 port.
+	 */
+	if (!device_property_read_string(dev, "transceiver", &transceiver)) {
+		rs232_property = strncmp(transceiver, "RS-232", 6) == 0;
+
+		dev_dbg(dev, "port is in %s mode (via device property)",
+			(rs232_property ? "RS-232" : "RS-485"));
+	} else if (info->flags & NI_HAS_PMR) {
+		rs232_property = is_pmr_rs232_mode(&uart);
+
+		dev_dbg(dev, "port is in %s mode (via PMR)",
+			(rs232_property ? "RS-232" : "RS-485"));
+	} else {
+		rs232_property = 0;
+
+		dev_dbg(dev, "port is fixed as RS-485");
+	}
+
+	if (!rs232_property) {
+		/*
+		 * Neither the 'transceiver' property nor the PMR indicate
+		 * that this is an RS-232 port, so it must be an RS-485 one.
+		 */
+		ni16550_rs485_setup(&uart.port);
+	}
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		return ret;
+
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int ni16550_remove(struct platform_device *pdev)
+{
+	struct ni16550_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static const struct ni16550_device_info ni16550_default = { };
+
+static const struct of_device_id ni16550_of_match[] = {
+	{ .compatible = "ni,ni16550", .data = &ni16550_default },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ni16550_of_match);
+
+/* NI 16550 RS-485 Interface */
+static const struct ni16550_device_info nic7750 = {
+	.uartclk = 33333333,
+};
+
+/* NI CVS-145x RS-485 Interface */
+static const struct ni16550_device_info nic7772 = {
+	.uartclk = 1843200,
+	.flags = NI_HAS_PMR,
+};
+
+/* NI cRIO-904x RS-485 Interface */
+static const struct ni16550_device_info nic792b = {
+	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
+	.uartclk = 25000000,
+	.prescaler = 0x09,
+};
+
+/* NI sbRIO 96x8 RS-232/485 Interfaces */
+static const struct ni16550_device_info nic7a69 = {
+	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
+	.uartclk = 29629629,
+	.prescaler = 0x09,
+};
+
+static const struct acpi_device_id ni16550_acpi_match[] = {
+	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
+	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
+	{ "NIC792B",	(kernel_ulong_t)&nic792b },
+	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
+
+static struct platform_driver ni16550_driver = {
+	.driver = {
+		.name = "ni16550",
+		.of_match_table = ni16550_of_match,
+		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
+	},
+	.probe = ni16550_probe,
+	.remove = ni16550_remove,
+};
+
+module_platform_driver(ni16550_driver);
+
+MODULE_AUTHOR("Jaeden Amero <jaeden.amero@ni.com>");
+MODULE_AUTHOR("Karthik Manamcheri <karthik.manamcheri@ni.com>");
+MODULE_DESCRIPTION("NI 16550 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..c0f3aec51d13 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -565,6 +565,15 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_NI
+	tristate "NI 16550 based serial port"
+	depends on SERIAL_8250
+	help
+	  This driver supports the integrated serial ports on National
+          Instruments (NI) controller hardware. This is required for all NI
+          controller models with onboard RS-485 or dual-mode RS-485/RS-232
+          ports.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 4fc2fc1f41b6..58dc1b5ff054 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
+obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.30.2

