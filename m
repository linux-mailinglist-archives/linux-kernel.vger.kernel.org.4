Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB31618330
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiKCPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiKCPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:44:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4C63EC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:44:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FYMtT024124;
        Thu, 3 Nov 2022 15:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=S4n/fz0T5Va3oEu0mWJ9DpAsZM3QboJfJMa5DrFwUog=;
 b=JYXhb/47cDCbnqOkp4feQSG9xMIC2S2Q0jNuH3EP7m8PfRP7Cmr75Sm6GfXYV+cyq4/X
 K9xrv/N/dSJ03nYzx6gVy+3Mk1tcaeYbVlsBTF2ySBRlEhJtzd6xR/oIyGyQhj2harKV
 ny3qEkWC17QMo9/QEAGFKloNGnuW8Oy3GZqK6yqAogM1v9eEu17yvVyVtc0EtSAD738m
 8IRqrWxsGWUXsXUVMWWiPsD8s3Usk53sc8U8zhUs7jFaGecz17STrpzeKED+szj1WS2Z
 6OQMP2U7fhW6aeYvBjFHaxmzKP6IOOJl1qjRl8TcQn91e0iz0lvCMys3AGcl3hULSYRl og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtng06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EvdDa027297;
        Thu, 3 Nov 2022 15:42:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm6se91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 15:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J43AgoFsWnG1U8QuXTM9jI1wr5yNVBKOCd3gf1M7yUiIuGlP99tBtI0tNOeFGF+YUTtHj8Q+ZevXI63YkPhT0mwKEcbyAM6lhIirFMRkgQBjPz0uBzVd0/phkSxejZEebKZ1wLreAajzXS7wXCZOwLup9uTKUwbXt2JdEfCmi+KfSOToVqJFblrnn1sNWaKvF1ewq5JwmMzIuBO9q73P7UQYaG8oprfRslVvFS4DQ5BKn3IMiZZqTE67rpF25MLtQQ3Gnkm59m7wwGdwZp0YcjbfBIOUjv9QIjMOKAAgIDiGYa2rcy84kACRcRPcNvvEN29+OTIFo/JX/m3CXjf6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4n/fz0T5Va3oEu0mWJ9DpAsZM3QboJfJMa5DrFwUog=;
 b=f95v/XWXE+iX4N5Mdydz03YXMAJLu8FrQwCI/jcyCmeeqiz7vOAwIO4VKkp5nwY7PZjkL7WRILjKMXPeE+RQ2JGSwTYoRy3bBfybQfkghxFBc1yej8D2NszA9mfdPqwoRbqFq0JnIW0ZjcQ48bkErJbwAk/V+e5hRDt/u1QqpKjenukbg6LQackxjXUD3xhBJCufl6BG7bip1PWTK2vmK9cGHJQplVxl8Wzxr0fpsPhGZ8t3GkY7D3MkvV3tD/K1CKrqlVCkf/rezcp6ixmSDNKhZUz9QwSvru8E63yrGywMYwPhuwRhtLMLMtzeVk+04RP9inmMiaE9y+bDqv5iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4n/fz0T5Va3oEu0mWJ9DpAsZM3QboJfJMa5DrFwUog=;
 b=QryiHNvo5FjWDsYC4ERxp9sX/b022022R1zVQuGzI53w2oHuDSg3wprf7KRzcq8rgBRBmktqS54lR61WRWFmHJ3u0btdZO6OErhQUVVOVq6MkOkAnLSnn77/aHtJ7eOllTu842AoNU4IZrUP9oBBgO5yWm76V65f7CoN66eOMqY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 15:42:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5791.021; Thu, 3 Nov 2022
 15:42:07 +0000
Date:   Thu, 3 Nov 2022 08:42:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its
 locking requirements
