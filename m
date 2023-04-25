Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABC6EE457
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjDYO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjDYO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:58:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A849C0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:58:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDioRg017723;
        Tue, 25 Apr 2023 14:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LjlCxI1yd9tgEAjJz6ebTiSqyap04NE9PQWsvKoR4z0=;
 b=b1qW3VziproRVSYtuLkJPD9lPOc2VtYOpFFLTrwdJCcrah1V3MA9cV0bHGnzVJh/gNpj
 X4u1R0gl9Mr8C5/DI+y6W88Y7B+cnkrtfHawuiRs7GfdJcGQZl70Ki5BnJJbNaoX2SDD
 ZRfZ//4OhFNmIVAC3rbPwhi7X6/pFmu87benFPbLzHxEhtTrZOqmbftUPb0aVyYrOwX0
 YigdmiKw2rEU24QMbKuNFjg1hFjao3lImWbZW6e26yEyNXHAlDcgAXDFfXF+8rXP1BXZ
 iu3wUpZKUAVzFoDXrVIhzCv0LuonjWiYUFR2BzNMtvRm64Yc1G2ZjSsOr9CDBYFV8pFh xQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fandvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDBwKs006648;
        Tue, 25 Apr 2023 14:11:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gsa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCmKuo7GeWUyGUKVfdzejin/Mn7qdXxMgUm9/gW3Qysj3QkKbz81aY/K6iwHROqi3+97idEdvNI1gGBY0+sxhIRdAZbz241rZU8x/wtIwU/3T3WnfYbKasVjOAXx+lDdJuWJyuq/6n9cWXGIwTGVISUZ8kbRohCHTR8iutgU6yTdEBfCzChBXlJXrqxsmeY7LQQsASyLdWDtmpKzl6MQJ/ePaWaTBQYQAQpEI6H3YBAv0OTvxzg0iVY2iuZEDB6XcCuQn5Q8HPsN2xQUa2LvNc75ASxG2ldOM+nKrLa7Wt6jT8MTf9dfVgIW8X4tNkW2X8xZXOC7Qi/md1+J6YWnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjlCxI1yd9tgEAjJz6ebTiSqyap04NE9PQWsvKoR4z0=;
 b=bB81MCQHPrvijuXk5I5efJXday7zaD1ze1jmZiIw57FjjVL2v2gHZN1XVTnkxJjQzsp/FoyHOTTDqyuIufrwl3BwmwxREodsqZ3jN1+Iij3AqFtOcuRD7dZU0FR4hdVoL/WYbLYNwMG7Jpi/WhR17czupt7pjQ71gYUzR08QOIwJAQeX1l8rhgJAAFpBlpK7p+Pxip8S3EUbPFRwZu7Yo/JIHnhWrG65rS2+p1F8mwQn16KLkti/q3wTSrj2MHAyY9koC/teve74tFEUu4NRZfgS4ivCWAC5vrThSuBAR5cTmOL9sqmzUfHjjXhvwVtbFCNsP8hdzuE75l9qUpOiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjlCxI1yd9tgEAjJz6ebTiSqyap04NE9PQWsvKoR4z0=;
 b=u9HsLFcq1q1FYTdEYanDrwSbjWlqc1HcwvfNazJ5NJzB4mhYJ1UDYFId6cTxTCrKDuWvFy6d8lX2U1Ed1kdO9RylCusnsA1e+UusoIRLUBIi7Pn1OXrlr1a3m7ntFqQuHCGNJ7o03mG3jROBsze1htAnMLDzWvNrr4bS6k2oDzk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 24/34] maple_tree: Try harder to keep active node with mas_prev()
