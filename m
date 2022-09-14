Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273505B9078
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiINWTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiINWTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F115D86C37
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMIml5014889;
        Wed, 14 Sep 2022 22:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qcAxmGJ/kx4xobBtSUuE0kBJ49vUn3mtf24AnfwZG6g=;
 b=K8sBhoI/A2A36R0sZzVz2jIda/5acJfAQ/pCbG2Q9H0Uxft5w4bLAGHuR1uH3fAI9mCN
 UZE7jv/DGfV22AM01mrqiya/Rw1CJbkQ3LDKy+RK3DXP44fuN1an7wIjxFL6frIHNAi7
 XUlrsHMF4tnj/TiNGbGw6AnnKHnoGIf67VULqaV0NWeIscENf4TbN9kxEHvLXeQDMzVh
 7drImZl/9O3C88WfJDlsh9S3LdL0m9sPPDGRHeBmzOydCO4Sc17mX3uox53aZWWv7uiY
 c7ZGX6WeF1NFhFFbAi3kfmr5aHCC/uEeZKhwGNb8WNom4nJMjGKscNJQcwukOT/kW7M6 xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr3shy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EJAjla035442;
        Wed, 14 Sep 2022 22:18:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym095mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTPkg1VbFtBtOvowUuoiLIJ4o52U5O3DffB60FGh01wJZJuI5kkb8Yc0vwV3prdTDQ35DdaImPIhEw1cOK4evu0T+xp4djVaZ0RbApSEtCmryy3fkJDJTIhDI8/tFuXDPAetJVunF4sdqW8kx79eAuLnGLfjFHfrrEQJygviTXJD7LHy7e9M1cFoDT2m4/J8eZqBJ9YDjYOIuQZyP2t0JWc5qTJZBaL5T3x4Okbw61t8bcimvLzU6P86VhjWe/zcYbzfki8jhMPKXp0JSl4fLnQWSrYqK1cK9M2uhVRz5RXB4LsXJCJ52EXTaS/nsopZnY6in8ZtZiuYwP/By7X/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcAxmGJ/kx4xobBtSUuE0kBJ49vUn3mtf24AnfwZG6g=;
 b=WH2ptc79/H+9gqWNo/Z8ItwtuZj81HFJ1BVf7jcZNrrnkipoqbVYgyr9WSsAfTdk4B/ZUUIwJRBGpXPBBwD+YNS29mDzzJBI7ThQDMhzA8zuaYSvO1xsLoaO7girrsJs3uv0SS9kk+pI8IW3TgA3sBe5YRqJKhjCcE4HRt6A1xsviC63j5aFXeVm8DdyvXA0Yvs23fU+DpL91ckpcPrcDbnbcycJDMJE3VuesdUX3V56yWJojM8mskxhRYb0rR/v+4OfHapoIR8wJ9qwUcl5R4BmOysXb3oysjY+ZYqY2Q5KZxwDyDvrj4alZwm8aJYIbH/3Vsa6NomlECfa4qRT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcAxmGJ/kx4xobBtSUuE0kBJ49vUn3mtf24AnfwZG6g=;
 b=SuLL9MI3xmSKZo5pEeWCqqfLOkREjxmKMUt1OkS0K363DfbT63iw8NHoU70OT2ou61hX3sSvHAUFkbfmH3iEiHjTbUNRM/Vr9JDGiAcGhfUuByBanJqUjh9bBjICF5sCLHsm+ZnOUJosNhgc2AXZRvzdX1z7hisMLxLI+shxuGw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4390.namprd10.prod.outlook.com (2603:10b6:610:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 22:18:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:37 +0000
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
Subject: [PATCH v2 8/9] hugetlb: use new vma_lock for pmd sharing synchronization
Date:   Wed, 14 Sep 2022 15:18:09 -0700
Message-Id: <20220914221810.95771-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 064c2c8f-7d6f-45a4-ba93-08da969f11ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4NRcuXUXb2IHGyaHEL5cHbegzmua74UKcx3S1OuwRK6hPPQkkhBxpB8ltUcBSSxa/uOyR1Dv9567+ClEa46eSJZO69QNru6Xp8yy3HNiBqRDfFzrQI7/9QxepQfxsrnHwvTr+tdd5xOmnO57KoPEAEllG48Owpi/dTmCIwW1UnVdwIcNsVDuZpmyH5Rp34oIRlEjo+KzuwX01TlQIKB3QNhPyQdv8AjeU3fBYNbpxneQfA1IfFQPruelKpJvfGxeBpgxMgNvFlXTZNHamtJocyzdmIZTUv4GJKb+3YsXhKGlwgWKUmPts/Gf9k8TiqG+Pd/+Bcp9xGoVvGJx76CyfAvIZcByq+G6zwm8tecjcCH0st5BH/QidR2FJ6Xx3HTERPobR8wSvd3//6emzLPkIkEyCsIrBl/hHgDiGnJ1tYDdLiFsgXP5P1DCHTEEUrsZ8VYdwhhCPXPzNVpHKKsBFwW7635quu0R70gNovSBtgs6f9edcK1xSmM8ft1WmI6DKucKCXx8+CgaoCvQFGW5UgNJWnfmath1YMm2EAWsDq24jiyX0hKKZAAp3Hu34ij2rxwblGRqqcMZoPxpPCbWuAiXvbYD6KWcfQjLmjZ2YwGBDDApIIcxuN2TZCNfqEyiH5de9atS5FoD618FzaYwZLgbNabrvgpfkAzJ62eA3KYJ3G6R+Un+1EW6d9bMqyztz3DNj9aqvJcVWEQYWN2VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6512007)(7416002)(6666004)(86362001)(66556008)(36756003)(8676002)(107886003)(83380400001)(6486002)(66946007)(54906003)(30864003)(44832011)(66476007)(8936002)(5660300002)(316002)(41300700001)(6506007)(478600001)(186003)(2906002)(38100700002)(26005)(4326008)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qlg2DX4u8ZWJOGcQr0JXQwTqXzdNssr3GDFpFuRoSlY49MDnLceUVRvRmERT?=
 =?us-ascii?Q?0+pmCHlorLhoAd32LJM62r185prNK3FzyyaYODb1drlmXDRPKarxRy65Yu/E?=
 =?us-ascii?Q?s4gdTQ47YBg7mRlpla8+dhmAJCZxxy/CncaRH/L40qfR5v3dcm0EcCZk8xw3?=
 =?us-ascii?Q?QQ3EdKOKjcLWBNzMQ41gLX6fiUXn71omHSL3g6cp28ibYd76587cRvQtKyjt?=
 =?us-ascii?Q?1qNIRg8ku6v6IooYWQZAEwJb96N+Xnwm1nnTMr2eTrbyCuiQdzFCgAXX1Tt3?=
 =?us-ascii?Q?/H4GCX7mXUJORgdAQuM7TI3nEE0/mALauJs2iRZu+mgyLk55S+p8XBBClajm?=
 =?us-ascii?Q?KbWy/tK0TmOgxeH4I0itxPI1qQi3f/83cKOg8Vp0cLaTVW/HCSJ/r212DDaR?=
 =?us-ascii?Q?5V+j6j23c2KZYLDqBc83WbU8YW1WC8E9irEtFcGAjW0YJX43XxRwWdYoUXCy?=
 =?us-ascii?Q?5UPLk01wsbSUqllxTS54F1RXjUsx7r+gpRujYkDdd+7ZQsXl+5LbM1YbNKZG?=
 =?us-ascii?Q?5LLOpWpxRJZTrE0TepbVAXG3RPRVV3gqeQBqGgrOpQtWI6j+BUFVTzkn/OM9?=
 =?us-ascii?Q?m+66IaQjRuESYRgs1dJt5JQbT0aYje5pemtGGBLwACef/1TcQK9We9Uvc9Mn?=
 =?us-ascii?Q?GW05qYdeCO8bPP5okuNxrPwW6dYowq2vAcj1yOV+WmDB9GkL5choLfrhm84v?=
 =?us-ascii?Q?F4JDtriw9T0DuJ+SljooukY8yum18jttU9Bzf95jerMlZ7ZlxnGYiBdE5YY+?=
 =?us-ascii?Q?WVRlmzwNAq+CYYriXlU7+AiOzFLR/oX0THOehVM7i/6JpfPPtUjMB8zReTP5?=
 =?us-ascii?Q?Q8FXAEYDYmSwH18aXeBoo93iI8eZ30zz75vpAYBN/jIxUIL1HHx2PsA9I8C9?=
 =?us-ascii?Q?7MQCkgDLUjSPv1SP+G1EktMutCBmSyN/vpBppQX8H4yIVpIxkYvaXuAvVvdg?=
 =?us-ascii?Q?Bq7r4bpu0U2PHtrlSyrh5yEAHOb5C5wTIu2VVtUmHab4ci8DJ8NT3PNfUJMM?=
 =?us-ascii?Q?fg4EGj7rcYOAPZwpZKvwUjRDmZ2I/gb5mHah4YC/0OQDXC/1PEDElp11/YKc?=
 =?us-ascii?Q?O4iCdlcJaIrAMiXbUNPsBRPnB1qms7qymSWeavtSn9fLWJsbV81d0YUqjFSj?=
 =?us-ascii?Q?tBy60sS0Auq9gwWDN1kqmMz7hmu31B5Y4jtFCO+IGmq6f2yBdPPaqoYMquGK?=
 =?us-ascii?Q?SvcMwGQ+dfyxuT85Mho7WS3Wd4pevwHSFmhWNsqlM2/hLr2WlFLsAc6MiaER?=
 =?us-ascii?Q?Se+i+EQGs6F8jAsvPEisY6Qk8MsybBJ8U4PN7Y/Hb2JN+ZZXoMXrQstT/IJJ?=
 =?us-ascii?Q?7kmrcEN86qjixLDirpMg2SxIRDC/ADf50TtgYJtQZJAjuonqIQMtSJQ/bWQD?=
 =?us-ascii?Q?TuCN6msESqRzqIs0vrpQF+Pc6qHgNP3hKWtSEZM+Ats98AaCrfZZololL+O2?=
 =?us-ascii?Q?hYADTXTFTab/yvxmdQcWqMDgulQQc1vrzdrnFYjNWlqwavUyqBGQC4d1B6Fn?=
 =?us-ascii?Q?j87no2EnJDzjV06QH1bRVHg5eC8K5zHbjazPIsdFgoOxn9vJlA11aSJ1p+og?=
 =?us-ascii?Q?9iYXUHrXbJQzP4eUjTs32+VAptFbnr25qf/MXGiQhEi5EVS+3WmWZc7sCwYC?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c2c8f-7d6f-45a4-ba93-08da969f11ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:36.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh6G3RK8F5rSPr8UqkM5iYqyURrjVg9cLF5F2Lh6F1+WFt/5Fkxfg3Z4PgiiEGQqyns4wzC01qw7d16TP3kKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-GUID: 1mm892UOSCJjKI1Q_BlwJwWFsjY6DIb7
X-Proofpoint-ORIG-GUID: 1mm892UOSCJjKI1Q_BlwJwWFsjY6DIb7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hugetlb vma lock is used to address this race:

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...

The vma_lock is used as follows:
- During fault processing. The lock is acquired in read mode before
  doing a page table lock and allocation (huge_pte_alloc).  The lock is
  held until code is finished with the page table entry (ptep).
- The lock must be held in write mode whenever huge_pmd_unshare is
  called.

Lock ordering issues come into play when unmapping a page from all
vmas mapping the page.  The i_mmap_rwsem must be held to search for the
vmas, and the vma lock must be held before calling unmap which will
call huge_pmd_unshare.  This is done today in:
- try_to_migrate_one and try_to_unmap_ for page migration and memory
  error handling.  In these routines we 'try' to obtain the vma lock and
  fail to unmap if unsuccessful.  Calling routines already deal with the
  failure of unmapping.
- hugetlb_vmdelete_list for truncation and hole punch.  This routine
  also tries to acquire the vma lock.  If it fails, it skips the
  unmapping.  However, we can not have file truncation or hole punch
  fail because of contention.  After hugetlb_vmdelete_list, truncation
  and hole punch call remove_inode_hugepages.  remove_inode_hugepages
  checks for mapped pages and call hugetlb_unmap_file_page to unmap them.
  hugetlb_unmap_file_page is designed to drop locks and reacquire in the
  correct order to guarantee unmap success.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c |  66 +++++++++++++++++++++++++++-
 mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
 mm/memory.c          |   2 +
 mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
 mm/userfaultfd.c     |   9 +++-
 5 files changed, 233 insertions(+), 46 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3bb1772fce2f..009ae539b9b2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -434,6 +434,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 					struct folio *folio, pgoff_t index)
 {
 	struct rb_root_cached *root = &mapping->i_mmap;
+	struct hugetlb_vma_lock *vma_lock;
 	struct page *page = &folio->page;
 	struct vm_area_struct *vma;
 	unsigned long v_start;
@@ -444,7 +445,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 	end = (index + 1) * pages_per_huge_page(h);
 
 	i_mmap_lock_write(mapping);
-
+retry:
+	vma_lock = NULL;
 	vma_interval_tree_foreach(vma, root, start, end - 1) {
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
@@ -452,11 +454,63 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
 			continue;
 
+		if (!hugetlb_vma_trylock_write(vma)) {
+			vma_lock = vma->vm_private_data;
+			/*
+			 * If we can not get vma lock, we need to drop
+			 * immap_sema and take locks in order.  First,
+			 * take a ref on the vma_lock structure so that
+			 * we can be guaranteed it will not go away when
+			 * dropping immap_sema.
+			 */
+			kref_get(&vma_lock->refs);
+			break;
+		}
+
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				NULL, ZAP_FLAG_DROP_MARKER);
+		hugetlb_vma_unlock_write(vma);
 	}
 
 	i_mmap_unlock_write(mapping);
