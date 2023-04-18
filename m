Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF26E6B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjDRRdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjDRRdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:33:44 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1EA244
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:33:10 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFlO5U026604;
        Tue, 18 Apr 2023 10:32:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=c5mhZIzicKyVDhAx68DK5J/opc+HxCUNWpvWLHJyc18=;
 b=m+0dzIbJiLXs51wjN7qDA1L7+tIHcWd0XyFTFwgm1w6a9IwQ9CtBgdm7npp+TlGck8qN
 5TNG7u1izN/Pj2sAvB5NiRQdt14VTV2doZvu2wfIJbs5DP9Ge3RFnZfnRRktVe5G4nFo
 FYI2mBnD3ck/oF79nukkgN8ZExByWRfU/qp/H4wzoRlZ76G1DxsDF6bAAKIoKTIHVHoN
 kawDNxAbAwTulQtXxnvNrX1d+C8/SFGVnzQYg1a4Gb0pzgyUPyqNqfTfHrkQhm1uDyvS
 hFm1AeF1iB2z8Pt4z/Q1/Md3WCAQ/uxney2O2wLMDqVxNGvVphrcLGY8+M/FqcLHG63N Vw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3q1x590e8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:32:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOQtXXr2o5+YDpZ/PME1lqS5nkUWoEuLMa3S2bM7JCw+x14nq8KVaAeG0gog6htdBJLRWOO3QWVUmHgGHhbyq5k/aIO4oj5nTku6rhWGWycelWH/fH1nSmCUAT20OHJuTJApVPb0KboEL9c0f4mjOig001xJxB9oB4Ohf8o57pbb7kz7H0TM9epDg9XUvm0WvgKcU8g3II5rE9MBU7x6NDBzhguqjxw+l4x2FtlMLf+rmTrLE5JInoEXAD905vOZ+YDM4RcJ4A4xZ3X/Tv/twkb0pRBF08pm7xIBPKu4Diu1Oy9PW8AIKq6PwQH0uCRbryq+wwhQMv4lMYskhQMOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5mhZIzicKyVDhAx68DK5J/opc+HxCUNWpvWLHJyc18=;
 b=fqkOpP8zucM0K94Ud8N91qQSCGahINy3qLM1a7W40Yvw8UOEJdLqS9zD3QSy/3RElHPIOB+oVXXUEA2AXWqcIQUGtQRPQ9MhqxJzsysG3Qdmv0vIlYwc7BBHGQgQCgjGO5L36kjzg3C3pkrM7zVkqTN3KhNAUCk+d4zjiXoYnzptT2kQrJX8COwgdV2FFYzVc1Uzw/wsY3tVotAIM1JUdSpR4p7myIuVavyU6/1xRkXLEdUi6JAEtLscaQx/3DNrFejz9aWnINJIQGi0q9TSzvi7365TZYDRZsiO44HjmC+qLg2u133qFl7Ih61jD9TOANWICGVZudONZhxpsszW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5mhZIzicKyVDhAx68DK5J/opc+HxCUNWpvWLHJyc18=;
 b=blTX/6MABIVX8iJhLaphaa60VUXfvTJaSky5tcOmUigQWs16ro/ZXhiJ9bQbromVb1JUh+7cYDl5mK+plbUY7q3TscJyWkF0JYmO/Lstu56KGGFzuBB+NHZUbNRVnE+FN7KDgpeTaEOQXItArReVYfvAG6fkNgCSsCLWxW3+gAA=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by BLAPR07MB7554.namprd07.prod.outlook.com (2603:10b6:208:287::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:32:17 +0000
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::3f) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 17:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT056.mail.protection.outlook.com (10.13.179.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.6 via Frontend Transport; Tue, 18 Apr 2023 17:32:16 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 33IHWDVv194680
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 10:32:14 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHW0CK025664;
        Tue, 18 Apr 2023 19:32:00 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 33IHVxjk025663;
        Tue, 18 Apr 2023 19:31:59 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 1/4] phy: cadence-torrent: Add function to get PLL to be configured for DP
