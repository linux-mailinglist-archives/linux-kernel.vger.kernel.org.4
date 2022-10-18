Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6C602185
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJRC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJRC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:57:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8DD98353
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:57:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYC1o030194;
        Tue, 18 Oct 2022 02:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Rd/MheiuGScuD6M/DehpW5sjsjoemrcCGRRj0hCBCnw=;
 b=k//oDn3ekvsNmao1aRHiqmLJrh5WPcm/GzH6CfSafVJBkfUKySGTPqboSAVxFyBkKYsU
 orsFyqxASLHKpauzt2BcFHnkehmcsMzmOm+s1wVyQ4Zbcx5AZQ1L1SAKb7O5nBlQlvw7
 U1q3wVIr/zFLqLzc2+gTNnw0UZXWeBLZF9pDbzpDzp3OVsHyfkczG8/9m2Msj6mZTxVA
 UWdj5cOPfbd7pA6t+DR5Qo2EsuxjxAlHcetU9bCpvImnKvUAqgY51F8WJNo2udjHlW9D
 mpR10PDiGG6jtohj0magLrp1zi1MYX4TnGPCYXlHfDjlAnmpnOeI1NK0hL+fBGad62jc fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sh12b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:57:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLttPI015913;
        Tue, 18 Oct 2022 02:57:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqy578q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXm4iBn70KbfENsn2mFt7bOl4zHswb+BbPUuKlmmJRVMXm4pExz4+yiIEPdApKYvSAzxHusr/sQoECV2FlL7F0tJ2lrFJ0OW/45yAaHoB2c/jHCZHJ2wkS4XfrqQN8g3LLR0AhiBGRdX98Bs28FfsYl2h/XpFEAZGUV+Apqpdw6seVYxACgeeaqhgwO0lJ1iwjizx+vou8bIqJWhGH/q1t3d0RihajjBxKe18O+kBkNWyzBZU+LbpHFA86qveXLKL1L44aEMp8qDUADqI3MJ32zXZze9TEYIRK7phEOHWN3Bw/fIovJk5myqu3pPxvBw2YkHaeyPnd9kfxaeFQ4fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd/MheiuGScuD6M/DehpW5sjsjoemrcCGRRj0hCBCnw=;
 b=Hr0rSN9gUFOw91iP6PSxxGcvMhODsF3VggaJqgUgtl89UnBuoxfMDweBPYXk+L58jHm0LYmoowSm88k5iyUIA9Retm/ym60DfkJ2i4sVm//H2tbg8MUemmbM7Z9kf5YZdDe+0ihfqNDHSmAdz+ND8thUg2LkqfPqmzAOsjcSO5GlgWtqHC8qY/MhBPcU2dvXysbsr8WgjVrz6uLlWRIrgcFepQR5UjOWQblZeU4WtUIyQEQ0xRhro+bpS85vGCxouqlQHljUqsXuzWJCDixwZaWRCMlI3RZ51OLzxKRxfneCP1z1ctBbaCtFI0hA3dgUvgHGP6TFU7qFZ5EIZgJRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd/MheiuGScuD6M/DehpW5sjsjoemrcCGRRj0hCBCnw=;
 b=Mcret6KI1yk5jG7dBlSUyKh/xxh9EivZi7hhE2lBaHcSHYqxhzIFhb3eNF9eU1eLr1RnIOCHJoSe+fC/f6/HLVI2SIbvz8m+zNMHF2KE4zvDXGjXae3jUjLdyxwtZRbdmcjbBJTgUlGHlzBJ4iqkNC5ORNM/T5G4GT+ZWJzwzsA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 02:57:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e41f:b75b:3246:c1c7%4]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:57:29 +0000
Date:   Mon, 17 Oct 2022 19:56:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] hugetlb: fix vma lock handling during split vma and
 range unmapping
