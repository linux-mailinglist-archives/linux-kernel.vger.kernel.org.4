Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC56D64BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiLMTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiLMTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:33:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52C62DE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:33:00 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJJEnM022248;
        Tue, 13 Dec 2022 19:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dHiOsaOcZeaXsyxC6q/oFn6bHgfhRYKBjshEq8/Jey0=;
 b=BcATNzcIO8Jbzq1Uek1d5tCK7amyGwlkH+VkumCGIl/HFqcG8fAcXn4ATgRwaYYvt6Nf
 j/azauF+gmnAoPuF+Ykum1HI8hrV1NqtHBzMLddweVWnxjMpWC5BeknH40GVfcSUFUtE
 j9W3yXuypCN0ra1FNJoayVU9qd00sUPpL/hfD6JiUV9vDlQSlwTgyTa8gsvqGpc4LFry
 U4UTjx8wuYX/B9s9/AICbPIvVbfrxFuUyX4O19Qvxc2uvW2e3lTDWT6BiyGiq3AWBvoj
 7fJNcOiIPCidjcXjPCxTfAlXJ7PumoIYV1orLVujgbNo0PPvlFGqRaJGdc0hD9EF+sly 1Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu0146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 19:32:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDJJOZp012423;
        Tue, 13 Dec 2022 19:32:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyeurf8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 19:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCItnOykwwLIN+F4Fn+qaF9FnoCLVbB93vvecbIcbHfoup2jUaD7vFHKrTPsYXcAirs+0BuQCzgAs4XA4M80R1bHJ1IWRgYC0dTgMjNHSVYo6AEr8AGHFU/f1vVR/k5XfXjY+l0Tiqr7oX2m+pN17cPhWPUjey6ZytJMctkRg9TI9COhBiHJqeRnOlzsRfIxCio5jwRod1R2Bm8czb17ergI41sQDZHNFXoAHEtO9YLhG362LNHKRE/RQG/idWsZxpNsC4edF66b+QsHlatFSoGe8F793OU0l05oUOSlo7UhgF8AoKqccBvAHIEqAlzvYBi020Lg96B7J570M//tQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHiOsaOcZeaXsyxC6q/oFn6bHgfhRYKBjshEq8/Jey0=;
 b=M0b5wR3MAQbfj3rE9jZCf439J0/N4l6yoE5OGs9tcOL18aUX90WHh9N2NiyN2eu73YHbMVtXwRWTnIdkcrm8Ce3Qf50wR2Vr00gjML77BrgQt84N6Q65Bk/5FM/Qq/uvQnLwcjgVEYcFSdyG/2gE1Ft9oE26AV24EXOkumXTlLFajNpx+86A1RYXX1U3n2IoBBzQ2WBTaDrbM67NQF/Yo2b/hA6k8jop8ptFyE8R/GrWw3aTu5weuqx+wp9EZ2Bt1BCNV7MgV7CEzziWFTOIrT52WfliEa6cNmmD4TLmnsPlU1OBps/f4MjukfYsSS84f9resErGDIcxYFOqMxu8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHiOsaOcZeaXsyxC6q/oFn6bHgfhRYKBjshEq8/Jey0=;
 b=P+mFTzuvmnmVVHfhSA6lQ6MmrjheTemCqmQXI2YnA189BMXyOTSVEcNc/+VmksNYpy+z5Oyqp0lRjcWNPY8uNGR92ktmTP38iJUWv/K2i1L5hHqx3p5A5qFCMAb7FhdI8Fh778FbxptJNeFp2GhzuqNJnrGPGw52AlO7TBSfWCU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:32:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 19:32:32 +0000
Date:   Tue, 13 Dec 2022 11:32:29 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/47] hugetlb: add hugetlb_pmd_alloc and
 hugetlb_pte_alloc
