Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7460E920
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiJZTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiJZTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:41:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D786FB2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:41:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QJMYts014921;
        Wed, 26 Oct 2022 19:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=pGNW+DbdsowbQfT6QRsJkRrUH0RDBc4wkFWROXB6cKo=;
 b=tKZGj2V8DNDoBKG/j0MBjmxvwBIwJnchpmvTRHS+qxdvtTCfxpfVh6icxnXy4B2IfN5b
 bUd9zk/AVY6zAcvbcMoJxyvfZZ/w3PN+J5MybIPyyqSiU6QpQfBdnp14HcczwdmRjJfC
 K2vrGP8LyQKHc0tmProacKgV6sqK8SFcrtt4a1ZJTIgrTYjE+SNIFNQm6uptOr8r701E
 9u4zaGJmoefxF/19LOiCf9OTxDYKj1ATp86aS12OqM59F994AUSmB/9Qg3ajN2dfk434
 cTdvyqBTPH/ZZAEo88GChPQPD9ialXPsR/sOdHOew+udW3ZWUZwWoD0KyCWHqNFs9opD pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ag1mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 19:38:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QImmRq006899;
        Wed, 26 Oct 2022 19:38:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg988q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 19:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCqNCzxqQG0arqAF5C1kDsy0+Y6XTg72Pe1I9EKgD+W0UB8VlZBx/UhjU1rnqB+LYBOxT9J57+hPgBxPTQ0/oomV1X2do+FsLwrjG+sFah9xrYsGCVEAmPtYKMsIQb0Ufiwqx1RDZb0V+mzXhhFq7c9ynxJUTEviG9yM/wXET7pMus//V8SJ9tFvnJe/6tOrdC8+EHxBHYMA6c0OL1lfeNVDEeQ+7zyT/j+wx7l2jE7pS++jdUw07kB6ve1NVWdpAAQXqdS+DLDaOUUDMu+grySiafjUOhjcvEGWz6mb3W7EHZYvp7uAbn2HdbCM2dlpK8YTPDZNTFQeUs/f1geyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGNW+DbdsowbQfT6QRsJkRrUH0RDBc4wkFWROXB6cKo=;
 b=n6vG5OoHkCRU0mP4HdAtLlym4H7NfPPbDFG94NE5CAYhCniYMqia94qXRtxqeXudTDTWjOECh3kD9PxVbEcJb02j5DzAFyLDp47Oefj4xGo0ouGulKyABXU+X7Qu1hL/wqwcBKJxbYrZRbJ6EBW15R+5MGiNjnFdDTOGziqA0SKUiUok7c8OOkYDHbMKp7GLa0QJCd3Hbuz9DGiS5ot84OoqznzWkq6/vxHsmqkCV17pkSUxmTPZTLvMCpmQyux78NAsPGe1c/1kmW+C8Zp1+rtBrJ6WaIOD10yB+mYwqNk6FksHNw2G6he2oLmwjP5LI6l9OlOf9bWi7JplRa4qFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGNW+DbdsowbQfT6QRsJkRrUH0RDBc4wkFWROXB6cKo=;
 b=ucyZEeCKY+hkocGS3ZxilaBJMDui5HVIaa0dFlSjYLJx4Xd1YIFBA4E0LY3B0PjH7XnSOHV3NcjiauefMtzmTZJoeoYu0oQ35AnIxBndkZca2ydz4f4/nfgkngWVJ53QN0EKwDifbAhpXBUYAjFO/m/kHIviOTPsrHbHqJRps/o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5610.namprd10.prod.outlook.com (2603:10b6:510:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 19:38:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 19:38:49 +0000
Date:   Wed, 26 Oct 2022 12:38:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@meta.com>, David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] hugetlbfs_no_page vs MADV_DONTNEED race leading to SIGBUS
Message-ID: <Y1mMw2mt0my0qVqP@monkey>
References: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215d225585ff3c5ea90c64e6c9bdff04ab548156.camel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: b3efeb2d-8de3-43b9-9041-08dab789b467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJ1sNEDo+quF6q6Yjub/wgJdlG8qFAk7ncXXS5XsAF5dFzItpHKjVAASl1Yg6iOe3I6f47rMynJycRFKQhb3NbqID8hyZXhhNY1MZ63Y85pbmqx2Xv8Kl3k8/vCegj2W8S/Zz/I3J4dsp4yz/QT0I091XSFyLt0u8PkiP47z/9n+LykBSwxB2E8hgEAQZRFt9I6AA3ioYDT1Wl2QJsZonHCpTSedFUNLPXXxBqOWKuLyiuxtHnREUOt3emx4YYiRsy5SNL3ekQ7FgUmgJ2RPCXf03J8qs/p2mqt3rAFOeVrUW/jiZRZ+De9zGF3Ud8ybkXyw/INTrn9NL3t1Rtin18+FOQSkf0Y0ge3M7oJFxNY3dH67FygaLvdunDMS4H/09dFF1r9nK6jUDK3CynacIYnE7GIiKS6O1hVzu6Hy5WG/sGkVWENACQ3JUf54uGTDp1XF6J8+NJkG0ku8FelLym5c2RjOLtY/oa/KW0B58JHq71iL98nLHlYXhKNDYzIxJxRWvISqwrR3P5l1LCfBbvgKkw7YKwfZ1JuymULUlMpBLFBrvgiKYLcP1W/Ga+C0cLmbdDpvywk8dX7Fr/ce+BnO4JzWVE39AZCIZ5RLlMiJ3Akhspk5GrYuC6r0WQMfGopApBlelmPci+L+9ZJBPpLvBjEy0/X0IGM6BRxnZixCd/18f9i7hUHZOx+r59JIdgCe7ECGYiE+6d/JHZU4hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(53546011)(6506007)(9686003)(6512007)(66899015)(26005)(5660300002)(44832011)(6666004)(8936002)(4326008)(2906002)(66476007)(8676002)(186003)(66556008)(41300700001)(66946007)(478600001)(33716001)(6916009)(7416002)(83380400001)(38100700002)(316002)(54906003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7a2WiUO/3CcA3+XgdrfkUgdMSaiwqzMQ9Bv2GvBNYO6vfzwb3Y9R8QJFyBfn?=
 =?us-ascii?Q?uHOCrGknonj6QNuJ6nvn3BunY1NeEd9b5H21pBqcPPmIOZKHarI88LxsYtCP?=
 =?us-ascii?Q?fPo2llf/KE0NLW8Vh0iJlCem1ONi1QHCBOgnv4gm/JvWI7LhxnwSqC7VVgVp?=
 =?us-ascii?Q?b30b/qvvbzqvjpFuGPc0zmXFWyPMJ95lQiU9+B89otH2+OKpQvgLlZGfWAku?=
 =?us-ascii?Q?dCyPoxRYaICB75PlwlQ5t2PlaE72H5ValXbB11zuQcHZmMWouEW9dTjEmVVa?=
 =?us-ascii?Q?kveiTqPt9wGF53RFFkOjQAj94b0ij8USRbEnxnAejVKyakCs2feld0ZRZWDD?=
 =?us-ascii?Q?rT/VHkolNwD/wE+yIJU02hfmKyg/m74gLILAzSgpyOFqIl2xraui4XxfHDxO?=
 =?us-ascii?Q?RDRLdz4xJ+HsAhSnykY6rZGzhMT0pIArPB+ROAO03PK2OdJZnff0yeInw5Sb?=
 =?us-ascii?Q?xKFHcd45Ip7E5Ly6WQ6D+TCXk1QbCsWoaYINx7XFcQ8at17pmVJH57sAqMkh?=
 =?us-ascii?Q?zZvacsvHYiEbwiaxGja+TifcGQzL5M3v4OZ15eASposLDHVs8JjCWPH35eQc?=
 =?us-ascii?Q?HKGzMj0AvOETMAvAkqTrfQiW/RTrDsSbn2tgNyHT9ITnMzO4HSMF0eNazpXN?=
 =?us-ascii?Q?mJiGaZsBLjWU7t6nhgMmcdrZmICtBIgtGchC8qlEnIfLL6C3iwOJNn0ZbN33?=
 =?us-ascii?Q?zRKNvYw7vjlRCMPVBeZ4oR3lFK4F2lO2XreK4RfEGSg+1W8d2v3cSl8lwd8o?=
 =?us-ascii?Q?qlnIMHGJJLjrGdiiLET6o6Rl6ZjG32Sf+1lrWsNr9Zocwh81QWVwGDEwEqy9?=
 =?us-ascii?Q?hIN4fUWo0ZemAp7CVAdxHwseW3JT63BxJyV5i28LmuA77E9wDYiX0qxSBSfD?=
 =?us-ascii?Q?ZrQsty1tnHrKzInCysRsqPntckAadtC2wzrGNNH/2zkb/Cfqv87q4vbk0Y9/?=
 =?us-ascii?Q?fUFvVqOE5Ri4On81pTTDWnI+RjIwdKO55c2zWSvo7EC037uZXbywSXaCAJei?=
 =?us-ascii?Q?XrH/GJxlIrk4knTzObh9l4eg+m8HSaxQDVgsh/TOYmM8VrYgyaVeQSV6J7Gl?=
 =?us-ascii?Q?rn5oqiW7x0DoYKUrBK+O7Oyf+6TAZaVFOftCRSKDoLM+kOse7K1yYp7lRpiS?=
 =?us-ascii?Q?CYYFd4JURa+ESfCifHb4+HXgPAZgk3ehhxl63VXmvjt1yifiHAB04pfoSRIa?=
 =?us-ascii?Q?YkPLmtFaXPCy48Ol2CQZBOc6XbAezSvIvt4g/wgCC4Z4vJDe+N6x55DODiuE?=
 =?us-ascii?Q?o2bMEqFK4ZxfDgkI0GnBrk2WAY7AGmLSee7xwEVlVlfscv+Ee4rvvz9/QQmf?=
 =?us-ascii?Q?hBVegfdF3FMh6nDCdNppppeXEU32Yx35wB2YVjUpWFvUxsjBMytvLQGuTeXe?=
 =?us-ascii?Q?BFJSUvyivpnRLeRLblDsHPVlGhLAWTMl7gWAMke2DDgpLP2gINz3XOGD60C/?=
 =?us-ascii?Q?VHenT5kRYM1QxbaBvGmPeIObNkVG95jtPO/5RysjFQDotfzc86Z3g7+a4fpO?=
 =?us-ascii?Q?c6O7/5Lrtev/1Lxjqo433ttn7vOuuZasx2DA/Nru/zfvI8vZRkA9yf3OHd1W?=
 =?us-ascii?Q?SDgLyz+8ASeH0Zh+Q7jNmYszu7EuR1M0Gt+/LCEVsk1qtbA/wIBBABtX7sfF?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3efeb2d-8de3-43b9-9041-08dab789b467
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 19:38:49.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWs5ZjFTNkLh+Mh2/O+j0dnV5qxJ9GJh5rjle454lM9djbqsjhY5cPTYlfL9Fc66RO4u5+cuAeqmSPQgn/4/Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5610
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_08,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210260109
X-Proofpoint-GUID: 8fO82d0IyjMmCJ6bkjO6rFw9KJDGk1Wc
X-Proofpoint-ORIG-GUID: 8fO82d0IyjMmCJ6bkjO6rFw9KJDGk1Wc
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
> 
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

I've had a little more time to think about this.  Sorry about the noise
yesterday evening!

My assumption is that you are still working with library code that gets
passed an address range and is not aware it is a hugetlb mapping.  Correct?

Part of the issue here is that hugetlb pages are a limited resource.  As
such we have this somewhat ugly 'kill with SIGBUS' behavior if we are
unable to allocate a hugetlb page for a page fault.  I would expect
applications that know they are dealing with hugetlb mappings and call
MADV_DONTNEED to at least be prepared for this situation.  I know that may
sound crazy, but let me explain why.

The first sentence in the description of MADV_DONTNEED says:
"Do  not  expect access in the near future.  (For the time being, the
 application is finished with the given range, so the  kernel can free
 resources associated with it.)"
