Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8860824E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJUX4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJUX4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:56:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6532BA5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:56:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDdpX019107;
        Fri, 21 Oct 2022 23:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=IDvpqFn3ChvBFwc/A6MbKcp3tYedqMcsrWfQg0NaJec=;
 b=UlxAGgumQMhPpN++aYk3Rv5ydKlfuBqWL5tZhM2EUr6Mw5tZXW+5xNoiaifgzOmMnXwY
 dAhxhDM9FlhEyofMigSO13+Si2PbBUSUZy3+fugurTQzgIpPgEF2lz2WkjTeAv2wmoP3
 HwaeJjqFemu/iY3VhHzlMcF5w6lazc28WgBbx0MDte785k9SIOiSJBKCrFv8TpRvVsT3
 hVHqK3wYnylhYLPBDVbmHN6d37uc0WRe05v6a9uuU4wIeDFt6ilSQBJsEnPZxzOAti8Q
 bi/nVctNRF3TUBVPrKEfu33kfp+3NPyOYpLjFPFb12IU1N1wZsZIZ9VqPSqAQaqd6ars WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7swc9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 23:54:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LMep3Q038563;
        Fri, 21 Oct 2022 23:54:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr3p4hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 23:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKdp2zdRhdTrcI16RJIZhgAOZHJjLos/DD5CAx0N64OydZz3nqEtcylx6tOe56ID0ARTgVVEoSLp5tTppEFwSlY5y4vpXsSKg3UPm5Vwl8iqH8xO6LumQ4PUCAqSfjpgUhsU9M3JF7NFuuhEfTrwQ70mxzfK3ALC8WTZtx/wmic6NT4/9URGFGFfL9YHhLOBxZl6UACc9voskcUo0BM7ELY2i5/ggsx4Fikmu1A/6OueMjUQZ6fpQrXzS/CyyEJ7cHGRaXiaO6LdFIEa5CMAmjjGMK7hZEzuMBMxEDkVj/NSdGX8E3bVwAidoPKpPvqs+X38N976sR4SjnjNRpw+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDvpqFn3ChvBFwc/A6MbKcp3tYedqMcsrWfQg0NaJec=;
 b=WwZ0cxa1GNMEtLDWQCzOIffehH7jTVjJ1H4gEaKAqxP9uoJgYbt9S7q/mCBS3dWGBw8jrlO1REokgJMgdq7wwxFJeeo6pT76fotlAoQuP/HTrFPmsnx19My+wWJcBWM/L9dj41QiGHJxSTQGl+XHiVEv44UHTWAQrwBwLgrmTCNOIQ6150RfmyA03AWOixY8fiGivXkHV/tRjApL6TtTziGCrpXeLM+6QlhBxd/+UFuDqJDcwN0O6/FVBTEZjqKz49zpTmj7xdVraVBOtylnBHpcWSxM7d51OpfvV9IYeAqZjn3Akgf2ifl1W6ecE3yufNUo1M3sgR7EbbtCn8urcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDvpqFn3ChvBFwc/A6MbKcp3tYedqMcsrWfQg0NaJec=;
 b=JzBmwkp97/prBYS15SregmATNzZYA5tnFh+ZkQwws/RAJTqQkRJJPTWi1vDtH893kVbbjDuuj7Psn0ERmlTtIMZm19av+yCirH+qUy+JOp4jeqpQyYYDoP9RSxMtzHTWurLV/Mwye2ulUTSxM6dK6Y2exXg5xCvl7WZP92zst08=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4910.namprd10.prod.outlook.com (2603:10b6:5:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.37; Fri, 21 Oct
 2022 23:53:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5f85:c22e:b7fa:21bd%5]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 23:53:57 +0000
Date:   Fri, 21 Oct 2022 16:53:54 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, stable@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm,madvise,hugetlb: fix unexpected data loss with
 MADV_DONTNEED on hugetlbfs
