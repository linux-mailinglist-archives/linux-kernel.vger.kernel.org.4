Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A495B907A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiINWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiINWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21786C15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EM9o1x004934;
        Wed, 14 Sep 2022 22:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Qv/NQPpFdTbOef+QCh3XKlQ9j1lu0LB1XJ6P0Mxj338=;
 b=ohwo0sPRvDfc3LkIPVpwGPcDgo5E2ZlrGrWVLhNNEBf+khYjHOw3FrkJYnJpONkIyuM3
 0l5lVqVOFL2Qf8r7fbUuIUszNcpnWcRU07ZM9SY4Dzkprw/GPFeV2TTr5bfSwHC2aMh8
 a4/JwoZaHJOCzruZB8Fyq8n5fruLVgONNKODBy8LwsI76Q06H0uGWfah3ffzzfw/xdlH
 Cp9Ugxr/jq/X2zyBBofIR9i1HodTaiAK1wrEPZ1R+c6WqTcke2oErqb5mjz9iem7jgZG
 FKnC5e5c8we0VwKgQqACe6TEjXEwdWXOCIIRWH57zMCcDHOLQBFZxxpmLPqyAob3LGL7 qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypbmgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKGKKR035390;
        Wed, 14 Sep 2022 22:18:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym095jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqeyfE9+zDsHKAyjvySib8rFkH2Y6hdvbWZ291/jlbIpuK9WIcJu6dfjaO4akWNbggfwEsFm01/JXdwQd/NNORqxMihWp5NubCLXiPnNCDeugKIAptcaKvVaQUg8h/4n4KempW8Memdgrzw1dRq8D77w5now5WQ7C2XQdYl+c6k4AtQwWeVvv6Wi3/dQH5wVg4C9CD6MluR/B+iCTeHjEumSmiQ+4LqT4913v9qykSJEQcf1da60LdzbB2l2SdVuXNJEomV1GCDAmp0fE901jU3N7w6YtHeAa2fQhSFSApcbTjohLg64cPM5YzHzIUnbGaEO1F+r9GBQJJCKLNuZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv/NQPpFdTbOef+QCh3XKlQ9j1lu0LB1XJ6P0Mxj338=;
 b=lqaaWlBC1KTTjMte7lXR6tvnnNcvyE+ZKbZ76PoowpL+giGTg3407oafAW2KGAzA49oAYtxFd936ASuBUTxiwVmpa0TNb35FgCv9GzWQv24G38uC2dxRHh5VnHc1gWNJh6B5j56fV141ubTx3f9Hzryrq8iauUh7PGG1c3/OGudu0zsPvL8NXPUiLOkasXhFaq3DwGq7vVRtdU6NB61gQFhl33vs/jTH21GsssuZL+YIDxxRC4MdaNY5lxsZHOUqcTKg77etKpzspR6UP5e4M5RzDlaSXE8SH+ERaeak4RLRQKIeREpviapF0/e5BHcYouk/NkHN6cZFELH49FefLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv/NQPpFdTbOef+QCh3XKlQ9j1lu0LB1XJ6P0Mxj338=;
 b=ZQTVXYrEiMDfCjAwDVOBAnUtYmhFECU+bRiteRAlt4+qWXE5AZUHp9OddD2ykcX6F0d0HyThnoLDzTVuSrfM+/lLJXT3z5AwLXhNnNjP16vGzCIP47Z5NQgkVK75pZpeYelDatoSDh4xAxN4VH4WYr/tQ+CFqtwvInt86kMMrRs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 22:18:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:32 +0000
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
Subject: [PATCH v2 6/9] hugetlb: add vma based lock for pmd sharing
Date:   Wed, 14 Sep 2022 15:18:07 -0700
Message-Id: <20220914221810.95771-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: d9512851-c283-4b64-a786-08da969f0f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBSOHUDtQKEGj1DvthAIYyNzfvnqUjtofJWiMi1Qa+41QkkUlDWthfd04aHpNbZZgXY6VzRZ+hfIILGklSosrMx/VqvHpGTa0ku16JWEGo/+W96PsjeB3Pt+9YPLqhDYcum9ydREywIVMRahI9buQzKkfztyfmbTb/KlbXuHDfeaqjD5EwtAUrIynUCvSMzjJCLDu+ec6bkSAKrfis0GDZRtJv8nRPh2cihAQJFyfMHycOQApqS76mCA3nY557M2f72Sidn30f2ymYyrnLCAI3Gu3KG4RPl4yxNeGCu+CEAaL+272vcKuva6FzjJtcVVldcarCkXaja/wrb6+F6j1HVDLFlnzb6GxtRY4XVHZE9HiYOWcS0zG4a9E+4ezlUx+s03ZwatHrmTkp0XNZu99FEObzIDFHCP0yWq+uyBIphyX+Ott8RfTzxNiDn6UNvJZ+h/ZestEsHcDRgul4LJlbJ0i4DNVNe9bzryFCUW7BMVNGyRizXOQ8wndMme0VDOaBPYoHr0Un7f5XKewVOAV1g1K/LMAVY19GYo2krwPXunqTPYVvwTLnlMG5TVuhU5EKwdrWMeqjQEPpOpR/WoYOzLqEKNBadRgastskcLL8cbWjnFwj588UpL2RXzJKUQPyhYdJ1sRctAOWoOo327tbJ2o+q97SyMBmeG0uP782HrvGB9zw6xSkXq89spQLDdF2HxOuP4teEp3JUaktkc2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(38100700002)(54906003)(316002)(36756003)(6506007)(8676002)(4326008)(66946007)(83380400001)(186003)(2616005)(1076003)(5660300002)(41300700001)(107886003)(66476007)(66556008)(86362001)(8936002)(6666004)(6486002)(7416002)(2906002)(26005)(30864003)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQO5un1b747IiC7g6OG5JYowu0RhUsdKXct//tg/YMYRdT/mdMRGS3HLlKsz?=
 =?us-ascii?Q?3x9lJDBX3ZuohVtsTBJCAkOLnY+jVDyhFbMNqJuYVbK5L1MWQwHraZhaZ6Yf?=
 =?us-ascii?Q?AutdR7xngmcs7lUIKqj8xDtueUZYBz5SGk6mpGbczTqg72j4vbLFDayW7Tpu?=
 =?us-ascii?Q?hvuK3tnMTiOpIevLEFyJfjpkTxa3vY3oHC5LdE8a2TBRKH/4qiMjILNx/xUh?=
 =?us-ascii?Q?7NXGTySzzZvzNSlJB9Lf8QiOf/pqKZxCu8cjFcSe73FxSmuCukyZfmHYrQtR?=
 =?us-ascii?Q?ExuA9AloYKRZQCcfHfkgSyxih7ex5mdM+DXcm5PyhS+44VBQVTS0lreKV6JC?=
 =?us-ascii?Q?7VgP983gVQ3dRWiNMjMzERuRtCjsdB1XeUAzNnqjnun5RnIpF1I5Y3cEjP7B?=
 =?us-ascii?Q?YgD4TjpJs/mneG9pA7o6c1qKK9OyYoKq0q/kGA/o97evfVD5vYaXer6fNAby?=
 =?us-ascii?Q?9I3u56noxHq1GBePTCZIaxLvO9++C2a5w2yB7DsEi5YM1Y9X3Zc0KWeT+ESF?=
 =?us-ascii?Q?kYdvyDsh9L6oFHwOx7VH5jT/W/yioQ7KfwUfEUG2fsCS6YqCWF+jeRIhdHgI?=
 =?us-ascii?Q?UNlIWGpHTtmcZyQGOfFIf6cn3t5Z0p8zUnMGFvYpHeqgL8NvCqcIWsAiEn+M?=
 =?us-ascii?Q?HcCJRSFNkUsjYTM0aCzD5j0bMwNjubxrLOTKEEEjDOzYRoecrgDs4Hjzs8Gp?=
 =?us-ascii?Q?4rPiXal0FurhBm2BRrrWxAoBKjIMfw2T1mw3MzhNc6+tiVzQhTM1EygkvrOy?=
 =?us-ascii?Q?OcAD+89HFLyvMlEila1SnMf+mi4VzILEDemskRP4jwxihCaoTfVWBdbTijMB?=
 =?us-ascii?Q?+BbY8PoVHttYlRqnF4VbFtWqCftkEWnbCwRDtupDRqN3vqo7rfJq7dUsX8V4?=
 =?us-ascii?Q?A7Eoa9dQESSMd33p3J350K693q9s2cpdoFuga5VRg2mQ1JJHEZMkMsxpYdTd?=
 =?us-ascii?Q?znDYt8c4KgWeVLDwvref1Jc1ZXANxdf9iU2RDr0lyUBHuRXH0XxPABvErI/S?=
 =?us-ascii?Q?Gfh/3qDurXH/6J6OVlJ1rE6QF5a82sZ1vPXIkEwh4aLzSNiUBGF3qt9GIaJb?=
 =?us-ascii?Q?P9EsaTJ8iXHAK/CifFeGUi4DstIVpvQbIPZ10YXTJAdTkDXa4/WnYdirZDRy?=
 =?us-ascii?Q?s7OpKTwi5B8p3K5G+7DMUD4uQPaxB2N7pstnwzLrBmoeHc57yspZxbEvmu2h?=
 =?us-ascii?Q?9DWsUifnpGdWAFDo53PAbyZ0oOx2EcItnGPxckCNa1u8mF+ImutV2cJzIZkf?=
 =?us-ascii?Q?RyTmgN2njQ4DOd8l2P8huCIdxfQsoy0ifNMJOBqdWRP+xord2N568ccUx7s+?=
 =?us-ascii?Q?xasOAM3uOxI0xC5WVXLicIL4xTKtCpivgQnRKopnFp41ytTqBQ3ypj0EFJVi?=
 =?us-ascii?Q?yPT/QcmEj/sbC+fnj00wXG0vytKFK93BQM1N/PVDtR6yKXPdIigpR71qRkP1?=
 =?us-ascii?Q?06AWpb00e4nL2oaTflK94SWiUXhaq8lfvlZrQiZGndn16AnQYmyEi55ylBv+?=
 =?us-ascii?Q?niifOAlrhwyS5dmdAV6+PZ/wZEXuDJAVdckHPsE/op/eKJFaQ74nkB5ng3Lk?=
 =?us-ascii?Q?mSkKXuVinfafvFhWn7u7sEXXq8cehUScXW9rfIlMwUsvEInq2opI0uZ8qu4F?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9512851-c283-4b64-a786-08da969f0f25
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:32.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vi7q5mpDObA1xUfYTqoVJuf5OV0npv5x4GbDvDY2qemtmPVIAvY2qwnhTdrcO2CENwuparx6RTcgVlDa4PO1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: XxWoKxguxz7mDk4owwO2p38FnMNla3FA
X-Proofpoint-GUID: XxWoKxguxz7mDk4owwO2p38FnMNla3FA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a new hugetlb_vma_lock structure and hang off vm_private_data
for synchronization use by vmas that could be involved in pmd sharing.
This data structure contains a rw semaphore that is the primary tool
used for synchronization.

