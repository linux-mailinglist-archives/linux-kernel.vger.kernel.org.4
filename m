Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE79700F40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbjELTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbjELTUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:20:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5605729B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:20:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4ArN002642;
        Fri, 12 May 2023 18:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XgTAEgOBahmZoVkTBhCJQdosI4AXXEwWd8kwuVIwA/8=;
 b=AC9vkotLHXQHdzHJbPcD7wcC/5+f2n1Be71PgqHwUZcTC8Kmx4pOWW2XVxW+mPW1NDfK
 FOmSEOV0nlWFUb5ZNcxSSTv9ZxrluhgmjkT1d6LUxBmcJlwZS8B6Fsc94iVncCKL/aVv
 gDcBXtZUNLBf5XpBFuELjzW9rG1xHfaZLTuGZm61LHQZFt4IGVcYg294ES/VxURkc2zH
 Mjc+UrczsdV/kk5t1vCPlnsl8E8BROBicy0tI7Yt7s9kDheETyV9o5OULXLbzcH5uxUN
 EYjvBAExZiociAr9AtPc4EciktucqHjmwsaidcWIkhrIJULK4XHB5dcIAB6EHjq3Qpbn 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH2mTv014331;
        Fri, 12 May 2023 18:22:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf8316cqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGq5iUdhVaF6YyTzu8Xhz1oWNbNm2dAU0jv9ndDpuJPhefwuJcaRvXc7zVog1Zur/r4C2Vj0eKB5PmtPeR7eAlpXfM+MRiVelyyTQEupXr7UIJK/hoPOoSe6UaXpgKS4tBErYqZd85Ty9hLuBDMWfsUTFbEjHKxdzwqavf7KM1dDJKCXiNGGXvgAxyI674m9Fg4kcVpqkRhdBW3YGkcA7gvo2Ail9G9ckrORHCH8s/fd6zhvA5ouGd6/l5CsnUvZT3PbZGSmusZGwxposq8Es2DQYIpZ4N+6kEuayhSz3f33qvNfNoz6OnN1xmTRngn1SPDFyYtdEnp8OjobEQWgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgTAEgOBahmZoVkTBhCJQdosI4AXXEwWd8kwuVIwA/8=;
 b=aiDtqf8Rc5vNhR+bfqjh/9Hk6jW/VrgXeeGuXf1fiAXGu1NOnvXjryhNwfkcnzBLIAmuXkxrKoUl/cc3e5DJsc3GkPx8XhIO8KJzhL7G+hgc+RG/7+7vNSWqyR7I6RVrbxIkSqiiOWrbPjKWxmLg9g2uo8ezhZZk3e8PJk1lxf3sNvDUIJtgohDn3e1Zw5UPJjvkEmw7o0LjnSrr+Lw65CQ0nLm9UMiHCk5flemNwoSzCs28teOnYbVA73cZjYzIptLkgWlTOVtDhJPLQEB+acsjTMBY6I3NJd1L5c1BWmDq0M3sguwCnv9S7ZYkCGv/kQxX+/2ogt7nfi9jURoIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgTAEgOBahmZoVkTBhCJQdosI4AXXEwWd8kwuVIwA/8=;
 b=wKbTWKhmgMi9UXxBhfrGx5YWF0hFdodmwPPa+RdZP5J1dPWfooFrIEhfFlxDDemBLyM9pKV92RbNk37Yf/cUtr7C7Klwf21hMYLxm6DMTighvgZRpjEpbGRls6oSsc2xcWHZpZ46LHSgzgqiHh0AEpQwXrALq/dOeW70Duwncxg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:07 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 30/35] maple_tree: Introduce mas_prev_slot() interface
