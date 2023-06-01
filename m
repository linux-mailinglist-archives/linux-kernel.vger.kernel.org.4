Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29371906D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFACQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFACQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC5F19B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKT4XJ016257;
        Thu, 1 Jun 2023 02:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=iFuOmajnv8UAboeRSWaci9Eo2kjzOvaz2Sz4LG6DuKfD4ZY9gGLIyWjFXJu5mrGiLZD5
 BWmZwXsS5HT4kQ+1F96Imovst6p7YUCh1oeHb5C2lJ0sP1NRRdS/zfZhjZg7A1n39Vaj
 QJwPg/ue7Nan5LbHpIHvmaLGlikRj5Pqzx1CLoC1PcsWkkcdHuLjXSFkf2g4TgT97RLN
 vt8EBR53myCm0lJG7DG5MIrt/UIjUjxjCWq3zOKYhfEs76nevTsDE2NYFy7IpA3ZYJYz
 bUgzjeagjuHh11/ywmV1+o7B2snPWVk98EsK1Cwcx4Y8KgMXkRqIT0baoVyhm+0VpdTR 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmeqhq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3510E5Va014631;
        Thu, 1 Jun 2023 02:16:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6gr6q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flhyh8DVZw1ZNx/tZxrfnWXWATcY5o0IpeaXiGYCAUXn+83hDe8FbGG/jCeqwgQnlbfAVgwTnYoALL0BUemn/uVTixOy5A9nvhQ8r6nd6G8JOLRUMHcTqPghenACLpLUIzhzDxHhPxPTvt2l4IYx0B80aaYWQwac+78xj1clEvD/hz/XfsGCtrlV+24ENIzzae3e4ohsHH+NA+OS3CuNiSVyN6eID7JwNLgTWqWVegnoxffDNy58ELhCXL7eM149QgVtsXndfGm41FefcBxmFINPvihhMSoBpaa7mqtICnJ/j4GHFhLdXbkMnOGMdLig8RPGKl+XE5g4c9h38gB//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=UkPSl9ztEo06ediUcQ4ydn1no43AEf041rltmLZQDe16SWohItL7+YZ4fN1/yZVZ41w72JGxRBzpbT0p/2mujMTY3VEYX6Ff6Lis20tSwPvBjCICcGVjDzNaSTHT1lM0zW51Wr9ZvaNbtqxijSzyHGjpa6eMSGBuMbugkGcnz7Zjrs+e2Q/CGEqouKdHRbWfhfp0Ehazhi/defH1NLg03JUjJocIPWgnnxV+KvuRxoWHz3lCBclSpZvkkH+P1n15A0GXy3JZFjI8uFLNahSMvhgzKhR8mLIwKZhO5toR8lOb9eLnJWG06L5hKqP0V5w0oBidjxsaOrzImxQ1QjEJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9omlzefsXQ1zzAnkg/pmDvba27GUm7hHo77v9ASBEM=;
 b=kvUiye00mchYg6HGEyWp8IbS0LJjadR3UYOwcRqz5S68gpk9XB/V0t7Cf5qtFwx4tU5xkO8+iZlojOwyNPsVSaKJhREKtXyb7Fk8TplGI+zQb2vdLR4DfZWOBdt9rqnFjogZRlkHJ5NBx+kF9U+7qRjtKCuH5/pgO3k9kHgL2Dk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:23 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 03/14] mm: Move unmap_vmas() declaration to internal header