Date:   Tue, 18 Apr 2023 19:31:54 +0200
Message-ID: <20230418173157.25607-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230418173157.25607-1-sjakhade@cadence.com>
References: <20230418173157.25607-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT056:EE_|BLAPR07MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: e74bd1f5-e4c6-4c9e-62b2-08db4032da93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWbH109UASxfLPpRZmvrfuQZ8o7PPpX0xix/UTjOG0nADvhZkyRkMiXDH0zFwHTRgmrhnt6JpCeYSbOPRxjfimSKtekbk4+hgHAZq9Yq+B2sZnOacfw1wnABY9KL4mInKsTE0Pa6fj8lspN6XYWKaSb2GCcaWVHNbAl9Qaf6GJxAKzLFAxXTt81QEScnnWrBTOLMVqkTviv36mPC1fzLdWxGG2NW6T6ebGU5nZQLrFmH/6pg+royaRnulkPfwZdSRE0UYvwhL5iGa4CkO5kc4/uDNKYBy7yozH22qZIBJIOADKbJ3oR/1mt7h7AQn4Uzz5YG/NQKMWWoAyxN4H+56Hma1OCOgQspDGtAoMcfJ1W0p6h67kSGbUmV5ttTNVzXdVcpQ1GhuATg4fbVXfRgHqVWFSTGPKdDHh7Ix+BHd6WOUsOG4F0Us9/gAUb8cmhr7Kd2nZg+3cl5e8HV2EJMHFnXi+BF19X8igwRxGd8oZ0EqQOykTgyFRSlu74zjoR+LeGzYGJr5eq3Twc8/1ukm8oN7RQwUa0FIfZ/NYYV7RL9J0LfaYvHEM5X55XQs6AbP0moIuqPVkSQMfLMRmXFTbQQsS7IqdDZs40s6N6rsjlINPeY0YsBVV2rvuG1B3GbdF1zgn+Rj9CBehiWZ6tn678wQGV0oJUbyU7ZI3+ToORiwM5l45qWTUsYYA5vYM5fownJiPlizatrmCkHPTAgJ7Apecp03IJ1LUMud1ObcVS0Lt7R4Gz7iaVKQoPLjXWi
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36092001)(451199021)(46966006)(36840700001)(40470700004)(8936002)(36756003)(8676002)(40460700003)(2906002)(82310400005)(86362001)(5660300002)(40480700001)(478600001)(6666004)(54906003)(110136005)(42186006)(70206006)(186003)(2616005)(36860700001)(1076003)(70586007)(26005)(41300700001)(316002)(356005)(82740400003)(83380400001)(81166007)(47076005)(4326008)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:32:16.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74bd1f5-e4c6-4c9e-62b2-08db4032da93
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7554
X-Proofpoint-ORIG-GUID: vWJhGzVE6fYwj7c-baOj_mabABcEHe8r
X-Proofpoint-GUID: vWJhGzVE6fYwj7c-baOj_mabABcEHe8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 mlxlogscore=920 lowpriorityscore=0 malwarescore=0
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

Torrent PHY PLL0 or PLL1 is used for DP depending on the single link or
multilink protocol configuration for which PHY is configured. In multilink
configurations with other protocols, either PLL0 or PLL1 will be used
for DP. For single link DP, both PLLs need to be configured at POR.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 3831f596d50c..bf22948c4a4f 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -38,6 +38,9 @@
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
 
+#define DP_PLL0			BIT(0)
+#define DP_PLL1			BIT(1)
+
 #define TORRENT_COMMON_CDB_OFFSET	0x0
 
 #define TORRENT_TX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
@@ -323,6 +326,7 @@ struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	u32 dp_pll;
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
 	struct device *dev;
@@ -977,6 +981,30 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
 	}
 }
 
+/* Set PLL used for DP configuration */
+static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
+				   enum cdns_torrent_phy_type phy_t2)
+{
+	switch (phy_t2) {
+	case TYPE_PCIE:
+	case TYPE_USB:
+		cdns_phy->dp_pll = DP_PLL1;
+		break;
+	case TYPE_SGMII:
+	case TYPE_QSGMII:
+		cdns_phy->dp_pll = DP_PLL0;
+		break;
+	case TYPE_NONE:
+		cdns_phy->dp_pll = DP_PLL0 | DP_PLL1;
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Unsupported PHY configuration\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1627,6 +1655,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
 
 	switch (cdns_phy->ref_clk_rate) {
 	case CLK_19_2_MHZ:
@@ -1639,6 +1668,10 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		return -EINVAL;
 	}
 
+	ret = cdns_torrent_dp_get_pll(cdns_phy, TYPE_NONE);
+	if (ret)
+		return ret;
+
 	cdns_torrent_dp_common_init(cdns_phy, inst);
 
 	return cdns_torrent_dp_start(cdns_phy, inst, phy);
-- 
2.34.1

