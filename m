Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494B6A6E75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCAOav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCAOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:30:48 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06633BD88;
        Wed,  1 Mar 2023 06:30:46 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AXiQh018644;
        Wed, 1 Mar 2023 05:11:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4LTBktBhD9NhN+6Fvv5MPBZnvlU929LAlkLez4DyrJ0=;
 b=hlKej//aRFNAttHeQWWpRzYZz5rj3pl/awO3R9S8dFeDl0+iQqyJaIxv6vPJkJn0zZmD
 nnQr9dBZ9/ZE6/rgOBrB6881llo7H+hgtMdqvwxZFzWiCVzZIrknibuklrUK8hYLLoUt
 Z1BjLf2Aq79W/ycJWNd8/dZk0yE6UnPT/bz2y8s1sCTYhEEaWf5Mjnecoh560QDM3mIc
 bPYo/YqIczrWKjNh18TVd0ov1D4x3xhbvcL82Fbs3BRyQjhQoWF4DjIP6w4+9bu7eIae
 F0cNn0kCzJe70iYwegQoDei4VqXGb2Gxet0WNvP3Jznhidw5kQcLTnPR6q8RRVoelWlk tw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3p25280kxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:11:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4QkZwZWGBai6+GTdlc7AydZ/gypcW0quZ7F90wFVW36AZxYSsJ/tC54iYETKu+eghMLi2eY83O2IX5j/glQLJG9ke8BwnYPntm6v9KtHux4UWUTZ3O5L5MpyF3Nn3qjSJGIFKDTC2IAims0FbI7OCW0ozQFYlHwr2N/1MkFYQr/X/7KRC2OJmG0LVpg29Tg4iGc1+TAEkriHmiecJGfFcSCspvwH6Lq01qDVOOy3h+CBVj0DMFjHOEYvs5Ye3Y5c1jOKQu6DdctNmDMHzGkkAjr8rHINTmjEWlgwDJejAEAxccr15mj/TrlYU/DTeDRCMwrfa2yBB4UKUP+sWXQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LTBktBhD9NhN+6Fvv5MPBZnvlU929LAlkLez4DyrJ0=;
 b=Zi/1lu3lLmBAzvBrcI7daD7ujw3ocy9XnHODZAQWzJqf3WGyX77df+hyermUmPSW/lvOdYdV4nqOeAuRGXHbfOf4KG7yw7A/XFmYTDortdQiGtDml/t8gIDVxgXIzjLKjv3yw0zlXWoo6JmLqI25AXudbMYZIsELPHffKvNw0X7lPu/udwfam1z2wg/ixfQvQMjqxi51dOWcITQ/1xXxcGR+UsiU6MYTywZu96/g34SDdqhc3aPkoqZE3tnT4DUP38pZDDmwYuS61JzJvbOG9te5L1R0WMHbEpvyOD60pzYYI34PibgEU2fMTPU9gyDsAFgcHl7DvhDV2NIFE4lWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LTBktBhD9NhN+6Fvv5MPBZnvlU929LAlkLez4DyrJ0=;
 b=aw+h5s1TW5DvRMatxHWM0XpxIWfnCI8AfaDngOpqph8dg/8aWx5NvtNDZBEW27jPQvm2IwGAVNkHzvAyt8Uv74HIDQvf57k3nBwHIKvrayz8G0q/M+Gqlf/DMXSoZkksU8JV3INRhlR3qq0SUQZBdsshx5XSrfe7xKEbLIBTAao=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by BN8PR07MB7060.namprd07.prod.outlook.com (2603:10b6:408:de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 13:11:32 +0000
Received: from MW2NAM12FT070.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::c) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 13:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT070.mail.protection.outlook.com (10.13.180.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Wed, 1 Mar 2023 13:11:31 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTig021365
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 05:11:30 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Mar 2023 14:11:28 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 1 Mar 2023 14:11:28 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBSIo006147;
        Wed, 1 Mar 2023 14:11:28 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 321DBS2L006146;
        Wed, 1 Mar 2023 14:11:28 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH 1/7] phy: cadence-torrent: Add single link USXGMII configuration for 156.25MHz refclk
