Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0933E6A6EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCAOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCAOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:44:38 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64E43443;
        Wed,  1 Mar 2023 06:44:29 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AXp5e019065;
        Wed, 1 Mar 2023 05:11:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=26iQbvRdw40aZHKTX8xSxBoWHZKhazdPrUNxdwfgiq4=;
 b=FuS1cT5s6ccG5bysaHcDRcrL90yJqg/5mdMGX3/tGagIoHmMYyMCCMB5fh0/vzPur1Qp
 ivq63w6pnB3cSQ/TnSF8BRLTMg4O/14XA0e7hi6VFCHB61kZTz10II4fnAVxj7OJgauc
 UKWQ5/IRuP29UFPsujDFhVD4PljFUbVXZWwwe1f51qQzqg3C5P+G4vFGfCQD/xFzY93P
 UOntD3Ikg5hRdTXp/jek1d8XxXDxLzXXFywnnssyKlEKYClz/1QWcqOGjViNV94dvW+D
 z0ZYzffYwEy3fJ1qXIN+/D+2w0d7CaXpDqW+rX7oTNh8c004Qi+Axpga8c9X6jjREMlj 9g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3p25280kxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:11:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+rpmr/vgRmrC3cbvKRBkU/my1+sB1UKR4H9qQ6EMR4jzw+dxxbKBrw6Wro4MoLqO0xNwZXP63bDa0VwABJFUsirjHfIXS7tkqcV4FWtkRmMNafjfPYcIXr34Hen21ftEL6PFR34bLnITNNWXqFch1Jao6bcnJpSAY6KpUnI0JUxqOEc8slPgKL0ndl28FnBPBGUmR7d//aJsHxQvTVP1SbHxPM6v0UFSkLg3J/ARxJkjMalM6E5uHO1U7q572qg8tJ1oICBE70OKOHHZnjcLG7eWpr+562RwROeXXkoFqxTAkZB456zqttA2SCJ5S3ddVknNHeu6WMtZQbnjJV7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26iQbvRdw40aZHKTX8xSxBoWHZKhazdPrUNxdwfgiq4=;
 b=kKWUcFxTYR8OQWpzzIE4j4HwMU0ExpS1n7KoNKDNQbLxPYH6pIdwAZ9diDvioTQIUnf5ueIfYYA1wmpmmAc2Y51kM1r4E2rgGAxdJTiW1grsi6LGiITA0kB0wbPHw9ogCx9MaSINSREYu0ThUrfurriedfbSLsqHalRajiVkerSwXkwpGCXNR/iVkOuT0HmSq76ti1/+KHVIjn1tMp4bZCM4oScE8zdxzbMq1RfDTFD7U5G94oQ2hOdm4iWcquSb1ySt2agyVC96BktpwOAwq2oplpfhS09A9P09K6gQFvr4HXN4ZQTz5Oazoj18KXwOI+dLJINUqqD9VtZHwHarow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26iQbvRdw40aZHKTX8xSxBoWHZKhazdPrUNxdwfgiq4=;
 b=xYBnQs2paocWndch7MggGlPRYeeneNFTdMVhBZ4ktON40yRSZnBDcybVCrjI90+rPvoDCx4nK+eruKEM2whfTOjmbHJasZAA056PjHR7YEPlpkeQoi2aXtZeSxUjRKbfwLctOC7oUCudw2D/Jhy/aF3oRNSQKc2cAU35gBpuCrc=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by BL3PR07MB8898.namprd07.prod.outlook.com (2603:10b6:208:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 13:11:33 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::c4) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Wed, 1 Mar 2023 13:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.18 via Frontend Transport; Wed, 1 Mar 2023 13:11:33 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTii021365
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 05:11:32 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Mar 2023 14:11:29 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Wed, 1 Mar 2023 14:11:29 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 321DBTIh006164;
        Wed, 1 Mar 2023 14:11:29 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 321DBT8u006163;
        Wed, 1 Mar 2023 14:11:29 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>
