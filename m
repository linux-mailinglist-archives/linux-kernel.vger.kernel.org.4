Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23A6E6B27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjDRRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDRRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:33:15 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEEC1387A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:32:49 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEgFPS028302;
        Tue, 18 Apr 2023 10:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Y9XuBWqkAK3AOlFXQmYfyb5UQUBzu0u2R2c7hn9gQdY=;
 b=Fp4JPtTqJq/uRXnkmbUqM2FDpzmfchXUtrbOzCdVUFViNQEw74dqNRRE2fCVkYGlBvdM
 Bs8gmnHmX/4HLs6KX0ryZTsy9nb/lan+/ALatCr6wKGAyOBFeqvt31viywLwwBpziS3X
 5jrNm1B1VSZmiQT/xfICJfooTCk567B8HH7U9qhYtuqDCsejj4PoX3dLde+Pr8qoqDUy
 ZljeJGZVhpNrJaWycrTQ445AngFIGQ+Lwn8nLqVxgRmpkN9ZO47oLGlbwxvcv4dani8I
 dgXPadn2gAq4OD2oYIttGTddtC0U6bxrTcCCl7U6XZ/Hn7wR+FuwPVXxMf2J++48up5L Fg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3pyrfxsga9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 10:32:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7+vj46ar2DnOAhnTWeKDMLWfxRsh3+Cz97aurAMjlaxRgRyHIYpJ7SSPLKovF+0Zlh2pdnLZyLUso/beBY4ia3G9YRtl3l6PePbTLcTAbML44PaICQFGjn4pyVEB+BpZwsOpEEnCezFvpzrbbraGLezggnwIGwvM5JQmj+a2/ZwO9ziLIVluGRIo2d6CCSSowD3SJU18AcfzCQB7Yy8ShvV/4WunIhyO7+kumM7Rul4s5ktuBqCpfZtgmk08i6CgiyAqEAn3QpzF3j/l1uXfYIwctju8HegBilTG4A4MjpMh5Y5a7ZhSK7z6kJpuxVCgUwfO+mdl6qAn2G/HYSFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9XuBWqkAK3AOlFXQmYfyb5UQUBzu0u2R2c7hn9gQdY=;
 b=jKfQaCLnFBjcUyyhBZu4Sc8TZk1X/vPhFmvJ/Td4IWiAFkNy7UkdOJuromCvjf11xbBqtKe2iG8LWfhOlu7I4Gadr8cQD77UUMNzT4MsJRbdXdnf/WB3irCVQy05VRwst16PRpuk39HjT1gugQS+t4rkQ5SlJZXaYRWZ4+boau72AwrqyPOKMUvYkc2eGbKRXN4bB0nsXVmqge3QWffd0okuolskohGDoGurnyrv5+eYxtO4vrWd1i8D17ZevvuOMxps6O5mRSoLV0Vw1rMDLZmOnEawtu2WWDbes+Y1+QfXplhWXeW2yJ/1L8sQJTPJGykqMutU3rI6lklwD9azRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9XuBWqkAK3AOlFXQmYfyb5UQUBzu0u2R2c7hn9gQdY=;
 b=flRjqQ8Ri1/DF5bDcvH9S4oT/fSZlp29nAvA9CYxqlfOQjET+6nA5hGgq3bJAowyUiczpjikt3nO5h6J9a0Eu+G0dFzH9POfXZq8ykUpTvhsc73nk20seTILLZfJryPM4pMdStkujq8T+9SBbxA8q9pxCZAnX128wU0DLBUH3Dg=
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by BYAPR07MB5317.namprd07.prod.outlook.com (2603:10b6:a03:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 17:32:05 +0000
Received: from DM6NAM12FT103.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::fe) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20 via Frontend
 Transport; Tue, 18 Apr 2023 17:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT103.mail.protection.outlook.com (10.13.178.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.8 via Frontend Transport; Tue, 18 Apr 2023 17:32:04 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 33IHW1LD194661
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 10:32:03 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 18 Apr 2023 19:32:01 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Tue, 18 Apr 2023 19:32:01 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 33IHW12S025677;
        Tue, 18 Apr 2023 19:32:01 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 33IHW08T025676;
        Tue, 18 Apr 2023 19:32:00 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <r-ravikumar@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 3/4] phy: cadence-torrent: Add PCIe + DP multilink configuration for 100MHz refclk
