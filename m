Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34126E17FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDMXPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDMXP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:15:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C51BE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:15:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DLfvWm012832;
        Thu, 13 Apr 2023 23:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=nNGzYXNZiU1HGYEV2TvGskVf68jn6hY1qJpj/I7cqww=;
 b=r1GL5EkjS2MTXcND/H3g1BFigCOSnP3y18rQsEZRVOTSfLLfaJGaaxc6uyx0zbE/fpAq
 x4bjhgtR5e8gPP+JMAR6gATRbdIUeprym1QRb8MzKfwpDlAl+OPIQvUhL/SUKF2HxuAo
 HWavCDLiUIHe+GW2NQfO8gaPKVz+N5qsLVuAUmBJj1oOm1rYVeLDlXpT+tSpI0vyv3Z0
 ZHrWw3SIWcJrAgLmn8wUm5ep3KP8ZC6u5owHd+D3TpCvjrJJxT+vucToo1x9ys/8peo7
 5eB7mgjrGuXmzqcZ0szjp526TunTmO/5WqlwTfhviN++rf53FDmAXIwx2S9AtQnex8Yo sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwn0pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DLeMve025109;
        Thu, 13 Apr 2023 23:15:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwdt922n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9Ds4l3QeXH7RjubDukRnzbQyurfyKBnqZ3YPOM+/+Iw11LpTN4IZIRLgsfAB0cKtU6lUclQ6rPTCLYXNGqrs2T30+93ZjvQWM+qMAz7Vm8SCYKHHRUOYtjhgxYNIQ7wt5UIf9cwqZZ8wytY2GwD0s8OqJ8PV1oMyklLitrFd4w/vV9mYB1QfRZCUbukOywoCovmnC85XREbuCMdcOSkuf1ycz/QZQfwMUFCLxdGXuxMGp8foCnJMNZ2gg4StMgNLTw5y0TmnXoR8qQvrowf+5PWYE3lSs8OjRQgowu68F7yjj2CIz3tvIZAPpi23xyCMfGwGaoY39pTiAgtgpI9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNGzYXNZiU1HGYEV2TvGskVf68jn6hY1qJpj/I7cqww=;
 b=ZQ2hiA+bPxO7+xgVLTEHZCvyoC4weXQwpOjg3NOUUkYH+MOw/mHca09TwDSWGDmtc3SITQBYVDrPgIPjuTxoNA5ke2LLknG00GsMNFMMgfLeF5uL5IlcBkQm1oxMYP2wJLDOkue8ERi/fkzcMMPUGv1SWcdS7W7/rWR5+5VYLy870+vXFYd0IOisuQPsmDQgleX5rFEa6agF539mlfEVqssJxMPpojTIwShyrzcv7Rq7NXmkMe2g95kTlPdAHQdcCRC8vUEBNQgDR+EC8sq0kpgsaTdmH+CQLyVFI97LV8r6bUxCT0c9QpnFkIPcRgFZpUZhfaIdW6J9/2PQ4+oSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNGzYXNZiU1HGYEV2TvGskVf68jn6hY1qJpj/I7cqww=;
 b=BFTFRveuwm0X0wALVZ2EZQyCuyeZxrbktxb5vWQH/ejUDpvXytV6LIh7m28TOC2bKLyD7csd8q+zkYLKnDGKbRU20xDaKqtd10UU1MpcPDjyOFxXExlI29Ap3LvGhKfwr6h2elX5IcqZD2DgJ7NHH2afsKhzF20tpCYNJVqEbqU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 23:15:01 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 23:15:01 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 2/4] mm/hugetlb: remove hugetlb_basepage_index()
