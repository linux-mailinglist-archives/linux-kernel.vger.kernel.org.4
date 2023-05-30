Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F57168BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjE3QJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjE3QI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:08:59 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC601A5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:08:26 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDnV0w015565;
        Tue, 30 May 2023 07:39:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=URtpxNLLM5uAIqtbBvzNg9wWzg866jGHoGUndX/lN5E=;
 b=HPy3IwFEu67Mqpmk9AcKGXpTH586vH40zpaW2bU7MnCV7sY0D7UVxDGZDMslAgqACmTs
 m11Qxzre/gc+Pu9xJfmoxV4Wb4ZsZK7cF97pumx7ozJniX2Q5sW7QmrFCDvw8SW1+zfR
 amvBJRpUbhMpIM7qWUp9dHNJKO98uKgSjassLbvXD/3ntfrxmwP8jqx/aI3Ztr+JTivl
 NJdKirZ5HO19SwJj7C3oOfePI6yMjZII8894bLY8nQzYmOlwYH8FcRsDGimqowFEs2SH
 IHZVb4Ridi7DxI6LGwum1gmS+TaONlb8opzBB5heDm81gVGGQKudE17oV8CZEry3Ms3t QQ== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qudex179u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qs+JLUazk0ZBhDra1VocjWsvo/pS2rQA2IHj5k4E5sOmtIy1QDGIJRkiuoaEMhRt8WJkHcfUOdQhJy/P7tpHeIndcsE9MyoxLzUStJU54tZusX48broLK4/hKMM6JO2KKf4d0C2no/Bk4uvWCsn14RnxfcA3XeaYoTRIrSSNnUCZuFN6YUNNVtke47R9+qpEiq/7Do3K3QXtNQ7kX/QepjlEQcx+fOJMVYDDsrqpndOuLKxVknyVl1F1w4oSyvyoqFXFIMBG2I0yyuUbRX/s/a5C/E+21G9m+x7SBUtkhUmaWRieqlnhO4SNZYezbbvXhY2jeZwrUVPcoz4PxXDfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URtpxNLLM5uAIqtbBvzNg9wWzg866jGHoGUndX/lN5E=;
 b=TXIdi5q86yLEiFG2gRtR+XJIlyPlhN1BiBkPIfeqJzJ37GRxJheC1CthMxy6SotseJAVuSH3QM0vJaXwww/Q/YZf4NHQDFdAu/e+wvCu8yjwr1ohEzoKZmOQZA6PuVhx+tMagvrbseG6ganfTfPP/yD5qEIc0wWWWaFj1hIDWy9uk/CyDnSupm+1ZQICcNR1dKYiISI08A8DVtYQFJQPob5StWuUOx7X4eFcIVH5ZpSBSDuR58zMU7SJ8a5OtV4ROFIPNOJ7bzK/3bcA8TeH8sreA16ZXYq7/zMvMq5oLuZeF8Mj3JuOCv4Uci0v624eesJkRwSN+136dsTKlfhD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URtpxNLLM5uAIqtbBvzNg9wWzg866jGHoGUndX/lN5E=;
 b=KVBdzm3DkBWHWaP2iP5lUcEib6G+CteNu6bpPX2baQpJal/TMnyk5C7dATa4wxer0YKC2+MJyjZ+LhB4ZuiU3Qt92ggBhQLzqU9+mrWSQotIX/wlNUzWWDBG3aAu8+ZjFxeRy+fu2ILHDLzEw9CpKDZKnHV1EB2zP+LiFmxFHM8=
