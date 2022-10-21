Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1588960803D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJUUub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:50:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331D1A3E39
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:50:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LKVK7W007815;
        Fri, 21 Oct 2022 20:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JtADH1H2H7g+5eIYCoyCXBJl9xpoG7bwNEK203ZUgnI=;
 b=zIqPKAYaPclHKeHX7AlXz2zaMyjuuS2LKe0Ab7/afCHI11Oj6EeoW4fSPoHUr2pdiLPq
 4YSnOvQQg2+fCvwfuvGCEuSt8Lz+tqhE3aaP5lqsVN9RjkO0WlHdmxacX1OJdvExhTX8
 2mp3WoWCzqfi83Dxn2M/U+aYBr7XCTjSFW/3F5O7Mrbk9jEt0HyXky08KY5+rxcbqkwj
 bUUQuHsHJHQGDMlMkgBHfc8J5AXO3lB0YY+sYExo1n0R5gzo/XZBquUrcdYIy90kAFjW
 06YScG8P3O7abN3tsjRIQMeeu3aQg+vP+Ek9PdljHiNMujtuEum+GiL4jCMwls/DR+lj wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3sub4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 20:48:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LIVwYX038611;
        Fri, 21 Oct 2022 20:48:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr3k1xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 20:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDtKf+Q4OUPfhIQdTZUo0lB+ZJnHVwfIjbn54FHicO7tMNm0GJbYzcEEDTsWMp/3eSYCE8F9iNFMvFeLiLtOdImdulkMiRvqQ2mQtf+4oVsHA2facVrxWGxdH9sFo/3ODtEY3RZZS8uslMlJ9xl+mvRhOg+AEVY5TvCr03HhVgD53BsOzBP9aGUgj7/Jicy6FJ/SPCwzQqZpK1FpZqzU9Y+jXuhtbii1LmYLSYApkBoJtMpYFbp9fjBN/OsylcPssqy0UNlEgnJIX0Ni1rcWrAOnB1i1Az0qbEearQHJdVQ9zsBPV8FDKMSKuWB5xOw8rn9KzxsHkzcQofn7gyD7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtADH1H2H7g+5eIYCoyCXBJl9xpoG7bwNEK203ZUgnI=;
 b=ju62kyCtQl4HIeGI3AFHF383mHltGUbf2unAaIg7jsbNMOAmtFJOaGXxDDNK/T9YPI59+t/qBCd3C1yRyqqYVhCpsX1wPKh74wqRvr8Lt7CHNz93GNt9P00BzgXFO4yXUVwyuIUjRb7sC6SfVyVOS3a6oL7vPqlXKUI3FlRrB1APpwXvwSStrG7u4aBcM11OUzzGrI0n9JjfNYWjC+AJrSp+azip2Dj06SZbLW/ozt51tLlUhOhzoILQiKM4MkecJFoh9mKRNKSi89ZjeronXsXBASjFv+8nGq1yZxk41Cqix5CwTqmzvvHxEP+6qm2nB/Z4/HdJ7koNXkNi6DmxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtADH1H2H7g+5eIYCoyCXBJl9xpoG7bwNEK203ZUgnI=;
 b=HROvzhADRPw+a4deIV/1870hNDgqtQ08Cw4WPJhSh1ddu7p/1CmmPFZR9VGABQDPrLIg2752lP2p6nQmtFI4Wdb5IDEVqSe174pg2rlPRAH5RmFgdYiPaw91HVotkL4vWFM3HVejKN8hX1l+PztzKPNH5KwmJ1iD+7lkAvmmpEM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 20:48:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 20:48:17 +0000
Date:   Fri, 21 Oct 2022 13:48:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,madvise,hugetlb: fix unexpected data loss with
 MADV_DONTNEED on hugetlbfs
