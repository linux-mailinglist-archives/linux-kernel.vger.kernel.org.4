Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFE648ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLIWhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLIWhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:37:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DC10D9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 14:37:37 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9ME0aC002211;
        Fri, 9 Dec 2022 22:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=UEylPfIkl8VZLG+2Ey9kLvRNnJWn2jvaGSnHw/ViRWo=;
 b=uYTpODXVXYmSCGIb+URGwKG/1qdaSUmMFZzAStxXj4/od+paVO+GwHYSRIVMfq7aG3Xb
 PyTPpmzV1dBPF06Pyn1I2zv0IMTl4nZ1yvaRRbWvx+cGvvQSXHBad3mf1nil2n+5x+C4
 MgJpVPrvPJlQmttNOAyivvfFnf0/5qBjxlHTz+boi8Vf/2993x4WNuuqrAe2E5u4yiJn
 K0NifizYFCY3NLHQU+j1MTn/eb08gr1N8KhoEAPTugmtJ8rTP09FbMd0OMy/B2u4l/3+
 TbmJRVq4Fb3HCWntqel+QwFbrclTaj3HryIzyKwWQqtvclhcc00+65sXMybep0Bm7g8A AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6w9uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:36:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9L8r4j006699;
        Fri, 9 Dec 2022 22:36:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa826trk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 22:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAilrsh6wS/XOyRUEE/bddMtYvjNt2COJ4+qlq4ma2sEJEYkOzuNdEmBAOylxZh7plOIGaYma/z4mxTGS+2mXC8jHJWFxekKYzFCP+cS45wz5o68YiVGAMgEShK6c3D3ESrAOS6fC3DeyVwjRGjHnwvCTTTIBXwtV8T3wTVBHjFDE+qIecbi/0aDQledJTRglbztTK6EGE8Ka+3vcR+LW3P7wQWYQ58pn/frFMk5CuZCbyKmzQOcrZWwZ+WJybyWxviRBbvXhxmwk2FssZjHyJFBXqjipXO8YzNuTlf1QW29REFzy2HF+zT2j3Fu+CkLBG4372X5q+7JHWN6iGYTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEylPfIkl8VZLG+2Ey9kLvRNnJWn2jvaGSnHw/ViRWo=;
 b=WMJISIqVAIWphfFyvCjJU8mQP96DQnkc+tFeWLgzQnaVLF3VbxIonM51K2VD5zM8QbfgRb+u5IMZ3zKUdAUJtZI22FWxKCAdRa8oQs80amvVQelMdDs4WgEdGDBa2mleZ2v+OgxtQ3LbW6mtQUrn/GSCeK2yRMpEpXrsaPoFXGoYLvUHOXJehnckPSzsjUO6EgA2pOPkMFcjp0kbP8qLQ1fNF5u4vUQqlb50ZQbzzSDUgOVZORuB6yxsQOEtvigZ+IltIxOsWQO5ZxfNzQD6PMqsspVcPUnSBtXS0/awji9tT2KXgDhmZQZ9DGWSdwXF3qUiHD52/ARo2bzujyM6jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEylPfIkl8VZLG+2Ey9kLvRNnJWn2jvaGSnHw/ViRWo=;
 b=YQ8GKuTRRGjKcu4onGupN4mkrNPy2GO07AztW8Iny2NNIZHjshfwOCNktzCcxKpvJlMkSAR8GCnNttM5uA5uS192ojtxZm8+ukprZONUP6ZPFYdAC8mAvAtYnwgcE6Uy3Jw1tZHUEI37ZDO5kYCuBzKGBkScDDNCRM81msD+vlo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 22:36:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 22:36:55 +0000
Date:   Fri, 9 Dec 2022 14:36:52 -0800
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
Subject: Re: [RFC PATCH v2 05/47] hugetlb: make hugetlb_vma_lock_alloc return
 its failure reason