Received: from BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6)
 by BY5PR07MB7235.namprd07.prod.outlook.com (2603:10b6:a03:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:39:02 +0000
Received: from MW2NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:a03:254:cafe::be) by BY3PR05CA0001.outlook.office365.com
 (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT029.mail.protection.outlook.com (10.13.181.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.7 via Frontend Transport; Tue, 30 May 2023 14:39:01 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 34UEcwIi032349
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 07:39:00 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 May 2023 16:38:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Tue, 30 May 2023 16:38:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 34UEcviB026620;
        Tue, 30 May 2023 16:38:57 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 34UEcuwt026619;
        Tue, 30 May 2023 16:38:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 2/2] phy: cadence-torrent: Use key:value pair table for all settings
Date:   Tue, 30 May 2023 16:38:53 +0200
Message-ID: <20230530143853.26571-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230530143853.26571-1-sjakhade@cadence.com>
References: <20230530143853.26571-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT029:EE_|BY5PR07MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c42d53f-f7f7-424e-635c-08db611b9c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rxw2GhuSYs6jdB/eVXxOdlcpieU9CSQRAqumdttt2uXR759+8b48inCBXKYriNkrQ5wy7ySF6fZ0SNjHKyfCGis7i2+bwiLE71JFPBGrRnDc91/1PO1g70RzeFrk4EjXOt6G+rmubAQgNqMkeRVKJNB83kUllEO07HQjyOhHX5jW7O3jAcW9NV8QrefaD4NgBKb02ch2jzO0ErwUgI2IYuPjw0lplZ/V2wlasnRyILBCc0NboRjBTYW81Nlmc8/+U+SjH2hKOi3pBVDmZxAxb9g0c77m4DdFKcD5uCeUtFjsX/ENPak7FEhtD8/WFKmvbJ5YR6jopdIJHxZgk01HRNxpUiyFa55C2FksIAH/cGdNrj5ToWp625s//6iRszUlUU0S3XvNbKYiMVISVn3c8TD7biEBiuZLDfAofpC1Qbz8qKouE/YrX4P0npBaZ5DS1J6DnKtFQSV+OA15NqbMfVcAX/DWbmOM7hkOeflzn6N/4V+BbgwwpWI8VgzHvtZ9J4Lks3/akVyU76lOcky8jHASXue/5En4R7C2o8XCxbd+tE/zjPoTizLeLH8QjhpUCJjUfWN4OcZ+IBsSnC/uJYI6ZHoo0xfn7I+tYk9aOXUya0QBjkQ8/57wvPS/CETtEpMs89LYApqUNTeAT24lDfl2gcxqmgOkOnZh4To+iMQBHRVlsnBDmvQXuiTJRly7c6Wq8j5TlD6Gjshvvai+iqMDNyf5qILJ5l3dkATWoDkMGQkYaQWKSJV0+3uWriE5
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39850400004)(376002)(396003)(36092001)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(86362001)(41300700001)(478600001)(40480700001)(40460700003)(4326008)(6666004)(316002)(36756003)(70586007)(70206006)(36860700001)(5660300002)(186003)(2906002)(30864003)(1076003)(26005)(2616005)(83380400001)(336012)(47076005)(426003)(8676002)(42186006)(54906003)(8936002)(82740400003)(356005)(7636003)(110136005)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:39:01.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c42d53f-f7f7-424e-635c-08db611b9c54
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7235
X-Proofpoint-ORIG-GUID: iKfEnMey3JjImnyry0u4-OlJPvrnbC4-
X-Proofpoint-GUID: iKfEnMey3JjImnyry0u4-OlJPvrnbC4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300117
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@kernel.org>

Instead of a 3D matrix use a key:value pair table for link_cmn_vals,
xcvr_diag_vals, pcs_cmn_vals, phy_pma_cmn_vals, cmn_vals,
tx_ln_vals and rx_ln_vals. This makes it scaleable for multiple
reference clocks.

Wherever both CDNS and TI use the same settings, reuse the same data.

Introduce CLK_ANY and ANY_SSC enums which are used if the setting
is independent of clock rate or SSC type.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1661 ++++++---------------
 1 file changed, 485 insertions(+), 1176 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index d4be3f098040..30ad0c5dd3a2 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -32,10 +32,6 @@
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
-#define NUM_SSC_MODE		3
-#define NUM_REF_CLK		4
-#define NUM_PHY_TYPE		7
-
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
 