This new structure is ref counted, so that it can exist when NOT attached
to a vma.  This is only helpful in resolving lock ordering issues where
code may need to obtain the vma_lock while there are no guarantees the
vma may go away.  By obtaining a ref on the structure, it can be
guaranteed that at least the rw semaphore will not go away.

Only add infrastructure for the new lock here.  Actual use will be added
in subsequent patches.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  43 ++++++++-
 kernel/fork.c           |   6 +-
 mm/hugetlb.c            | 202 ++++++++++++++++++++++++++++++++++++----
 mm/rmap.c               |   8 +-
 4 files changed, 235 insertions(+), 24 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0ce916d1afca..6a1bd172f943 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -114,6 +114,12 @@ struct file_region {
 #endif
 };
 
+struct hugetlb_vma_lock {
+	struct kref refs;
+	struct rw_semaphore rw_sema;
+	struct vm_area_struct *vma;
+};
+
 extern struct resv_map *resv_map_alloc(void);
 void resv_map_release(struct kref *ref);
 
@@ -126,7 +132,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
+void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
 int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
@@ -214,6 +220,14 @@ struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
 struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 			     pgd_t *pgd, int flags);
 
+void hugetlb_vma_lock_read(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
+void hugetlb_vma_lock_write(struct vm_area_struct *vma);
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma);
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
+void hugetlb_vma_lock_release(struct kref *kref);
+
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
@@ -225,7 +239,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
-static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 }
 
