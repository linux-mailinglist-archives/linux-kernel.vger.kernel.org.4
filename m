Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF596E6B28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjDRRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjDRRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:33:26 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67BAF12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:32:58 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFlILW026562;
        Tue, 18 Apr 2023 10:32:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tjM/QYG4TF54NGqBnfWAbRE8E4r5yQji/WvPO0FLt2s=;
 b=mdTM/iR5t550rX43b0/y9hwrb3xPLr0UHp/40fFlCDF4Ji0yJCHAe+ryKAMejiZPPrp4
 pVcB1Cb9CSs1VNttlDP3oJE47llDE9uEJIc8oP1gSKq5cBrVoEfzji3uxcfNR8alhn3h
 errJAW94qxTe/450LvjKLEP9EumOvYu3szbVl08h5UcO75lnvTzxs9x+t3DGR1b6ueFo
 6UZhwjo3x8LDzPKo9yNsiBOu+yH1tug/SptzPpHX2gy/x8BaYSaUtsCOxHrqgY8bCu1/
 tQ35YTVblO2di+dR2vorDWfkbq4+e53U+N1tXR5bmuCNPSzw09MJ2nc97loJ6XUf7BvN 1g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3q1x590e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nawTO1kiDrZ7WiUGGFAmcljjLKbg+EOg3NO2w46XbTWhTH77tT974wAwzRBHMZ6Mltuxb/HjNcD/2fjDJBKfGwC4s00niqnJRZ7ld7vR/2WJkQWhSP2fSz+oYUem4KH6zQCFDeBFakNakMBHXzazWSFp53YdLSw2xjiQzx20sgdd5S6d4lp+5yeZY2GgCt+5FpG+DP9LT7LBYZYyW+DYydZQj4KF3Ti+m/7Td9Ck7cCRp+YB+cwLiwpXfbuwN1cxv86ry7yw68t1VjCjS9BAbEdLDGAn7nMw3aKShUDhgqvM9CskzMLNyLENWtUoV9tAcV/pQKaGb0/yEmKeSScjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjM/QYG4TF54NGqBnfWAbRE8E4r5yQji/WvPO0FLt2s=;
 b=jrGJPE3B1gsAKxJiXp18NfS2lm8Xr1zQxEB7qaOG8Gyeb9qsgJgkYIeVOnkzOigiBwKEkrZs0BBnhI/wg2scrOl16CVB4rLAnPhXZPwct9Tj48nqHY31Zrqdj2aGRhpEJtqPa+YPeYydrJ/0jCCu50EjlddkCbB1Vv4E6WAtWQMTv16DaCBzaWZSGlssAiOLusDNp+dUaVTZzHvW1MXPEsmg3CGtXI7eh080DFjIJyHF4GxIPWVCRL3DMAwXAOkSqZolUvKUFBvCAqOCYpvkQ3vHgLO3pz8JchQu9nWOWL93GlJCOx9nVFO12Aser0XrcnDfQTLq3zJsK6+UXYI4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjM/QYG4TF54NGqBnfWAbRE8E4r5yQji/WvPO0FLt2s=;
 b=aN9Zwm9cZuuCk7OwYBycV9BbPKkN3GRdVISuQBPyfrx39HRSebfhLYlKllho2myr+JCfseHFR6DboGjEorFoVzxPO5bHA+NEa1+9tLvDgY3OIjHnB/ij2peii0lLt0zebV/SiphTB8+pHCOqKHtfAdU6ql2c9UTgDZNCuqnv7ys=