Date:   Thu, 13 Apr 2023 16:14:50 -0700
Message-Id: <20230413231452.84529-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
References: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN7PR10MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: a25a9b17-5ef8-4420-16ab-08db3c74e822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uABKVaLs7QYZGQm2oft410K/vB54Jw01PyDPt+o6U6qqUVj2QuN1qhBk0r4m4qhgW5KpSR3RHRhl5PKSNrDq09gd7z3SGqDkRtHv6JhjDv5nVKigwfe0dwqCUa/rEY1/VIa1LGzdUqiYEBAeJ0NQ0xgIf/8JLbQknk8yhhds4lIpoKHYEAD/S8o4xA7nchtNA/yeujwqEsKjPZBHP9h3XTIqYHbmJ3F9fXAHcVN/VJEKOKjGhzoop+MfeOkwHgUP2KIHxPD6N//0RY22MkYlKHA0EuqgaaIDL9PzwI5ilae5n2iO2/cqeocPGDl5StoLxPUsU92t+znrAcQxHpOAT9mX7ZvC6vcZDpMv5gAqbo0blLcjXmYgDJWpyJwIXGSSHyNzXsJ3C/MRPjM/rhrJhj/y9sGg/hSkEq37XjgHNGdMBHnMy25i/KQeY7Xw+PIvOdLHgi1BaAYChq0U6Utm9v5tL2E989pjpcJ123BVAVngN/nP+y4cL9+/22/eeGhpHImystF78VaZ0t/ac9YiY87MXDPZove8wlPcmBE4K/dGGPGJEc520LyQzaainF7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6506007)(86362001)(6666004)(6512007)(107886003)(478600001)(6486002)(1076003)(186003)(66556008)(66946007)(66476007)(4326008)(38100700002)(316002)(5660300002)(2616005)(41300700001)(83380400001)(44832011)(36756003)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LBj9ZHQd8TUsZgUJ4OTe3HbIGLw9DQpdPVmxyp4mtaUZcXbxTKrsRRwHhB/?=
 =?us-ascii?Q?fjC/ljQQUqcGQ7Bm1POca73H50ll6MUnbqM5wT6o1NBRuWgTgp5OLewLezg5?=
 =?us-ascii?Q?/tvAjMDjUoMbf95W1BPMCDIleEhvyL0fAh20nydyUR6JIAJgF5t8idLtov4t?=
 =?us-ascii?Q?fqUpk6X4gzaMi/6ZxxhW2HHmIf7fA8hJAJHhx8efYMF87IK7PbfMp8NmZwZA?=
 =?us-ascii?Q?kd6lUCXPFpQuQFDHm+cwZdpameGI2rU7cSfotWnc8wfBBpSRs1Eyc/X9kZtL?=
 =?us-ascii?Q?EOD3nqLdDY289iVhQmi7VkYXw2+IPj/LHAgCS9v3aPwCzOWX0K6g+s1l1tjL?=
 =?us-ascii?Q?aJ7KT8zDbntIeI7eoEiyN3Ou/J8NUkAl95gPkS4dqUVCWXO6j8sLnZFsza/Q?=
 =?us-ascii?Q?rn2Ja2Jlvg2W/HI8Zq8vlKeom2VNLveHnEFREKmCgKpuS+pnWKx3EngkSC+S?=
 =?us-ascii?Q?SCF4TZ9z8HC75f0hbyY4b7kbALvPoi/kmF5LfGF49zVOCrOMRlMhnB5u/cDk?=
 =?us-ascii?Q?Lti0pCuGxQPGAXtTPP0r6PBxlAcm7NkjtZxAsdt/MEtxNA6kMe4fKp32rm2N?=
 =?us-ascii?Q?Suo3Ui5l64XBVeK30bV1av587b3WRHkYUT7e6TSTixlVl+lyNzQMfuKSv42u?=
 =?us-ascii?Q?w396iAnx2H362CAF/Ipj5cDT0wCNj01sBhsmnq4Ux68AKigCS9EmBhGQw8C1?=
 =?us-ascii?Q?NmFpW2Y8vcqTxJW5hg4JcXnjm8zhTpHZWyqbDDXx3BK1qcjeNBxMU8Nh821Z?=
 =?us-ascii?Q?KtlSmEdM9LzwyjexEXQRBT1ZOwrx5VL6n5Qf9Rqssng34I2BqapdyttHsvHh?=
 =?us-ascii?Q?3Tbk8X8lqJRFvyHkdK2lebMGYJTsh0ZQ6uJ6fmi8FlBhH9aomP6lzvuTjleq?=
 =?us-ascii?Q?GbdYtQoUtNLL0c74ByvaU1JYbXBmnUpfNO7/DGzlHwYubx84Ls5GpnQNG4f4?=
 =?us-ascii?Q?2Lldl3Ehu6oDdkkzYorHKZh/j1gLcpIxvu2dgQwTr5lRBSGM7DvZwYeq80XZ?=
 =?us-ascii?Q?mnThRTbd19w4eH9U9tIwffZfQQdH4fImwjdFv8vquINyUawRTLfSCGCw932k?=
 =?us-ascii?Q?d1oWqczZKQtQTnpKB5T3BvBXNUEBwb9JkDBnxVW8E3Uhy6sRLv2gXe2H9wmp?=
 =?us-ascii?Q?s5IcxXePhKYV9JcL4oDf7vryXMM22XLVaqafIFipUQoTO6cDQMKVAUi2RX/R?=
 =?us-ascii?Q?xMZWck1L52wlWyr1fUvfsyOnzjfHIfpCeqhGncLvTCtqhBq9tfqLbzj7W4qk?=
 =?us-ascii?Q?Jc/9fMvvilWGnvDwXmKA7ckPuoGrqwNvsI4btB9YqVL9iXqFem7P6IbtMVqD?=
 =?us-ascii?Q?I3l1kNGueXIv07QxEwhnRJSOxQ/Zil2mcGjfI47x5dh7ShE69UuJloFDWVrv?=
 =?us-ascii?Q?/MLg/1HvB+B4sVerYj6eMCj4K0E1hnum4k/vNfpQHpizTCIMDjBu+vUHnw9a?=
 =?us-ascii?Q?+vUVlHAhY3bm0fIAKpMR6LuT1P+e2dt3BNbQSuYUbPsIZYe4Nt56z2wzXenP?=
 =?us-ascii?Q?zUKv1yPVZxhEp0MeMZKfnHZvHVgEoAiDq+vG030tV2DqjMbdN+DxdHcUHBDK?=
 =?us-ascii?Q?5bViCGk5F9cpKpVhK9ehYmU3AggWA6uuEdm4/Wx0TqWAOmLIZJ0ugK8PNEbl?=
 =?us-ascii?Q?LLgBCkiRohPx9KthykSyXFU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ttVfZV9FqBvk/QkqSOm96vIepP094YAfDH0/qcyBW86FrFLaSs1RSsADW7FrtsJcsDnbmxmuG/OOv3+VrjKh1pqGvQaThD2AkcGUAKsKp0WQR9Ul4THL6tu0vwPIuiC0VsfPvX5Z0cT9MiWrrKcgPHQAEOUXXaDzlGV5rx2wvo0KwiATSbH1F80ky+teww03qduhbTxnoHMGTZWkriKr3bwL8ObqY3Q0S8yySaX7wUlOt08mUGdil0KmJZ5hxVb6JMJwKQ1Ar9fvoSg7SFxyuVerrrnWCxvdfK0uCl2+2hrhJz8//X2E7SftuFvtLbxz3itgkD6hLVuwj6BTKhfkH1qMfbRrxKLjb5+287Q8B733skMoMHRM0Vw2AZyK61o0vQ39+yb1sAFqCWZ6sa7H4zdbSrOy2D9/qW4BLWg2D3S+yNr+i1b1n8pGF+BuXsi3lbvgc6Ymr4CWCJqJbjz5BP2VdWGvqn2C3fUSBlJo+C/pZ5KHqk/T5D9YO2BAJXE9l/j+251393DXbfVCj0divbTlq8OnTbFswU/+AP87ns2/eAxWFlr9E3MdOACfHVm+ZP0KaRDw25Sp04JMj63Eby356QUWRw94eePocdjcvh06lzE5ShGJ0mLH+6YJmSlJyVp5JktxSq4pg1ig4OKNx5tlSSS5cBT0u0Ui8SRBreARFOknwG9tzHW1SCPEf586o6OhV8SNM2tbW+C0G5aDaumIWIukR/WLq1y932QteZ03wkEEhNmf14QWYfvW6QOTOXyFY6zjqsOhAg8hfRiCWf1phouNePDBi6qNojtyHLJVYFjqlWOHSMUE2l0nNwZsxxkrcWICHtCrV+gUD+oMy0C9H/TO4jGWQOi79srMEv6YP9iMVNzZZDOMOxvX34juFfaozKofv05xQp5qEEFGGD6gyxisu4Z0m4Lf+mHqBcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25a9b17-5ef8-4420-16ab-08db3c74e822
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 23:15:01.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5sw/U/qKegAloe+DwZ9HEl6jXblC7HBsGASMo9UyLDuUxNhTKkjsZTcGipGA9PdbUXi3d8WYISWZz6QLeoU8QcPzmMPT2Z5MZLvS2AE34o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130207
X-Proofpoint-ORIG-GUID: CGdbZDWTTTrGciyPweo43NDpf6YvVJui
X-Proofpoint-GUID: CGdbZDWTTTrGciyPweo43NDpf6YvVJui
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_basepage_index() can now be removed as hugetlb pages have ->index
in PAGE_SIZE. This also allows removals of vma_hugecache_offset() and
linear_hugepage_index() which are replaced by calls to
linear_page_index().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/pagemap.h |  7 ------
 mm/hugetlb.c            | 50 ++++++++---------------------------------
 2 files changed, 9 insertions(+), 48 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 330b1db913f5a..bb60282317875 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -792,16 +792,11 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t page_to_pgoff(struct page *page)
 {
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
 	return page_to_index(page);
 }
 
