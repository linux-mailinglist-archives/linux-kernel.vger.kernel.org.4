Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D57201FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjFBMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjFBMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:22:39 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255881B0;
        Fri,  2 Jun 2023 05:22:36 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35232TIU029264;
        Fri, 2 Jun 2023 03:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=NCwP+lQ7nwSw6NGWDLCOZnrx//UA6OUJmWII/CRbWc8=;
 b=FHBBJN/mav4W+IQOJdzy//vdVG3gKLC3HY5Bc9nV4wg9tvSHFQHISQf2dVSRUJHtuHxp
 cGdMJp4iiasFiM2RjAOEB+t2VSKhnjsJ8yhLeu57eC7GPjKEnHJ+Ppd8mgx9dFjESrjG
 JeCi1MZktj8NhB/ljxZthnpL4qE0NfnNnI1ymeaLfdr14e6gLQjwhUmw9Qq9fsbpVGDB
 XWodXzjR1SYV7k20LXlyb/wXztCzoIEL/YMJMWmT23J7zZLViKh+mHlll64NlOo7PdrY
 Tb23uX5cqoZRj8yj6hJiQJvBltBJIIyhuhfFJiIX/rCYPq/jLXHjXtw15nzSD9vsWIe2 ug== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qxx5n3e83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIkE6HYeN21t+hXwM4RsWQg6ILTiBfgjIu4hksUYWFzVRwSd30IDxH703AdG+KkhaJYf8aPaqvERcQU523GyP29C+YjpSEIhKOTvVxtsjL2luKyj8RNtpJrOsTdeTXt/dMFH0QT/ZFd5F91lHfkorNToo6oFL8/rXqSO+ZpsZSGPd7Cey85ysFRjxMpzYnsyv8ZWvik7+0PqHZzPcktwrnNQ1dXiZvWSopnTnaGOcoCcMLg200osmrcItCFDNmwVhQcuPrwJME/5zcUeBThieP8SogviC1fhYxozAzjxx+OFr7ea3wedae4a0KoC0wC4BndRlq6fJYz5GLKkdnDa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCwP+lQ7nwSw6NGWDLCOZnrx//UA6OUJmWII/CRbWc8=;
 b=SZ/aEP1IWsXL2JOUqU3vJ+XRLKse9mJsLRJc5zVDotgccX7Rc9nPUBS9I/564gc7L/a2wKVUXbbCQMZU+osve4uXtZgIHO2KogXtl523O/Gv4n8+lfR07cz51eeqgU8RL/UCQIHlOvPlSO216j1TYSrP5NitAQsfRiwealf4hpa9vKzeKVVS1Ck8nlTZdnnKzjpYXK505zQIp0d+4YoXvQl6y2BOHU97yBuLTmbYr17G7hd7niIyDLGjJjQ5GbyPF81vSMDlR0VYma0jKCMHOdk2SYAF4PoXKGL6rYDybPmDMS9vgSCGIK0ggDxz7pQBT+Fth1Pb355MxoqkGTMAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCwP+lQ7nwSw6NGWDLCOZnrx//UA6OUJmWII/CRbWc8=;
 b=hN+GLpQgtE1GFj6YKGsfW7NkqyFzkMwa0pjTg7GdRsdhrD9XzL4btQN7T5IaCKdVgCdKjYYX5+GV8cmvBWW308pcP9riJL6fK+iiKAjuWhsRxqnoyNwBsvB83HTYzG45dXR4CGx3iZIj0M+JNWT7YBIBgvPTLipJb0ru7uQgybo=