@@ -307,15 +303,42 @@ enum cdns_torrent_ref_clk {
 	CLK_19_2_MHZ,
 	CLK_25_MHZ,
 	CLK_100_MHZ,
-	CLK_156_25_MHZ
+	CLK_156_25_MHZ,
+	CLK_ANY,
 };
 
 enum cdns_torrent_ssc_mode {
 	NO_SSC,
 	EXTERNAL_SSC,
-	INTERNAL_SSC
+	INTERNAL_SSC,
+	ANY_SSC,
 };
 
+/* Unique key id for vals table entry
+ * REFCLK0_RATE | REFCLK1_RATE | LINK0_TYPE | LINK1_TYPE | SSC_TYPE
+ */
+#define REFCLK0_SHIFT	12
+#define REFCLK0_MASK	GENMASK(14, 12)
+#define REFCLK1_SHIFT	9
+#define REFCLK1_MASK	GENMASK(11, 9)
+#define LINK0_SHIFT	6
+#define LINK0_MASK	GENMASK(8, 6)
+#define LINK1_SHIFT	3
+#define LINK1_MASK	GENMASK(5, 3)
+#define SSC_SHIFT	0
+#define SSC_MASK	GENMASK(2, 0)
+
+#define CDNS_TORRENT_KEY(refclk0, refclk1, link0, link1, ssc) \
+			((((refclk0) << REFCLK0_SHIFT) & REFCLK0_MASK) | \
+			(((refclk1) << REFCLK1_SHIFT) & REFCLK1_MASK) | \
+			(((link0) << LINK0_SHIFT) & LINK0_MASK) | \
+			(((link1) << LINK1_SHIFT) & LINK1_MASK) | \
+			(((ssc) << SSC_SHIFT) & SSC_MASK))
+
+#define CDNS_TORRENT_KEY_ANYCLK(link0, link1) \
+			CDNS_TORRENT_KEY(CLK_ANY, CLK_ANY, \
+					 (link0), (link1), ANY_SSC)
+
 struct cdns_torrent_inst {
 	struct phy *phy;
 	u32 mlane;
@@ -402,23 +425,26 @@ struct cdns_torrent_vals {
 	u32 num_regs;
 };
 
+struct cdns_torrent_vals_entry {
+	u32 key;
+	struct cdns_torrent_vals *vals;
+};
+
+struct cdns_torrent_vals_table {
+	struct cdns_torrent_vals_entry *entries;
+	u32 num_entries;
+};
+
 struct cdns_torrent_data {
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
-	struct cdns_torrent_vals *link_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					       [NUM_SSC_MODE];
-	struct cdns_torrent_vals *xcvr_diag_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-						[NUM_SSC_MODE];
-	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					      [NUM_SSC_MODE];
-	struct cdns_torrent_vals *phy_pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-						  [NUM_SSC_MODE];
-	struct cdns_torrent_vals *cmn_vals[NUM_REF_CLK][NUM_PHY_TYPE]
-					  [NUM_PHY_TYPE][NUM_SSC_MODE];
-	struct cdns_torrent_vals *tx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
-					    [NUM_PHY_TYPE][NUM_SSC_MODE];
-	struct cdns_torrent_vals *rx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
-					    [NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals_table link_cmn_vals_tbl;
+	struct cdns_torrent_vals_table xcvr_diag_vals_tbl;
+	struct cdns_torrent_vals_table pcs_cmn_vals_tbl;
+	struct cdns_torrent_vals_table phy_pma_cmn_vals_tbl;
+	struct cdns_torrent_vals_table cmn_vals_tbl;
+	struct cdns_torrent_vals_table tx_ln_vals_tbl;
+	struct cdns_torrent_vals_table rx_ln_vals_tbl;
 };
 
 struct cdns_regmap_cdb_context {
@@ -427,6 +453,24 @@ struct cdns_regmap_cdb_context {
 	u8 reg_offset_shift;
 };
 
+static struct cdns_torrent_vals *cdns_torrent_get_tbl_vals(const struct cdns_torrent_vals_table *tbl,
+							   enum cdns_torrent_ref_clk refclk0,
+							   enum cdns_torrent_ref_clk refclk1,
+							   enum cdns_torrent_phy_type link0,
+							   enum cdns_torrent_phy_type link1,
+							   enum cdns_torrent_ssc_mode ssc)
+{
+	int i;
+	u32 key = CDNS_TORRENT_KEY(refclk0, refclk1, link0, link1, ssc);
+
+	for (i = 0; i < tbl->num_entries; i++) {
+		if (tbl->entries[i].key == key)
+			return tbl->entries[i].vals;
+	}
+
+	return NULL;
+}
+
 static int cdns_regmap_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct cdns_regmap_cdb_context *ctx = context;
@@ -2276,7 +2320,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		ssc = NO_SSC;
 
 	/* PHY configuration specific registers for single link */
-	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
+	link_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->link_cmn_vals_tbl,
+						  CLK_ANY, CLK_ANY,
+						  phy_type, TYPE_NONE,
+						  ANY_SSC);
 	if (link_cmn_vals) {
 		reg_pairs = link_cmn_vals->reg_pairs;
 		num_regs = link_cmn_vals->num_regs;
@@ -2293,7 +2340,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 				     reg_pairs[i].val);
 	}
 
-	xcvr_diag_vals = init_data->xcvr_diag_vals[phy_type][TYPE_NONE][ssc];
+	xcvr_diag_vals = cdns_torrent_get_tbl_vals(&init_data->xcvr_diag_vals_tbl,
+						   CLK_ANY, CLK_ANY,
+						   phy_type, TYPE_NONE,
+						   ANY_SSC);
 	if (xcvr_diag_vals) {
 		reg_pairs = xcvr_diag_vals->reg_pairs;
 		num_regs = xcvr_diag_vals->num_regs;
@@ -2306,7 +2356,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PHY PCS common registers configurations */
-	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	pcs_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->pcs_cmn_vals_tbl,
+						 CLK_ANY, CLK_ANY,
+						 phy_type, TYPE_NONE,
+						 ANY_SSC);
 	if (pcs_cmn_vals) {
 		reg_pairs = pcs_cmn_vals->reg_pairs;
 		num_regs = pcs_cmn_vals->num_regs;
@@ -2317,7 +2370,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PHY PMA common registers configurations */
-	phy_pma_cmn_vals = init_data->phy_pma_cmn_vals[phy_type][TYPE_NONE][ssc];
+	phy_pma_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
+						     CLK_ANY, CLK_ANY,
+						     phy_type, TYPE_NONE,
+						     ANY_SSC);
 	if (phy_pma_cmn_vals) {
 		reg_pairs = phy_pma_cmn_vals->reg_pairs;
 		num_regs = phy_pma_cmn_vals->num_regs;
@@ -2328,7 +2384,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA common registers configurations */
-	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
+	cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
+					     ref_clk, ref_clk,
+					     phy_type, TYPE_NONE,
+					     ssc);
 	if (cmn_vals) {
 		reg_pairs = cmn_vals->reg_pairs;
 		num_regs = cmn_vals->num_regs;
@@ -2339,7 +2398,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA TX lane registers configurations */
-	tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
+	tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
+					       ref_clk, ref_clk,
+					       phy_type, TYPE_NONE,
+					       ssc);
 	if (tx_ln_vals) {
 		reg_pairs = tx_ln_vals->reg_pairs;
 		num_regs = tx_ln_vals->num_regs;
@@ -2352,7 +2414,10 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA RX lane registers configurations */
-	rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
+	rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
+					       ref_clk, ref_clk,
+					       phy_type, TYPE_NONE,
+					       ssc);
 	if (rx_ln_vals) {
 		reg_pairs = rx_ln_vals->reg_pairs;
 		num_regs = rx_ln_vals->num_regs;
@@ -2441,7 +2506,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		 * being configured, but these can be different for particular
 		 * PHY type and are per lane.
 		 */
-		link_cmn_vals = init_data->link_cmn_vals[phy_t1][phy_t2][ssc];
+		link_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->link_cmn_vals_tbl,
+							  CLK_ANY, CLK_ANY,
+							  phy_t1, phy_t2, ANY_SSC);
 		if (link_cmn_vals) {
 			reg_pairs = link_cmn_vals->reg_pairs;
 			num_regs = link_cmn_vals->num_regs;
@@ -2459,7 +2526,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 					     reg_pairs[i].val);
 		}
 
