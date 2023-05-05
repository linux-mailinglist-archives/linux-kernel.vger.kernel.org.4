Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CA6F87E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjEERpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjEERpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:45:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662A1C0EE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhMLS014811;
        Fri, 5 May 2023 17:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=11n+ziE2wH30vCc5YSng/swz2aTw6+RJqOx/euoewRe2PUYlKDmWJhWU/V5UiUvhz7dT
 w/+40Us/+/Qhb/JbBfi72AeeR+AQ403Kg8JcVvGp+uLHCTAV3GzKaImcS9P+Stzhvxtj
 Pn5p1tAeb4JxMhiXT1QYpeP8MwM/sOJp3dWmcKVZu43ZRqkTmiJvDZD0dcOaf2b48ls4
 Ygvl3Gmlc1jDjSM9d5tWez7pUC8kd31Fc7prJNQdopO1e/Bmw47fngg/JoF/+SP5kUc+
 bmR5fdzKqwC3XLPYdUqa044ft+Q+mf+ySWP021h9tPEL1fs5QfidbVrvNJbKYTq2Rdow nA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sneddyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345G9u6i010002;
        Fri, 5 May 2023 17:44:18 GMT
Received: from outbound.mail.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spank55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPvINDff1hO3LsvcAq0BJ/ZjxWeft/31uVAGGEZlZLkiotIsnnJOFaM29TVvt7tVTWlMu8nz8E9UP6BIejf9/IGSZ3PJWmKfm7oW5NdfxSyEoCZR4ASbnb4kRKZ9tKqot6Zg9cpZ3fqAnWPSqOL0ULL9TMQuhD8RlLutcgeuMbjJBgZI5Ly3V+oJSDXgxbBuwlXgVfalyLE51A2qkC82S6638wXALmJ5Zm6PdgrGujbfeC2HpuzrHbfEyofVJ/WTykW/n+NBbLZG7AhF876tHR+z4nyK3nViRJUJ5ouldmA8csC1asMajm3dPOTIFVcpt2HKKXV1ouU6e0NbCwS6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=X9/66fMZ8TOU4CF/Owb7cGWBvAg9bd4r5lMvnfTCfowc+SJdkaSb6bsJOCiIQGQtcXO7Und47vSgPHwS00YeEOFdXXDXTpWlcwiD2Vg1C3ZZzRRcn73shqaX9dCB23/wD6AdpyY+4GWqAtYvbdbV0U0PVbgFL3lMpJtVh02Rlrxhral+HxvSc/NmQW9H4Wu36vJA4Oydmshz5NUtR9quBiDEGHgnUpXmFLWW9oDSO3ac2ygVq3utkdDff4/CPxK1fVqnPxIQ0y7ArZdkP+bF1eYLr8dfjEhudVCK5nR3iT23n2QZTORw+iv1SPm/94q+Qxg/Kp7973Uh9Yvc4eXvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yNU9HJW6liJ2fUnwkIAF9WIpSr2/rxcoMxVBhqd718=;
 b=BBQDQ1M+8676PLd9kZXtJWGV2AKdzmGvpMeNbT7ZZgAjx0g3KOhS159eAH/fTK6d8uZsfpkbQbZRgvqL2qEa/vCC0ElqnrEX5s3AyJmlP/p2w3wjZUYH1Nbxabfs3KyqLOasEGq9zB7Eko1VTaZf/mlC8esINL2XswpAeMN0f8s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:15 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 14/36] maple_tree: Use MAS_BUG_ON() prior to calling mas_meta_gap()
