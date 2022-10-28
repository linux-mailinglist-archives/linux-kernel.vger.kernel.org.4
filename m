Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9BB610939
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 06:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJ1EPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 00:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJ1EPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:15:17 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7B32045
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 21:15:15 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29S4CvMl002318;
        Thu, 27 Oct 2022 21:14:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=TpBxpQVk1nkov9Tw/YsobjCQZMOD7Aa3W6BOfp2QfCs=;
 b=pQgKIrQ0gA2BibSBwvdFXzhSRnjBrXGXS4ZvYMsmbDwMpxRs/rEYL3imh3q+rJgd3YUU
 LjpXuu0rEp955r0h/VxkbPouKVIcoReRxGZo+pTmlJmGkRY/zYzN4OEm9yNtEnJVnIvV
 6+w1cP1F1dRzJDCT4EJpo+f4AE5/ColuWQCN92paRm0cUHXHKtDJtLhj54OYbDdwWuLK
 4OKje2p1ITLduelKmndJNo74ldcnkiqA4JlfgNt0ihPVJKFqWUwhYzLP6l5+4mR8GxZw
 Xi+FAXihG+GzKg56IdsfSS9X5IL7bw7M2xkv1Ho7c/PQ/rShZVHbjKzAhHd2CavRiZgc Uw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kfg0r14u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 21:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6+1CJE1jtfA3knHMVNK5BYNvXYmKV+l3Xbcb8Gbn0HjT1SFkJat5c+JwKUeXd+NTEVwUwc13dxlYgtvFFW64wROyKVlPwjyvqCOtdq4eDJFTRzZ7TprrSC+uRkdupS7fTebsiq+BQD1qIEcc2IDdEDSekPfkHdbrIa9yXYTTCU/Rac89qX51+nglzw9qIxXxfvIothr+AoA1RuLGOYIzs1VeTEF6S6VADDRsO+3NbBDw2GqLFeS/uKp2MFXpCG83g+4JAo1ES4A3M6Pe5+LiIUx6XWfaTcYd6Yc4mzIXnSKQRlfiTWskhU8ZOxMkS4NoWYhiNj+18+XZYtz5oFa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpBxpQVk1nkov9Tw/YsobjCQZMOD7Aa3W6BOfp2QfCs=;
 b=BxVdcaPnBTVizBiQxvC/RcGsrMZ8xTvOmq31Th+qquvDdFbNbdZKablRbTU6BVXaRv//MyAK8vz0V4yyezC75KMP/cPL/9LW/adgdEsvRH425aWVyg9NkAr0ZZtz+gpyig6M5VT8cHXJc0QH6tzGhtDL/1q1BKkLBPQHFlxQRhZz7Q1lg3qcFPHm/8CxxIYz3jVqzBD+HX3yr4ING1N94hOsmK+WbFjQtz3vJsHNIOSaAjMML0YWHQuKc6RwipR0YD0pQEZcrpFgx4pqStC1JUD0c+d6KCmEFRmv26x6WfgM2BZLmhjVKa8WXAOkLudmSaSdC+tVnyOQ5cMDMEFyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 04:14:39 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::d789:b673:44d7:b9b2]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::d789:b673:44d7:b9b2%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 04:14:39 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx8m: Increase the clock enable before reading the register
