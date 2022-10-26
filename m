Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9C060D995
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiJZDKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiJZDKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:10:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75C1A388
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:10:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q1nRRL014108;
        Wed, 26 Oct 2022 03:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=QcRco4kKBuawEQvbmM9VMFfLagmuzjHpfjNVoWd1Osw=;
 b=d3vyafacJ6xdxhomtAsidzqd3TvDR5ZLxl+UkJK5yAZkVwCAwW9c34tCQ7toTqgvczoq
 cyLoNzwbkDrXbh+OU8l8z2Gp38+8jG0q29iNZK/0wxK/wqN1iGxPu0MQ2tUNNsixX76R
 13CUS1RnMb2NKVEylWE+jw+4t4ocFVCAQY1pLxFEmZQCjOTrfARtNFz8v8F0fA7CwN1u
 dgAmc3/CNN2GcXNAFqsmnOtMJ7qS1TbQ0sjZtlb3WsNKz2yr30iglvRggUqsQvROGIwT
 Vb0uOLWsJa6bL7nNMOzWQUEvg8ekdUZMNuDCXAW7PahwFKI++UqdvaS7vjYrqT4YKS/m MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84t597d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 03:07:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q31oi2017129;
        Wed, 26 Oct 2022 03:07:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5gj49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 03:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbRlRKR56BcF5NFqWl56Ogvn+e7b3MnAjA8OEUe/LFZAAgQ7L5vf+6fkomjksb3RYveemn8DNOMFkGrLw0V8AnSqKQERsgA62YaYDhdFSsFRs/kopGF9rAwtXgDAWwChlA1S7W4IgVZyKk98rnemjqGUGTODaP8hUL0A7814b3g47iuFefQjtRbr8tOA60ax6lyOem+QyTulUmtre/TPCAW3YbTXVP2+OkQvPBzocQ1/ToSLXvYW3SIKd5KzWpZgMTyd86NGwESZ4cChWoH6ozH1CzDiH4H8LiIC0h5+brgCJwJPegRnfwca+KBHBWhlzfFV/tQ/6wwzLG3iBAC0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcRco4kKBuawEQvbmM9VMFfLagmuzjHpfjNVoWd1Osw=;
 b=HI5WgHETvyD2FXWZV3wMRMNEiKz1UcknvCExw2SH88MQir09P55s6agZXm/5b86CY/HIVzetQR3byorWmoSYFX79pDLFAtUBtLbo09Mcq5z02isKcfTyvRPXtLuj8/R4s5zFu5gjcIQZd8FwJlwdqTO14HhIyWsdB0cXka2bHvCqu7Ro4ofNHgo5d3013bVRRKo5gaJES9NxMoXY95nMR/pl7KbhLHq/0w8D6mkSrSdSORgX6kla8QjH2FApZGmgm6970VIm+jOZMhfkJsE5lHbjrH1flQnS147iByPJLF8gimVxImIiq4ClB3WdvaB0EY65V/CizNtaBCbGg/A+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcRco4kKBuawEQvbmM9VMFfLagmuzjHpfjNVoWd1Osw=;
 b=RoyQpgFAfCIHHe55mh0tOW4vaMLFCvIkzcIP1kDNwp7kqtly+GgbZBX1f5J/UBL1cYsJ8Q+XN/wybrUUd6p71CDUCxmqSB2hqi4g8cgHftKMayNHuKqY8Mw9+kodHyAoLEBnN9+g5USRuatSbzDT4saZd3T3Eu2m+EeJcQpbS7M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5229.namprd10.prod.outlook.com (2603:10b6:5:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 03:07:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 03:07:49 +0000
Date:   Tue, 25 Oct 2022 20:07:42 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] hugetlbfs_no_page vs MADV_DONTNEED race leading to SIGBUS
Message-ID: <Y1ikfoLS0SdA6dna@monkey>
References: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4defa151-bf46-4ec0-a946-08dab6ff4352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7mv2LvxNhMw+lDFJ7uDcHKbRsxUWl42HF1P0bMB2JA65qrKAzybqvNnn3unUd9eGEUdqjrv1D/6fWbmNJ/lWxCENFwu8KHccRNeMuBSMy4SY4y2CwPQBIPgZ2IjuHm80fBR3ZE1zjIkAxKRiiVwIjmf+Ng5R4gs4+t04fhp0LD84t1ryrPVfr09/1ZAHItMhC941HfU/kqiopHhyUtsIUc4vMW14s1nv5VOA1P2hE//sK2kbLaYdIG/cccgN5SIWkGdBMEUCvW6hc//vqCDNGEAs8LXmNQqVMhBnb8S4CzhzQN4zRI0OPkpt6V+Jit2gsCidveK1w7n+SY/U1KwrxKm3idg3xO/gJwA6DGweabT94br+m7DNC9R2vLL8hP43Y6UUIwa2f4KcL2qrWgWg/jiv+p/7riSJ5SpS9d+/JAGjWURkHVAXkYDVXROn7aUcqqKLR8/BqvMpunGJROQYJxT71M5tny2+gcSknqW1xCPXPtr3jjLSfCQZGYesqe34fynFezg3vn0kYfb8RQnUCFy5yq7ohUqxbs9PMVJeXsHgEq3XCLpNvcZBJdexWeHfCteslSlN2u4lKmh/16q+s09qXu45+4YME8zo4F3CjgoKo2axxSEI3QF8sBXg/+GFa/+UPoDt59g4Bs3CFgA2mrYWBM+++OHRmAYhi5xxuTA1bkSLxDgwN4tA6EKEY3itrba2WrhYU7uG5WH8Vgq8D0EOrs6pxRmyKtyUZ9fdtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(53546011)(66946007)(6506007)(33716001)(66476007)(66556008)(6666004)(966005)(316002)(83380400001)(6916009)(4326008)(8676002)(186003)(6486002)(44832011)(41300700001)(54906003)(5660300002)(2906002)(6512007)(9686003)(38100700002)(26005)(8936002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kMw3kVFLS/zzr5bT+Ps/h9trqxPHay9kOb2tAHuc0zC97bXLRIn9wcgC/6Hq?=
 =?us-ascii?Q?k55lN9H28N6ynLP+W9UcQRH9norMTSevWWwmthSHQWAyRreeW/0Y7eUDp693?=
 =?us-ascii?Q?G6K7pjRzQaR9pjWOjR1drN8+LPEmA4c2Zn+89WhaQbCsP2rEwhw0DzsqBYtV?=
 =?us-ascii?Q?Ai9wGf9gx92qiMfUysZO1lqc+hLgMS+dQJJTQSiirXDrfQHfWhD71PqTqmy5?=
 =?us-ascii?Q?dEYok43zyLBUraIZ7pU3VZD7qmFgPiuz72Tgf66+EmfLakL3N+11ttb2jCuC?=
 =?us-ascii?Q?EE+6tCJvpQhppuGU3+xNIwqd+cy5THiEqweoBBkijcnCDNDgcB6Xrld1q5ey?=
 =?us-ascii?Q?O9JV2nRKtEK04Ha8dI59Ab6bjOP0NW1TpcD7z03ylM9nxEGqxvX64FSWtGd0?=
 =?us-ascii?Q?EITQtVOlXK9BTEYs5y52SFYBvwJENtpEfxdS1PsN6ZH/Oy+H3NehXBLuISU/?=
 =?us-ascii?Q?TKLBVUXk9vMsmeADvvM34IWKgEMy/HUDeV2jTUwKlX5rZJYOmdr13ul1sNPb?=
 =?us-ascii?Q?AtT4hxZaOV8XIQCh1dsG1Pfy6HHiNubeHyBEtZMOKTayfDBie1iU1JIp9ZmF?=
 =?us-ascii?Q?u4fplgVFAWbDUl4iZHez9bf9nEesjBAcLCYM53wcAt98jkbSFiO2o9j3rRty?=
 =?us-ascii?Q?IK+YNolANcxDN4HcI+V1CHJqapTfMreqmoJd6VetNQJiK8ujh0JPntK4EMiB?=
 =?us-ascii?Q?q5oxpitGbzjX15senkNy/MfeKCITMrigWrom/Ex3H7MGSI+5Me71eAGbgT3H?=
 =?us-ascii?Q?bSBnDgokQAJwohUwyjkC4ntAMpBiho/KQfgop0vPedN7rnXahS0wB4qtD+db?=
 =?us-ascii?Q?yzN8m32x2ggQK1I4xdN7ry8OTHWB7xPnObBqMpjDW+t3X0VkYDF034UXXvQV?=
 =?us-ascii?Q?a/xmXRSp3Mv04rQhgy5wArpfaYoVqJtgSQ9vAougBNYI6KRIo3bN5ohQYXyx?=
 =?us-ascii?Q?PqazF8jb5HA4uvgc9Tdr8wAtgQqs9Aot8MJU8kYVMP96447MUS5RkSQKW7eN?=
 =?us-ascii?Q?3u+8jfsMwfuRKFG5WLh8Fy9+RQet3DW3+u+8di6+mtxeYeledreC2Nb+nwmX?=
 =?us-ascii?Q?qLEO24WhU5BVzWtKfUrnUMeakaRcmTvLjKIVgfzlOnIFDxRCHNUtOYVat2qp?=
 =?us-ascii?Q?vzwj/cR/aR3RNJuRji0lV1/i2yX0E8xlmj1vA08RGx93d/5yPEyTGoSwrADP?=
 =?us-ascii?Q?zgwoEBG5wTqHhkrr2V/MFsJIrr5nJZ/WCmrPIufefHF2riR1ImQ8ZOvgMszz?=
 =?us-ascii?Q?HSp9mKTJlBXNtKnu0Cpbvv2D/uCuxEVf2VQJyMso1kd2i4jFCpKCCa/QLRKg?=
 =?us-ascii?Q?h6VRbLnZjN85b92v1Yq8u1JoI4aPZd40++8EPTh+mOMsJekWsqNengj1v417?=
 =?us-ascii?Q?G2rknhlZA6afCYVUccp6wuqxfd/lw0hql94IUrvgXSxkk984U4g+FcwTBpqj?=
 =?us-ascii?Q?umOkkzI9VYkmboxO5b9oV2i0p2xJVJXQ/CNa4TYjP07PhhbrSkod/+vAlYFy?=
 =?us-ascii?Q?aq47iTsBUDnoun2o/C//hKUQufdOhcLlgsGHg3on0R/5FfL6U2KfcIGW/aPQ?=
 =?us-ascii?Q?A/imuR+GcQTzfmFLozcC5O2IKytQ5+CtJxBVu2YAtqkp+nNvceRXHorWvs94?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4defa151-bf46-4ec0-a946-08dab6ff4352
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 03:07:49.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GC1bYkgjY7VRmKtq/wDIYauOotB9VJn3TJ+78PQkBaHHhCr/422co7m7bKG8LSfWFZNNtzbmirZruuPbUAk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_15,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260014
X-Proofpoint-ORIG-GUID: yFRhfOLqKPAjE7235nLEp2cT8tH6XQMI
X-Proofpoint-GUID: yFRhfOLqKPAjE7235nLEp2cT8tH6XQMI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 16:37, Rik van Riel wrote:
> Hi Mike,
> 
> After getting promising results initially, we discovered there
> is yet another bug left with hugetlbfs MADV_DONTNEED.
> 
> This one involves a page fault on a hugetlbfs address, while
> another thread in the same process is in the middle of MADV_DONTNEED
> on that same memory address.
> 
> The code in __unmap_hugepage_range() will clear the page table
> entry, and then at some point later the lazy TLB code will 
> actually free the huge page back into the hugetlbfs free page
> pool.
> 
> Meanwhile, hugetlb_no_page will call alloc_huge_page, and that
> will fail because the code calling __unmap_hugepage_range() has
> not actually returned the page to the free list yet.
> 
> The result is that the process gets killed with SIGBUS.

