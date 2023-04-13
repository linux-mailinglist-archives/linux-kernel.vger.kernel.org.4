Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2E6E17F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjDMXPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjDMXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:15:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E91114
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:15:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DKxDtY006509;
        Thu, 13 Apr 2023 23:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=uWAWqf/Ei3Fj5gyx8nFYEz2lrYRudR7/nq90cXKlESk=;
 b=aAJT1FNzLwYB2/uI4hlFnCsz9tYb9S3UnpJu6rqGiIvyvNiLEPBFLtzr6WYy+iY2W4Nw
 oUM60yCwU1/1zKEnhk9Vpli7Arpv0/0vWKmma7gCGKhaG0XTB3PMDpJBiBLpzrPD9FS/
 FRnLqlj7sA5tgmWNGRAiCKOwQxL10q9fqFGyU3jU9g67oaKq4mWMi5fvuP0QJkaY0O9g
 rFCl/15cGT2WSR5tA9x+KeTbaNN+rzs+NVr6Y9yDO1/cnByND3MBOiZ3hkJoX3yML6yi
 03YY44T6/rjprXKydw0g6SMuSWr0vBPldumt7t7zqzKVcxDY4eknrzgXhNrI9p/4POYD Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hcct79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DM6C1i012738;
        Thu, 13 Apr 2023 23:15:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgrs6sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 23:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyLAHQiJb+QKJpj+/CyYxfrHo9VeW60e/IYWnABXMnYcjxE09oP44vUNVGViCV0pdjJ5hECSnodegTmx+Gcb0s4IMZngVvbUgKlbULPjcGsIi95H/zinbIP8hpvr6H50IujDu6QNqmsmJwDvVTncC3FRSxrm23lz8acv83b5qRByg7xtCyGrgAgR3jnFMjIGkhn+PhT7L55dA3n+DAZZmmq+Sq8AMkXrZtcD0+Hy8QR0GGse9AzKkXplvOaZE2xICPEK9oc9JfW5L3CWWBRSpB9/dzUoGq0aqNbcRNbIUnYyY4oDN7Y4ZE8b8jyF48DxaafLMKIitClTtEQcEFNCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWAWqf/Ei3Fj5gyx8nFYEz2lrYRudR7/nq90cXKlESk=;
 b=gNo6A2ccqV1d8or7J+bmt5dyk2F7j6a1GGVCHC97vMnS3oUwgydlY8JA9bI1Qc7c2Z5WEMN12bsMAVDXVIT2Ay2SDdniiftv5JjoRbExYWjuix7/kekXz4LxEbbA+65UOBVB8YIXVKox8YgDGX1HcPuCozN55gKSnrGD4c9ARCHl8nNQR/5CI5JbkQXYT5Fyk558NYeSmtt7WTaFmRDdl53s5aAhBfuHohu9ziclOsYhT3eorUPhYpHgRbk9p9QBE18wB0OlBY1xrn1NQLSynFwTx/A0vruaiof5WvVR3kinx2eNm2d0TRw8auyt+Hvf9TPUAnjk9uODJnRJbCILcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWAWqf/Ei3Fj5gyx8nFYEz2lrYRudR7/nq90cXKlESk=;
 b=uqU5YTufFuT8lZEI8q3DUtTRvIHkNDPyXN97/m1HW7wI2VHOuqTfAnfdzoZMTkEywm5JC/udCWaHi5inYZkmYCdCzLrKjP/JEsL47fx0RXZCzpshKpK3J0ToJNc32gc8/ixqFbKLcuOHVqZZ+mY5TOqiZHMlWpvwuP5vpuqRXeM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ2PR10MB7058.namprd10.prod.outlook.com (2603:10b6:a03:4c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Thu, 13 Apr
 2023 23:15:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::12d3:3f71:5b55:c342%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 23:15:03 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [RFC PATCH 3/4] mm/hugetlbfs: remove huge_page_shift in hugetlbfs_file_mmap
Date:   Thu, 13 Apr 2023 16:14:51 -0700
Message-Id: <20230413231452.84529-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
References: <20230413231452.84529-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ2PR10MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf7892f-e418-4a0c-84ef-08db3c74e942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ft7Q9VNN4CuRV2Yg0feXbICi3Dk2njvd58Tpia48t/RIARVTji1dHoYShTCjBbDIqVa+uNdhONI8O+Roa025A0kM3igt6J0gA66xhSGrkCS1ZgLhx3SnlrdNGBHxHpTtO0i4anIjSbw6bXRYDx6YL2FJNNViXVHte3G+fpuoBMUmSTUufSrblI+gbVgt9zNk6GeIFh0cfk3o3ywpIabFP5YNxjNQfFGKx7egS0LtOMf8jtFxm03+RVm+rk1MR7dnL/NohO31syEEJi//jJkuYbBN0vUeCu7bs7e8gtCp0g5eVQmdHHQ4iSuPRKFqMV6iyp+pRHK8QIJULJB24JNVvGkkBpkLp/CMF1xfUhlo4zkq/d5+h+qzy+84gfDlwzGWBRgeMwU2UqXfC95MNXtPmFvqFMfiwe7l2J6Hl7tcz1/7pq08V0fe30S+6oM3W33nUTsU0fW1eekRBPDOH1TjMaXUHhIqgd6FhmPVeYK0/+7dPBNvD7Adz1sZNkU0SbIeDaWKbX1NesmpqCs2pqsw2/aHKq4APzTUYIxJXITOEbRWIDc1SxAQ0YVwbqutlqV7u/07s2KVWYN2opvYTccQ8MwB6G9HLv80jLxauNoq3r4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(83380400001)(2616005)(6512007)(6666004)(1076003)(478600001)(6506007)(107886003)(6486002)(186003)(44832011)(36756003)(38100700002)(5660300002)(4326008)(66556008)(66946007)(66476007)(8676002)(316002)(86362001)(41300700001)(8936002)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQ+ytWDpVxXiuYHL66opYg0wPYSzop7viMdSsUmNd2KRqsEz5kOyXMgjRZf3?=
 =?us-ascii?Q?FsHfgMTC3jfvG3fPrnZUU80qId07LCLt1OJNcMzduZB0NJ3wCrJTEeFVrIl1?=
 =?us-ascii?Q?Pyv+HnP7p5uO4iUJ3vln78XngzjoGY6+z24bIpnsZhDZOcLvYVXwvGkweeNV?=
 =?us-ascii?Q?k9VT8WydNvHKq07RUsVxo0WlwieL9HKGgEuy9EDyurXqqjl/xwgm7sq4lHW2?=
 =?us-ascii?Q?UamMkGpHhUUVuYxCuAlD5EJ02cZgFbEnRRPsK0iWW8q96t4EIv9gf5NAU9on?=
 =?us-ascii?Q?rtSMU+RHj3R/4NJIQjnPYvCByDOEt5Rqey0tlm6P9PIU+zbIm0y/7ldxafUR?=
 =?us-ascii?Q?oHrfB4KxEk4lau7V8ol/9kA3q6akLv7JN7aquS13bJ+aEhaucZ4UikeL/grE?=
 =?us-ascii?Q?vciecK87w+5w0PZUscv6rKRZG/QTtevWb3FfWqq3Wqmx0/xLO2K4hfIg/2Ir?=
 =?us-ascii?Q?16Q1yNoWg29wTj9LZJT6AXnj+8xOlK5eBbm7RdnKA192YqWK0COTH9yeBdVr?=
 =?us-ascii?Q?EkRO9dHkxjDRKy+9NVbysQDeIm0ymWirKglOKfRxnH4a9q0KZkjmmJP2LxhA?=
 =?us-ascii?Q?LzVcDOd5Bse9DYkIaWf8feavFJpcmhyHsne3gLnGK/Q5jpEAUl/Ywevakv/G?=
 =?us-ascii?Q?VuTQoMKgThW4AUf1ApB1wbvhD9T/7w6K1nuhn39cyuUU7CBYJOtAW+x6jWPS?=
 =?us-ascii?Q?o1rNEp20GJpVrBeeMSOgBB6wrsaRX9FBWAA7Kcc96zfB1cx/ICaYg7FYY9Kj?=
 =?us-ascii?Q?6FvDEf6Yf7tawwt5YDKH/u/zyMawdl5qXyOWnaow4FIAQI1e9sHAyyt4ePLq?=
 =?us-ascii?Q?BAN3rY7gzjuvzNR/IVBA+Bl/nYPWB141Wsp1EKLwJ3zVs1iOCfE+g355Irhf?=
 =?us-ascii?Q?cVq2uxZqMgwNUcy4KwVp9cnsmIhfsWYGZgImpb8IxU4dhwmmHSYZm6iNQBPm?=
 =?us-ascii?Q?GlIRo8z2JAIo6AycCJTkQ9DyaEZQNg33U4zrnwKToiW2HX9XY37OIwF4Rfyv?=
 =?us-ascii?Q?N0+a3Lr97iFmLRKxX62dD7IKtC+6g7hDmFC4Xz0RehcNg2CvcGK/oIe+QlDr?=
 =?us-ascii?Q?kq5fAkfHuqG9oWxOnpsmAHJlKtc6gFLrixoj+2HGZst4VnhxmQyLH1GmlIVP?=
 =?us-ascii?Q?riHs2u0HT6nGNHZy/ThzkxTzC0pnSUj8A20NO+UWbrduAvhXlBgXgpz4Z48A?=
 =?us-ascii?Q?RnuQYHTbx+1CMDLbho9niVW2AuFOT1kyLDU+wwjLXn1HA3Hz7Z+I30SzoMst?=
 =?us-ascii?Q?1AlgdWVsTel5D/eZP1xID5IpStgg/7XronYPhNsEhp+Mo4kC+D0kC/cdtz6K?=
 =?us-ascii?Q?f2Jke93sijt7v9jwqJ6ULfIoLAqRFxkkGKgXcP0LZfPZCiaV3tPnFHiZq436?=
 =?us-ascii?Q?ei9fJMlgro04eJdpkKz42xkI+IM/KDRfbTBi1IHQadoQ3QdIs7c+bLdl84Vb?=
 =?us-ascii?Q?5b6j59066ya20EJoI4PoYBTUSyi9iwuez/unqi4FocvyAk2j/gEPd9JZlkRI?=
 =?us-ascii?Q?tCXnXapqsMohgasgnfRx7tD+H/VitqVVDhhSQO3blRY9UdTxJK0WxUPK8xBi?=
 =?us-ascii?Q?c39j6ehWemJ4wju+hXfYpYTiQIsZQBXjI5L1WTllqCuGwq8QUcHRiSXrb2Ck?=
 =?us-ascii?Q?fNn5BjJKmepjet/4dYf6d6U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +FlBMkAOwUNyXovwUkkRKJQpFyrbECUFu18m1tOr1ZNRaJx85XB582gvRh7zlVv1qKAnh7s+iE6BaabdhG8/UE8LjnXu0meDGeJzQru1iRh0usFBtQAB+Zj7yhMrkLg6m0BfRKN504Dnnlr4jVezdcFhDv5BNE5GqSL7aRPCCGTCIpnn0kZ+RV4psTqlmTnJi9E3VC/W6rfnIl9ojmrRSA3+hFvTVlZ5tMZzWvb+MeqtKr3k2gtDo+KS1hrR2YeMHeD7Qg0bK8VkYf0LYJscBBiQcRR65jDznAJcpTgrMdgP/gfIyzMSNyuLqWWqKc52XkrkJyp8AW56v42dVgVeoxiCV3JvwGKylznl+lfclvmmkNyTYlwK0AdI9WBXf7WvnjpvMimwCQWh774NNBk/lKI1nWVATLNWb5CxLzSj2UU7ASa3k8MYf/8yBdzgOvWQzAKrSajnS6W3fZP3smVAbSxwhk4siJW+eQqM6qLzZ+WpRfaJCkaLbK2XzvYzcFRkYKT38SCIvJA92Nv1l3+eTUqbVw5EOpqmILQc0DuwiFDtFCwvi2OIdd505v4vO28pb8y7xwSyCJmsMeBWy87Q3qRBuNuP+Ff+ycAgBJfrgwunM7iwmjv7zgB0jJ6eUqJ3+Zyo5aVYNJxjYBSbm2egelES2aE6ryzdX1S9qXHhUYQvYHFIZsAqls1oC3VLXY2qLf21FxTYfdrag0urkGm5NlXU73G9uIGweAMXyLDm8d3narNpMVOW8ZORFp/WvdQPNfO2EecjkY3KFk2g+qJYt7yWKdaFWWhSNBc9fnhs8A0e2hWsjD8bRjifNr2/4ZIsWVrnG9be1n5rrRYdy4C07dodhiz7riimuSV5IwlYO4H1ElCZCdfzgEc2SnKSkJCLSBLZfTpGwGIQuMKWDybWPcNqQxmyQOLASnOiLnseKIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf7892f-e418-4a0c-84ef-08db3c74e942
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 23:15:03.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Rq9LQ6h9sTjvE6awaoRWwa03U3iAeca2fSwzi/vZYclS3NgJeohBiUHNaIJ4qGlOjfkvFzjDYmiXBKlygwOtF7NuIhgkKbikpo7hODvcjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7058
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130207
X-Proofpoint-GUID: oTJEq6S9dbV-oLmX7WngSRhbdy9gbx2z
X-Proofpoint-ORIG-GUID: oTJEq6S9dbV-oLmX7WngSRhbdy9gbx2z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove shifting the vma->vm_pgoff and len arguments in
the call to hugetlb_reserve_pages() within hugetlbfs_file_mmap().
Adjust the chg variable within hugetlb_reserve_pages() to match previous
values which are expected by cgroup accounting code.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 mm/hugetlb.c         | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 702d79639c0df..9f2e71f2e9f52 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -165,8 +165,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	ret = -ENOMEM;
 	if (!hugetlb_reserve_pages(inode,
-				vma->vm_pgoff >> huge_page_order(h),
-				len >> huge_page_shift(h), vma,
+				vma->vm_pgoff,
+				len, vma,
 				vma->vm_flags))
 		goto out;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 011020a30f4ac..a28fbdff886ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6752,6 +6752,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 {
 	long chg = -1, add = -1;
 	struct hstate *h = hstate_inode(inode);
+	unsigned long hpage_shift = huge_page_shift(h);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
@@ -6791,14 +6792,14 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		 */
 		resv_map = inode_resv_map(inode);
 
-		chg = region_chg(resv_map, from, to, &regions_needed);
+		chg = region_chg(resv_map, from, to, &regions_needed) >> hpage_shift;
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
 			goto out_err;
 
-		chg = to - from;
+		chg = (to - from) >> hpage_shift;
 
 		set_vma_resv_map(vma, resv_map);
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
@@ -6823,7 +6824,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	 * the subpool has a minimum size, there may be some global
 	 * reservations already in place (gbl_reserve).
 	 */
-	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
+	gbl_reserve = hugepage_subpool_get_pages(spool, chg) >> hpage_shift;
 	if (gbl_reserve < 0)
 		goto out_uncharge_cgroup;
 
-- 
2.39.2

