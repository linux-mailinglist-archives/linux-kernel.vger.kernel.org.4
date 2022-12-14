Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0A64C179
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiLNAsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiLNAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:48:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4F55BF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:48:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLOS0G026444;
        Wed, 14 Dec 2022 00:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NdRWePg6GPbjNBRaNDRD55/O6zBJSrpDpCb0FFVHQnk=;
 b=Rqa2xAU2jrugtVKE++a+tRE8vCYTHN7jzzMnhzBpTUdcNUNUxuMyew4s9uqMuP4jpmog
 f1aBS/cRw/f2De1j2TnA9m3THX1y/pyIKxSJhHefybkMyclTL5DcbseTqhXsgcpC5L9q
 oJm/d9im1oLa7RLHV1TzL9wQ5NFhZ6T+HuolQoQxePumEgnBJTWNzwP6ZUTTWS2SQXju
 Rq6Kk6Akd5PzSyLtFivLCNusJryHPJHSHpc0skJzQYqpj726WN+IJHB1Mk4Lo4xZqsea
 A9YdDYWzqGKVBnQ/bb3EBAnIungDqdZu9RsWqmfXIcHyOjwNGZMjgzkgtZyNmjTp0/Tl qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewrp9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:47:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDNJT52009648;
        Wed, 14 Dec 2022 00:47:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyenw5k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 00:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn+s+b6uHqsCNL7OYNyMy2E45MoBdifBo3EHskskluBbQmrxTL40ILloQSZu7loYvkxwh8T3BkEYj4woiLeGrO2Aslj215kNmIe5L1NfbbvdNNeY/ybzYThoHydOz5enMzTs0sCh/oNyEUrsSBP79NWT0AayRarmt5wyEyuHmADecBB66xDMWFVKpNkWorIPxBWqyLSpAjbXdYlNhOTKf2KfYdRANUAfopydXFRseCtF4NAu5f7Fo3SEIWbG+lZiraSIisQ02+dFFLvCrmfcLILr4+Og4cKEYI7VUQhO/K99fB6eGSDmVp05czPl1jAK546RUEFvTiIzG7hPBOWQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdRWePg6GPbjNBRaNDRD55/O6zBJSrpDpCb0FFVHQnk=;
 b=WqdzEClhp4m40Ru9/I4lVNW6832uF3ZoCzCkSBuiQ7NSWWRg6hCQDrecTr7O6BKq4lsmKzQfjFoeQXaSRbODGe1YYY7ntiPjlx27rw5Ip6S4OZQfy1cAhqbpYUwO3EY4BDzOvqg19j0tbC6BLctI4U9vpfy/OSoOsVHqG8anGlsaFMETV5+mJTXCLQUukkALYwzUEL8bRyFyl4aY5Ght4Hn0b60mDEdqEzDbQgWDhSiclCe25naEnhRQgdpYtoi4jG80ZSdyz08518DroLjTgH2e7ym9ULglQwtTxMUGPBVPrW+/+2uVJUsfZH7eDXob5YjzuIq1BXN6XT56sKxA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdRWePg6GPbjNBRaNDRD55/O6zBJSrpDpCb0FFVHQnk=;
 b=KLEZ8+sphpN6X8sOdaC3FIIhop5jEQKQarJToRCEV2qbW3RaWScPQ5/sVU+Ljlybc+e3er+DKlvF8EQEnWAu6uoNz/kmeSVyqp73bJQGUWwOpL/CxrPzd6aBtCFpEO5OfomQ0gU6MzoGJYj6KGtpWtQ97Qz/nAisRBofpG6pWQY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 00:47:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:47:36 +0000
Date:   Tue, 13 Dec 2022 16:47:33 -0800
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
Subject: Re: [RFC PATCH v2 12/47] hugetlb: add hugetlb_hgm_walk and
 hugetlb_walk_step
