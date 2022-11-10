Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08D5623816
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKJAWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKJAWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:22:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F919295
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:22:13 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA0KT4f025133;
        Thu, 10 Nov 2022 00:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jvBT4d1TBEEckKfxvC8qaET4kaKQXdsMZumd5RAUFeQ=;
 b=HUIu9mUVFiAXCi9gndiaZdb2kwHMEQFl0TpHO2sHFvpGAyqSxrVfE79l7f5bJKCRbt/p
 l0ehFKl6TOFH9g8pQmW1XepNTqKaTf+4T1GII8wZfVk7YIEekLvvhBejOZw/fjH9AOXC
 UGHLwd0iDTTOaRjeQ4q2i+jjXUPu0L46wQJs2f9D6zT3MtJh2k8L6pFUV2Cn+jrA/koI
 kA3Hj61qf5qAnL9iRi+tAeel5uU8DAnZ6I0tRsoUJGhjRHiTciulQCHMi2kF2kFAS7hu
 sW3sVfnDrk76LaRTul72SK0GX7hgn0aEEkkmmUCgzDyC8sMJm4xj91Hw3ZAFcsjv6A7c uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krph480mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:21:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA05KUC000378;
        Thu, 10 Nov 2022 00:21:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsfrabm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvafOlCvKhiCsITCbMLhn/fKocjc/zXJlldDJIoil510UkRSXJfzi/n4zPms7lIFGQHfbJrFpPwxyULr2QJ18eRsF5Od9f4qfqMh4GmZWOZ28UDEUoTM7M6YzSM7Wx6JEqoELGF4VShvknfQR05lxQ5di/t4qCFHqhuMAmpE7GmNbCMYh5j+YV/WjqhLirAAb3IqDGe4aQKBxD2uLhejJ3oOIC1bIumyJdTmTYIFSAvG1ZdqeGuiJJqdbY1lXkyjpenf3Ymmlpy1tDhofJGPxbWQCzrBdhErAKXCfeW9y5uCQAbmEmh/dN5cMF2J9FaG5qFQzq9seH8DxYlP1vNM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvBT4d1TBEEckKfxvC8qaET4kaKQXdsMZumd5RAUFeQ=;
 b=IMMe3Ztk672YRI0L/A/AY8WNc1/FniND6ZvuYttPcDm8jynALxlwgUeNEl35DZGnvApfqTcP/vv2hsBV/mbu9B4w8b1LIcsYZF8/bFsJBfVBqwvxiejM/MT5lngVHqK/R6XmY0jEkEbxSYLwtJweh3FDnXwwH9aQ+wdKh5UwnpT+uVkNmTpFBw18/y8dnVIx5nxJnZQQEn9l2yCbkxPtuUdrNbV+paZQ+efTm5tZd2ysWh4HXVVcNZTYZxacLXeLSnCh0eGOMIhNSgyqdmyEvm0CItXncbt8dYuYVVLpclUXJ3SMChEjZJdp4Gv7MieG2OtIRQY5p66mDLt/Ol2PZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvBT4d1TBEEckKfxvC8qaET4kaKQXdsMZumd5RAUFeQ=;
 b=wogfyAIFH7I/AAs74Cktv8zfbBu6Qv+of7dyypBmrCnEGyl0EaDqiQEUrLvphoZgioxaThU2EKBDl0I/T7QCnTgskY+RjJt/Px1MXG9p8Z/b8lymG5KaSioXNBM0y0gL+/T2ZobG1B4eQNMh9Rtxey4fNd6pfWmtTkPwWHlK9r4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 00:21:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 00:21:53 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Nelson <doug.nelson@intel.com>