+
+	if (vma_lock) {
+		/*
+		 * Wait on vma_lock.  We know it is still valid as we have
+		 * a reference.  We must 'open code' vma locking as we do
+		 * not know if vma_lock is still attached to vma.
+		 */
+		down_write(&vma_lock->rw_sema);
+		i_mmap_lock_write(mapping);
+
+		vma = vma_lock->vma;
+		if (!vma) {
+			/*
+			 * If lock is no longer attached to vma, then just
+			 * unlock, drop our reference and retry looking for
+			 * other vmas.
+			 */
+			up_write(&vma_lock->rw_sema);
+			kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+			goto retry;
+		}
+
+		/*
+		 * vma_lock is still attached to vma.  Check to see if vma
+		 * still maps page and if so, unmap.
+		 */
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+			unmap_hugepage_range(vma, vma->vm_start + v_start,
+						v_end, NULL,
+						ZAP_FLAG_DROP_MARKER);
+
+		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+		hugetlb_vma_unlock_write(vma);
+
+		goto retry;
+	}
 }
 
 static void
@@ -474,11 +528,21 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		unsigned long v_start;
 		unsigned long v_end;
 
+		if (!hugetlb_vma_trylock_write(vma))
+			continue;
+
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
 		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				     NULL, zap_flags);