Message-ID: <Y1MxEk5ewlJeaW28@monkey>
References: <20221021192805.366ad573@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021192805.366ad573@imladris.surriel.com>
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed0e519-491c-4470-5547-08dab3bf84f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrAiQyx+CPcbLgqKssIkGGz4PYNinr/JnKV57aO+4Fn/rVZxBcU+js31e/nTYkzBBqFmzPriXmne1KXCmtI+qtjkQxNVn2mh4s5maHRFBDP9SrwjOol/ESt+aquwnENlyHkFsOgi13rvfbKgvpHaF1jlCS5vM3hg4x4jBwGmi9S4MDJ/V0FTL2o84zxvK6y1Z4ksnSIVHP8dwe4Z9tb2QKn2fAhf1RIV34sTVyJGQwD1KhMqclDkUI5lOKEvB6TegxrWnssC23KezD4XaNnoBljdIjsxCTuTdiMPxvXrfSXRnoriEv9Lzmcw5jC6+CLcpiCvXC2RAmYXWhTZTegLNvPmsDtjNNhdpMlt7NThm/r+QeV7tx2RAm53DOyejYXGvImme7Ff4OcB0P+IOTdlz8sKpGRqKjQDXwjkQZ/fFqqGVgSw0ojIn4qd83tZzi4hPJurUwC3cwikhKdDMydno1QO6oGHptiwe0Jw4rh1hwZGVdPyO9p/5g5ekbnJLwBtikcv7w+xkdJl2NamREzCVgQiLwOXxqoLTt/iZnjKcWOXPJvtAQ1l9qJNDbksXosjAhJ/4Z4xBEIwszFbosuYvpsvGL0ux5BFZ+jhySitEXJxN7UZyM/tc3tkrDPaKmCTe9RoUvjkOPfs6pB3+5IxKQmwoGS5kRYjzFQU0TvrpgLbxz/ApFhiL646aoasm9u4ghruA4yq4xdKvv4Cj2zHAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(86362001)(38100700002)(2906002)(8936002)(5660300002)(44832011)(6512007)(6506007)(6666004)(186003)(53546011)(83380400001)(9686003)(26005)(4326008)(54906003)(6916009)(66946007)(478600001)(8676002)(33716001)(66556008)(66476007)(41300700001)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1yWxB7Wd2Q79OmsCuMbBuz1nYWggdzUi1DXL04g3mEFDLHIaa4jeVqSn1jpk?=
 =?us-ascii?Q?wRHSvepn461BesvfO35XjYqtDNznXHVjqh8le44uo0FZ2gbjNbwKymR/b0PS?=
 =?us-ascii?Q?6pPW7IXsL4Jsih6DZOzfQ6eVpIAh6jUNfy4qdrrujbcV9hk3dloklkD/mfaz?=
 =?us-ascii?Q?nqqKMFK4eNTRogqMA5Xx5OLs0rSYEpSn1MrszdaAM+9NpwUTQfr2GAjxJtms?=
 =?us-ascii?Q?HhxtDcDceymwFYF3Xo9DM9rbRFia9emm+Hfvlhd9yV8n4LHrptsM2wzweuw7?=
 =?us-ascii?Q?nl42HlQv0Tquo6U9XjanOwX/PDGYZkFyThF8MZU5L++JfMJhFilkCjKJljN3?=
 =?us-ascii?Q?ReD95swFUsqi4WvwsoViLzasDxaCzkPr/KwJwWAuy+lq1drwQ4S4xF2dBuV0?=
 =?us-ascii?Q?DTsJt89qzBuABdQ0gOBL1bBSgcddPnYKVuHuGiNZZLVP+UnoYyqXUzh2KOCs?=
 =?us-ascii?Q?nGfvKEkNLxf4XCidNMhX6DVQjQVxuCktnBV2jKXAAJjAPX5xzjqKMWrYHLyC?=
 =?us-ascii?Q?mk9Gs4frxpW76uZoZpLU1dfg6HUf3xHdzsEo1RhSIfd3GAlKCjtD7Ufz1M8e?=
 =?us-ascii?Q?ltqAyG785LYt32cQUN0iO6DVWBO0Ih3vxdyqP0Y3RPqund9PZyhORPK8M4BT?=
 =?us-ascii?Q?KCBTNDWdNFKdl6eZhaTcZVes4YaFELdYKcjuTNMKckmgW51l9o57i7xAeL76?=
 =?us-ascii?Q?75RdowxfZArSJW8NY1ezqy8+jqZKWNyNz2x4i4BC39rDW4pGxNgwNMzi+9TI?=
 =?us-ascii?Q?eiyujLK6SjGFWYD7I7MN6ntKJoFCUkT1/vUyZlygMwzdt14RKwfj8x6n+fLL?=
 =?us-ascii?Q?D9LX/yjEl+yqaydpNGNmrgkPPxzge3hyxAh4y6R71LWHWA9rFmUHz0sfLrNL?=
 =?us-ascii?Q?C/jWbdiPHYdUOpJ/DbrWbJ8k9GYigyU6M28sk/j7KXBgAYGRLGqC8Wn3UX0m?=
 =?us-ascii?Q?C4DdiS/J5MmguEHktXeCVmp97u1+ODKWmnCpF18Rt0PxNkqFVAJSK5aL0p6s?=
 =?us-ascii?Q?EPqqGboZDuk5pxYNrPIdfWmUDYWUAbmo9mZfVMrOz7se2+7cv+L7wFnFowk6?=
 =?us-ascii?Q?GYsf+jn0HTtU9cLXVakRsoTXHWh8tqE+TdIZY1hsjCkHWyOj+FEz+8khNgfU?=
 =?us-ascii?Q?5P7HuEXM22vcTqJhLf3bExDoRa5ro5UACGrIC34mh1JPTHrrj4m49r+jsPdL?=
 =?us-ascii?Q?KBOaG3RGVHke35obAIfJx0gd28wGurl/RwwCTYaXRpRdaMnDSoVTg12OSW70?=
 =?us-ascii?Q?xKcrAq9fr/3v4oS0qY65AMhecCag5iVYt3i2XDjbPibCP42/V6TXU0NjLDWP?=
 =?us-ascii?Q?LEzaprSiBw//Q0wCame4gzppZ8+DMC4kJUNdLgPv0WF3TnZEB3BWu8OL30EZ?=
 =?us-ascii?Q?f7JnaQOGnjHVpt3Q18H74UEiJzbBUS/WfeKoFmTOwiCCCf90Mjb2Us0f71oJ?=
 =?us-ascii?Q?S9KUgpEP1ae2eYdoAR+hTd+6CPjSX18SvIlgR5cjrBTBUy5bmibcJo08d1mC?=
 =?us-ascii?Q?MhqKUxqh+4DEbmM7R3p47NS1gm3Hwd4TKZCVnjeJLdW8hk9wiGpKb0J59GFy?=
 =?us-ascii?Q?nygE1uOcxS2ZHoeATOEz2rW7nkq6sC+lG2eORnWNoYpUe7bPvuSzMx0rI2BE?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed0e519-491c-4470-5547-08dab3bf84f7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:53:57.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQIcpjO9WiuWLGAnjycFF8gMn1jUC2mG+RV9rsuTyVMnR2nskQN7b3JCm1VMMo+WyE4wyyvwUUqp1AxPdKkplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210139
