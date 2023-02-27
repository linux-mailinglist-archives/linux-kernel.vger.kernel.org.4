Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9D6A42AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjB0Nbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB0Nbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:31:37 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43772054F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:31:33 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R8m4st008732;
        Mon, 27 Feb 2023 05:31:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=WHXNqDNr7jBMC5/VY+Co7N2B1NPE3RaRNS1Tg9dEyR8=;
 b=l5kZZY4HDD8Tb99hPUvqlILqvbjAbOws9xGXjkMJkPjsHuQcMPA8DQRZU/kgIYxe9A7z
 XyVtj9fOPJBl5xfM6yYQLGxGyOJq8aUmIWZ+wlO/VsiGkqGIePX7AhDWrQP4xCMsJjvY
 IOd2DyxTW6WCq7r3L06xjKm3TN/x6c74XFL1dyGDnL0S8BAiTOI5t+HcOglgP2ESKyvu
 YwaRJ1BvF0/bgDxZhA8+5YeMNVNT/BD4WZBPao/vKY6HcXam3wE+ggmxn6gTYYaWI++J
 1r1TLOAbXiGCMOjxJt7tl0H4FtghLQxKQ3nBWRifz0tYyFhGn2nuG6I879xzwHQ2Zinp Dg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3nyet6ys5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 05:31:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS170d903GDL321bEbedyxkBmyIg0rCLmuarSV/Zh4XmHpPdwzoRqFMTHQuvDsfKOzLO/1u2RmES8agaTqbApTNF9I4Y7YCyrtUs1QyYE52Rdr1AuSNuvWO26EMWhjjejWifCzYLuYlKGcgmI6UAIKQxAedZ8UolmAB+MciKGySEH+bx/CdUX8yMpoCPpF5LT0bSf+zm4NxiWF8X4xz0upxO3pN40fw7HAfjXWHrQqsLu/lS71AOM8tB7XgYa97MsqunsZmREb+DAc+ciBCJMvddzqWkC19QgPKaVFiWR/gl9ivnkOTIGcxP2EwsSaW6i8PqTj1Se7JEe6W0hQ8pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHXNqDNr7jBMC5/VY+Co7N2B1NPE3RaRNS1Tg9dEyR8=;
 b=oCpJ/Zw/GombXd9e9KrM+qlvI7Y6GcH92tDN9MpEiEOOsQ0xM92nJFGt4Letypyyv17bQmjUo5pq1RSB4KjFxm3F+u64RlArDACm4vxu8kw6FJCwWpEFmlZxzKLb8R9dj0ZIPomRgQcEfDFryz2AQMRMcUneVAseu4SglW2jv0HqIlFJzAWCUpug7n0AOS7dS4P8SYVA0KkVWuCb/5uvfKHvUf+6zNmK12m7Bf8FVEGK+xvPK5ixUsbXu9F7EiXX5XsML6juPNY9aPoOeNw6jB+8w/uXHibrCKWVz1M4Ffrt8SINJV7927oNmhjXpliJLOw++2eFgk3OdCS/P3x3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHXNqDNr7jBMC5/VY+Co7N2B1NPE3RaRNS1Tg9dEyR8=;
 b=RouOrcM72qOVoZjeWcUPk8qkfJghBt2xyy01/v86rWAnhGLmqsQowGwVVMEvrsBsgrYped0HmvPbMNG4DhENDD3BgnkiTpIiCDzOOdbI+oaJSMlvyJaeVYjUxztFNUwvno0N/s4PzjcuPHbZPeTMSGOzgspoiNF25QU1KldNLWs=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 CY4PR0701MB3730.namprd07.prod.outlook.com (2603:10b6:910:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 13:31:10 +0000
Received: from DM6NAM12FT105.eop-nam12.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::9b) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16 via Frontend
 Transport; Mon, 27 Feb 2023 13:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT105.mail.protection.outlook.com (10.13.178.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.5 via Frontend Transport; Mon, 27 Feb 2023 13:31:10 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV74j019544
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 05:31:09 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Feb 2023 14:31:07 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Mon, 27 Feb 2023 14:31:07 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 31RDV7L4029868;
        Mon, 27 Feb 2023 14:31:07 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 31RDV7kd029866;
        Mon, 27 Feb 2023 14:31:07 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>
Subject: [PATCH v2 3/4] phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MHz refclk
Date:   Mon, 27 Feb 2023 14:31:03 +0100
Message-ID: <20230227133104.29788-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230227133104.29788-1-sjakhade@cadence.com>
References: <20230227133104.29788-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT105:EE_|CY4PR0701MB3730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8541d0d8-1c8c-45ed-c831-08db18c6e3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoUJSL06bqmfYZCwEkxF41QKv0xRUBL+RueeOhpKdu7mTKN1lvz6Xpe5Rv9AMT9uqDMnblXM5gcdEc6Yxrz5S33h4P31yISPiDpUU7vnWWf0mrIDC+2WtPF0iMgoXa/+njx9WlArfPnpC7cBUwlIW/Qav/TqBrm8QwdUwCWm87V/c/2UQIDLgL7gxfS/TpZaZtvHVI6CnzDbSfkTjBQc/4fya7sP8KSc0jvr/XvRa6UfCMI9LtHBc34trK5oD1uab0OwmvwUQIvGSXM4qwwGrwDjv070oNWpqoKmjRqEGUVfpOS3ZvGD561AKIhasuiAWWNeQDiBHFCvtcZSUtBt3eLjf2nthOBndEDrecE2H6LakDkU9GpzbGgPCbKYBfWULdRbqV0JPwUUckSDyUtKoxb9oIkooz4Nnf0g4PzBpUXOq4QErUQWtu0UIsDatsgJa5xbzdYi3kzroQDIbS/GEn7GC/Ydi4sv9vCMOP8hK3PLxS1ZwpMrxnJVQZs2zX210W0Cl29RBd6aItHGCIMxU/P8BHelQrD4eFKEcnYt27gqiucEMmlyE63X1lcgTsD/iXxatbpRu/NEHLba7fMt9LqBSynzwpxIDx8dVaF5kpOf+kTxc8pQs4DcRyrI9e6w2Prm1Hho0rVZv8XI8dEUXpWhK0kBqjUlvIcHi86Bkm8cqqsW3NAR3fA1ixd+hc9NUA2QR+Q697S69gXdwD+vEQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36092001)(451199018)(40470700004)(46966006)(36840700001)(30864003)(8936002)(82740400003)(82310400005)(7636003)(478600001)(41300700001)(42186006)(36860700001)(86362001)(2906002)(316002)(5660300002)(40460700003)(6666004)(54906003)(36756003)(110136005)(40480700001)(26005)(1076003)(186003)(336012)(47076005)(2616005)(8676002)(4326008)(70586007)(426003)(356005)(70206006)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:31:10.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8541d0d8-1c8c-45ed-c831-08db18c6e3bd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT105.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3730
X-Proofpoint-GUID: TT1r_Ye7cFtN3T4bL10lFgB9Qk1FzqiA
X-Proofpoint-ORIG-GUID: TT1r_Ye7cFtN3T4bL10lFgB9Qk1FzqiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_10,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0 adultscore=0
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