Message-ID: <Y04VxvTbJTlxWfwl@monkey>
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
 <20221005011707.514612-2-mike.kravetz@oracle.com>
 <5154292a-4c55-28cd-0935-82441e512fc3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5154292a-4c55-28cd-0935-82441e512fc3@huawei.com>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ea0c7f-b294-4af7-e590-08dab0b47ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOksQSyelxcgSEzTy73uW8Gps+8FzBCvarEd/tYsvA21ODZQF3rtgEqwhSwKpPr0G8RPrJPII+rYDKTCce0zlh121aP3YPiBFNhjHn63/QViCu+n/KXT3XuawLkMxbzqJ0Q5VOU39E3E1PyE/7RD50Vgrf5uCUCVqloDuXvtvIpulb9EFoVoFD/q7+GwOeM3DK0QpvJP2lFbXRaP8ndZyPYb70eDN2kCpjdLTgX9aNWqeEJmItPi0mXsUoc9Z1c2mvOvhCirF1egUsOi5NFJJhal4zbC6kJnzQOtDxxObFZkyPvvlaVcNlLblctog8vz4VgdaZr7IVCvZvYI9CRE1D52bg4BzrbysAJMyZq21xxY45D/nmeypuVcRX/o9lO4su+TPuuby8hgJ6j1Vwe2ZMCiBXxk+pfZE1W50wfbQ/Bks1Jq6irt8G9K2J9qvHc17s3F+z+2epq0lvh+FcWu1T2rxuFVIesx+L52Y6Gv0NkPvfhfwQGZ6QugI2QKwAzjCjd3u1qSLPD6cdF+cEN6MTA8XW5hnjm7DF3cnk1RDD0XmVjqozEDtpG1QevPl9E49sqv+icLL/mcBK2qWs6gK/EfRt+sI5jVJOopy8K589RJMj9Yeg723t07WUDE9lQH3tPmEsii1TsaluffN3bP2v8rKg1MQOQ5liYKVOLECadzlEDPov7jx7mhNWToNTM0LUxZ2KpnNbJnTUw6GTFjFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(9686003)(6512007)(6506007)(53546011)(83380400001)(478600001)(186003)(26005)(7416002)(5660300002)(44832011)(2906002)(6666004)(66556008)(33716001)(54906003)(6916009)(316002)(6486002)(8936002)(4326008)(41300700001)(66476007)(8676002)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqVuldkA/67Vbumips5vtJl3QedgWNHwfmjnRf6xeerVyBu9WfHSmQvf2pN6?=
 =?us-ascii?Q?77EciwzkuHwvy8TDhzdpAxJAhFtqADc3CFtmNFpjqAotqt8wrY5fRw3nkW+G?=
 =?us-ascii?Q?YsGW/k89MJz5JD/FO1SjU8Wor/0sG3A12lCi0FETYAKNNLWww6XZ5y9I9WL7?=
 =?us-ascii?Q?oBvhfd5pcL5kIgpvwmWd5mSdzwddV75GacVi9cUQ0JCm5Ip8NEP9eQ/3LTVl?=
 =?us-ascii?Q?YviBiawWqhDaVanJZfXhoRKjBA3WGTe1KxZJrfHRiW6rkme814yvR8FQbIsu?=
 =?us-ascii?Q?uin5ndoc1/5AIvIqt63KBjcRhPkA9up69qV8nJzdDU7A7WahvEMGlgqzDkel?=
 =?us-ascii?Q?K9/fh82Of7aNWgn4wLeyBVj13KsaFYEnT+wCnzk26YvC7B95zSqcAIfY2WkY?=
 =?us-ascii?Q?LjXsq8s8Yi/Fda3IFIU47YlX1TBX3ISCfiFGboQ32J8azwZUMGvEgsWdvSP+?=
 =?us-ascii?Q?oWSRypBpJhyei7/rgxTkY5OHGaSNL1Z2NWRV1E9+bJxnMqzqNz1FLcrSnDKI?=
 =?us-ascii?Q?obPs2eTkvPNdiEqhK8F83Z5QZ7CGvh0JzJ6+s9bjgrmFVoJDj9QiEFLGyrdw?=
 =?us-ascii?Q?NLNt98cnAUeIcH2gH7NhTgsSKLK3LroIojf/MgPRdQkNq2lLvmGtFp4+jG/Q?=
 =?us-ascii?Q?0BWOM4GLTCG00+7S1rYe0nNtltpPM6lWYuJshdgFpQNdUu0tkeLHeYX796AH?=
 =?us-ascii?Q?hoGhZ2M4WqLbzYgO9DA/pWZ0ylgutIHB9l7M8CniYG2L24W6tCQroS0Uxn78?=
 =?us-ascii?Q?H5M0/Z0wplreo3Mxb2c5JR5+p7n415XSSc6bWlzCrxO+GkAqz2fKHUjeuvJy?=
 =?us-ascii?Q?0mQfeMml6xpt7XMPUnGc7v6lrvbm0E3+AlueMRis7vkzJpYcJT956Nue7jxT?=
 =?us-ascii?Q?33nyaUIqioc80ubhMzbOva8qe8Ij5JKEtvDBPUPRCoz+lI1jhnqXPdNK/D2t?=
 =?us-ascii?Q?h5IKNf0DANMvF7pOYh0q2kuiz60So3MdR+zaDQVVwEdsQgT/7OvxmFhMURSp?=
 =?us-ascii?Q?NYDOdr1WeWvRwWqqvg9wDixuTEzLauHnqJGqKtGdviLLYuEx9g5MlW3F6AER?=
 =?us-ascii?Q?ek5HhF45odWaazrFF4UN0ApijlX+meEI+lL2J1t4mWZtXrZDttBQxni/ewfP?=
 =?us-ascii?Q?VjK7ir3hhIPcOkI5fvlE4tVrXjKOIt3DA6dvEwPCVfDH0uCKejtWVsILw6OM?=
 =?us-ascii?Q?m/EbAON7VEnVsN+p3xHXVC9/uN99zl825fc52btk4UXTG3FaJP9eIWGzRthH?=
 =?us-ascii?Q?uoM3tJaUVC/IPJTz9OTZrZZ54xTMdiR9tl38PfNYB8QSpp26cUqvg1tPufqd?=
 =?us-ascii?Q?jKtGP57r5Axf2foyA2ilq5T9kwzKJto33nzB/hjaXdctHT44T3d12L7byvyJ?=
 =?us-ascii?Q?tWe1UdI/zrmOgyv+hTi+jJpBLOU8tpzZDP4MeuwjJELENqOf1uOkPerMzb9R?=
 =?us-ascii?Q?AOAoBtnql5nx5gBqY09UIu9vCfObdxRzalT4pcv8UvLAhNuiEkz4+AxLUht1?=
 =?us-ascii?Q?KQCpkJAMUGj2++5RwRmCqVsdeNK5fhtddje+d9vJH+eCiQMYx4fVDCTHeL6j?=
 =?us-ascii?Q?uIojTPUzctcoSIdWAzv3XqKK4Ucf6kbQ+G6II31zeimyWDn+iTMQ6/y1HWGX?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ea0c7f-b294-4af7-e590-08dab0b47ee5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:57:29.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AoLU9FRaaaOVslB2LaQEADRQNrFmYB1El2TNhTe00ggOq8wytxj38iqEjCJDJqaODUPSONRPKIh7GDYUbsWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180014