+
+		/*
+		 * Note that vma lock only exists for shared/non-private
+		 * vmas.  Therefore, lock is not held when calling
+		 * unmap_hugepage_range for private vmas.
+		 */
+		hugetlb_vma_unlock_write(vma);
 	}
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 616be891b798..e8cbc0f7cdaa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4795,6 +4795,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
+	} else {
+		/*
+		 * For shared mappings the vma lock must be held before
+		 * calling huge_pte_offset in the src vma. Otherwise, the
+		 * returned ptep could go away if part of a shared pmd and
+		 * another thread calls huge_pmd_unshare.
+		 */
+		hugetlb_vma_lock_read(src_vma);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
@@ -4941,6 +4949,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
+	} else {
+		hugetlb_vma_unlock_read(src_vma);
 	}
 
 	return ret;
@@ -4999,6 +5009,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	/* Prevent race with file truncation */
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		src_pte = huge_pte_offset(mm, old_addr, sz);
@@ -5030,6 +5041,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		flush_tlb_range(vma, old_end - len, old_end);
 	mmu_notifier_invalidate_range_end(&range);
 	i_mmap_unlock_write(mapping);
+	hugetlb_vma_unlock_write(vma);
 
 	return len + old_addr - old_end;
 }
@@ -5349,8 +5361,29 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
+			struct address_space *mapping = vma->vm_file->f_mapping;
+			pgoff_t idx;
+			u32 hash;
+
 			put_page(old_page);
