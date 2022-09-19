Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7815BD794
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiISWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:43:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C234D4F4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:43:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMOS3E015042;
        Mon, 19 Sep 2022 22:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=LWiTRK7hifZTRFqroHXt8Ts8xFgt7p6oA3jTUP3xOSc=;
 b=yzCldkgOy03nBJQJaunhmD4pp2MMVI86rFosw5ps619CVIHvESFaboTB8nOF3bJrq4/b
 PqN4CChvbh8+M2aNn4hVBhcFlmW9QJUAshEAXChTs083IEDpBKUsjoy71LSJabiemQ7M
 4lJ+B9bxwkjVwd4A70NhZntlh4nVtS/uhfQMARSzei+8x1yKLY1qYbq979eLIgjkAixI
 W7dE2Lo+mo5q06BQU0EyDnuiaEaprz04fjyHn8dl9/WWabVhHcthSZ7uS5PUdp0Y5YJZ
 Gnb5aeLiBo0yMNC2e51dZEabnbp48s177gQx9cl6hk6pJkgvQS4jnHBE4s6TuL2Pwxib +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m56jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:43:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JLenbm019025;
        Mon, 19 Sep 2022 22:43:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d1mcsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY8NYfjda9SKC7oY79p4hBBABF3T2lQS04wcLFzCNiFgeUVrX+1IM0HiVFeIpChiQX19GyrahKzxiGqk45MtG4j34RreE13AeSWOvhnLzVeEZ11duvOsBLWvL9xRWHcGzzP7mUmqMt8kEpnAMGWgTAYds4PrmlkWR92SywLntVvjticTEM3P4GjujUPOwU4zhsi+Xqq+YW6wIZ7B08/+2CloycigZqZKZSjFz0WH8Tys4KNitvsCtuPUpdthj7mwZeFskZHqsFcCK/jkQPQpzDNgvmWCzsKBR9J9p6nsgm+9+5FQLLp9SI7k61dFoar1H+ozUijceUwKD+SEi51IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWiTRK7hifZTRFqroHXt8Ts8xFgt7p6oA3jTUP3xOSc=;
 b=lkojUuijMNg3x7mXCAI2JI5BbIVzYPRwfNYtmo4jOVl68oOhpBD0kG7SIBRmWAhQXZtVLziPrp3wWPCyMxPTpRSGgQka0lLLdcqr8U8/Nf9PjQ3/oqynAS5yf611dbTjrFDn/2rBL5mbLDTGJAVzV/6D9f0gO1JN0yd8Hz/GoUTpDOOD8bTuZ9ijX33Z4xNKQcC1hqDivK/Ar7xizS2x0uT//DQyT7wkIJ6sxGKMLXeca0CzLVZHtutaH7TCm7+9xwvc5zn+stYHzE+1kNfoSugrmyQoYJhnx/G+Uf1gyhUysUyfbu6TY132KwTWVSihzU71BCROSk94E19fmsxv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWiTRK7hifZTRFqroHXt8Ts8xFgt7p6oA3jTUP3xOSc=;
 b=C8iolv/esOUPzxjJfnr5222E8A1bxiUEuK0i45FgW90sKoN/y2LohjvG/+9d2FRQ+oW7zOcsCVboIgIVRV/ZXuduP0KxGSN7gHQslYTpJdzoBwZDuawMFl7b4Ouhr9KOLfMawwkDRGW69NOSdGi/PLfzq5yBWZyV9cSUUoSdTBI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB6915.namprd10.prod.outlook.com (2603:10b6:208:431::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 22:43:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:43:30 +0000
Date:   Mon, 19 Sep 2022 15:43:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 6/6] mm/hugetlb: add folio_hstate()
Message-ID: <Yyjwj+0LjMbRNkYw@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-7-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0243.namprd04.prod.outlook.com
 (2603:10b6:303:88::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ccc12f-db8a-4725-0069-08da9a905fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 121kFyQMR7zTaXXcCWPGjqOEqceYesdo/MhmPbxwzi842Z7A3AElfODdB/VIcxISH0Ve9s1TYfzKdNLQOdVa2DOmA6BN9EoHMpWR+HarVMCwoAh/bFsCIKKawdpS8g9zrnIruXyKAsxmKEKhEdHWhPJSd5q8MaGfyPDflkD2qo+Ae9or2VcQqJF0pRnZv1HNodP7dZnfkdPglv+irjBeHwCtJquhGZZ5+2GlSIsJdk3wHnThVOyYm2auOt+P1KVcuOt5ZpqeQjJl+/pxgmxsrofwOXRfkedI5/LJrLGUB5+lBmKVZx8yUaGLpHzdzlNfZ8kNw8gJ6eloNWH85Sye2H3cph5UAbFwky+UgRP0SnhgZReO+PHeWMrOq5qqBvZidPxgwK4Y6Uw6utXAiLCbPkyUZNqwyIm9fkS/Dc4gyexJMzR5Yap0Bbozevs9pS0RY3uUtnYlQiEk0Ci/ImYFqdSy2quyVDyXtrqd5jy4eiVsjQtU5YMgDpdYLs/NLkc1Q0u79t1DR1TSL3rsAnI6DGgW89Dx/5Ro3YaF2O7TCJ51zSu2rSQP+3eGEdwnM5lOtp3ud2gNkd0wMqse1IJ7aLCCabd1lPywJeH903Z1n4L/LFBtFsBkQHsMqGWNgteRfsyQmfgxjqveGUD+wJP9cpUOIg75+uCpKPSgisr9Xf5edQqyRu1h/v3tTySnEsLcP8QE4pObl01x42ZOK4C/62MiXd1b8ORaoW5U/HYvyHFaSGIUGc16P+iFdzk+ydSF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(6862004)(478600001)(316002)(6636002)(6486002)(41300700001)(5660300002)(186003)(83380400001)(86362001)(38100700002)(26005)(6506007)(53546011)(6512007)(6666004)(9686003)(44832011)(66556008)(8936002)(7416002)(33716001)(66946007)(2906002)(66476007)(4326008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fh7us76JHBwxZ+CYiaipCIanwHOCNkHOx8CMIjQbNrHGsKJpUByGEC43ch/w?=
 =?us-ascii?Q?EeYSQODkUeoRMpoZXxW3zCsN3bH4WJoFBNNWLuATI2iMrC2WxXSI2xbu9e94?=
 =?us-ascii?Q?aKwT/HGomg9U7cJn+3KT4NNxncPP4G4wUFCengUuWhWPlzBo+UJYZZWjsMHG?=
 =?us-ascii?Q?lZXUQvHObcB+MFnLHESY3aDXIF8z15egQeXxDFTdrzx0V0pIzNSdmctHmkMr?=
 =?us-ascii?Q?tVBR4a4NTpmbQnWB3/e7U83jOoIw7/p6U876yT4O8zDtXOWdNryyQyPBG2bo?=
 =?us-ascii?Q?+1tEa9NaqmmOMVcf6wtVqc0GzrsPMHypXS/MuCtijCbb27WPtyYdpl+oK0Af?=
 =?us-ascii?Q?WoFActEUtMXMWz+Ytvv5BTiQddc8tGxeAxVRLdh3Z2MmVSPRIA76Nz5kGMxk?=
 =?us-ascii?Q?O8tcbqVFC5lR0YIyfvwhi3edbaU0Ktx5M6wVvaEbWDl9SjIFifyCVLNLfrQh?=
 =?us-ascii?Q?eIgvI1iLLdfz/7nYQcATt76G0t5hFlJUZtZjnnfPkRwSTXNAj3Oe5/nJb0RQ?=
 =?us-ascii?Q?5Jl7geDDlnnLzdIrjNV81O2Z3qq5U9dyNdExgJFFno0bRHysZpqlnEl5wdE6?=
 =?us-ascii?Q?7crZ93jDqcUP5rM/tQ9I0EzL+IuZut3yZkMcPRLiXrf3TZvF/2P7JQNorYmp?=
 =?us-ascii?Q?9dqvUAiMaTwxFpCvM2HI69bL5ZXjfH4ZQBPhu4AtGd1iqr+6+VJGAFUuP0PD?=
 =?us-ascii?Q?8W58weltCJ6VJOujswILNlNoAN9HJyq+plnPaHkbJB8qsGKNbzR+CVYFDcUn?=
 =?us-ascii?Q?gln7QkosY6SUQYt4PMXW7My4FFNGGJoZvDE0vLZo4XXxz9BAOfzF8rLT6pLy?=
 =?us-ascii?Q?8DFCyS5x8KfFRthjQOm6W1IDoBn8q7366NSyuZls7TXUTJ+cCJMC+MVrlPj3?=
 =?us-ascii?Q?ZtzJ2tAWlll/GC3PB6gNqVtCrtXIHLtkkhVW5ORYb8YIxp+7+RwAMc6Nieem?=
 =?us-ascii?Q?uV4ILYGgnDzEo80FPBSs3Xu9TAXhOOHFWMIWWncumPHY3DFJTJ2Eq/WQJ92m?=
 =?us-ascii?Q?m5FzldjUf54QvOX7pZJrZT2rwpg7+fvp2o6p+DR0TQVmaUJIHOzUi4tzMpe8?=
 =?us-ascii?Q?BLxdxZmEaLqmBJ4RmQkTLhBj+7FRlLzl2wrxYvFg+m34sDMt76xuLYv0Sbu7?=
 =?us-ascii?Q?aG7NGKas2E3XIuhdmnJnT8ClbfM/KmjLxK4mJX8KBxJepH/ERoPqImPjdc4Q?=
 =?us-ascii?Q?jDVJyDzihpmI0bJEDrZPAGbPSp69BmV3C8gR6Wp8cqlI+F2YdKJBY9hbW/Cx?=
 =?us-ascii?Q?CeKTgcFsdnuo+C+Q72csAqsnQz/Vk6xo5pT+D8+SiDKYPLhRUtxTqk2fUN1n?=
 =?us-ascii?Q?eFXKWw3lT1/T0NP270TjWWxUf4uKAL/i21uy3hWiGY8s2hkbbKqYXA1oMHkB?=
 =?us-ascii?Q?zMLb8obKCTmycFPoksn7hFaO2KgE3JtboSP/NCy4Fm2UIzNkkvZ6FB7w2N/w?=
 =?us-ascii?Q?jyqkKtiTrd7Q7fZV0WX/RyJM1fkUBWQlxUyFzY9w4vjEA2U+ep9CCoJDy2TZ?=
 =?us-ascii?Q?eSRVY13GBsCaSekksed12YBEHiQxvuETsFJV+fFsJDj8PGzwGrFIIbq3tNJH?=
 =?us-ascii?Q?907GjcRj94EAJsgI6Oxtku4OuBysJ2Sv68lSkO9iTkhhHU/+W3f3kCPSHgZT?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ccc12f-db8a-4725-0069-08da9a905fc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:43:30.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yet4dtMh4LajIa44wDIz4IFKRCJzSXbXfChllC2Txt8TH/PVqB/QCPRHHf3sjCbuvp2ClK4EJZHb4Tn0yWCMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190151
X-Proofpoint-ORIG-GUID: 8Fe2zvXf5Fa9zDcaVvifemvIjLEL2yrN
X-Proofpoint-GUID: 8Fe2zvXf5Fa9zDcaVvifemvIjLEL2yrN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 12:37, Sidhartha Kumar wrote:
> Helper function to retrieve hstate information from a hugetlb folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/hugetlb.h | 14 ++++++++++++--
>  mm/migrate.c            |  2 +-
>  2 files changed, 13 insertions(+), 3 deletions(-)

Thanks,  Someday we will be able to remove page_hstate.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 0bcaca694ab7..f59e8fb3f937 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -850,10 +850,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
>  }
>  #endif
>  
> +static inline struct hstate *folio_hstate(struct folio *folio)
> +{
> +	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> +	return size_to_hstate(folio_size(folio));
> +}
> +
>  static inline struct hstate *page_hstate(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHuge(page), page);
> -	return size_to_hstate(page_size(page));
> +	return folio_hstate(page_folio(page));
>  }
>  
>  static inline unsigned hstate_index_to_shift(unsigned index)
> @@ -1057,6 +1062,11 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>  	return NULL;
>  }
>  
> +static inline struct hstate *folio_hstate(struct folio *folio)
> +{
> +	return NULL;
> +}
> +
>  static inline struct hstate *page_hstate(struct page *page)
>  {
>  	return NULL;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..55392a706493 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1589,7 +1589,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>  		nid = folio_nid(folio);
>  
>  	if (folio_test_hugetlb(folio)) {
> -		struct hstate *h = page_hstate(&folio->page);
> +		struct hstate *h = folio_hstate(folio);
>  
>  		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>  		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> -- 
> 2.31.1
