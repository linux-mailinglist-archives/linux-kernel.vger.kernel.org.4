Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AE5B9079
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiINWTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiINWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9779EFD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMAARp026129;
        Wed, 14 Sep 2022 22:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=c5CV29ucnX6P7BSExad26jDY9ce0i4MfDdk5OL0pR+4=;
 b=y1yf3FkwprIzarb0yhWit8irhp79vPw/iGZt6ErczAtgkGwAgDa1vrqd3XrSEmjEcBW/
 4yIblnZrWg5Lq84vOGDU14STENVGKL9LjIeLF1/WNVPn5/BRaFcxi2NsMwLQpRwsAeGp
 I8raYYun2NMuCg7FW0NPbh9HjXAAN6MilCM/MVnJNt5N2XM3ZWH2/SOUS36gtBH+0LKu
 ItjlYD6CGEVLNQu3LKtS22noxXpzThpgnStXCEZbxywqLBDA40BkCQHAAN3drxgtOwCB
 6OvRRaYVruovpemTn26o6hQtEn6MhwRJXkO6rYGiUeWQLl/mb4P/UzAtB0bBsivIDbkp KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypbqr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EM1D1C035494;
        Wed, 14 Sep 2022 22:18:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyehtdu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWLjzSJ8uiB6pDYXfUXVDz0jnU6pTCV7K1boAA0r3jgVaeI9cyc4mN4HxHDyORQtbVWPWfRr+iJkGBEXfNoHTO87ZVwB864UKYpCLa27HeBqxuih5/Rll2LDnADEiBr52ltl2shceyKAKDFjoSbPitChxq0E5Apbq7AMHW/d4dzN3RortlAWOHvUyRNbEvd+53q+bquxmDnfdORMaO4K2IlJwT1AflczgkFfY+z44j8b2SpNTnNDG8Zgeh+/IZYmJ04QAzok1lyDI4/eqEg97K3g2WshdDgox1af5iK5Q4xPlC/aNSqm4NItJsrurAsvS+dAkcYTZ2SqF+/meAGkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5CV29ucnX6P7BSExad26jDY9ce0i4MfDdk5OL0pR+4=;
 b=Mbn2pD9dj2yCro6F40fT/OyN/1IRkITaPnhMe+9jkQ9pStxnyeETPSTWlQ/sShTURG3tbP6ep8hPWfHgoW4JWHlBeSpUiNUe3v3+bDfvD2ofmDsjZ85CrFh0qKhkWPSufXS3YdbxLX7zBGyLD6rX/P2aYeiRkE48rPhXVX0kRjuyJtJJCG7Zk5WeXt2mPMZqHmnTOB+oU5rB1QeaAwnKgVKUfH0KVsMDGdMf6bYvEpBVDpJiFhMKiD1Wu81KTotXHwsH1HtAPQK6fSYQgMabadKma6wnauUDAT4aTHGScM69P4/D9mvhlfAHbYURw+UpcQPA91Qu6/KutLo8QZoIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5CV29ucnX6P7BSExad26jDY9ce0i4MfDdk5OL0pR+4=;
 b=Vv2V0Ecj4I6Qej1KdNudLjrEYJLEzuA668EHVocTAqkErBwIqo2Byp1rTdZ8up0zfIBoSH0/14xBdwMPaK5FVWS9/s+xXr7nj2aQm1txI7x/2GsiAWg+n/SVrJSPN5xPWPj9REMdcY+wrJ4nEm+xs4CqcU1l2Py5Xw4lKvJIlXM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 22:18:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:30 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 5/9] hugetlb: rename vma_shareable() and refactor code