-		xcvr_diag_vals = init_data->xcvr_diag_vals[phy_t1][phy_t2][ssc];
+		xcvr_diag_vals = cdns_torrent_get_tbl_vals(&init_data->xcvr_diag_vals_tbl,
+							   CLK_ANY, CLK_ANY,
+							   phy_t1, phy_t2, ANY_SSC);
 		if (xcvr_diag_vals) {
 			reg_pairs = xcvr_diag_vals->reg_pairs;
 			num_regs = xcvr_diag_vals->num_regs;
@@ -2472,7 +2541,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PHY PCS common registers configurations */
-		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+		pcs_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->pcs_cmn_vals_tbl,
+							 CLK_ANY, CLK_ANY,
+							 phy_t1, phy_t2, ANY_SSC);
 		if (pcs_cmn_vals) {
 			reg_pairs = pcs_cmn_vals->reg_pairs;
 			num_regs = pcs_cmn_vals->num_regs;
@@ -2483,7 +2554,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA common registers configurations */
-		cmn_vals = init_data->cmn_vals[ref_clk][phy_t1][phy_t2][ssc];
+		cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
+						     ref_clk, ref_clk,
+						     phy_t1, phy_t2, ssc);
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
 			num_regs = cmn_vals->num_regs;
@@ -2494,7 +2567,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA TX lane registers configurations */
-		tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
+		tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
+						       ref_clk, ref_clk,
+						       phy_t1, phy_t2, ssc);
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
 			num_regs = tx_ln_vals->num_regs;