X-Proofpoint-GUID: I7QXxldB_hRHKNe0Jbau11hOQLgDwd6B
X-Proofpoint-ORIG-GUID: I7QXxldB_hRHKNe0Jbau11hOQLgDwd6B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 09:25, Miaohe Lin wrote:
> Sorry for late respond. It's a really busy week. :)
> 
> On 2022/10/5 9:17, Mike Kravetz wrote:
> > The hugetlb vma lock hangs off the vm_private_data field and is specific
> > to the vma.  When vm_area_dup() is called as part of vma splitting,  the
> 
> Oh, I checked vm_area_dup() from callsite of copy_vma and dup_mmap but split_vma
> is missed... And yes, vma splitting can occur but vma merging won't for hugetlb
> vma. Thanks for catching this, Mike.
> 
> > vma lock pointer is copied to the new vma.  This will result in issues
> > such as double freeing of the structure.  Update the hugetlb open vm_ops
> > to allocate a new vma lock for the new vma.
> > 
> > The routine __unmap_hugepage_range_final unconditionally unset
> > VM_MAYSHARE to prevent subsequent pmd sharing.  hugetlb_vma_lock_free
> > attempted to anticipate this by checking both VM_MAYSHARE and VM_SHARED.
> > However, if only VM_MAYSHARE was set we would miss the free.  With the
> > introduction of the vma lock, a vma can not participate in pmd sharing
> > if vm_private_data is NULL.  Instead of clearing VM_MAYSHARE in
> > __unmap_hugepage_range_final, free the vma lock to prevent sharing.  Also,
> > update the sharing code to make sure vma lock is indeed a condition for
> > pmd sharing.  hugetlb_vma_lock_free can then key off VM_MAYSHARE and not
> > miss any vmas.
> > 
> > Fixes: "hugetlb: add vma based lock for pmd sharing"
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 43 +++++++++++++++++++++++++++----------------
> >  mm/memory.c  |  4 ----
> >  2 files changed, 27 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4443e87e814b..0129d371800c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4612,7 +4612,14 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
> >  		kref_get(&resv->refs);
> >  	}
> >  
> > -	hugetlb_vma_lock_alloc(vma);
> > +	/*
> > +	 * vma_lock structure for sharable mappings is vma specific.
> > +	 * Clear old pointer (if copied via vm_area_dup) and create new.
> > +	 */
> > +	if (vma->vm_flags & VM_MAYSHARE) {
> > +		vma->vm_private_data = NULL;
> > +		hugetlb_vma_lock_alloc(vma);
> > +	}
> 
> IMHO this would lead to memoryleak. Think about the below move_vma() flow:
> move_vma
>   copy_vma
>     new_vma = vm_area_dup(vma);
>     new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
>   is_vm_hugetlb_page(vma)
>     clear_vma_resv_huge_pages
>       hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
>       				  without put ref. So vma lock is *leaked*?

You are right, that could lead to a leak.

I have an idea about setting vma->vm_private_data to NULL for VM_MAYSHARE
vmas in routines like hugetlb_dup_vma_private().  We can check
hugetlb_vma_lock->vma and only set to NULL if,

	vma->(hugetlb_vma_lock)vma->vm_private_data->vma != vma

Got sidetracked chasing down another leak today.  Will send a patch
implementing this idea soon.

Thanks for looking at this!
-- 
Mike Kravetz
