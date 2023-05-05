Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02616F87D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjEERol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjEERoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:44:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE961CFD5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:44:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhI2W028007;
        Fri, 5 May 2023 17:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=PYRNpmeUczSDqawrC/QcyXE6aI1B2NpsCZUw+mkg8Uss/aKmTGEQPhdNpRItCncFLOct
 9fCZLL28+MAkHpztI2JtLkiiytkBYWNqsXxdCMHJCKX+n4EBMaBx/FCnYxWqg6KW7ZCT
 g42C+uMrUZXoEAXnMFnFDmq9FEhdoap2F5rh4ge03r7/rPnWkAhmDlr+uaE+UyhgYV/l
 LS4GByXOpbe3RNdk7vrV3x/Q63yv2IVIiQ0I/cV/SCRBdyew3/DyTEztQ+zFA9cQgbik
 cT3HncYfj/TOLMcN5Q+Cw9FbDYV2sdBXxqAofQ1Wnsx3xxDuzTXbJYwW2ieRs5l0RabQ 5g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t145jcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GVNqu024864;
        Fri, 5 May 2023 17:44:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spacj05-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR7VMIph/fO9l3zLeXBF6nZmOAMCEyMBoL3XNvU4VXVZjNYgi+2qFRZFbLQGHzsZMUxd6DIdGP0hX0fX++YhnRq+c8wliSAexbzIz0n9vOe0pBdCx1kRdc8YkWnACEx5cIjeukzTl+2XcRudxXOEucXekoa+GT5pWMoTZ86DdnczeTa6SZRrGZeZCh2l6FRWR+2D0GZ/veK2ZuU2ZIbvb93UjSeN/ZazI1+mXy3HBWStnRxfmnRvsRYSYotjmmV122LJcR4B3nUScAp/wqTw8E9ptTLWp7NYrEjdVCRBQbUQc5qMVS0DevbM7RIhMpFZ09c4y86y0zmvVeErIr6JbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=m+weNgqhz1/dpLNoK44Bd6NMNfnGNcCGk/y66Za69hd0B0LQ9iupZYRsxXz+lqSxTNbwp57B2UUx2tNU8s5xyRHcbuQhCChWWhI94+cNf2nZtmgsL03wQd8jd3Uz1167f0V5mfUw5IMXd0+zWQG+1/LrwIo8NzW2ZtpZ3iiZ0jTvgETOyfEGE/kmoIZPjGm1CxlWBWhMW13PmrIaZEGjn8a8xmk5Z+V+jJeKzEgVpU7qDHazXm13rVG1oA/8WPWKaDN/rh1a51S6Qed6x/KeMyi/z7YNJsE8FlDcSgZYc0uSt7j6tHv+Op3bTaBRXFSyUf9PzF8/rE5MSi3lBruHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5VCQae/u+KrSguTgZokUl+Fxo+cz9ZckZBWA2If+Ro=;
 b=EqjmN0dO+xauWhY9p7Z68FvQzrqZSJiOa7tMr8TJAy6+VKqrNHEv9Oz3XZT8c974J2kmR8TgAcebrHTx+f1Rki8uFORK03qviMZOzKAJu5QrFX6LQZnBtp3ZcUm5HCoe67SpP5TSncdfXocv9aAHDBpDPEseUo/j6HppxynFwAo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:43:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:43:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 08/36] maple_tree: Change RCU checks to WARN_ON() instead of BUG_ON()