As mentioned, hugetlb pages are a limited resource.  So, I would expect an
application to MADV_DONTNEED part of a hugetlb range so that the pages can
be used somewhere else.  If the application has need for pages in that range
later, it should not expect that those pages are available.  They would only
be available if anyone that may be using those pages have made them available.
Some type of coordination by application code is required to manage the
use the limited hugetlb pages.

In hugetlbfs there is the concept of 'reservations' to somewhat manage
the expectation that hugetlb pages are available for page faults.  I
suspect most people know that reservations are created at mmap time for
the size of the mapping.  The corresponding number of hugetlb pages are
reserved for the mapping.  As the mapping is populated, the number of
reservations is decremented.

Now consider a populated hugetlb mapping, and someone does a MADV_DONTNEED
on a page of that mapping.  When the page was originally faulted in, the
reservation associated with that address was consumed.  So, before the
MADV_DONTNEED there is no reservation for that specific address within
the mapping.  In addition, when the MADV_DONTNEED is performed, there is no
effort made to restore or create a reservation for the address.  I 'believe'
this is the desired behavior.  If a reservation would be created as the result
of MADV_DONTNEED, the freed page is not really 'free' as it is still reserved
for this address/mapping.

If we believe that MADV_DONTNEED truly frees the underlying page and does not
create a reservation, then getting a SIGBUS as the result of a subsequent
fault is certainly a possibility.  The situation you describe above results
in SIGBUS because the fault happens before the page hits the free list.
However, even if we hold off faults until the page hits the free list,
there is nothing to prevent someone else from taking the page off the free
list before the fault happens.  This would also result in SIGBUS.  Do
note that all this assumes there are no free hugetlb pages before the
MADV_DONTNEED.  This is why I think an application that knows it is
performing an MADV_DONTNEED on a hugetlb mapping should can not expect
with 100%certainty that subsequent faults on that range will succeed.

Of course, that does not help in this specific situation.  Since the
application/library code does not know that it is dealing with a hugetlb
mapping, the best thing would be for the MADV_DONTNEED not to succeed.
However, since MADV_DONTNEED for hugetlbfs was introduced there has been
some interest and desire for use.  Mostly this is around userfaultfd and live
migration.  So, I would really hate to just remove hugetlb MADV_DONTNEED
support.  I have cc'ed some of those people here.

> What are the reasonable alternatives here?
> 
> Should we see if anybody can come up with a simple solution
> to the problem, or would it be better to just disable
> MADV_DONTNEED on hugetlbfs for now?

Here is one thought (perhaps crazy).  Do not allow MADV_DONTNEED on
hugetlb mappings.  This would help with the library code passed hugetlb
mapping.  For the use cases where MADV_DONTNEED on hugetlb is desirable,
create ?MADV_DONTNEED_HUGETLB? that only operates on hugetlb mappings.
In this way the caller must be aware they are operating on a hugetlb
mapping.
-- 
Mike Kravetz
