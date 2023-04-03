Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429FF6D3F95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDCI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjDCI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:57:24 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F68540F7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:57:23 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3330rNLg027028;
        Mon, 3 Apr 2023 01:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Irpy7gwnJfEgC+OQ7vjdVKttO7DrnfvAdXMGCE/6wik=;
 b=Ge8XWep9cmXyHD/OcQ4EmHwQF/w12mc/OcvXsZl7Q318lfoiyCGbdkUfuK+2j5Glp3um
 WFKrH5WFbxL1Kcp6mpJZgmZuNkLNq1EiD+oFM2cfHxl6oRDBm3KO3pR7G3n37ko3pB1N
 cP0isKIwFzb0fUXBV4tSIPIhzpsJstMJRbSqkKasTk/1Lef05ef0os+jL6gNfRQs32iT
 ahGvEW80/8A46SqRDP36QnV366+mKjBRBSGZdruLV09thfUydkXwQlV8ztr5NLVBCllC
 HcpvAShxAnF2+40/jLi2pnAZIoLcUs33tntdKKqV2kygDHfeNPOrPAtO00Fzo96oH6Rf MA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3pph61t9ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 01:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp5NMKtdrJIofQY5TVFcQOasdSt2X0TxQpkWFHF8LxrlRcV1HCYaATsRavvM3K68Qa+DCh50lmXyILaQJA+ZaDLvH7GtrjSD3HKQ7licvC6ESDZa89KR3MqYWLSCubvd1efGz0Dx2a3pZ4uGVviaoxyPdE1nxetq2yGHxX9bPZYWd83peI1LtIW7Kn8dAe3WynQ9dcwLuK4tOMGxkRKTNI21kaHYqHNIQu2MJK/7oAFDkO22BcI4/7115osh/PvBxg0xIUPv1evTpJXcO7/wM+hNDpPSfnLzyA6sL7hGKYLxfxtJDLK/2U5M3LjIgT1RDlVq+L7d9FBTAEIwNnfwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irpy7gwnJfEgC+OQ7vjdVKttO7DrnfvAdXMGCE/6wik=;
 b=HomnefaweHmEZQW1uzYGE1NjxFtBHWpic89+ysk9m0K+4VxWlQDIFCPMdnuMLh4JKdBe7p2birtkpqj9CJ1gJTD1UR/o6LNd4WXvTD0M700cmH3qXRpp+Bg+IgvtBV9/jRxhXrmRUNY++VgO3eBD1RrjY9FslSc5KYBt1Y/CSKJJptuoJLZXFtbTq4oKvOr1G2dO2mPgkurBHBr/luYiVqKE7mtnwG9J558ejO/fm3ThpV+J5/MJsIaAj1vGfMKkYtx1vUbqXnzf5q7lcRVMZ1FA1U9GDNmRI203G++v22lXpRHPILCe09Bb/lbk3U7whNpMLa1BzRWajx4b7BqKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irpy7gwnJfEgC+OQ7vjdVKttO7DrnfvAdXMGCE/6wik=;
 b=CU2KuCyMUapHBo3Ziyvu/k3kIEkUPEJ6Zk+1ZKOGSvFqfvmGzG8w6r3Pe+o0hWqjzZYk1uuwxPZIjtVraI80vyTdsVWsoCzAgMlrbgVcEzCSjs5BCbtZjVxvVkUwgzS1xWEKEjwUPTeAnM9MtmZT1WLjbTZAICTaHd5qhogdGrU=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by BYAPR07MB5093.namprd07.prod.outlook.com (2603:10b6:a03:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 08:56:50 +0000
Received: from MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::72) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 08:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT007.mail.protection.outlook.com (10.13.180.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26 via Frontend Transport; Mon, 3 Apr 2023 08:56:50 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 3338umu2012599
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Apr 2023 01:56:49 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 3 Apr 2023 10:56:46 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 3 Apr 2023 10:56:46 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 3338uk5k010253;
        Mon, 3 Apr 2023 10:56:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 3338uiIx010238;
        Mon, 3 Apr 2023 10:56:44 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration
Date:   Mon, 3 Apr 2023 10:56:44 +0200
Message-ID: <20230403085644.10187-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT007:EE_|BYAPR07MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1c21e4-f32e-4a4b-5eb7-08db34215cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxJ7cOdzGQRd7ZJYkbi3o63LER939pW5lCw93Y9X+QTQZMvjuG+YX9dYggkTAEn2xGPdG66kGTlzfFURpnAHWVmI/J7ViKkUR0u2yhMF7b+tOF1/pOWUdfK/4FmmWSRodPydoxwbtGtHpAe8XjqOkFMW3xYLbrYckMupdEHkjuZerUgZ2pnoCPXLkVl9NpHD1Dbk82Aw9N2rTet5f39laTtxBu2KM8mC8ewcxiD3kJ6B1crAtoZSMaYh+7yvzU55JcAb2JbbLxqQZIRowOV00jKUT/gW2VceMAM397Ua35NonTYOeztwhy4++qX7tchbezC+Bl9ejcppiOafvzFY389WvRTI+G5Pwxf5pgksLEQjLNpsUNrFQaVckf3cJe8a2vUjSQuyh56oCH1V+ONb6T59Q9zNSd02E6Tpwl/jpz6Osv/bZRttIpx6mDSQKEqqUcwNv+lqmQukihFEEv3lhmxZDrcpbFfsNUzjJ2GiuEsziKfxqXoTzauOt4WtNhH2RH3hy9KTei+8ZkK73fAgddKroOgTAupQRvD0uUhwVQkK66RfOtuWI2XnP4fBYV4+YGnQ34SBrbUvWyRXHCfN7QAQP9VIBahD07JJUvyiDDkXwTXjVvCPw7YOg9rm6Y4BBLYGd/0K0JkiR5HBPHO1Spcec9KGxFvLEXU8kjOy10t/oucZc9TXO6+M9GkoAmAyTUA18wdidS+togmDhDB+wQ==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36092001)(451199021)(40470700004)(46966006)(36840700001)(1076003)(4326008)(42186006)(54906003)(8676002)(110136005)(316002)(70206006)(70586007)(36756003)(40480700001)(26005)(83380400001)(186003)(2616005)(336012)(426003)(47076005)(41300700001)(5660300002)(82310400005)(40460700003)(478600001)(8936002)(36860700001)(86362001)(7636003)(2906002)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:56:50.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1c21e4-f32e-4a4b-5eb7-08db34215cf3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5093
X-Proofpoint-GUID: 9k2vWfGbvcnP8tHgnYGHI6DMyDYrbMMU
X-Proofpoint-ORIG-GUID: 9k2vWfGbvcnP8tHgnYGHI6DMyDYrbMMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_06,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030069
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register sequences for PCIe + SGMII PHY multilink configuration.
This has been validated on TI J7 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Changes in v2:
 - Rebased on latest PHY next
 - Added Reviewed-by: Roger Quadros <rogerq@kernel.org>

 drivers/phy/cadence/phy-cadence-sierra.c | 141 ++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index ab0a37618ef3..13fcd3a65fe9 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -24,7 +24,7 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		4