Date:   Wed, 14 Sep 2022 15:18:06 -0700
Message-Id: <20220914221810.95771-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa0f240-db29-43b2-05a6-08da969f0de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AvGPbLdzoFj1uc71qBP6dbl3v7Xm7E/DJ4ArChkH7V0w7TZaTRWX6BAgHsG/d1AT4ynDjw8F+f4oAgfAyUz77XZt//8LolIAyajtwjj6L5D5fO7htRoBQlGF0j9+yxUpbHfnrp8Fl2Sm6gMa951koqPZedKdNRna7+BBl4ui/1mv5ER89P1Ij+y1/LqtAB3b1HT8zPdLHLDgXsRYt9Learp6H7ila3ps6Qkukxi6mT89lj8fb3xAttE8ycX1t/1geNtznXS6C4Sh1UT2v1DfTwj91do3wWGW8qN8/vL37QKa7xWPBksK3DHhMTsLVHgMMpB+1W55XHEeMqo0gZSFXU8uqzCVvraLmAfYgnLY68TBGUcVo+0OP1TVKjuy1WrGeECc7iZ9CedNpgbgtoF78MeFWGaKtZLd1TwJ9otj3pJFtUyjJJqIUBszdIyrcOWyIHLk/ZcjZPiSOTAuIFWDbDAMjhuo6NUp+78yBOT5m7HVB2ksbdk0wHY9OvQk2pI9NQYM5XgwDv5oo03XYs2wRiQ8hMD24mBLZrn/C2IQ1U01KJEOQoWK3a+8p1looTjPXGyht+Dj2ofoDGwt1R2HnwJyImc9lOBr6+DrPvJ+0ODpJqQHRUOUEnFNg5yFXY2t5HsHGBU+4hfnYbdTfi8F87RfvNVh2dsVn2S53yBCbJGnYim1vXVc5jeQg64nxENX3Et1oEVWM5LXJJbtmfCRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(38100700002)(54906003)(316002)(36756003)(6506007)(8676002)(4326008)(66946007)(83380400001)(186003)(2616005)(1076003)(5660300002)(41300700001)(107886003)(66476007)(66556008)(86362001)(8936002)(6666004)(6486002)(7416002)(2906002)(26005)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABmSBjnD+dy0WguvxoTWhK5crCfRpyyyiOVa6aXEU0Oj4AEE3UYBvgBEB0uq?=
 =?us-ascii?Q?6NNXSl71/WHrg62H2CABw5cbw9Kf/cyScFOUy9Q+ym+Qrj3G9Bze/aVj1d7P?=
 =?us-ascii?Q?0gr4AlgbJRRbekjSZUFFUGiOZO8wWZ3BXgb8eP8155kLPF/NmEd0MQaUYOH4?=
 =?us-ascii?Q?Jv1pq07UB0T5dl93ojpIYtc663NaKLyzIsZYL51mNPoLpQNmTo19x1Le6wqm?=
 =?us-ascii?Q?cqxyhtRGeSmdXiM5XGhL0gHbgHOGdxDy31d3Lr7PpT1V4Avf/Pq7S2hGrvPn?=
 =?us-ascii?Q?x3ao39o7QrIpXczlKCkTZ3U6+O+VAvhXTl1DT2qR7PsRwf1IQ0Pi1nMhPC+3?=
 =?us-ascii?Q?cEq0A010uZ6Rtm+ofShsplSn6peLCZvpMLinOPoF16RlVZKtwfYGTR/XlddQ?=
 =?us-ascii?Q?7hGxwlURs37ZuQuVfTL/Zq8kQmfmnXNOSpLsR3QrYxihZQ/vBhnlDuMxBfyH?=
 =?us-ascii?Q?eGscSzXKG9RWUxPnv2XjAfGSrLCQBtOGPaR6o+RRbYRP6SA1yJVEYeOHjgDV?=
 =?us-ascii?Q?CoJxRAS7B2CD7Kp6xYon2ud5MJ9tzhP2zh/AEe4Q5hgZFo6/niglhk3T5ASh?=
 =?us-ascii?Q?pXDnHmvIKe6Gn+JxjpEDoyWdIw2wwIgsgMz2O7JaPhskivYHydXrbWDkghxV?=
 =?us-ascii?Q?9+V9ffVtmtYY/PUExaZr47rchT3PlWKJKw6OgDcBxPPaTXmju9XPtnEgF0C9?=
 =?us-ascii?Q?/IRcbcZLIbTxA+2hkj4RJaCDpJhwGgf29PAOEJ+J4TGRMbXQZ5eo4HBawPqa?=
 =?us-ascii?Q?VK7kQFHUViiul7qcBF0MX/y3WgQmA7I54OMzyf6B1OXEkLp7bB2/tHxGcpnT?=
 =?us-ascii?Q?BcDOZC87Lt4IJLG/CL7nlhVCSkjI/KNNwz0/bGW+JT9dPDWnoNbxo+TXoxd1?=
 =?us-ascii?Q?SXk48a3yUsbuuY5UDOZj3jBQnANze081dAxEv+VPGyfqf4rpEmbCIqyoVe0E?=
 =?us-ascii?Q?ONRY0V3iGGGjz2QJDGae9s75q9yyKQTVr4wZFT39Fob/Bj4H8YkuujnK4nyQ?=
 =?us-ascii?Q?0cTU+82AAYMC9Pn1ZAMjE0kXBzriSSuWlvvGVOilAPW3PIhdEk+j7sG/hgaI?=
 =?us-ascii?Q?rehq5wh9noHxkypP9q436zRaHOgzljvOucm7DiamMnkvc5rfLWegKSINPWqS?=
 =?us-ascii?Q?pnHwzoudoiUHi76YG392z8aL8GV6zh3bN/go6L5NUyAuGl5wcGvQfN1/1+dW?=
 =?us-ascii?Q?iHCa/W+/QBcc7W/p0AOexCUTR/VS9kc+p28VniT7zqdmdTM2ReJ4ohEjr0qY?=
 =?us-ascii?Q?fZXul8haQzpyuJLX/UhRgEI1i7sx2iN0r+RNBQFQfkuH1qa3uKAON3+pIrQO?=
 =?us-ascii?Q?OrPPD83Q1N6BcgFFD1HPwKjuEjFA/FtLTmTuZ4VL376UIQiUXIgY6674E6gR?=
 =?us-ascii?Q?LA/mmbN1kbjCocCYA9/RhRjHSxdVNTgQOGPyXvZn93Y5AQaiCozKdVLGRboS?=
 =?us-ascii?Q?G+YRSKiZm71PYM+m0uctzsqngkxrVTmyRthZ+klXzyrId22p59JhmbWs+nSJ?=
 =?us-ascii?Q?Qk5gx2/1IIrk7kL42bUBcVEYQe4fHhF8zOOVyh7ahlXlvxTdg2OpvbKYINKR?=
 =?us-ascii?Q?Lr05UPa+QzumGzSjsB78ukB1rdozpNtwBpYxffpuDqkwhGcZeuMym3kGAWV1?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa0f240-db29-43b2-05a6-08da969f0de6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:30.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPk2CMG5DbWfOS5iILOJobbNQZ/ch/MWrRxmfleo2S6V3PohxLgn4ELZiabsQ5LFwJwGeORbwhyJ04TMCTEa8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: P8wqMPzQxSCpFJXxg0I-dCr1o4h08_Tf
X-Proofpoint-GUID: P8wqMPzQxSCpFJXxg0I-dCr1o4h08_Tf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the routine vma_shareable to vma_addr_pmd_shareable as it is
checking a specific address within the vma.  Refactor code to check if
an aligned range is shareable as this will be needed in a subsequent
patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eb38ae3e7a83..8117bc299c46 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6639,26 +6639,33 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
 {
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
 		return true;
 	return false;
 }
 
+static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
+						unsigned long addr)
+{
+	unsigned long start = addr & PUD_MASK;
+	unsigned long end = start + PUD_SIZE;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end);
+}
+
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
 #endif
-	return vma_shareable(vma, addr);
+	return vma_addr_pmd_shareable(vma, addr);
 }
 
 /*
-- 
2.37.2