Message-ID: <Y1MFjnDBOzpCW/9Z@monkey>
References: <20221021154546.57df96db@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021154546.57df96db@imladris.surriel.com>
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 852a4d84-4a98-4a0d-47f4-08dab3a59473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0t50+qLGcwJXTEVoWi7IlwX4BusCiir1hnsuV22fpii96/pdP/CINQJwIZeBdndcrdMw/qyyKeV568i2xmgmKZi0wh6h+GQkDA1K7wUgYBNRbpmfnrZEYJIUeh1smd6ZGI5lwUMp+oSAxFAiqh50btgFN1+gSCcRc0Z+/M5QgPqWJKR0wmYcyYcqgB+fOSKU2h9nhpWwMM9hahJD+vySS52ODWOSaHRvOAHIZU+zyQAca5htKtlreO3INMl/HDDjLsMqCcq2WK5Tn+X5bMTbNDVS5poFR/ja7QmC65WhOYP/d50uqhuLPM7RX1qh9/Uq5ztr+9Ll6t3ghw9K2hNeXpnGfI0Ly08tu7ezqtYrH/pZMdPDCWvJfYNmbQ267Lcgo0PC023clnA3jnbZY64W8ShVFMwkTGrDdVdQBXg6JqmiPLJNFPuG853jLRX1Ke3TWK0vWP18O9JxJTP83spe6TGW63rDBZ1jPWaRHlOGurMQ5Y9sAPagtP7Vbc6FevsldgqDyPPLUAEe082cG5OgeUi4IldwRwgGeuar0aQmCjZWBWcHhQyhPcE0V1plIo0TDFS3Ed78ntlVS+HY4qt2oJj3sly384Ek1dFNQ9+RCaiFW03dNdn5/54XFJFw/tWFv+TbWu8T8HhPMbi1XfJwHG07qmWgmvMc03VFxqTtmtEGMK1rh1IswOtiOEfUcdjwYy/9s5mKDuqNZfhdjF3BqT/2VKbOI+Gjh2ZAKp3DMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(4326008)(66476007)(8936002)(44832011)(41300700001)(8676002)(66946007)(6916009)(54906003)(316002)(66556008)(5660300002)(86362001)(966005)(38100700002)(478600001)(6666004)(6486002)(186003)(83380400001)(6512007)(26005)(9686003)(6506007)(53546011)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uU8lbWPOdtGbw1uz4Pl3c8li5hMmQKeVHqYXM87xXSJ5tS4BiY36gELZwMWQ?=
 =?us-ascii?Q?96uMeCRPWoFeoenL3fPUEJgdZYy8ynESQRJkE1pNgPxSK+s6E+dtRplrd849?=
 =?us-ascii?Q?qE/Ahssytj2nJymww4Ase0tjRRXYFyivgVMEbJ34bkO/qZJRC4B5HwfuT57w?=
 =?us-ascii?Q?8+TrLdA72/r+bdn//TOH4Pp5t9TV9c9ZZJcxd88f+2kiQlXdVx/7KnSdiOzu?=
 =?us-ascii?Q?YA8AvJ9aegaa/G8G0zkoEo+naDJRes/uuQS7RZPYIzmVWs0NiO7BAZItzgiY?=
 =?us-ascii?Q?mPuINHSPgV4+8vaLz+MyEt65/eY5DuidLt0NuM+E4olCXXux9Rj8j03McQSq?=
 =?us-ascii?Q?YyTWu8jsxBUjjEIgb1JBG9D/wa8uxD0OyK/C7UjsgWZb1B9O7cO+2+gV/J5Q?=
 =?us-ascii?Q?2MZwztABKsb8D1TBIbOOVk0B+FZ2a8y108Xb644k0nqvyXaT+56qLckL4HxX?=
 =?us-ascii?Q?Li+X+Lxxk0JJ678i6h50RHqoTMHxbBHvP04ev/PYFWoOnvEpQlepAnaxZFAI?=
 =?us-ascii?Q?GRw9tXKXqYmpZEVFz2gCrTBOosfc93CMg4BmnqvSWjr6sO/VHEo3LViw+PJJ?=
 =?us-ascii?Q?Iik1KJwJ9OVBL03/rHS2cukC+vWnNGaB7XfzCMgc/0TYK6aiRAIOC1cbZVQR?=
 =?us-ascii?Q?x0TTdioVpvvRxJrYYfAp57rXlLnn6/ZkPL6gGTxCEVfkp5jqX6VKB9emZwMg?=
 =?us-ascii?Q?rc1ObJv69hI77N+tIv67Sc/EW+lClMifiOJFGuREczzjLVfpdEXFXEm8YRDB?=
 =?us-ascii?Q?kTeBy+md5uGpvuTjMEm5o+wbToBngSGsHdm70yod2ZcycfGwNT+1U0Mh/igq?=
 =?us-ascii?Q?cXbvObXN6GlkIsAZWlLziJai2+G15gUzi9qaLl0jtThQxKPHeY08TSGnn97Z?=
 =?us-ascii?Q?2lNYH1WmrJ36z3x0PK5LtHdFLedh9fN2o5DYOCo1Fw24NQYjtWXAZdb/FVHb?=
 =?us-ascii?Q?/Am3LxvdM42oYPkR2R3oVHyYBx+OUuBBpXNmnc7yIBxdFYZFbJHxYMK/kpiW?=
 =?us-ascii?Q?gXDkcAK+9yFpvoGQILElwgdSsUecbyP+bOnr/6qJX44WXpQqdP5fY5yhOfEz?=
 =?us-ascii?Q?JwB3IGKN+5S6IkrRFDPAQyOVSfGEZiPlulrCMtMlXW/3cWne1y3eibG5t8Sz?=
 =?us-ascii?Q?j0rmbbeTuWNCnwTrwQFvWI7+aIbHRBdZIE7cDClHMsq1u7G9YrVdXByQpuLY?=
 =?us-ascii?Q?2XRLzGbqgSkyAHJ1jTO+YnR9MhbbzCVvzxhEc3qm7ulMfXHkoABMdFF9f1xz?=
 =?us-ascii?Q?i/x+idYfeMvhXzP+CYxVhFzI8sSvqOsZhckbxJUPPVnZO7KnD5Yu8dG7D0aU?=
 =?us-ascii?Q?j4bYuVmZtH4Abk8Hi6DQGG+ntW53t/Rg7aN01dTGReD9uKT14Z165Umov+1r?=
 =?us-ascii?Q?yoIeAP430bRjlUqSyg+pUdr0SJP9ytw77igTYdOXcYXVOUEmAGXS62jhOuH0?=
 =?us-ascii?Q?c5goFW7u9xcFz7hOJc9dkZVyWov3A9LHjkjp0WEPFuxUgIczpZ6RnjBR828D?=
 =?us-ascii?Q?6kIDLCIgQT9o0Hyr/s5Pco30KeZH2fxo+N6bP80cOYEVIqehGuuogryZf8bO?=
 =?us-ascii?Q?sNSBJ23Xk5u9be3CDieg7ZaIyECofcrD0sUAKtL42RH2teJOxHP1TbcQe/22?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852a4d84-4a98-4a0d-47f4-08dab3a59473
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 20:48:16.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNeqhG296DOBUTclyiqNN0YACNbFQp6ZRZxYxjXdm7BndUhtociOKHZ6S7xUAIAGG7p6M4KgzP1jXRt2+MIjHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210121
X-Proofpoint-ORIG-GUID: T5-cPBY47vmySqKH89bLHL7Orn3gYMq0
X-Proofpoint-GUID: T5-cPBY47vmySqKH89bLHL7Orn3gYMq0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 15:45, Rik van Riel wrote:
> A common use case for hugetlbfs is for the application to create
> memory pools backed by huge pages, which then get handed over to
> some malloc library (eg. jemalloc) for further management.
> 
> That malloc library may be doing MADV_DONTNEED calls on memory
> that is no longer needed, expecting those calls to happen on
> PAGE_SIZE boundaries.
> 