@@ -2507,7 +2582,9 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA RX lane registers configurations */
-		rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
+		rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
+						       ref_clk, ref_clk,
+						       phy_t1, phy_t2, ssc);
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
 			num_regs = rx_ln_vals->num_regs;
@@ -4080,1169 +4157,401 @@ static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_rx_ln_regs),
 };
 
+static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_NONE), &sl_dp_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_PCIE), &pcie_dp_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &usb_dp_link_cmn_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_NONE), NULL},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_SGMII), &pcie_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_link_cmn_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USB), &usb_sgmii_link_cmn_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USB), &usb_sgmii_link_cmn_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &pcie_usb_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_link_cmn_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
+};
+
+static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_NONE), &sl_dp_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_PCIE), &dp_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &dp_usb_xcvr_diag_ln_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_NONE), NULL},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_SGMII), &pcie_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_xcvr_diag_ln_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USB), &sgmii_usb_xcvr_diag_ln_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USB), &sgmii_usb_xcvr_diag_ln_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_xcvr_diag_ln_vals},
+
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
+};
+
+static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &usb_phy_pcs_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_phy_pcs_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_phy_pcs_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_phy_pcs_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_phy_pcs_cmn_vals},
+};
+
+static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &sl_dp_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), &sl_pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &sl_sgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &sgmii_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &sl_qsgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &qsgmii_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &sl_usxgmii_156_25_no_ssc_cmn_vals},
+};
+
+static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+};
+
+static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &dp_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+};
+
 static const struct cdns_torrent_data cdns_map_torrent = {
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
-	.link_cmn_vals = {
-		[TYPE_DP] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_dp_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_dp_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &pcie_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usxgmii_link_cmn_vals,
-			},
-		},
-	},
-	.xcvr_diag_vals = {
-		[TYPE_DP] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usxgmii_xcvr_diag_ln_vals,
-			},
-		},
+	.link_cmn_vals_tbl = {
+		.entries = link_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(link_cmn_vals_entries),
 	},