Subject: [PATCH] ipc/shm: call underlying open/close vm_ops
Date:   Wed,  9 Nov 2022 16:21:50 -0800
Message-Id: <20221110002150.440055-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: a8235422-eda7-4f1f-7117-08dac2b191b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 881mpW53bo+5gn4xGrwheSTlot6BrbWoXVr/YCa4bC9Ap3YKMTnqIqoAeESvHSFWJ6XBsKClMwir2AzxsiCFUS8eBuXIH/WOD7gNnKljbDEUWYJVvoJyl21hqOEK/y8NAtwfgPYrM/A3EdmKWyKL+cWsb05NXWG8YugRIJq0TNzr4fa4eCPiKaFdL9ya8EuANvurQ8y1ucdpnMqet4IZCJua891BW82g9/0xM+Vns5criOWeduIrd7UY8s24pLuKBmxskI4/8hnz0tzSxR1htA4OtYfKZmP5iVNDzambJzldykOPVDfOzZOfhNQBmCCPoIp1QYoaXwWs19qHWQCaGutZ8irPZEmsJWGAcSLo80Sjy7E+nmMzParWiQAr7AJKw2qvUF1tjOS9dtJDL/KFiNyVIiPfFRvsaW2R1NxC5onHKZZSBV5qbHdojj/kcHijfgBOKVx4RCh0ngL/X3nRUgMsS/xucRavkHlrondkWBD5jxsbmAh6/Fi8kRS7JZp6SsSXoMyC6chvz9A1OKzmYfcK/XtAklLpxKtuigAh9XKI7lLXDN6lGsOtomVtaIJtgaPzDLLrENMDcKWdnrN1MGrpvgARjJL4xu6kDUFcNlLgRZuYo57GGz9RqiCCbj8yVrfcdoTslPilUvDKH0MLDjwxNltf/zdYcuNKjMLy0P1qLAFsN5GsmZ9IkWnbB1CPmNKi0uhzwQZ2vavU7PtM/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(66476007)(54906003)(4326008)(316002)(8676002)(8936002)(66946007)(66556008)(44832011)(26005)(5660300002)(2906002)(7416002)(6512007)(478600001)(6506007)(6486002)(1076003)(186003)(2616005)(83380400001)(41300700001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGauW3jL3T0gjxCqVKye7Kgq/kX6zpcnITzrSGEkLqj820q5JZt6Wwp9Gs5W?=
 =?us-ascii?Q?pCQNVy22TW0iETr0aiODAPo9W8wr8tlByMNK7K9ulam8thBbyBVUoJ5OM5Nv?=
 =?us-ascii?Q?M0weZbKm/oLWZEv79YeHFg7WePd5HjkZib4/cEelPX2UAk5P5GjR3Z0+v+BK?=
 =?us-ascii?Q?QkPkSdEuDPr1opt+jJ0C7CDaD6K5JbYZUJyr09WGbgPoYj+i/jwnVeSRxgFs?=
 =?us-ascii?Q?kIOb230WkIAJ46QgpKVBGIwuzjXqyepMh4JXyedGd53oZktmhe/sxLNMddjb?=
 =?us-ascii?Q?Uek2Lc0AKoEe99OLv4ccZzWEzOMKF3knYlZda/o/ZES6UEaA37q3O8+bY8r/?=
 =?us-ascii?Q?9V+QaXoCSb1wzBtUT5FIrLxt6yrF1pODx9jxw5+8nyMX4XNeu+cN0yQR3fMK?=
 =?us-ascii?Q?vN58i39F9fo+JQwezOCqeVnzDZbVw0WHVvWGuqHaR1m9eQDLM/adfux4+8Fl?=
 =?us-ascii?Q?1ANr5CgRvOzHr9ZhPjJnpWBpHLXAxQObCN5HKigdD7ON5wdEab6Bu14qPs3f?=
 =?us-ascii?Q?M+2cKrYjvhpU1NyHyo5ZSejgW4+5Y/fr51O4OnAWYH8dPjt7KpTdQeAb3/nd?=
 =?us-ascii?Q?emyHL1NTn6pPgjK4gOXLnIS2Hmz0tL9Xqc32Bp8DDFD65i+92QKgEKmDc3+q?=
 =?us-ascii?Q?fk20ZS1jtpGutQASbSTpWExHPHoNt7CQJKoiwJy7M590W+hOudy7MLIvtgmc?=
 =?us-ascii?Q?jMSXBY5ShvHag3iuc4L6yc0+DozGxvSYPNpb0XJa4HxM2CIZSdgmyHDTQezW?=
 =?us-ascii?Q?8YFwcckHjURtp1KvIqqj3HbhFDhDMkIKGEQgGnjeol5naJbm45iE0mUGBb2q?=
 =?us-ascii?Q?UA+J5BJ/2N/Q9bGYny7u01Mm3gVBVgwYIn7orHAvIvhF+5BdDeoWs8u+86sI?=
 =?us-ascii?Q?UNo8L2f2wPEa3v/183Ft+ObnUNVg5KKN3TTDAcO8za+Pyg1hmXG51zVnVwtW?=
 =?us-ascii?Q?s4p7YqHQ+Yvho7At8QrbJ5eq4NTZ7zPntYXicDYD4raz0BTSZrdK2J42a3ft?=
 =?us-ascii?Q?heJuED1VRpb4IFAWR1GKJxnuGF6GZcaSbUHUMLtnmJxPRgOS8kzPkM+bCqXG?=
 =?us-ascii?Q?VdYWBOIeR9F61WNgPqw45yVShEQ4aw0J9bpnTG4CKTUe18bO+zWg+lrPHkvo?=
 =?us-ascii?Q?3Z1prYHH5lFflyZHbq+dPMAFfk+RJzyCZ3uqbEd70zhIEvF0I18qr1JmBxI1?=
 =?us-ascii?Q?5CUjv7UQ18sEmbiQgMsgqhqv1Xn/swIbXB5DC7/dKsF2gEMkjeP6cU37PgJp?=
 =?us-ascii?Q?m99jXt5dde687JgyILS5noswecnhYNNqiLETrzaXaik4mnHtKjYBxGUMUTs7?=
 =?us-ascii?Q?ZMJmr3dpY0gxfCDfZ6dLrQk/91hAqpZ9nfGUUm/VdzmilUbRog8sDu8JAsnG?=
 =?us-ascii?Q?VmYw+VJLxNQV+RJVqMibClU/IvfKXmVObT48ChMF0vaBhSBUW6MDKzDiV8CR?=
 =?us-ascii?Q?87g4gJXGUfTUpsotDeSkKglPxR7cF5orjyNE32A2smRE1HB9qLLuvxvKcYb7?=
 =?us-ascii?Q?64BouN+tUs8s6yOuPw45iyzn1Ck74i7qlz+EJp6SR9+rSRsezO1+den3Vt6a?=
 =?us-ascii?Q?etT78NSG69o+Yd2Wq7luCI4PuJN1eMDoZhoWSrqC07oHT0p6LDzRlBILzPYQ?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8235422-eda7-4f1f-7117-08dac2b191b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 00:21:53.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9zVo6TzDjIUY3dv+iTi+u1x0Kex1EA5eOkQIZaIIqXNg0ah70AzqLq/2FSDEv0E1SYpf1MjU2d58l6877De0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100000
X-Proofpoint-GUID: AnefXsVVUgpJdYjZDyuYglOCAyzSstlU
X-Proofpoint-ORIG-GUID: AnefXsVVUgpJdYjZDyuYglOCAyzSstlU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared memory segments can be created that are backed by hugetlb pages.
When this happens, the vmas associated with any mappings (shmat) are
marked VM_HUGETLB, yet the vm_ops for such mappings are provided by
ipc/shm (shm_vm_ops).  There is a mechanism to call the underlying
hugetlb vm_ops, and this is done for most operations.  However, it is
not done for open and close.

This was not an issue until the introduction of the hugetlb vma_lock.
This lock structure is pointed to by vm_private_data and the open/close
vm_ops help maintain this structure.  The special hugetlb routine
called at fork took care of structure updates at fork time.  However,
vma_splitting is not properly handled for ipc shared memory mappings
backed by hugetlb pages.  This can result in a "kernel NULL pointer
dereference" BUG or use after free as two vmas point to the same lock
structure.

Update the shm open and close routines to always call the underlying
open and close routines.

Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
Reported-by: Doug Nelson <doug.nelson@intel.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 ipc/shm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 7d86f058fb86..b7a354a62caf 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -302,7 +302,15 @@ static int __shm_open(struct vm_area_struct *vma)
 /* This is called by fork, once for every shm attach. */
 static void shm_open(struct vm_area_struct *vma)
 {
-	int err = __shm_open(vma);
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+	int err;
+
+	/* Always call underlying open if present */
+	if (sfd->vm_ops->open)
+		sfd->vm_ops->open(vma);
+
+	err = __shm_open(vma);
 	/*
 	 * We raced in the idr lookup or with shm_destroy().
 	 * Either way, the ID is busted.
@@ -366,6 +374,10 @@ static void shm_close(struct vm_area_struct *vma)
 	struct shmid_kernel *shp;
 	struct ipc_namespace *ns = sfd->ns;
 
+	/* Always call underlying close if present */
+	if (sfd->vm_ops->close)
+		sfd->vm_ops->close(vma);
+
 	down_write(&shm_ids(ns).rwsem);
 	/* remove from the list of attaches of the shm segment */
 	shp = shm_lock(ns, sfd->id);
-- 
2.37.3