X-Proofpoint-GUID: AIHC1_TjRPP5O2QjMAAft7WPhoywC4Se
X-Proofpoint-ORIG-GUID: AIHC1_TjRPP5O2QjMAAft7WPhoywC4Se
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 19:28, Rik van Riel wrote:
> A common use case for hugetlbfs is for the application to create
> memory pools backed by huge pages, which then get handed over to
> some malloc library (eg. jemalloc) for further management.
> 
> That malloc library may be doing MADV_DONTNEED calls on memory
> that is no longer needed, expecting those calls to happen on
> PAGE_SIZE boundaries.
> 
> However, currently the MADV_DONTNEED code rounds up any such
> requests to HPAGE_PMD_SIZE boundaries. This leads to undesired
> outcomes when jemalloc expects a 4kB MADV_DONTNEED, but 2MB of
> memory get zeroed out, instead.
> 
> Use of pre-built shared libraries means that user code does not
> always know the page size of every memory arena in use.
> 
> Avoid unexpected data loss with MADV_DONTNEED by rounding up
> only to PAGE_SIZE (in do_madvise), and rounding down to huge
> page granularity.
> 
> That way programs will only get as much memory zeroed out as
> they requested.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@kernel.org
> Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")

I do hate changing behavior, but in hindsight this is the right behavior.
Especially, since it can cause unexpected data loss.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
> v2: split out the most urgent fix for stable backports
> 
>  mm/madvise.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2baa93ca2310..c7105ec6d08c 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -813,7 +813,14 @@ static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
>  	if (start & ~huge_page_mask(hstate_vma(vma)))
>  		return false;
>  
> -	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
> +	/*
> +	 * Madvise callers expect the length to be rounded up to PAGE_SIZE
> +	 * boundaries, and may be unaware that this VMA uses huge pages.
> +	 * Avoid unexpected data loss by rounding down the number of
> +	 * huge pages freed.
> +	 */
> +	*end = ALIGN_DOWN(*end, huge_page_size(hstate_vma(vma)));
> +
>  	return true;
>  }
>  
> @@ -828,6 +835,9 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>  	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
>  		return -EINVAL;
>  
> +	if (start == end)
> +		return 0;
> +
>  	if (!userfaultfd_remove(vma, start, end)) {
>  		*prev = NULL; /* mmap_lock has been dropped, prev is stale */
>  
> -- 
> 2.37.2
> 
> 
