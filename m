Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9F6A42A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjB0Nbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB0Nbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:31:35 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424AC20547
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:31:33 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RD2WNX024666;
        Mon, 27 Feb 2023 05:31:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=iwlyNUErb0IfKCnR6P9pvMvv/8iZPWOlThozo16uQqw=;
 b=BZwJZ7OGcWFe4mMLih5umzkxrd6Sxi7+GNUOw6Rill54YD/qcVDT/3281/9tnuk75uwW
 j2UFyk/Q6x2iHQNEMNQDMsIINCodLsWwsHwPfTIvXPsA1kCuewEf2uaZ9V6vP2vKZ8xJ
 iqThurafHblt7055J65gK4fp8a5GOJKEvnmu23dt2Lc5AvbPtU3kZXgOlhv8lkpkrgKG
 uYZS+xXmTOz7Vg/ptQgQZKYn6MSy6te1//ImnnGElhPg11dkdnJcgGS4MbF8LxiJcDex
 xvnK1m2MkX5W7s9YlRDuLK6V5m/ynq8/4t1C0tNmRi5aiHLEUN8QiB9U3ns7/+D6EWdG /Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3nyet6ys5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 05:31:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyLWJXwmW05GYbGrzL9bbKaCacsxwHJaD/NpQp5m27ioOe267CUZzEXKv3XnodUjZaMclZiKBf6rCUJY7hqOQtut7WL40W37ZURS8IofGzHN9mBxkAX3TAYG8sZhnVOWLzaapg04Q2QYQN+0c+vTTl9n8HiQzpRGU2RMZysBMSzYg0iCs8pdyTvJ/604J18nlIoxgo2EVYO5mCRPWZFoJfHmOQ7agpv1U8zsjFzjT+pYVIJnF8CEfa9ER8Lvc9XErva0/5TAvbFCxjJzaDLABUz0Qb8rf3L3o8cOKVN5PYPNohkLAC7nnWFPTlhgszfotJCYxMoTONpCtfAd9jv1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwlyNUErb0IfKCnR6P9pvMvv/8iZPWOlThozo16uQqw=;
 b=Hc2bzcLHpvlH37bOE6EavxHmNkyyxhiWxCJRaOfqtOU/t/mWlZiUjeA8tLxRK/Vixu/WUunIMCtQkeBViITuq4S+ci85jGSpbELbNuvkgjzDgnjkayj1zyaqK+1f8hTUHBtxOEOmJdxS1jS/1BpC8zu/CQb5ySUMEFr5f8OAFvUs/r0Y330A5OuMPr7ZaHSW670RKMJ5CM0swHZKkmuu2MABRxJlmGPKfpmaiTl5/3aN8aSUPOuTt+YUJ1u5nFLdgJVGKIc2se3dP3ikWmjay+57hpq7289smgh4DQBbdwffNvf/kmwOngVkK4RGehunh/Ghs/ib2T8kSPUQdT2GJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwlyNUErb0IfKCnR6P9pvMvv/8iZPWOlThozo16uQqw=;
 b=s+bAY99QVgvJNOLGTUCYn4fj1tqEe7W9Ow6briy1Ed2Ysv/kMBib82Hzr8xHFrDzBHxc8vnbggtK7G7h3c0CE5dCIq980ViVEdMdWmg4IAv00AZZ3KMvPnZ8aqaqBf5d8bWAU6X5OM3QfD/AOiUwEqfS7T6TmS0XKzZ9zPM4fZQ=