Message-ID: <Y2PhSUnufjkoqSaH@monkey>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030212929.335473-3-peterx@redhat.com>
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe15d1a-0a03-4c8e-f133-08dabdb1f6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR1w0sDayPb07vyxUthI7cEemsFxO4npA3sEl4PY25FT8fpfsm+pnIctZeDOCkSd3xyIVZpyBwtn8JFWR9Y+29hcoKdGIfY4XhvM6Y4ZOgzUP7fbO0/20ZO4c5XKJZ643mhZgvoULV2vWKgrVRhdhlHNlMXUKVEr4w4ydaKoTifHrM1lBFb4E9+LgB1B6ERaBfLFC65BfKJkKvWydShYlABznj/3RQNMR69Nh8bm1wpUtMG4VijI99XYvbrVT97RcLuN6j34rSRHNDMYelm70z7I9qN5olyBQG8KrPF0s5N+JjfjuKHMAGg1cmlbpgnCsVDBosgK3fZLDcogYN+/kk5NKh4ZNPmIy0ACH1xgjdwtbBcpuZQ6K70ebTd2BoFAz0AYliIzCvmOB3RzstVDkzC/knyzbQZfTRxoRi/+y5fcnS5qcYaurE7ebUQiXeKYUP7+Gh56g/kTwsHeSNf/NzT60ZLRoMKLWn9gehgUNsIVasmUT35Uh4KGg1P+AperWD6ZQzeYFDJU7Dq42cnU10LpPKoV60DGMJ3U3PcziePGClm7+4s/u6Mtb2PDNdGuV3SdRiQoQ77ad6fVvqHERBhbS1ucebXRASLKqjC4O2N1jXVsenNvtXfmaNgT2GTHyBWccikk38foVaDA10F8UVi4frgH0bAKYblSPfT4Bp25ybwXWzfI0gUyvWvhyjQmXYoCsJjeTFoKCd/u81alblz01ZkMpY30Mt5+MOhSlJRYrWCZHKm6o/oML8xHnnZj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(4326008)(8936002)(83380400001)(26005)(478600001)(7416002)(2906002)(44832011)(5660300002)(86362001)(38100700002)(66946007)(6666004)(6486002)(186003)(9686003)(53546011)(54906003)(41300700001)(6916009)(6512007)(8676002)(33716001)(316002)(6506007)(66476007)(66556008)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0dGJG4fSr/Z/j7sqKsikfhiwN7+W21no8d0CrLjCWQAgLqjQ+oe1Mlu4RAK?=
 =?us-ascii?Q?scGbhJtZjNeUeceoDjicATtFYkNEH9dpKcNO28zKgTDGuWwWDlTuyGQbGJea?=
 =?us-ascii?Q?Qdnv304dMFnyaUjYTbBRYn8a32c6VArkdolgeW2vPwX9xLCp+5SK+Lehaa3N?=
 =?us-ascii?Q?4GOKRAtXF2zq+bHeaXjTMgtS9EnvUlgNhDk5zba7EAr98oY8S1D0T0z2stN2?=
 =?us-ascii?Q?JZD/qOBtyi7RSuMlz9J4uFheDulMrt9HX13pOdSw+kuGmolfEmUt0FnuIcxJ?=
 =?us-ascii?Q?MDNGm5+aAbtiilwpwN5LKYQegNNkdBCxy310fNiuxbyJUOz9+W/1M2RYD/Pe?=
 =?us-ascii?Q?gHwd0Ek5VTC92w0eZDMGrkBw9eMOavejq4mSSID6DMUlRM+aAXR5ElNHRZG9?=
 =?us-ascii?Q?hqjZFywZRf63RgEWZHSC2vCak6+LFsyB4w8NBYgJketNJ5m+1UBv1Ub0mEJM?=
 =?us-ascii?Q?gX8nINsg159Ny+dqol/MAN+bkO6diazPFdYseLqG1kDASWM8U/i9+NM94bi2?=
 =?us-ascii?Q?9uXrkogaozxpp2gP0tdRX8BxX3yn0fhy2MI0QI0wEEx0VFUU3ZzDlK13tWq1?=
 =?us-ascii?Q?pBA1qyDW68Raof16OFEQqhlEr4gLp3WGOdULC/FnTJeznXbZGZfN11LO6jaU?=
 =?us-ascii?Q?DRdUJ/jJBro/Y86TL0cpAkGEfgrMpKFgf4hpl9U27lk/la0c3tBYKKB0bqLj?=
 =?us-ascii?Q?AJ1Wr78uE3Ngj8ROqbR7bkg7loZEZl4Fk0g69YY6KLjlUAUM3VPv1Pb32Aa8?=
 =?us-ascii?Q?mj+VdcTy3KcWZntO7UhMly1QtF0pL3EplXb/OFMqtUcuJSWYybXp1caDS3L5?=
 =?us-ascii?Q?3DIZ7a03ltJPXna2ScLFZ/zrnL7gInJCJkN3XmZ7VzuCZvUOanqfHQUSQZpe?=
 =?us-ascii?Q?yDcWDmEP7YVyhZo+y8IK31/l5r1cuEOpPIp3UhtIrSt2yFZKWgQnAJknRF7o?=
 =?us-ascii?Q?Oo4rSDqBoJeBeCz4RI5f/J75mABOqJmPO6PC/Ygi4qqcmypq3EPPi0/ueF03?=
 =?us-ascii?Q?Rx3NTUs6P1vJDXSKNumbrMqu3n/iMAowukWH2whC7EdJyOWov5rAHhisgjIj?=
 =?us-ascii?Q?KWFMuU/7LnGcVasMYOImf2dcruCEvYcjhb7P4SQDCz1DKnxggVvXU+ABDVvU?=
 =?us-ascii?Q?2kRHAEojh6C6mn9xnwmmTkJH4C2thsG6D2YXaN03XhOxQYgbA/akNeBzAVOe?=
 =?us-ascii?Q?RcX0Nd0GxbkhpwB1RvM+/90OBcR4wxaBGxakq3qkHUOKGCxMVtpmMOQb0mAP?=
 =?us-ascii?Q?NI+u74KdpEwgIQdoMD+s6tw7QzyX56s6K3DjGq3bVf5o+7FlMzftc6r/OXK+?=
 =?us-ascii?Q?0GP8rx0r/S7TIJH1JNuKSVO+b+y0130RETVQ5Mro5Yj5Icx+vaBOsxvt2E2p?=
 =?us-ascii?Q?MxZbuCNu+RdDrlIMie5LvxT+JX/92ws/Ygqe8yoKu/OyQOzKZGvuzSVYUBVs?=
 =?us-ascii?Q?kza6d2o/e1ExvzNxlHfgj26a7ddRP9KKmpxcLprHXhwkthX8cHqTnOsBqxld?=
 =?us-ascii?Q?8feT42I2YsoX5R5YsM3Jpf3Ej5a5hwsSZk9FMkKGbA1Odb0DD2LLdkdX7ze/?=
 =?us-ascii?Q?JERpmt5qNO5ENtA27E71tJy9k4hHASOnBtUUH1+ckFEqxLeCtchq7i9Ufz+H?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe15d1a-0a03-4c8e-f133-08dabdb1f6d6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 15:42:07.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/B7ajbOvmS+K5T3q92cHz3R9x+RMaWJOtT46rmKk8tRhcWiDNswazcIOERZk24GrLuBOir1jI8Qrp9fTSSTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030104