Subject: [PATCH 4/7] phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink configuration
Date:   Wed, 1 Mar 2023 14:11:22 +0100
Message-ID: <20230301131125.6084-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230301131125.6084-1-sjakhade@cadence.com>
References: <20230301131125.6084-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT004:EE_|BL3PR07MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b7ead8-acc6-4081-7d34-08db1a567ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JS+/1DzKqC2ehR2QJfSRh9UqIJhnY2lIa4mUIFiNSDOYo857BDYHIu8+Xhh2IpDsnJ4+noX9KlvVIeORnWSGqs5hwy1UwQjcIZXXRMETCJyNhAFXYwTQjkbxNYbjbdghU5UUMNcoF+1qnrCpIl96CmM/vveS5I75jxywJ5ieek4SrBB9020qol3pRJZqFGSc5Bm4S83F3brbBPsuarsGAlCOpIOGMHCBJoSMT/kb7Gsu7t8lFD+2ll1Ge+4ZQ5pwIkoqakMSrF6XK0N3BTEcVIW16cf5LRy/52UQdm5uNOpQJZt/8CRcz9iDk9b+6eoASqdk52zJvGImvkBMXw+7Q9vHRBblyRjG99jMu/Zy/Miu5zW9Gee3HxFyQRh6ufQ6xC9WHMHoXclkcIIZqWg2Ie9pe4BtBAIy3gSPP78PMufpkz1uMGxcwDybtYesJCxgrNPy44g8MpXNcDKbWAtnw/yvq7djUxfXSlLclj/vmG0eR2DUi56CKVj2im00jaanXmQdV4rfeC3u/vnRsbxhTcqa7dy2mA/NPJB6nz04t/owZH3Frn/dxu43YNjJqIgIVXMtFgsZZTMpW9HNX9NzLc9N6PicCWdYLl78XBcsA02zm4lb0x2oiiD+4eF6N6CUIXsyMbybQsDNnIOl25aZ+pHoPsZa3hzSyGwc5L4RPsXsgwKqGdWzlfQlYd4TdkXkqNKyFDgSiBQieXEUzXSyyg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36092001)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(54906003)(42186006)(316002)(47076005)(426003)(336012)(110136005)(478600001)(83380400001)(6666004)(1076003)(2616005)(40460700003)(186003)(26005)(8936002)(356005)(86362001)(2906002)(41300700001)(5660300002)(30864003)(70206006)(70586007)(40480700001)(8676002)(36860700001)(82740400003)(4326008)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:11:33.0767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b7ead8-acc6-4081-7d34-08db1a567ac5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8898
X-Proofpoint-GUID: JL16YbRf5CNbr9bH4moWog8i8EsgHdGn
X-Proofpoint-ORIG-GUID: JL16YbRf5CNbr9bH4moWog8i8EsgHdGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_09,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
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

Torrent(SD0801) PHY supports one external and one internal reference
clocks. Add support for dual reference clock multilink configurations.
Add register sequences for PCIe(100MHz) + USXGMII(156.25MHz) multilink
configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 194 +++++++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 52b2e3c2d299..9565359cccbf 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -357,7 +357,9 @@ struct cdns_torrent_phy {
 	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
+	struct clk *clk1;
 	enum cdns_torrent_ref_clk ref_clk_rate;
+	enum cdns_torrent_ref_clk ref_clk1_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
 	const struct cdns_torrent_data *init_data;
@@ -2461,9 +2463,11 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk1 = cdns_phy->ref_clk1_rate;
 	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2;
+	struct cdns_torrent_vals *phy_pma_cmn_vals;
 	struct cdns_torrent_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
@@ -2490,6 +2494,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			 * Get the array values as [phy_t2][phy_t1][ssc].
 			 */
 			swap(phy_t1, phy_t2);
+			swap(ref_clk, ref_clk1);
 		}
 
 		mlane = cdns_phy->phys[node].mlane;
@@ -2553,9 +2558,22 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 					     reg_pairs[i].val);
 		}
 
+		/* PHY PMA common registers configurations */
+		phy_pma_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
+							     CLK_ANY, CLK_ANY,
+							     phy_t1, phy_t2, ANY_SSC);
+		if (phy_pma_cmn_vals) {
+			reg_pairs = phy_pma_cmn_vals->reg_pairs;
+			num_regs = phy_pma_cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_phy_pma_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
 		/* PMA common registers configurations */
 		cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
-						     ref_clk, ref_clk,
+						     ref_clk, ref_clk1,
 						     phy_t1, phy_t2, ssc);
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
@@ -2568,7 +2586,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 
 		/* PMA TX lane registers configurations */
 		tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
-						       ref_clk, ref_clk,
+						       ref_clk, ref_clk1,
 						       phy_t1, phy_t2, ssc);
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
@@ -2583,7 +2601,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 
 		/* PMA RX lane registers configurations */
 		rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
-						       ref_clk, ref_clk,
+						       ref_clk, ref_clk1,
 						       phy_t1, phy_t2, ssc);
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
@@ -2685,9 +2703,11 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
+	unsigned long ref_clk1_rate;
 	unsigned long ref_clk_rate;
 	int ret;
 
+	/* refclk: Input reference clock for PLL0 */
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(cdns_phy->clk)) {
 		dev_err(dev, "phy ref clock not found\n");
@@ -2726,7 +2746,54 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 		return -EINVAL;
 	}
 