Thanks for the details Rik.  That makes perfect sense.

> I have thought of a few different solutions to this problem, but
> none of them look good:
> - Make MADV_DONTNEED take a write lock on mmap_sem, to exclude
>   page faults. This could make MADV_DONTNEED on VMAs with 4kB
>   pages unacceptably slow.
> - Some sort of atomic counter kept by __unmap_hugepage_range()
>   that huge pages may be getting placed in the tlb gather, and
>   freed later by tlb_finish_mmu().  This would involve changes
>   to the MMU gather code, outside of hugetlbfs.
> - Some sort of generation counter that tracks tlb_gather_mmu
>   cycles in progress, with the alloc_huge_page failure path
>   waiting until all mmu gather operations that started before
>   it to finish, before retrying the allocation. This requires
>   changes to the generic code, outside of hugetlbfs.
> 
> What are the reasonable alternatives here?
> 
> Should we see if anybody can come up with a simple solution
> to the problem, or would it be better to just disable
> MADV_DONTNEED on hugetlbfs for now?

I am thinking that we could use the vma_lock to prevent faults on the
vma until the MADV_DONTNEED processing is totally complete.  IIUC, it is
the tlb_finish_mmu call that actually drops the ref count on the pages
and returns them to the free list.  Currently, we hold the vma_lock in
write mode during unmap, and acquire it in read mode during faults.
However, we drop it in the MADV_DONTNEED path (just a bit) before calling
tlb_finish_mmu.  So, holding a bit longer may address this issue rather
simply.