Message-ID: <Y5kdJQgrPRwvw1VJ@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-13-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-13-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b597e0-2dd0-49af-df2d-08dadd6ccb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqW7f0fUNXjhEtQnp92P2I9uChBVgaveYuc3zbrQYBAQed4fN1HyGOxxBvPndlPdhd2p72R3xYAQCe/HgAVckslHHDKgYnSVJBdDlnxBet7Vrkj6wZFUwtFkG4RLbGyYWLuUEC64zcsp8DU9VsMUEg6GGb1dUp9kfUxXjIoctchtpGVckb15iYQ4VUHGef9hf8KCPF8Z5RssjtqT0nG1QbQHXJ4PEs9NHhgzv6PJEMKvgb7KrDVroTgKf1jQ72ItMZ8B7Zus83T4/LURU/0PNpJM8vbqnSraHpwOwmnUpYbaoyHYVpLVI3AfCBf5iuOqhSw4h4ohO+tDa6wuraq6g7Dnis0zEfZCXHrOO7PNFgEgvcl792C9qQh2iQtwG4gLZPpFvy82hmKb1+Z1l+/vMhyOHfysnS965NYy/ZhJmlQAqOn9Vt6N2YNvskHM8loWzYYGDx4wcHsIcVb1Wrpp+y6Hpozb685zYlUeLhh6nhLT3h4EuUS/Kl57CYTI5cW0YmT/pmlcGMhjVZsZswLRSCJ5W6vSH1px4mvVHqvt7o5Z1f8llT457r20Eco1Ik3BDijnC9sHEEvE4QYegnoBaFKBzbxZEv3rJbR7SNWEnSF+AalVTBo3UOo/7VV0XmJeXJyoBjPA7ICc5Lx9mxZ3bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(66556008)(4326008)(41300700001)(66899015)(5660300002)(7416002)(66476007)(44832011)(8936002)(8676002)(66946007)(2906002)(6486002)(478600001)(316002)(6916009)(54906003)(53546011)(9686003)(6666004)(6512007)(33716001)(6506007)(26005)(86362001)(38100700002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRjcC49w3BBUQEgVULQY7uHI5QvKx2AxcKE8BIv5zUoSERgn+cN6QFtMtWMI?=
 =?us-ascii?Q?ZkpbjwOHy+9LgrZ6ga+MYzCpW5aZQYMFgvvFbTbcr5iHrBlC7wdF+I4du0i3?=
 =?us-ascii?Q?VBGNXTMbyYdBAX8sDb1WknpGHhI1xAWtZZbCEbfW+XaqPTbdt167T3ZVAnWA?=
 =?us-ascii?Q?6k+nRhpHh/sr7pJbjPHGY/W8u+ZmPlEZLkgqIHoRsOvhxr4yKe6WLBA0r2tC?=
 =?us-ascii?Q?ZvZGjIccZB7xyZKfZjH49G5OLrvkQZ2YKXamp7eg5quWkbSkTpi+2CUKN8BW?=
 =?us-ascii?Q?uMKkUmqrPUbpWkcTCSu9GlKrdhIr2EsnX2kB5AbMMVASxmYugEWcgbLUkzLI?=
 =?us-ascii?Q?S+j+Cx3gcuk8NLMLRXtoih9Vi5xbzR/MTr/pWgFOtD8AVSDZnid4BQ2L+NJG?=
 =?us-ascii?Q?sLK0R0R2T15TojyyPbyullrOxJmxWt2kwaaAm8Pn0/cqv15rTWl6j7/rSRuG?=
 =?us-ascii?Q?NJ9dSwoT9k207qAJNEqQKCmelGy8yMK8gJ2cZWhDpFX52XZxk6G6Kkw60pEy?=
 =?us-ascii?Q?IKg6jMhPxFgTFkKWnrzD09PmiaNAPeVoNKgBbD8ZvvcayxJLRde1DFYYqIhO?=
 =?us-ascii?Q?UrHMuVUyg9AuPc6zVNp+09ch23z7O5NHABv8vKhCAsItYTzTCJBbh4gThFbs?=
 =?us-ascii?Q?exYaeUCotEWOXsj1EFtJ8e2G5ou8c3OaqRrRAI6W8n5Za9AzpQkBw26FYJS3?=
 =?us-ascii?Q?K+EaizHJe22QDghpAvreyJVm9H13B2T85du37i7dhy2iwMRu7b6q17cOUEN3?=
 =?us-ascii?Q?kU38PBLUDsglOy79p3VzDLzz0juIG7W592Q3lbFU4aOgF7LoCsPtpmZdCF3a?=
 =?us-ascii?Q?h24QpVay6Ste3LxXBOY8qzVjS7zshTDV9THJ/NFgF/naQxDqajvgFUQz/gmw?=
 =?us-ascii?Q?AXopcp1w2CQ9O3fo4nAeafKSv1/Ozmbv+S7JRVJDszptSB43Vgx6E4bu+LrG?=
 =?us-ascii?Q?IoY7ZUbOjOBtX0tHy7AHWlA7jMmvpQNmavvtMqsSkFjuo3fkJYk2UzjNJDN8?=
 =?us-ascii?Q?E0uFM0HfNPREWmMmxeU0GtGOrF+oIrz/8ow+q1+BhxqA0Lk8Unz4msQMvnYR?=
 =?us-ascii?Q?96IFEdiCgZJ6nFtu0qdc1TEm0c9sbt2TVI7pr6ASfHQvcdVMrTmVC34D0Z7k?=
 =?us-ascii?Q?va5y1xr4fz0VyLN0zWcdMnqqakTpNDUGmbT6evx2IYErLcTBPUZdcyGB/BfX?=
 =?us-ascii?Q?kbdIpgOu7Mj/mvFicpXRluIP+c1YhLFUWZeyBu/bJTKUe6V57/5VHTYkt0MP?=
 =?us-ascii?Q?yV9lL68xwYA1FO2G5oVXpQ6BqXhG+iC0S5dHI70/BrJ7VPt2PGLaG4JPlfzk?=
 =?us-ascii?Q?0jUNYRE4qqHtXW1lH0RhvrswSWAKL4Q2Y5HBm5oE+0c51rdEBHg3JN3CGVhB?=
 =?us-ascii?Q?Lc/O89l6Y3lBqfVOBw+WYpOGjmxSsvcHBlvVRl+2df4BMjoI/dmh+kTU1F3t?=
 =?us-ascii?Q?TnIRs0oyIxob1pMRKBmHwqE5lYfx5RPQSBcXhjH0k2Hs4DlBUK21rVS1CbJj?=
 =?us-ascii?Q?/6EwBAgZr0NAPeZJsapiInmeAv3r2gmfW8WFnejvhv07pzZ/NOR6hyu2+csK?=
 =?us-ascii?Q?CWcsIRltAK/7PEKFEhGni2R/G750EwI0KMu9vhziWnZI7w3+/5pwrFtbYqEe?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b597e0-2dd0-49af-df2d-08dadd6ccb25
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 00:47:36.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOr4m3zLRhY5Nb9t9zndSORZWS7r4giD6m2yavMoIEYOfoKVE/b20FE1k4M/CNkFqg6v+2fZpoR0MkPf0+7fLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140003
X-Proofpoint-GUID: j7QTz1BI1JM7mLFGaFlnhAa9SClZIVVO
X-Proofpoint-ORIG-GUID: j7QTz1BI1JM7mLFGaFlnhAa9SClZIVVO
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
> hugetlb_hgm_walk implements high-granularity page table walks for
> HugeTLB. It is safe to call on non-HGM enabled VMAs; it will return
> immediately.
> 
> hugetlb_walk_step implements how we step forwards in the walk. For
> architectures that don't use GENERAL_HUGETLB, they will need to provide
> their own implementation.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h |  13 +++++
>  mm/hugetlb.c            | 125 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 003255b0e40f..4b1548adecde 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -276,6 +276,10 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
>  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, pud_t *pud);
>  
> +int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     struct hugetlb_pte *hpte, unsigned long addr,
> +		     unsigned long sz, bool stop_at_none);
> +
>  struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
>  
>  extern int sysctl_hugetlb_shm_group;
> @@ -288,6 +292,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
>  unsigned long hugetlb_mask_last_page(struct hstate *h);
> +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      unsigned long addr, unsigned long sz);
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> @@ -1066,6 +1072,8 @@ void hugetlb_register_node(struct node *node);
>  void hugetlb_unregister_node(struct node *node);
>  #endif
>  
> +enum hugetlb_level hpage_size_to_level(unsigned long sz);
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  
> @@ -1253,6 +1261,11 @@ static inline void hugetlb_register_node(struct node *node)
>  static inline void hugetlb_unregister_node(struct node *node)
>  {
>  }
> +
> +static inline enum hugetlb_level hpage_size_to_level(unsigned long sz)
> +{
> +	return HUGETLB_LEVEL_PTE;
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3733388adee..90db59632559 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -95,6 +95,29 @@ static void hugetlb_vma_data_free(struct vm_area_struct *vma);
>  static int hugetlb_vma_data_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>  
> +/*
> + * hpage_size_to_level() - convert @sz to the corresponding page table level
> + *
> + * @sz must be less than or equal to a valid hugepage size.
> + */
> +enum hugetlb_level hpage_size_to_level(unsigned long sz)
> +{
> +	/*
> +	 * We order the conditionals from smallest to largest to pick the
> +	 * smallest level when multiple levels have the same size (i.e.,
> +	 * when levels are folded).
> +	 */
> +	if (sz < PMD_SIZE)
> +		return HUGETLB_LEVEL_PTE;
> +	if (sz < PUD_SIZE)
> +		return HUGETLB_LEVEL_PMD;
> +	if (sz < P4D_SIZE)
> +		return HUGETLB_LEVEL_PUD;
> +	if (sz < PGDIR_SIZE)
> +		return HUGETLB_LEVEL_P4D;
> +	return HUGETLB_LEVEL_PGD;
> +}
> +
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
>  	if (spool->count)
> @@ -7321,6 +7344,70 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
>  }
>  #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
>  
> +/* hugetlb_hgm_walk - walks a high-granularity HugeTLB page table to resolve
> + * the page table entry for @addr.
> + *
> + * @hpte must always be pointing at an hstate-level PTE (or deeper).
> + *
> + * This function will never walk further if it encounters a PTE of a size
> + * less than or equal to @sz.
> + *
> + * @stop_at_none determines what we do when we encounter an empty PTE. If true,
> + * we return that PTE. If false and @sz is less than the current PTE's size,
> + * we make that PTE point to the next level down, going until @sz is the same
> + * as our current PTE.

I was a bit confused about 'we return that PTE' when the function is of type
int.  TBH, I am not a fan of the current scheme of passing in *hpte and having
the hpte modified by the function.

> + *
> + * If @stop_at_none is true and @sz is PAGE_SIZE, this function will always
> + * succeed, but that does not guarantee that hugetlb_pte_size(hpte) is @sz.
> + *
> + * Return:
> + *	-ENOMEM if we couldn't allocate new PTEs.
> + *	-EEXIST if the caller wanted to walk further than a migration PTE,
> + *		poison PTE, or a PTE marker. The caller needs to manually deal
> + *		with this scenario.
> + *	-EINVAL if called with invalid arguments (@sz invalid, @hpte not
> + *		initialized).
> + *	0 otherwise.
> + *
> + *	Even if this function fails, @hpte is guaranteed to always remain
> + *	valid.
> + */
> +int hugetlb_hgm_walk(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     struct hugetlb_pte *hpte, unsigned long addr,
> +		     unsigned long sz, bool stop_at_none)