+	/* refclk1: Input reference clock for PLL1 */
+	cdns_phy->clk1 = devm_clk_get_optional(dev, "refclk1");
+	if (IS_ERR(cdns_phy->clk1)) {
+		dev_err(dev, "phy ref clock1 not found\n");
+		return PTR_ERR(cdns_phy->clk1);
+	}
+
+	if (cdns_phy->clk1) {
+		ret = clk_prepare_enable(cdns_phy->clk1);
+		if (ret) {
+			dev_err(cdns_phy->dev, "Failed to prepare ref clock1\n");
+			clk_disable_unprepare(cdns_phy->clk);
+			return ret;
+		}
+
+		ref_clk1_rate = clk_get_rate(cdns_phy->clk1);
+		if (!ref_clk1_rate) {
+			dev_err(cdns_phy->dev, "Failed to get ref clock1 rate\n");
+			goto refclk1_err;
+		}
+
+		switch (ref_clk1_rate) {
+		case REF_CLK_19_2MHZ:
+			cdns_phy->ref_clk1_rate = CLK_19_2_MHZ;
+			break;
+		case REF_CLK_25MHZ:
+			cdns_phy->ref_clk1_rate = CLK_25_MHZ;
+			break;
+		case REF_CLK_100MHZ:
+			cdns_phy->ref_clk1_rate = CLK_100_MHZ;
+			break;
+		case REF_CLK_156_25MHZ:
+			cdns_phy->ref_clk1_rate = CLK_156_25_MHZ;
+			break;
+		default:
+			dev_err(cdns_phy->dev, "Invalid Ref Clock1 Rate\n");
+			goto refclk1_err;
+		}
+	} else {
+		cdns_phy->ref_clk1_rate = cdns_phy->ref_clk_rate;
+	}
+
 	return 0;
+
+refclk1_err:
+	clk_disable_unprepare(cdns_phy->clk1);
+	clk_disable_unprepare(cdns_phy->clk);
+	return -EINVAL;
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
@@ -2982,6 +3049,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
 	clk_disable_unprepare(cdns_phy->clk);
+	clk_disable_unprepare(cdns_phy->clk1);
 clk_cleanup:
 	cdns_torrent_clk_cleanup(cdns_phy);
 	return ret;
@@ -3000,6 +3068,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(cdns_phy->clk);
+	clk_disable_unprepare(cdns_phy->clk1);
 	cdns_torrent_clk_cleanup(cdns_phy);
 
 	return 0;
@@ -3037,6 +3106,100 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
 };
 
+/* PCIe and USXGMII link configuration */
+static struct cdns_reg_pairs pcie_usxgmii_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
+	{0x0400, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs pcie_usxgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs usxgmii_pcie_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0089, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_usxgmii_link_cmn_vals = {
+	.reg_pairs = pcie_usxgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_usxgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_usxgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_usxgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_usxgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals usxgmii_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = usxgmii_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_pcie_xcvr_diag_ln_regs),
+};
+
+/*
+ * Multilink USXGMII, using PLL1, 156.25 MHz Ref clk, no SSC
+ */
+static struct cdns_reg_pairs ml_usxgmii_pll1_156_25_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0014, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x0005, CMN_PLL1_DSM_FBL_OVRD_M0},
+	{0x061B, CMN_PLL1_VCOCAL_INIT_TMR},
+	{0x0019, CMN_PLL1_VCOCAL_ITER_TMR},
+	{0x1354, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x1354, CMN_PLL1_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x0138, CMN_PLL1_LOCK_REFCNT_START},
+	{0x0138, CMN_PLL1_LOCK_PLLCNT_START},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs ml_usxgmii_156_25_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3 },
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0000, XCVR_DIAG_PSC_OVRD}
+};
+
+static struct cdns_reg_pairs ml_usxgmii_156_25_no_ssc_rx_ln_regs[] = {
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
+static struct cdns_torrent_vals ml_usxgmii_pll1_156_25_no_ssc_cmn_vals = {
+	.reg_pairs = ml_usxgmii_pll1_156_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_pll1_156_25_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_tx_ln_vals = {
+	.reg_pairs = ml_usxgmii_156_25_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_rx_ln_vals = {
+	.reg_pairs = ml_usxgmii_156_25_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_rx_ln_regs),
+};
+
 /* TI USXGMII configuration: Enable cmn_refclk_rcv_out_en */
 static struct cdns_reg_pairs ti_usxgmii_phy_pma_cmn_regs[] = {
 	{0x0040, PHY_PMA_CMN_CTRL1},
@@ -4169,6 +4332,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
@@ -4185,6 +4349,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &pcie_usxgmii_link_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
@@ -4197,6 +4362,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
@@ -4213,6 +4379,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &usxgmii_pcie_xcvr_diag_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
@@ -4288,6 +4455,11 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_cmn_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &sl_usxgmii_156_25_no_ssc_cmn_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_pll1_156_25_no_ssc_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
@@ -4355,6 +4527,11 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
@@ -4422,6 +4599,11 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
 };
 
 static const struct cdns_torrent_data cdns_map_torrent = {
@@ -4455,6 +4637,7 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 
 static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
@@ -4522,6 +4705,11 @@ static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
-- 
2.34.1