-	.pcs_cmn_vals = {
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-		},
+	.xcvr_diag_vals_tbl = {
+		.entries = xcvr_diag_vals_entries,
+		.num_entries = ARRAY_SIZE(xcvr_diag_vals_entries),
 	},
-	.phy_pma_cmn_vals = {
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-			},
-		},
+	.pcs_cmn_vals_tbl = {
+		.entries = pcs_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(pcs_cmn_vals_entries),
 	},
-	.cmn_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = NULL,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_usxgmii_156_25_no_ssc_cmn_vals,
-				},
-			},
-		},
+	.cmn_vals_tbl = {
+		.entries = cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(cmn_vals_entries),
 	},
-	.tx_ln_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = NULL,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usxgmii_156_25_no_ssc_tx_ln_vals,
-				},
-			},
-		},
+	.tx_ln_vals_tbl = {
+		.entries = cdns_tx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(cdns_tx_ln_vals_entries),
 	},
-	.rx_ln_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usxgmii_156_25_no_ssc_rx_ln_vals,
-				},
-			},
-		},
+	.rx_ln_vals_tbl = {
+		.entries = cdns_rx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(cdns_rx_ln_vals_entries),
 	},
 };
 
+static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
+};
+
+static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+};
+
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
-	.link_cmn_vals = {
-		[TYPE_DP] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_dp_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_dp_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &pcie_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &pcie_usb_link_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_sgmii_link_cmn_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_dp_link_cmn_vals,
-			},
-		},
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usxgmii_link_cmn_vals,
-			},
-		},
+	.link_cmn_vals_tbl = {
+		.entries = link_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(link_cmn_vals_entries),
 	},
-	.xcvr_diag_vals = {
-		[TYPE_DP] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &dp_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_dp_xcvr_diag_ln_vals,
-			},
-		},
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usxgmii_xcvr_diag_ln_vals,
-			},
-		},
+	.xcvr_diag_vals_tbl = {
+		.entries = xcvr_diag_vals_entries,
+		.num_entries = ARRAY_SIZE(xcvr_diag_vals_entries),
 	},
-	.pcs_cmn_vals = {
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-			[TYPE_DP] = {
-				[NO_SSC] = &usb_phy_pcs_cmn_vals,
-			},
-		},
+	.pcs_cmn_vals_tbl = {
+		.entries = pcs_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(pcs_cmn_vals_entries),
 	},
-	.phy_pma_cmn_vals = {
-		[TYPE_USXGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &ti_usxgmii_phy_pma_cmn_vals,
-			},
-		},
+	.phy_pma_cmn_vals_tbl = {
+		.entries = j721e_phy_pma_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(j721e_phy_pma_cmn_vals_entries),
 	},
-	.cmn_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = NULL,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_usxgmii_156_25_no_ssc_cmn_vals,
-				},
-			},
-		},
+	.cmn_vals_tbl = {
+		.entries = cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(cmn_vals_entries),
 	},
-	.tx_ln_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = NULL,
-					[EXTERNAL_SSC] = NULL,
-					[INTERNAL_SSC] = NULL,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = NULL,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usxgmii_156_25_no_ssc_tx_ln_vals,
-				},
-			},
-		},
+	.tx_ln_vals_tbl = {
+		.entries = ti_tx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(ti_tx_ln_vals_entries),
 	},
-	.rx_ln_vals = {
-		[CLK_19_2_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_25_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_100_MHZ] = {
-			[TYPE_DP] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_PCIE] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_SGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_QSGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_USB] = {
-					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				},
-			},
-			[TYPE_USB] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_PCIE] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_SGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_QSGMII] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-				[TYPE_DP] = {
-					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				},
-			},
-		},
-		[CLK_156_25_MHZ] = {
-			[TYPE_USXGMII] = {
-				[TYPE_NONE] = {
-					[NO_SSC] = &usxgmii_156_25_no_ssc_rx_ln_vals,
-				},
-			},
-		},
+	.rx_ln_vals_tbl = {
+		.entries = cdns_rx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(cdns_rx_ln_vals_entries),
 	},
 };
 
-- 
2.34.1

