Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6766036AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJRXgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:36:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1D263EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:36:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ILx3vP003545;
        Tue, 18 Oct 2022 23:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=OdPxxhsR28oLKyqr0D5XgeLxK4Dhz3zEtPZmW0zeYy4=;
 b=jF6D5KLCK8v2YNnhERKW9cpxtfoNfRUwQ1rX8pKJ96I9+Tx/IPWDAo+07BpjPyN1vsfW
 j8s+l3eIaaxTlGI7R2gTgIwA0L2fvxJ9UXnC1Vk7POngMcWblg2BVq+yN1V/bkEgguyD
 Ts0KLMwUIk8qPRt38c/46klwDXWt6Xsb246wAdXdrvJH/EfcNxmUfglk5K92mOIJO4bh
 yRv1/L/UoDC3MA0/yiYthzkSOEd6hXRLDrMVEyYQV3KhW3DLZk7Rbd6IHjWHatNBvK9W
 uHrHNh5dCegzWC8+K3RGQE1mJ+v1sci9Vyf8CoTvRDPMtnCcY0ugG3kJ01fXvVwcVmIb Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww3yya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 23:36:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IMVTHw028844;
        Tue, 18 Oct 2022 23:36:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr0drh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 23:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDsw/fse+x23Gg5NRXNAIZt8MQN/HsgAFQnNq7DBIe1mRkcWoLGAXL34I7LoW57mwZmb45x0nkwDzQomL5FzBRgR4UCEsvkBJYIwQUeD6/KTqbW8Yrj2JPdvUJWqHNxVldrq0g+1JrNWnsbk1udmkWMH1vfPosqdmy83ok5nWqPXaXeZKw1DVEpFnIDF74CDt/IXESIg4hUXblJU9cZaUyq2QOrxUEbjlJPFDyp/OULyRpKOEj6UWy5Hbt2YZkwJijTA9XdMjgHYgT/M51pVIImN4s+GNYdLNYA9aW1PDPIcb+AztWx0e7lDPzZ7cY19u07mruvfyRZHLpszReixYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdPxxhsR28oLKyqr0D5XgeLxK4Dhz3zEtPZmW0zeYy4=;
 b=EfWLe0fCOaCqq6+dTZcFVC2PWkitC7qzBVgfPgmIZ8ZCs061GkNcPQcxW4qD8LxN071O9V301SRdbwb+FQhXyU6gBHFpe1NJGOVwPG6AYZMhOiDhX/+chwwjnIAvRf2ut8Gy7lnYMFTKTvhPaMIbnKRwTqhdr2pq7D6P0ZqfTpw6X3ZvEza6n2uLn3c9W9+o2WRC7EtC4nsmpeuyW5N59epZM+mtw47Xzp/CltFxX5Itg6F3QSCyYBUymwkJ1PcWIOwXo9qFNFnMp0i151CBLSAgLY/Q9argx227eBc00GtYZvs0iUYMJ8yNTKgoBQYkDxHRE9dbyc4d6ESXEsMqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdPxxhsR28oLKyqr0D5XgeLxK4Dhz3zEtPZmW0zeYy4=;
 b=xjoTs9nB+L8su9bDrh4RWGrOvvJlJ6tMZlu46/G4SQ/Zn/dKNjcUBsVpMpZgcVNDwHUGFthXRngV38h04DmELUa15Z12aziRr4gGHdz2DXYJsnpN/3siEWF/bYjEwvmtAKUSPugMWI9HSyGD1FcbUY3piEJEqpAo7Zdz0yImynk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 23:36:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 23:36:05 +0000
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
Subject: [PATCH] hugetlb: fix memory leak associated with vma_lock structure
Date:   Tue, 18 Oct 2022 16:36:01 -0700
Message-Id: <20221018233601.282381-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0299.namprd04.prod.outlook.com
 (2603:10b6:303:89::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: c95d5b7a-ad0f-49ee-ae84-08dab161866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6YnhbRN7nQKOh9VtQLCMj0l0gTVA3cnJGGWh1CVXdeviozj/Zj4oUtgZjIPhsL+DzgrLznTzHKmvIjL2HzVS5NwsGx0NCMW9QtS/CNTKZSqgtpgN9xviXVfNzfM9PSEQzBxkWRegLgDuX2/Qz820LRCM3BwxzXy3eci5GmLdBrKuj/M8ud+uF1CESIefe1yDkr4SWVMsFfU5WH9EZFo94mVbUYzYf/HPnaIJMAuR6FRsdoGMNz4jE6U1U6RU24N5bHEnK2N66QmToKjGFTSxtMM4viAl2GGCN0jmtcjNBo6YDZubXvUs5dvMIZAF5sqzKrdE6vSEwSZKm/rsHAuW0quqsrNSCoHnp+hE/+nNTsido3CSZm88oSLh+544Q3ocGalkhGoXibfIZa/jeT2AsEMbAzVb8uGCphD3BSC8/6gBNCl3/ewIfzqCoC8b1lo4oAqQ++gzEv10Qf9q36MPVdp64L+l7PbWcnQmUlrr1DUhET4EwqTq4vuAad3q71L9vFgJxfOPDZzDXq4hKF/siB/ZEAwVVphT6QlLYw31nOUKg3MSKHSe4FjCVFbOprjkpA0XD1NT8ioEEzrVsRuCEgtU8X0zOAk9lTWS/A1nDeWhUYOjPcip0BLCyBt25m8z6EY1aZifJ6toNN6CGqfOhZGp4M9NFPjGjdua6mPfssP+ha+12tB90ZWhV1kXEJ1+FeKKiVOZqafbBnz1AizANnlIi1OBkeMmfoy/gVAsEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(66556008)(8676002)(6506007)(66476007)(4326008)(107886003)(6666004)(86362001)(2906002)(186003)(83380400001)(26005)(6512007)(8936002)(41300700001)(44832011)(2616005)(1076003)(7416002)(36756003)(5660300002)(66946007)(6486002)(966005)(478600001)(66899015)(54906003)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvbxtXlfpgQ6S1IkQwE6bedbf+/JelBnfBqVoVD34V5+k93gl8pF9//3g/yF?=
 =?us-ascii?Q?u2Nq1D4eBWfaq4mVNFVDDC26XQjrR4Cu96owjcT0X2cq7OgPmYKQGbpTvGSE?=
 =?us-ascii?Q?1HAPQZK5/auGCXW1AauIvVPIwQ62mmZ+YuwzVf3Tv/17IhH1pc5TukyZ92YN?=
 =?us-ascii?Q?P280CCnnEepbEvV6xiFvYlEQxk8cuDZmKMAO4/lkLfsyPaI6/NY/Vxu8pC1g?=
 =?us-ascii?Q?WbguqPqXeT9LarP1Li/tnw12/KqIvtGupA7iRWpcefgHOzxdukuOevJPRh/5?=
 =?us-ascii?Q?4EHEHubcIWOjJTjOp9QGIpCJmLAm4Rx1mNeKfgtML6suD5xHcX6P4ER6whQ2?=
 =?us-ascii?Q?TfHWM7GRgOWxcVf/YAtPNbEl68naLURq/OV75dOhCFMyy1YaJKozbJmykbeK?=
 =?us-ascii?Q?W4g4QUVXeaKR/rRQ/CSSKx2Fbg5NH7nGSiivPefVySoQP/9eiZtk+twsUzoz?=
 =?us-ascii?Q?cwtosJjmVa39AVz2z3pPvZXidlSRgyqBiC7/Y01uKdb1S9+RcDES3qcuzWen?=
 =?us-ascii?Q?yX1z+bd06ipulii0JqNpZTLBkNMnRDgZvQz/sxbM2UdS4GjvJcwbB1Aqla7h?=
 =?us-ascii?Q?xo37sXk9jOsAQv0P+YmJ3trxYQN2X6ylkD4ot20ofSe2a5eKAoVlMWF/g/6x?=
 =?us-ascii?Q?5GOSOUprTlYPIhtB410JLhWDU4NzRwZg8fWkzyvhYzqf2yXMTNHg9KyO9B5p?=
 =?us-ascii?Q?ZZ+v97CakaWUPDW6aHmT4j9YvBks/djDRV7PeY/b3iDNTY/aokdg7gKe0vq0?=
 =?us-ascii?Q?GK0G3syPlGywLp3y46QsfYQZ+dbX+zuaNa0XvAw6v2ega4teFfNuiPPOONl3?=
 =?us-ascii?Q?DaMwpy7BsYhik6ey6w0l8bSke15cd0lCSV3eWo8023GRlObKUADHwXJEpBFf?=
 =?us-ascii?Q?4V6RmEMr0hGyJXiORS6pWrP8qQFtP9a3iMGpJ1B6Hik/RB1LKDxVT83WLehI?=
 =?us-ascii?Q?HPkAnvjCoIu6tBgsyVmABktOIlmb7crC/sp3Hq5OhkdRXZ5OcPuZVFymUy2X?=
 =?us-ascii?Q?jMwsgYP5gX1atSPFSf1z4Alvi0PLrTtu84ixP8vpFmYxsSKv1zIIEq5RPegh?=
 =?us-ascii?Q?D1ruidQj9RR8daBt9FZFOwQQDzkFQDtKrmYBk4mExmoGdJk1cVIYBzV4ycOf?=
 =?us-ascii?Q?f+crZZa8mgA/GL81z3aykt2+dHR9b9pcpFVTScdcxU7dDILvAnLB/aZxsbEH?=
 =?us-ascii?Q?ORtl8Mro4g2mSQaEDGWi9uP58/H3tA4iIokPQw6zHoSmuJEgwSprQBV5mMuJ?=
 =?us-ascii?Q?wH03kuQiS6Ck1pM4omznetgYCYZUz+t6kEdboLpeEOmO+y4QZJPLxPsmbCAi?=
 =?us-ascii?Q?EKlfp26ni6+UFPmckxbPHjFbFcOe58D04q/NjcMUSoCRBfvaNVGId/E2YBkE?=
 =?us-ascii?Q?Nx7n7uGgY0jJvBUizFzqw03wCC7in1YAOrFxzKa+uR03uql/IODcuAYhbjKc?=
 =?us-ascii?Q?tNo6A2FqrD2TpKJZTaqj1EACfb8Pi4di5wWMin3XU6JsXCM5gFdcHKDieGlU?=
 =?us-ascii?Q?v4cZmggLAc73J9E22NShCmBTy7rD6DNPPOo4QZE/K0AHCnABMEnYS9ExwicY?=
 =?us-ascii?Q?n2U1FIWrqvmETXkTS2h7bnIIni3PLUeSkmRnZP5NVRzSQAuyNNwZja0/w9Tw?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95d5b7a-ad0f-49ee-ae84-08dab161866c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 23:36:05.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZmiNBQhDhgc4fAHO9Da/DiEzXx028WvzRjgc3F7tqi/c37LgzOjxbvnTniUXiKEkUoFuwcg16oqsHWmo3Th7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180133
X-Proofpoint-GUID: acV-t6x2iRxNf11wFUnIPdTuB03NA-U2
X-Proofpoint-ORIG-GUID: acV-t6x2iRxNf11wFUnIPdTuB03NA-U2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb vma_lock structure hangs off the vm_private_data pointer
of sharable hugetlb vmas.  The structure is vma specific and can not
be shared between vmas.  At fork and various other times, vmas are
duplicated via vm_area_dup().  When this happens, the pointer in the
newly created vma must be cleared and the structure reallocated.  Two
hugetlb specific routines deal with this hugetlb_dup_vma_private and
hugetlb_vm_op_open.  Both routines are called for newly created vmas.
hugetlb_dup_vma_private would always clear the pointer and
hugetlb_vm_op_open would allocate the new vms_lock structure.  This did
not work in the case of this calling sequence pointed out in [1].
  move_vma
    copy_vma
      new_vma = vm_area_dup(vma);
      new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
    is_vm_hugetlb_page(vma)
      clear_vma_resv_huge_pages
        hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
When clearing hugetlb_dup_vma_private we actually leak the associated
vma_lock structure.

The vma_lock structure contains a pointer to the associated vma.  This
information can be used in hugetlb_dup_vma_private and hugetlb_vm_op_open
to ensure we only clear the vm_private_data of newly created (copied)
vmas.  In such cases, the vma->vma_lock->vma field will not point to the
vma.

Update hugetlb_dup_vma_private and hugetlb_vm_op_open to not clear
vm_private_data if vma->vma_lock->vma == vma.  Also, log a warning if
hugetlb_vm_op_open ever encounters the case where vma_lock has already
been correctly allocated for the vma.

[1] https://lore.kernel.org/linux-mm/5154292a-4c55-28cd-0935-82441e512fc3@huawei.com/

Fixes: 131a79b474e9 ("hugetlb: fix vma lock handling during split vma and range unmapping")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02f781624fce..7f74cbff6619 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1014,15 +1014,23 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	/*
 	 * Clear vm_private_data
+	 * - For shared mappings this is a per-vma semaphore that may be
+	 *   allocated in a subsequent call to hugetlb_vm_op_open.
+	 *   Before clearing, make sure pointer is not associated with vma
+	 *   as this will leak the structure.  This is the case when called
+	 *   via clear_vma_resv_huge_pages() and hugetlb_vm_op_open has already
+	 *   been called to allocate a new structure.
 	 * - For MAP_PRIVATE mappings, this is the reserve map which does
 	 *   not apply to children.  Faults generated by the children are
 	 *   not guaranteed to succeed, even if read-only.
-	 * - For shared mappings this is a per-vma semaphore that may be
-	 *   allocated in a subsequent call to hugetlb_vm_op_open.
 	 */
-	vma->vm_private_data = (void *)0;
-	if (!(vma->vm_flags & VM_MAYSHARE))
-		return;
+	if (vma->vm_flags & VM_MAYSHARE) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		if (vma_lock && vma_lock->vma != vma)
+			vma->vm_private_data = NULL;
+	} else
+		vma->vm_private_data = NULL;
 }
 
 /*
@@ -4601,6 +4609,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	struct resv_map *resv = vma_resv_map(vma);
 
 	/*
+	 * HPAGE_RESV_OWNER indicates a private mapping.
 	 * This new VMA should share its siblings reservation map if present.
 	 * The VMA will only ever have a valid reservation map pointer where
 	 * it is being copied for another still existing VMA.  As that VMA
@@ -4616,10 +4625,18 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
 	/*
 	 * vma_lock structure for sharable mappings is vma specific.
 	 * Clear old pointer (if copied via vm_area_dup) and create new.
+	 * Before clearing, make sure vma_lock is not for this vma.
 	 */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		vma->vm_private_data = NULL;
-		hugetlb_vma_lock_alloc(vma);
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		if (vma_lock) {
+			if (vma_lock->vma != vma) {
+				vma->vm_private_data = NULL;
+				hugetlb_vma_lock_alloc(vma);
+			} else
+				pr_warn("HugeTLB: vma_lock already exists in %s.\n", __func__);
+		}
 	}
 }
 
-- 
2.37.3