Date:   Wed, 1 Mar 2023 14:11:19 +0100
Message-ID: <20230301131125.6084-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230301131125.6084-1-sjakhade@cadence.com>
References: <20230301131125.6084-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT070:EE_|BN8PR07MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 723a5ae9-ea9e-4189-742e-08db1a5679fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+I7ADHslJkHbK7Yl1AjLA23uWJ4/19jsZR/lnndRK8eaJxEnXcZe+xaFippDpbrsWr5EaBoy9QlMLPlSHZrDZEPfO6Va9lcfKCmyBc//ZpQXl5A3ITlmh3P7N0MlooPRO5V6DV++xLA0MB4LR4fWVKo1owOH47oh0NVuv2hAgeOcyPM+5zZMHVEcsNaqDC1lDrCkhIef6F0Yr2oX0EIiRQCRHFkT9HMrJzMfNmqTikjc+h8XQ54iuY/dHlJgxvSSqwTdCGxREfXx/3/JKDn79HRS1mZwvdkFpzwFM4wp79F8IGYt7nuHsZLqANTKuL+lIgyQ796dwxxhvuqxXInQon7wDCjxSrF5MLRBiD57wVL5MTJMhAQPROw2VqpUKWybwQoAvIxdC/7cTE+BrtHV8VS5A8OxhzQ5vN++c5rGhq0pJZGYyp+SgTlossNieCKYHH0Tp1HkNGwIPk1S80Mug1dRDbK3dP92g+OFCnwBggrsCMAPIu4IX/FVPN5xAHuohMA8KGkZP/Qam8FtLBEIjlLbYsYG6+qk4mhaS30z6v89ZkwUy6kxXgwkD0O031wpiV5DKSHy1t4P/hjysunVy3RndHw+C0yIRLAcH/FulVycsx/u+WjgEDjLIbNb/zoZPTkbVHtVFWYmPNEDi/cOG+ubD3DD+y2iiv7u4E5YXP37FIqrgEjXxVbzj0LIu/j8hnhxk71kyAp/NoEv0SZKw==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36092001)(451199018)(36840700001)(40470700004)(46966006)(426003)(47076005)(478600001)(70206006)(70586007)(2906002)(6666004)(40460700003)(54906003)(110136005)(36756003)(2616005)(316002)(40480700001)(42186006)(26005)(1076003)(86362001)(186003)(83380400001)(336012)(356005)(7636003)(5660300002)(82740400003)(82310400005)(41300700001)(36860700001)(30864003)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:11:31.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723a5ae9-ea9e-4189-742e-08db1a5679fe
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT070.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB7060
X-Proofpoint-GUID: acjwJcMxQ2HzmNMKsUa9yOjYfcX01z07
X-Proofpoint-ORIG-GUID: acjwJcMxQ2HzmNMKsUa9yOjYfcX01z07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_09,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010111
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register sequences for single link USXGMII configuration supporting
156.25MHz reference clock frequency.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 233 +++++++++++++++++++++-
 1 file changed, 228 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 8bab6f9b75d0..d7b5ad82b81d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -27,13 +27,14 @@
 #define REF_CLK_19_2MHZ		19200000
 #define REF_CLK_25MHZ		25000000
 #define REF_CLK_100MHZ		100000000
+#define REF_CLK_156_25MHZ	156250000
 
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define NUM_SSC_MODE		3
-#define NUM_REF_CLK		3
-#define NUM_PHY_TYPE		6
+#define NUM_REF_CLK		4
+#define NUM_PHY_TYPE		7
 
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
@@ -106,6 +107,7 @@
 #define CMN_PLL0_HIGH_THR_M0		0x0093U
 #define CMN_PLL0_DSM_DIAG_M0		0x0094U
 #define CMN_PLL0_DSM_FBH_OVRD_M0	0x0095U
+#define CMN_PLL0_DSM_FBL_OVRD_M0	0x0096U
 #define CMN_PLL0_SS_CTRL1_M0		0x0098U
 #define CMN_PLL0_SS_CTRL2_M0            0x0099U
 #define CMN_PLL0_SS_CTRL3_M0            0x009AU
@@ -196,6 +198,10 @@
 #define RX_PSC_A2			0x0002U
 #define RX_PSC_A3			0x0003U
 #define RX_PSC_CAL			0x0006U
+#define RX_SDCAL0_INIT_TMR		0x0044U
+#define RX_SDCAL0_ITER_TMR		0x0045U
+#define RX_SDCAL1_INIT_TMR		0x004CU
+#define RX_SDCAL1_ITER_TMR		0x004DU
 #define RX_CDRLF_CNFG			0x0080U
 #define RX_CDRLF_CNFG3			0x0082U
 #define RX_SIGDET_HL_FILT_TMR		0x0090U