Received: from DM6PR14CA0040.namprd14.prod.outlook.com (2603:10b6:5:18f::17)
 by SJ0PR07MB9089.namprd07.prod.outlook.com (2603:10b6:a03:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 13:31:11 +0000
Received: from DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::d1) by DM6PR14CA0040.outlook.office365.com
 (2603:10b6:5:18f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 13:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT024.mail.protection.outlook.com (10.13.179.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 13:31:11 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV74k019544
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 05:31:10 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Feb 2023 14:31:08 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 27 Feb 2023 14:31:08 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV7nE029877;
        Mon, 27 Feb 2023 14:31:07 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 31RDV7Gs029871;
        Mon, 27 Feb 2023 14:31:07 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>
Subject: [PATCH v2 4/4] phy: cadence-torrent: Add USB + DP multilink configuration
Date:   Mon, 27 Feb 2023 14:31:04 +0100
Message-ID: <20230227133104.29788-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230227133104.29788-1-sjakhade@cadence.com>
References: <20230227133104.29788-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT024:EE_|SJ0PR07MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ddddb7-4c44-432b-5242-08db18c6e401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMIctd1tXrbFofGNR/MYk4fXLUHPUk/v0nWhTxqr6k41TpO5fNjI+49QV3j1ESh8ajnOaBxTPc3Yhd4sOqR13KcNNlRJqMK30ZqUzGMpA9QDRqzbqF4qPAI36+Na7s7PBX7/ziGE9lnLshLaRcGfxtmi9EVwuiJmaeaNOZOjTllN6AcKeusck7GPKGCDhCnWjx+eIL7ZpBu8CUMI1igoxxamD5oQTBJxWi7NdAs0JhIWj+jOsAOYJ3T+I1Tv5+jZSQilvwoKX9E2R6h3CT6mZEXVi9hsN1acfn4aSdUDPomWzh039/d7nFx7klwpSwsYzaF5ErUPapdJDgj7sOwQ8GObthLGEpCFbUdl/sG7SY+nPONdcB7l71ILeGxllPYDFqgUFEo89Y35dNCc8K/Z2BlvAlP13AzuzMb/hBS96c0OFMxPi5rQlfr6gwDtSNCV1YHvssS6UKUWPW6Bwx0/FTUaFsR8m+T3eZkZOaMmScr0U8vONDvoivNMe2djnrNN3kmS+jYUE7QZ9Tyd8dwOSa9vfugUl9ZtTiAq2PHQYO025JmjkoTWhSZdkzyFAkOolvQSpp1RzltB5EeQKqcAgvuGFAh0MrlKZ+6DRl+KILgYh+/xZhNCqmrit7b70v+kjLd7S2Z7njplq3qn3Qt8MF1OK0LJxgqXVa8t0536sqmQlkKkSKskcMDeQiR2/WC2EehvLJnaxFeUnH6/IF1t8A==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(451199018)(40470700004)(46966006)(36840700001)(26005)(186003)(1076003)(6666004)(36860700001)(82310400005)(426003)(47076005)(356005)(40460700003)(82740400003)(86362001)(7636003)(40480700001)(36756003)(2616005)(336012)(41300700001)(70206006)(70586007)(4326008)(8676002)(2906002)(8936002)(5660300002)(42186006)(110136005)(316002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:31:11.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ddddb7-4c44-432b-5242-08db18c6e401
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9089
X-Proofpoint-GUID: Qp7EkXZkHRBTByBFwjHyDuxdHOElZ99T
X-Proofpoint-ORIG-GUID: Qp7EkXZkHRBTByBFwjHyDuxdHOElZ99T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=959 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB + DP no SSC multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 98 +++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index c8a204616cdd..8bab6f9b75d0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2898,6 +2898,38 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* USB and DP link configuration */
+static struct cdns_reg_pairs usb_dp_link_cmn_regs[] = {
+	{0x0002, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs usb_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs dp_usb_xcvr_diag_ln_regs[] = {
+	{0x0001, XCVR_DIAG_HSCLK_SEL},
+	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals usb_dp_link_cmn_vals = {
+	.reg_pairs = usb_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_dp_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = dp_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
+};
+
 /* PCIe and DP link configuration */
 static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -3914,6 +3946,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3991,6 +4026,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -4001,6 +4039,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4078,6 +4119,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4102,6 +4146,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4127,6 +4174,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4204,6 +4254,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4230,6 +4283,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4307,6 +4363,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4333,6 +4392,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4410,6 +4472,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4426,6 +4491,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4503,6 +4571,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -4513,6 +4584,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4590,6 +4664,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4614,6 +4691,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4639,6 +4719,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4716,6 +4799,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4742,6 +4828,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4819,6 +4908,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4845,6 +4937,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4922,6 +5017,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
-- 
2.34.1