Date:   Tue, 25 Apr 2023 10:09:45 -0400
Message-Id: <20230425140955.3834476-25-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f8dd6e-ad7b-40dc-c5e3-08db4596efdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jlu6NBvkI917q7OAKglGkRB/IOpeI7HNj9I/F2rwYgyRLdFG/XQDpKANMNrSIIpdjUvoEI2wVL+qKPy4P7SSP6Add4pMsIHKaKbkLlFa2Z8fcZCMxtafg5rKKynMv1/0OsceUYQXEFdaSo35xZMmfxbZQfbdzpXTgTGYTXheqhEWv+/bjjxio+MiWgww/GAmaajgPRgvTUoRxyixYcevlZCKO25u7EP98jfYK3xD23mFZgo2IcDNOY8WEQbEkYFsFTSHTds3XziaR6GfqpIrTt1tqglAxVGn2urkwA8HUX8fDEmXT5uaO+hRGTZbwYbrLkvo8Kydn2jw3f7uzIPANymJ1R1lF/7IgVYap1zN45xw9rAKCTSa9P62FJp0Cs+ZlYNRg80h2zYf95K1iVZS5fT4UaJa4kTAxt2IlKrVrD+t5kuKy1pK3wuWJyDBRTHGUWjrBbOedjZqPQ3DI8EKsu3DWK7YHoTy/T9HPN8WpGg2jKa/ap8BD+wmRyzcgmmIOCrClHov3swU6/IhMS7Dg3Z6Vmz06/9V889nyb8vob5v4gxJNxo1GtZllqy490bm3wkFiitIhFanZuznj09kYSMFfDjg8m9gQ1QAk8U7JcNGXLaaQB7YgEjMo5Q+g1B0Y7lKIQDSnHAAc18GMKF1cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005)(34023003)(148693002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kDY+B1M1yhelL/UXyb/5xBKfmDRw5Pn0dw5bQKWAoUHS4RHK1R1JYAPMzC1?=
 =?us-ascii?Q?brxnoUxZM9eXfNXBPPn7rYVmPrj7qVrt65GXtMYIJdWteR+kvqkMfbZDYa7h?=
 =?us-ascii?Q?6kFtbIOVBiulWs1WP16AtzCvuCSEgBct739mCr5RvIpMVcnn4NyO0Kn0tVxQ?=
 =?us-ascii?Q?CtZ6ALeFHJGdtRsWR9SlHgYP3muf/QLTBK9OXCBIoxdSxlBZix9CPLw1W3RB?=
 =?us-ascii?Q?CbgXLoVukyOd1glS7bbFTRDk4qlcWfdOTihYj5wEw8WjnCO3uhb/9XkXkhZz?=
 =?us-ascii?Q?ysBf0MswO/uqtOyrPpuvMDgbxTwuPd/+U/CF2HLCJC9D+hnu9ElctGMX7nGn?=
 =?us-ascii?Q?EldVsKJglawrya9RfQImK3RssDLRtZojVTdzrcgeycAbPXNaT2oy7/Xo8l0H?=
 =?us-ascii?Q?tDhIn3EtdzZk0p7cx2wKUFuCkONYpN6ssj+NmdQ0Q8szjoF60xRK5Dl0nqR3?=
 =?us-ascii?Q?Wv2BNaDGkn1OlSiibwFJzc5pS+nOjMlRJiRcmUe5YNIulNk5z9/a2ei+gDxN?=
 =?us-ascii?Q?CoZub/aZpAFRErBbfYyib/p2HJG3setIcOhASllIcQL589ASXxIFtoz0LrQC?=
 =?us-ascii?Q?aY9n/k5stWHz6ApevEV/Ln4pKsa5elT9wmld0rXsfW9ULI4zMyqhIHgG7c8r?=
 =?us-ascii?Q?N7Ex66o/S0OVbaFQOZhgF6ZWCAz7jdtOpvkGdNdloq1olkY3Eac9ZlEYwHcX?=
 =?us-ascii?Q?fnqDSJsLTSnJgsK6C43zM3dV0d5CQwIJQ4VmBjsNWZadInZNqs5x3txRbDX4?=
 =?us-ascii?Q?jUunwalzPRWSy8FMe0STnn4Mw60kx9zeTUOTEgMzATylcGQxP6cOOhwa0UEz?=
 =?us-ascii?Q?qDxZT556yafKN3i3cJFP7RMboZtP0oxixVSxyenB5Trakr3t562X5aSwKWIw?=
 =?us-ascii?Q?NbLbQTLZ8UDjCtT+EIeFnoSWM5cLb0R+v5edIv/6FUzzbZIlKJZVybGuC+DR?=
 =?us-ascii?Q?g7hiqYUd4vF/xEoTQCjCtqA/QkwmJAQtr++PuxEgrFHCqcQCrekT+Gt20Nqj?=
 =?us-ascii?Q?Vz7pmWEp5+9k5puV54Tk4oQ4wbtJAcBkari8E11QFKbULOzK37OpY3syfpSG?=
 =?us-ascii?Q?bb4l3vV92Z+gmfNVbCPHdKu1/VIbeIxxCUWL7n+hDSrOdvJLl5jinO8hBIEn?=
 =?us-ascii?Q?JG19v5pAmApt98qeQ4tivDvhWYfQkbKVFauuG+SJfeqw1+BkP/s/sPcjEWQL?=
 =?us-ascii?Q?zNlfv+cDOpFIbCpaDFEn+jM+4CR4CiYNlNVG2XeM9LTGIoqo94PZsG5YYf7G?=
 =?us-ascii?Q?SzrJI3tRCO4m3KMBy8F8xuY3GkV9iIukCeKOcM6x2ifyzMgaWpZKMsOsQbYn?=
 =?us-ascii?Q?SPoNzvyM8Kn2MlfBrPQ+a/9x00Z/8HCP+I5zYirqDMJeVyR3do+0mDVSngXs?=
 =?us-ascii?Q?joUoIA8rlHOToEBoNyqRnWT2fKt1CVfwG97TAc+z/aSrgXmFwOgUBoRcOz94?=
 =?us-ascii?Q?AtL4l0uuN8LKPHrUFIVLK1DZxtdjqe3GI16BGoSKOp8AtkLGdRpy08aeAvHl?=
 =?us-ascii?Q?EkyK8AuFNzNduV6AWXifHrjBhMzrSck67UUSgWi/NmooPXM1+6ufBqGdpFil?=
 =?us-ascii?Q?V5F4/Ym7XCw10xq7jIr8dThZKUWrHUJCgxIBHVkMfX9UWiQpVBhoJhHZUiqp?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OtH3qyJNK5w6N/V9pbzP3H9Wr8DaiadfVB+bJEz+IpgGlkNTh0qVgULXt+ORS2nOXE7c2rqeAJSuGjPhv5wHzM1JpR70UPttk843i4+3RGfJvBEiFGmCbOd8v3dgYNvhdBMDCuQrrauEuHhN1w9xQRZrF9WWzqjcy2B6Agk7HWuUxrs7LB5wE0UhRv8vfpyEpMZzHHAMC46XLk9IVg47ifbCaIJwFOX02AtMedxG/djXHIVRk+Tede21MxRdTSGouiHV8PRTlAI/5DtAdkandMKJ5dVjEZZf5u69+M+c5KrcdKD0ymjc8sWjKWuGIHFlvX+mlVuru9m9cTvZ42jNFjXErdxGlkRELcIG/b0yuvUDfZhDOqW1Wv+XeLmywLMun08CnmtZA6oK7KWen/Ty86qPjTt3BjErVAHtHxmpbe+z051SLMnPpj+bvZHaXleqTiGgOBqR0elp41G8mRQG2/JH784Uf5I1KT1Bd0xVMHAxhJea1kyyMRry+BLnOM1SIbHlCaPbkfJhFFmzLPHkcTqbcZ1A1qIJYK30lrYqelplnIBALozRE6jxwOYrv82bKEwUhj9dGMyiCEdsIU10k+pI+rb71+jR/JNNj6tOkgqS0Ii/Eqd4N9H4aXHbwLLWhZl6wbRA8tBAIY8NfHYr4PACV/VJgsV4olhUGCF9SaaAfrbaJSEzOyJ/oz1ZG7mR5SpuZ41/rcLA1C/IfFq0Rr+SEZJBQrqmUbAKUqoCWFz7z3NMDNtsN2z1g3528yY52F8XBw4edyccqFXmD3YLk7W+w/pmhDAk03KsDdgC9eIxSasfGOo+Db+NGsM0c2XE/YpQ73Flj2hhN822kcs7BMkYMy5Y+ARa5lncrSYydcoWK9gnGdmUv1L58XX2DdTtd5RCuNiAHxSx9yxuDMfW/g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f8dd6e-ad7b-40dc-c5e3-08db4596efdd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:17.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6gb4qHGiIDF8j+QwmNBBQSS2x74LLYvJbJA9WafTILvyxSueuhlWAW9h+uO2dwVvOiyvMB3RWzRrnex9p2MLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: SgGJfYOnvijv_m_87PRucyzLAeumF0po
X-Proofpoint-GUID: SgGJfYOnvijv_m_87PRucyzLAeumF0po
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a reference to the node when possible with mas_prev().  This will
avoid re-walking the tree.  In keeping a reference to the node, keep the
last/index accurate to the range being referenced.  This means the limit
may be within the range, but the range may extend outside of the limit.

Also fix the single entry tree to respect the range (of 0), or set the
node to MAS_NONE in the case of shifting beyond 0.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 125 +++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 42 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ef7a6ceca864c..20f0a10dc5608 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4828,7 +4828,7 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 				    unsigned long index)
 {
 	unsigned long pivot, min;
-	unsigned char offset;
+	unsigned char offset, count;
 	struct maple_node *mn;
 	enum maple_type mt;
 	unsigned long *pivots;
@@ -4842,29 +4842,42 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 	mn = mas_mn(mas);
 	mt = mte_node_type(mas->node);
 	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
 	slots = ma_slots(mn, mt);
 	pivots = ma_pivots(mn, mt);
+	count = ma_data_end(mn, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	if (offset == mt_pivots[mt])
+	offset = mas->offset - 1;
+	if (offset >= mt_slots[mt])
+		offset = mt_slots[mt] - 1;
+
+	if (offset >= count) {
 		pivot = mas->max;
-	else
+		offset = count;
+	} else {
 		pivot = pivots[offset];
+	}
 
 	if (unlikely(ma_dead_node(mn))) {
 		mas_rewalk(mas, index);
 		goto retry;
 	}
 
-	while (offset && ((!mas_slot(mas, slots, offset) && pivot >= limit) ||
-	       !pivot))
+	while (offset && !mas_slot(mas, slots, offset)) {
 		pivot = pivots[--offset];
+		if (pivot >= limit)
+			break;
+	}
+
+	/*
+	 * If the slot was null but we've shifted outside the limits, then set
+	 * the range to the last NULL.
+	 */
+	if (unlikely((pivot < limit) && (offset < mas->offset)))
+		pivot = pivots[++offset];
 
 	min = mas_safe_min(mas, pivots, offset);
 	entry = mas_slot(mas, slots, offset);
@@ -4873,32 +4886,33 @@ static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
 		goto retry;
 	}
 
-	if (likely(entry)) {
-		mas->offset = offset;
-		mas->last = pivot;
-		mas->index = min;
-	}
+	mas->offset = offset;
+	mas->last = pivot;
+	mas->index = min;
 	return entry;
 }
 
 static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 {
 	void *entry;
+	struct maple_enode *prev_enode;
+	unsigned char prev_offset;
 
-	if (mas->index < min) {
-		mas->index = mas->last = min;
-		mas->node = MAS_NONE;
+	if (mas->index < min)
 		return NULL;
-	}
+
 retry:
+	prev_enode = mas->node;
+	prev_offset = mas->offset;
 	while (likely(!mas_is_none(mas))) {
 		entry = mas_prev_nentry(mas, min, mas->index);
-		if (unlikely(mas->last < min))
-			goto not_found;
 
 		if (likely(entry))
 			return entry;
 
+		if (unlikely(mas->index <= min))
+			return NULL;
+
 		if (unlikely(mas_prev_node(mas, min))) {
 			mas_rewalk(mas, mas->index);
 			goto retry;
@@ -4907,9 +4921,8 @@ static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
 		mas->offset++;
 	}
 
-	mas->offset--;
-not_found:
-	mas->index = mas->last = min;
+	mas->node = prev_enode;
+	mas->offset = prev_offset;
 	return NULL;
 }
 
@@ -5958,15 +5971,8 @@ EXPORT_SYMBOL_GPL(mt_next);
  */
 void *mas_prev(struct ma_state *mas, unsigned long min)
 {
-	if (!mas->index) {
-		/* Nothing comes before 0 */
-		mas->last = 0;
-		mas->node = MAS_NONE;
-		return NULL;
-	}
-
-	if (unlikely(mas_is_ptr(mas)))
-		return NULL;
+	if (mas->index <= min)
+		goto none;
 
 	if (mas_is_none(mas) || mas_is_paused(mas))
 		mas->node = MAS_START;
@@ -5974,19 +5980,30 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_is_start(mas)) {
 		mas_walk(mas);
 		if (!mas->index)
-			return NULL;
+			goto none;
 	}
 
-	if (mas_is_ptr(mas)) {
-		if (!mas->index) {
-			mas->last = 0;
-			return NULL;
-		}
-
+	if (unlikely(mas_is_ptr(mas))) {
+		if (!mas->index)
+			goto none;
 		mas->index = mas->last = 0;
-		return mas_root_locked(mas);
+		return mas_root(mas);
+	}
+
+	if (mas_is_none(mas)) {
+		if (mas->index) {
+			/* Walked to out-of-range pointer? */
+			mas->index = mas->last = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+		return NULL;
 	}
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -6112,8 +6129,16 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
+	if (unlikely(mas_is_none(mas))) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	}
+
 	if (unlikely(mas_is_paused(mas))) {
-		if (unlikely(mas->last == ULONG_MAX)) {
+		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return NULL;
 		}
@@ -6133,14 +6158,30 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			return entry;
 	}
 
-	if (unlikely(!mas_searchable(mas)))
-		return NULL;
+	if (unlikely(!mas_searchable(mas))) {
+		if (mas_is_ptr(mas))
+			goto none;
+
+		if (mas_is_none(mas)) {
+			/*
+			 * Walked to the location, and there was nothing so the
+			 * previous location is 0.
+			 */
+			mas->last = mas->index = 0;
+			mas->node = MAS_ROOT;
+			return mas_root(mas);
+		}
+	}
 
 	if (mas->index < min)
 		return NULL;
 
 	/* Retries on dead nodes handled by mas_prev_entry */
 	return mas_prev_entry(mas, min);
+
+none:
+	mas->node = MAS_NONE;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
-- 
2.39.2