Received: from DM6PR05CA0044.namprd05.prod.outlook.com (2603:10b6:5:335::13)
 by BN8PR07MB6145.namprd07.prod.outlook.com (2603:10b6:408:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:32:06 +0000
Received: from DM6NAM12FT075.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::44) by DM6PR05CA0044.outlook.office365.com
 (2603:10b6:5:335::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 17:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT075.mail.protection.outlook.com (10.13.178.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.6 via Frontend Transport; Tue, 18 Apr 2023 17:32:04 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 33IHW1LE194661
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 10:32:04 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 18 Apr 2023 19:32:02 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 18 Apr 2023 19:32:02 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHW1Sl025686;
        Tue, 18 Apr 2023 19:32:01 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 33IHW1wf025685;
        Tue, 18 Apr 2023 19:32:01 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 4/4] phy: cadence-torrent: Add USB + DP multilink configuration
Date:   Tue, 18 Apr 2023 19:31:57 +0200
Message-ID: <20230418173157.25607-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230418173157.25607-1-sjakhade@cadence.com>
References: <20230418173157.25607-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT075:EE_|BN8PR07MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 43918a04-83d0-49e0-b226-08db4032d3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNsuQ/6OZChf9Xfv7LPxTVx+h24mIrlKQu7pRSvb8ABlJvqrzjTWTyP+weCmsVs1dzjdo24UBqjJje+1WOzhl3VnFLUV8W5Mz4RyffT5xNpjKlS6yAuOsR/6SmztRrlCd2yyizQvEkSpjVJkMFKohCJ4Y0FOb5Kmw5grOSyCUcGuoAZx675WZ26/G+ywaS9B/+zNdpUECm6RVwO4184XtE3Tq2xzwTXZpk/olFKeHMC9mne+EFa7/F9u8Cunh/TWN0Ay9irbp6v8oTPd5J5cARD3zCOd9V0pK9ZTT8mQ/6R6+LsLGBgzQ1mzWO12VEXEOI6UbRXVzFhNMfKjm+DlsQOksRlMF1+hqj6/1OlZm0JfF9qpOvS7H1tnJF60GbJs/0x89Nc7AVEYf8JcspjW051O+HgSNwkTF5MRhYSQBXPKXWqFW1LWkqT9iD8zbop0acMG39QlxLar6AgKdAc+A9ep4mRmRjs336pZMo+6RFFiMEx5vcVRaqDQu3OPSwIYMizObNfrWfeKpYcjPXt7FcE2+AO7K+XkajEuQ9l3MQKgNwe84kTkI9e7h/zrbtiTMzKd2bwA+eIQuE39h0oGCoDybHF+6TTK+OnUC8ZfOcYPFEKrFhQF/YxBp7pdQK0IV70r/ca1BaRQraamzMwv3haKNwSTeg3D9liGnzu6pxp3yDqFrnjEEpnj2qtGbpTC0QjEClvOgdO+COQ6cwsJqTqBcf1qSg6GirNCuw+a+LajxlfwRdJKZk0pawyEX05g
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(451199021)(36840700001)(40470700004)(46966006)(6666004)(5660300002)(82310400005)(8936002)(40460700003)(54906003)(110136005)(316002)(42186006)(41300700001)(40480700001)(478600001)(70206006)(8676002)(4326008)(70586007)(36756003)(82740400003)(356005)(2616005)(36860700001)(81166007)(1076003)(86362001)(2906002)(26005)(186003)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:32:04.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43918a04-83d0-49e0-b226-08db4032d3de
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT075.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6145
X-Proofpoint-ORIG-GUID: Cvh90TrA1sgKMD98-1Xp2NzRQ7Ksq88x
X-Proofpoint-GUID: Cvh90TrA1sgKMD98-1Xp2NzRQ7Ksq88x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 mlxlogscore=799 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180144
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 2fc5dd495ad0..3b0e4daa9de9 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2896,6 +2896,38 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
 	cdns_torrent_clk_cleanup(cdns_phy);
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
@@ -3912,6 +3944,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3989,6 +4024,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3999,6 +4037,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4076,6 +4117,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4100,6 +4144,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4125,6 +4172,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4202,6 +4252,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4228,6 +4281,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4305,6 +4361,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4331,6 +4390,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4408,6 +4470,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4424,6 +4489,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_dp_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4501,6 +4569,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -4511,6 +4582,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4588,6 +4662,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -4612,6 +4689,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -4637,6 +4717,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4714,6 +4797,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				},
 			},
 		},
 	},
@@ -4740,6 +4826,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4817,6 +4906,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
@@ -4843,6 +4935,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_PCIE] = {
 					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_USB] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4920,6 +5015,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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