X-Proofpoint-GUID: EFQhvhdFnkC2Q3-BNWZyXg7s3N8vEYts
X-Proofpoint-ORIG-GUID: EFQhvhdFnkC2Q3-BNWZyXg7s3N8vEYts
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/22 17:29, Peter Xu wrote:
> huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> hugetlb address.
> 
> Normally, it's always safe to walk the pgtable as long as we're with the
> mmap lock held for either read or write, because that guarantees the
> pgtable pages will always be valid during the process.
> 
> But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
> means that even with mmap lock held, the PUD pgtable page can still go away
> from under us if pmd unsharing is possible during the walk.
> 
> It's not always the case, e.g.:
> 
>   (1) If the mapping is private we're not prone to pmd sharing or
>       unsharing, so it's okay.
> 
>   (2) If we're with the hugetlb vma lock held for either read/write, it's
>       okay too because pmd unshare cannot happen at all.
> 
> Document all these explicitly for huge_pte_offset(), because it's really
> not that obvious.  This also tells all the callers on what it needs to
> guarantee huge_pte_offset() thread-safety.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 35e9a468d13e..0bf930c75d4b 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -329,6 +329,38 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return ptep;
>  }
>  
> +/*
> + * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
> + * Returns the pte_t* if found, or NULL if the address is not mapped.
> + *
> + * NOTE: since this function will walk all the pgtable pages (including not
> + * only high-level pgtable page, but also PUD that can be unshared
> + * concurrently for VM_SHARED), the caller of this function should be
> + * responsible of its thread safety.  One can follow this rule:
> + *
> + *  (1) For private mappings: pmd unsharing is not possible, so it'll
> + *      always be safe if we're with the mmap sem for either read or write.
> + *      This is normally always the case, so IOW we don't need to do
> + *      anything special.

Not sure if it is worth calling out that we are safe if the process owning the
page table being walked is single threaded?  Although, a pmd can be 'unshared'
due to an operation in another process, the primary is when the pmd is cleared
which only happens when the unshare is initiated by a thread of the process
owning the page tables being walked.

-- 
Mike Kravetz

> + *
> + *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
> + *      pgtable page can go away from under us!  It can be done by a pmd
> + *      unshare with a follow up munmap() on the other process), then we
> + *      need either:
> + *
> + *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
> + *           won't happen upon the range (it also makes sure the pte_t we
> + *           read is the right and stable one), or,
> + *
> + *     (2.2) RCU read lock, to make sure even pmd unsharing happened, the
> + *           old shared PUD page won't get freed from under us, so even of
> + *           the pteval can be obsolete, at least it's still always safe to
> + *           access the pgtable page (e.g., de-referencing pte_t* would not
> + *           cause use-after-free).
> + *
> + * PS: from the regard of (2.2), it's the same logic of fast-gup being safe
> + * for generic mm, as long as RCU is used to free any pgtable page.
> + */
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz)
>  {
> -- 
> 2.37.3
> 