Below is another version of the "hugetlb: don't delete vma_lock in hugetlb
MADV_DONTNEED processing" patch.  It is very much like the version in
Andrew's tree but the code has been shuffled a bit to hold the vma_lock
longer in the MADV_DONTNEED path.  Can you take a look and see if that
addresses the issue for you?

From 9a1f047ce42f76b3befd673da5ee2bd49bea6c75 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 25 Oct 2022 20:02:58 -0700
Subject: [PATCH v4] hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED
 processing

madvise(MADV_DONTNEED) ends up calling zap_page_range() to clear the
page tables associated with the address range.  For hugetlb vmas,
zap_page_range will call __unmap_hugepage_range_final.  However,
__unmap_hugepage_range_final assumes the passed vma is about to be
removed and deletes the vma_lock to prevent pmd sharing as the vma is
on the way out.  In the case of madvise(MADV_DONTNEED) the vma remains,
but the missing vma_lock prevents pmd sharing and could potentially
lead to issues with truncation/fault races.

This issue was originally reported here [1] as a BUG triggered in
page_try_dup_anon_rmap.  Prior to the introduction of the hugetlb
vma_lock, __unmap_hugepage_range_final cleared the VM_MAYSHARE flag to
prevent pmd sharing.  Subsequent faults on this vma were confused as
VM_MAYSHARE indicates a sharable vma, but was not set so page_mapping
was not set in new pages added to the page table.  This resulted in
pages that appeared anonymous in a VM_SHARED vma and triggered the BUG.