Received: from DM6PR06CA0006.namprd06.prod.outlook.com (2603:10b6:5:120::19)
 by PH0PR07MB9681.namprd07.prod.outlook.com (2603:10b6:510:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 10:27:12 +0000
Received: from DM6NAM12FT102.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::5d) by DM6PR06CA0006.outlook.office365.com
 (2603:10b6:5:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 10:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT102.mail.protection.outlook.com (10.13.178.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.12 via Frontend Transport; Fri, 2 Jun 2023 10:27:11 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 352AR60e007697
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 03:27:07 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Jun 2023 12:27:06 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Fri, 2 Jun 2023 12:27:06 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 352AR64j077917;
        Fri, 2 Jun 2023 06:27:06 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 352AR66f077916;
        Fri, 2 Jun 2023 06:27:06 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 1/4] usb: cdns2: Device side header file for CDNS2 driver
Date:   Fri, 2 Jun 2023 06:26:41 -0400
Message-ID: <20230602102644.77470-2-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230602102644.77470-1-pawell@cadence.com>
References: <20230602102644.77470-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT102:EE_|PH0PR07MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f36443a-8cf3-43a4-eba8-08db6353ed2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dgeFhIcQPzGmHZF7esRUs/pxNFVNawAtsJ59NsgBaSlzQ2pzhwMrVmvb5wnBbPQMjF6ofX6MtgLYRPYVGVmxbQL7kOvJXRtNHXK8QnewGZYuehKfgUc6dVTZaF9Nbn+7BvHCC1CZ8sxy0GhQakJIeDMkHBOXM1uJ4K/TldPR/oSAAvFvU/t8YnDjvPCJnjROrjTj66mQg/rDqkWTqe1m9Q/LBYeZRfCYwnSkoqmyLdJV6AJUGkMXyTW/4/00zu0rUhANyZWJKIlfAs0JJH87XVKBrtneNvlMfs9rQsVGv2l0C1Bgkjx9InyGExuoFhJTtDBvTlraWr2C3kPZvT9ikZv5ox+NJkFjnJxR2wUkrUgJ2yjxjFKOx/tBJyaS1PBOTBg4qwQj2YwJPXaPIGd7T0shNBVrUxz/12i2sva6HBOum+176SIxY9xs3eKr85cxRmCLkvdO9v0XsxM5oHErADQT6L7TYYj+qLNwbBPK/WyB5tghtNPi3LsfG7kYPesK2YtFzk59PV7s9LtTI3JzG8Zf+v2/lR2FjQpRGjBR/G2xufZ6EZx3+KzlKB9N3eELvf1mlzdaqs5bfzO7zZZ53tw3752FNx4rk1c9hsVppqsWrtXkIqGMHeF3k+w3/U7DhjOYPfdDDHTay8fDWieP7Xwe9cVuhwsH4/WlZmmQr560e5fAN4SGPoQL7mJ48kC3AsOrBm7ydVmB6nTbCZc5SLLNvgky9sPh+U6H+/YBUA1u3PXtx4QUIEOXYbNn0DKFiw1u5Qvnx6ytN4/j/sGjk5u17bCp2OmXLe82F8EwBI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36092001)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(2616005)(83380400001)(47076005)(30864003)(186003)(36860700001)(4326008)(6916009)(70586007)(316002)(478600001)(42186006)(70206006)(6666004)(54906003)(8676002)(2906002)(7416002)(107886003)(1076003)(5660300002)(26005)(8936002)(41300700001)(40480700001)(7636003)(356005)(36756003)(82740400003)(82310400005)(86362001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 10:27:11.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f36443a-8cf3-43a4-eba8-08db6353ed2d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT102.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9681
X-Proofpoint-ORIG-GUID: eVFR09iEH2v5D_lPuwXhUJ4E-UZGat-3
X-Proofpoint-GUID: eVFR09iEH2v5D_lPuwXhUJ4E-UZGat-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 mlxlogscore=722 impostorscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch defines macros, registers and structures used by
Device side driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h | 707 ++++++++++++++++++++
 1 file changed, 707 insertions(+)
 create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
new file mode 100644
index 000000000000..71e2f62d653a
--- /dev/null
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
@@ -0,0 +1,707 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * USBHS-DEV device controller driver header file
+ *
+ * Copyright (C) 2023 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#ifndef __LINUX_CDNS2_GADGET
+#define __LINUX_CDNS2_GADGET
+
+#include <linux/usb/gadget.h>
+#include <linux/dma-direction.h>
+
+/*
+ * USBHS register interface.
+ * This corresponds to the USBHS Device Controller Interface.
+ */
+
+/**
+ * struct cdns2_ep0_regs - endpoint 0 related registers.
+ * @rxbc: receive (OUT) 0 endpoint byte count register.
+ * @txbc: transmit (IN) 0 endpoint byte count register.
+ * @cs: 0 endpoint control and status register.
+ * @reserved1: reserved.
+ * @fifo: 0 endpoint fifo register.
+ * @reserved2: reserved.
+ * @setupdat: SETUP data register.
+ * @reserved4: reserved.
+ * @maxpack: 0 endpoint max packet size.
+ */
+struct cdns2_ep0_regs {
+	__u8 rxbc;
+	__u8 txbc;
+	__u8 cs;
+	__u8 reserved1[4];
+	__u8 fifo;
+	__le32 reserved2[94];
+	__u8 setupdat[8];
+	__u8 reserved4[88];
+	__u8 maxpack;
+} __packed __aligned(4);
+
+/* EP0CS - bitmasks. */
+/* Endpoint 0 stall bit for status stage. */
+#define EP0CS_STALL	BIT(0)
+/* HSNAK bit. */
+#define EP0CS_HSNAK	BIT(1)
+/* IN 0 endpoint busy bit. */
+#define EP0CS_TXBSY_MSK	BIT(2)
+/* OUT 0 endpoint busy bit. */
+#define EP0CS_RXBSY_MSK	BIT(3)
+/* Send STALL in the data stage phase. */
+#define EP0CS_DSTALL	BIT(4)
+/* SETUP buffer content was changed. */
+#define EP0CS_CHGSET	BIT(7)
+
+/* EP0FIFO - bitmasks. */
+/* Direction. */
+#define EP0_FIFO_IO_TX	BIT(4)
+/* FIFO auto bit. */
+#define EP0_FIFO_AUTO	BIT(5)
+/* FIFO commit bit. */
+#define EP0_FIFO_COMMIT	BIT(6)
+/* FIFO access bit. */
+#define EP0_FIFO_ACCES	BIT(7)
+
+/**
+ * struct cdns2_epx_base - base endpoint registers.
+ * @rxbc: OUT endpoint byte count register.
+ * @rxcon: OUT endpoint control register.
+ * @rxcs: OUT endpoint control and status register.
+ * @txbc: IN endpoint byte count register.
+ * @txcon: IN endpoint control register.
+ * @txcs: IN endpoint control and status register.
+ */
+struct cdns2_epx_base {
+	__le16 rxbc;
+	__u8 rxcon;
+	__u8 rxcs;
+	__le16 txbc;
+	__u8 txcon;
+	__u8 txcs;
+} __packed __aligned(4);
+
+/* rxcon/txcon - endpoint control register bitmasks. */
+/* Endpoint buffering: 0 - single buffering ... 3 - quad buffering. */
+#define EPX_CON_BUF		GENMASK(1, 0)
+/* Endpoint type. */
+#define EPX_CON_TYPE		GENMASK(3, 2)
+/* Endpoint type: isochronous. */
+#define EPX_CON_TYPE_ISOC	0x4
+/* Endpoint type: bulk. */
+#define EPX_CON_TYPE_BULK	0x8
+/* Endpoint type: interrupt. */
+#define EPX_CON_TYPE_INT	0xC
+/* Number of packets per microframe. */
+#define EPX_CON_ISOD		GENMASK(5, 4)
+#define EPX_CON_ISOD_SHIFT	0x4
+/* Endpoint stall bit. */
+#define EPX_CON_STALL		BIT(6)
+/* Endpoint enable bit.*/
+#define EPX_CON_VAL		BIT(7)
+
+/* rxcs/txcs - endpoint control and status bitmasks. */
+/* Data sequence error for the ISO endpoint. */
+#define EPX_CS_ERR(p)		((p) & BIT(0))
+
+/**
+ * struct cdns2_epx_regs - endpoint 1..15 related registers.
+ * @reserved: reserved.
+ * @ep: none control endpoints array.
+ * @reserved2: reserved.
+ * @endprst: endpoint reset register.
+ * @reserved3: reserved.
+ * @isoautoarm: ISO auto-arm register.
+ * @reserved4: reserved.
+ * @isodctrl: ISO control register.
+ * @reserved5: reserved.
+ * @isoautodump: ISO auto dump enable register.
+ * @reserved6: reserved.
+ * @rxmaxpack: receive (OUT) Max packet size register.
+ * @reserved7: reserved.
+ * @rxstaddr: receive (OUT) start address endpoint buffer register.
+ * @reserved8: reserved.
+ * @txstaddr: transmit (IN) start address endpoint buffer register.
+ * @reserved9: reserved.
+ * @txmaxpack: transmit (IN) Max packet size register.
+ */
+struct cdns2_epx_regs {
+	__le32 reserved[2];
+	struct cdns2_epx_base ep[15];
+	__u8 reserved2[290];
+	__u8 endprst;
+	__u8 reserved3[41];
+	__le16 isoautoarm;
+	__u8 reserved4[10];
+	__le16 isodctrl;
+	__le16 reserved5;
+	__le16 isoautodump;
+	__le32 reserved6;
+	__le16 rxmaxpack[15];
+	__le32 reserved7[65];
+	__le32 rxstaddr[15];
+	__u8 reserved8[4];
+	__le32 txstaddr[15];
+	__u8 reserved9[98];
+	__le16 txmaxpack[15];
+} __packed __aligned(4);
+
+/* ENDPRST - bitmasks. */
+/* Endpoint number. */
+#define ENDPRST_EP	GENMASK(3, 0)
+/* IN direction bit. */
+#define ENDPRST_IO_TX	BIT(4)
+/* Toggle reset bit. */
+#define ENDPRST_TOGRST	BIT(5)
+/* FIFO reset bit. */
+#define ENDPRST_FIFORST	BIT(6)
+/* Toggle status and reset bit. */
+#define ENDPRST_TOGSETQ	BIT(7)
+
+/**
+ * struct cdns2_interrupt_regs - USB interrupt related registers.
+ * @reserved: reserved.
+ * @usbirq: USB interrupt request register.
+ * @extirq: external interrupt request register.
+ * @rxpngirq: external interrupt request register.
+ * @reserved1: reserved.
+ * @usbien: USB interrupt enable register.
+ * @extien: external interrupt enable register.
+ * @reserved2: reserved.
+ * @usbivect: USB interrupt vector register.
+ */
+struct cdns2_interrupt_regs {
+	__u8 reserved[396];
+	__u8 usbirq;
+	__u8 extirq;
+	__le16 rxpngirq;
+	__le16 reserved1[4];
+	__u8 usbien;
+	__u8 extien;
+	__le16 reserved2[3];
+	__u8 usbivect;
+} __packed __aligned(4);
+
+/* EXTIRQ and EXTIEN - bitmasks. */
+/* VBUS fault fall interrupt. */
+#define EXTIRQ_VBUSFAULT_FALL BIT(0)
+/* VBUS fault fall interrupt. */
+#define EXTIRQ_VBUSFAULT_RISE BIT(1)
+/* Wake up interrupt bit. */
+#define EXTIRQ_WAKEUP	BIT(7)
+
+/* USBIEN and USBIRQ - bitmasks. */
+/* SETUP data valid interrupt bit.*/
+#define USBIRQ_SUDAV	BIT(0)
+/* Start-of-frame interrupt bit. */
+#define USBIRQ_SOF	BIT(1)
+/* SETUP token interrupt bit. */
+#define USBIRQ_SUTOK	BIT(2)
+/* USB suspend interrupt bit. */
+#define USBIRQ_SUSPEND	BIT(3)
+/* USB reset interrupt bit. */
+#define USBIRQ_URESET	BIT(4)
+/* USB high-speed mode interrupt bit. */
+#define USBIRQ_HSPEED	BIT(5)
+/* Link Power Management interrupt bit. */
+#define USBIRQ_LPM	BIT(7)
+
+#define USB_IEN_INIT (USBIRQ_SUDAV | USBIRQ_SUSPEND | USBIRQ_URESET \
+		      | USBIRQ_HSPEED | USBIRQ_LPM)
+/**
+ * struct cdns2_usb_regs - USB controller registers.
+ * @reserved: reserved.
+ * @lpmctrl: LPM control register.
+ * @lpmclock: LPM clock register.
+ * @reserved2: reserved.
+ * @endprst: endpoint reset register.
+ * @usbcs: USB control and status register.
+ * @frmnr: USB frame counter register.
+ * @fnaddr: function Address register.
+ * @clkgate: clock gate register.
+ * @fifoctrl: FIFO control register.
+ * @speedctrl: speed Control register.
+ * @sleep_clkgate: sleep Clock Gate register.
+ * @reserved3: reserved.
+ * @cpuctrl: microprocessor control register.
+ */
+struct cdns2_usb_regs {
+	__u8 reserved[4];
+	__u16 lpmctrl;
+	__u8 lpmclock;
+	__u8 reserved2[411];
+	__u8 endprst;
+	__u8 usbcs;
+	__le16 frmnr;
+	__u8 fnaddr;
+	__u8 clkgate;
+	__u8 fifoctrl;
+	__u8 speedctrl;
+	__u8 sleep_clkgate;
+	__u8 reserved3[533];
+	__u8 cpuctrl;
+} __packed __aligned(4);
+
+/* LPMCTRL - bitmasks. */
+/* BESL (Best Effort Service Latency). */
+#define LPMCTRLLL_HIRD		GENMASK(7, 4)
+/* Last received Remote Wakeup field from LPM Extended Token packet. */
+#define LPMCTRLLH_BREMOTEWAKEUP	BIT(8)
+/* Reflects value of the lpmnyet bit located in the usbcs[1] register. */
+#define LPMCTRLLH_LPMNYET	BIT(16)
+
+/* LPMCLOCK - bitmasks. */
+/*
+ * If bit is 1 the controller automatically turns off clock
+ * (utmisleepm goes to low), else the microprocessor should use
+ * sleep clock gate register to turn off clock.
+ */
+#define LPMCLOCK_SLEEP_ENTRY	BIT(7)
+
+/* USBCS - bitmasks. */
+/* Send NYET handshake for the LPM transaction. */
+#define USBCS_LPMNYET		BIT(2)
+/* Remote wake-up bit. */
+#define USBCS_SIGRSUME		BIT(5)
+/* Software disconnect bit. */
+#define USBCS_DISCON		BIT(6)
+/* Indicates that a wakeup pin resumed the controller. */
+#define USBCS_WAKESRC		BIT(7)
+
+/* FIFOCTRL - bitmasks. */
+/* Endpoint number. */
+#define FIFOCTRL_EP		GENMASK(3, 0)
+/* Direction bit. */
+#define FIFOCTRL_IO_TX		BIT(4)
+/* FIFO auto bit. */
+#define FIFOCTRL_FIFOAUTO	BIT(5)
+/* FIFO commit bit. */
+#define FIFOCTRL_FIFOCMIT	BIT(6)
+/* FIFO access bit. */
+#define FIFOCTRL_FIFOACC	BIT(7)
+
+/* SPEEDCTRL - bitmasks. */
+/* Device works in Full Speed. */
+#define SPEEDCTRL_FS		BIT(1)
+/* Device works in High Speed. */
+#define SPEEDCTRL_HS		BIT(2)
+/* Force FS mode. */
+#define SPEEDCTRL_HSDISABLE	BIT(7)
+
+/* CPUCTRL- bitmasks. */
+/* Controller reset bit. */
+#define CPUCTRL_SW_RST		BIT(1)
+
+/**
+ * struct cdns2_adma_regs - ADMA controller registers.
+ * @conf: DMA global configuration register.
+ * @sts: DMA global Status register.
+ * @reserved1: reserved.
+ * @ep_sel: DMA endpoint select register.
+ * @ep_traddr: DMA endpoint transfer ring address register.
+ * @ep_cfg: DMA endpoint configuration register.
+ * @ep_cmd: DMA endpoint command register.
+ * @ep_sts: DMA endpoint status register.
+ * @reserved2: reserved.
+ * @ep_sts_en: DMA endpoint status enable register.
+ * @drbl: DMA doorbell register.
+ * @ep_ien: DMA endpoint interrupt enable register.
+ * @ep_ists: DMA endpoint interrupt status register.
+ * @axim_ctrl: AXI Master Control register.
+ * @axim_id: AXI Master ID register.
+ * @reserved3: reserved.
+ * @axim_cap: AXI Master Wrapper Extended Capability.
+ * @reserved4: reserved.
+ * @axim_ctrl0: AXI Master Wrapper Extended Capability Control Register 0.
+ * @axim_ctrl1: AXI Master Wrapper Extended Capability Control Register 1.
+ */
+struct cdns2_adma_regs {
+	__le32 conf;
+	__le32 sts;
+	__le32 reserved1[5];
+	__le32 ep_sel;
+	__le32 ep_traddr;
+	__le32 ep_cfg;
+	__le32 ep_cmd;
+	__le32 ep_sts;
+	__le32 reserved2;
+	__le32 ep_sts_en;
+	__le32 drbl;
+	__le32 ep_ien;
+	__le32 ep_ists;
+	__le32 axim_ctrl;
+	__le32 axim_id;
+	__le32 reserved3;
+	__le32 axim_cap;
+	__le32 reserved4;
+	__le32 axim_ctrl0;
+	__le32 axim_ctrl1;
+};
+
+#define CDNS2_ADMA_REGS_OFFSET	0x400
+
+/* DMA_CONF - bitmasks. */
+/* Reset USB device configuration. */
+#define DMA_CONF_CFGRST		BIT(0)
+/* Singular DMA transfer mode.*/
+#define DMA_CONF_DSING		BIT(8)
+/* Multiple DMA transfers mode.*/
+#define DMA_CONF_DMULT		BIT(9)
+
+/* DMA_EP_CFG - bitmasks. */
+/* Endpoint enable. */
+#define DMA_EP_CFG_ENABLE	BIT(0)
+
+/* DMA_EP_CMD - bitmasks. */
+/* Endpoint reset. */
+#define DMA_EP_CMD_EPRST	BIT(0)
+/* Transfer descriptor ready. */
+#define DMA_EP_CMD_DRDY		BIT(6)
+/* Data flush. */
+#define DMA_EP_CMD_DFLUSH	BIT(7)
+
+/* DMA_EP_STS - bitmasks. */
+/* Interrupt On Complete. */
+#define DMA_EP_STS_IOC		BIT(2)
+/* Interrupt on Short Packet. */
+#define DMA_EP_STS_ISP		BIT(3)
+/* Transfer descriptor missing. */
+#define DMA_EP_STS_DESCMIS	BIT(4)
+/* TRB error. */
+#define DMA_EP_STS_TRBERR	BIT(7)
+/* DMA busy bit. */
+#define DMA_EP_STS_DBUSY	BIT(9)
+/* Current Cycle Status. */
+#define DMA_EP_STS_CCS(p)	((p) & BIT(11))
+/* OUT size mismatch. */
+#define DMA_EP_STS_OUTSMM	BIT(14)
+/* ISO transmission error. */
+#define DMA_EP_STS_ISOERR	BIT(15)
+
+/* DMA_EP_STS_EN - bitmasks. */
+/* OUT transfer missing descriptor enable. */
+#define DMA_EP_STS_EN_DESCMISEN	BIT(4)
+/* TRB enable. */
+#define DMA_EP_STS_EN_TRBERREN	BIT(7)
+/* OUT size mismatch enable. */
+#define DMA_EP_STS_EN_OUTSMMEN	BIT(14)
+/* ISO transmission error enable. */
+#define DMA_EP_STS_EN_ISOERREN	BIT(15)
+
+/* DMA_EP_IEN - bitmasks. */
+#define DMA_EP_IEN(index)	(1 << (index))
+#define DMA_EP_IEN_EP_OUT0	BIT(0)
+#define DMA_EP_IEN_EP_IN0	BIT(16)
+
+/* DMA_EP_ISTS - bitmasks. */
+#define DMA_EP_ISTS(index)	(1 << (index))
+#define DMA_EP_ISTS_EP_OUT0	BIT(0)
+#define DMA_EP_ISTS_EP_IN0	BIT(16)
+
+#define gadget_to_cdns2_device(g) (container_of(g, struct cdns2_device, gadget))
+#define ep_to_cdns2_ep(ep) (container_of(ep, struct cdns2_endpoint, endpoint))
+
+/*-------------------------------------------------------------------------*/
+#define TRBS_PER_SEGMENT	600
+#define ISO_MAX_INTERVAL	8
+#define MAX_TRB_LENGTH		BIT(16)
+#define MAX_ISO_SIZE		3076
+/*
+ * To improve performance the TRB buffer pointers can't cross
+ * 4KB boundaries.
+ */
+#define TRB_MAX_ISO_BUFF_SHIFT	12
+#define TRB_MAX_ISO_BUFF_SIZE	BIT(TRB_MAX_ISO_BUFF_SHIFT)
+/* How much data is left before the 4KB boundary? */
+#define TRB_BUFF_LEN_UP_TO_BOUNDARY(addr) (TRB_MAX_ISO_BUFF_SIZE - \
+					((addr) & (TRB_MAX_ISO_BUFF_SIZE - 1)))
+
+#if TRBS_PER_SEGMENT < 2
+#error "Incorrect TRBS_PER_SEGMENT. Minimal Transfer Ring size is 2."
+#endif
+
+/**
+ * struct cdns2_trb - represent Transfer Descriptor block.
+ * @buffer: pointer to buffer data.
+ * @length: length of data.
+ * @control: control flags.
+ *
+ * This structure describes transfer block handled by DMA module.
+ */
+struct cdns2_trb {
+	__le32 buffer;
+	__le32 length;
+	__le32 control;
+};
+
+#define TRB_SIZE		(sizeof(struct cdns2_trb))
+/*
+ * These two extra TRBs are reserved for isochronous transfer
+ * to inject 0 length packet and extra LINK TRB to synchronize the ISO transfer.
+ */
+#define TRB_ISO_RESERVED	2
+#define TR_SEG_SIZE		(TRB_SIZE * (TRBS_PER_SEGMENT + TRB_ISO_RESERVED))
+
+/* TRB bit mask. */
+#define TRB_TYPE_BITMASK	GENMASK(15, 10)
+#define TRB_TYPE(p)		((p) << 10)
+#define TRB_FIELD_TO_TYPE(p)	(((p) & TRB_TYPE_BITMASK) >> 10)
+
+/* TRB type IDs. */
+/* Used for Bulk, Interrupt, ISOC, and control data stage. */
+#define TRB_NORMAL		1
+/* TRB for linking ring segments. */
+#define TRB_LINK		6
+
+/* Cycle bit - indicates TRB ownership by driver or hw. */
+#define TRB_CYCLE		BIT(0)
+/*
+ * When set to '1', the device will toggle its interpretation of the Cycle bit.
+ */
+#define TRB_TOGGLE		BIT(1)
+/* Interrupt on short packet. */
+#define TRB_ISP			BIT(2)
+/* Chain bit associate this TRB with next one TRB. */
+#define TRB_CHAIN		BIT(4)
+/* Interrupt on completion. */
+#define TRB_IOC			BIT(5)
+
+/* Transfer_len bitmasks. */
+#define TRB_LEN(p)		((p) & GENMASK(16, 0))
+#define TRB_BURST(p)		(((p) << 24) & GENMASK(31, 24))
+#define TRB_FIELD_TO_BURST(p)	(((p) & GENMASK(31, 24)) >> 24)
+
+/* Data buffer pointer bitmasks. */
+#define TRB_BUFFER(p)		((p) & GENMASK(31, 0))
+
+/*-------------------------------------------------------------------------*/
+/* Driver numeric constants. */
+
+/* Maximum address that can be assigned to device. */
+#define USB_DEVICE_MAX_ADDRESS	127
+
+/* One control and 15 IN and 15 OUT endpoints. */
+#define CDNS2_ENDPOINTS_NUM	31
+
+#define CDNS2_EP_ZLP_BUF_SIZE	512
+
+/*-------------------------------------------------------------------------*/
+/* Used structures. */
+
+struct cdns2_device;
+
+/**
+ * struct cdns2_ring - transfer ring representation.
+ * @trbs: pointer to transfer ring.
+ * @dma: dma address of transfer ring.
+ * @free_trbs: number of free TRBs in transfer ring.
+ * @pcs: producer cycle state.
+ * @ccs: consumer cycle state.
+ * @enqueue: enqueue index in transfer ring.
+ * @dequeue: dequeue index in transfer ring.
+ */
+struct cdns2_ring {
+	struct cdns2_trb *trbs;
+	dma_addr_t dma;
+	int free_trbs;
+	u8 pcs;
+	u8 ccs;
+	int enqueue;
+	int dequeue;
+};
+
+/**
+ * struct cdns2_endpoint - extended device side representation of USB endpoint.
+ * @endpoint: usb endpoint.
+ * @pending_list: list of requests queuing on transfer ring.
+ * @deferred_list: list of requests waiting for queuing on transfer ring.
+ * @pdev: device associated with endpoint.
+ * @name: a human readable name e.g. ep1out.
+ * @ring: transfer ring associated with endpoint.
+ * @ep_state: state of endpoint.
+ * @idx: index of endpoint in pdev->eps table.
+ * @dir: endpoint direction.
+ * @num: endpoint number (1 - 15).
+ * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK.
+ * @interval: interval between packets used for ISOC and Interrupt endpoint.
+ * @buffering: on-chip buffers assigned to endpoint.
+ * @trb_burst_size: number of burst used in TRB.
+ * @skip: Sometimes the controller cannot process isochronous endpoint ring
+ *        quickly enough and it will miss some isoc tds on the ring and
+ *        generate ISO transmition error.
+ *        Driver sets skip flag when receive a ISO transmition error and
+ *        process the missed TDs on the endpoint ring.
+ * @wa1_set: use WA1.
+ * @wa1_trb: TRB assigned to WA1.
+ * @wa1_trb_index: TRB index for WA1.
+ * @wa1_cycle_bit: correct cycle bit for WA1.
+ */
+struct cdns2_endpoint {
+	struct usb_ep endpoint;
+	struct list_head pending_list;
+	struct list_head deferred_list;
+
+	struct cdns2_device	*pdev;
+	char name[20];
+
+	struct cdns2_ring ring;
+
+#define EP_ENABLED		BIT(0)
+#define EP_STALLED		BIT(1)
+#define EP_STALL_PENDING	BIT(2)
+#define EP_WEDGE		BIT(3)
+#define	EP_CLAIMED		BIT(4)
+#define EP_RING_FULL		BIT(5)
+#define EP_DEFERRED_DRDY	BIT(6)
+
+	u32 ep_state;
+
+	u8 idx;
+	u8 dir;
+	u8 num;
+	u8 type;
+	int interval;
+	u8 buffering;
+	u8 trb_burst_size;
+	bool skip;
+
+	unsigned int wa1_set:1;
+	struct cdns2_trb *wa1_trb;
+	unsigned int wa1_trb_index;
+	unsigned int wa1_cycle_bit:1;
+};
+
+/**
+ * struct cdns2_request - extended device side representation of usb_request
+ *                        object.
+ * @request: generic usb_request object describing single I/O request.
+ * @pep: extended representation of usb_ep object.
+ * @trb: the first TRB association with this request.
+ * @start_trb: number of the first TRB in transfer ring.
+ * @end_trb: number of the last TRB in transfer ring.
+ * @list: used for queuing request in lists.
+ * @finished_trb: number of trb has already finished per request.
+ * @num_of_trb: how many trbs are associated with request.
+ */
+struct cdns2_request {
+	struct usb_request request;
+	struct cdns2_endpoint *pep;
+	struct cdns2_trb *trb;
+	int start_trb;
+	int end_trb;
+	struct list_head list;
+	int finished_trb;
+	int num_of_trb;
+};
+
+#define to_cdns2_request(r) (container_of(r, struct cdns2_request, request))
+
+/* Stages used during enumeration process.*/
+#define CDNS2_SETUP_STAGE		0x0
+#define CDNS2_DATA_STAGE		0x1
+#define CDNS2_STATUS_STAGE		0x2
+
+/**
+ * struct cdns2_device - represent USB device.
+ * @dev: pointer to device structure associated whit this controller.
+ * @gadget: device side representation of the peripheral controller.
+ * @gadget_driver: pointer to the gadget driver.
+ * @lock: for synchronizing.
+ * @irq: interrupt line number.
+ * @regs: base address for registers
+ * @usb_regs: base address for common USB registers.
+ * @ep0_regs: base address for endpoint 0 related registers.
+ * @epx_regs: base address for all none control endpoint registers.
+ * @interrupt_regs: base address for interrupt handling related registers.
+ * @adma_regs: base address for ADMA registers.
+ * @eps_dma_pool: endpoint Transfer Ring pool.
+ * @setup: used while processing usb control requests.
+ * @ep0_preq: private request used while handling EP0.
+ * @ep0_stage: ep0 stage during enumeration process.
+ * @zlp_buf: zlp buffer.
+ * @dev_address: device address assigned by host.
+ * @eps: array of objects describing endpoints.
+ * @selected_ep: actually selected endpoint. It's used only to improve
+ *      performance by limiting access to dma_ep_sel register.
+ * @is_selfpowered: device is self powered.
+ * @may_wakeup: allows device to remote wakeup the host.
+ * @status_completion_no_call: indicate that driver is waiting for status
+ *      stage completion. It's used in deferred SET_CONFIGURATION request.
+ * @in_lpm: indicate the controller is in low power mode.
+ * @pending_status_wq: workqueue handling status stage for deferred requests.
+ * @pending_status_request: request for which status stage was deferred.
+ * @eps_supported: endpoints supported by controller in form:
+ *      bit: 0 - ep0, 1 - epOut1, 2 - epIn1, 3 - epOut2 ...
+ * @burst_opt: array with the best burst size value for different TRB size.
+ * @onchip_tx_buf: size of transmit on-chip buffer in KB.
+ * @onchip_rx_buf: size of receive on-chip buffer in KB.
+ */
+struct cdns2_device {
+	struct device *dev;
+	struct usb_gadget gadget;
+	struct usb_gadget_driver *gadget_driver;
+
+	/* generic spin-lock for drivers */
+	spinlock_t lock;
+	int irq;
+	void __iomem *regs;
+	struct cdns2_usb_regs __iomem *usb_regs;
+	struct cdns2_ep0_regs __iomem *ep0_regs;
+	struct cdns2_epx_regs __iomem *epx_regs;
+	struct cdns2_interrupt_regs __iomem *interrupt_regs;
+	struct cdns2_adma_regs __iomem *adma_regs;
+	struct dma_pool *eps_dma_pool;
+	struct usb_ctrlrequest setup;
+	struct cdns2_request ep0_preq;
+	u8 ep0_stage;
+	void *zlp_buf;
+	u8 dev_address;
+	struct cdns2_endpoint eps[CDNS2_ENDPOINTS_NUM];
+	u32 selected_ep;
+	bool is_selfpowered;
+	bool may_wakeup;
+	bool status_completion_no_call;
+	bool in_lpm;
+	struct work_struct pending_status_wq;
+	struct usb_request *pending_status_request;
+	u32 eps_supported;
+	u8 burst_opt[MAX_ISO_SIZE + 1];
+
+	/*in KB */
+	u16 onchip_tx_buf;
+	u16 onchip_rx_buf;
+};
+
+#define CDNS2_IF_EP_EXIST(pdev, ep_num, dir) \
+			 ((pdev)->eps_supported & \
+			 (BIT(ep_num) << ((dir) ? 0 : 16)))
+
+dma_addr_t cdns2_trb_virt_to_dma(struct cdns2_endpoint *pep,
+				 struct cdns2_trb *trb);
+void cdns2_pending_setup_status_handler(struct work_struct *work);
+void cdns2_select_ep(struct cdns2_device *pdev, u32 ep);
+struct cdns2_request *cdns2_next_preq(struct list_head *list);
+struct usb_request *cdns2_gadget_ep_alloc_request(struct usb_ep *ep,
+						  gfp_t gfp_flags);
+void cdns2_gadget_ep_free_request(struct usb_ep *ep,
+				  struct usb_request *request);
+int cdns2_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
+void cdns2_gadget_giveback(struct cdns2_endpoint *pep,
+			   struct cdns2_request *priv_req,
+			   int status);
+void cdns2_init_ep0(struct cdns2_device *pdev, struct cdns2_endpoint *pep);
+void cdns2_ep0_config(struct cdns2_device *pdev);
+void cdns2_handle_ep0_interrupt(struct cdns2_device *pdev, int dir);
+void cdns2_handle_setup_packet(struct cdns2_device *pdev);
+int cdns2_gadget_resume(struct cdns2_device *pdev, bool hibernated);
+int cdns2_gadget_suspend(struct cdns2_device *pdev);
+void cdns2_gadget_remove(struct cdns2_device *pdev);
+int cdns2_gadget_init(struct cdns2_device *pdev);
+void set_reg_bit_8(void __iomem *ptr, u8 mask);
+int cdns2_halt_endpoint(struct cdns2_device *pdev, struct cdns2_endpoint *pep,
+			int value);
+
+#endif /* __LINUX_CDNS2_GADGET */
-- 
2.37.2

