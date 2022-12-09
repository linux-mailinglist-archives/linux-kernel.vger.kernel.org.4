Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9AC648AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLIWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLIWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:49:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED283629B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:48:43 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9ME8XL004171;
        Fri, 9 Dec 2022 22:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=8yAX/UqxijgWR6eUlAP7v0mGuP3tWHRLlPIEDobQ8EE=;
 b=VmaBpglL433L3bqTFmirGyLq9ux3GNve+7Am/BqpvmNpP/j/vE7GL5XaWKOvJZeWk2Qd
 Mb0DvUX+ZU7Us23PYu5PJsqoEdmMVMMNkI76swxQlX4qK/4nFhrlELYGR/VQrXiemc/Z
 DvRlL7Grs6xbwN6bxn3HoV6QUAjrwDOxLclgqcoiuZfBos0oa2lzq88vLKEs01MUTPIq
 kVYAJ98DKYS2jx8Nr+B63v0/M9BmUZz4ZjwwAjS2Nk3sLzj9grpu4M6lUZ75X/dSK6Eu
 7ldqAot0rcUazuwP02KuQ2/WPubyq2sx0Y9t+Bij7Nc4Fy00wGKBrMQ0hpox0c0MLhBD 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maxeywftj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:48:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9KvVMV039815;
        Fri, 9 Dec 2022 22:48:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8m9k8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5fljBaPh2FErLPFWpLq9qZGGd2tfavhFhdLGUIpDm9g2fdvKjcYW0Ogy5iZKt+8xWiWMVO/73554CvM8OqSnyL80Aa//TaBmqISyL0Vo22XjNh0LgwNiJxtAX6iUOUafty6ro7CI/oo+IFupgDo9KolBH6LCwMZlIFQU2BjZydIhyLs4oGBi2qJAgv4dvniXAn67rodMYjpuZnvrjiCiBXmiVVXkOZwloe4acg+Kn3dBI4eOD9fqmlB+Fj0LfQ4CIpPgRgRIMXJYeiNSjhnhkOzpO0nDg1a8g7VjodhnRyNGjYtP0+Ta43wtoN8+PKpkcAcukuTwT8bEfpKi+VvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yAX/UqxijgWR6eUlAP7v0mGuP3tWHRLlPIEDobQ8EE=;
 b=E79uishBjykQ/UfEnCWCaGYvIKc+bSPy/dovJbm/yCGuAXji72FZUv8rQRkmjI+/uSh81kDD1MEixPzPony3BPVWljdijl6HT603Lg+QbxWH/+puebmR28/Kx8bnTIAUTS/OUb4W8gVxEBrGIeYGOoQ6JxlXmAu76pGZwnOM0rX4m9P+1yJwCXLyHVxSG+26SEpMDz4+In5qcilyDKQGYT7mOu3jzUBMcsW5wwFRe3Sano+2yQPW87mwU9F9Zu3mTXBPbucKlZqifz84EBnZ3eZrJokfNa5Z0wMXrBCOUUy4CtfhLJoGprrXCXc/8XM60J5Z9WLK/9/kVAQioiFuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yAX/UqxijgWR6eUlAP7v0mGuP3tWHRLlPIEDobQ8EE=;
 b=gad5hPxgmthc2KfSy9wtPMnWQg01HZE5nomy4Gy8Xs2+UfRBfvO/Jc4S/oxrVvgYyM+RB/gfKND0TF0b4hnuW1madl5vckBRYti3HjImmA2G+cGU5JgSTpEwwocKmmI2RZvuTHAxuTJGPRKJSW4HRpTMoOKYrStLrhQCVF/Ws0A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB7345.namprd10.prod.outlook.com (2603:10b6:8:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 22:48:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 22:48:07 +0000
Date:   Fri, 9 Dec 2022 14:48:04 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [RFC PATCH v2 06/47] hugetlb: extend vma lock for shared vmas
Message-ID: <Y5O7JOlyPnUz9IAn@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-7-jthoughton@google.com>
 <Y4fEkLkbYr7qfPQA@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4fEkLkbYr7qfPQA@x1n>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: ca61597c-d204-41b9-2d28-08dada3770b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJk8dYY++3YOGUcTnmsI1Eyy22CgnX1ym/hf8H6/7vO9utE2ZQaVJsFqQfGE60as4ECk6DcstM7yZKqfyDdNKQ4NYCh1iIxkYOK74d2gcUgWpHxcZGmCXaH7secDKSWL9deJDPFT5nHg9Fjdf6bKvmnx7KTol44N9mEkDRSdhdSugNjXe8pkrdWxpOirqDVYYpinGDBsRMT8sicfV9nfoc5/GUlt9GbubrWPJZuCy6rhv7nL++AcswUh6H3+QZ6y0nMGXDP1haQlj5QxpgtCqxapVtzWcBS1Tfa3RmumMGIVX+K750iMKVtO5wDxgR0mNHV44ssYKqq0dxpXfRUg+NTKMfOZXSo3NvsrrbNaWFOUfMOegnMyzlQM+if2glJF19hXwXQsNqHR2ZhySs/TXoRApS6IHm98UYfRhKvvfMAZBGZVZzycJnQ5h7On0deUCYRLWeGLOELULQN6T2/lYq8T3f5hVj1oAbXdWpOeqLZkNMwNOss3l5mTt2Kf9jdSJU+Y2lmKPQtpnSkYEwJ92lg7atup4/izkjNKbrXxFzGWcb/eoG9GVtnu4O6vgbcnEptJTZZFHAumTIktjskUgJKgLrYQKJZIlcZnbBCYtXJyo7m+D7fa9KZjlfNMwF8Vz+5uByknvVFNie8jhUvwTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(6486002)(38100700002)(53546011)(6506007)(478600001)(6666004)(186003)(33716001)(2906002)(6512007)(54906003)(9686003)(83380400001)(86362001)(26005)(316002)(66946007)(66476007)(8676002)(4326008)(41300700001)(6916009)(44832011)(8936002)(5660300002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mf5kigh+TSYT1lVlboo6/lNmTA1macw3FjdWOCeDuIzvCYoYJdRMZ4HG92Yh?=
 =?us-ascii?Q?Lv2UZP0opOyzjoZfz37jYf7kR5PgxH0HRRZvTSclhMb9KVEzuBfr2IAouHFV?=
 =?us-ascii?Q?81qfyNj0dMd9D3QPT74IPfQN9NFwjKL5RaqFSBkkaZG8B5N5VH0XZ+SIn60S?=
 =?us-ascii?Q?VmB6t+8/MvCTR6H+oF2gH2dedJWFnZlFZxyolK5xCs+mjDR6tkAfeLCNUpg5?=
 =?us-ascii?Q?ESoJ1CHRQWwPF/uMVeEjl32+zwkfxjtukOJPOarSRzgRxaRV4DOtmmCOlYlI?=
 =?us-ascii?Q?+2aWyLP1aD2h4EBERbEtjXn3JdCNBX8N0UnzFicZ90PN9rnNwvWcdqp3ZvjM?=
 =?us-ascii?Q?QgwzIwTBFtln0+bpX4PP4miaCapFwZOT8U8zSiyoDF1eSpgxlXWzA4q4ztas?=
 =?us-ascii?Q?AAsaMMxGvEGK1Od6pm+yxKHL/iRpsMms2ZQLGNt3dzaFFUvb9gKlDjRNNeYU?=
 =?us-ascii?Q?zLCDEQU1ZnwxmFicqqVIlV+k6XF3iMyotOWfP8HAiacZYqXFvZOi3MIPXglD?=
 =?us-ascii?Q?6gKQvnrbpXabv6iLZYKjGYNth3mgpThC0U8X9O1YJ8JEvtQ34qQ+FOBvUn72?=
 =?us-ascii?Q?4K4To+NNcAXu+oN+Ht+5iUJjUve7RBSv1/s7Kb5BISenL0a4py0vQTa9D4p9?=
 =?us-ascii?Q?STQhwmssSaHY1VKJt7rG2fjyHS3VES2c6I2uPBFa+WdRE3ftwLL3HkQIvi0M?=
 =?us-ascii?Q?msQGaZAWtAV+sqFQWnE8ILfn7sH84h3bZ3hy0El2fxI6ej+IVKavipGUyF5h?=
 =?us-ascii?Q?ebsq5skYsD36T6kwkdxJpUhWIJloUSMH3ifXJYTELF508E+YPjcNRFlw/Emc?=
 =?us-ascii?Q?XxwNsca22mIgDebszTgOlWnqr2HySMG+cEkJGuu5E8r3Nbw9XY/DH5B9QWLW?=
 =?us-ascii?Q?109ihJCBo9jNq72Slv9li59gc3Gc4vSGLSHjIuWBrLHKiCSQithdlXltvgwg?=
 =?us-ascii?Q?HAHoV3/GaTC2aS2Mf6VK2gFTKasHayNfJeN60djpu+metKjUW1SeeX3/uxCY?=
 =?us-ascii?Q?qLYOICSEiJqAQZaCuna/4SlNqDFn9aip2ADUUiQmhJ/DiWUQrJTMTs/h1shd?=
 =?us-ascii?Q?4QvkQkPXe1D3TcTeAxJpArSgiN4xFVY+otTqbQiJY7H0lSlyQLSmPAmAzldZ?=
 =?us-ascii?Q?J+QtfuXSec7gUhlxOhOPHq4hM1Vdp9uyGZr8gg7PDAry6ZcZeRDQUFrXTAOL?=
 =?us-ascii?Q?mpGpVpOF/q9P1PWdstxOq+EWrr9ArddwEe/F7F5YTFdqplmHSqPtXpZqhR2k?=
 =?us-ascii?Q?Kg+Fji9P6ieyfm/KUZ1E/VFtOA7vdNqOn4EwuzZbnY0rFZmVqC+Yebu9j+iO?=
 =?us-ascii?Q?pzCKFAuj206q5vkA4Pfjw4y63iMPUV2VVvhGAoEPYYSGj5+II87dfqVWLLwY?=
 =?us-ascii?Q?3pZYsFxniXrvbfCpzeaN7YDrzpyMaopGMYbm3drOBoqiLYdoZT0fM2U+TmXg?=
 =?us-ascii?Q?boqqs2GY+hLInlanzdDDIUaVE+zHYqu/sen6Xa18C2V75CheMxyzqeFToYsd?=
 =?us-ascii?Q?f7kLkzgpPgMUo2Zcu54quyB/xzxYPhKsQTjAi/ATs7UuPm++MoXZ4xRrbq/t?=
 =?us-ascii?Q?1AYU2dwpyIOjZJca5+9YU9njNgrCLfyYt23G0ty7NbcbhORtMbMbVNMdDOQG?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca61597c-d204-41b9-2d28-08dada3770b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:48:07.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjPNGnHzKpKIfSkIKa6abXI7QV/k3ZEm6AUsZmDealyg1FFrOLhFqatuCLhEjjH0v16gHL8bmKjRzL5AFOAkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_13,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=870 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090187
X-Proofpoint-GUID: 1fvIq3uRrk1GDMJaDHNmfTVTumvYb5eF
X-Proofpoint-ORIG-GUID: 1fvIq3uRrk1GDMJaDHNmfTVTumvYb5eF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 16:01, Peter Xu wrote:
> On Fri, Oct 21, 2022 at 04:36:22PM +0000, James Houghton wrote:
> > This allows us to add more data into the shared structure, which we will
> > use to store whether or not HGM is enabled for this VMA or not, as HGM
> > is only available for shared mappings.
> > 
> > It may be better to include HGM as a VMA flag instead of extending the
> > VMA lock structure.
> > 
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  include/linux/hugetlb.h |  4 +++
> >  mm/hugetlb.c            | 65 +++++++++++++++++++++--------------------
> >  2 files changed, 37 insertions(+), 32 deletions(-)
> > 
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index a899bc76d677..534958499ac4 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -121,6 +121,10 @@ struct hugetlb_vma_lock {
> >  	struct vm_area_struct *vma;
> >  };
> >  
> > +struct hugetlb_shared_vma_data {
> > +	struct hugetlb_vma_lock vma_lock;
> > +};
> 
> How about add a comment above hugetlb_vma_lock showing how it should be
> used correctly?  We lacked documents on the lock for pmd sharing
> protections, now if to reuse the same lock for HGM pgtables I think some
> doc will definitely help.
> 
> To summarize, I think so far it means:
> 
>   - Read lock needed when one wants to stablize VM_SHARED pgtables (covers
>     both pmd shared pgtables or hgm low-level pgtables)
> 
>   - Write lock needed when one wants to release VM_SHARED pgtable pages
>     (covers both pmd unshare or releasing hgm low-level pgtables)

Peter must have read ahead and knows that you plan to use the vma_lock for HGM.

The commit message implies that a you only need some type of indication (a flag
for instance) that HGM is enabled for the vma.

No objections to expanding the structure as is done here.

If this is the direction we take, and someday this is extended to private
mappings we could used the same scheme to expand the reserve map structure.
-- 
Mike Kravetz