Date:   Fri, 12 May 2023 14:20:31 -0400
Message-Id: <20230512182036.359030-31-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: f59aea67-cdfd-4c90-ebb0-08db5315cb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vefVbKiND+3Atd4rc0XEpjAXGgbJ9BIxiykvzFvCOEiSIYiO1PS4IR3/eHa9WSeWPG9FnEAF3U3HpI/35IjS7DQUFDOmmXKZPQHQnLR1dIPs//Jvdu3OSL3ooeNTbAwzoPNdRai7I/rdiGokE7ostnwBJItkDME0DlV9n3+e6p2QFfN/YCWrgOFE4pKZ9AtI8RWYDakevepxLWa6s3J3tnjX0PoKiejL9DhQJrG9BqzFxmoAfvmzfFn2HAOZex1kSvNDn2JYDdBLvecp8OD/86eq2AKq9Rnxu9JOs7thbFYGNFmMA73BHBiqTsNnHC58iIFobUqs3gkHoK+88VC/vjBhlrTkV9lOQJ/xyWxoKpn0VSlkkDGI7E7W3rVtSKpBGnUlJF+FFe5aseaP5MdfGGlGnwoGev42iaZMFVKi4DPdV72Sb48UYrkxQbIpfRjC9GKWCVCNAww/DdVkfarF/WrGm9EF77s2ciIwd8zKq6L/7TGsZOGZQpdkNo0Fv0e1AdnqpWQ6z+WsU/ulaewpfwLyF239LKWBZ2dsFgwwhWzoXKzbFsXJl3bptkJikXVW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2inNoTtFt0hBm/bV/HtzONp3Mpfscgcouggp6HcOKnxd/70pIfk441hx0f9b?=
 =?us-ascii?Q?7QHbEKtFPdJE49cb2DzStYnffVcoan9Sdz/5ofwZh/kl7xJoce+6/CgJwbd2?=
 =?us-ascii?Q?Wzb1imSGY+f+qobn5ss9l/9Z553tcJwZP0o4yl3230/3m3Ov0RwpWl+BZdXB?=
 =?us-ascii?Q?RCRsRjRMqRwhGhcepVgJLOGY/+uHMuS1xV4yb/SAVry7uKSg4VHosxe1eFli?=
 =?us-ascii?Q?WupM+YBw91zjXlPl4vB0NL5Q3c5HYiS0PnYLnIhavngOf96Run7CoFAWLqOz?=
 =?us-ascii?Q?XHlxasHpPlqm2M+kZP6/zm4HYwOMUE0Ys+s1TMGvhWJwVt13gziPxnVY3n1e?=
 =?us-ascii?Q?lTp6OwRjNvoKYOga6C7ix9Ixgjja5W1ARYuu9NK+r+qytg5m+RPlBjAWhtgw?=
 =?us-ascii?Q?N9dO+6KnCvn8P9dqGRdilDVXpiOzlmHNq8hl3bj/uTlM571GKEtfBGcvobqy?=
 =?us-ascii?Q?LeITOileQOsL4TIvF33AylJADxlQXCpRiDSrTrSDhtWZVjMeLBJ5/YAdES+u?=
 =?us-ascii?Q?Iep10BuK89B/L31sy9pKdqpTR2BCsRgc2T9f3L98DqTP1zH6fI634Gu3wYMI?=
 =?us-ascii?Q?enkG96+qHBaKfEl+NF6l57Tu2Au/JOBgoJsGsY7DKOxG0LV/mS39+it8VXJD?=
 =?us-ascii?Q?hE+MPSSQUw1swtsDEHZwLwUDTFpYK/HDnXOyJ5OUjh7qNySSP1I4rfAvi/7n?=
 =?us-ascii?Q?P2MKfDCsW4KoSFCe6htt0+tZIZhIX82DaLMivv2gGeNQb/JRn2/JugBoleYv?=
 =?us-ascii?Q?JT1A3ejZWvYJ3Q2QcgTd2HwQXhaV6NgCd+j4jmz9XpMMkEhh4FHd1zp9vMEf?=
 =?us-ascii?Q?vHZAapJUfVKPR+6pb3edHTNKbnLwZXCIYn49lPpWQQmH4gGHvxdsNDRKqSJk?=
 =?us-ascii?Q?iRWftR4FkrdqbmbeDSFb4E/URU9YR5yNPxwDOrxDXQNXlNvrYohd+CiJVAHM?=
 =?us-ascii?Q?4aiKZfchV4ogy5DLlDu5TeuRaYqmQoLcjxFvDrozltzJgEMUBtiDqxSEGsbU?=
 =?us-ascii?Q?bQRaX2SVqOxFhyY2WkX5OeLMglSATcuV8ux075fYasUg0yxsAh9U6dSu8ach?=
 =?us-ascii?Q?vOai1WA3GqNpOTGikJOUcUNww25iANzSI4bgfVbUUSSjxz7tRWpDwfjnAHHp?=
 =?us-ascii?Q?CRszhhc+W2lKR/3ZlSyE6jtYgpUPhFg7fS/qtExRDfrG+ibiS7Xjte4CIFmV?=
 =?us-ascii?Q?nSO2+6UZc7PGC1mvKNotpocD5cC3jB1bG+e16HNaQAQITTmsM6INACmTXlfx?=
 =?us-ascii?Q?bc27FqrCrkz60wYxG0EaRnv0d/V4o8FrTi8PICuVHvkVOmt5kq6PcBGhSSKy?=
 =?us-ascii?Q?B1xNY1GOjVgIk1BFYSUX9+pf6FKGjvJdIN/lDy8ZPEHXFCGfkBlxjeKXTkt0?=
 =?us-ascii?Q?kzMnPB40FyPEls3jENujoKXXQgdWx02If0dSjMtYQqetw+B3e9UIpf72SO4u?=
 =?us-ascii?Q?7q08Rj620CaV4MOxvwvDXcJv9X1wTNL9cVdzBV0+MvyiIoX94+AuKCW1CrUN?=
 =?us-ascii?Q?Gxb8H5GF03rOSn9xYlGA5w9TmzTjKvsUeNo3YnSl4rc8H2i4oBYxyrajnJVf?=
 =?us-ascii?Q?ILRTBvUEHJ04dg7K6RAvKqXM2EvSi+ZB4jCHwV6Xd2f7B5PJNN8GdmaDh4Gi?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Apq7z+y6OtuIKhm6wxaoQWRwBXj4ReStswUhko7GVW+h0983R/jq1iVtUFKKlD+APFDvsnQCMoAQkeGFVqG+sd3Dm3cyHL6jY4JmpouobiDSESeIVsfH6rtaThpXYS2+6aqF/gywtZuRpMdRrcfFwc1K6xR03gJK94t4odzvjOQUznzjnsxsmWW6qJi6MgPgd2GT+cgC/63pHyvzOw64wWVM+0/kkdcyru1fUe2sTfAfeCIhgQNj1RiRcsJ1QIWp9EPdnjYU13ZlmBGfudULJ4e1UHnuQVZhyyp+ipvtffWYVGfBXAH86Q7g2k0EuSJaIxSY8JbMqPDSOppNahfaEOUy/5Azulktb7JWUHRiAJ23ZlFJSh0axBLH+AnSx4Rtt/W7xPmKg/HdvIVyGM3iGX1b8mHtsysZOQn9cfjHlDwO6uEcUs513FURfpMCUmzTWv/LtniubFQ3iFUUgFGnzjRyFAU8PNe9Q2bbYIibE076e6jioAoKH2X5PKOf5mpYCs4XF8jaRUtuw98hc6gD4bJD8q/KZWf2Kmm6NkMQoEqOOTpFl8X4w+nfkkdpaYGFLs0dse2b2lX8SejXF2xrna8CyXH9tjkZRSaZLbzh5TZT9Rlrar3nJyhnz9q21TfIfQb98Mtn4DwbCqWJK2MEPnPlmBp8x/MExV9umPYUlDqL9pgZLuhmI+C0ph9MnTxBKqc5aI75qY12Z1Y/UwfxEfS/SGoZ2wGq2v28mAfifyuVo12tilQZ/5wpysKVvoetT7O+Cz55K+uf88C/3MkKAMpNGSpkl1YpqPOZ8qGIQDuhQllq3ZpU9QwNjyuAwR51wWuEkR0Ri5aNm4zAI1nxUOu46QminKROthl32BhgvsJ9S6PrB5YLahPLHzsdamKoI/x5FZXD9LrVUyC8u4TBGw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59aea67-cdfd-4c90-ebb0-08db5315cb31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:07.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXH+R8BBZpvlWUX3bChksYNRJra/bdyrwjliu+74vCdV+sQoQD/iGG/YLwmYn1jUv9HxESomsYtTafiohifV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: Hx6wEiZWuaReDwrQEyYeIAZ1M5o69O83
