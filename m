Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502476684EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjALVDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbjALVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:02:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDC45651
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:46:39 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJuNAZ006047;
        Thu, 12 Jan 2023 20:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2lZcX7VrbQTi1+7mVOVczMeZDYnWD5m9QVBm9IatMv0=;
 b=mjWcQvaAIZbg33ZgLysJKp99qQywSZXJ3sQdBWR6c67Y3w1FdabqHBZCuK+w5UKk12+j
 +8CrO09stYoFihwEKVzGocrGyYEq8oUqpkWouegcDaW4V+qybfyqpFeqUkvao89470Ul
 qgKYrtRtVRu5w2On99IHXkcvz/tnyLMxCb7WjmG/05vW0QRfXJr3ZYUNKtaJR7LEbefX
 PcyZTiUfGEvKNlJvNVMzHzDMdFGkw3uzn7x/njFilgB1OIFUfUyIGpw64YT9DZLGrv5K
 F1zVu+rMZEo3g81LCeLNPmGPeu+GvDmCYXxJtVFevTVkgasI6Uji2kAzg1SeD4XcSyY9 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0btud0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CK1TT0034162;
        Thu, 12 Jan 2023 20:46:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4h0wcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 20:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDuHZPpjvfXZljw8Ku/kMNAAK4Ed3+Y/M0R2yt2fNApqIRzhMbfUgl5ijKnRzowN/ANTQf6WRol5ojeisWwV70shUo1NVjmJqEddREoisWKSGshhYklJOsBauXb8Y1F00Xo0s+Ia3j9/Xhbcf07YbCtxVk+wnZF/rdYwEbDnXA+t4QpKnlm5eyAgV8phxf23FFfOLEcZZEFl20Y9KPiUekJDEW7JplaXUsVgYEFDRjamkdegq7K4DV0cAA5eHAHOqG2fZq0TqlHiXbOpQcchHbbTAvJJLIYcYpjY26mQtiEbScGXFHL0CzD+KUZ6F/XXJru278Ktcjs+z81WBNwMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lZcX7VrbQTi1+7mVOVczMeZDYnWD5m9QVBm9IatMv0=;
 b=eAr/ANfKk2OznBhysKBie3i2eBA1QpPGC0RjoihcUVounNo+40T78txbt6o3rLntuU3I5z+yw2IQnJ1J0sx4+OLkykv8xmx1AJcStNFVozOQtksfQtOqeu/9S2EY0KGfsiv3OzgJqy8xjcm5fC7ZPM99mr/23BeALoGHF5X283+DXUFEGN8rOu7KKM9CwPM1ez5j8kG6d8GoEZJEYCkF6TR+cSG51ejxfcJpiGiDJ1sOJj524mMic2/h1Ek57u4pRCFr3AmmDWXzMzF8v+2/O3Uk9lzPlvuQIYDMjARA0FB5AXNhUo3H0IJmhMVt5S4iN+IO4f0EwuKnfi2KRkLthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lZcX7VrbQTi1+7mVOVczMeZDYnWD5m9QVBm9IatMv0=;
 b=hLvw8vyBn0tqe2SXQAPeUpf4iuDjOXxRMUcS5aYkuy9yF+UyMgRkPk8xGFpdqVGSJ1POe0YLILvmNUyBXZZ94RDX9s2wmviVszzNJFwf25IRei+ovDwrvoz7KpV/Rwxn/79DnmxnuDcQ8EEoD/skRdDmU++TnLoiTDtx0I8KErY=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6804.namprd10.prod.outlook.com (2603:10b6:930:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Thu, 12 Jan
 2023 20:46:19 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 12 Jan 2023
 20:46:19 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 2/8] mm/memory-failure: convert try_memory_failure_hugetlb() to folios
