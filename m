Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5017166E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjE3PWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjE3PWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:22:15 -0400
X-Greylist: delayed 2567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 08:22:11 PDT
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261CC7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:22:11 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5MCQ2004699;
        Tue, 30 May 2023 07:39:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4yQiUseMHzLtMGVMaRodjiuEQyUqaZskXm+kceAcg1o=;
 b=Wvi3/gmiUVDGTmT8DlCEHagJXW7hI36e2DwlIqc6yqmQy+0znWUG6aslE4TyrOwjTOcP
 kGuIKry4Pn6ftUJ7UJzRCqRmXRYW4IV9/RTul0EPyEBPr413z2Ut3GlC0Eow6QcJKn9z
 MNsrdzC6A8kamnyyEm5Zc/in2iqks7PwSzctORENmpvpRSLiWH/Oc3F+2w8IgzAgtszq
 OPKUt6hWxnorJeCJfYsEQHpB5Oa0mWzGkZwUhXzjSazf854FFzgaBTma3+ZcJN3yaxTS
 xDFqvfajJ1YAV58xK7yw6SyEURKu82FusDls3V/hW0hn7ZETcByktyKLXRreltOw4zSn Ug== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qudex179m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 07:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq58zITVOfiLjp6Wsh+Co+rtSHB3FuFXb54/UUTKFL3lbWIQYPuzaE2YIEosdd7w7Bjt2VRGaEUw5zwDIDsxthfmmhcr+5JiQV5yMaq97wMQXw/J9OfgmcBzeD9M6IjVWEH3kswDZkfeCNiBTtbWO1r8M8Wcult48a9VudUHXJpqJD88QenXYmoIY1EgQLDY/yWfhXmtbYkeFDKYGRBo9G3rpA3J+P6+vI409ZCx6QEGXVDOxch4QygsilwwhvwImJu2GNsKHu26+OS/KxEogpC1k3piboo7wEUHpMOsTrTZyeZFVqZ6Rssk0nfAkoxj1ASM++snT9QoyPPzeoYrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yQiUseMHzLtMGVMaRodjiuEQyUqaZskXm+kceAcg1o=;
 b=nW7nkmwHZbJYjJTCkJrTO+klryfnxQdUt49AG9WIdY/2g6VgWMa2Lxu3+p+qJ/yEUR9GfMFUQQTLM6fDRYtMa+n6jYyJxTLjH9opfr4cjeoQaHzEAihoDi6rdmdCCMX+8BOX75Z7ysXu1T46Bb9YXIPbFXIwN7/kdIKUSS4CBgpdEi//NnkXabKjKH2c2YTQlKM081XF+jd/mMvdsBVLz8wOcl/61DVnDZ4gAwXx6utG2KpHSmSfi7NIj6ZAz5NH4FYTJaogrNtrbX3X2ffhHSQN/dEEuDW/1IpthUv8sVOJIFM5gF1FgIuY655hNYaxooUfnMJ9yKg75Bcs4PXOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yQiUseMHzLtMGVMaRodjiuEQyUqaZskXm+kceAcg1o=;
 b=TjFe3ATGAGj3MXTNBuH0VFdF3wsl+mHQR/f3YqfTd3+wUJdoIVp4GFeDqx77NElFcEBCa1ZTHLJb2Xbdtkytw/7fTLYe3jOcd+mUP11AD8jMOf1VDtV+uRqx1puTR/47HAFZJcUiUMugChFNy65ElRAAYpARYeXtmncmLguuwjY=
Received: from MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21)
 by CY8PR07MB9617.namprd07.prod.outlook.com (2603:10b6:930:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:39:03 +0000
Received: from MW2NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::8a) by MW3PR06CA0016.outlook.office365.com
 (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 14:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT053.mail.protection.outlook.com (10.13.181.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.13 via Frontend Transport; Tue, 30 May 2023 14:39:03 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 34UEcwIh032349
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 07:38:59 -0700
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 May 2023 16:38:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Tue, 30 May 2023 16:38:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 34UEcuX4026616;
        Tue, 30 May 2023 16:38:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 34UEct4i026615;
        Tue, 30 May 2023 16:38:55 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/2] phy: cadence-torrent: Add single link USXGMII configuration for 156.25MHz refclk
Date:   Tue, 30 May 2023 16:38:52 +0200
Message-ID: <20230530143853.26571-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230530143853.26571-1-sjakhade@cadence.com>
References: <20230530143853.26571-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT053:EE_|CY8PR07MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 8649eff3-6172-47e1-3fe0-08db611b9d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9KgJiM343VPdvTvA205aOab18LzoIoiX9Vs7YbcWy0KZrdMM/+KbdL7BhM3ak0uD1BnbjIN4lh9r0DXJvV/7uRS5Jf/WwU3FtNDk/dkq4S9p316Bq0QoVCtmXCKgMhl7ClNRHXm8OecpznbhGjsHrrtaEqrgfPSEgPV5q/hUN65thiuU8uwoySc/ESI4J9inIHjZIzFDBg4TdWPAEjUqI/phIZkX4H29wpf510HSsYKMSPCvYjTezXbxP+8NTlySDqmg32OQ2UzlU92YVm9gFdBnge2Jlslu2BCQMSbyxPNhkfzwstIZMBEayOAV5qK7E3q4Ha+N3BV2+f3k979qjfi4W3jL3bgn/jEYBK09Oboe60GJ7eAzpY5VVYIoVgD8yhXMpWLJVBTa1yBOPdtR3JRvV3jr0zFtTRBw/CxXOnJ0kMci7EPGqvmjLA1xg9IUr+dJ7NQX6df2NpPU14JTyqHZislVRmFQW5dwHjR595OIauircBdkGns7rwEduErK0r94xYcrEUsJ2I4/ePqSH3Zv3ELX5XJtYmQ1458AyMfeJSI20wOtZSP+feSoF2ELrb7U3IQUZdB7FcCz0ve1Na4St7Z/tSdEyZFesDSkaJOKXwyL8n6SHrztkQW4YbrNF2+CfJOIxUSBAdmcb9X969wNJbz6icJGDhztPZ/ukFUX58/k381wwyj0iYSwgvw5DtSzduSezYMT0EFI0UvMvtZKEfQMKT7A/Jv8EKie8xUxBt67e5e7wNVho2EJLnh
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36092001)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(186003)(41300700001)(47076005)(336012)(426003)(1076003)(26005)(83380400001)(6666004)(2616005)(478600001)(110136005)(54906003)(42186006)(40460700003)(356005)(70206006)(82740400003)(4326008)(82310400005)(40480700001)(7636003)(316002)(70586007)(8676002)(5660300002)(8936002)(2906002)(36756003)(30864003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:39:03.2283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8649eff3-6172-47e1-3fe0-08db611b9d3a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9617
X-Proofpoint-ORIG-GUID: _KiBNzha46uPrzMdDyWyoMrgmddsdNjT
X-Proofpoint-GUID: _KiBNzha46uPrzMdDyWyoMrgmddsdNjT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999
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

Add register sequences for single link USXGMII configuration supporting
156.25MHz reference clock frequency.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 233 +++++++++++++++++++++-
 1 file changed, 228 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 3b0e4daa9de9..d4be3f098040 100644
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
@@ -2928,6 +2958,123 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
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
@@ -4028,6 +4175,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -4121,6 +4273,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -4149,6 +4306,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -4257,6 +4421,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -4366,6 +4537,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -4475,6 +4653,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
 
@@ -4573,6 +4758,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4666,6 +4856,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4694,6 +4889,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4802,6 +5004,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4911,6 +5120,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -5020,6 +5236,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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