+			/*
+			 * Drop hugetlb_fault_mutex and vma_lock before
+			 * unmapping.  unmapping needs to hold vma_lock
+			 * in write mode.  Dropping vma_lock in read mode
+			 * here is OK as COW mappings do not interact with
+			 * PMD sharing.
+			 *
+			 * Reacquire both after unmap operation.
+			 */
+			idx = vma_hugecache_offset(h, vma, haddr);
+			hash = hugetlb_fault_mutex_hash(mapping, idx);
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+
 			unmap_ref_private(mm, vma, old_page, haddr);
+
+			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5499,14 +5532,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	};
 
 	/*
-	 * hugetlb_fault_mutex and i_mmap_rwsem must be
+	 * vma_lock and hugetlb_fault_mutex must be
 	 * dropped before handling userfault.  Reacquire
 	 * after handling fault to make calling code simpler.
 	 */
+	hugetlb_vma_unlock_read(vma);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	ret = handle_userfault(&vmf, reason);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
+	hugetlb_vma_lock_read(vma);
 
 	return ret;
 }
@@ -5740,6 +5775,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
+		/*
+		 * Since we hold no locks, ptep could be stale.  That is
+		 * OK as we are only making decisions based on content and
+		 * not actually modifying content here.
+		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5747,23 +5787,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
-	} else {
-		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-		if (!ptep)
-			return VM_FAULT_OOM;
 	}
 
-	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
+	mapping = vma->vm_file->f_mapping;
+	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
+	/*
+	 * Acquire vma lock before calling huge_pte_alloc and hold
+	 * until finished with ptep.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the ptep no longer valid.
+	 *
+	 * ptep could have already be assigned via huge_pte_offset.  That
+	 * is OK, as huge_pte_alloc will return the same value unless
+	 * something has changed.
+	 */
+	hugetlb_vma_lock_read(vma);
+	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+	if (!ptep) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		return VM_FAULT_OOM;
+	}
+
 	entry = huge_ptep_get(ptep);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry)) {
@@ -5824,6 +5876,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unlock_page(pagecache_page);
 			put_page(pagecache_page);
 		}