Date:   Fri, 28 Oct 2022 12:14:18 +0800
Message-Id: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a6c5f2-890d-4101-8a3d-08dab89aeebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VC1oYmIGhAn8KHMJzykGbbJQaL85MSOh6ZXIa+TDRZNMO6GYeey9jVw7GSqI10gGNKkE750MpaXZOjIwTZYLh2p1V94IzmVnkMc3UCpowtIJQmfwHkO9ddOEcV8xv/cNr7ghG48/9geDatPMhTbxmzlviCEGxSiAwleRkBSpQs2lztpVJdaeMZ8OIhftk+/LuRn9WTgbXvKXHG9XwytzqBiuQNE6h7Ml9LlAxcWvaPW9kTnO1cfSb1di5etZomhgvu43rts+n+MgYT8KLzCMi7WGwy8owL0WmvJxLbvmKigPeWqaa0PViMxSVK0kCHSZzXspAYONkEEwvTs8ML/x/gKofGdOqxU9/WKFLtXkWp/DDxJ1MU1qE0SI7y1FDppa3W8mmy17AGKrCHFbZOElX8zSzJS0/uQuguyjPtnyFCJglWkJmhmD2ceWjx/2tyOMWJjbWQnGAXjwHtKKb9VFNdBn7iG7TDo+Y/uOG+pLuui92RCjhZISMhsvBQUer8oFXRrPYaSG6TLSrVozi14+xTGqqzIqxkanLPcqsraTQuQdNXoP0dtjVDOJpj2cYewcZWU3XkMnH6fkq3PxcGadDFohNzUgqZZ0ChNRPH2UCzw9QS9wv/vfTEsKskbaQZAwEhMHxowF16+KlX/PMbnF8Da1Hw7qNkHU23fDjxiIAhMVTnWsCQle7bhASvG7QHwdHMPHDwMxM+nttMWbYAK5Z7JKD8CNuIzWysoixlqCdSnMF0aAus1YWY1rKyChlcdawedmXa8Jd3N9fOlwk1HMnDN+axSaZJ3BKSKuM7K/kMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39850400004)(366004)(346002)(451199015)(26005)(478600001)(52116002)(6666004)(83380400001)(2616005)(66556008)(6512007)(186003)(2906002)(1076003)(6506007)(8936002)(66946007)(5660300002)(66476007)(6486002)(316002)(8676002)(41300700001)(44832011)(4326008)(36756003)(86362001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVToqHxa6VZzTAiNAKZJk4pZ4Pb/3EwA4KHEGU2zMIYK7nQyJCOU3gPtp73M?=
 =?us-ascii?Q?W/168+pJ16FQCq7aso1Xzd8rDKg7gkpqWlmmBEdu1qhhljwN1ZIJpGIMi424?=
 =?us-ascii?Q?33vDNBSxtkMsotx4723S2jxaX8BOthjNYaaNk6UuHmwlShJ8AZGtlleRWx3x?=
 =?us-ascii?Q?ujkmsCzUeidXcHkQ5+g9/fItQYXjWWceirsRXLIxXHoDmWQ+50w9GxyLA8nM?=
 =?us-ascii?Q?GeeZVCabSbFeYGFbKNlYfC7r4DPNJ9lNCVQ+CIeotEwtDTxhc3S8AQaTmJfJ?=
 =?us-ascii?Q?monKHs26H5u5G9XW8DjdPSqZDKiBeq6aXVWOUiCNt1nHufCT54pXEeGwtbYZ?=
 =?us-ascii?Q?Gi/7Z9mAmNpyjhb4mYalciQwIneXbnsc6N1FbUBjZ2JBOfmt8z8BOFKg4u50?=
 =?us-ascii?Q?UY418BWMEXytk4q0tFtu5thvoKddJmxUBG1nc/3aC3PQIvaXHcIrAm/iC1iI?=
 =?us-ascii?Q?gKygae0sy8Xo+Jf+IpGh/2J2S2f+nxe2vGt5wofR8nmGIgb2jcSEzBe4cRrV?=
 =?us-ascii?Q?0QOhfu0QZu0+6eqMsOzGExHPPZ4NZ78K3RvmmS95sEML+ZAPVcQuGGuI5XKn?=
 =?us-ascii?Q?Hwdo/FTJLl3MFNTbhb/5CuiZQUFeFvLjCACLiGZQNL3VRExYtP0320bGw5Dx?=
 =?us-ascii?Q?CR1Y5BcyTOz82lbJUq2mp7oZCadILSMc30YqLr8nc595x9GXXCHlcMO8dV1J?=
 =?us-ascii?Q?+tkvzhb2rPjpWFGFIxrbyOc8l9sfOhA7v0aKBiJe2BxcwULVyerGM9988HbA?=
 =?us-ascii?Q?6Ue6+FgelgFUROp2uc1rzRE92JjwOHOPbn3MxFehhK9FgXjk7Pl/t2Ew3UiY?=
 =?us-ascii?Q?oBfPj4sR2ZZGt/gpoITokFYvP28IP3ON0/X/SML9qZNCLEA8ynLpcw8A03RS?=
 =?us-ascii?Q?dIfnHq84h7deLNYRKr42K/m5CBNlaD+F1oXQLoz6Zli50TAqof2iM0qGWKvs?=
 =?us-ascii?Q?sL7WTaVSjB1d3drad86qijh1l1i1DnZXwSylY3jUWzH5tNyhrV2GPqaiT6eQ?=
 =?us-ascii?Q?sDKROxgGXWY2EGkjdKcoh4pHEt2fSrnJ8dLDSXAwKSbbccGhZn3GOyVbsa7h?=
 =?us-ascii?Q?XrzlpUiAGzoFsqSmqjuvCwhkCHVp4tuprpFHXzEpD4gfhl0cdpE2/bYwOZn5?=
 =?us-ascii?Q?0IyosqlqEoxHs+S/e+zEXbCmDloRoYSUA4GeXVitE5Z5/Dxhst9F7PJKsHZO?=
 =?us-ascii?Q?1L1vsDt/9UF2WNwwyMrGN+5p2Pd2Y7efQok3EAWoz03AWGXnveQ2E/G6BPxA?=
 =?us-ascii?Q?oRYN+znDQ5ioGVnPCoFu+mmhz9W0++waH5qNj8uF07mXoYLel3wKhnxS1Idl?=
 =?us-ascii?Q?1t6o9ZcnweXv5C239YUAgtYb6nt1NzPhBGFWNPZO2FUWjBKJhsDdIbHvpTue?=
 =?us-ascii?Q?L+zvvLSp1yr/IBtNhOlmslGMp0pOWE9BQjTJENMSz+tlscwTgiOTT6aM2P7j?=
 =?us-ascii?Q?97HGC+7g3nVbID5a/TxtS3xyutKp3O+cFTJfS8I1NSeKkYekovJqY6SLBlZJ?=
 =?us-ascii?Q?P6x+TVTCWy8GGZcy0qyV/rtVkYNgr+xE4xkPtGNPifyiT5w23Egx9YZYxglj?=
 =?us-ascii?Q?U9AjZrV0NwqjvvChJKu/zmOKaDBSziF5On53cJhP0qJEPYfUKS9d4+44ZIJO?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a6c5f2-890d-4101-8a3d-08dab89aeebe
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 04:14:39.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYMp/CLslnFF2rRlgAS6Zfy5W3BFIIiTl5rkk69X4qa6kLqk20yXR27ocDty/jPdpq5pCbDuJaVEtOfjO6YXXqFYQ2X7juc0A08w9r1JUc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
X-Proofpoint-GUID: snwtmMtRbHOqpTrQoWCy1RKEyt_ev0_H
X-Proofpoint-ORIG-GUID: snwtmMtRbHOqpTrQoWCy1RKEyt_ev0_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_01,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=782
 impostorscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing kdump to start the second kernel,
since IMX-OCOTP has turned off the clock, the clock
needs to be re-enabled, otherwise the system will hang.

Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/soc/imx/soc-imx8m.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index cc57a384d74d..28144c699b0c 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/arm-smccc.h>
 #include <linux/of.h>
+#include <linux/clk.h>
 
 #define REV_B1				0x21
 
@@ -56,6 +57,7 @@ static u32 __init imx8mq_soc_revision(void)
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
+	struct clk *clk;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
@@ -63,6 +65,13 @@ static u32 __init imx8mq_soc_revision(void)
 
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
+	clk = of_clk_get_by_name(np, NULL);
+	if (!clk) {
+		WARN_ON(!clk);
+		return 0;
+	}
+
+	clk_prepare_enable(clk);
 
 	/*
 	 * SOC revision on older imx8mq is not available in fuses so query
@@ -79,6 +88,8 @@ static u32 __init imx8mq_soc_revision(void)
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 	iounmap(ocotp_base);
 	of_node_put(np);
 
-- 
2.25.1

