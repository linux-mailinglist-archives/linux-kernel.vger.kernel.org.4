Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B2773B04E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFWFsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFWFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:48:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE45630C3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:47:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N1sORc031806;
        Fri, 23 Jun 2023 05:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OEZ5RYfheYhpYRD37BAUs58jpD0AZ5+RNubeykRXB7o=;
 b=IeTRJVzD20vCF5W44vg0/eXTquA1CGTBALBgjxyiJ5uDzL3mMb5imaoWW197F2CWQzQV
 s61iWSd5QEPXFEtjVWZrHy6zqKclx64/c5cyd7P+00oqMYAYcV9ASRxgIl2xvDBSf7Mz
 1lHQSAuvMl14vDF0SYd/FDsvpeeEbCvqh1tl8rH0t6Q7/JXSrRGZPiUYrE3s0lKhnScK
 MV9YK40lsypOAJv9orlTugMh8rYlKsOChH/37bmDu1EHn1BGcjTBeemrILoNG0Pk+PZU
 Qw8yOKkBujLuxW8KjUnAG54ZOg9r/Z5dA8WEdvhODTgsNH9IJ2Oyi0Zu8evNgsA8MGOv 3g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95cu394m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 05:46:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35N4lIx6008371;
        Fri, 23 Jun 2023 05:46:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9398u0ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 05:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYhH19gQlzaiquzJIwRKtRCn/rt2Ctm2iFXgQDPw1M1WbhVoVoORxrV3zFmCQdmGd6jvOo1S0oACRwnKBIe2q7g79yisx2RWgLAdzeyCVItO9Ch+sw8JLIPHQeXXZ5I2ljxSnKr4eptjP9P1hpzic+cc2XcAI2gEsdWl6wbeZKJECvNdZ7Iz3B1NcI1qksAyyYutjpWe5Ptems9wFzdQR40+TB8G21XgMmYQR/vaMxJQratBKZRJnFKVyGPuSMCcvkGD8HhZZgaFNRf46X6Urhe5Nm7ee5xuRZk3Ysad7Rol4VofCNeD3gpx9G7s1jBGUL391OOi/NEk1RTdtZ7qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEZ5RYfheYhpYRD37BAUs58jpD0AZ5+RNubeykRXB7o=;
 b=B3TKJa5wRydYUc2ZOuEeVeG+Av5Kz7nyvc5FnDoTs9wKTOd4q/N7iS+/kPpnxO2r/SV4iZF1a4rykQfBJQ0T6G9T7gi7vAujDwPbf8Gc7QfxucR86XX75baFT3iU+oZGR0CW1nqSjhUeTt74w6EtIMd/1F0U/5wFzoI1I8qWYFmQAidoB6euHOVyN5YXbptThgcr2XSZ7M2wsJuMPZO0d4PivIPzx6aC2YB2cCV24TAsgZv50U60m+qfz1v4D/LLyvuwgW+3q/yTZcxfYhaZhjOLSUXK8+zOqqztsyByGaVG46ih88uy1OObfa8BrAz6+mnqv3hD2x8XF+RJHZMTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEZ5RYfheYhpYRD37BAUs58jpD0AZ5+RNubeykRXB7o=;
 b=kxahuc+vofA+RxN6+aKXtTtrimeeujndr4iye7CayAzN41ZVE6TwQ1egMrRfcSREJRqsg9nrkdt/OrxSrSXsrqKNL0j61ADz846FpUpbFACFj6cfUalF1gcI79iep4O8Oah4xYMeQc+PCgGT6R/xcsB7bdo9zzOtWthbMNZA5fM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 05:46:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 05:46:55 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: remove hugetlb_set_page_subpool()