@@ -336,6 +350,31 @@ static inline int prepare_hugepage_range(struct file *file,
 	return -EINVAL;
 }
 
+static inline void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+}
+
+static inline void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+}
+
+static inline int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	return 1;
+}
+
+static inline void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+}
+
 static inline int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index b3399184706c..e85e923537a2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -677,12 +677,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		}
 
 		/*
-		 * Clear hugetlb-related page reserves for children. This only
-		 * affects MAP_PRIVATE mappings. Faults generated by the child
-		 * are not guaranteed to succeed, even if read-only
+		 * Copy/update hugetlb private vma information.
 		 */
 		if (is_vm_hugetlb_page(tmp))
-			reset_vma_resv_huge_pages(tmp);
+			hugetlb_dup_vma_private(tmp);
 
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8117bc299c46..616be891b798 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -90,6 +90,8 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -858,7 +860,7 @@ __weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
  * faults in a MAP_PRIVATE mapping. Only the process that called mmap()
  * is guaranteed to have their future faults succeed.
  *
- * With the exception of reset_vma_resv_huge_pages() which is called at fork(),
+ * With the exception of hugetlb_dup_vma_private() which is called at fork(),
  * the reserve counters are updated with the hugetlb_lock held. It is safe
  * to reset the VMA at fork() time as it is not in use yet and there is no
  * chance of the global counters getting corrupted as a result of the values.