@@ -854,8 +849,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f16b25b1a6b93..011020a30f4ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -949,24 +949,6 @@ static long region_count(struct resv_map *resv, long f, long t)
 	return chg;
 }
 
-/*
- * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
- */
-static pgoff_t vma_hugecache_offset(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	return ((address - vma->vm_start) >> huge_page_shift(h)) +
-			(vma->vm_pgoff >> huge_page_order(h));
-}
-
-pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
-				     unsigned long address)
-{
-	return vma_hugecache_offset(hstate_vma(vma), vma, address);
-}
-EXPORT_SYMBOL_GPL(linear_hugepage_index);
-
 /*
  * Return the size of the pages allocated when backing a VMA. In the majority
  * cases this will be same size as used by the page table entries.
@@ -2087,21 +2069,6 @@ struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
 
 	return NULL;
 }
-
-pgoff_t hugetlb_basepage_index(struct page *page)
-{
-	struct page *page_head = compound_head(page);
-	pgoff_t index = page_index(page_head);
-	unsigned long compound_idx;
-
-	if (compound_order(page_head) > MAX_ORDER)
-		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
-	else
-		compound_idx = page - page_head;
-
-	return (index << compound_order(page_head)) + compound_idx;
-}
-
 static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
@@ -2703,7 +2670,7 @@ static long __vma_reservation_common(struct hstate *h,
 	if (!resv)
 		return 1;
 
-	idx = vma_hugecache_offset(h, vma, addr);
+	idx = linear_page_index(vma, addr);
 	switch (mode) {
 	case VMA_NEEDS_RESV:
 		ret = region_chg(resv, idx, idx + 1, &dummy_out_regions_needed);
@@ -4810,6 +4777,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
+	unsigned int order = huge_page_order(h);
 	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
@@ -4821,11 +4789,11 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
-	start = vma_hugecache_offset(h, vma, vma->vm_start);
-	end = vma_hugecache_offset(h, vma, vma->vm_end);
+	start = linear_page_index(vma, vma->vm_start);
+	end = linear_page_index(vma, vma->vm_end);
 
 	reserve = (end - start) - region_count(resv, start, end);
-	hugetlb_cgroup_uncharge_counter(resv, start, end);
+	hugetlb_cgroup_uncharge_counter(resv, start >> order, end >> order);
 	if (reserve) {
 		/*
 		 * Decrement reserve counts.  The global reserve count may be
@@ -5582,7 +5550,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			 *
 			 * Reacquire both after unmap operation.
 			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
+			idx = linear_page_index(vma, address);
 			hash = hugetlb_fault_mutex_hash(mapping, idx);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
@@ -5669,7 +5637,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	bool present;
 
 	rcu_read_lock();
@@ -6014,7 +5982,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the same page in the page cache.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
+	idx = linear_page_index(vma, address);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -6185,7 +6153,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	bool wp_enabled = (flags & MFILL_ATOMIC_WP);
 	struct hstate *h = hstate_vma(dst_vma);
 	struct address_space *mapping = dst_vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
+	pgoff_t idx = linear_page_index(dst_vma, dst_addr);
 	unsigned long size;
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	pte_t _dst_pte;
-- 
2.39.2