Date:   Tue, 18 Apr 2023 19:31:56 +0200
Message-ID: <20230418173157.25607-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230418173157.25607-1-sjakhade@cadence.com>
References: <20230418173157.25607-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT103:EE_|BYAPR07MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea03328-f398-4eb3-10e9-08db4032d393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOYnTQEBxcMLJ7W3WtDAbxTd2UNEgQoQ+mDAYv0wYe/nHP+vAnr9bESrT0OtZOWz6e4iknENjbBHTuGtsQ8g2/gAnm4ACiqhBEDS3YT3cNHcg65kZ+70ZsfAdrK7IlTzHGIyJCtRsu98ZRmlxNixn8xTeUqpNQ62hP/gHcoIyJ9Kj5ASMdi3qXpyOsDqjwdblyWoVcl6N22VsK+8j+bdBGO+aFICNk5/w8nh5qzdVZX22h3BvmcmYbqOpHodKX++awo9pcC216QilYcwdsbkFN1NGGfj3GK5ScFn6zJoNiZjS2gQ4NGtEbAGec2ImCGaACyUs8mj2Twzvwv11cWLiuD8DKKMMVMLTvejaH5JbgClNCKy6U8ZN0ebays2dtCvwEPoQCik9TKpDb6jmdCtgq75SD8mHzoKODoJPI6vzgvTGgU8qvrHy0IlAVwdlerp3Kig7wtdNrqRH9foEyLNecjZhzoBSdvCVR9viDzU6y+yHmY14Oj+s0cQVNcYVPPZ7gjCxMmy2hHhJFwfX0Tev/FtRT6/5oZ5HA5XXALHPBwLQvmxrUJvWi3MhyrC4/5gKSZnAARPFg1r3pu4UYw/lH1O0P9lJvPes6WvwNlGa3pfhFHMqaR2GUqsgSVtkQ3HiA3gvCJumTtCjOO/b8er/nscVkblKUUoCdl6sdPh0MLIrBl4Y1+RMhwdP1Vko7gUPiWfpzPKsekPxgWt51oyiO7rCBSRtH+MUgyFryh6MyA7Nc3F6X0Sig/vd1NjAsrZ
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(36092001)(451199021)(36840700001)(46966006)(40470700004)(356005)(86362001)(40460700003)(8676002)(8936002)(2906002)(5660300002)(30864003)(478600001)(1076003)(82740400003)(26005)(81166007)(36860700001)(186003)(40480700001)(316002)(110136005)(70206006)(42186006)(36756003)(70586007)(4326008)(41300700001)(6666004)(47076005)(83380400001)(336012)(426003)(82310400005)(54906003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 17:32:04.4292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea03328-f398-4eb3-10e9-08db4032d393
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT103.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5317
X-Proofpoint-ORIG-GUID: lwaGuuYvunD3oG22Q8XY9p6_gcbDVsW6
X-Proofpoint-GUID: lwaGuuYvunD3oG22Q8XY9p6_gcbDVsW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add multilink DP configuration support for 100MHz reference clock rate.
This is the only clock rate supported currently for multilink PHY
configurations. Also, add PCIe + DP multiprotocol multilink register
configuration sequences for 100MHz refclk with no SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 284 +++++++++++++++++-----
 1 file changed, 227 insertions(+), 57 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index cef63d4a93b7..2fc5dd495ad0 100644
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
 
@@ -2857,6 +2896,77 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
 	cdns_torrent_clk_cleanup(cdns_phy);
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
@@ -3799,6 +3909,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3821,6 +3934,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3880,6 +3996,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3902,6 +4021,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4000,6 +4122,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4022,6 +4147,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4097,6 +4225,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4119,6 +4250,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4194,6 +4328,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4216,6 +4353,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4281,6 +4421,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4303,6 +4446,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4362,6 +4508,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4384,6 +4533,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4482,6 +4634,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4504,6 +4659,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4579,6 +4737,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4601,6 +4762,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4676,6 +4840,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4698,6 +4865,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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