+#define NUM_PHY_TYPE		5
 
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
@@ -46,7 +46,9 @@
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
+#define SIERRA_CMN_PLLLC1_FBDIV_INT_PREG		0xC3
 #define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
+#define SIERRA_CMN_PLLLC1_CLK0_PREG			0xCE
 #define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
 #define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
 
@@ -74,6 +76,7 @@
 #define SIERRA_PSC_RX_A1_PREG				0x031
 #define SIERRA_PSC_RX_A2_PREG				0x032
 #define SIERRA_PSC_RX_A3_PREG				0x033
+#define SIERRA_PLLCTRL_FBDIV_MODE01_PREG		0x039
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
 #define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
@@ -305,6 +308,7 @@ enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
 	TYPE_USB,
+	TYPE_SGMII,
 	TYPE_QSGMII
 };
 
@@ -929,6 +933,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	case PHY_TYPE_USB3:
 		inst->phy_type = TYPE_USB;
 		break;
+	case PHY_TYPE_SGMII:
+		inst->phy_type = TYPE_SGMII;
+		break;
 	case PHY_TYPE_QSGMII:
 		inst->phy_type = TYPE_QSGMII;
 		break;
@@ -1316,7 +1323,7 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 			}
 		}
 
-		if (phy_t1 == TYPE_QSGMII)
+		if (phy_t1 == TYPE_SGMII || phy_t1 == TYPE_QSGMII)
 			reset_control_deassert(sp->phys[node].lnk_rst);
 	}
 