Create a new routine clear_hugetlb_page_range() that can be called from
madvise(MADV_DONTNEED) for hugetlb vmas.  It has the same setup as
zap_page_range, but does not delete the vma_lock.

[1] https://lore.kernel.org/lkml/CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com/

Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
Reported-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/hugetlb.h |  7 +++++++
 mm/hugetlb.c            | 30 ++++++++++++++++++++++++++++++
 mm/madvise.c            |  5 ++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a899bc76d677..0246e77be3a3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -158,6 +158,8 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
+void clear_hugetlb_page_range(struct vm_area_struct *vma,
+			unsigned long start, unsigned long end);
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
@@ -426,6 +428,11 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	BUG();
 }
 
+static void __maybe_unused clear_hugetlb_page_range(struct vm_area_struct *vma,
+			unsigned long start, unsigned long end)
+{
+}
+
 static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 			struct vm_area_struct *vma, unsigned long address,
 			unsigned int flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 931789a8f734..0a52c3938ce9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5221,9 +5221,39 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	 * will be issues when accessed by someone else.
 	 */
 	__hugetlb_vma_unlock_write_free(vma);
+	i_mmap_unlock_write(vma->vm_file->f_mapping);
+}
+
+#ifdef CONFIG_ADVISE_SYSCALLS
+/*
+ * Similar setup as in zap_page_range().  madvise(MADV_DONTNEED) can not call
+ * zap_page_range for hugetlb vmas as __unmap_hugepage_range_final will delete
+ * the associated vma_lock.
+ */
+void clear_hugetlb_page_range(struct vm_area_struct *vma, unsigned long start,
+				unsigned long end)
+{
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				start, end);
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	update_hiwater_rss(vma->vm_mm);
+
+	hugetlb_vma_lock_write(vma);
+	i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	__unmap_hugepage_range(&tlb, vma, start, end, NULL, 0);
 
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
+
+	mmu_notifier_invalidate_range_end(&range);
+	tlb_finish_mmu(&tlb);
+
+	hugetlb_vma_unlock_write(vma);
 }
+#endif
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 			  unsigned long end, struct page *ref_page,
diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..90577a669635 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -790,7 +790,10 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
-	zap_page_range(vma, start, end - start);
+	if (!is_vm_hugetlb_page(vma))
+		zap_page_range(vma, start, end - start);
+	else
+		clear_hugetlb_page_range(vma, start, end);
 	return 0;
 }
 
-- 
2.37.3