@@ -294,12 +300,14 @@ enum cdns_torrent_phy_type {
 	TYPE_SGMII,
 	TYPE_QSGMII,
 	TYPE_USB,
+	TYPE_USXGMII,
 };
 
 enum cdns_torrent_ref_clk {
 	CLK_19_2_MHZ,
 	CLK_25_MHZ,
-	CLK_100_MHZ
+	CLK_100_MHZ,
+	CLK_156_25_MHZ
 };
 
 enum cdns_torrent_ssc_mode {
@@ -403,6 +411,8 @@ struct cdns_torrent_data {
 						[NUM_SSC_MODE];
 	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					      [NUM_SSC_MODE];
+	struct cdns_torrent_vals *phy_pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						  [NUM_SSC_MODE];
 	struct cdns_torrent_vals *cmn_vals[NUM_REF_CLK][NUM_PHY_TYPE]
 					  [NUM_PHY_TYPE][NUM_SSC_MODE];
 	struct cdns_torrent_vals *tx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
@@ -644,6 +654,8 @@ static const char *cdns_torrent_get_phy_type(enum cdns_torrent_phy_type phy_type
 		return "QSGMII";
 	case TYPE_USB:
 		return "USB";
+	case TYPE_USXGMII:
+		return "USXGMII";
 	default:
 		return "None";
 	}
@@ -2243,6 +2255,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
+	struct cdns_torrent_vals *phy_pma_cmn_vals;
 	struct cdns_torrent_vals *pcs_cmn_vals;
 	struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
@@ -2257,9 +2270,9 @@ static int cdns_torrent_phy_init(struct phy *phy)
 
 	/**
 	 * Spread spectrum generation is not required or supported
-	 * for SGMII/QSGMII
+	 * for SGMII/QSGMII/USXGMII
 	 */
-	if (phy_type == TYPE_SGMII || phy_type == TYPE_QSGMII)
+	if (phy_type == TYPE_SGMII || phy_type == TYPE_QSGMII || phy_type == TYPE_USXGMII)
 		ssc = NO_SSC;
 
 	/* PHY configuration specific registers for single link */
@@ -2303,6 +2316,17 @@ static int cdns_torrent_phy_init(struct phy *phy)
 				     reg_pairs[i].val);
 	}
 
+	/* PHY PMA common registers configurations */
+	phy_pma_cmn_vals = init_data->phy_pma_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (phy_pma_cmn_vals) {
+		reg_pairs = phy_pma_cmn_vals->reg_pairs;
+		num_regs = phy_pma_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_phy_pma_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2616,6 +2640,9 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 	case REF_CLK_100MHZ:
 		cdns_phy->ref_clk_rate = CLK_100_MHZ;
 		break;
+	case REF_CLK_156_25MHZ:
+		cdns_phy->ref_clk_rate = CLK_156_25_MHZ;
+		break;
 	default:
 		dev_err(cdns_phy->dev, "Invalid Ref Clock Rate\n");
 		clk_disable_unprepare(cdns_phy->clk);
@@ -2735,6 +2762,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		case PHY_TYPE_USB3:
 			cdns_phy->phys[node].phy_type = TYPE_USB;
 			break;
+		case PHY_TYPE_USXGMII:
+			cdns_phy->phys[node].phy_type = TYPE_USXGMII;
+			break;
 		default:
 			dev_err(dev, "Unsupported protocol\n");
 			ret = -EINVAL;
@@ -2930,6 +2960,123 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
 };
 