Date:   Thu, 12 Jan 2023 14:46:02 -0600
Message-Id: <20230112204608.80136-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddfb8c1-2c13-47e1-8e62-08daf4de0e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBb5htytBcNDKQVVIOoJoCRbMuCgsvf3jJJj7YCCClAUPRozCgdgoCJR9izN1dlYEWq2MuT94ihvRdO9SLoT5A5eHoC/UHXPnS3i8eydRZ33N+XossSEv5M1IMJ6azsybywNvaPEmhzHwdpb9RyoaSICBZ6sZaRNJY2qtj1JHA+3Ucexwu/jdu0bPtdcIx1jcb0C+6stO7la320iBTA/Wm9wnmsR5MY8o7MSpXGEfaTcSokRay7N5gFx45RCKI1El8Z0vz6EYZ0/mxvuUc5s1W3kurVVCe5VbfnMo3pDAewd29Vh3qP/LcA/8/qwza70z8uoLSROZtPh4qGtZtwqUi4bpQoNFAS+4Y0BOBiS4txApNUW+gBmAILvwwq9YdgwjSruEfvQ9mydXRqzlf/GdJEFeuBl6fo+9760xm/maMFPAp7hBNlV0J+Wp/aPVsuViex0cHT2JMdKWp2lVH8sb1JwaQsiyAGorwbOcza227czEa/8JAM4qze5nA/GVMWPZNqnhrU5TGPpgIJJM6o7z0UmsiMdfxFcgy2zucp2BXT5KqajgI2WCDGQ3OTnmL960qTeEBCTF547nau5dbKmjitvwiBTP/f07nsSrYeUepXxiDN0lXCQBUW73/w8T9eO9jKoauQpPSK5VA7bY04lmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199015)(44832011)(186003)(2616005)(6512007)(478600001)(316002)(5660300002)(107886003)(6486002)(1076003)(66946007)(8676002)(66476007)(66556008)(4326008)(83380400001)(8936002)(86362001)(41300700001)(36756003)(38100700002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbZl9pvNcv1gDF0a8YzTTFH2NxboImcrg4WDzUOwNAi+bR81iuxzFhn9MIml?=
 =?us-ascii?Q?Q7EYTbJejEK37nkBkIL2HhAMkhYnbUxmOx6IFHvH/6Q6Uih8t66PSCPYFLLt?=
 =?us-ascii?Q?6T6dECMpp8AsPsdSx3gnFdyWQMZcGuNA2zDKGRFAD788/iXc/YfcAO+0Fm/A?=
 =?us-ascii?Q?JXNAI+x2b0/vhxojUheTooQmTIAdDurdD+I5p8DY4Ss4j7wpt5EKZ1ne9xi8?=
 =?us-ascii?Q?z0nG0jYCVoPiwrRdkYud0/0xHhC92G1+YQu9ZObbM+Y7zut4zjikmAY1UGPr?=
 =?us-ascii?Q?+TWY2xMYlKWoXK3JfwQ3K9aIZhjteYALDOlqCVRdlbFiMG43Er2T3mo2+upr?=
 =?us-ascii?Q?TZ2VQ4kOX6Sm9piIeg6o6vZaXdr9/wa8Xk/4TJMcHKUBavA0EgPqRauVKZFY?=
 =?us-ascii?Q?rLgy8ehCjGovJqUenzgMQ5sSpk1L1sCvJpkTyoIba+vp37S42B8zdnzpL0ND?=
 =?us-ascii?Q?LadGb2ERpJFFeBDoJczI/qEs16iYSFHsBKachPMFwq0xg6f4Rd7DnLJem+Mr?=
 =?us-ascii?Q?KIo4HkkyBUSS8SPlTfpmv+ygCehBUv9A6jz0sJGtOb++V0qbivHhse84qxn1?=
 =?us-ascii?Q?Xr8oxiQ9H6/y9rGraW5Q9UR48p9iu7wPzCs4asCLkQ8O/PbwIyY2XJdLazlF?=
 =?us-ascii?Q?iOSgYAjsq8HczKo+AO7mfPJmCWvTrC57eSPGSBa0+IPDQMnqpki7NnRZvchl?=
 =?us-ascii?Q?3Mvf/CVgz098prFFU/vXhle7iTTT+mBdlcHsB8yPZ4N8/w2eBeoAvcJg2uqh?=
 =?us-ascii?Q?i3/SrkbBFze41ZRcRqII2TY3Xss3AVxPyYs1ZKsK89y8os7ePQu+KH1JfIv8?=
 =?us-ascii?Q?d3YxvZvQVGt7zTozd0OwO8Nwy54W9hdEKCt6H0Q8XqV09laCl+Wm/5V96ey1?=
 =?us-ascii?Q?WwbqSh9R2fBNZ/wmrqDg4eVk1FVi5etHIhsAyMhHXUBdyD72CIfCcO23QXIR?=
 =?us-ascii?Q?COU063QaMkO9TJNXFt+bI1zwV237rMHGlRKZOVSkjS3LNI43cdfhtgsIu7MY?=
 =?us-ascii?Q?iPY4Cwhx5miu9adzbKEy4FD9PmLOKc8rHAgc1r5QuPLoG2nscoYHbV2s9YDI?=
 =?us-ascii?Q?hO24OqaYu9FCX/AVE5g3L7CTa8D6IH1LA2RMdFakSvMTyhuWKRG1AMOaz3eQ?=
 =?us-ascii?Q?BUFgpuBYQXz+7mMoG8lFFYQCaB9A96YYHHhq5EnYj9RTbYKzwCwiGJSWEwcR?=
 =?us-ascii?Q?yZYzOP+LIBOTC5MpeWJLYNYVxCY8krAuHmuH8iR0guenVZZEU+E1SGJeDd0B?=
 =?us-ascii?Q?Hyu92hcbvrZXbOru6JJGgv/rldFNHYnlF1D9fOuw4iWBrMNNA2/0Mphwv319?=
 =?us-ascii?Q?KScUbYLDpF9AuQZ8vrGZClRVcuBwYdX8zsW3K1q+k0Rq8K3JNMlreRyWeRMz?=
 =?us-ascii?Q?z2RS3A6uG06LSA+RYsnZJGpOJXyMhfLqJdsSJCovJ36ebF0UCsdzOQTcgvzU?=
 =?us-ascii?Q?Azt1qiiv5pbrr4KfzdCYqfxLaAUU9wTrWELVLdBqQjPxHVbA0YLrAOOw20kk?=
 =?us-ascii?Q?08J5BtqaLkNKTEu37EaAR2h+zVXFlCokGn8Z2lDjP7bk3nKA7C4eRjx+n18e?=
 =?us-ascii?Q?XO6VP8E5WxR6ilD4KndRN3rOJsSaP58iOi8FlC4d4GFAClof56Dds9CXL1lw?=
 =?us-ascii?Q?KzWhMno6UBhW50BIllbDZOQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?T21ztMhbkN6q3M02mgXVtkgGq1AD+n7cRaKe/jhe+3e1n1rmp7FqhHh2dsm8?=
 =?us-ascii?Q?xJFYYuVAyblSGhPYbqe/IiIic9/cxO5XS5S565U4tZHaIbWJvejgBxlHBf3T?=
 =?us-ascii?Q?VfhlcmjMs8nLFl4fOiJAHhnsMHW3R23o5iCRkWpDSeXz/8Tc/Py0ZhIEhjpY?=
 =?us-ascii?Q?A3sY9eAsu8IufWajL5ENjXioidjLgnrnbRvNzb4e55cyqVLAWdAWxVqaYD1b?=
 =?us-ascii?Q?5Gvkem2Ymrf4el3nU1UJ4FpK39tx4hJqj958fE2WRy0PxZrWwpd8jmu3JExd?=
 =?us-ascii?Q?gRqYF8pjLIepQDZijyQQOWrw0cIUcEOcEu9exF9VzytWorfN+Srh6dSW133p?=
 =?us-ascii?Q?13iykzV2NRtX09rXKMoUafAJ8WkAktovxS/TOOt97utDH0mrDN/x7nYWT8/M?=
 =?us-ascii?Q?WTP6zXsi8PvVt4OUt77V8/WbK9ddaJc0aGIdQUzdC63xpNoNHfBcWNRDGDrU?=
 =?us-ascii?Q?1uLNC89akP0uzr7VhmMYQ0g7u/ShRL9XqfUMrznI0DGWwE7q5u/2b9Fa9MJs?=
 =?us-ascii?Q?El5TfsTZisEgoKBTSm2XFWbEyKMVjNkxgy5QNK+OIcgl0JGjk4emW236/4eC?=
 =?us-ascii?Q?Enc5ExC5gsUWZphjvQbqh51lyCrHL6Z7Cw3r7TXaVbUse/qKN/rjbo/WUouS?=
 =?us-ascii?Q?l5WUjsSSo+XMowtBN5v4dnhbT6qv7baLn0vgGROeJ9Y4W1FL7F1ICWC1QZIF?=
 =?us-ascii?Q?RUf5gcJktB6KJohtYkPUvIzGO+OzONbUGmHenNjuBQqQQNJSUcdy9iKlZMva?=
 =?us-ascii?Q?4Ip8P4LqgD9lvvYW8iJRysSJdGt77eDX+PyB8fE3xVx/u4HBnqE7/vI36I8R?=
 =?us-ascii?Q?tbKniUFrVsjUWMSAOgDrF/0LBDmhWhG+y7jAxdyeLi37Ct/N1YKCYD1RidTM?=
 =?us-ascii?Q?xkWzj/HwZAoGHoD90MeOCmxpqoe1YaOnmdFktHmUifo+pMeVjGeb5kY6Ytt7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddfb8c1-2c13-47e1-8e62-08daf4de0e8e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 20:46:19.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Gg7g0v84Y9+StJMX1xrVPhxlI93qC5kJWjWTTkBBXd7pXP9zLfl4cTdqMzUadjkSldRLQDyWgpICuBY7Dc/AzdcinR0o0ViajzIouDaiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120148
X-Proofpoint-GUID: bGjhiaQ2vQNaNY4PQdbSIzzKpyryC1aa
X-Proofpoint-ORIG-GUID: bGjhiaQ2vQNaNY4PQdbSIzzKpyryC1aa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a struct folio rather than a head page in try_memory_failure_hugetlb.
This converts one user of SetHPageMigratable to the folio equivalent.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory-failure.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee7e79ec6eaf..ca84b27489d0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1860,7 +1860,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 {
 	int res;
 	struct page *p = pfn_to_page(pfn);
-	struct page *head;
+	struct folio *folio;
 	unsigned long page_flags;
 	bool migratable_cleared = false;
 
@@ -1873,8 +1873,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	} else if (res == -EHWPOISON) {
 		pr_err("%#lx: already hardware poisoned\n", pfn);
 		if (flags & MF_ACTION_REQUIRED) {
-			head = compound_head(p);
-			res = kill_accessing_process(current, page_to_pfn(head), flags);
+			folio = page_folio(p);
+			res = kill_accessing_process(current, folio_pfn(folio), flags);
 		}
 		return res;
 	} else if (res == -EBUSY) {
@@ -1885,16 +1885,16 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
 	}
 
-	head = compound_head(p);
-	lock_page(head);
+	folio = page_folio(p);
+	folio_lock(folio);
 
 	if (hwpoison_filter(p)) {
-		hugetlb_clear_page_hwpoison(head);
+		hugetlb_clear_page_hwpoison(&folio->page);
 		if (migratable_cleared)
-			SetHPageMigratable(head);
-		unlock_page(head);
+			folio_set_hugetlb_migratable(folio);
+		folio_unlock(folio);
 		if (res == 1)
-			put_page(head);
+			folio_put(folio);
 		return -EOPNOTSUPP;
 	}
 
@@ -1903,7 +1903,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 * or demotion can be prevented by PageHWPoison flag.
 	 */
 	if (res == 0) {
-		unlock_page(head);
+		folio_unlock(folio);
 		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
@@ -1913,10 +1913,10 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		return action_result(pfn, MF_MSG_FREE_HUGE, res);
 	}
 
-	page_flags = head->flags;
+	page_flags = folio->flags;
 
-	if (!hwpoison_user_mappings(p, pfn, flags, head)) {
-		unlock_page(head);
+	if (!hwpoison_user_mappings(p, pfn, flags, &folio->page)) {
+		folio_unlock(folio);
 		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 	}
 
-- 
2.39.0