Message-ID: <Y5jTTYwzFHgmm5l6@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-12-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-12-jthoughton@google.com>
X-ClientProxiedBy: MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 662b23e8-9920-49ab-cac5-08dadd40c776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irqGjafQv7MK0PsQhfEG90T8mLSuLbQFvE1WiOlJOLD6SZFwE5qrM6dLf9QQ6+tnQmuoPTeom1zrx34WLN6cBl10u9ErExiMI4KdX6LizIpqwAltyWWQ4krbpdgVddygyQ212ai3ECVmszG2nnfFVU6GpveBoR6h9qABABAWqGlZLRLdKaIENV8rWuATp2jivdrPxpzq43lqT1KjlZou7KimnkuSAmZPJCtEkH2G/qZhbZDg6AehZk+8CJsMMiaJ1h9p9v3on0kxwjbjbVDBb7pvyzhLq28QUSbIaeF/AYHCGob/fcAHnVxHNcxYyXJ6HPR5g1jY8JHog//J9cOvQ7k6oW6mZWhWZBIKutdnqghCoEIxX97SvOwHYUNGyd7682y8AqHZ3Q1h4LujBsuEOjMFyG41REx5P6u7vDpWUWJuCLt4IN6a3osRCgUGB8Hjg9bQTSdfyOaRStFHGiT66csQdrtQKJjonAiHta8bP3cgL2HbJOaZWU5K8iQ/pzJSauCHMabgn/ajSrjnjsMtjmVC8zE02Ru4KC6/h+Ntz1e3icl3gLpR0o6XDKn8GwfXuC436pED64DDW7Frzz6mIrCQimJpukm+VxIiZhObbYaCIl7B5Kw8CwNfTi4AZZwfJCv2N1Au5lntpH4Mlevgyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(86362001)(38100700002)(6486002)(6666004)(9686003)(186003)(26005)(6512007)(53546011)(6506007)(478600001)(41300700001)(66556008)(54906003)(8936002)(8676002)(4326008)(7416002)(66946007)(44832011)(66476007)(2906002)(6916009)(316002)(5660300002)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/D4Sx4uvqZ6Td/8naZPbqTb3lO0fJg1fN7Q0vTut7/j16KobPAcR9ifa3j4?=
 =?us-ascii?Q?nyVubfI9/UD+2/HmxaTJBPjIiwihg3RXLBKrBCJq92zdPA3l+2B7rIuoLBJw?=
 =?us-ascii?Q?KfhEJuTGYnj1Ln6+jcs96/IuYvo1g1Ro9dcw6b8Kls/Zlvo+Ky43016nbC85?=
 =?us-ascii?Q?nwTMBKMPmlSmcX/XH2ZrKyVcoPgtrk6hg5qZFa0HjDbAR3WotlDbO9wXrJYZ?=
 =?us-ascii?Q?ttlU057Qq/86xRYlis2c8/lqDpfjpRdwRdOhBHFpyjyZX3ihAP3BDuMryJec?=
 =?us-ascii?Q?vjhqMTI0VU75qUloQf2GTz/WkwNDDZFSPZe3MDj1z5Smn7+XHRh9pSY9aRWz?=
 =?us-ascii?Q?wThLN4TztPi+HYBH0G7mb+7v/m8tW1FQEFWTieAhPWq4AHP3xA1sI2ul6cVA?=
 =?us-ascii?Q?D6zP/yyd2IZ2uWUYMim+2oc+rY391H65rdyWU7nWV51g545vAekRgte9+DDv?=
 =?us-ascii?Q?4vNOeQCd+TklsDmSWrbfQwLMrfqoNu/BzWw3IqqeFeudcU9qcLhxiTwQEv/t?=
 =?us-ascii?Q?bX362AlMNhYKaQI3sO45b86F6sIqeFGuauYV2MNuR5qobatWaF2aoGZMTerG?=
 =?us-ascii?Q?D4AINV2KXKN22bn3P6EUAnXOc1U1GR++cU6d+MTw7cMukZkKe5QioEBX0M2w?=
 =?us-ascii?Q?dW9RtwFqE9GdBcQKptHmcb3nFTD2smtKZBf4uSMpq8wpChqtsntOjLqGB423?=
 =?us-ascii?Q?i6JXLYlU3FYQ7YnG02/JXVR+LgD38+f7/981DMA13rJ1wxSfykpwhFWWbnFR?=
 =?us-ascii?Q?D1Sf/WTUaOZhSatAQRVqFw8/Ytkt1KaRP5XPFfidHzq0cruRGJp5fPp7R0/Q?=
 =?us-ascii?Q?NqOEk2rHKdHFRENRZ8mlLvvxAKwgTQC5MGpzbFV0rBIaxCrXW0V494QSyQAe?=
 =?us-ascii?Q?+dn9MTtkiZyVxy7kp7nwN+1W80LD5X28YzXGkPE8zM2Dxnva8PqFArfSspdk?=
 =?us-ascii?Q?bXqTT/+9txEXOBP9SeSI02nY52laVhWLe7hBVTJEYagkMgvkVI3uBoUDPjL5?=
 =?us-ascii?Q?qKu5K65eki1813R4nXegGlW9Qy6+3Zy2az0/3iT8SX0BPTf1j3xVfFE957Bd?=
 =?us-ascii?Q?4DgGtrOziUy/ZprBaFZ1fIwVqXJOdmX1hkhrjFMjndzXdEG4Tyn04f4d+qN/?=
 =?us-ascii?Q?foKG4l+q0lcrWD/vVIz+YwvxPEllsF66tRgEkewEuW+qTMaeflF5IFUDAlUo?=
 =?us-ascii?Q?n1DxQMDMrOBXKwHnELfvFqkzgfWf/burBCMXbSLX4QfLSyQ85dcwe/9pK39R?=
 =?us-ascii?Q?mG/vXPICfPs3Y/SoO2/RGc974vsQ9aNZRHemntQR/ykKmjaqurgVK6clV/QC?=
 =?us-ascii?Q?/QqrjMXWztBjVjFkdpxwoZ5iU1pUeUnGqJq+uGix2AEXsT6zmZk6nemTAY0T?=
 =?us-ascii?Q?Nu8OvdgZPT0+9aRLQv1NESNgfrJ6Xe4zZtO1TUOc+pZUnQD88Mv6XMwLVOVY?=
 =?us-ascii?Q?+Bu+AeiEWssB/7yNSIW/xNhVVIuzRQKepxsxwIoU3rSmIqmGAKC1mTo8fCVg?=
 =?us-ascii?Q?SHawI9oDjGWh2Gk1u5djipip4iCgXZ2dBcR0jFKW4c0BbpFBAe+hbRjp2zZF?=
 =?us-ascii?Q?dANiYXAUvQujZtKOqT3XrC/zSYWGyIjjjMYIajR3d0XapKUrVNh/QImea+eJ?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662b23e8-9920-49ab-cac5-08dadd40c776
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:32:32.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw54ow3m2wdIHHJDihUMQyl6oUGgn1ThrHj/QIIzi8o1iV+M3KCLt1P7eKF3ypGuOpWCeVJ11+zLyiXgZ7dscQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130170
X-Proofpoint-ORIG-GUID: qF3c-QNtj10nWJIaJ1VbAtkWH8K5J07O
X-Proofpoint-GUID: qF3c-QNtj10nWJIaJ1VbAtkWH8K5J07O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:36, James Houghton wrote:
> These functions are used to allocate new PTEs below the hstate PTE. This
> will be used by hugetlb_walk_step, which implements stepping forwards in
> a HugeTLB high-granularity page table walk.
> 
> The reasons that we don't use the standard pmd_alloc/pte_alloc*
> functions are:
>  1) This prevents us from accidentally overwriting swap entries or
>     attempting to use swap entries as present non-leaf PTEs (see
>     pmd_alloc(); we assume that !pte_none means pte_present and
>     non-leaf).
>  2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
>     implemented right now, locking is the same.)
>  3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
>     HGM won't use HIGHPTE, but the kernel can still be built with it,
>     and other mm code will use it.
> 
> When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
> implement hugetlb_pud_alloc to implement hugetlb_walk_step.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h |  5 +++
>  mm/hugetlb.c            | 94 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d30322108b34..003255b0e40f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -119,6 +119,11 @@ void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
>  
>  bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
>  
> +pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr);
> +pte_t *hugetlb_pte_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr);
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a0e46d35dabc..e3733388adee 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -341,6 +341,100 @@ static bool has_same_uncharge_info(struct file_region *rg,
>  #endif
>  }
>  
> +pmd_t *hugetlb_pmd_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr)

