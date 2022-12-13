Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9364AC04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiLMAOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLMAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:14:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CD1B1D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:14:43 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwroh002656;
        Tue, 13 Dec 2022 00:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=kaUJOk1Ow9HAGu98jMU89btHxCtaXBI7pv+L5GI45Gw=;
 b=kYkOxGTLZdiA4fzx7x3kB2xbaH0TrLLEXPru4asDGgs9tcic15iz/GzlhgiBaOOMieQc
 9YxMArSTZ8wZlK9gjh7iRQQCFr2iFCK+ow17PKL+fyktnPrAqBG8SxPT2P/HpHb4iMjL
 ERcSOAYyvjz1rNoOpR3A2HIbkdxxosARPglbF9u4H3iqpkZiOMZ1FYA5DUJyojk9cFS1
 7wve2q2y71l3Ppp+EJUgG9zDQvxQMa2f5TXyxKOG9QuauaNhFbOhiOcwnl+UdVW38Pzz
 CrGUEDx8vny46qjHN6RxSaZ9dNEFJqQ+Db6U2MGBQFaaP7uS+JZGk8BS+VMowQ8QQwYi 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcjnsv4w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 00:14:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCMwhPT017576;
        Tue, 13 Dec 2022 00:13:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb4cp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 00:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQCWgXf+n9bgbArXesm1N9cJYFUiGFBtVyAStvan6K26SGJ1VmwSdxIhp07ehgFYkdLSmtur9nDhMBX90a0k5A/UKsNz18jCb8eK7At8kCxKdAtw89mHPdcyg2B77OGn/90qtzPrmgD62qpauh4OVoHdI5RfJT4xT2voCx/+OBHWzmyhni2Vs6LwexrG/Q1qKXnurFLCqPHGv5rInwA+qw4c3UWiqxoFzfTlhmZUS7j/LgUOqeFC5HI9VVsD33G8C4pXdv5nOpunYlzat2F8lH3ndWgk+K3dqab5awQhTPzLKSA7vsl1DYY+i1NYVtwMdoleAG1k2cwiQAI+ZVzgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaUJOk1Ow9HAGu98jMU89btHxCtaXBI7pv+L5GI45Gw=;
 b=P4SqiqGXsKmr67Lh8H1uOLVfJX2ZnP5Ce9HIuUaX8yoCDMAf0D6QHCzjTpCPx50WVyOjq6MQgWBilv/T9eOORrrLeg/6hYOG0FgG1J0BUJgQg7i1UeswmyQKdIDigHLFl5l69Nu1D4F+PhtpGFGtEGXkLzsRc+Ftwyme5GvtGV3DwYpqwn0AXxzfjTuzEXECxHwGZZIoXVZDfpzBPr3WqAU3WawKpAFHCQGIYEGCMto7r2WEXxdcLGSi8pzDCzhsX1jONokl8ivn+yQmq/kQ/kXCVFQmEyHVg/LakXlJ7QRT6ztXH2ekeOrXYSy0LzX5pF25czDsH1XiRvdswMxb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaUJOk1Ow9HAGu98jMU89btHxCtaXBI7pv+L5GI45Gw=;
 b=vLmJGbqFx0pzeJwUdcDtyaVpBxpsEGAd61ejsmedMXktSIofAi0hYmi5KiFTAavhOozIh3dzgznEc24LJlJ8/qIycyV70JsDd5B1Ev8CG0pnKpY9CZ3Cn2urQ3wOpxkuXou9sW81VuXk2T917pQoXrshfHi7Lj1eYrc6cCShHbY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 00:13:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 00:13:56 +0000
