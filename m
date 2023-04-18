Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284A6E6B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjDRRdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjDRRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:33:42 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0BA7680
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:33:06 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFlILV026562;
        Tue, 18 Apr 2023 10:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1w+YxsHOF5HdNiDgVb2rnec436eVyv+a5mER3p7Qugs=;
 b=iRlOlOceLiJ1bZibXeJn41HoTbrRnXA1sE5jEEHNCS2xdn3evf2c3AYIDtPUlUc3XY8Q
 kNBGNh1hmKvQk+68A7gPtnlyb4dP3jLvW6fUbB/TgzjZ02ubB/NtcbUtaLLkHsI5pDEf
 Wm3RbJnRKEMBi8/aLQICDSzMHoAK6fJ7CW5kNonxoej+ZlJdtAqkOBINEUzLvuPVYnSH
 a8bTrZqWUPETlZUndu5oVgGP7smpwTSzcjm1+7oYAwv4xgeX6/0giJ6K7jR0FRV4NJCc
 ZBjxJQPihtaLYRvHmVcgwdCGq1XF6WUMo9Y4onvPPpOgogEubpSC8w6zcvp96Ho6ydSA qg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3q1x590e7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9vJH5ZNQvYZ7WuOdm1ZT15vY0bK29KIGsx5LeughiJr+e1Gd1a0fxJvu+ASbhOGeKYTSAoxyUJX9SzRpT99xkFwhqy1ILN/Fy8NiEI6HiB6/gpXulHPn3K19AkSBrXJR5tg7Tpxq94lWU+LJ0goIJVwjdIPckc2E3znT5Z8mlwtem39FnXe3KD9k2yCa+o2p7wyAX/j26iXK8axB55FqCIZNyBNZ0UU46YnaX++hjS03Xa7F2nrQ+o/74xpQreOfYpgsXZXPM9P26OwYCZl8RlSU3rVp0NBzB2disFQMr2uA+3BIrRfu3xZMQgnbsIs9twvGlsQagNuMcsgQbqcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w+YxsHOF5HdNiDgVb2rnec436eVyv+a5mER3p7Qugs=;
 b=e4INWckjCMBV87uwIO+fMRTXnH6TB8rKDw6ECLKVdwZJKEXUm257SAjYjtpmkXqFfgia3sHi/h0glekEoX7PxwGyyRl+GXU/kTQQ714TRZ8auatWvU3vEylqc34WWg/msItV6+dXbg08L5LAcSo5Y6gfss+VpH4hoyHrgSp5FbGeyyT2/rF7UPEr6+hMXbbnezYfq6NEZv0HaPddRpmFnaRoiZxHlcmXgkwyDR5HdB0Ezsg54vAQVUOHd16beUozGVd85lQ8/ZL3AOnCjYYWhoLs5flUnvj439dLtluNR32bzm0polNpbBZaE1a+9a7a8kb59XQRb9zDiebcQ4eqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w+YxsHOF5HdNiDgVb2rnec436eVyv+a5mER3p7Qugs=;
 b=F8HpAjEuXNPtxxevENlwmKIz8OOimo75RT9dK1ug7sO2qxrQ6RoNaw7TFKFlEhBWoI+m5shTKrZIsDk4l/ih1pfIMKhx24EdfcynzIdB4qRwDdYGwzEBQyoTisaolmSRK0pJoQfIyZZE1GWNK7dpoioDijZ19+7rxCJTbXiJ8o8=
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 BYAPR07MB7829.namprd07.prod.outlook.com (2603:10b6:a03:104::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:32:04 +0000
Received: from DM6NAM12FT089.eop-nam12.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::93) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 17:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT089.mail.protection.outlook.com (10.13.179.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.7 via Frontend Transport; Tue, 18 Apr 2023 17:32:03 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 33IHW1LC194661
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 10:32:03 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 18 Apr 2023 19:32:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHW050025673;
        Tue, 18 Apr 2023 19:32:00 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 33IHW0lK025667;
        Tue, 18 Apr 2023 19:32:00 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 2/4] phy: cadence-torrent: Prepare driver for multilink DP support
