Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506376100BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiJ0Sxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiJ0Sx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:53:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C45E646
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:53:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHnR8n006919;
        Thu, 27 Oct 2022 18:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=LdPwG4ELMGi43hw4XQdF8IdlSUSf2woCfmBLAYtV7NE=;
 b=sB6vIHo3GabS3gezZUaBCSr0tHe92qhTrsqF+BmDSJ9/GLPWYYCpK+dHhNqGIMqORuZT
 b0MfwwinLH6iMDjWskn/SvBC6nQ4aQopdVkRn9Bd+g6SBBxDeURdkg45bMMpFmP41Ix2
 1bh4Z9qzUjhC8qJT5UKay3nSo0XXUT6lYzwB+oDFSzH/bk5rzFyLXl/HBagzAVmRYUa9
 oOn/hCqouSBGSsHyefdYLxQR13wdcZ13S7gZ9gZKP/B0wIFMqgo1kZD56UJ+rBdxA+oL
 H3MLihaNpB5rrkOgoGi2L4Ad1DtjyZmEVmsEnTgd2SERuIGfa/kLzCVPloBC5dtwHoq0 ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0ak1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 18:53:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIBxsX025871;
        Thu, 27 Oct 2022 18:53:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqa9br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 18:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc93JMRmqzh/rOOzvL1RY+Gu3Dp3GSukb9DTbAE11ZFcxFqB0dcZH6U99AC7e6EBXP+n/AYFAZhQnySDtCvXPgdLOFCWQ9iwUlA67JTZwwt9wRW7AQ2bhhj3QYOAolvaRKShPB8vbz7LgDmN9fUBsJhWUTZt8br/NLjmfkXdbiHTlgW3ZrCrW0m1Il8Twb6AZeRbf/nx4nrMJxerYcwbcFVTPlUREeXaFTp/gjRjphenDukPOT6cuOeLsOew/nKOQVxIf7wGbSYA6Op7TYLxhLO8QIvWw8hi3IHsoxZ2fwjfUhR1Z3FSeFjiFmwJwTg78/wn3Us9XCh/lKdRaDDhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdPwG4ELMGi43hw4XQdF8IdlSUSf2woCfmBLAYtV7NE=;
 b=PAuWDxhuVht8rvFhsnUjksWMAoQRSjhzcrAZtdVhZKefhH7Ao+neul9NBkwVFmty6/XLvIZmxwDrXqD8aHFFiFnKc2iagcVkIWWbMlyXm2vbOX6Fr1nwK6azrEPgnPng5WyvS74h0aQGVTFpsaWgNWe/UmD0YgsIL0PB/HRodmw5+3tqx4PNyymLEMnCgelWVSbWQyV7h6VXi5hu2QNK7TGsqwyWE18dQBTQScJ4i2nQnQiAfbjwzQvBHOGnK8JX5rsY8Uvohm247uC8cTtO5YB+RPjxEJP6S5NSFPkk0/6MP2K0qyQcNrvjOlD4sGn+frdBPNYNxmfCbUfQzA7cEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdPwG4ELMGi43hw4XQdF8IdlSUSf2woCfmBLAYtV7NE=;
 b=zBUmKwO5MmEHaawXcYkDSQJj5DiDENNHhAaZNHOBrM2O3MQ2sheLeb7cf9GrLbtj3OLvpBT/kLxbJbCPo6z03Lzz1lzHBQHLvvthJ5NKb5F4vMFldAQSY6iqmOmdJFCCZRtXY0UsFa6KELhCVH3Fh3L0+XtaL4o3Ymo0/oNNHNA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5153.namprd10.prod.outlook.com (2603:10b6:208:330::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 18:53:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58e9:95ba:d31e:ddd3%6]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 18:53:16 +0000