+		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
@@ -5867,6 +5920,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		put_page(pagecache_page);
 	}
 out_mutex:
+	hugetlb_vma_unlock_read(vma);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
@@ -6329,8 +6383,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	flush_cache_range(vma, range.start, range.end);
 
 	mmu_notifier_invalidate_range_start(&range);
-	last_addr_mask = hugetlb_mask_last_page(h);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
+	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
 		ptep = huge_pte_offset(mm, address, psize);
@@ -6429,6 +6484,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	 * See Documentation/mm/mmu_notifier.rst
 	 */
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_unlock_write(vma);
 	mmu_notifier_invalidate_range_end(&range);
 
 	return pages << h->order;
@@ -6930,6 +6986,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	BUG_ON(page_count(virt_to_page(ptep)) == 0);
 	if (page_count(virt_to_page(ptep)) == 1)
 		return 0;
@@ -6941,6 +6998,31 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	return 1;
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 }
@@ -7318,6 +7400,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				start, end);
 	mmu_notifier_invalidate_range_start(&range);
+	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
 		ptep = huge_pte_offset(mm, address, sz);
@@ -7329,6 +7412,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	}
 	flush_hugetlb_tlb_range(vma, start, end);
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_unlock_write(vma);
 	/*
 	 * No need to call mmu_notifier_invalidate_range(), see
 	 * Documentation/mm/mmu_notifier.rst.
diff --git a/mm/memory.c b/mm/memory.c
index c4c3c2fd4f45..118e5f023597 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1685,10 +1685,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
+				hugetlb_vma_lock_write(vma);
 				i_mmap_lock_write(vma->vm_file->f_mapping);
 				__unmap_hugepage_range_final(tlb, vma, start, end,
 							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
+				hugetlb_vma_unlock_write(vma);
 			}
 		} else
 			unmap_page_range(tlb, vma, start, end, details);
diff --git a/mm/rmap.c b/mm/rmap.c
index 744faaef0489..2ec925e5fa6a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1554,24 +1554,39 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and fail
+			 * if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
@@ -1929,26 +1944,41 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * To call huge_pmd_unshare, i_mmap_rwsem must be
 			 * held in write mode.  Caller needs to explicitly
 			 * do this outside rmap routines.
+			 *
+			 * We also must hold hugetlb vma_lock in write mode.
+			 * Lock order dictates acquiring vma_lock BEFORE
+			 * i_mmap_rwsem.  We can only try lock here and
+			 * fail if unsuccessful.
 			 */