Date:   Tue, 18 Apr 2023 19:31:55 +0200
Message-ID: <20230418173157.25607-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230418173157.25607-1-sjakhade@cadence.com>
References: <20230418173157.25607-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT089:EE_|BYAPR07MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2a44ca-8892-469b-7544-08db4032d342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2ZY4QSfQML1EQG/gIcWkuwjRFAXycC9hrbihLY/gvwBJg9NQzHYK+P9T+0shsVKL8KG2/l8M/PWDvaM2pvM61tXfpMboIJ+4+MBr3zz6dAX4dycB8kS56Hda0I3B6DxTDJ6OTSizXlHY9qsknHExPjhQWEPAk4UiWC5VehTkY4YRVt1/8+ghMtw3xmVyU84ZSdnIOPDtoCMLP87Nk4xNgzt3A8LkSg5iE/gLomOeX8HxD82g6SC1N1E5+vRN1oPrbIFc+TvPk/MSI5Mot4pDMLoahbk8ezpVHPFFxEMwzoMxfVQwLLFauMU8Aa8FY0BjazrVPip2kUOPOOBpfTNBawuGZjNy0mB1j+Znx5GCFPpsFeLQUMVuSx3VeBZguTJY2OSbYq3asDcvUFSvowWNkrPAzm+0HGeWOm3ntSUtIZcGeF4I7pN/Mde9Unc5mOp6Ak+04xjJ+sAeuHcfOeLG7MorXK1hwCm3pljRRqhmHiAnIuUzyZEGMG4sATOADaDGWaCEz8epbC3YkcI6cOqnh8OU68oj9U+mZdjt6bODBo00YtMLtgnFN8zQmItVUiKT1TCgQE5/cj01SLdqLLHwnYPGPa/c/NMv1KEd+o4sNfe6BVDcKfAGWJL8YiC9oGnE8Ql8t6VpnHCit2LPv+uhKj1eFTkSBlNQ65WSvqi798+0fRcvscSDFPC5bzPTlM6QV1s9UNQ1NnjC3H8971NqzFJshun8NrGMYHnUgV5AFQ=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(2906002)(30864003)(82740400003)(40480700001)(40460700003)(66899021)(478600001)(6666004)(2616005)(83380400001)(47076005)(36860700001)(26005)(1076003)(426003)(336012)(36756003)(86362001)(186003)(41300700001)(316002)(8936002)(5660300002)(8676002)(82310400005)(110136005)(54906003)(42186006)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:32:03.9010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2a44ca-8892-469b-7544-08db4032d342
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT089.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7829
X-Proofpoint-ORIG-GUID: KdjVWV0Mb6Gc9NxssFc9h29QS1-zPKZG
X-Proofpoint-GUID: KdjVWV0Mb6Gc9NxssFc9h29QS1-zPKZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_13,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
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

This patch prepares driver for multilink DP support as well as for
multiprotocol PHY configurations involving DP as one of the required
protocols. This needs changes in functions configuring default single
link DP with master lane 0 to support non-zero master lane values and
associated PLL configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 305 ++++++++++++----------
 1 file changed, 168 insertions(+), 137 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index bf22948c4a4f..cef63d4a93b7 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -69,16 +69,11 @@
  */
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
-#define PMA_TX_ELEC_IDLE_MASK		0xF0U
 #define PMA_TX_ELEC_IDLE_SHIFT		4
-#define PHY_L00_RESET_N_MASK		0x01U
 #define PHY_PMA_XCVR_PLLCLK_EN		0x24
 #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
 #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
-#define PHY_POWER_STATE_LN_0	0x0000
-#define PHY_POWER_STATE_LN_1	0x0008
-#define PHY_POWER_STATE_LN_2	0x0010
-#define PHY_POWER_STATE_LN_3	0x0018
+#define PHY_POWER_STATE_LN(ln)		((ln) * 8)
 #define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