Date:   Thu, 22 Jun 2023 22:46:35 -0700
Message-ID: <20230623054635.279495-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: a3599146-d042-470d-519f-08db73ad404a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54bRH7mLHgp3N8sOv+HmnfJZllfETRLoI/yeKkfy84cMtGCGxV9mfDocuYdyK4mmXRPwhiZmSfOHhthOZGCC9rc7KvQynx9sIJLix82wrZeGmeOGP7V+D6Yn3X2anLnjLv6ihZCBqr5Q/CzFbrG6GEkwneKxlDwIXACwtHsF28tuHmyrUfaURJO5Wn8vqppfPH1yOZk5f0aZ00UdPvOYTdGPi8QX58JbJaAr4uXQwfwVAIHZGPuy1QL2/jZKdiSzBAWUshBbUXZTWhKPEWxb1UBaJoaDOUfSL6B7s+hMfwp4owcOG4+Nll0ChbeHxXfeWKFiSIAOR4cJ6YrodnoCxsSx96F4YlDpSDvYV6NVl/7PtgPjM9Hjci6SUUO78sy10H2+/5NXYp4Bl+BqO/Ag/T8JOECFzFw85U940jOhYOqWPHHBI7EUMtLmhbfxbDVNbysGgmfFy898INN1u4Jdquuf8U/3U4YumbSxXZ8tY5hW3QRsdIWLG35ZXs2rieXhmABKUDCGnH+NYZ1Oon+ZMCLnL1WfeVJt+VTLZPDq84Iv060a1NG3NpVlCCS577Cj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(6506007)(44832011)(1076003)(5660300002)(86362001)(6512007)(2616005)(316002)(478600001)(4744005)(2906002)(186003)(4326008)(107886003)(6666004)(66946007)(66556008)(66476007)(8936002)(6486002)(8676002)(36756003)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YLW18/yBMpDCTIx/h/xnFOa3i9gbr550u4EsDCRyMIKgj60we1bNz7fbHKuy?=
 =?us-ascii?Q?cWSwfmjmFBvgj33+GlNK8EkkmOfGZaRVxYUfRPsCRlhx3QXTywCxVwMYr4iM?=
 =?us-ascii?Q?NqoFe+njSVFAOfOjoCh3CQUJls8afSPrb7pvOIwHJg9SA4qJ1y7q6rcOxYAl?=
 =?us-ascii?Q?fT97I19bwVUKJg7ZnvJAjFnV0cUlA9/87xpfRFybBtIG1/Zu0B0ZvhJSNiRi?=
 =?us-ascii?Q?5Zcdpx1vUqnH/8LSGqaMcyAfFhE8ap1xj5icnaMjaFq+qaZq5l3duGQAdmv0?=
 =?us-ascii?Q?PuBSPKbVAwEnjeIaJvk3CxdSqz2aXJExdRXknoGeRfPMWZqLIlSBGBoXWLVV?=
 =?us-ascii?Q?ZuHzHpH2zEh89XomJg26LvuOfRuCZMcJGwCCXu0O7Pd9xzZC2Wus6rVsYdZe?=
 =?us-ascii?Q?wpSYmEPxqco5IUKJ1uhLSnQTJ/4AibfQaRsWuKREWsmIpW1XRHaKjODXOAZV?=
 =?us-ascii?Q?P47Gcl0dY0lVlaxzJOpWV3Y1P2HmEYUj5q5vY9Ytmds0rvDXJMfdfxX7UjPE?=
 =?us-ascii?Q?vbAT0ljHrVcP0x8AQQhKeLAz/wJ9NhZRA3XrN/zEyZohuTUW4kkXEABm7rih?=
 =?us-ascii?Q?/K8FOkgUaeQmGxPyhFDWQ81RYgbhrxJDILWaQ1f+Kmc4IuN/V8khoisv0Rll?=
 =?us-ascii?Q?i8EMTZ+suWkyGOQx6uDFZGSar+3NCEFSO9LrX7cnvZXEDHz8pmKCmR7Bo4lV?=
 =?us-ascii?Q?vFNJp/gumj3NNKp7NkZtpgy1UmrQSEvO1D88/AWhbNlfqiO0s5hEY1UO4NRk?=
 =?us-ascii?Q?G+C7F3w9BGEQkF8R8B02mTiqe9JfUfOt/q4QYVqFgLVkNQ8O2dSIVCw2Vi5Y?=
 =?us-ascii?Q?CC8DxgLtoSPew6qXr7r0kUESKA6q1nu91mjhf7lOVuHZbf6AbF0CnXeWrIPB?=
 =?us-ascii?Q?gsKcfJ/TCiXG1i/xKAf8Zf7Tcj6WAwZU1RdleISZ5AoZieJiPqA8s0fyn3m1?=
 =?us-ascii?Q?4qL+fuKj99bIcLb4MosVfnOguCXCMdjB8RuSa4y3wcOxt5T13xtd/inB/5Qd?=
 =?us-ascii?Q?Hn+OhSdTsvYZ8k6vjSNzAPuzB1TnuBex7aGTQfvzy8uwRCrFFMbIxsIoH32B?=
 =?us-ascii?Q?i7QqspA5YBPyDCgfxeN/8w+mOZcmo86TREIPRdIBVjHWFlc4Qb6JS6uxfZaU?=
 =?us-ascii?Q?xSiYy8F22Bxyc1OfJYn2vPddBa1yzDdw6r5wW3Gxwtk2gSCP/t0PW42kJQyi?=
 =?us-ascii?Q?qYqtF8D7wgERZYGs5w6BWt/U7VCVsKPGdRydT91WU00GeP6zqZmc1cKJd5hN?=
 =?us-ascii?Q?i4prR8eIN8T750/fKz9a5GX6OUQWIcRpuDuY+iGCgJVKpojn4f+qxSHRgxlm?=
 =?us-ascii?Q?GEXujtAE30SyGh0MouHlLCgj36P4ZLZ8seYdv/QC2bjbhs6zijGgKra+gEms?=
 =?us-ascii?Q?KvIeIKNsMelAdC11SMZ9NkmvOJhoNDJab/r+8UnhaQfqHwmvCysMk7JO9jmR?=
 =?us-ascii?Q?sxWgisYktHwTTkaT7mfjZrRVO9QDdq6l05LrP7pUXAC+/JeMLttDkIJyIqqK?=
 =?us-ascii?Q?yoy6ZTiuR2cTHPHFGfvQeG6F+/Mjo4Y3Q03orLUHnr9jPNs/yy9yy5EW8sUn?=
 =?us-ascii?Q?g/D9CwJImuWnOlPTHfxscDkfG7c62Mm2ni1PQcHAsoi1Bawfwn8bOviOhk9d?=
 =?us-ascii?Q?R64NNUcIvKcxJLK7RJYRGWY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QQuo11N6PKkrTmMGMpVm+w2AY0EvkhXRJcGmBC6Um2GNrqF5RTGW+Hk1MOxpfk0jTnqffxAeKmDU1ubi5fFGRrvx0RjbYGtTJDqc5xsAEg/LG4nQoIEYPuAMe1rfg+4y7UZS5h+CBHlf3KjVhJe2F4azU0RDfmY/IUKdEV064unbYIV8ugI5TxPIeNAf9/odQZwQBkUZjpaqpAMLUYstINFCdjzg4q+zCAK7C5sJ+ekCRAoYI1CMW/vbTc35jhofoGFrMBqjOh4/1j0SExicbFnskPIZZHBNMP7cUqfkm6s2GIuW/G3JtqOUgxD2KdP5tUTe6CWU+Q6t5aVqhF1COGq1vvTOGv69EYWfLtG5QYl+3o9KuREmMv7wFCfCP98DUce5nj4zEueBoOQ9abLcLULGuBB2uJahnVtsZJ9cqRFgWqBtWknENwIxFAVP1KrmIWavdUfw70T8Q3WxmuT3uxGixAOd7s0NlH1v8NJXktigkMPzBYLSSsj2MvmUidUv2HVLTMj0pSXaEQKD7t1lzc0IOgdGIkFl07kADY4qOh/bwTMe6eyYyIaExHiNUibSNAJF2Rgni69H4mYViz8MZwsm11igv6jIg2w/kQJ3iZt7aqy+OomlylMdahd2csXZqG8i/j+f9BynyI3dm/f8D3hUzB9hniOAiDNwu020RyrgiUkqVQl/+6cegmYX9TVNYN/59WHYywWPlBEnspHItLIbXgg3dNyaACGkyIPTppisahMH3Imzp2QyB9G2YlJ5+p2/x0RXaKPfdOjJrRlZVt/8w7u3kHtx+E7MVcdbNhE6OMWdlXOKgl1YsLZG/+YgdjfyQJkPKFSFGxHnZssJOOeZBBnXfogHHlmrLvFCluhychJE6Xgf12Y9wow3fnvR50uGmzOl2hXen8BvNvvR7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3599146-d042-470d-519f-08db73ad404a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 05:46:54.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX0mLWkj3Rk9kIoZily386kngJ1TMoPziQLcNhytucYpHn0JRC+JMoIMTIAZfc0zyC1/a5gs70iy615ag9wj9mfuH9sv2AWw1nMlwbMa7f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230051
X-Proofpoint-GUID: O08ynZJmt95D1sgAy6vedXyWnZ9lD1OP
X-Proofpoint-ORIG-GUID: O08ynZJmt95D1sgAy6vedXyWnZ9lD1OP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users have been converted to hugetlb_set_folio_subpool() so we can
safely remove this function.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index beb7c63d28716..d14676b6d144f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -761,11 +761,6 @@ static inline void hugetlb_set_folio_subpool(struct folio *folio,
 	folio->_hugetlb_subpool = subpool;
 }
 
-static inline void hugetlb_set_page_subpool(struct page *hpage,
-					struct hugepage_subpool *subpool)
-{
-	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
-}
 
 static inline struct hstate *hstate_file(struct file *f)
 {
-- 
2.41.0

