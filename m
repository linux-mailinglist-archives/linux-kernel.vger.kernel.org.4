Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D16F87DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjEERpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjEERor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA41D96D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hh4h4029134;
        Fri, 5 May 2023 17:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=GDD+mLNirCcGAYlTuRZb5VCmYwv5U26pWcgVsYvLALxo75qp2yGi7UZHX/6qgZeke6Lm
 aSUebghC97x+GFBVgurkzWnBM4UmMPc+QiGM/b9jAjhGqfAOlyNYhmphzxnqJ/HwViBc
 J85A3HYuS8U7aCjbhS/q5pbzvGF3fHVtn854NDFw5Wmeqwgn2Y4BaC0fZE12XmdZAKs+
 lrYlMlpEsGbEEOwfqOKFisZjvsXOamKXbZ2toxtO4TiikOAnb27tLCbVJt3P5k3+StHd
 z0XJzU+z9HccazAuVZpm1TRtpP/7bnrXWPJZx1oszVRYtLAb7IB6wFwA0DLsqb9AXBPz 4g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1wf4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345Fx0fO026877;
        Fri, 5 May 2023 17:44:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spgeyqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+cWwZ2WPVfD4BfHYksS98i6MCpGz9KA3pt9qZKMvsAF+diLR0q/SBi9JYkmbTVW1UY/+Wb9iPsRHoMR9ZXT8mOLT+RumfhpwJY8pjLrFfLozDd+aGKKFtbhsdLJP1dF9pTmYNiaLpaqre5VgW/I740YSZDAzkCt/qDKfpIeC2ztfeMoTUBbizlBm/XCgolD3DFcELVR/rD+DsLaXqPWnXIGuYIA1YmjYeqsEAgIvLQ8ebwKwHtWdELg/NDkgfYMWZ/oOL40XOQ1JLETdlk8KqfaRbUDsmsqqdmxnuJxJjCX0GneLuRMkhM5SYAx0xa40ooWI8iB0gEKLxKlr97xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=AhY4/R1UbSwkfHOHFUcT97s8ozLBosWX8DwIhRWuNsQoIDsdjtvIzg8M0rs6CWzq979UxoT3mvHe8s22MKKYssblXdXJcFrjdMhgsr3d0fQgj9WHbrONASY1KlfrEnfWL6LNQxPej/Q2HzWX6dmCDYaJiMVIzbFhzHT/k8QUYNGSWg7tpDvLKGgjCFa62wHJDKkHH6LRiMIXPKnGh7mvFs4K9QRFmux0KGOoy9RHqQbyB1d5BRm31sb80SHjI+cssFuVunq2T1ogTCZQst2CAKXop7ccXQFBEl3zMWN0LmdASknJzbGbrp86EUc/FyZzBMAgRPW7vpjYP+22bWGVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KyBz6QjokieOxuGt50Z4gigq9psaMvhxNm998CObA4=;
 b=UjT/W8z9mdrRJhk2+Ue67KqWM77cpVH07fmda1zOVz7J7yWFtQMZrvIjB5FdtLUOfXkQtqgyaQUHBuHdKt/yfW/2ZIL4D9seHiw9afX2o3spT+O9CQbjO2axksrAUGGoVkeBeWb4+TW7TAhQolUaHlfSz2NVU6agQZDg7VRShpU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:07 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 11/36] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Date:   Fri,  5 May 2023 13:41:39 -0400