Date:   Fri,  5 May 2023 13:41:36 -0400
Message-Id: <20230505174204.2665599-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 902de8eb-59db-4565-3005-08db4d904ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSU1fR+s/856spKUFEFrzTqDWguS3/lNfO+0YdsdxbEjBDai571NsuQNSCPx2UbwZWcfBvredlGz4njOlZKuntH0HqGW7dbFMw+atZzDjKi39kMj/w7wDQEodQWKX9FjPutUY1V7EeYV9YBu6/SBH1l5zLSta9YzlgD/lhU6lIoMhWHSqKteORKFxBJV7dVomruPolowQdq6nTZwkcMjfmdJ4tMLDibDibqSJ0TSq9HZf7aY6Zb6o9QUw6/x95mc8g9zuFvp3ZXPotZTDzJ7rFV/jus3xFnCJiAzoU423SVHIGfnx4jJ9FVhXcDV+CRyNMxO592iPSfJ5Vhm4ji6fJczUqwc8olOtvRPY4rtStU+uCYgECCuf+kmWzEokAs59HhqTtd8p71qNOO1vJsLaqNbkyyW4FFwByAAt4QjPTkOKYGXXNYQwvsiGCpOqsWeh+mgRC9hCVYKSgQKGVtFZAPmI5JPUyoWEj/M8qtLpBs71vrJYpYsFob6kOU8H4QN/mfFar8xPk2zdoCxKUitNH3MRqmEn3jWLR6JAlxA6xx9YR/G4+SOxDYWf3NvDyld
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(66476007)(6916009)(4326008)(66946007)(66556008)(6666004)(478600001)(6486002)(316002)(54906003)(36756003)(86362001)(83380400001)(107886003)(2616005)(6506007)(1076003)(26005)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(4744005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaFQDCkdvGgyx0BHFUXcXLlwJgHldSLPxgIQArM0B6xBW5AHqnREzvzHjDog?=
 =?us-ascii?Q?V1+1YXDRsqQa6xkoJvS0a12K50+58Y+A133QtnuG2Vjw7xDRG1Zyyjvv0K7c?=
 =?us-ascii?Q?S0/PTqMZwJni7Ivo9GckLv3I3xeC1be58UUkaZHk9PgcCd6f90LTVLpCcJHQ?=
 =?us-ascii?Q?iO22rU8Q5X81tPhz12n679w9bk9gBMD/ad55n9NGbgMC+b45TG896lrCVIL2?=
 =?us-ascii?Q?N+fuNucQNIB27cl4kIgSvH/aL0PxU//SLosHgFq5O5f0gXAUF+blU02Z2VWh?=
 =?us-ascii?Q?zfCtFwyS/AZbPC37I3FJRzL+fmBe86WZ1nD+h0moJmhcWdLCzBwprTlbEdCq?=
 =?us-ascii?Q?NXFhBVYGaVj3Pz5ikpt+J9h+e6m3hu4EgKy9jkIiTsV7WScK7GZ0ptHwo5FQ?=
 =?us-ascii?Q?FYMNimXKioD7kmv/dy24fTNNOz5XUI6T9VJpIrs4NPwXH1YtPCeR1zGiZjkv?=
 =?us-ascii?Q?ac7rEbXxWgCfiHZ/cq2wVCL69DU3uBA6b44xynV7svB+m7qnvIQ3c/3b2jAG?=
 =?us-ascii?Q?jIcoCsqf1phCAteKdla/LAMVAU6K8BxAhAPOePVgbGbLv94AVnHaQ+5OwJMu?=
 =?us-ascii?Q?7G/vKX+389w6gIQ3zViTMX6j4Uwun9s4C1Y1NRcSTu+MEzALvi6pXx5ecLn+?=
 =?us-ascii?Q?9Lf0MNMXSbxOFeLjI9SzhzNBUsz/nxlMmW+tq8kAXhs8C2W0HkB/t+3/sNj4?=
 =?us-ascii?Q?JFQbxYjrwwjaJ0D6o4rKcDD0h6AtsVWDPwUM4pnAhqelPx9LNV86n2QIzd4n?=
 =?us-ascii?Q?m7wy65dmbQDLIaxsUCFtpEmdD8GsCFucQzM/Te9FniwKX+CmxbNFB8t6PHuc?=
 =?us-ascii?Q?btitz94s4uYeYDWl3Xmiqt/bmlUU2nN73VW611nIONOt1f8K3DYbHqqiMTrv?=
 =?us-ascii?Q?eGg7f4Jq0OGXdPVBTN9+LzZgbzBCZ0s/LQspMtYQLRc+VY8Ht7H9CVeNu0WL?=
 =?us-ascii?Q?IMy8v1IzTa3HxYrUQNsJz/gR+njrXU8SvKeLwJWa6gIqhwE45Bgz5dztlirD?=
 =?us-ascii?Q?hbEXKNS75u2qB3LsJ2sD96OrSQC4dyJ0ccGsnITL2+xUIUtOrCCe+1Ic7jGs?=
 =?us-ascii?Q?lOTs426JgGvnYNMef2NUJDwqH+gK5pIFSOd6A+7v22NMnAOD8fxuh+kS84pE?=
 =?us-ascii?Q?tyl1MKithJCaixdhxd7LuaUQZQfb37nhJoa6RPikwRWL2IxStg9QdpNuMBxL?=
 =?us-ascii?Q?UDzcNQYkFZdefCmzQ2btwiBaexoju/D20z823drrnAsPblOf9vZtD3Xd1DZD?=
 =?us-ascii?Q?5kazgA+uVCPL2N6q/lwe0mCX2YnLCy/avePZvFQVv2jhPvGSnxmnMXP9JOjq?=
 =?us-ascii?Q?2Innrpb0NmtVcUsNxpTD4aj6trlEuxrYM3OE/jxVuwSeWQAVfOeJP7CBR+lQ?=
 =?us-ascii?Q?WjvN/kRRkpz0beh2PtPoWl5z3Rp6TFp6X2sRtPNxp1HPv+aUNqSND/cTD7JC?=
 =?us-ascii?Q?lKw0U+tFHve4LlckD3uNnE+b0m1e9s7xCL+KQJ+aBfuyKehPXj7d7RaNJB2y?=
 =?us-ascii?Q?CtaGZLSQeQlhODyh6Y5vs0RvFpDNiwRebS7MEGsDPTg8Bkzlx+zHsdua/ilm?=
 =?us-ascii?Q?QXEnV/ANu4TcFMcKHVpdL7lb9E+ZGfthUuMbCWk/JX+NaK9kZoJ5o/V7A23c?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: prYBFNYLuddNwBT7bPBmSR5bFn0V5dSUiXQNv4jak3avRiNcfLcR1S2II+xL7u/INEqkDRQvSpOdJi8RMPfM5q4fUQJGO3U+yfBjbwlD4QADATniFBzXbhhx981MMV4xBB9BvhWRZggCBDfMwtc7yPSv4H5ZxIViap6zO0R9vVQyaPLgIEv8ALEHX3Opah7pkNWfNI1QKRdLiZ5/WdX7WFroi5jJLRvbouRNYdJM6vO/3jY+OrSDusL2D7+fJihqOdj6jy9ioh4X4WYa3CnQhWART6OtKU1ChDR91xU4koRt0ZJ2dd8LpcQ+vrfvoVryXQh85nXlfTYbJccQ918m3mPRp1Dq5rBlkj961vMAGWyzTH60vv8aDjyigxm1AaTbH1AHjwpR69Ab6bXQi1Y8BxxLpgvx1KXed47MRH3pBx0aQPPJ8qyTWaKOvgAaK0XJVncdiARcju1KZ3fwj7moSbp0xUOHQO4QemLk0Xryw2cUmWoZ+C/o9Iv9DPXLEqaNytr8syz4Z/hIMwQn1rKvLjDOLC7hn6KiZkaGk3ydr/FmCZBnshXnXBzAr/+qdNLgoqYnn2X6P6giGfVhgDUI8Dn57SwwjQMuBWzj0UAKRK1Dc/2RDgwpCsulY6v69WX74MPL+Y3II/bJoWyGhrHl+MCdLvVR7W1JX+Ri6xqMgmnO0gi3IzEr6FqNYHo4KWD1e0/11ApHyd6EaLg9dKmKSgaQxtA/iieub5QxwOO5+ebUDeokjYIZIhVlDXUraAP1eQltdRWxCh//j1prJD5+I0DnswPNWnU0znPq0V8oPG7d65Exh3QpPoKJEEDGDEpEXjnImRYpEGtaTGTvQklZvE2DN8UaTb8kqHNSM2ebw9HFGV9K1zz7j2LDUFqRpdIPa1FvtT5Ajx3ihW12mOf/uA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902de8eb-59db-4565-3005-08db4d904ea8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:43:59.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B4GKTkRymNlPT0CCMCPBmnUgYAziN8daov0Eg4PtDoyusqnvGeQAz/Ivm+O3ploK6CldBTmOSIR6xuvyy0lHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050146
X-Proofpoint-GUID: SsO2WRPHfTzJBXWP9TYV7fuokPEnX2Wz
X-Proofpoint-ORIG-GUID: SsO2WRPHfTzJBXWP9TYV7fuokPEnX2Wz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

If RCU is enabled and the tree isn't locked, just warn the user and
avoid crashing the kernel.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 204d7941a39ec..ed92abf4c1fb5 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -616,7 +616,7 @@ static inline void mt_clear_in_rcu(struct maple_tree *mt)
 		return;
 
 	if (mt_external_lock(mt)) {
-		BUG_ON(!mt_lock_is_held(mt));
+		WARN_ON(!mt_lock_is_held(mt));
 		mt->ma_flags &= ~MT_FLAGS_USE_RCU;
 	} else {
 		mtree_lock(mt);
@@ -635,7 +635,7 @@ static inline void mt_set_in_rcu(struct maple_tree *mt)
 		return;
 
 	if (mt_external_lock(mt)) {
-		BUG_ON(!mt_lock_is_held(mt));
+		WARN_ON(!mt_lock_is_held(mt));
 		mt->ma_flags |= MT_FLAGS_USE_RCU;
 	} else {
 		mtree_lock(mt);
-- 
2.39.2