+/* TI USXGMII configuration: Enable cmn_refclk_rcv_out_en */
+static struct cdns_reg_pairs ti_usxgmii_phy_pma_cmn_regs[] = {
+	{0x0040, PHY_PMA_CMN_CTRL1},
+};
+
+static struct cdns_torrent_vals ti_usxgmii_phy_pma_cmn_vals = {
+	.reg_pairs = ti_usxgmii_phy_pma_cmn_regs,
+	.num_regs = ARRAY_SIZE(ti_usxgmii_phy_pma_cmn_regs),
+};
+
+/* Single USXGMII link configuration */
+static struct cdns_reg_pairs sl_usxgmii_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs sl_usxgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_usxgmii_link_cmn_vals = {
+	.reg_pairs = sl_usxgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usxgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_usxgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_usxgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_usxgmii_xcvr_diag_ln_regs),
+};
+
+/* Single link USXGMII, 156.25 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sl_usxgmii_156_25_no_ssc_cmn_regs[] = {
+	{0x0014, CMN_SSM_BIAS_TMR},
+	{0x0028, CMN_PLLSM0_PLLPRE_TMR},
+	{0x00A4, CMN_PLLSM0_PLLLOCK_TMR},
+	{0x0028, CMN_PLLSM1_PLLPRE_TMR},
+	{0x00A4, CMN_PLLSM1_PLLLOCK_TMR},
+	{0x0062, CMN_BGCAL_INIT_TMR},
+	{0x0062, CMN_BGCAL_ITER_TMR},
+	{0x0014, CMN_IBCAL_INIT_TMR},
+	{0x0018, CMN_TXPUCAL_INIT_TMR},
+	{0x0005, CMN_TXPUCAL_ITER_TMR},
+	{0x0018, CMN_TXPDCAL_INIT_TMR},
+	{0x0005, CMN_TXPDCAL_ITER_TMR},
+	{0x024A, CMN_RXCAL_INIT_TMR},
+	{0x0005, CMN_RXCAL_ITER_TMR},
+	{0x000B, CMN_SD_CAL_REFTIM_START},
+	{0x0132, CMN_SD_CAL_PLLCNT_START},
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0014, CMN_PLL0_DSM_FBH_OVRD_M0},
+	{0x0014, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x0005, CMN_PLL0_DSM_FBL_OVRD_M0},
+	{0x0005, CMN_PLL1_DSM_FBL_OVRD_M0},
+	{0x061B, CMN_PLL0_VCOCAL_INIT_TMR},
+	{0x061B, CMN_PLL1_VCOCAL_INIT_TMR},
+	{0x0019, CMN_PLL0_VCOCAL_ITER_TMR},
+	{0x0019, CMN_PLL1_VCOCAL_ITER_TMR},
+	{0x1354, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x1354, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x1354, CMN_PLL0_VCOCAL_PLLCNT_START},
+	{0x1354, CMN_PLL1_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x0138, CMN_PLL0_LOCK_REFCNT_START},
+	{0x0138, CMN_PLL1_LOCK_REFCNT_START},
+	{0x0138, CMN_PLL0_LOCK_PLLCNT_START},
+	{0x0138, CMN_PLL1_LOCK_PLLCNT_START}
+};
+
+static struct cdns_reg_pairs usxgmii_156_25_no_ssc_tx_ln_regs[] = {
+	{0x07A2, TX_RCVDET_ST_TMR},
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3},
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0000, XCVR_DIAG_PSC_OVRD}
+};
+
+static struct cdns_reg_pairs usxgmii_156_25_no_ssc_rx_ln_regs[] = {
+	{0x0014, RX_SDCAL0_INIT_TMR},
+	{0x0062, RX_SDCAL0_ITER_TMR},
+	{0x0014, RX_SDCAL1_INIT_TMR},
+	{0x0062, RX_SDCAL1_ITER_TMR},
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x0030, RX_REE_SMGM_CTRL1},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x00B9, RX_DIAG_NQST_CTRL},
+	{0x0C21, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0002, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0033, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG}
+};
+
+static struct cdns_torrent_vals sl_usxgmii_156_25_no_ssc_cmn_vals = {
+	.reg_pairs = sl_usxgmii_156_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usxgmii_156_25_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals usxgmii_156_25_no_ssc_tx_ln_vals = {
+	.reg_pairs = usxgmii_156_25_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_156_25_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals usxgmii_156_25_no_ssc_rx_ln_vals = {
+	.reg_pairs = usxgmii_156_25_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_156_25_no_ssc_rx_ln_regs),
+};
+
 /* PCIe and DP link configuration */
 static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -4030,6 +4177,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[NO_SSC] = &usb_dp_link_cmn_vals,
 			},
 		},
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usxgmii_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_DP] = {
@@ -4123,6 +4275,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usxgmii_xcvr_diag_ln_vals,
+			},
+		},
 	},
 	.pcs_cmn_vals = {
 		[TYPE_USB] = {
@@ -4151,6 +4308,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 	},
+	.phy_pma_cmn_vals = {
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+			},
+		},
+	},
 	.cmn_vals = {
 		[CLK_19_2_MHZ] = {
 			[TYPE_DP] = {
@@ -4259,6 +4423,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usxgmii_156_25_no_ssc_cmn_vals,
+				},
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[CLK_19_2_MHZ] = {
@@ -4368,6 +4539,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &usxgmii_156_25_no_ssc_tx_ln_vals,
+				},
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[CLK_19_2_MHZ] = {
@@ -4477,6 +4655,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &usxgmii_156_25_no_ssc_rx_ln_vals,
+				},
+			},
+		},
 	},
 };
 
@@ -4575,6 +4760,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[NO_SSC] = &usb_dp_link_cmn_vals,
 			},
 		},
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usxgmii_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_DP] = {
@@ -4668,6 +4858,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usxgmii_xcvr_diag_ln_vals,
+			},
+		},
 	},
 	.pcs_cmn_vals = {
 		[TYPE_USB] = {
@@ -4696,6 +4891,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 	},
+	.phy_pma_cmn_vals = {
+		[TYPE_USXGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &ti_usxgmii_phy_pma_cmn_vals,
+			},
+		},
+	},
 	.cmn_vals = {
 		[CLK_19_2_MHZ] = {
 			[TYPE_DP] = {
@@ -4804,6 +5006,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usxgmii_156_25_no_ssc_cmn_vals,
+				},
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[CLK_19_2_MHZ] = {
@@ -4913,6 +5122,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &usxgmii_156_25_no_ssc_tx_ln_vals,
+				},
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[CLK_19_2_MHZ] = {
@@ -5022,6 +5238,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				},
 			},
 		},
+		[CLK_156_25_MHZ] = {
+			[TYPE_USXGMII] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &usxgmii_156_25_no_ssc_rx_ln_vals,
+				},
+			},
+		},
 	},
 };
 
-- 
2.34.1