Message-ID: <Y5O4hEVoT3/sdnk4@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-6-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-6-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe22106-cd85-4e9c-39e3-08dada35e005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lQ3xtpZWN4fTNt/EfmosDA7lzyDxs/osz+DtWgDDzMOJBXeRPBOhdUCytAhX49QvTWzTir3JlRv183fmTKzz5MOr8pKGQ3EN2H9Ami48DhXscEHQ50ndW0mG4vJ+uCz7QS6cviBWimaJX35myyw/Qq6qzeZxRGZLAe7cyCE7HJ9sd+B5mv/By8BKPx58es+Ebh7FKuKFBiT8ynfMAetB2AfGWRVI5m8Btu1y6hDuLW4+Tx+G03FSg4k5zGTNLr6YuLD/GbRdyYUOqNJOOk1/NagZCk6sHWXIzeZ9wkxsEjj7g2SapF20AWwNg7CTXm7ZndxE6fA5iCG15NNTXhQBLPoNpDdRvPiIwWgHWRG592JfVWV+S3+KjyKQ8T6mWzTT6hRd/YNV54C33GNe6DBnfTwq38LHRr+9kovqnIQYnaZ59DKo9pcJHXFTnu3D0ImlK/ck09iMe73DUwXECznuYH4Mr+pGdWyviiGH/7ZRdMUEIgLbUOLf4bYbMp9IbkWtAdIjypWjSprUWG60RuK8mGHbMB/Xq87k4liKQv2NGHeP/ioDJry51Ey80zesIw3MDT1Lu5IxGMve3XQfc17MV583FI7oWLQnG7SpiRd05qzyLK/BwH0BflMFxvfl89bVY/rO5VbJ4D6WJLVz/zzpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(8936002)(66556008)(66476007)(26005)(66946007)(316002)(83380400001)(41300700001)(4326008)(8676002)(54906003)(6916009)(38100700002)(478600001)(186003)(6666004)(33716001)(53546011)(6512007)(6506007)(9686003)(86362001)(6486002)(2906002)(4744005)(44832011)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXZ3S8YpGR9eJuE84fjJ+ZlUj6zxUgHMRI7sgoVgk8h+a2YryvCv1CG+RV52?=
 =?us-ascii?Q?H65DrXt4hqDLzl/7hw2zlK8YWIZYAI8vX8X+qsDBWa1PcgOo+nY4/OmDGRSF?=
 =?us-ascii?Q?BMtEiNbhAyqlG5Bum+RqUtAqr5AXzoRdIYxNKuel1sbPr2Uy6YaVtXcz7AbO?=
 =?us-ascii?Q?Mh3yd6LHuv3GoOEo4NrS8ohemg+wx2U4BuRMrvpnMrjbF3Shg2lspHZxopJy?=
 =?us-ascii?Q?w2IvYjGxNKFsmE5w/XQAesA2NpM5bKuv9xphxzbeYh8qG2VQ5PWjnAfDr+AQ?=
 =?us-ascii?Q?Nb0IxYWHUEr1x+nWLYgHvGZ9d7KfVY4zA8/4xNMZmJvcdpKzQT3WziWr1nvY?=
 =?us-ascii?Q?/UHV2ScXOjRAil4oDqfPgIdTMqHdy4skMPwoUfZHPMTJqi+CNa2UNvcIb7IC?=
 =?us-ascii?Q?7ly/MsPTPdT28rTZNlHTzIauQ7ZmvIFGxzhC/IPlkw4tuaqacjP6Qwq5Ockx?=
 =?us-ascii?Q?IXCoDRgPXAiU8PeG/nB3AeyrXBBNTqJlqRusskS98cj9myo9asF3P+KSw73W?=
 =?us-ascii?Q?T1O8TXkWpDQVhjzRXF31c9yJZIWxmGwKkJ1As5SCTmWRCFqIfLFLUeRoUrza?=
 =?us-ascii?Q?o+2DcuPbIG5dKEr114p3IR7HwMBEl7fUxzmh1P7X6zqRooxRSV3Q+hkxvmOk?=
 =?us-ascii?Q?GjRNJfCakBMRVVz9FsRmmbaVl7/feEZunmGX0p3eT4nsOcr7lVPdIBmRxoEm?=
 =?us-ascii?Q?09+/2ZgNe1/XAP/IiVfhEOmDs2c8LplpnQjv+0eerQkavE2vPuKZ/b1tTjSM?=
 =?us-ascii?Q?KufIxMr6eW2vu5DjF+8J9gNP8HNK4ewxMQG4OMNJd9Wdz4IL49nKLuQguUuc?=
 =?us-ascii?Q?nZ4+9xMnUCgD72hJluG/zSfuitkiKZLPaAgGAailZbcQ/J0Nk9OhTL2hM27K?=
 =?us-ascii?Q?wyU7l2er1OAb3oJFQIYPGddDudzpYm7scBaJuCPQR2QXFz1hCI3k9ghhhpN4?=
 =?us-ascii?Q?7GPc5glFIN4lXZzEGdV/IlJ6GVVK7HvvoUMClmethN7i4D8wSajCDfh+SJ2I?=
 =?us-ascii?Q?ynm5vwKyAU2pixjwD3LywTcZ7aSnEaTIlNi3R3+u/SnMKceoV0JZVfcagSTh?=
 =?us-ascii?Q?gPJhOH9nJbrg44i1qDjeSIbwrKgKe2eyR6voP0PC+yhjwxyBnho5OwreJFO8?=
 =?us-ascii?Q?Ft/3aLllsS5+yfWtLxXKonSRhw92dH5EFq24gCKhK4L6yYGKYneD6VY19Agb?=
 =?us-ascii?Q?ThkYxEGopH4ydODSimGypZps5m401kAp98/EZR+PpQWetNR38oi6ZZZk/s0Z?=
 =?us-ascii?Q?5sE+djBF9JBkCE0urie3AHYnwnMC74j5RodcMoeM/JWnK10l5+KVHeboSIJ+?=
 =?us-ascii?Q?tKU/ffoe5m911Y3iyVUBgpv+dgk48fFT6Hmx7qnrePEbLZoEdes5Jx4O12KG?=
 =?us-ascii?Q?ePvBZJvy5xTlxCtIO3MWbNu9pMwCRIcifSijs72bMFiYQYrJRkbtLrR4JY91?=
 =?us-ascii?Q?cnWPe4Ju6pEGCoXyLwGrN99SqDM3wDaiPeS7l8jJSlZj0bp09Zq1DecjMsXk?=
 =?us-ascii?Q?fUs+/g3l3gGaTIU+wRMaoBjsrFq8Gt2UmPjWmUCjcKJCHUFaWmFFX8SnPhxT?=
 =?us-ascii?Q?ANfN20WFoYhHMU5lTQHUSxo4tKFFNLsghqh48cMuE7yNiar4wadcGTeSqoGW?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe22106-cd85-4e9c-39e3-08dada35e005
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:36:55.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G12HuUpzmWrr/V+NZ5bqCArJ1qxDTd0ZkJNtUYYsgokhYS3Eqi4Pp8OSb7nm3CvsvD/sVF4lsWkpXh5Rc84nEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_13,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=863 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090185
X-Proofpoint-GUID: icmlsaRBtSQ6_aTnJPefldnRoTynsP2c
X-Proofpoint-ORIG-GUID: icmlsaRBtSQ6_aTnJPefldnRoTynsP2c
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
> Currently hugetlb_vma_lock_alloc doesn't return anything, as there is no
> need: if it fails, PMD sharing won't be enabled. However, HGM requires
> that the VMA lock exists, so we need to verify that
> hugetlb_vma_lock_alloc actually succeeded. If hugetlb_vma_lock_alloc
> fails, then we can pass that up to the caller that is attempting to
> enable HGM.

No serious objections to this change ...

However, there are currently only two places today where hugetlb_vma_lock_alloc
is called: hugetlb_reserve_pages and hugetlb_vm_op_open.  hugetlb_reserve_pages
is not an issue.  Since hugetlb_vm_op_open (as a defined vm_operation) returns
void, I am not sure how you plan to pass up an allocation failure.
Suspect this will become evident in subsequent patches.
-- 
Mike Kravetz
