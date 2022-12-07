Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0E64641E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLGWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLGWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:30:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC218324A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:30:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7LwlCq027255;
        Wed, 7 Dec 2022 22:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jIcNepEyvu8m+dFeBBQOsjceWpJajLm726w3jbJq2vw=;
 b=0FLRbQxa4O2PcTn6AjLyT/1xHuxjug6kwb/D96vsHfAZB5eP2vJpeXoAsFXQfWKgXD+C
 rJ8hK+NqBFGFFYJbYWn7G5igp27PtjRBNDTEBuQeRj7RWxD6ecei9MuqRShMJyMJg213
 st7LwKu1BcCZO7OTSl+H4SJpO6UZynOCehVoKEHsEcMKU3ULmTYgRkCw4iVaTwifnEFb
 p0JJ3nJXriAd/iYhDoJ33EzSyUyPXOnQFE3sHFz257x9BuAltI/l2tNs9SAIJxIp7Xhy
 EAquX2/Fy3BlCZN7dY/c2qOO6AXL46M9G1eQiubx7kzRejAwB8GDRu51okj7cnkz5cE0 bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8hhr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:27:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7LwBQ6033725;
        Wed, 7 Dec 2022 22:27:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7xch1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 22:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiiB6yJIeCAKoHH/MtQEm2ZVMbSPdNZKgJzt1wTp1G/TajXAaodaAdcByZsmgwbH6OUbytK8SYcaciDVwDL+pNlErCZwZ4ddBgrXlt1RfL0uiAp4wLdLNGCdMBhvFhO2VjBaq+pRNVSSuO3UjyFuNB2J8zm2jmkKrtBITYg8yQwV2ufIohPcWCIAFNqXkWpRbPvpGeiXP8/kBE4UwVk+IE+yTnPLoGjeU5mK126YXqMpeWjl/XSjYuv5C2zEVxCdmd+3uOLwa2uspv0mp7Fuf2XnAq4MzS4pi6sD1keyfvyxDFmsDcupP31N7u/hbni3DH6XgmUF8m/55VeNH9EE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIcNepEyvu8m+dFeBBQOsjceWpJajLm726w3jbJq2vw=;
 b=LpRgaPMzFFY1n0gMJTtJxiMHNpJ5jqQaRKV4eze0U9Wc+7qD7SmpBOuMgcT186FX0KRTP5SRygsCzSSd57iODub/S1E4MATV7q50ACb5XBhCcZPTN/n7qKRNa61VrQshK3FsZHUPppstcQt1ZcUiGg5O/Kz21nulXyCynJDK2WKIMmCQ/hELeR1ui6jR57rZo2JyBM8tSdCw5GupTWnewUEvTlOSZl2ZdftiUNmgjKZO7JawglixGMojeeuoTeGcItLvcOqxBweh3pk7jg7jztdmdgvozM2WoL8AgBAODZ4Yxk4HWmwqO+O1IrKLZuWuKSuVX8bsg3PvHh+BWQMGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIcNepEyvu8m+dFeBBQOsjceWpJajLm726w3jbJq2vw=;
 b=SLhFOoOMlHzyTYshC85Rcr2mtaVTBDeUJJlg6F6WEe3ebIOpbVrMsFqGipXfAfMh5eGY7bFIuX/YpA2ZH3GuqRDu5rLKoLJfKV5Xgf+4SOXJ9LDylkYDyVifum6yEiBfSrR8zKfY2rrAy+EM0yZulnyq+GCt27dyv62Y8OXgh9I=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 22:27:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 22:27:55 +0000