Date:   Wed, 31 May 2023 22:15:54 -0400
Message-Id: <20230601021605.2823123-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0068.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbb63d8-de62-454d-526d-08db62463281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqPQ0tYTmE8/vRftZYnh5oWsmLBdtSf/+ee1LWiy0xZiQcy0keAkaGFzTxfno0lbkLrNORUdyw1Oq19kcpgwtVfMpmXIU6hspD5do9Trd4B4j6E21hjgQagdvOije8OJJV6Y/4zWpVPI2ls8vduK/mRFlpeqVf/7vRbfuq7Jt6n7S6aYVnQO4yPVUmKmKOW1i1OkSg4+krk3hsjfJv1Bj/yAX4G9j0L+FyJeTwj0qM/ltKqa//Nd5wIvobOwUhBqe1HFqAFBSqzi3frwe0LPYfrnCNPpfqOp1QwH7MtRECHBRi9dloav7Mc3Zu3QkPZxZvTUj254FSBrhPLPMcb4NJhd9ZorGmFJHWSb3tViWQ53jRdXiC0mR/gFBkepKYkN/+gEmtWtuLycSl4xLoRFeV8xjcbMXXUtETsjmPnVMPPbdIyd4LrZyig7mk8F9F9N1sIGe7T50Ia8/eRw1bzrdCYsrH36gNm9MG6jY8Yg0Z300zQ5oSNgIP+ClHXXdtq+KnGS33iGmxEEd2Ml9qByEl1PHv1xIecHWzjiEI4BcWFeFu8k9AAd8L572DIYWv4H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koyd5joR1jD71wAomel3Y9GMH/HID5GfLW4pvHUVouuT80yzCqc5+2HcgOZU?=
 =?us-ascii?Q?CXR3p6a9PinhcX2FV/9I7pugvTNNWtn9zWKR3ODkyKMeKTeqULJTSw9bnCG0?=
 =?us-ascii?Q?gic7V5N7Hxrr8Qjh0z1Mx8//nMDEbQJOkRs88+D/Em9XLKDRrRttiWGf7Fmv?=
 =?us-ascii?Q?jg2yPK/zt9rrsQTFaZdhtXZuJrbsMaWRwSnAWehDlHo5RQZ+nE3pCCW5pTVu?=
 =?us-ascii?Q?qXMgn1KUJ9OebGOVkin6rBlaxD3aTlr0Wclrovfijgu/DLwP7x4lU9Sw5m8L?=
 =?us-ascii?Q?ffMHIrZkbuPMjreCrGASrtCZND9fkppeSDAsAat7aoUGRsc0iFp4J5ir1ZmN?=
 =?us-ascii?Q?5nZ1MgVp8KjskJXF/tAO2dtQ1Pg03PRzu/7OFknMJH6+ES4O2d0hNaDePa6H?=
 =?us-ascii?Q?EzcrLFJHbnS5x0+GjKDBtqfOUJ8vMdm9BaLgkrLBRMX/2TpNjKf0fyhji1iB?=
 =?us-ascii?Q?X/RBNv7uakrpVKunuL/seqv/vmAONg+iBSQomzijxcy04D7IfqabuKgVIIqO?=
 =?us-ascii?Q?rHMqFCbPAt1+JQ/JZKTtjX0I1KUafR/9qIapE4ZjGHBQ3kEnCYPG9AjuLnBV?=
 =?us-ascii?Q?ECPl2kGm5rwxpskNYsZW64uA/CNjt69Z0fXdcWwJCGRd/12DTzWyB11pB9A4?=
 =?us-ascii?Q?jGhOXRx4G8OEV1th3MjyBXecASpTgoHqrNF+o6cGUA9AZjh12INffugKSWAC?=
 =?us-ascii?Q?vIY8g54dq+FOl9t1aouDpym2cNGXjW7JOUBCYuw9DbaHuu3XbkfwrK2sEcmm?=
 =?us-ascii?Q?NK7VSQMTEmr+Odh70f88SmMkHuJna7vNikwxlw8+7pI3Lmyj8JkyXGfv/Qbb?=
 =?us-ascii?Q?I907Cje0rMSQJGiiEMMZnZ6XuS98BX77UUaiOCOONWS/zdKIMAVFVFPrmqU0?=
 =?us-ascii?Q?arDI4hP1rfLpcL+bsMuEeUgYxLqfmowryE94ll7bA6MABRW6s4d70QEt/a/9?=
 =?us-ascii?Q?0gGf9lSwdJ9PF6e+v2sZuW9ZeXLtSRDE92cXirz/q0dNTzcxFC0dapoJUsZN?=
 =?us-ascii?Q?msD7lY8dhpngoUDdGs2PUKC5LGBVwADBzyLv/QVVLKZl6PIqshiFIgEpRR80?=
 =?us-ascii?Q?J/CIjXflzivGagy59NjD9JA+X8HbKVBE88dqZdHLEYcfETTN3AAU/cPmtAFq?=
 =?us-ascii?Q?nMicehkIFiIknrzZ5Tn2YFMr+aIJHjB+ZT3ZBrIDqN+sAIcxJJFvPD4CW+OH?=
 =?us-ascii?Q?Z7dy4u250kftzQleuaEXEs8/Li7/A3G2kgbTop5U3CwW9UqK7ZP9t+Rqot0x?=
 =?us-ascii?Q?nmOHSmGxYh/lkjQtFRl6kLh5PDVt7GHg+AMb1fOC2Zlles/XPHQhP5p4zBrN?=
 =?us-ascii?Q?ypVyLpylN0AIIZDP+MA/I+rkIjD2ZombzgcLU2m4DAPO16welsXqITAlDm3G?=
 =?us-ascii?Q?YXd5bY+bwHVuMOpLLkk9TRcEw5Vtmegte8pnTRE2nGDrJIlp5YCKIWq/V6L2?=
 =?us-ascii?Q?33rhnbUfNkwAfsCTADBNnyBJSWPbfpVnK0Chs0eVwLxiCj7DxgVSV85d8QMv?=
 =?us-ascii?Q?j+2LcvgQEh2kAg5xL7cZ+8/x1273kvtNIuBK16hHAE+ZT4HnJ5t9+NENXeiO?=
 =?us-ascii?Q?2mY83jXevB3ePx9zCMEEu5Tm9KqdgY8Bp37hnTex6ZIrxkW9j/+cjbkR4+Qx?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GXV+/FoxNrSugAnRIPfe2wylrTA0hnLLm46zo/H9MZzyQhl37J+9rGRgu+ZZG0Hy0S1CD57Euml9MT45yKp8kMhVisui3MofTZZakixGHCrn6cjSzBDw18vW0UFIddoNyF64LMvk4xjaTOYcsB3j4KcDFBTIne62j4Dhh702dJaQ5n2DJ5OAgVDq4nfs7n7nsMi9dS0d6NDG3YYZCSPDgXFZXArA+WA1cEWfn+6CoKcVpWpVdNdNzPI4CFffOUSr5sTxy0abWltQBQfw2BLXSvMu43sYx0uCOCybzahQwHG72unDru8aMqgs+53PlWpVsipNoZC8A6zVarMTlLjs4+d8fv8VxDNA+0A4F1oS9erKNO9x6tXiMBGIVmhDuPNmUs1sfVOV1hMa0Itfh55LExt6bGRBXSLDAQeQejqKy6+pdYyfuFhWgOtFfFJDCUmDBL9liHaI959ofW6ihYxM8YaHHdxcx6GNvgaCOSTR6rVJKOmGHm7rPd5sItWO4wix9BfVQDmGgFCeylpdvhJ5iNEvmBs/xbb0nrxQm1oMfGxEklMYrJ4HKtYxVsOnEBvXBSJgdBSvJIpBnAMr6cojSD26IgwbLVyiBCzmgLBSmjDGcEp9M9Ej02MODm6APptAdXyUdbdnWUQfdDPlpdpizBR+qj02ArY8vLyu4PnrQTLEba9KUOT2dK2RVbs4356D8GQ0E+yKJSNFwGo9Ismgrf9JBOPKw9E2rQUY4U/k90PCY3PO77Wn+pxSi9G5uG/coBKHlWTVeW4gXu+Kg4xBuALejeA1e2JXTrd/1HTLwTbPaId6Vs4hqQ69z+HEUr47YKojvEmX34pfB+c9fpbIMh9ztDiywUHQduC1vE2Y7T3U5Po6x2Hx1BCYo5pBemrLH1ZTQIxkI91AB6DlO6SXaw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbb63d8-de62-454d-526d-08db62463281
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:23.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkbdyKui1AnP+WK98Qw+louorvWjy/clSfyXH0W6H9zpa/bY3Px00aEFrPjh2sD6zasiJxxqpfo8GezQ9EslZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-ORIG-GUID: FVTkB-9gU_mKY0H02-5wKplNjgSiujYN
X-Proofpoint-GUID: FVTkB-9gU_mKY0H02-5wKplNjgSiujYN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unmap_vmas() is not used outside of the core mm code.  Move the
definition to mm/internal.h

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 4 ----
 mm/internal.h      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66032f0d515c..209fe13dc8a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2302,10 +2302,6 @@ static inline void zap_vma_pages(struct vm_area_struct *vma)
 	zap_page_range_single(vma, vma->vm_start,
 			      vma->vm_end - vma->vm_start, NULL);
 }
-void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
-		struct vm_area_struct *start_vma, unsigned long start,
-		unsigned long end, bool mm_wr_locked);
-
 struct mmu_notifier_range;
 
 void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
diff --git a/mm/internal.h b/mm/internal.h
index f45f5eb4514f..9b665c4e5fc0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1099,6 +1099,10 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *vma, unsigned long start_addr,
+		unsigned long end_addr, bool mm_wr_locked);
+
 /*
  * VMA lock generalization
  */
-- 
2.39.2

