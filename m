Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9CD700EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjELSW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjELSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:22:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34D79ECF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4iCj027793;
        Fri, 12 May 2023 18:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=Sxwqt+1EDwvNDay/u10va+WPzrRzTjeGJIO9FBLkvTse+a+RhcBrSnhxNCbOvNtxgc20
 VX9paKr70Y/al9ANowcK6rbLJMI2q3TLRauAaMp5LMLETGngtZMud0DI17F22X0eUGL/
 2KZT/qTJL11LZ2omr37XS5F/FHDW/SgnjvBHEjbkKNGu6PGlCZb/LEcTPv4RzltN3Pxc
 39h24760i3ZzxjezIH1Gy1CvOVF1uLKIlECdBaKD3Mnn7tUahoGZ4R3I2kEfxxe91CyO
 90p4JFS2hDwtlGLGggz82LiuhILxaaMJgTLny/i2vzcFLJ5IPz0/j62XqU5dC1OLE3iA Fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77cbpvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CI4UCZ024228;
        Fri, 12 May 2023 18:21:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8gtfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTAt374kAYRryPiI+UrInZLfBReLlyv6yggi6daUorD9MSPCEJMn/GY6riZ7kl3fMMjjr+uB9iDc8Ohbpskq1497hmwGSPPtJwho71bQei2R3E4W71jXSGnpsEgVlMHv++XTnYOA2b5UDFibMTLIqDDHAlmm/4ATAf0ui0knIfKRrZCLt60mfGPojM/PpvSehc1reAdBfbbJquhrPKDyUd71Ol6kTo3mbaSeEanbiROSWbUiUOtw1bAKO0vM9mpetU0L1p78ML/fI0MC/B1BRAvmsdXfPbJn3X65KV9QpBQLGjsmeHP4RWunHPbeeyLBAE8EuktoSUfvzAiPhdM47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=RSBU1D3QRF0NXmJWBkotxKMKRWC+kK2tdqvMCbq4+3XROiQ4vq9Ih5UGBPu2hV0APtNh9kBkE59mZqgvWpvX7dwO6uOjwohPUzRyYSJ8HaHDjIMiwT4+RnN/bLcn79PcSWG+UOWlrIwQyrL5r7LA8tyUpwvTfQHN3BnUwe0CtIpKJvbhrXITs65l4pSFW5wylW13KwJE7v0Ha18l21dTgbKMBqczDJnHC9CAema4m0Wv+GjNGnaMgLpidgzJkC17VSJvS3veto+wKQmBrQIG6LGpFovqqNXX3N84QlHRkx7krscxkLu3Bx+SUqIFqZSLNiZxjVcyUdFyBjBtNAhcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ZJYb7OBgZ8fLZD1qapOKPbyb6wU+xw9GGDQ21f5yA=;
 b=kaXX6Pw2fd/SbxzVYy/+wmO/Fe4oUAs6vwbM2p+pPVnFkCby9CZVU3tEjw428tPSLYb3qbtXRYP8qV6ZDdg6pYzHQdbFwtBF2qrCkf5RzPX/8z+7odgNOnI6eRu1EOZTuo6UVEXWXuaPmKFq3ZDzNM6EyJPfsQDH3OujGm3REFE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 12/35] maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