Date:   Wed, 7 Dec 2022 14:27:52 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y5ETaE2dEUP78l6Y@monkey>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203156.651077-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207203156.651077-1-peterx@redhat.com>
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b4f3b0-ed25-43c2-9245-08dad8a24984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +L6ixtumWhzlLeH1eyM1hYt98Det2cW9ptgqQ3XYmLG44NnUDS40mBjyCAWJKXp37Ob8xjZSo8QhnNKQE2byQrqaGF1NS8a30R57ClBjaAv7fkxs23ckHduL4i+fnk1tdhR2pfXUhWTtJTvRkpJrkz0F+91s4TVkhJFE//N2zny63gQCN3uuiM6akaolC30GfmQADwJXopk92ndJmRZ+VcnqMY2dv5iyXyRazfOVWXEEuFuuLreWY+2WClVx2suGR+uw9CYIYchidRmsBEpjx5agRPeV8Z29XnoOL+JOC0BBDmn1q05lBkiGfMSgDDBCjmFwexB6dHTM50mjjcLOA3701WQeIoMxSUdi3I9hFyL4N2xUR70BJjXFb61NdyGtZqRo6xtXHM6mVCtiFvppwck5dMnT9qH6hqv6W49KP2l0Nx5troHqRFmZ53LPdtG0sXu1KEk0d7hHnbTOLfgHekH1KzI8rlrH+iDsk9JMIaeZjO8A9cS2/A/rv4hjyu7nnVy+8lGJoKgWJWIxzD0KMRlCV0nUaFXy4hx2+wgRjJPAUygEjYIyZDLd/QMydmR2w7JWF7z7fS3zoqj66XkInHFYJ2JurI7XJjboyKhVMB/iYpQvb09Lb1Adpuyh6Teh3AW7lBlrMw7CpOGA6quGSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199015)(6506007)(38100700002)(86362001)(6486002)(478600001)(53546011)(8936002)(6666004)(26005)(44832011)(4326008)(7416002)(9686003)(41300700001)(4744005)(6916009)(8676002)(2906002)(66946007)(54906003)(66476007)(316002)(66556008)(5660300002)(6512007)(83380400001)(186003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m6Vdew3KlS1wGPJ5gSIaQ81GrhIQWoKjFa+U2ZJMnwyUSTOAVXmJC1Fnev28?=
 =?us-ascii?Q?5qQ/K0QqBAR5JNT1gvQQCmII0DaoBeFE+1MQXXpD7U7E0Z8FJKZWs99iZEdO?=
 =?us-ascii?Q?oExTIvmolWJF5ts7eeRpMiRVPUuu/qenfsHGuqN1xku9C5PhQUi47yR3OYw+?=
 =?us-ascii?Q?53eF5wB/XPtpVVWeVDRqGThZtQ8jV15U9t6+3ELpFwNpQyc/6ed0je6ihiFh?=
 =?us-ascii?Q?O1IaBaoD46YdepiIL+GoCdyuVEkJ1Gk8lNdJtb8L4tDgtctZcaz4uG49AljE?=
 =?us-ascii?Q?Vo5WWOZQRtp8CguxgBdmgzYbRMXVGDIjeflYys3W+wCpXritehrsYSUwLggD?=
 =?us-ascii?Q?gTG6gDkKfi2x/hPvXwNCrA3uhCcWSaNAd6EWdAWDGmhnhX7L6B34E23zsJPn?=
 =?us-ascii?Q?HyoPLttCfwPlvDZ5qqReojGprshrA4HBq/UA8+3TM25hFyzHbh92Lc7v0enG?=
 =?us-ascii?Q?tR3tExPFxWbC50G/7+1NtpPW6vqHlh9fwYPU+rtN3l0TSobKwnoXW9D5AwZ2?=
 =?us-ascii?Q?2HKQi/epKLElgRTvZYIThSe8S9QOAFQfyIl1RZFj8OivJnrLlvXQf+wSrdbR?=
 =?us-ascii?Q?p3sN7wCrjGhojE2cvuWuYgCHY4VzILnbw+abIBMgV0/rIFycXQ6ly6FhdcCf?=
 =?us-ascii?Q?yeW7jrkMv6BzLiwnfvy1UNkKPxw5Tmur1PUQi07VXbsV3JUYPEqDdWd/+oJo?=
 =?us-ascii?Q?V4o0Lr84TCxwp8/9DusW0AcYtoQLYImzrvDRe8lmAyknd3RoualeV0Qq063a?=
 =?us-ascii?Q?3q5we4RBaZLAoj1acAJJF8rdeRfgd/1vb2IAISUcedrSqsfDQX13TVf0FRqs?=
 =?us-ascii?Q?H4PTT7PbD0aT/gi2eC5fcT6cFZ2X3Z+u8361ngOKOUNWNnW5LStx3MkEJgz2?=
 =?us-ascii?Q?w5klAQ0uVWAr8oY7mIZGlJsDCizawDo+xjhOXtW7HEnt/VjfOdMWqNVwVTlR?=
 =?us-ascii?Q?EzU56srUulwGYQP3kR64bC2+7BC6WB/g3euzl5tTIkox6uXfoo5+c4nMDiL+?=
 =?us-ascii?Q?y7+cDyt/9w3+Fuqhi32blmnyoKIjLDQ8ZZBGUt1PRqmCjLodUR5d76bZlA3d?=
 =?us-ascii?Q?PHlzed7Jh6U0SB8T3eKVJr/UQiNf1C/6gVEHL15ERfLdPNM8plagOxShE/LD?=
 =?us-ascii?Q?k1NjXQMZIKuIB63cVMKoCysvbuiVSVAOsBEeW977IP3zlbgc+ZdOWiuPgoNu?=
 =?us-ascii?Q?xjL2wB+CoaxaWXB5L2+oA2YtuC+jrUpGPmY9CmZvTYLg8LD5rMbEOodxaASm?=
 =?us-ascii?Q?53u6VbvVA6QN15FhwLs/gYcSQPUsnIXWP0rxrcm7rBBh8TGYPXt4trfAlkNU?=
 =?us-ascii?Q?eAHdRTwglQdyaQaZqf5Woh2/8hW7h3XHsn1s0PDeSCaRsQfYesym9AJgsYjW?=
 =?us-ascii?Q?GGDubUOe+QoAr6euzrBQDuyMVR2zIZncS+bdDKXAHsXE1FhLmFMD4eoMgGKR?=
 =?us-ascii?Q?jGlYb0FhXCSk3Taz28LlvVU3SeW/VaiVZeEpaDRyiPDOPPrikwcLLFb+yf1u?=
 =?us-ascii?Q?qqAvJsJ5wuna2/BPelueRtEdrtp/MDNTnAI70OtPndtak3nWh0LiqmpBEgJy?=
 =?us-ascii?Q?H4oq6eFrEjLpfQ8EzNFKeone6fqcoh1F1s1HbmRJn4igsAIuA1SObRPaJhF3?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b4f3b0-ed25-43c2-9245-08dad8a24984
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 22:27:55.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTW9Q97LIvRNPv/tehBd01jyc7bQUYntGjuYAsWoqyyy3tYqd2QzMkyP099PSWd8PxYLa8dWZBqQAY9o6WksRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070190
X-Proofpoint-ORIG-GUID: YfGjvxUCpEk8KG7MAbvdV5BEs1-zLTCi
X-Proofpoint-GUID: YfGjvxUCpEk8KG7MAbvdV5BEs1-zLTCi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/22 15:31, Peter Xu wrote:
> huge_pte_offset() is the main walker function for hugetlb pgtables.  The
> name is not really representing what it does, though.
> 
> Instead of renaming it, introduce a wrapper function called hugetlb_walk()
> which will use huge_pte_offset() inside.  Assert on the locks when walking
> the pgtable.
> 
> Note, the vma lock assertion will be a no-op for private mappings.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/hugetlbfs/inode.c    |  4 +---
>  fs/userfaultfd.c        |  6 ++----
>  include/linux/hugetlb.h | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 32 +++++++++++++-------------------
>  mm/page_vma_mapped.c    |  2 +-
>  mm/pagewalk.c           |  4 +---
>  6 files changed, 57 insertions(+), 30 deletions(-)

Thanks!  I like the lockdep checks in hugetlb_walk.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
