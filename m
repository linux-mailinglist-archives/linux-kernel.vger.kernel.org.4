Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E659669D0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjBTPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjBTPdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:33:38 -0500
X-Greylist: delayed 4837 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 07:33:28 PST
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ABDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:33:27 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCN4bD031472;
        Mon, 20 Feb 2023 06:12:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=315+u0s8VUcCrITuFKOJZxuHWFtogM/2gdxMWtnB0mI=;
 b=AEeaQ9ax98vzFcMfBfdp7uz4zQ82/2+tn65tM8lYLJA5q5AfuUe7ZEmzv1I9WG/TS8LL
 6ZVHczAxy8MEKargVb3A5HCPD5htEC/Y1XtQheYVpjV+NpFlLWOnBHj51ESas7vGqmi6
 ShCKiUszOcyTiijJ8kL0Zu884FGfFGU2f/6aT4j9Nftbd1BIo42odBykLUkTu1lUDeqj
 iK+9fQ8/XedzlNqUmqDMfqZVxE2AZMbL2+5tw7Jr32uzkYXM134dq44mZRZ+1Wl2zF9/
 Sy6kuAvafYslXBG9dVlQa2K4ViRRbUvYsgfzS3PsokpYYR9/f6rURhuN75YaE3vHDKZq yw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3ntu546kk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 06:12:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYd40pBv/GQTyEZ7aazquBSe0VsRecvpHwwEBP1xXJC1quycB5UCoVuFxmTvwTzhkPxB350NmqYCfYXsRITT1PFdY9kxVobokzg+njlAFZWnn5PX/xOAoV8BXA865AWlZ5LrAIwq9QT2TG/RBXmTxYIWfznFQyGgJfPn19mRzUnBHhnGR6DFfGG6Ouq6cC6jy0VUCquG79zpANvgaKZMbpgXpInCy+mNw7+7TWxivlsotnGhx6MpMfSTx2pzjVLIbXYu1+UPAdBn5BHzVLpXrZinyWvZp+63o6Wqc9jrL0HGySvMKtnfai9EjwaMYHHS8YEoTKjTAuOZnAeTK6daNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=315+u0s8VUcCrITuFKOJZxuHWFtogM/2gdxMWtnB0mI=;
 b=OYsdsegBWcc3tndVUPHm6/zVmf3wffDZlJ6f5WD7rqU93wg8zoQ9ze600RNyBx3XTH/Xohn5UIjsu4HNB4o7oA7l9nVLZBlMnfuCtzNRhnrrLSGbVnWEpuM5Vu0eRrzNngN3m3+qSz5GkQba/DLbVyPq9kHYpiW9icoDsKX1KrpiBq4odi/4TJyi4B67eOjw0UGIs2fLPDxk5VoXRtGFwzfchLBS+zQPnHH3jfkL19sZGjLgGuUxTugNJAFdr0mhC5uMLIaFSEKkdLtQnn7pmTCUrTNjHUEjrHXWfRkLw2K/yv4Y8ND3A17eVJpQcS/kGa/2XnXNpb5UDI/ADK2Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=315+u0s8VUcCrITuFKOJZxuHWFtogM/2gdxMWtnB0mI=;
 b=cG53lbZNdiqRoIdk5DOzWMRteJDC4piZrlNzCnswmE45niT+ipZVDd7uOLMfQrkMvuwwemdO5/bKmQ7WY3DkDNzgRH+vxtaVZ3NFZeYoheaRlGALCLs/iJPJcaOOJnElv+WME2NlMtBUws78+rh2rfiEssW0jyBpJ/jMdC6HdtA=
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by DM6PR07MB4778.namprd07.prod.outlook.com (2603:10b6:5:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Mon, 20 Feb
 2023 14:12:20 +0000
Received: from MW2NAM12FT092.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::fe) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 14:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT092.mail.protection.outlook.com (10.13.181.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.17 via Frontend Transport; Mon, 20 Feb 2023 14:12:20 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 31KECIIS003498
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 06:12:19 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Feb 2023 15:12:17 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 20 Feb 2023 15:12:17 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 31KECHLC025372;
        Mon, 20 Feb 2023 15:12:17 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 31KECGPm025366;
        Mon, 20 Feb 2023 15:12:16 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration
Date:   Mon, 20 Feb 2023 15:12:16 +0100
Message-ID: <20230220141216.25326-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT092:EE_|DM6PR07MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4dab64-2b2b-4170-4b75-08db134c7aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q+dAYxZruVC0CIzSxNBneyj0A2r3lfEYksSmNj3DRkaTszriStC/3PvAzsBUo05FdMqrp9c8IzYgl1GnYmH85SmGr+YJkZA3jHGR6UYZqOXspoSHfJsgKN8hlq6AzI8TC3E9cuph1BcvK7n2ipNW0gMKhlEmU84smJOPOm8H9QGgwIdHAzRLHEML+nUwSHYUxVWAkk8sJsOFFmBDvbdcf09vcek3gtvKTIzza4Fb1nwxPpQZhV0P0q0BHlU9qgDUUEwUnMlldYph4wCw9oDvKiaJRNhJTBo7n3fyKZ67Vv+UruUEB08K5mxbKt4fxxBByub+dXtLidPKe3VSGrE1vXvM7HAi26w1hgD4hUYg3j/jFSuR4p0H0ldDEmCIrKRYuw+/9JTyhNOpANXmKdZFK89U5pNgIY+xBycMyaT6+YxAwpHiEH7W7/t8RmOab6/sJ3sxizQkv7qHl11jZD9J+3ekWvngzgwkCQmx7I9VKXx4sXGxCHhv8h0w/cbSjNvX+QAKIiZgVW7149KC34nxg+gtQFSB93NIKrWB629lPTwsGQ08I0t0fTW7AZfq27ZxMiMHT0B3DtPkl5r4DE/pTQoWFVTU84DuGBpJUq09FFqSeeikujhURZMigSQNWC5/GMlOyeIh48BRKScRqLPiEsIC1Br4xJV6BQbMynFGL8PXyaAgLr6QRDGEgaNM1U8RhKaTzQ75+t+MFSU699l0w==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36092001)(451199018)(36840700001)(40470700004)(46966006)(41300700001)(83380400001)(7636003)(8676002)(4326008)(82740400003)(356005)(47076005)(8936002)(70206006)(426003)(316002)(42186006)(54906003)(70586007)(36860700001)(5660300002)(110136005)(82310400005)(2616005)(336012)(478600001)(26005)(86362001)(40480700001)(186003)(2906002)(40460700003)(36756003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 14:12:20.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4dab64-2b2b-4170-4b75-08db134c7aef
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT092.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4778
X-Proofpoint-GUID: BRH5eyLJkCtPZdMNPo2qWd5MUNiHoxgS
X-Proofpoint-ORIG-GUID: BRH5eyLJkCtPZdMNPo2qWd5MUNiHoxgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200129
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register sequences for PCIe + SGMII PHY multilink configuration.
This has been validated on TI J7 platforms.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 141 ++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 6e86a6517f37..7c0daf3e8880 100644
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
@@ -298,6 +301,7 @@ enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
 	TYPE_USB,
+	TYPE_SGMII,
 	TYPE_QSGMII
 };
 
@@ -936,6 +940,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	case PHY_TYPE_USB3:
 		inst->phy_type = TYPE_USB;
 		break;
+	case PHY_TYPE_SGMII:
+		inst->phy_type = TYPE_SGMII;
+		break;
 	case PHY_TYPE_QSGMII:
 		inst->phy_type = TYPE_QSGMII;
 		break;
@@ -1339,7 +1346,7 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 			}
 		}
 
-		if (phy_t1 == TYPE_QSGMII)
+		if (phy_t1 == TYPE_SGMII || phy_t1 == TYPE_QSGMII)
 			reset_control_deassert(sp->phys[node].lnk_rst);
 	}
 
@@ -1537,6 +1544,71 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
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
@@ -2363,6 +2435,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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
@@ -2377,6 +2454,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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
@@ -2388,6 +2470,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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
@@ -2403,6 +2492,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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
@@ -2414,6 +2508,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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
@@ -2435,6 +2536,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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
@@ -2443,6 +2549,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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
@@ -2458,6 +2571,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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
@@ -2469,6 +2587,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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
@@ -2484,6 +2609,11 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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
@@ -2495,6 +2625,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
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