-			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
-			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
-				flush_tlb_range(vma, range.start, range.end);
-				mmu_notifier_invalidate_range(mm, range.start,
-							      range.end);
-
-				/*
-				 * The ref count of the PMD page was dropped
-				 * which is part of the way map counting
-				 * is done for shared PMDs.  Return 'true'
-				 * here.  When there is no other sharing,
-				 * huge_pmd_unshare returns false and we will
-				 * unmap the actual page and drop map count
-				 * to zero.
-				 */
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+			if (!anon) {
+				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
+				if (!hugetlb_vma_trylock_write(vma)) {
+					page_vma_mapped_walk_done(&pvmw);
+					ret = false;
+					break;
+				}
+				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
+					hugetlb_vma_unlock_write(vma);
+					flush_tlb_range(vma,
+						range.start, range.end);
+					mmu_notifier_invalidate_range(mm,
+						range.start, range.end);
+
+					/*
+					 * The ref count of the PMD page was
+					 * dropped which is part of the way map
+					 * counting is done for shared PMDs.
+					 * Return 'true' here.  When there is
+					 * no other sharing, huge_pmd_unshare
+					 * returns false and we will unmap the
+					 * actual page and drop map count
+					 * to zero.
+					 */
+					page_vma_mapped_walk_done(&pvmw);
+					break;
+				}
+				hugetlb_vma_unlock_write(vma);
 			}
-
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0fdbd2c05587..e24e8a47ce8a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -379,16 +379,21 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via hugetlb_fault_mutex.
+		 * Serialize via vma_lock and hugetlb_fault_mutex.
+		 * vma_lock ensures the dst_pte remains valid even
+		 * in the case of shared pmds.  fault mutex prevents
+		 * races with other faulting threads.
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		hugetlb_vma_lock_read(dst_vma);
 
 		err = -ENOMEM;
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -396,6 +401,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
+			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			goto out_unlock;
 		}
@@ -404,6 +410,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       dst_addr, src_addr, mode, &page,
 					       wp_copy);
 
+		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
 		cond_resched();
-- 
2.37.2