Date:   Thu, 27 Oct 2022 11:53:11 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: remove redundant list_del()
Message-ID: <Y1rTl/1lgpKwVE8T@monkey>
References: <20221027033641.66709-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027033641.66709-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: cd69ac52-65c9-4808-f576-08dab84c8207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rujhxHPbqSTv+LGrKi8KDNhEJi/3KO1XUiRZQGvBlOBgVWHPbYltf7TdaLxQcHkUcXwt8L/Nyke0dRRI7dGcrG2nCXnzlszEQuisO2gD3Zpyhszn5HRE9eMv+/Z6oHSBWlchUgvjZBnzcpgZtRlCoF52fEibcCX4gQoQ4RHfqTKDNCp/KgF8FgAebNIczsSsxeqXvWGuE9mDwijvg5VvwIUbAbMyP/X+TjFHWjORJtnpKNyzOjjNUOwBb3fr8bxLzdHinQ0jAV04NQPXFxx4jSdvbrmZu0m134Gj4KHUZC5qOzR4y+QpSiReQCW4rqVKX2K5CMF0HZDAy5YHJ9V3gGEj6VTLzZhIecG7tPfhM6Ad6OgD9b8T5BoUEBveHmoGNxEwxaV/D+DKjDNdEGaZ4VNlkdeeYwvXhqtkur1pqENysmvXX1elisrNQswxNi64z6331IxmJPa4Yq2yqboH421r4RohRD0FvyXKCI965Qm+cCrIDjrrepyDaOus03E+lZwA+SHbPD5S3S+kAqjwPPzaNRYCLHS8ygdYTCH1r7r8rA8zhdm/oRGuemrDh+nqIz4MD40/FQ6p4khhYoc5NsTpZJrYcNbb5VHSSlurj/+vh6uac2b/+xgZhuvWSDyUcd3HMafujLWbe/jRNrQNRqNRiInEzFYYYYpj/YhfmQSWTjiIQnoEa3tjdLLkduwRY2yx+wgO7TCkF4M3PbnMGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(6666004)(6916009)(6512007)(8936002)(66476007)(66946007)(2906002)(66556008)(6506007)(44832011)(4744005)(53546011)(86362001)(41300700001)(83380400001)(5660300002)(316002)(4326008)(8676002)(26005)(9686003)(478600001)(38100700002)(186003)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUFW6iQ3wNC8fzAkHfhaDE8wAvy3sv0JupcJ20Z/CW/PmmJol5kYmmLRxewi?=
 =?us-ascii?Q?ha6ESJ7FoaXjif28ZrfTtBKw7ZblI+yTyOGpOnBymYRsEN0w65WqeuUWzxUn?=
 =?us-ascii?Q?mp2mEVf6RIyLnYla8zMgBL66QB1Uz29TcsfCH1H2IqLn24CHtNvrSgCQo36Q?=
 =?us-ascii?Q?rvnPz3JKCGr39l82cz6ufFvkVDg8/KukwcWvb6uUgtgE+yaX67WVPjnE4ofw?=
 =?us-ascii?Q?t8OuHJrmZNpuXHalUDeiWtfkVxsesnuVMzY3wRnMLVK9Wq1fiC3mzd4fB80w?=
 =?us-ascii?Q?wCs47Qaz+WUH2FXIofyGJMHxAPpJqY7IWhrCeLq7XsyM8hIN3uaQw9IJSS+s?=
 =?us-ascii?Q?yB1b78LtcCxOmTWFwtU7l5LZDQJZuWDsi9RWSuM9Rsgy8TBKlJHa8aNDoQvI?=
 =?us-ascii?Q?Xv5mj5lc9x8VJ8QAPwrfQSObRRTBtZ4KWRPThpwhl07uK/zO09NjFUMoUJxH?=
 =?us-ascii?Q?r1de16ft5Y7ET5AYkWJ1sDfs8/o2D34+GhwDpFf+0fpbWiDXy/NKOmnBp3FW?=
 =?us-ascii?Q?+9NexPCSuzIWoAn0QD969nmHMamNw74hV4NZ9PHD+aPd4U9vnWKu4JaVINTh?=
 =?us-ascii?Q?3ix2uspO7x7L4yV0zmwxiMYJ0tUJ7g4dgKfb16lu3BQXnfa2cSxpxhdRSeln?=
 =?us-ascii?Q?KVOdARfPc+Z1NZpNZHfqiR55I7uWTCf0Vm82ChqxqWc6O1KZ3wBNsTlQaRZk?=
 =?us-ascii?Q?mJE9L4B1qzrPuRPnhXY41NnyLy2RnxJ62CAGRERO4/5w3yTPYEwolxAZ5yHl?=
 =?us-ascii?Q?jF/Da7V5HeFDe4gh68Bq9KkFttyjp5w7MqGw0EzkIb5gNnwOreY0ZtwuKEhn?=
 =?us-ascii?Q?k26MTgcrEQefol9bezaqOMUaVmSEo6JNg/qQOsTui/YmBJDS5mQMxil7xwZq?=
 =?us-ascii?Q?nBXx+bkPQbkBXdLzmGvrISt5lCHw4dIYOQJtJ0CfKMagIxXGcfF9E4v5V0aY?=
 =?us-ascii?Q?ZPoZ5ANJRlH5SkcBIQD/OdQ39zfdYjyWbbd8gj0rxb9Xgq9xH/znlBYGNVO3?=
 =?us-ascii?Q?qUbVdjm74h7teRrlHS4IHQwLo9L2LFbAmcZEauUPQlG5SZOWSzsDKoP4DjH+?=
 =?us-ascii?Q?av0LhVvdvctQCBd9Vf2EhYENrGc7TDzaZJcNNnAC8I5/ZQxWR0eYd7jpdT+h?=
 =?us-ascii?Q?RL6yfXmmqhmS1Jum3dOD0mGH1gSb1lj86pcbR4ZMZqZO1pkjZgNSPkK8JLte?=
 =?us-ascii?Q?Vny2Dso7Euwjm13HgtcISDwkzGpho2FK1wReNQqDJWNpq5IeCcG5rIuq98FN?=
 =?us-ascii?Q?WRzyP9lnyuOCu7Fjse0uRVLiDmgKpFaDnga4JaTu5yevUnjRwvkMN8ozQ7SP?=
 =?us-ascii?Q?I0okSuyqPSPO2BjHnuvE+rEFFU9ds60zvdOS8oD4pPKfws8riH7Xog8+H+9T?=
 =?us-ascii?Q?UkRicrvUQqdnrCJv7vPy5tnw/NUpE1YgSdWWmJl6EtStTWbYE/fUgGupERwo?=
 =?us-ascii?Q?SVd32RKPBHOTToY/k7x95Gtci9dYYkbTiWjL8MqaO1nd0AN4bVMIcPh3abim?=
 =?us-ascii?Q?jOAn4dQ0qTr/igsjocftF0+cQKi9n/jblhl95aWAPPAkCVcsJAhyqC1uQywG?=
 =?us-ascii?Q?Z9GssMOqYVjSYPaNiye8xtAy5m2yLxgsJUxAOiWWlTFdRK/3mttj+m9RKJhM?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd69ac52-65c9-4808-f576-08dab84c8207
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:53:16.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWgz6w0k0fTxRaXPwgBpd7oqX+fdLE4TAM2hLxaTd/b6oKFhKGDiGz7dxu6fUyckXSFydxUHNnWq1ZyOB642Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270107
X-Proofpoint-GUID: ITAIWMDmVT18trbCXEEfmIyqu8Sy62Sp
X-Proofpoint-ORIG-GUID: ITAIWMDmVT18trbCXEEfmIyqu8Sy62Sp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 11:36, Muchun Song wrote:
> The ->lru field will be assigned to a new value in __free_page().
> So it is unnecessary to delete it from the @list.  Just remove it
> to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 20f414c0379f..c98805d5b815 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -231,10 +231,8 @@ static void free_vmemmap_page_list(struct list_head *list)
>  {
>  	struct page *page, *next;
>  
> -	list_for_each_entry_safe(page, next, list, lru) {
> -		list_del(&page->lru);
> +	list_for_each_entry_safe(page, next, list, lru)
>  		free_vmemmap_page(page);
> -	}
>  }
>  
>  static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> -- 
> 2.11.0
> 