Date:   Fri,  5 May 2023 13:41:42 -0400
Message-Id: <20230505174204.2665599-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e3a9bc-75a5-48fd-8120-08db4d905844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hQlCXgIbryg4d8HvtLVWFrkl9HJalHWWSLRs7dyUhtaVdSVW6Dm2cSIr6z0DLmpViKMmqw3NzIi/rfZSak+Av3Exg1osWTM/w430cEfz6tVV+HxRlGPOYo2tQyEfFNk3zvs5QZfPgHe6ykb+tal7serAjLXjtL+SHuiswOtNc3QcMreByQwhHfCJR8dbeA3N3xqqcm6tXdjiWtvg+kqlr2xd8G5IGI6JyJo8RYv840oB+TS6IkZfcJDO36+fPpvWsY9mbLExiauCI/R7cp4VY2M8gQh9cAeaqSv7pWdcL+yAq4/DJA7kh27gB6PzWonWR4OABFwnUngL4Pt4K9p50KpbtHIkRP6rTeAhn+pJOugwwholfr6Ik2+S9ZoNyzabWxcIbasvpLl+Wl4Gy9mUU92ECFNEMn4x1ywOmngXboSIHqR+6GtWimx8kse/iu1stTNnUrWAUn4ruWtQelCRPArwUwpLexU3xaKL7P70THqcm6w5PRjrR6d/0m64kLB5ukZV4Vr2cb0bXKl0+7cCjXZFhhS96qZRD0ESpjBaS59Oc7vwbbWa+71WBvPw8Ik
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XDcEqYMvMOkS1fXe2NKaCvTjITJpU27ftwNnEjJOmKrian0AECLfo3iduKdj?=
 =?us-ascii?Q?5afx7ss/4Uy/IdTcx1knvQ0kxG6QmebWhdZXNFpUwPEvudyanPlnEWxkz2tZ?=
 =?us-ascii?Q?FPfhCbEXjgDpXM+B+WilQvxVUFh9WlU8J1KBtl95BaNhzNnBCysTrPQqpfnR?=
 =?us-ascii?Q?Bah7jB59gYrEyolHvybNFQUKWFx5fHRFPVzfD0/nWc9r8dZToTQ+csZQO/Ml?=
 =?us-ascii?Q?UoE6b4SONH7Hj1ucruO+sFF8NMxl9M3Oqx8r49NPvEyjMV6NDXhRnuvqaq1S?=
 =?us-ascii?Q?pHnkVCtpb/faTvi4z/cV31T/CalGMzSiNWIEx8CEQ8rHrAEalePcWfy8biix?=
 =?us-ascii?Q?PG4FILWU8UCu4Z5v69fo3VlQc27MRwHeos1A3QcQHYMr46isxpJJHvDE3wbE?=
 =?us-ascii?Q?M2Ox6C6vPhfZI1iYj3YTfDojT2kQWtr2z+el9oVqrHMt6Mg1dRgr9neViqx2?=
 =?us-ascii?Q?FiPK5jnXUkgWFbck51AX/wVzn+v0wWsbFdtpyN61/veRgJ3522tRsCpm8web?=
 =?us-ascii?Q?+zYNbbLTSPNQ67Ts4zCqZUMSuKsPOuU6RI9J/znFi4e2FFwQhGvO6ljjxLQS?=
 =?us-ascii?Q?8+cLsZwf7zWR1dnsNbfUXT9i9asf2dBpu/VA0PCPh7ssWvWuXN/dan/a1wfM?=
 =?us-ascii?Q?KNiVxK54OFnbngHt+Jf3LpyL/FarCMyixWb/+vcngtbqiJMPTo2DmDlXFeZJ?=
 =?us-ascii?Q?OIW/FrXt5MbRJL4adUt8oZWX38/LWv3Nf9m4S1REBb50kuHvqL0abVeGZvHk?=
 =?us-ascii?Q?ai/2OEthZXz3E/FLJCw0SBTPkP3BipkEXKopOYRV+4tBGGuDOQmWYUG6ZAzB?=
 =?us-ascii?Q?F4KTbrdvgfiXbTzEHAbtvTUxV80zsypSVm7R+6NDaBEU5GyhVUMJ/VWICAlh?=
 =?us-ascii?Q?UzNBcVEdCv0zwYrA79vD+lfkHsIYg6BDDi/qbX5E8EGxEIVYDIPiYvB+O8Ym?=
 =?us-ascii?Q?qijJUZh8XT+81OiNNmCSdLLvcTa6Tu9V+KwOGoSE59eQThyVO59gY57WnyQV?=
 =?us-ascii?Q?1pb0iADsjbKTRq5Ks+sLfDkfLzosooT6aY9Wy281B+HRaihxdmHm72SKn1HE?=
 =?us-ascii?Q?tbbZcpjzM3nfenQCk2DyFGoqi3q6gGjRdRJ34pN2R5k2B7oeAou4EGvJAHuZ?=
 =?us-ascii?Q?Uae4coXgVXgbsPV4Lvuk7WZpAToiweLK1THbP1QQG2+KG5NchHoT+crgelZ+?=
 =?us-ascii?Q?Kx98Prj7I0h7cQDeaQPQVBV4fe8J2PPPAONTmTwnfcc3kc4Uq/MRDiswyV8d?=
 =?us-ascii?Q?XbF73ulzilOzmTImjDFq8y+mtoZTbi3m8HkGCxDBVYHig0aeby7qIV/KX/zQ?=
 =?us-ascii?Q?8kGFMwhw2Pl+BVjZSgbboPkr2+IzQGRU76JpxOuqcBsevCvvKhnxfMworCAd?=
 =?us-ascii?Q?MGcEKMthtyIwn/Bw8bkY0FEy8mYGdD6DRsaaosfoTtlPLYSIkKQ8CQ2OZ/M8?=
 =?us-ascii?Q?jXuGxVyExY0CZfk5QDXBu7KnfNut+1KCgPJ6ewpHRw/QlPJIkDG3EUxYBKZD?=
 =?us-ascii?Q?9V9GzWVHKB9lU5tNHw5BZsAizNBPrioUcXt97hah50CpIrjZsMqp7bdfSgaC?=
 =?us-ascii?Q?ywA2rEUTmfOxrCLRxv7OdII/6knxQW4g33yzf3cbmJgy/hyBz5TXtvRjT8my?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J6NKesXpDw8DnxAU/OaT7CzC1X9ML368uejM6ClXasOjzVGLg4lpZt+S3wYICp7oyHA0yXOWvntSAKw7e4lxh59ucMh9mVklBS3FW+FBlVkMm084VNZrcTMmZAO+ii4baTp42oY8lR1XanFcNN/Kt089ZA990c9nprgxj52qs1rWKuqNMDA7SU3En6DHPBanq2P2eob8TVOei6jQetClyyzsrHKgFaKnbS87HXjuCIKQSpOxR/jFcGyBhhCVABuNMcbpjpRc2lBJmwqhjP2dgbWSAB1IEzmb0Tt5sgdDPdFiV5x7jYGr7phz3+qWvQ5vDwNpxwXKAwiGP9Z8z8bnG4g9Clr3dJl0AfTrT9Nz2QTbtfmEqJwac7vmt4QI2RFEnoTE71W2QMrWknMYBApp5srMZOFTxZKC0oIwLl3cwvPj+xUIflbZYdxHvQK0IXCJd7ewEZWtTSH+aUx/UemJFRsG63t1UKs0ipebs9/5A1w5bbKlgLVuusMBmK07r5g4bRb+QswNP7u+02rxAHKnlTqUhqdFj8Q/CXfIpFjFoWAHm79kTbX40pR0wVedSQkWAaPwV63F4Y+8lH1d/gBb/gtxgly+Tbm/F6V+l0ewAAkMl37BWC3N+2XRzyenhFtV2vyDnoyqEzr9zwCXvgWndvOJIEyhiqmlFCJnrpADzAEIkIDUb595mREZq3UCPiIsFWDmyZ+sEyzJBW+AxoqDo7JNSU09n6V6wCP98pnZsMw0Vd/9Q6QRMvV3OJfRmRWlJFosIXVIwerbQTDgXvmLY8bkpwTMAJGpxiixnzqHpaQ9wodes2s7zKLyxrx6RTBBwiwgHWCgxUz+65Jq9v9ONthobM5FMx09l9kYSkBgttrRBZo20Vafz4ew49M29iVvs4QR9aXyB1zoFymn2aDlig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e3a9bc-75a5-48fd-8120-08db4d905844
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:15.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjNd+dQ7lh0usRIMzjjQNgbfIW0hUBiyIeXz+W7HIBrWjsJepvD/APeqmkcecVQdqvokyHq48pOhTfxgGrrzRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: cP8GtmiRcDCrQNxIQs5lLM3gySqSZnmt
X-Proofpoint-ORIG-GUID: cP8GtmiRcDCrQNxIQs5lLM3gySqSZnmt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the call to BUG_ON() in mas_meta_gap() with calls before the
function call MAS_BUG_ON() to get more information on error condition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d5ccf7bcf3b5d..d7809a7000c58 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -963,8 +963,6 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 static inline unsigned char ma_meta_gap(struct maple_node *mn,
 					enum maple_type mt)
 {
-	BUG_ON(mt != maple_arange_64);
-
 	return mn->ma64.meta.gap;
 }
 
@@ -1628,6 +1626,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 		return mas_leaf_max_gap(mas);
 
 	node = mas_mn(mas);
+	MAS_BUG_ON(mas, mt != maple_arange_64);
 	offset = ma_meta_gap(node, mt);
 	if (offset == MAPLE_ARANGE64_META_MAX)
 		return 0;
@@ -1661,6 +1660,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	pgaps = ma_gaps(pnode, pmt);
 
 ascend:
+	MAS_BUG_ON(mas, pmt != maple_arange_64);
 	meta_offset = ma_meta_gap(pnode, pmt);
 	if (meta_offset == MAPLE_ARANGE64_META_MAX)
 		meta_gap = 0;
-- 
2.39.2