X-Proofpoint-ORIG-GUID: Hx6wEiZWuaReDwrQEyYeIAZ1M5o69O83
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the user needs to revert to the previous slot, regardless of
if it is empty or not.  Add an interface to go to the previous slot.

Since there can't be two consecutive NULLs in the tree, the mas_prev()
function can be implemented by calling mas_prev_slot() a maximum of 2
times.  Change the underlying interface to use mas_prev_slot() to align
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 232 ++++++++++++++++++-----------------------------
 1 file changed, 90 insertions(+), 142 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c69418b120179..f88c60f43afc8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4531,15 +4531,19 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	int offset, level;
 	void __rcu **slots;
 	struct maple_node *node;
-	struct maple_enode *enode;
 	unsigned long *pivots;
+	unsigned long max;
 
-	if (mas_is_none(mas))
-		return 0;
+	node = mas_mn(mas);
+	if (!mas->min)
+		goto no_entry;
+
+	max = mas->min - 1;
+	if (max < min)
+		goto no_entry;
 
 	level = 0;
 	do {
-		node = mas_mn(mas);
 		if (ma_is_root(node))
 			goto no_entry;
 
@@ -4548,64 +4552,41 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 			return 1;
 		offset = mas->offset;
 		level++;
+		node = mas_mn(mas);
 	} while (!offset);
 
 	offset--;
 	mt = mte_node_type(mas->node);
