Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315C664D23F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLNWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLNWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:18:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C43D388
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:18:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BELwwcV023822;
        Wed, 14 Dec 2022 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jZhjVG6gfMYsAZwJZXu9wyhXcGT+CO8v3hE1QUhVpNU=;
 b=IaB8dJNbjn7Eg8SKj5xwZmdTkb7jZUPcqpmxK0Bgu/XaTOGeWNZvv0G2xjn0bVSxPdsn
 jYd53O7lihKKDSPOu8Lj7vLRmO+NSQtEt13AeTVOOBsSRirhlglHyQtwrgAQjSXA6YKc
 LJYdQ2BUxBeprvXoIjBpoYBkOULKWMM1Thl/Gcp6CZRSpZJQNNaA82QDMj5utkWLQHWh
 190l0w5X3KxlqhWySMFjUvhGwKwX4aGHkmvAQPZm+lDETR4ux49WIvwtj3mDaQox9rwU
 wJP4J2WTQPPP5dswfFXS35HaTAu5zmP1yaHf+5HtApU6cEwY5AHjCQm7wUjtgcZge6sa Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeruhvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 22:17:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEKvprE031114;
        Wed, 14 Dec 2022 22:17:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyepqmbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 22:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2JnL286kOFEdi5YOb5Jc45oBlE8TrhNjLteNRFR5VULRxawuFLIZabic8eTB8A1PsiaDsbHHf8mDGoi90Tp5x7YIjJJQ03FW7bqb1yAQCa1Zs8fqs/DhjASg6RPgXhSGkSgi3HkdR1cHYrz3jxJPvw/KjSRg3pvQKaGuI7nL0vvg0RVRTHj+gcAoJdUyO/2CVtEfQRcOgYSAGlTJN9Ag2lgDKirIPuIUwRrKgdSTIkHtWH/CG8oHRLICRL4IPx26w0WXTeTBKENoOnqiNaz/nmsysMf/TZ0D3nz/3z4Xp5trHP2j0ar8Aa9elpBqyJASGMfs9OUPYI8aprKsamKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZhjVG6gfMYsAZwJZXu9wyhXcGT+CO8v3hE1QUhVpNU=;
 b=D6MvfjQxwr7/t5Uoe5prLKL+RbkU7GQFvM+0mLGIuv9Kwn76ZxqDmm0nz3qskLnOHgIMa+QQG4Fzs6mLtqvTQ3OToD0nQSSM8o0isM+Yhr0ZFEgmgnwIkpYE4E8KkRJbaqfh3+AymKAChouxEQtWk3PoToHQedt7vyzEetaXMMo7Q9aEEXBG84uXhR2h7FKUU7ZA+UIEgm2VWMVrsOvKiKwwwbbfC0aXCXWAJW4SC4w/s2awmsff+aXylzIU+Q685S5LAjjBMkEuSWoTVb77GCwP9RtQ79bGcxjrFjX5hG9BJ9ujqcuc8a7q+1SkOYN0MrFH2GHnyK1u2sQpnELWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZhjVG6gfMYsAZwJZXu9wyhXcGT+CO8v3hE1QUhVpNU=;
 b=xytlLhEZYWpFj00XGWiYgY23llrQEOw27pYHC0xQJxD4hZclp+iDB3sEgetZLEvZ+zQ6FssW54UKvxWq/pC5aEG1f/j+cMid9UFBhGL/tAjMDFacd3c46IHZEFL0GSeeQ3NTUGBxhTwy/7GqgCDXYA/AgmMtfkdRTU0EEEF6V5E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6237.namprd10.prod.outlook.com (2603:10b6:930:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:17:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%5]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 22:17:26 +0000
Date:   Wed, 14 Dec 2022 14:17:22 -0800
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
Subject: Re: [RFC PATCH v2 14/47] hugetlb: make default arch_make_huge_pte
 understand small mappings