@@ -1009,12 +1004,13 @@ static int cdns_torrent_dp_get_pll(struct cdns_torrent_phy *cdns_phy,
  * Enable or disable PLL for selected lanes.
  */
 static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
+				      struct cdns_torrent_inst *inst,
 				      struct phy_configure_opts_dp *dp,
 				      bool enable)
 {
-	u32 rd_val;
-	u32 ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 rd_val, pll_ack_val;
+	int ret;
 
 	/*
 	 * Used to determine, which bits to check for or enable in
@@ -1024,28 +1020,18 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	/* Used to enable or disable lanes. */
 	u32 pll_val;
 
-	/* Select values of registers and mask, depending on enabled lane
-	 * count.
-	 */
-	switch (dp->lanes) {
-	/* lane 0 */
-	case (1):
-		pll_bits = 0x00000001;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		pll_bits = 0x00000003;
-		break;
-	/* lanes 0-3, all */
-	default:
-		pll_bits = 0x0000000F;
-		break;
-	}
+	/* Select values of registers and mask, depending on enabled lane count. */
+	pll_val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
 
-	if (enable)
-		pll_val = pll_bits;
-	else
-		pll_val = 0x00000000;
+	if (enable) {
+		pll_bits = ((1 << dp->lanes) - 1);
+		pll_val |= pll_bits;
+		pll_ack_val = pll_bits;
+	} else {
+		pll_bits = ((1 << inst->num_lanes) - 1);
+		pll_val &= (~pll_bits);
+		pll_ack_val = 0;
+	}
 
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
 
@@ -1053,22 +1039,23 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	ret = regmap_read_poll_timeout(regmap,
 				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
 				       rd_val,
-				       (rd_val & pll_bits) == pll_val,
+				       (rd_val & pll_bits) == pll_ack_val,
 				       0, POLL_TIMEOUT_US);
 	ndelay(100);
 	return ret;
 }
 
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   struct cdns_torrent_inst *inst,
 					   u32 num_lanes,
 					   enum phy_powerstate powerstate)
 {
 	/* Register value for power state for a single byte. */
-	u32 value_part;
-	u32 value;
-	u32 mask;
+	u32 value_part, i;
+	u32 value = 0;
+	u32 mask = 0;
 	u32 read_val;
-	u32 ret;
+	int ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (powerstate) {
@@ -1084,29 +1071,11 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	/* Select values of registers and mask, depending on enabled
-	 * lane count.
-	 */
-	switch (num_lanes) {
-	/* lane 0 */
-	case (1):
-		value = value_part;
-		mask = 0x0000003FU;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		value = (value_part
-			 | (value_part << 8));
-		mask = 0x00003F3FU;
-		break;
-	/* lanes 0-3, all */
-	default:
-		value = (value_part
-			 | (value_part << 8)
-			 | (value_part << 16)
-			 | (value_part << 24));
-		mask = 0x3F3F3F3FU;
-		break;
+	/* Select values of registers and mask, depending on enabled lane count. */
+
+	for (i = 0; i < num_lanes; i++) {
+		value |= (value_part << PHY_POWER_STATE_LN(i));
+		mask |= (PMA_XCVR_POWER_STATE_REQ_LN_MASK << PHY_POWER_STATE_LN(i));
 	}
 
 	/* Set power state A<n>. */
@@ -1121,7 +1090,8 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	return ret;
 }
 
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
+			       struct cdns_torrent_inst *inst, u32 num_lanes)
 {
 	unsigned int read_val;
 	int ret;
@@ -1142,12 +1112,12 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 
 	ndelay(100);
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
 					      POWERSTATE_A2);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, num_lanes,
 					      POWERSTATE_A0);
 
 	return ret;
@@ -1171,6 +1141,7 @@ static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 struct cdns_torrent_inst *inst,
 					 u32 rate, u32 num_lanes)
 {
 	unsigned int clk_sel_val = 0;
@@ -1203,14 +1174,17 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
+	if (cdns_phy->dp_pll & DP_PLL0)
+		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+				       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
+
+	if (cdns_phy->dp_pll & DP_PLL1)
+		cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+				       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + i],
 				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
 }
 
@@ -1219,23 +1193,44 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
  * set and PLL disable request was processed.
  */
 static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
