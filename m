Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306C56A45DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjB0PTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjB0PTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:19:14 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EA20D27
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:19:10 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R9eNb1009851;
        Mon, 27 Feb 2023 05:31:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=LotoLEBc5EZRhqHDOwbl71ULstg1Sl6rYn8VRK43HzY=;
 b=LG8lJTzld6lIAfqwQWf9t+pvYJ6jGilhO6sUb5YBCrIa1QeTv+Pr9dGH9ORGDqLOzImZ
 PLsxmpGIY8SlU44WE0DaqgcMCOBrkp8Pw9B+mtvplQbgNwROmEBWX91uOyC2HljjtoA9
 0386QDPrvHrAm/SOr/YCBawy5EWvIjNbXpOuA9kZQPVLFNxKDK+tPSD8FRIUtKDo9oUV
 qkoejQ82QxH8PNIfLzTf5nJtizTZ3VWD8rD2hVsr1Kdz3iLvVNqFqgtD4cFqELuS2KvA
 aywjtofBYq9LN7UF7GXieMqFZka8LYzfNa+znvfM2XDpPKvPVGiglFrKw0O4H3XHk25v xQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3nyfs56yxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 05:31:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdHwNEjkU5ixSX4S8DyysGR3ZCCEcrirHfOm6fUR1blHSsCagv7AUDVvXzsr3MrnVJ7L2ocu01YqpPJbWAgWclcUKegP8A1ifDCGoSOSvyGmb/0HwVTUlsfvpUBFVP1Hr5KlYGfuJ3eFx/BZs2MFUG3pTbbQPp7a65CkV2iF0/P3hwru0ezCSnKzrzYE2UORPaviZz4LKMj53J6P+nFwbJDySQ7h4mDexQcTi0Mwzg6K1bw9XF6ARvCMGFu+np9jFIZ3FOu+pCUD+7WZyfeTZPK0sZfJ3r+23E6rtRU/HQgmsKuD4IWEZHqV61b/MjsO55yz4ZMBD89Sl6nTJW7XlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LotoLEBc5EZRhqHDOwbl71ULstg1Sl6rYn8VRK43HzY=;
 b=k8cAqvhsqlY7YNhpYYX191Lb8yZs+mv4Wep9oAn1D7Uc2WFxhrxayryW1ZCTv3ucaKUk8skDCo1dpluZVoauv/ATgS6wLMaeHeQdULu06gUE/oG+bW2V1wrUWyZouFghDv2Qkeudx4SwD36tXyyjBXHko3v0TkoUWEz3h4JBvO5c7ZgdVrYPuAilh/22hF49YUslFZSrUdRb+DiWBLwL+g8HoE2OD9HTIKwZb0SGtQaJSQr+Xgir6lfk9x8dFpcY2LqGDEt1J9jCt6oZeL69B+Mvdi2JDUW7BwbwDXXailEHM9U3J/3k+nZrdE/673ffeYLZb0BsGOSR17N/lRR3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LotoLEBc5EZRhqHDOwbl71ULstg1Sl6rYn8VRK43HzY=;
 b=umzUx094UwLtwlZQT8Hr2FkuT0RP96pxJcwMuBw1WTcTzTg5tUbFhx169Rt9CZxsTZCaB9mQHfSia/nuZvRAKUtCo9Mr2H5GHvUSfDZ69v5L8qOXFbYFtdDFb5cAxpIrzTdMN7bRbZb8ECp9IoZW9908y5IbujICOojyDCXGzVQ=
Received: from DS7PR03CA0031.namprd03.prod.outlook.com (2603:10b6:5:3b5::6) by
 CY8PR07MB9641.namprd07.prod.outlook.com (2603:10b6:930:56::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Mon, 27 Feb 2023 13:31:12 +0000
Received: from DM6NAM12FT083.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::6c) by DS7PR03CA0031.outlook.office365.com
 (2603:10b6:5:3b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 13:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT083.mail.protection.outlook.com (10.13.178.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 13:31:11 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 31RDV7PL136144
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 27 Feb 2023 05:31:08 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Feb 2023 14:31:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 27 Feb 2023 14:31:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV6IZ029854;
        Mon, 27 Feb 2023 14:31:06 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 31RDV669029853;
        Mon, 27 Feb 2023 14:31:06 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>
Subject: [PATCH v2 1/4] phy: cadence-torrent: Add function to get PLL to be configured for DP
Date:   Mon, 27 Feb 2023 14:31:01 +0100
Message-ID: <20230227133104.29788-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230227133104.29788-1-sjakhade@cadence.com>
References: <20230227133104.29788-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT083:EE_|CY8PR07MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 32693176-0cb9-4567-b3c7-08db18c6e418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Fty4kHD2u//GLuB4AhvXRf2Duc+OU2JT6/o0Taq3pZm+5oqGNatJa4IUrt2jL62KwERLuKCH5G8PNtakzVvUnjavg7JHAEOaYkHXRGkZj1AZP24i3GKOfLKxlwVTiwA7EmKvjlbAVu8ARKXxtPTtmMQ2Dp8zzskjTNNlcHFoloBYzTKk8zoW1XVua9HrpCVb9pbFXMq2wvHLnoZUvDnIybuSXirWv5Rjdsdu6TwwW5LGzP3U1+jfQu07A4X3zVR2UeZCxOSOzzeAhJjB+7HWyYmmAJ5SL8bWzgCAU9szca8TT30AxzkfiQAWYASAQYp9cx7EkmiUyHSpfhfAGQwMPIYjtVTp7pH36D9Jgf6+lHSeGT9siNc0RxAL/s1hSKAkvG8XQAxLXHr1x62uJRV/JirJoiRqo84lZ1Qe3gOG73qkEDutvGRW/lcAxRECBug+OxqIdQI3IgoMdutpHmXW4iLsxp1xZXN03zO/zfMca/7HvJS6wEzl12wlV4bnrOvGgSFv2kanbeQDKUXbfe4SA/WtKOibX9Puuzn5C/aN2QBOFp4ZDS/1F0LWTZau+rBSOCpVu5oOKXm459Tz8IQ25Nhqd+4x1NUDSl6Gid92gZvS3JXvRQRPe8N9Dc4OCBaXpunguA0D0WHTzHqukwGVvnDWoDNpHr5Z/nphsgiuzuINoeG44Y7xYyX1K5IFlSyuHRkb37dWjoV443uoFIgB28Dr8cu5aI8+TofI5inGTA=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(6666004)(1076003)(336012)(2616005)(26005)(186003)(70586007)(316002)(54906003)(41300700001)(4326008)(8676002)(70206006)(110136005)(42186006)(2906002)(8936002)(81166007)(82740400003)(36860700001)(86362001)(356005)(82310400005)(478600001)(5660300002)(40480700001)(426003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:31:11.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32693176-0cb9-4567-b3c7-08db18c6e418
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT083.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9641
X-Proofpoint-ORIG-GUID: m2iEBk0lJQgsYtymb1R-5iD3rKEzIKBH
X-Proofpoint-GUID: m2iEBk0lJQgsYtymb1R-5iD3rKEzIKBH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index f099053c583c..c54bafbc7c9d 100644
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