Thanks Rik.  I tend to agree with this direction as it is 'breaking'
current code.  David and I discussed this in this thread,
https://lore.kernel.org/linux-mm/356a4b9a-1f56-ae06-b211-bd32fc93ecda@redhat.com/

One thing to note is that there was not any documentation saying
madvise would happen on page boundaries.  The system call takes a
length and rounds up to page size.  However, the man page explicitly
said it operates on a byte range.  Certainly mm people and others
know we only operate on pages.  But, that is not what was documented.

When the change was made to add hugetlb support, the decision was made
to round up the range to hugetlb page boundaries in hugetlb vmas.  This
was to be consistent with how madvise operated on base pages.  At the
same time, madvise documentation was updated say it operates on page
boundaries as well as the behavior for hugetlb mappings.  If moving
forward with this change we will need to update the man page.
-- 
Mike Kravetz

> However, currently the MADV_DONTNEED code rounds up any such
> requests to HPAGE_PMD_SIZE boundaries. This leads to undesired
> outcomes when jemalloc expects a 4kB MADV_DONTNEED, but 2MB of
> memory get zeroed out, instead.
> 
> Use of pre-built shared libraries means that user code does not
> always know the page size of every memory arena in use.
> 
> Avoid unexpected data loss with MADV_DONTNEED by rounding up
> only to PAGE_SIZE (in do_madvise), and rounding down to huge
> page granularity.
> 
> That way programs will only get as much memory zeroed out as
> they requested.
> 
> While we're here, refactor madvise_dontneed_free_valid_vma
> a little so mlocked hugetlb VMAs need MADV_DONTNEED_LOCKED.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
> ---
>  mm/madvise.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2baa93ca2310..a60e8e23c323 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -799,21 +799,29 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>  					    unsigned long *end,
>  					    int behavior)
>  {
> -	if (!is_vm_hugetlb_page(vma)) {
> -		unsigned int forbidden = VM_PFNMAP;
> +	unsigned int forbidden = VM_PFNMAP;
>  
> -		if (behavior != MADV_DONTNEED_LOCKED)
> -			forbidden |= VM_LOCKED;
> +	if (behavior != MADV_DONTNEED_LOCKED)
> +		forbidden |= VM_LOCKED;
>  
> -		return !(vma->vm_flags & forbidden);
> -	}
> +	if (vma->vm_flags & forbidden)
> +		return false;
> +
> +	if (!is_vm_hugetlb_page(vma))
> +		return true;
>  
>  	if (behavior != MADV_DONTNEED && behavior != MADV_DONTNEED_LOCKED)
>  		return false;
>  	if (start & ~huge_page_mask(hstate_vma(vma)))
>  		return false;
>  
> -	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
> +	/*
> +	 * Madvise callers expect the length to be rounded up to the page
> +	 * size, but they may not know the page size for this VMA is larger
> +	 * than PAGE_SIZE! Round down huge pages to avoid unexpected data loss.
> +	 */
> +	*end = ALIGN_DOWN(*end, huge_page_size(hstate_vma(vma)));
> +
>  	return true;
>  }
>  
> @@ -828,6 +836,10 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
>  		return -EINVAL;
>  
> +	/* A small MADV_DONTNEED on a huge page gets rounded down to zero. */
> +	if (start == end)
> +		return 0;
> +
>  	if (!userfaultfd_remove(vma, start, end)) {
>  		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
>  
> -- 
> 2.37.2
> 
> 