-	node = mas_mn(mas);
-	slots = ma_slots(node, mt);
-	pivots = ma_pivots(node, mt);
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	mas->max = pivots[offset];
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	if (mas->max < min)
-		goto no_entry_min;
-
 	while (level > 1) {
 		level--;
-		enode = mas_slot(mas, slots, offset);
+		slots = ma_slots(node, mt);
+		mas->node = mas_slot(mas, slots, offset);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-		mas->node = enode;
 		mt = mte_node_type(mas->node);
 		node = mas_mn(mas);
-		slots = ma_slots(node, mt);
 		pivots = ma_pivots(node, mt);
-		offset = ma_data_end(node, mt, pivots, mas->max);
+		offset = ma_data_end(node, mt, pivots, max);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		if (offset)
-			mas->min = pivots[offset - 1] + 1;
-
-		if (offset < mt_pivots[mt])
-			mas->max = pivots[offset];
-
-		if (mas->max < min)
-			goto no_entry;
 	}
 
+	slots = ma_slots(node, mt);
 	mas->node = mas_slot(mas, slots, offset);
+	pivots = ma_pivots(node, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
+	if (likely(offset))
+		mas->min = pivots[offset - 1] + 1;
+	mas->max = max;
 	mas->offset = mas_data_end(mas);
 	if (unlikely(mte_dead_node(mas->node)))
 		return 1;
 
 	return 0;
 
-no_entry_min:
-	mas->offset = offset;
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
 no_entry:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
@@ -4614,6 +4595,76 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	return 0;
 }
 