@@ -1005,12 +1007,20 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
-/* Reset counters to 0 and clear all HPAGE_RESV_* flags */
-void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
+void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 {
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
+	/*
+	 * Clear vm_private_data
+	 * - For MAP_PRIVATE mappings, this is the reserve map which does
+	 *   not apply to children.  Faults generated by the children are
+	 *   not guaranteed to succeed, even if read-only.
+	 * - For shared mappings this is a per-vma semaphore that may be
+	 *   allocated in a subsequent call to hugetlb_vm_op_open.
+	 */
+	vma->vm_private_data = (void *)0;
 	if (!(vma->vm_flags & VM_MAYSHARE))
-		vma->vm_private_data = (void *)0;
+		return;
 }
 
 /*
@@ -1041,7 +1051,7 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 		kref_put(&reservations->refs, resv_map_release);
 	}
 
-	reset_vma_resv_huge_pages(vma);
+	hugetlb_dup_vma_private(vma);
 }
 
 /* Returns true if the VMA has associated reserve pages */
@@ -4622,16 +4632,21 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 		resv_map_dup_hugetlb_cgroup_uncharge_info(resv);
 		kref_get(&resv->refs);
 	}
+
+	hugetlb_vma_lock_alloc(vma);
 }
 
 static void hugetlb_vm_op_close(struct vm_area_struct *vma)
 {
 	struct hstate *h = hstate_vma(vma);
-	struct resv_map *resv = vma_resv_map(vma);
+	struct resv_map *resv;
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	unsigned long reserve, start, end;
 	long gbl_reserve;
 
+	hugetlb_vma_lock_free(vma);
+
+	resv = vma_resv_map(vma);
 	if (!resv || !is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		return;
 
@@ -6438,6 +6453,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		return false;
 	}
 
+	/*
+	 * vma specific semaphore used for pmd sharing synchronization
+	 */
+	hugetlb_vma_lock_alloc(vma);
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6461,12 +6481,11 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		resv_map = inode_resv_map(inode);
 
 		chg = region_chg(resv_map, from, to, &regions_needed);
-
 	} else {
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return false;
+			goto out_err;
 
 		chg = to - from;
 
@@ -6561,6 +6580,7 @@ bool hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
+	hugetlb_vma_lock_free(vma);
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
@@ -6640,14 +6660,34 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 }
 
 static bool __vma_aligned_range_pmd_shareable(struct vm_area_struct *vma,
-				unsigned long start, unsigned long end)
+				unsigned long start, unsigned long end,
+				bool check_vma_lock)
 {
+#ifdef CONFIG_USERFAULTFD
+	if (uffd_disable_huge_pmd_share(vma))
+		return false;
+#endif
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, start, end))
-		return true;
-	return false;
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return false;
+	if (check_vma_lock && !vma->vm_private_data)
+		return false;
+	if (!range_in_vma(vma, start, end))
+		return false;
+	return true;
+}
+
+static bool vma_pmd_shareable(struct vm_area_struct *vma)
+{
+	unsigned long start = ALIGN(vma->vm_start, PUD_SIZE),
+		      end = ALIGN_DOWN(vma->vm_end, PUD_SIZE);
+
+	if (start >= end)
+		return false;
+
+	return __vma_aligned_range_pmd_shareable(vma, start, end, false);
 }
 
 static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