Add multilink DP configuration support for 100MHz reference clock rate.
This is the only clock rate supported currently for multilink PHY
configurations. Also, add PCIe + DP multiprotocol multilink register
configuration sequences for 100MHz refclk with no SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 284 +++++++++++++++++-----
 1 file changed, 227 insertions(+), 57 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7fd3bc33fc19..c8a204616cdd 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -904,74 +904,90 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		if (cdns_phy->dp_pll & DP_PLL0)
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
+
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		}
 		break;
 	/* Setting VCO for 9.72GHz */
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (cdns_phy->dp_pll & DP_PLL0) {
+			cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		}
+		if (cdns_phy->dp_pll & DP_PLL1) {
+			cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+			cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
+			cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		}
 		break;
 	}
 }
@@ -1708,6 +1724,20 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return cdns_torrent_dp_start(cdns_phy, inst, phy);
 }
 
+static int cdns_torrent_dp_multilink_init(struct cdns_torrent_phy *cdns_phy,
+					  struct cdns_torrent_inst *inst,
+					  struct phy *phy)
+{
+	if (cdns_phy->ref_clk_rate != CLK_100_MHZ) {
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
+	}
+
+	cdns_torrent_dp_common_init(cdns_phy, inst);
+
+	return cdns_torrent_dp_start(cdns_phy, inst, phy);
+}
+
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
@@ -2219,8 +2249,11 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	u32 num_regs;
 	int i, j;
 
-	if (cdns_phy->nsubnodes > 1)
+	if (cdns_phy->nsubnodes > 1) {
+		if (phy_type == TYPE_DP)
+			return cdns_torrent_dp_multilink_init(cdns_phy, inst, phy);
 		return 0;
+	}
 
 	/**
 	 * Spread spectrum generation is not required or supported
@@ -2462,6 +2495,12 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			}
 		}
 
+		if (phy_t1 == TYPE_DP) {
+			ret = cdns_torrent_dp_get_pll(cdns_phy, phy_t2);
+			if (ret)
+				return ret;
+		}
+
 		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
 	}
 
@@ -2859,6 +2898,77 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and DP link configuration */
+static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1}
+};
+
+static struct cdns_reg_pairs pcie_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs dp_pcie_xcvr_diag_ln_regs[] = {
+	{0x0001, XCVR_DIAG_HSCLK_SEL},
+	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
+	.reg_pairs = pcie_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = dp_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_pcie_xcvr_diag_ln_regs),
+};
+
+/* DP Multilink, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs dp_100_no_ssc_cmn_regs[] = {
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_tx_ln_regs[] = {
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
+	.reg_pairs = dp_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_rx_ln_regs),
+};
+
 /* Single DisplayPort(DP) link configuration */
 static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
 	{0x0000, PHY_PLL_CFG},
@@ -3801,6 +3911,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3823,6 +3936,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3882,6 +3998,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3904,6 +4023,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4002,6 +4124,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4024,6 +4149,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4099,6 +4227,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4121,6 +4252,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4196,6 +4330,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4218,6 +4355,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4283,6 +4423,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4305,6 +4448,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4364,6 +4510,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4386,6 +4535,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4484,6 +4636,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4506,6 +4661,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4581,6 +4739,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4603,6 +4764,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4678,6 +4842,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4700,6 +4867,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
-- 
2.34.1