Message-ID: <Y5pLcoxp2qVZtOq9@monkey>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-15-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-15-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: e3338295-c2a6-44bf-5510-08dade20fb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ubYYBX6zBeKUxeR6fx11JMXBfei0WXHHchFm36GNb8HmKku2Y7/F0F7EBetbAu1Wxh1kJHkqwg6LNme0mkg8+GzZ10ecVyqnBuZtfD04MisPhhJKI03HnN1TgNzTqUExFxsHPK5BmKsaj+jr1OOdbwI2vN99PZn3IjUI9VheZx321w1BNHGa8ClbuldtY8Kg8ll0+goCF4B5I1Q0lbbtP7Cql7L72MDCamRqvRidq8VwUTdY2aNDXW51SZ9q9cY7jnk15rdMtG48svXdWoEYlZ4RP61qe1r30FOgXSRHySKoLJF53B7eYQH5B77uaY8khjOBOi584Ua40yy3f2OcZxkDurcjOeHE2NPK7Ojtf5RviQGl/+BrPPDsnd5KTOvM4/WRibvPy/bIJOk4lPpH8LqwMu7oDpRtD4IHbHWy1YF25rgSl+26DBqvt/fAtkGalLrE7QdxXxieRf174PYA2aaFt+aEWeK8287oVvJ0Gh8aq6LH2ohsbUMSmIBMg1Yk4GgMgIUI0NM+MuzkTI/JW7Ahh0mOiKKSwtTw94J7fVsk00+Ubk8sz+1Kaol4SWVyX/+3NiRq9szkPFMrgvXqvfIf+PsepK3bHiDekpHmzTbFx5RA2qqv/llyG4AOUuSsMdAMV1KevYoGSH+LaEO9MgnSEViZ7My2cegL9iF7P4CJ2ECSg7vu/WJ36kBhHYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199015)(478600001)(6486002)(6666004)(86362001)(41300700001)(2906002)(38100700002)(5660300002)(44832011)(7416002)(6506007)(186003)(53546011)(316002)(83380400001)(66476007)(66556008)(66946007)(6916009)(4326008)(54906003)(6512007)(26005)(9686003)(8936002)(8676002)(33716001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87e55OvQOC7M5Wn4YPQiH1agroi8bdXaaVTqXF+fdO+LCQ8IJZE0ny8FFxkd?=
 =?us-ascii?Q?TyhMBfOVWeFXYw5bRCWd1Nckj530/gT3ZnehVt/NwlybAMbRuiVElF/acK77?=
 =?us-ascii?Q?UuIqH/QuubcOWd1W1s6hEfWXVMZdWesYVFa/93LEJJEYW3icY5LSVZy//Q5c?=
 =?us-ascii?Q?g9dqfiJwgTLapuMpaiP9apd0aBsfIh8ssptJ2XQT5EkL1DG4s9vd7erTpTP+?=
 =?us-ascii?Q?+oXU1H+4UVmjDTkOq7BQUWfrwukdXpWkvOKL7ErBpvsT6c/kXng7Gc61WZID?=
 =?us-ascii?Q?phfPGuP0iZ8Zn6co+HWvulVmR55c1cPI1GfqvB+1DwF/6paYNeUTHC+eYo4/?=
 =?us-ascii?Q?spXsMvhR/Pxr/P9ZbrZmJTq1oSu2fJstQWmKXFDUAvmU9fvdiqDTLkxYQ3yu?=
 =?us-ascii?Q?yBUsqkKdwLMVdFy0rS/sx9MBFHQ0onX/091f63Xf8AAgUWyTrVQiys4GZVXr?=
 =?us-ascii?Q?GLWII15ud4gX+EPBPEKaoKTImpLpE/nQiMcvepbS5dIBs6c6CHAxcv9AZY/l?=
 =?us-ascii?Q?PWYIV0D/FyvTYTLvr9wVExQzhjyNLYzHmzGYJzer9cORh1SI9rq2yNBrov3m?=
 =?us-ascii?Q?rookle5ZFeJBesOt6vlGsLSb6FtWmpNavrIUZF+QFaNDivqfcM8lhpVFs4rb?=
 =?us-ascii?Q?XoqJt80IdDhq5wYsV8Q+3qJ3uMcuLNeP1cG8sh1US8ej6lXASkES7wWjOoiF?=
 =?us-ascii?Q?PQx12hyCIVUKgW+bjTdlvBVkKhzvudtutBZ5wJMDVVIPCZxIWs/w0p322ykf?=
 =?us-ascii?Q?CyxrbCIp+OlAFUSrwyXQmeGfEvT6dewjEHNaODcLoCGwtw1NGIrkpUNWj/d7?=
 =?us-ascii?Q?lVVVY1/hn2fyjTQ+C4vOOcR4o37/VA11PzUAvTgyZBHsJAKqbbJLJuHN4MeV?=
 =?us-ascii?Q?YP06TU2nWscFNcFVCxUcBFwVsypXsCHawdNrDk8O+ndJGNha6Jnx/9kLNnUF?=
 =?us-ascii?Q?GcUiXA2ZGgQVaVOYTO+immz509mkDcTgMuIeHfaUYfDJtJ6DcNW0juSEhqk+?=
 =?us-ascii?Q?BrSODzexbnz1eS68FlPT/SrCJO48FfvnCxIKwkD2GW+mQJSSaeU79URvO5DS?=
 =?us-ascii?Q?+OnKDvdqI2oq8Zwpndad8WTwQh3L68ZM+vHoG7+xbIe0PJ7N49TcDPvIMwDH?=
 =?us-ascii?Q?vvgb01wPmHwioTq/N0cbyg01LZ/vfCkPd3Sl0TPOPhLfvNy8sEgzbaY1bFMU?=
 =?us-ascii?Q?adeBJWEuEhwgWw3wcDNXPd0YV/QEvU5GYebtyZp8grtNRaJZv8hICfe7pMxS?=
 =?us-ascii?Q?o8U7cVinLTgwJEHD2+p2cL3IhVApoYSjBzik+E12j417EuZr4+wKJdWjKjn4?=
 =?us-ascii?Q?95A2lbgLBsfWUddyYm6R/tm4U8VeSYEiNm6hbcX68mXpnCkQxf/0AQXKm7Lo?=
 =?us-ascii?Q?5VRsTpctYlHOd6lNT8H0B43vilrSGmegjeRbvvJy7WUzRRI3W7YdJ0K6XeAO?=
 =?us-ascii?Q?MOAF5m/p20eUONYqYQS9CKUupSqgK8jF/MtXKMOlAwjrnJT2S/3ExqC9lMKl?=
 =?us-ascii?Q?PlRvLV4xxybjNbN0+d3Zua1gbGCPrZO6YRNOMvTUnR2SL9QwaBt7P2a3H5uw?=
 =?us-ascii?Q?fDSHFNwoD/Ad8+si3bV0PSFXVlY0NvPxX7My/iZxRn29me9F4ZDzOdH/JJv0?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3338295-c2a6-44bf-5510-08dade20fb49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:26.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL9uqebJT0m6XJTrkraqmd1lTLz23VcQuzFYKxosR0bdraX8JbXjF9Zw2O+Q2wzdlfnkzw7mvpCyunRmMhwqhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_11,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=783 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140182
X-Proofpoint-ORIG-GUID: Kd97RpbF0XmSwCxDYN_JV-MbalQpFn6D
X-Proofpoint-GUID: Kd97RpbF0XmSwCxDYN_JV-MbalQpFn6D
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
> This is a simple change: don't create a "huge" PTE if we are making a
> regular, PAGE_SIZE PTE. All architectures that want to implement HGM
> likely need to be changed in a similar way if they implement their own
> version of arch_make_huge_pte.

Nothing wrong with this patch.

However, I wish there was some way we could flag this requirement in
arch specific code.  Just seems like something that would be easy to
overlook.

-- 
Mike Kravetz

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 4b1548adecde..d305742e9d44 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -907,7 +907,7 @@ static inline void arch_clear_hugepage_flags(struct page *page) { }
>  static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
>  				       vm_flags_t flags)
>  {
> -	return pte_mkhuge(entry);
> +	return shift > PAGE_SHIFT ? pte_mkhuge(entry) : entry;
>  }
>  #endif
>  
> -- 
> 2.38.0.135.g90850a2211-goog
> 
