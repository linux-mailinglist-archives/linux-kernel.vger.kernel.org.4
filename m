Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4164F43D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLPWpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLPWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:45:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68248776
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:45:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGLSpYD023037;
        Fri, 16 Dec 2022 22:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=dCQf7YMobAT4v/S1qun9Wv3LIItywq4gHhbIDQcTRFw=;
 b=Mi7f+PQKomfQwZEDvMuNwtwUH5Wff0pmaWm/6rz/Nkl2UOENdjJpb8LmR0fmDvoVrEKV
 WBHg5ZoKVVZL1yM6UeR7EMVAPqIA6UgXOaeoQWdNcq+FLbEnSP/MS9AZnbigBjaYA+pX
 AXFzoKohIhoLnXR0rc2bK3/zvVo/0zKupzkbuewELZmMMGpHgNGhInlfu08ML7wv5PjI
 glMlI11KhwvRuraq4SQgGczOgnUyiBwnvGlRoSHDvERa9ZkzWwAuhebv4OGnP+u/CQGQ
 42q0aaa+ACZuo23IgDSlq1Ulw0z/rqvCZah3UYJ1D8HJhwdYfQ7xv7u1Vh0TLD4GgCUw qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyes0nka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 22:45:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGLbY47027806;
        Fri, 16 Dec 2022 22:45:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyf104tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 22:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfcURuYcs8EcnbmX7/3y45rRGlKzt8oInrVKreyx/a0r9njfR9/ygY9Ydc22du824a4Aoy1slwC5OccW7ljmrCxprhrIsGgj0K3YZ/7h2JMxlNxLK4pTDc6oKjVWBOMCOYN04VYj3rCmeD0oEYZ3LY6/+SwuZLf+ohEPTIfEgr0Z/J+GDXwzZosqCfTQeuJXByhqxmgO4G2C+PZr+ZKnjRNbgviolsLVbUDD2MZ+6bgc096Nl4tDR2uiubNDtB1LfLue1Zic++ZgprZw5BwSWrmPE39L1O3iItmIPjE+FPyigBDf3SCELU2son6Kr6XEUghd8DExcnMt5Krt8Fwm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCQf7YMobAT4v/S1qun9Wv3LIItywq4gHhbIDQcTRFw=;
 b=Ka0Ewzyvjk8DWPhmuO6llpenfOBfcFV7zuYOH2mQDfifibVXSKY7fJAsDc06llw62S19ts16z2S3/1Md8827yWJX1lI1qC94u7EZ5CN2uYADW3BLBsYwU9uFHTI2is1R8XlUrvLCRxdqq5q4tgmaMptnCjzmrGcsjSJXggflyOcrTdy0jIAP+UorBIudXNqX73tQXuFMXLsFdoHfo/CBpRF2zWQDZ44bFBzh6HPVh+UER+hHO8q8lcX+f+/bP6OidovcHfVJmEFdtEvq/4xf8Dq79Nfnk9y9Crt8Z2SGf8MPsZ/ITUjN8PAPYpcZ1FDReFd8VV/O5rNKMJTrP7O5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCQf7YMobAT4v/S1qun9Wv3LIItywq4gHhbIDQcTRFw=;
 b=VA1BwBMoYuBi6lNehxXTYspolCvqU/5yiEKlI8gkT6RBi7Y6XBaAiLOjCJyPbTZuCDxGDN7/ClAoLgPKViYx5LC5Il8XCHh8O+uXM5GkzjFtoNtlM73xt6laNOWTxm6IrPzgD0W9S8qCWL6Jp9dVv7zswo81UmCR+i0wl9rb5Zo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 22:45:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 22:45:10 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: initialize variable to avoid compiler warning