@@ -1514,6 +1521,71 @@ static void cdns_sierra_phy_remove(struct platform_device *pdev)
 	cdns_sierra_clk_unregister(phy);
 }
 
+/* SGMII PHY PMA lane configuration */
+static struct cdns_reg_pairs sgmii_phy_pma_ln_regs[] = {
+	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
+};
+
+static struct cdns_sierra_vals sgmii_phy_pma_ln_vals = {
+	.reg_pairs = sgmii_phy_pma_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_phy_pma_ln_regs),
+};
+
+/* SGMII refclk 100MHz, no ssc, opt3 and GE1 links using PLL LC1 */
+static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_cmn_regs[] = {
+	{0x002D, SIERRA_CMN_PLLLC1_FBDIV_INT_PREG},
+	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
+	{0x1005, SIERRA_CMN_PLLLC1_CLK0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
+	{0x0800, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_ln_regs[] = {
+	{0x688E, SIERRA_DET_STANDEC_D_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
+	{0x0106, SIERRA_PLLCTRL_FBDIV_MODE01_PREG},
+	{0x0013, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0003, SIERRA_PLLCTRL_GEN_A_PREG},
+	{0x0106, SIERRA_PLLCTRL_GEN_D_PREG},
+	{0x5231, SIERRA_PLLCTRL_CPGAIN_MODE_PREG },
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x9702, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x0051, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x3C0E, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x3220, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x0186, SIERRA_DEQ_GLUT0},
+	{0x0186, SIERRA_DEQ_GLUT1},
+	{0x0186, SIERRA_DEQ_GLUT2},
+	{0x0186, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x0861, SIERRA_DEQ_ALUT0},
+	{0x07E0, SIERRA_DEQ_ALUT1},
+	{0x079E, SIERRA_DEQ_ALUT2},
+	{0x071D, SIERRA_DEQ_ALUT3},
+	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
+	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
+	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0033, SIERRA_DEQ_PICTRL_PREG},
+	{0x0000, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
+	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_cmn_vals = {
+	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_cmn_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_cmn_regs),
+};
+
+static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_ln_vals = {
+	.reg_pairs = sgmii_100_no_ssc_plllc1_opt3_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_ln_regs),
+};
+
 /* QSGMII PHY PMA lane configuration */
 static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
 	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
@@ -2340,6 +2412,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
@@ -2354,6 +2431,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
@@ -2365,6 +2447,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
@@ -2380,6 +2469,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
@@ -2391,6 +2485,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
@@ -2412,6 +2513,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
@@ -2420,6 +2526,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 		},
 	},
 	.phy_pma_ln_vals = {
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_phy_pma_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_phy_pma_ln_vals,
+				[INTERNAL_SSC] = &sgmii_phy_pma_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_phy_pma_ln_vals,
@@ -2435,6 +2548,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
@@ -2446,6 +2564,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
@@ -2461,6 +2586,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &ti_ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ti_ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ti_ml_pcie_100_int_ssc_ln_vals,
+			},
 			[TYPE_QSGMII] = {
 				[NO_SSC] = &ti_ml_pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &ti_ml_pcie_100_ext_ssc_ln_vals,
@@ -2472,6 +2602,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
+			},
+		},
 		[TYPE_QSGMII] = {
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
-- 
2.34.1