Date:   Mon, 12 Dec 2022 16:13:52 -0800
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
Subject: Re: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
Message-ID: <Y5fDwH6XiM808oUM@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-9-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-9-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd009b-aae9-4fc4-0742-08dadc9eec5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqcPypJGMogbbW8u4abMQkP25UytjHL6pLhtt/9WoqWLsblVnw0J/5uVXsclj5oNc2nFp8Tzy2ZtaR+m8NfIB+WmsYLX6Na9S9aXcAKKdevk065dQy6UlK07htlgvvSg+IodJ/OQ0ogYodikaS6qfhZhOQVTOJE220zO+Ey9O7hwRhOc/qPbGVbbkdrpGpv16xdY+O/3g8Lk4I5hhgsOMMws2BHfRU/4jbdv5s3Ar/oXA/MWBaXrCpYWqsw6LEj0JAv8+2fUCqZZlbjteie6kR//R9F2rlhcSfTk48t5Gb1Ei5iJA8zzHHtqTWGPRWPGuPpDwpgNe+MOSKtVifk7IjtjG7fsTym+oRU5bjVVO2yPEzhyUR12nWAxfjOWgucwS5gSDt5Xh9jlz+gUqGZixrtGAzhvEi7DLIRbtS5LZZFJZhUXVgYnUmJMOfqXihf/qMql7dCcoBanIpyrcZc8OF98CJIoJq6s78Bzr/gobk+rHbo1ydwkN8Qrud2SFoNFlWFoKIyrQH1fdmPZcz8hD9rdciDHxjY0m0nZ553zt4ETPl7dZl768y0WA5FKVzlgvvTIat/U3ywkvws2zvgxtGvDo3YvVsEjj4sFw2RPNMqD3KtP2nUMXJO5/hFvgKweKE2FSy2YEOGZeccelrZjyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(54906003)(316002)(2906002)(6916009)(6486002)(33716001)(478600001)(83380400001)(38100700002)(86362001)(6666004)(9686003)(186003)(6506007)(6512007)(53546011)(26005)(7416002)(5660300002)(8936002)(41300700001)(4326008)(66556008)(66946007)(66476007)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dkm2fRu2SlBj8oWbLn+Mdld5kPVdu1lNG90+j7jRCUe0E+lx36P78YaYFj6I?=
 =?us-ascii?Q?6lSc17BJ5Qh5F92ik+4WDPVHhimyeXQUWh7kZMaG1GR47Jm+qDIy9tJB0RQD?=
 =?us-ascii?Q?+oUQBn8roMtrYj08xx27CwK6or73cGESpexSwtPvWA5JsS4bOs5vRtNlisVB?=
 =?us-ascii?Q?Pr9n28RsL5Lp6w3UPYT20+hQDrf/BM+d0RioHJIkSGKZvKEBI123r2EYQVpX?=
 =?us-ascii?Q?ZPFZo6jwLY9lIro5TPPGUZiekwBZulMgMaacwlk8F6q6wdsC+KHNcWB7LZcN?=
 =?us-ascii?Q?gjQAfPt0oYMUOCIOw/G6G3QwoBWKgoaHfuxWBKHHPCOC5Nllzdl0vT3S+Lpm?=
 =?us-ascii?Q?kVZA3TD9d2DTqs5x0YPec2gsITnuPch4Ux7u6laFRkLhvDThQeuI4qf4xuQD?=
 =?us-ascii?Q?BvcqBE48UqUUXIlDFs4pfUfzPtVw6OCMkf67McgIYhk2kuV4H7mvzoP+kOz2?=
 =?us-ascii?Q?NARqmZMsuyAFvEhEiJY0j6W+8wVmSR2PGe/VTLw2+qNSVworZ/mXRsxH8yQ5?=
 =?us-ascii?Q?hVJ3L3EPYaKZjBUTNfQfLZjJicsSV48A5IDnbi+R4/z7mzaZdUGjwnTAa8GW?=
 =?us-ascii?Q?o09Nga1DSZmftM495/9AZb99lbjog53Awars/6OJU+csWobF7XdqZ8wkQQdc?=
 =?us-ascii?Q?4V0i/j7x13Hf9NmrYQueQcK78nXkyiS6Jl2mXiNQcmMg4sqNwWhqTA3xhOxS?=
 =?us-ascii?Q?uyjIgrdK1ZV6ksl9/bDBxuPpqgXUsgJDqCpe3a0hSrqQp5KFTmUlJsmb6thk?=
 =?us-ascii?Q?pTu6o73jWX87ovglu0yNB1FUpldzyg35vm7tkOh9ht1fqlbYlUPzLR0ItXPe?=
 =?us-ascii?Q?AaUonf0z7VUEw3KSLAzg4KlH613+RsugtjoRestO0NTozqy97ARvvgFuKBgZ?=
 =?us-ascii?Q?xwHqNAcBOLdbkoe3v82qAsqXodds+pKzO7+4QC0mAYHE/H4/kFCfmvPyIiTR?=
 =?us-ascii?Q?xr4EYmjWRez5eYts4hyw0qcBcuBOCe7dsOU8w62ibXbX4N/jBTMFqCjInmMx?=
 =?us-ascii?Q?GWeGjT2VTqwMXB+wuygqlEU/khPoOno84QAG3GFgCO3F7rJfv4hcZowyGF0F?=
 =?us-ascii?Q?/P4mBBjNocJddF3fYA6rJbBACEqf2PlCitpqOiuiPawW3u2f7Lkk5Gisk624?=
 =?us-ascii?Q?WfhZ1mLWg8HGj2bZRuXw9SCDF2IOX7G8/u2NoU48NRkGtHXRfgTwDpQ+zOEc?=
 =?us-ascii?Q?V+ptdsj5dTUL6c3qA7vaROFWkXVmjYG4tzm733j9tQMNcd0vrimtKPi7nPvG?=
 =?us-ascii?Q?+tl7lZJfiHF8s0Wwdk9YxJ0/4IJrIgrwh36dk7Km2Yj8gTre+PxO/75NWY5F?=
 =?us-ascii?Q?fLOj0dStN5eDLzt3Q0dXX6UmJUeTh5H8pmZzvSlGQY2kc672AQvvu9U+ECLY?=
 =?us-ascii?Q?RP9FTAIitywDKTRB6AAjdV1MJVemEKP8KbiJX/nC7SGldcI2GQwyagaW/ReW?=
 =?us-ascii?Q?XlGQ326+m8TgjiXABPbzqqht7SdyVk9bnQbRyNKuisa/Fo6GsojBtB7BdRwj?=
 =?us-ascii?Q?WdK6dM9EPmIW9nMMIJE9xhW472h3zh67+YT1/DN93VoLCj9Y3pgZzfvpnvee?=
 =?us-ascii?Q?furGw4tFLqmF0cyJWHcBX6yZm6Zc0LulsenGydqWNCHm/4K8mlOFbUPLsk07?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd009b-aae9-4fc4-0742-08dadc9eec5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 00:13:55.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFvCjA3Ao8wvm/qLBEuQOG72OAN0FovB2rl6rjK8IRkKyLLV8sbaAzR9CgSsxyKsh0UpIvpfPFs8nRlME/4gew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=913 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130000