+/*
+ * mas_prev_slot() - Get the entry in the previous slot
+ *
+ * @mas: The maple state
+ * @max: The minimum starting range
+ *
+ * Return: The entry in the previous slot which is possibly NULL
+ */
+void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+{
+	void *entry;
+	void __rcu **slots;
+	unsigned long pivot;
+	enum maple_type type;
+	unsigned long *pivots;
+	struct maple_node *node;
+	unsigned long save_point = mas->index;
+
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
+	pivots = ma_pivots(node, type);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+again:
+	if (mas->min <= min) {
+		pivot = mas_safe_min(mas, pivots, mas->offset);
+
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
+
+		if (pivot <= min)
+			return NULL;
+	}
+
+	if (likely(mas->offset)) {
+		mas->offset--;
+		mas->last = mas->index - 1;
+		mas->index = mas_safe_min(mas, pivots, mas->offset);
+	} else  {
+		if (mas_prev_node(mas, min)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
+			return NULL;
+
+		mas->last = mas->max;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->index = pivots[mas->offset - 1] + 1;
+	}
+
+	slots = ma_slots(node, type);
+	entry = mas_slot(mas, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+	if (likely(entry))
+		return entry;
+
+	if (!empty)
+		goto again;
+
+	return entry;
+}
+
 /*
  * mas_next_node() - Get the next node at the same level in the tree.
  * @mas: The maple state
@@ -4798,109 +4849,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	return mas_next_slot(mas, limit, false);
 }
 
-/*
- * mas_prev_nentry() - Get the previous node entry.
- * @mas: The maple state.
- * @limit: The lower limit to check for a value.
- *
- * Return: the entry, %NULL otherwise.
- */
-static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
-				    unsigned long index)
-{
-	unsigned long pivot, min;
-	unsigned char offset, count;
-	struct maple_node *mn;
-	enum maple_type mt;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry;
-
-retry:
-	if (!mas->offset)
-		return NULL;
-
-	mn = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	offset = mas->offset - 1;
-	slots = ma_slots(mn, mt);
-	pivots = ma_pivots(mn, mt);
-	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
-	if (offset >= count) {
-		pivot = mas->max;
-		offset = count;
-	} else {
-		pivot = pivots[offset];
-	}
-
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	while (offset && !mas_slot(mas, slots, offset)) {
-		pivot = pivots[--offset];
-		if (pivot >= limit)
-			break;
-	}
-
-	/*
-	 * If the slot was null but we've shifted outside the limits, then set
-	 * the range to the last NULL.
-	 */
-	if (unlikely((pivot < limit) && (offset < mas->offset)))
-		pivot = pivots[++offset];
-
-	min = mas_safe_min(mas, pivots, offset);
-	entry = mas_slot(mas, slots, offset);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	mas->offset = offset;
-	mas->last = pivot;
-	mas->index = min;
-	return entry;
-}
-
-static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
-{
-	void *entry;
-	struct maple_enode *prev_enode;
-	unsigned char prev_offset;
-
-	if (mas->index < min)
-		return NULL;
-
-retry:
-	prev_enode = mas->node;
-	prev_offset = mas->offset;
-	while (likely(!mas_is_none(mas))) {
-		entry = mas_prev_nentry(mas, min, mas->index);
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely(mas->index <= min))
-			return NULL;
-
-		if (unlikely(mas_prev_node(mas, min))) {
-			mas_rewalk(mas, mas->index);
-			goto retry;
-		}
-
-		mas->offset++;
-	}
-
-	mas->node = prev_enode;
-	mas->offset = prev_offset;
-	return NULL;
-}
-
 /*
  * mas_rev_awalk() - Internal function.  Reverse allocation walk.  Find the
  * highest gap address of a given size in a given node and descend.
@@ -6017,7 +5965,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		}
 		return NULL;
 	}
-	return mas_prev_entry(mas, min);
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
@@ -6232,8 +6180,8 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (mas->index < min)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_prev_entry */
-	return mas_prev_entry(mas, min);
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
-- 
2.39.2

