Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0A6205B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiKHBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiKHBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:22:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB01B78C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:21:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80OL2Y018169;
        Tue, 8 Nov 2022 01:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=jruOD3X9GjPXbVGMpiHTIkp/jm8OUuxleF90SkEWaD0=;
 b=3NDEKnfSfx+H3cKTlQBliMcQA84UThsnKvCnqSZqHduBmLYBj0uGZP7hhXBkH0MfNBn9
 Nuc3J08GJR1FVgDAFD34eZ4M35LpmubUj1qUHZCYru/76r9O7U+pgIeR2SjKpaae0Nac
 5ldxKXYFtYIvOj2SbZHysOB/NByLW4gAID2wo+el9cRSAZxQHiOnpSFSDGqaZ6mbAbjy
 k+5IrLVu3pkbYQL7TRvl3gTD5yNS+7Gp7grHoazetv/g5WzX4mcoVOD84DsNmr9bVj91
 J/s4ql/Xpr0nOu0yV0cz0QZMVM4oJigffz0Z9oxEdQLNe5qF3njPCvn+RItZB2Cw5SKy 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngk6dxae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 01:19:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7NIX3b025648;
        Tue, 8 Nov 2022 01:19:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqfe14b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 01:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmDr4TOuv8aG/c246+on+7Y0k5La+Wxe473adhGRRpvISpTk1vzbETwLhcl4wAr5WvSY9wKUJIrK7lv08av/VzmEr6qsoR1nGnjL3ljSdeo/6XYyzF8Ph2RapYv/mMP/oVRcmrxE0s6VdaryOSOtZ8X3ue7UNWP+q+n+nuHnbR5SAbLTpJggjlvYP5ebYNblIQSMArzrmVlm3//LMomKbAn3+BCHmodkUm5o4o39Ty+hOd1heFnF9uppgan2lfwAeIYxfo4r9rzetK2kGCcTe+E/LZdVsnOZHKm4cbhmg4G26hJJK/6hl50GuntjcXREbnCSnjGRlsCXCralVoiCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jruOD3X9GjPXbVGMpiHTIkp/jm8OUuxleF90SkEWaD0=;
 b=UJYa/hHTek0TyHD7EXqMmKkg09TZQZd+HP8NhRy5pBe2MkWlTPsCrEb7e4Oa4s3V61ru24QLdLjWFeoD9/ftVTdYn7uTMRYZWGydESPjXxwNawFpOqnsAxQe9EdTLiXM38gzuqeK+2j3k63lPt6xLos+QAJB5omVRMXqm5Sh1hJjsy51ZKanNuF/97KXqHx+0kdnHOlXBZmgvVFIc8ITDg3d9gGTd6DCUZAACvYr6YpJv3S1JEXN8XZH96kNNEeejtE4P8k8qkndLVX9zq+mGRIfxbTamjT22OmaX9ESejNbpxsBsyjAvLFSGi9Vj/AFA7jbVNrmEqVjJqGnJvHs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jruOD3X9GjPXbVGMpiHTIkp/jm8OUuxleF90SkEWaD0=;
 b=KqD7Hh2viFEPbLRS9SqvZW/MRo5tVtOK5H541cMShGpqYsYYf74N5k5j3moNZwQaLi20arx0V+X8e7/b+wVKX4h21H4slRzO3xm5J2fQitD3nWUMo0XpH/p0XXXB1+jW2HOehyEhOUL9l2GP8F9Bab/EyXChH5FVCa8yxYqzxxc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 01:19:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 01:19:32 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 2/2] mm: remove zap_page_range and change callers to use zap_vma_range