X-Proofpoint-GUID: 7gZNslZeZA7fYgxRoNriLzXnocjoaFRv
X-Proofpoint-ORIG-GUID: 7gZNslZeZA7fYgxRoNriLzXnocjoaFRv
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
> Currently it is possible for all shared VMAs to use HGM, but it must be
> enabled first. This is because with HGM, we lose PMD sharing, and page
> table walks require additional synchronization (we need to take the VMA
> lock).

Not sure yet, but I expect Peter's series will help with locking for
hugetlb specific page table walks.

> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 22 +++++++++++++
>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 534958499ac4..6e0c36b08a0c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -123,6 +123,9 @@ struct hugetlb_vma_lock {
>  
>  struct hugetlb_shared_vma_data {
>  	struct hugetlb_vma_lock vma_lock;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	bool hgm_enabled;
> +#endif
>  };
>  
>  extern struct resv_map *resv_map_alloc(void);
> @@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
>  }
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> +int enable_hugetlb_hgm(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  					struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ae8bc8c928e..a18143add956 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
>  #ifdef CONFIG_USERFAULTFD
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	if (hugetlb_hgm_enabled(vma))
> +		return false;
>  #endif
>  	/*
>  	 * Only shared VMAs can share PMDs.
> @@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
>  	kref_init(&data->vma_lock.refs);
>  	init_rwsem(&data->vma_lock.rw_sema);
>  	data->vma_lock.vma = vma;
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	data->hgm_enabled = false;
> +#endif
>  	vma->vm_private_data = data;
>  	return 0;
>  }
> @@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>  
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * All shared VMAs may have HGM.
> +	 *
> +	 * HGM requires using the VMA lock, which only exists for shared VMAs.
> +	 * To make HGM work for private VMAs, we would need to use another
> +	 * scheme to prevent collapsing/splitting from invalidating other
> +	 * threads' page table walks.
> +	 */
> +	return vma && (vma->vm_flags & VM_MAYSHARE);

I am not yet 100% convinced you can/will take care of all possible code
paths where hugetlb_vma_data allocation may fail.  If not, then you
should be checking vm_private_data here as well.

> +}
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	struct hugetlb_shared_vma_data *data = vma->vm_private_data;
> +
> +	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
> +		return false;
> +
> +	return data && data->hgm_enabled;
> +}
> +
> +/*
> + * Enable high-granularity mapping (HGM) for this VMA. Once enabled, HGM
> + * cannot be turned off.
> + *
> + * PMDs cannot be shared in HGM VMAs.
> + */
> +int enable_hugetlb_hgm(struct vm_area_struct *vma)
> +{
> +	int ret;
> +	struct hugetlb_shared_vma_data *data;
> +
> +	if (!hugetlb_hgm_eligible(vma))
> +		return -EINVAL;
> +
> +	if (hugetlb_hgm_enabled(vma))
> +		return 0;
> +
> +	/*
> +	 * We must hold the mmap lock for writing so that callers can rely on
> +	 * hugetlb_hgm_enabled returning a consistent result while holding
> +	 * the mmap lock for reading.
> +	 */
> +	mmap_assert_write_locked(vma->vm_mm);
> +
> +	/* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
> +	ret = hugetlb_vma_data_alloc(vma);
> +	if (ret)
> +		return ret;
> +
> +	data = vma->vm_private_data;
> +	BUG_ON(!data);

Would rather have hugetlb_hgm_eligible check for vm_private_data as
suggested above instead of the BUG here.

-- 
Mike Kravetz

> +	data->hgm_enabled = true;
> +
> +	/* We don't support PMD sharing with HGM. */
> +	hugetlb_unshare_all_pmds(vma);
> +	return 0;
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> -- 
> 2.38.0.135.g90850a2211-goog
> 