Since we are potentially populating lower level page tables, we may want a
different function name.  It may just be me, but I think of walk as a read
only operation.  I would suggest putting populate in the name, but as Peter
pointed out elsewhere, that has other implications.  Sorry, I can not think
of something better right now.

-- 
Mike Kravetz

> +{
> +	int ret = 0;
> +	pte_t pte;
> +
> +	if (WARN_ON_ONCE(sz < PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (!hugetlb_hgm_enabled(vma)) {
> +		if (stop_at_none)
> +			return 0;
> +		return sz == huge_page_size(hstate_vma(vma)) ? 0 : -EINVAL;
> +	}
> +
> +	hugetlb_vma_assert_locked(vma);
> +
> +	if (WARN_ON_ONCE(!hpte->ptep))
> +		return -EINVAL;
> +
> +	while (hugetlb_pte_size(hpte) > sz && !ret) {
> +		pte = huge_ptep_get(hpte->ptep);
> +		if (!pte_present(pte)) {
> +			if (stop_at_none)
> +				return 0;
> +			if (unlikely(!huge_pte_none(pte)))
> +				return -EEXIST;
> +		} else if (hugetlb_pte_present_leaf(hpte, pte))
> +			return 0;
> +		ret = hugetlb_walk_step(mm, hpte, addr, sz);
> +	}
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz)
> @@ -7388,6 +7475,44 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *)pmd;
>  }
>  
> +/*
> + * hugetlb_walk_step() - Walk the page table one step to resolve the page
> + * (hugepage or subpage) entry at address @addr.
> + *
> + * @sz always points at the final target PTE size (e.g. PAGE_SIZE for the
> + * lowest level PTE).
> + *
> + * @hpte will always remain valid, even if this function fails.
> + */
> +int hugetlb_walk_step(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		      unsigned long addr, unsigned long sz)
> +{
> +	pte_t *ptep;
> +	spinlock_t *ptl;
> +
> +	switch (hpte->level) {
> +	case HUGETLB_LEVEL_PUD:
> +		ptep = (pte_t *)hugetlb_pmd_alloc(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		hugetlb_pte_populate(hpte, ptep, PMD_SHIFT, HUGETLB_LEVEL_PMD);
> +		break;
> +	case HUGETLB_LEVEL_PMD:
> +		ptep = hugetlb_pte_alloc(mm, hpte, addr);
> +		if (IS_ERR(ptep))
> +			return PTR_ERR(ptep);
> +		ptl = pte_lockptr(mm, (pmd_t *)hpte->ptep);
> +		hugetlb_pte_populate(hpte, ptep, PAGE_SHIFT, HUGETLB_LEVEL_PTE);
> +		hpte->ptl = ptl;
> +		break;
> +	default:
> +		WARN_ONCE(1, "%s: got invalid level: %d (shift: %d)\n",
> +				__func__, hpte->level, hpte->shift);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Return a mask that can be used to update an address to the last huge
>   * page in a page table page mapping size.  Used to skip non-present
> -- 
> 2.38.0.135.g90850a2211-goog
> 