Date:   Mon,  7 Nov 2022 17:19:10 -0800
Message-Id: <20221108011910.350887-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221108011910.350887-1-mike.kravetz@oracle.com>
References: <20221108011910.350887-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a697cb-5b49-4d71-2454-08dac1274a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+snvrW3jDR297UishsSpSceSYdJgT8OxE9m+YgF4sE4aHRbXb1Sq6prM6BVpDa0DDa+4L64i2xQNE1qNnm6gAns84X0HyvbvdhC9buolIXwlVVV5C8b4VIvq1zzpD/GkmIcFNSu2ujKB/Lg4ps6MecLvd1yHMUOTBzSD/nxtu618gD1XvBtnAFf4csDyIqzosdnQj4DKMZWaTCIcbkpk8hAcrr/OkYK2qv687o0qMio5NVRhdKv7N/3msUHWiNge2wwmPVf3i7A/BBZCrVJIg82lSWYNM0ZolVvOgZ5gr4Ka8nf+QtTk0zARCxKkcPOTtGfMStMeMFh2dclWD081++zKFJ7wfHNQegj8BOz9JD2BcEjKG+odeiixoYNzfQokqrZvx46CA+VZfY9XzIk3zvDYO9Xl2iMmMmuT150LjDt2KoPhd1+a/jUP8nqstWxJe6X4SlAsaW+LUzjyc/kQ0NU8SjmgbvNg/JWBxChLr8h2+L+b6RmSpCZp5DaqSS+79Ew3kha2ol+eY3aGbXRCdGWSD4FWr2oOxFZIfyBdb9MdFfUBixlLWds0pCUUQ/ENFSsUvop+qwVnVL8MyDRIT+uMKrHlJSUpt3JRaTc20L3VMvYbMgWAitIAd5rKRhRw/CdAcrSAJBbQHxQaV2eqY1+w98FOLxGP2jw7bKaMilezytUCct75FeWNu8j/Vt30b9VQmglZ1jnEd/TCybxKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(4326008)(38100700002)(8676002)(54906003)(66946007)(316002)(66476007)(66556008)(6666004)(107886003)(2906002)(6486002)(41300700001)(83380400001)(7416002)(26005)(6512007)(44832011)(86362001)(478600001)(6506007)(5660300002)(1076003)(186003)(8936002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLa5MZ4X2+p3Hga7OUdFb/VaDff1tvdD2eHNzmyAJHLoKf7eL2rl58qsf+vi?=
 =?us-ascii?Q?b/QXnDXX9aXMegKj0stj8MOzpkedza4sXKnlDP507XoY9rsuI9RwwW1wQo7z?=
 =?us-ascii?Q?kcaxEyURWLXDfW7TjHx+47jbIcUMCmSi3mcXF7Pj50BYSzjQH4UfYF0npk8D?=
 =?us-ascii?Q?RmO9dRM8UmR9xWgbxOLUmWPq1nTDpWQr0g2HMk5Y9ZOFhQZT7C7HvTriQ4kQ?=
 =?us-ascii?Q?xVy1zV/KfS6SIFFztNs954qG629VA6xdDe/zlYv/qwWtRRnkoIs4MoSNw8tE?=
 =?us-ascii?Q?I4qiDTXFLaLf5DxvrVVlf79NPnIQR0LjFYqfoYDjf0nipBs7yEj2JRDSeYMF?=
 =?us-ascii?Q?N6AJDCDis049G2AwbmIZcS7Z1iS8haezTQuwvW8ViEbxGoyElIJx1vH0OZPv?=
 =?us-ascii?Q?MbpJpwTpyA3KRmgM92HidlWgSo44bfBZ9XtP7pMpC4G+19pfG8N8CPph7oSI?=
 =?us-ascii?Q?Fvp3qhFBewf5NQN9GQf8WV2AjW0AR46AC0D5Z8Nn6rtzRzO85gVJL6PPd+KK?=
 =?us-ascii?Q?KOGXfrvs/J2valTWEJxhYGE2JrGJ2Zlj6OhGCdN2fHn7hRoPmMEY/ptiZYuJ?=
 =?us-ascii?Q?UGR77aPEVolpupIUbP84SeNPoVm38hKi8SKaK5fSHPHWgI3UrxKy0tcQFZ5J?=
 =?us-ascii?Q?3KvuSeojufOgVNWzEHDJ/TGfTNr4qQUTusRB80CeB31eyKUAb9mI+Yq3Vx3K?=
 =?us-ascii?Q?OwlFFEu+wLD9h00UVArujWPVOgOyM7KXwdW7gCs62MnqAc7pE06BYXLkqaFf?=
 =?us-ascii?Q?z40h4oV5aGbi+gKn6IIMx1OELdyRPudCglajOKUe6Y2DtVFvxbKcH1O0IVnt?=
 =?us-ascii?Q?N88cBZCB4mJ180zxaisJ7kyhMl0jInpsap8JFW0W4LDrm7i2GMDYdryQw/+A?=
 =?us-ascii?Q?UcydScHz3aSBPP9I5RlyvC79miLrAQ12qCd7KT761RjKrohoevppFP3wTvgd?=
 =?us-ascii?Q?ZFn8M4LoGZW4Fy3UCOVuIJQ33iiZL6gs2hLgzHsXuwpJ+FQbfYccAR3b6nGM?=
 =?us-ascii?Q?MeTcCoinIHWPtUM2MgX0dVODX1fsnZe/42wz3yLvGVTJ/lSyI/ofI/X12YIP?=
 =?us-ascii?Q?7doO+OSKtqTrPm9B/6o8Yjddelo9ljEA0pSaoG6tbpzZM0G6xeRFER5lHBx2?=
 =?us-ascii?Q?8pZMQIQ60Vxaginsv1zAhmUeuDNqQCrZOBpq5CiPOGCw8FBDd8vIXrbRH19z?=
 =?us-ascii?Q?OA4/UTZbGNQg/n8XxiE8JV2k/2kL4SXWjPsn14ApIBe/9cSd6PQAKItQDxRd?=
 =?us-ascii?Q?+oMnNwKOUYtro74tln8X5rn5gVhh5H7Ym+TCLE1xscH9a8N0t7mEviXgpTTZ?=
 =?us-ascii?Q?Hk0rTrkr8tJT+noFCyaejHdAtcxZ4gDUCJTbTc1H2bVjR/hcXcNkSWmCkojo?=
 =?us-ascii?Q?tI8BMiSSGRghB2ZLQ7EwFZn/A5PkN33LBJqQCcT7/kJXFBJWtva7m4sI14TY?=
 =?us-ascii?Q?JqzUWag8vdFqq0N64F7N5eXpzc0BCbkPGqiW4V7dm2dL1ge/YDN0++Lpu0Xs?=
 =?us-ascii?Q?leHicELj07tVyASVbV6N3Z2UOt5O6bA7j7ibefYAU/2zVzei1AO3m1nYcfbe?=
 =?us-ascii?Q?fYX1zLGR0K91X2g/qgelWoImOfiELuE6NoalhOh+Jz5CH0AyON1W18dbtM/y?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a697cb-5b49-4d71-2454-08dac1274a47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 01:19:32.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LXHNuILKSpTXHyjMDa9IDEaY4bmn/+5DJ3iyIzpF9eMwFZKpkn+X4oHnaoNOTYMdVhPQuFKB9O5sbE5e3Y6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080004
X-Proofpoint-ORIG-GUID: QlrkNCnla4rQpFLRh0pC7sUlBJeyHwzF
X-Proofpoint-GUID: QlrkNCnla4rQpFLRh0pC7sUlBJeyHwzF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zap_page_range was originally designed to unmap pages within an address
range that could span multiple vmas.  However, today all callers of
zap_page_range pass a range entirely within a single vma.  In addition,
the mmu notification call within zap_page range is not correct as it
should be vma specific.

Instead of fixing zap_page_range, change all callers to use zap_vma_range
as it is designed for ranges within a single vma.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/arm64/kernel/vdso.c                |  4 ++--
 arch/powerpc/kernel/vdso.c              |  2 +-
 arch/powerpc/platforms/book3s/vas-api.c |  2 +-
 arch/powerpc/platforms/pseries/vas.c    |  2 +-
 arch/riscv/kernel/vdso.c                |  4 ++--
 arch/s390/kernel/vdso.c                 |  2 +-
 arch/s390/mm/gmap.c                     |  2 +-
 arch/x86/entry/vdso/vma.c               |  2 +-
 drivers/android/binder_alloc.c          |  2 +-
 include/linux/mm.h                      |  2 --
 mm/memory.c                             | 30 -------------------------
 mm/page-writeback.c                     |  2 +-
 net/ipv4/tcp.c                          |  6 ++---
 13 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 99ae81ab91a7..05aa0c68b609 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -141,10 +141,10 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 		unsigned long size = vma->vm_end - vma->vm_start;
 
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 #ifdef CONFIG_COMPAT_VDSO
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA32].dm))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 #endif
 	}
 
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4abc01949702..69210ca35dc8 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -123,7 +123,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 		unsigned long size = vma->vm_end - vma->vm_start;
 
 		if (vma_is_special_mapping(vma, &vvar_spec))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 	}
 	mmap_read_unlock(mm);
 
diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 40f5ae5e1238..475925723981 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -414,7 +414,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
 	/*
 	 * When the LPAR lost credits due to core removal or during
 	 * migration, invalidate the existing mapping for the current
-	 * paste addresses and set windows in-active (zap_page_range in
+	 * paste addresses and set windows in-active (zap_vma_range in
 	 * reconfig_close_windows()).
 	 * New mapping will be done later after migration or new credits
 	 * available. So continue to receive faults if the user space
diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 4ad6e510d405..b70afaa5e399 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -760,7 +760,7 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 		 * is done before the original mmap() and after the ioctl.
 		 */
 		if (vma)
-			zap_page_range(vma, vma->vm_start,
+			zap_vma_range(vma, vma->vm_start,
 					vma->vm_end - vma->vm_start);
 
 		mmap_write_unlock(task_ref->mm);
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 123d05255fcf..47b767215d15 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -127,10 +127,10 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 		unsigned long size = vma->vm_end - vma->vm_start;
 
 		if (vma_is_special_mapping(vma, vdso_info.dm))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 #ifdef CONFIG_COMPAT
 		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 #endif
 	}
 
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 119328e1e2b3..af50c3cefe45 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -78,7 +78,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
 			continue;
-		zap_page_range(vma, vma->vm_start, size);
+		zap_vma_range(vma, vma->vm_start, size);
 		break;
 	}
 	mmap_read_unlock(mm);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e..32f1d4a3d241 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -723,7 +723,7 @@ void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 		if (is_vm_hugetlb_page(vma))
 			continue;
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
-		zap_page_range(vma, vmaddr, size);
+		zap_vma_range(vma, vmaddr, size);
 	}
 	mmap_read_unlock(gmap->mm);
 }
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d45c5fcfeac2..b3c269cf28d0 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -134,7 +134,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 		unsigned long size = vma->vm_end - vma->vm_start;
 
 		if (vma_is_special_mapping(vma, &vvar_mapping))