A little confused as there are no users yet ... Is hpte the 'hstate PTE'
that we are trying to allocate ptes under?  For example, in the case of
a hugetlb_pmd_alloc caller hpte would be a PUD or CONT_PMD size pte?

> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +	pmd_t *new;
> +	pud_t *pudp;
> +	pud_t pud;
> +
> +	if (hpte->level != HUGETLB_LEVEL_PUD)
> +		return ERR_PTR(-EINVAL);

Ah yes, it is PUD level.  However, I guess CONT_PMD would also be valid
on arm64?

> +
> +	pudp = (pud_t *)hpte->ptep;
> +retry:
> +	pud = *pudp;

We might want to consider a READ_ONCE here.  I am not an expert on such
things, but recall a similar as pointed out in the now obsolete commit
27ceae9833843.

-- 
Mike Kravetz

> +	if (likely(pud_present(pud)))
> +		return unlikely(pud_leaf(pud))
> +			? ERR_PTR(-EEXIST)
> +			: pmd_offset(pudp, addr);
> +	else if (!huge_pte_none(huge_ptep_get(hpte->ptep)))
> +		/*
> +		 * Not present and not none means that a swap entry lives here,
> +		 * and we can't get rid of it.
> +		 */
> +		return ERR_PTR(-EEXIST);
> +
> +	new = pmd_alloc_one(mm, addr);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock(ptl);
> +	if (!pud_same(pud, *pudp)) {
> +		spin_unlock(ptl);
> +		pmd_free(mm, new);
> +		goto retry;
> +	}
> +
> +	mm_inc_nr_pmds(mm);
> +	smp_wmb(); /* See comment in pmd_install() */
> +	pud_populate(mm, pudp, new);
> +	spin_unlock(ptl);
> +	return pmd_offset(pudp, addr);
> +}
> +
> +pte_t *hugetlb_pte_alloc(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +	pgtable_t new;
> +	pmd_t *pmdp;
> +	pmd_t pmd;
> +
> +	if (hpte->level != HUGETLB_LEVEL_PMD)
> +		return ERR_PTR(-EINVAL);
> +
> +	pmdp = (pmd_t *)hpte->ptep;
> +retry:
> +	pmd = *pmdp;
> +	if (likely(pmd_present(pmd)))
> +		return unlikely(pmd_leaf(pmd))
> +			? ERR_PTR(-EEXIST)
> +			: pte_offset_kernel(pmdp, addr);
> +	else if (!huge_pte_none(huge_ptep_get(hpte->ptep)))
> +		/*
> +		 * Not present and not none means that a swap entry lives here,
> +		 * and we can't get rid of it.
> +		 */
> +		return ERR_PTR(-EEXIST);
> +
> +	/*
> +	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
> +	 * in page tables being allocated in high memory, needing a kmap to
> +	 * access. Instead, we call __pte_alloc_one directly with
> +	 * GFP_PGTABLE_USER to prevent these PTEs being allocated in high
> +	 * memory.
> +	 */
> +	new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock(ptl);
> +	if (!pmd_same(pmd, *pmdp)) {
> +		spin_unlock(ptl);
> +		pgtable_pte_page_dtor(new);
> +		__free_page(new);
> +		goto retry;
> +	}
> +
> +	mm_inc_nr_ptes(mm);
> +	smp_wmb(); /* See comment in pmd_install() */
> +	pmd_populate(mm, pmdp, new);
> +	spin_unlock(ptl);
> +	return pte_offset_kernel(pmdp, addr);
> +}
> +
>  static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  {
>  	struct file_region *nrg, *prg;
> -- 
> 2.38.0.135.g90850a2211-goog
> 