+					  struct cdns_torrent_inst *inst,
 					  struct phy_configure_opts_dp *dp)
 {
-	u32 read_val, ret;
+	u32 read_val, field_val;
+	int ret;
 
-	/* Disable the cmn_pll0_en before re-programming the new data rate. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
+	/*
+	 * Disable the associated PLL (cmn_pll0_en or cmn_pll1_en) before
+	 * re-programming the new data rate.
+	 */
+	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
+	if (ret)
+		return ret;
+	field_val &= ~(cdns_phy->dp_pll);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
 
 	/*
 	 * Wait for PLL ready de-assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
+	 * For PLL1 - PHY_PMA_CMN_CTRL2[3] == 1
 	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     ((read_val >> 2) & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
-	if (ret)
-		return ret;
+	if (cdns_phy->dp_pll & DP_PLL0) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 2) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
+
+	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 3) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
 	ndelay(200);
 
 	/* DP Rate Change - VCO Output settings. */
@@ -1249,19 +1244,35 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 		/* PMA common configuration 100MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
 
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, dp->link_rate, dp->lanes);
 
-	/* Enable the cmn_pll0_en. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
+	/* Enable the associated PLL (cmn_pll0_en or cmn_pll1_en) */
+	ret = regmap_field_read(cdns_phy->phy_pma_pll_raw_ctrl, &field_val);
+	if (ret)
+		return ret;
+	field_val |= cdns_phy->dp_pll;
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, field_val);
 
 	/*
 	 * Wait for PLL ready assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
+	 * For PLL1 - PHY_PMA_CMN_CTRL2[1] == 1
 	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     (read_val & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
+	if (cdns_phy->dp_pll & DP_PLL0) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     (read_val & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+		if (ret)
+			return ret;
+	}
+
+	if ((cdns_phy->dp_pll & DP_PLL1) && cdns_phy->nsubnodes != 1)
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+						     read_val,
+						     ((read_val >> 1) & 0x01) != 0,
+						     0, POLL_TIMEOUT_US);
+
 	return ret;
 }
 
@@ -1329,6 +1340,7 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
 
 /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
+				       struct cdns_torrent_inst *inst,
 				       u32 num_lanes)
 {
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
@@ -1336,27 +1348,13 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 					     PHY_PMA_XCVR_POWER_STATE_REQ);
 	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
 					      PHY_PMA_XCVR_PLLCLK_EN);
+	u32 i;
 
-	/* Lane 0 is always enabled. */
-	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-		       PHY_POWER_STATE_LN_0);
-	pll_clk_en &= ~0x01U;
+	for (i = 0; i < num_lanes; i++) {
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK
+			     << PHY_POWER_STATE_LN(inst->mlane + i));
 
-	if (num_lanes > 1) {
-		/* lane 1 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_1);
-		pll_clk_en &= ~(0x01U << 1);
-	}
-
-	if (num_lanes > 2) {
-		/* lanes 2 and 3 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_2);
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_3);
-		pll_clk_en &= ~(0x01U << 2);
-		pll_clk_en &= ~(0x01U << 3);
+		pll_clk_en &= ~(0x01U << (inst->mlane + i));
 	}
 
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
@@ -1365,36 +1363,57 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 
 /* Configure lane count as required. */
 static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
+				     struct cdns_torrent_inst *inst,
 				     struct phy_configure_opts_dp *dp)
 {
-	u32 value;
-	u32 ret;
+	u32 value, i;
+	int ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	u8 lane_mask = (1 << dp->lanes) - 1;
+	u8 pma_tx_elec_idle_mask = 0;
+	u32 clane = inst->mlane;
+
+	lane_mask <<= clane;
 
 	value = cdns_torrent_dp_read(regmap, PHY_RESET);
 	/* clear pma_tx_elec_idle_ln_* bits. */
-	value &= ~PMA_TX_ELEC_IDLE_MASK;
+	pma_tx_elec_idle_mask = ((1 << inst->num_lanes) - 1) << clane;
+
+	pma_tx_elec_idle_mask <<= PMA_TX_ELEC_IDLE_SHIFT;
+
+	value &= ~pma_tx_elec_idle_mask;
+
 	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
 	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
-		 PMA_TX_ELEC_IDLE_MASK;
+		 pma_tx_elec_idle_mask;
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
-	/* reset the link by asserting phy_l00_reset_n low */
+	/* reset the link by asserting master lane phy_l0*_reset_n low */
 	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      value & (~PHY_L00_RESET_N_MASK));
+			      value & (~(1 << clane)));
 
 	/*
-	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
+	 * Assert lane reset on unused lanes and master lane so they remain in reset
 	 * and powered down when re-enabling the link
 	 */
-	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
+	for (i = 0; i < inst->num_lanes; i++)
+		value &= (~(1 << (clane + i)));
+
+	for (i = 1; i < inst->num_lanes; i++)
+		value |= ((1 << (clane + i)) & lane_mask);
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
-	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, dp->lanes);
 
 	/* release phy_l0*_reset_n based on used laneCount */