Date:   Fri, 12 May 2023 14:20:13 -0400
Message-Id: <20230512182036.359030-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0362.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: ae13e170-d695-4942-ec6a-08db5315b05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RB2wVAQPXBWP6SG7QGQBgSBS/HrL72z5n1OijMc8sdoH06L+9k75jCsg0Xsym5fIP8aTHiJm/W3XjD3n93Q26n1YtiUGhXZbbuwOyjym1kZe6BbDZpVBt8yYmBXeSu3LeJkHB172Xv8q5UXEN/686pA1yiK1VzA/hDCwJ7juEbdp9gaP1Mj6X8BJK0pTBesrG97f9Ehe3DYHBl8qQNHXwWTYF4xMMklCMEF6DYw6fY5CJMw//KzoKTIeLjXVd2VqakiM8kPUgzv1zIa7aNqvYIHeNiy9dVtuaWDiW190TpaJrae/oxHIAom9gE5m8QKCBEu05HXBm9l8Z3WftJe8gPPi5uy7tIgf4/yMY0ElUp3QMsmUDpRNLRVPN1q5rBJBMI7tYXTHNKbKIvnPtA1iiMjYC0FVVCWVrYqJE4kpkaCsk1nTS1jPkdNwckx6cRgRATPEN7UkElLiUr+oy1jv0iMstrQxwUnYuHgvKm77gCidhKS/6Nfhn/E+EonkmeVtXrA1bCyAf2JngCYscE0ivNk3ltO7BlvP6mwjMnCPbXqKRCfwyUpANDXBqSRXe156
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(6666004)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faozvrWHJQ++Qjd9yXLfDJEORatTeEOH+mb0aHN/xndA0/Uvpb0IsYeYM24c?=
 =?us-ascii?Q?tKZbUepl18LQ/yRTBSej+4E78F7qcUXqSr8u13F3+a9zFH7qWvEvN1tbpehL?=
 =?us-ascii?Q?bRVwy+be/wPVxC0R0YdKIRALbrCp4YtMlh0F6zttozZLF8yMkSLNIGN6b1n+?=
 =?us-ascii?Q?wVa90o/JciIeoOQWUDChP7R5Ycbr7Xos+9qC7rZNExWV3dc3IjMmPSoTl3cE?=
 =?us-ascii?Q?I75o8oboKhmV2xj8LuNFw83ULOulwA9VX4zQ30Pl/3wF3YnMvrVMBvUbhbct?=
 =?us-ascii?Q?IAaNTj2Ip/pxLFqXqGJQLVeytP1J2dS8KK2rV/IikJ1zngN/ZJvCO9LM/7nz?=
 =?us-ascii?Q?vS6xj40GTdzXR+5e2K0eJIm+jsEN7pdgOaoi1IhGTQXsu4h29mzZCrwhWJ2h?=
 =?us-ascii?Q?coXvWrXLKZc3GBNr26KHzn7xVUHOKBlXpelUeiQ84aopPpSXjf6UkGfWHI+P?=
 =?us-ascii?Q?BqziaaZTEvagBY6LGWkAAJDozFPoygapP+OlxayRZme0VTZni+FKWisk3xCV?=
 =?us-ascii?Q?HmIiLgMHn0rjbvzotItLJvskl/yoR6VHuIUx02I8rMz3eglaPkHLVn0imNVP?=
 =?us-ascii?Q?0ucTyodKmXM9ETmVrLH3ME4tN7GnwT7O2tfjKAe1yfJIHFMkma4NnF62o6QU?=
 =?us-ascii?Q?6sL9EmY+aBqpag3iy2DW9mErdNN90UQP97W4LRrhR+H+j9HYcH1DnY3Ru1rH?=
 =?us-ascii?Q?Gq7hO8VR0UYsq+oZ8h09y0NDYiBE0uZOBVtvBOpodzbySB2VN2+YUVBsHRT+?=
 =?us-ascii?Q?0J8PUNzqPq72BfeNikTIZvRV/MJ86e0+hjcspu/K6Q83TGH0Kk1n+VpHjPlH?=
 =?us-ascii?Q?nld1ltnlQsjSj7fhlotQ77/sctceS2LjjHSNfJPVk+Gb4Zu+6n9R76HLRfmE?=
 =?us-ascii?Q?4dFiCyRz+aCF1LgX0ZL+dz4xW2ojgClK1Bmx7ivlZAyfne2jaoxwQy0P/cGS?=
 =?us-ascii?Q?Tf6wrB27WJzJiCcPkSBwOIQ7pSfb0sQak3rZ3N5lUawV83ewz/OLO37n1vOK?=
 =?us-ascii?Q?x+n7l1WAjfHVJ5iL4BSxVXiZqQGMl7csGKcrzcblibrC5DXkX3Y2oGwgWH93?=
 =?us-ascii?Q?Xx0IcYKvlgH6v/L9Cc9490Zs0ZW1qqJYNLeq3wR3lwSiLOmEwQWC0rUpND/V?=
 =?us-ascii?Q?HNovKtXIUbC8sKTCibUVU8rkal9MrGbFuJS13BZJueQXjF1DNHgK5WdQQ9Q1?=
 =?us-ascii?Q?GCeGghggu3QGthaqCSBDT2bPG3gIqaNu5aCH+Vv3JntW7flxFIf9zYtS5PrU?=
 =?us-ascii?Q?mvGfEK6mnKnW+O3zEvCYjHJ2Fovk3NJKLEvWo9fH2E9EMOLXqf9LHYNmrEpQ?=
 =?us-ascii?Q?zs9RL6jGTOX6AsLO0WWb/kRRJQtIZcc2SfY6Pl9lYCD+1263xlYdWf+DPMy2?=
 =?us-ascii?Q?n3xEna20RVMjGtS6OKGuMukMsWpeV9ghmclqv/PXfdVwCyQqBzL+yIv+DhIX?=
 =?us-ascii?Q?ffrTkVFuwmm4dM+w40Kq1ZsuDLOzW/MAEv47sqZ+UZruzENHtKOLYq8vscRP?=
 =?us-ascii?Q?U0pHrjexHSVhlgVH9g0tWioD78Sgr90oUl5ZnHf/LfLYGkh85NEGH6ooW2SH?=
 =?us-ascii?Q?6bCV6lGG52HQ/Guj2qe+qVaES0Tg9S/bsZp4efjCaDx3VH7kftOjHxAb1wMl?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DzQMrUPl6JJ1/vKQ1egR7HivfGci45jW2M5YDYxzVOy8szc5+D+wtXVTTgGCRbsLG9ThG6LIpFsAhvONXWC2hDjquN8DYB0HC8jKywQXMEAKC2pb/UjL9zUlv/o+Q7KxK30aCdU6ZUz4J5pF41KluZ0CEcAZjZRHnZpxnro6p5HEtau/CKE2JD2p0Jy9C6KWkhGz1Is0ptZNwDNb2PznbFy3E9xFLoyMO6ilrjnxE4wpNlxI2/+9B/pPMfRK1QLySeVacn+zXG5EWAaQb9CvgNM7XJjaGIMeWB+xg8VHPs2sCb/3mwsWDh1ikiBQGy6/RRvMUVTAbGfie0Kn0UYFaRh0Gp+yWP+kwhDlXtZ2y82luHe1mou2Jz+3HW7am0uQDdZkhImt1H/hOpbtVKAieRSuOyETHgEwrSkxfd2RHqlGAkU+YFeqARzZCW0L3K6SR4SmjrpQ9jRaDfeCzVex2F2t3lfe8FnJ7oMbq7SNG1YZq+DT56y8VhG9oVIgj7+kwfFpCiMaKV8KxmakVfuIIKDdF0UiwqQTE0IvWeMo90Mj4JqOgX4MxavrDQA3iShUQ3moMKCQ06vvkNUwtiP553CSskCOT3fr5465HXCHye6Hgwq9Szu3wjgqEM/IpTZcyRIgDxfSF1gl2a2ciDDOlfrXqoPK4BQ3vbCJQ0scpJ6shajMCLIuW5fq0s/8DBnvJx2H88cyfuhXnIqP0pPVTU9usjk9/Tvt9d9fWdQjTgyC/1MpHd1s4ShxZCE47JNk+EAYRGo0YV+/VrstUp/t0pkAfDQUnOQU6i+5wX8hWRP3GbiMQ27NtneC+aGbbbBVvIeGMYpptyciTd14cNL4xRqH5D/8cp89fuU3vF8mtLj3h3a5yrAaeUL5qlANNm19iB5DZMW/z5xyEm25VgIatA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae13e170-d695-4942-ec6a-08db5315b05f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:22.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Achpth6I9Di+7F+DV79hkaPqCpwwTzTcmF4EknQHUCVvsFd8XY/YB9PCijuMS8E7gyt/pdhJWdlS7ZysLDgcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: kABGRXxpxGBOZnBVb8ldocqmyptEoEJF
X-Proofpoint-ORIG-GUID: kABGRXxpxGBOZnBVb8ldocqmyptEoEJF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the even of trying to remove data from a leaf node by use of
mas_topiary_range(), log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index da441042ec8ac..824967872d426 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2345,7 +2345,8 @@ static inline void mas_topiary_range(struct ma_state *mas,
 	void __rcu **slots;
 	unsigned char offset;
 
-	MT_BUG_ON(mas->tree, mte_is_leaf(mas->node));
+	MAS_BUG_ON(mas, mte_is_leaf(mas->node));
+
 	slots = ma_slots(mas_mn(mas), mte_node_type(mas->node));
 	for (offset = start; offset <= end; offset++) {
 		struct maple_enode *enode = mas_slot_locked(mas, slots, offset);
-- 
2.39.2