Date:   Fri, 16 Dec 2022 14:45:07 -0800
Message-Id: <20221216224507.106789-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d53c11c-6acb-4c86-a76c-08dadfb72fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R8P7SjtEQl0xPQPY5HbP/mY3XrA4BPS6bv+vCq5oyl+io1fzrUck83qaCDRcXmYfM23lwxjtNT7SK7OA6XiEEjr4TtwpKT3EwC92+Tb6OyPzW+3PKuxJH3u5/x46wjzOxD8qmsiHY+b3IewW9eMtcVi5ekGUzkRfbylSvQfzNU220djleS6SJiEqpiyycyIOa6q8vyQTkRwuz/VI7FgNl7FBybzxzjobRzdQed9RfeLvdaxl2/d/61/vsxIZYvWEbKJTyMbinzHDolRWK97Xe6rNvsXdaWMuCFVJ1gXdOQ9ssQR6PgQMXUCVU1Y3FizVcH7GrQG/cfq+6ocBrUoJg9542L+7tSZDZMmwxyEnYFPx/17E6RTnCz9Fw2zHNkRvcn1iWgYxz05290nP7UiXByQ9IFGXuvl+yz3qsLZZzx6r0/n9vIuEeL5LiIVuCDh7jC7zgDrXoxJYb+CEjV8xGRm3KSerZbT+0KK5aGfxmUk3pgkfL83NJWqktO2nbrDqEi2/RR/M1/xE6lT+8EFVos059nIkJSR9sfExc7iK6FNwoth+CTO+gswxLlDCNqXq9itSTtmucr+XljJbALOtKJbSOojctlLK4lKRxf7odYNgyu7x/R0cdik8fu+HwedwaZV7rdnHaYrwAdkBGVPyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(44832011)(4326008)(8676002)(2906002)(2616005)(66946007)(66556008)(66476007)(36756003)(41300700001)(4744005)(1076003)(5660300002)(83380400001)(8936002)(86362001)(38100700002)(478600001)(186003)(316002)(6512007)(26005)(54906003)(6506007)(6486002)(6666004)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnh4OSswSHVyb1hJMkZ2OGR2OVlIYVQzQW4yODd2U1lGSmozOUxhMXpNemJ4?=
 =?utf-8?B?NUJHWHFjWWxkbEN5ODhKZjJjQUtKN2xaV1N4cVhQZFRqVGp1aklDZmU1R3g0?=
 =?utf-8?B?UWFEK2V4V1NEODBmUWJrZExveTlaMGZWcWM5NXdiUDYrREQ5VFFWVDV3cktP?=
 =?utf-8?B?elgxNXI3cEVzeEpjdm5EcHh1Vyt5blBHZmpMNE92V1U4OEFGQUQ3YnpaRFYy?=
 =?utf-8?B?K3h2WEZlbXZOajI0WW5QcXBReG9Ebm5vNTgweU84Sk96bDg5Y2Vma1NydUdR?=
 =?utf-8?B?elBsWXJNeXpsemVUSTBtbWozK1VMNHNFSjFpV3V4eU9oNGhtVDcyQ1Jiekk5?=
 =?utf-8?B?Q3F3ZVh0a00yZGNMVGo5Rk96aVhUbjF5YkVGUWZRRkVXV1ZaQ1N0WlVwbDh0?=
 =?utf-8?B?VUZEQ2FTMHE1L1QyMDFCYmtiTUdGbFBYRnppR0ZXMVBOWTk5M0FqcXJjcmYr?=
 =?utf-8?B?MzZ3NjlBODlFQzRvKzd2TmJLcm8yL2VhOGMzeFZYQzNtWGxBSUQyUUhXdThi?=
 =?utf-8?B?OENLNnFnTU92WkpPN1lXazdDTkQ1VnR0Rjg5ZXVPOC9qMGw1UlJYWG15OTV2?=
 =?utf-8?B?TUNtcWsxeDRpSzBibWEwUlFwWTBFT25PWVl6K3VLN1g2OVVBNng3VGZ0RUlp?=
 =?utf-8?B?WWVScDFkaTJ1TGlPUFZZdmQyRG9lNkpDUWM5dmJCQU1HRStiZHZoeVRtYmk3?=
 =?utf-8?B?b2dkY1ZCOVlSTGVDOHhkc05hbFh3Y1ZsMXcxZlRMU1BPZXNHWXFja0svRG1R?=
 =?utf-8?B?RncrQmliNXQ3UmZ5S1ZVMzcrVXZMQ2ZBMStrblhYRk5mTkMrVkpPRFJ3d2pI?=
 =?utf-8?B?eFIzV3o5amF0S2VZYTVxM0puTFhIejVYWUsrMXFBWU9YNEFIRlk4dVJQNjBR?=
 =?utf-8?B?S2R4c1p3Q1AxWFBiUThQV3FGT3ZHaGN2RFY4OWxxb1JNZjlucC92L0Z1QnJs?=
 =?utf-8?B?VlFIYjBjVkhrVm9XNHcwR0NiVThLTnNZUGhuWEhhTjA4ZGxnZkQ0MHVkTVZv?=
 =?utf-8?B?VkhhRFJ1VFBUaEZpYVNKazVvelFHMkNGVUhmZE9vTFYrOS9LVlBjbVFVVTVO?=
 =?utf-8?B?WWlWd0xmMGpndWFnN2FSWE02cGRDSE9FUjBuaGNvdG0zVFkvSDZjL2t4bWg3?=
 =?utf-8?B?ampkVVlETXJEQWc5TnhLUm5NMDVtY2tsYkpWYVZuTTdCaWpBTzIvSnJCYkFs?=
 =?utf-8?B?czRqNGFRdWlQU0ZRUHJ2L09DdjBzYkpQTThMU05wZVZ3THBiSUdLU1RRdEFR?=
 =?utf-8?B?MkJpaFM5UzFRWmU5dWVvcS9zNStUMjZxNTBBUFVXRUpWSEgrMmVsMEZNeTlS?=
 =?utf-8?B?RENjMXZoYnM0S0poeVBmdk13TkxCMjNhaWlCYitXL0Q1QkIrOHdNb2ErTHNB?=
 =?utf-8?B?dW1ZaUVMZExRaVVraGZBSEdUa1hvclBLLzIyWHFKZEE3aXhRMGtsa0svd01X?=
 =?utf-8?B?c09BdE5mSVcremd5OE0ydHNEZWo4L2pNdWhiMDY1QWpSNjdEaVY2YW5waTND?=
 =?utf-8?B?QVJiRzVtQjdKdmpERnR6dnpudGs0OGlVTjBYM25BMHhyZURvT3JRK3Y3UG9I?=
 =?utf-8?B?YVFKOU10V1hYNHRBZjJuQmd1ZVZ5Q2ZCOXRVNWd3dFhFaXcxeW1Cb240eFph?=
 =?utf-8?B?bk9kYUI2bjNKVWhYL0FjVlI4R3ZDajhyVUNNS2lTRjZWbVFXRnJ4REpyR1J0?=
 =?utf-8?B?UlZEUGZJN0VVUk5nK3czcUhDOW1ueGNncENUNURwOVQxNjZtM0psalVQRHRR?=
 =?utf-8?B?cDJrOGhITUxuN0UwekQ5QzhrY1JYV1cvM2NVblhESFBtcVJnRlhjNU0rd0cw?=
 =?utf-8?B?N1dqMEtpQ2JyK0hwQXdXVnQvRk9kWk9vZzQ3dDZ1K3hyQTVWb2o4SFgrZ3pS?=
 =?utf-8?B?L3R6U1RMRXI2OG1QOFpQVVllTGZSN0ZnRkdGZThPTU0xbXpEU2hVZGZRN3Ny?=
 =?utf-8?B?M0czMnNiVTg4L1VZd29OWDRqS0pMVWxEaDc0WmJRc1VuNTd1N3d6cmhNcWhW?=
 =?utf-8?B?MktkWlFxUGFNeHdsY0FtWFY3M0djNFJWaXVUOVIySFJXeEZGcFVXM0loc3Rs?=
 =?utf-8?B?NzR4dTZSZ3VvMHI4U1pMMFRIN1JTRXR0bmpDTlAzZ0kvRFRmWGFHbktJMVFG?=
 =?utf-8?B?VjZSNXFXT0ZSeFNIZHBVQjZkYzh1bVFjL29GWDkvOHliYUdOdGNrYUErQlc0?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d53c11c-6acb-4c86-a76c-08dadfb72fd7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 22:45:10.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0WPxqqXVF91SkyYU9wc5mIneWRU1hGxe9fqL3jbfnpuly4tJcQQ8gI0fLbTTLsR+Xpl5PB5oqn9wWQ95k3ZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160202
X-Proofpoint-ORIG-GUID: O0KZe3YpqhUjphEeehrSm674H-qV5xqR
X-Proofpoint-GUID: O0KZe3YpqhUjphEeehrSm674H-qV5xqR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the gcc 'maybe-uninitialized' warning enabled, gcc will produce:
  mm/hugetlb.c:6896:20: warning: ‘chg’ may be used uninitialized
This is a false positive, but may be difficult for the compiler to
determine.  maybe-uninitialized is disabled by default, but this gets
flagged as a 0-DAY build regression.

Initialize the variable to silence the warning.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0dfe441f9f4d..b28b699c0a1a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6747,7 +6747,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long chg, add = -1;
+	long chg = -1, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
-- 
2.38.1