-	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
+	for (i = 0; i < inst->num_lanes; i++)
+		value &= (~(1 << (clane + i)));
+
+	for (i = 0; i < inst->num_lanes; i++)
+		value |= ((1 << (clane + i)) & lane_mask);
+
 	cdns_torrent_dp_write(regmap, PHY_RESET, value);
 
 	/* Wait, until PHY gets ready after releasing PHY reset signal. */
@@ -1405,41 +1424,44 @@ static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
 	ndelay(100);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	value = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
+	value |= (1 << clane);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, value);
 
-	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
+	ret = cdns_torrent_dp_run(cdns_phy, inst, dp->lanes);
 
 	return ret;
 }
 
 /* Configure link rate as required. */
 static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
+				    struct cdns_torrent_inst *inst,
 				    struct phy_configure_opts_dp *dp)
 {
-	u32 ret;
+	int ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A3);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, false);
 	if (ret)
 		return ret;
 	ndelay(200);
 
-	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
+	ret = cdns_torrent_dp_configure_rate(cdns_phy, inst, dp);
 	if (ret)
 		return ret;
 	ndelay(200);
 
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, inst, dp, true);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A2);
 	if (ret)
 		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, inst, dp->lanes,
 					      POWERSTATE_A0);
 	if (ret)
 		return ret;
@@ -1450,44 +1472,45 @@ static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
 
 /* Configure voltage swing and pre-emphasis for all enabled lanes. */
 static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
+					 struct cdns_torrent_inst *inst,
 					 struct phy_configure_opts_dp *dp)
 {
 	u8 lane;
 	u16 val;
 
 	for (lane = 0; lane < dp->lanes; lane++) {
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 					    TX_DIAG_ACYA);
 		/*
 		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
 		 * current state of the analog TX driver.
 		 */
 		val |= TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_DIAG_ACYA, val);
 
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_CTRL, 0x08A4);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       DRV_DIAG_TX_DRV, val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_MGNFS_MULT_000,
 				       val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_TXCC_CPOST_MULT_00,
 				       val);
 
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 					    TX_DIAG_ACYA);
 		/*
 		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
 		 * analog TX driver to reflect the new programmed one.
 		 */
 		val &= ~TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[inst->mlane + lane],
 				       TX_DIAG_ACYA, val);
 	}
 };
@@ -1506,7 +1529,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_lanes) {
-		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
+		ret = cdns_torrent_dp_set_lanes(cdns_phy, inst, &opts->dp);
 		if (ret) {
 			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
 			return ret;
@@ -1514,7 +1537,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_rate) {
-		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
+		ret = cdns_torrent_dp_set_rate(cdns_phy, inst, &opts->dp);
 		if (ret) {
 			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
 			return ret;
@@ -1522,7 +1545,7 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	}
 
 	if (opts->dp.set_voltages)
-		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+		cdns_torrent_dp_set_voltages(cdns_phy, inst, &opts->dp);
 
 	return ret;
 }
@@ -1590,6 +1613,7 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 {
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 	unsigned char lane_bits;
+	u32 val;
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
@@ -1597,18 +1621,23 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
 	 */
-	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst, inst->num_lanes);
 
 	/*
 	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
 	 * used lanes
 	 */
 	lane_bits = (1 << inst->num_lanes) - 1;
-	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
+
+	val = cdns_torrent_dp_read(regmap, PHY_RESET);
+	val |= (0xF & lane_bits);
+	val &= ~(lane_bits << 4);
+	cdns_torrent_dp_write(regmap, PHY_RESET, val);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	val = cdns_torrent_dp_read(regmap, PHY_PMA_XCVR_PLLCLK_EN);
+	val |= 1;
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, val);
 
 	/*
 	 * PHY PMA registers configuration functions
@@ -1627,7 +1656,7 @@ static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
 						       cdns_phy->max_bit_rate,
 						       false);
 
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, inst, cdns_phy->max_bit_rate,
 				     inst->num_lanes);
 
 	/* take out of reset */
@@ -1640,13 +1669,15 @@ static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
 {
 	int ret;
 
-	cdns_torrent_phy_on(phy);
+	ret = cdns_torrent_phy_on(phy);
+	if (ret)
+		return ret;
 
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
+	ret = cdns_torrent_dp_run(cdns_phy, inst, inst->num_lanes);
 
 	return ret;
 }
-- 
2.34.1