Message-Id: <20230505174204.2665599-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0364.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da968de-662b-4611-5c8f-08db4d905338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kLXTBb5imCkbFAvqOL6wLwOGhm6z5Xrr7TxIaF3Zgm6qMHZG9RV+rf32OKe3dDccLOxO+5BkC7nCiLuCJm6LPB7EY/gm89BdEX9CsNJD9rtzsXWnG3IspY4ho0lBzR46DYwCwlwRzYhyTQs7wKtQMx1fwEK00yB9J1Pgj1uTvMScvSYiSUKRh/mtmlYebn3GrwLCgxdb2MqpAqo/EInxQMgiqrWeu75vLPZIe103RTGDGzZmd6KQnqoLcy2Ds3wUpxC4l2pfZgMCCMaylt5BFFhSVE/Pdtm1ypUglFEzVHHJEKCRvmWiEgnflwEsqtu74V26KM1/xf4iNiNjPW9DvqdXsso+CeJQUiPdVXBAh6Fe/yggK04wRDlqMe58Rq87PQW1W2QdYCzyQXDiqqjtslVuPMhiY7XJUnLQ4AcuGVQoUBudyp0qpiLcIABN3f5gukpIVpGdXt/uyN93Abagw7uCLbereJqUkYyovUj+dBXhm5grp0xdWPfPpooO3IUkCKuB9QkNDAXEA3kSKYCVD8RsXohA+t0FyTedNvLqoqgQflN2WT6DSSsGRl7wLjz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8nPm0rrboh6KQgEPTirpiKJ5ggGDYWIb0Y3Q/5eIDkWjE+bbW7KCOiXfJC8?=
 =?us-ascii?Q?Se0z1fidLO5L7+wiz1BxpDIcF7wgq4hVPHUdncpT9wKq2rTQjSclJybZQh9u?=
 =?us-ascii?Q?oeMYf6D0wU1V4etKCxv5USf3AKv0EAPHBo4j6wgwoS+Gb+psMPDxldl4C5zt?=
 =?us-ascii?Q?3nXEpmYn4KBMtZmEPtLYj/UAEw9YEgN9aAjxRbyJWO96gXHYGklEzBqzolhz?=
 =?us-ascii?Q?ryOJqIgPTaAz8g6SFt51ATzPDrvhMtzpThzzbL00s1CFnNS5ZnXslhoiBHoM?=
 =?us-ascii?Q?x5CeHmHk+GZ4shy3Oy2Bi6BPuIV4QA/NdPmGB+5axippTJVHPT1Ex27/iFjx?=
 =?us-ascii?Q?cwyKw3b+Y8pb8EoxddlDTBMhL3wvACKJy39vUIBEf0XoItPDNWiK1FU6TEnZ?=
 =?us-ascii?Q?tvq3toXEw9xfhNMEShlyUsjcv7bk6SG6Ind0HJpaE4Ygl8d8mqQcjT0uhUGx?=
 =?us-ascii?Q?8QxzG9yacJ+MmrBU19yB6kkhOOt0xEjSMbyn6KKJMGBO/7PHagDH0J+XU9sr?=
 =?us-ascii?Q?4lKPqNmb/r4DpsgQwx324b4XcR0iKgulMJbR1sQFb9yt8B+690zPMAvqOHW0?=
 =?us-ascii?Q?zHPwoz4KUapP5+2nguHlYjawyyZVjuEYBJBxi2GflYyfGY2sL/I7aG65tRLP?=
 =?us-ascii?Q?1wFFRN9LhXhivZvqpiVAmMii1QaT0GqIimc9qp95xICIvc9yDGZrUlkA3OoZ?=
 =?us-ascii?Q?G0ZVSK0F3jcpgh12drK5or1zkw4iGfqkI5Ins8Uyj4ASOW28v53DSEofPdBi?=
 =?us-ascii?Q?tAstU3nLbozj6shcOEToXr6odOCofvacQfHqkrzHfgyiFHyjkTGOn5C+lzd6?=
 =?us-ascii?Q?Q25sGrR+wQXOZ/wU1tRqA/roCoOVY9wtMjJEkRzl7ogNnXg2EHH2G9v6jStZ?=
 =?us-ascii?Q?wEWrXqFBgPhWoBqft+NiBzcp6nkUAmqOJ3rdmluPF8+tdDZkvkhr47wTTD7m?=
 =?us-ascii?Q?cMoc8TZA8HCbaFN8tB+gQxeEfij0mKfNyHyhTV5MxcoSjBDmIz62g/oMKQmh?=
 =?us-ascii?Q?vOCVg3zSJPPj8XEYjC5CKaip+iHpnk8T2Bd6fxEuK4A9lcqeILNBvYHsEXQZ?=
 =?us-ascii?Q?mtUW8MMQof+gPvS0v+KwiQHD2JemDed8Lxoe+pbIt/iDtFaYtxV12A1APG9l?=
 =?us-ascii?Q?fIax8fhW0DhoiJObyPP13F3sXYDQQ+R0tkQ3O1v4742FRDDcgxO/kfKv6EHF?=
 =?us-ascii?Q?iTOBxfHDqCMwor5BeazJ+ftIjM9XImnqBMt453Zrryfi7YUhm2Fk98qhMfE/?=
 =?us-ascii?Q?bem3M/n5Gw0Ogajm/w8cdcCaPUPosXroW2G1udvxqY06iJOIpejnyzP2OWf+?=
 =?us-ascii?Q?1KIuwVyQW8RXBchpghTu/86BY0mrIL0kwmyy14ZOII7sMLJZqPMrsFDrl5Rv?=
 =?us-ascii?Q?J6Kr4SIqEJrCMqMFlUt/TPqchGJc3ueFSeIiaLHYIGlJvEaq45s9IpBaBkfG?=
 =?us-ascii?Q?N5fB42rdCrNEeY3FUyTz9+3M9TU4sGdhi5ViStimtcL695d1d5ZJEhf8ZaZu?=
 =?us-ascii?Q?UaMsV53nm4MN2d7BwV0wBwM8sZ2u5Fa857Y27HV9HKk+jTemsPOgAOIApNGM?=
 =?us-ascii?Q?axdT+1zCdHSGWoMxf5CDnSPrsbuRNJjjMoDGMsjgHbMyasagWsQkla5KxaGf?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O0SH9tiCm9drwXaGd8OM0TxeQG0l/Y8NnZksdLSP7MB3UVe+IBnfeQg5iGB4/m0WwOSvZdgMlFgLp/w+KbnuKHN2k5V8+vjmrXAbJr6bau/BJ3oZdosZanJVuBclGGlO74HAqiCOVdynIHXeLV0nBpoO6TqXHHEzcLmG2JUox7OR4KpB6FwKLYB8DGO2BOIR/4vkGpqo/uhmf2fk6+wNYJcRUfqmOs72rIsWt+FDOm+653eFMXmK9mgrqs71hsmB0My16QvvJVie/BsUjYjx21NGmXiYZolIzyDBbWLsvPQlameLG7tbjIGOW7GUysJyT1hAaBB77Ks3YZXgrzYtR3f8Cx2RfM6fz6c48qzrK1gSswCm+pXYtPvf6kh+iY7sB4L8qZLVpRPrgAG1x6z48klmAuhs0cuf72LMM+mgYifAgn6B0c2FM1tPjPExuwKTnL3voyIEGGG9iwB25VI6WF8CN/rx3+WuckFv3buv1W2U/dEVPa2CZb9CCz2RhXSLgzKL21ebqyJ68NdW2PfWD6/jwKcvVo8aRywAavIgBc+47AICmlP0Ays/TK2ZDTBYr98p3NAAmHcETU+xmTdvDaKxqIeLAJxytQA1L2451EJj29h7o0PRs1aQynIvQICn/vellI8X4GcWPtGV8RK2nbl5cXb6nVpC5IqhBjtSFcSn5fRU5Y5YiVrQ1UvuSSk0ItCcXjeXSJg3v44xIuSfddDY80EDZrhPN/xZeqrKho5+sS9fcdAtGiHNOXZOFu6iaUjF5/h6cMqiKItJkTp7iBRhJg1wNx7d4VuzpWkraa191bb1Q7yPxDsL1/oHYriRsmpkexfAqvQar154tUdtgREOaNXHlHKayFWNQxwbwTi/03CUio4QKqQy4hAycicwOHhEjvhQ+xL8V9FilxPaXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da968de-662b-4611-5c8f-08db4d905338
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:07.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHx95zKOI0oOjtOBSkuS4bD+Gpw/YlUARHaKdsY7ueUyqePYZp7V5ehk/nbwpSSjR3OOZqmRygnZ79qskZxXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: gW9Y0Os_QzaDm_JcydKvErszg8FtQ-HX
X-Proofpoint-ORIG-GUID: gW9Y0Os_QzaDm_JcydKvErszg8FtQ-HX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
information.  In the unlikely event of a tree height of > 31, try to
increase the probability of useful information being logged.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a594f1d88d062..da441042ec8ac 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -194,7 +194,7 @@ static void mas_set_height(struct ma_state *mas)
 	unsigned int new_flags = mas->tree->ma_flags;
 
 	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
-	MT_BUG_ON(mas->tree, mas->depth > MAPLE_HEIGHT_MAX);
+	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
 	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
 	mas->tree->ma_flags = new_flags;
 }
-- 
2.39.2