-			zap_page_range(vma, vma->vm_start, size);
+			zap_vma_range(vma, vma->vm_start, size);
 	}
 	mmap_read_unlock(mm);
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 1c39cfce32fa..063a9b4a6c02 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1012,7 +1012,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	if (vma) {
 		trace_binder_unmap_user_start(alloc, index);
 
-		zap_page_range(vma, page_addr, PAGE_SIZE);
+		zap_vma_range(vma, page_addr, PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d205bcd9cd2e..16052a628ab2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1838,8 +1838,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
-void zap_page_range(struct vm_area_struct *vma, unsigned long address,
-		    unsigned long size);
 void zap_vma_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
 void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
diff --git a/mm/memory.c b/mm/memory.c
index af3a4724b464..a9b2aa1149b2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1686,36 +1686,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 	mmu_notifier_invalidate_range_end(&range);
 }
 
-/**
- * zap_page_range - remove user pages in a given range
- * @vma: vm_area_struct holding the applicable pages
- * @start: starting address of pages to zap
- * @size: number of bytes to zap
- *
- * Caller must protect the VMA list
- */
-void zap_page_range(struct vm_area_struct *vma, unsigned long start,
-		unsigned long size)
-{
-	struct maple_tree *mt = &vma->vm_mm->mm_mt;
-	unsigned long end = start + size;
-	struct mmu_notifier_range range;
-	struct mmu_gather tlb;
-	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
-
-	lru_add_drain();
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				start, start + size);
-	tlb_gather_mmu(&tlb, vma->vm_mm);
-	update_hiwater_rss(vma->vm_mm);
-	mmu_notifier_invalidate_range_start(&range);
-	do {
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
-	} while ((vma = mas_find(&mas, end - 1)) != NULL);
-	mmu_notifier_invalidate_range_end(&range);
-	tlb_finish_mmu(&tlb);
-}
-
 /**
  * __zap_page_range_single - remove user pages in a given range
  * @vma: vm_area_struct holding the applicable pages
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..dbfa8b2062fc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2601,7 +2601,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
  *
  * The caller must hold lock_page_memcg().  Most callers have the folio
  * locked.  A few have the folio blocked from truncation through other
- * means (eg zap_page_range() has it mapped and is holding the page table
+ * means (eg zap_vma_range() has it mapped and is holding the page table
  * lock).  This can also be called from mark_buffer_dirty(), which I
  * cannot prove is always protected against truncate.
  */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index de8f0cd7cb32..dea1d72ae4e2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2092,7 +2092,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
 		maybe_zap_len = total_bytes_to_map -  /* All bytes to map */
 				*length + /* Mapped or pending */
 				(pages_remaining * PAGE_SIZE); /* Failed map. */
-		zap_page_range(vma, *address, maybe_zap_len);
+		zap_vma_range(vma, *address, maybe_zap_len);
 		err = 0;
 	}
 
@@ -2100,7 +2100,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
 		unsigned long leftover_pages = pages_remaining;
 		int bytes_mapped;
 
-		/* We called zap_page_range, try to reinsert. */
+		/* We called zap_vma_range, try to reinsert. */
 		err = vm_insert_pages(vma, *address,
 				      pending_pages,
 				      &pages_remaining);
@@ -2234,7 +2234,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
 	if (total_bytes_to_map) {
 		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
-			zap_page_range(vma, address, total_bytes_to_map);
+			zap_vma_range(vma, address, total_bytes_to_map);
 		zc->length = total_bytes_to_map;
 		zc->recv_skip_hint = 0;
 	} else {
-- 
2.37.3