@@ -6656,15 +6696,11 @@ static bool vma_addr_pmd_shareable(struct vm_area_struct *vma,
 	unsigned long start = addr & PUD_MASK;
 	unsigned long end = start + PUD_SIZE;
 
-	return __vma_aligned_range_pmd_shareable(vma, start, end);
+	return __vma_aligned_range_pmd_shareable(vma, start, end, true);
 }
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
-#ifdef CONFIG_USERFAULTFD
-	if (uffd_disable_huge_pmd_share(vma))
-		return false;
-#endif
 	return vma_addr_pmd_shareable(vma, addr);
 }
 
@@ -6695,6 +6731,130 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 		*end = ALIGN(*end, PUD_SIZE);
 }
 
+static bool __vma_shareable_flags_pmd(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_MAYSHARE | VM_SHARED) &&
+		vma->vm_private_data;
+}
+
+void hugetlb_vma_lock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		down_read(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		up_read(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_lock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		down_write(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		up_write(&vma_lock->rw_sema);
+	}
+}
+
+int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
+{
+	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+	if (!__vma_shareable_flags_pmd(vma))
+		return 1;
+
+	return down_write_trylock(&vma_lock->rw_sema);
+}
+
+void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		lockdep_assert_held(&vma_lock->rw_sema);
+	}
+}
+
+void hugetlb_vma_lock_release(struct kref *kref)
+{
+	struct hugetlb_vma_lock *vma_lock = container_of(kref,
+			struct hugetlb_vma_lock, refs);
+
+	kfree(vma_lock);
+}
+
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+{
+	/*
+	 * Only present in sharable vmas.  See comment in
+	 * __unmap_hugepage_range_final about how VM_SHARED could
+	 * be set without VM_MAYSHARE.  As a result, we need to
+	 * check if either is set in the free path.
+	 */
+	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
+		return;
+
+	if (vma->vm_private_data) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		/*
+		 * vma_lock structure may or not be released, but it
+		 * certainly will no longer be attached to vma so clear
+		 * pointer.
+		 */
+		vma_lock->vma = NULL;
+		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+		vma->vm_private_data = NULL;
+	}
+}
+
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+	struct hugetlb_vma_lock *vma_lock;
+
+	/* Only establish in (flags) sharable vmas */
+	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	/* Should never get here with non-NULL vm_private_data */
+	if (vma->vm_private_data)
+		return;
+
+	/* Check size/alignment for pmd sharing possible */
+	if (!vma_pmd_shareable(vma))
+		return;
+
+	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
+	if (!vma_lock)
+		/*
+		 * If we can not allocate structure, then vma can not
+		 * participate in pmd sharing.
+		 */
+		return;
+
+	kref_init(&vma_lock->refs);
+	init_rwsem(&vma_lock->rw_sema);
+	vma_lock->vma = vma;
+	vma->vm_private_data = vma_lock;
+}
+
 /*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
@@ -6781,6 +6941,14 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
+static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
+{
+}
+
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+}
+
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index d17d68a9b15b..744faaef0489 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -24,7 +24,7 @@
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
  *       page->flags PG_locked (lock_page)
- *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
+ *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
  *           mapping->i_mmap_rwsem
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
@@ -44,6 +44,12 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
+ *
+ * hugetlbfs PageHuge() take locks in this order:
+ *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
+ *     vma_lock (hugetlb specific lock for pmd_sharing)
+ *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
+ *         page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
-- 
2.37.2

