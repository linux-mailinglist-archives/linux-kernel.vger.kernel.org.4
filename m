Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0D5BD745
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiISW1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiISW1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:27:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9264F65D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:26:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMC057023769;
        Mon, 19 Sep 2022 22:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=w1F0Hkw6JDIfRxT0B1LOLSNCX9BlvF1PMCKL3t0vSJ4=;
 b=oLU3fS5Q/2tzQxx1X1/Lc2gfsvXRxmgd7m7v2w6IEv1oiZVE66JEXfMemcyD1O4HUksi
 rqwgQU9Ga1FF2IdExlgk0E32bBQitVJtP1jHAgQD3o87kNdDvZRwQOmJRxkK/QTmDVBt
 NwuYugIzgVb8BTMweN3yBX5tHVd0XtEZHpEyE3iU8o/kWRz++9xhFuAyqtiZ2BP98vZz
 YsBG0E48XEd0Nkm9gQAKGbsv2IlyuO5l0jB/5iBcpHOR4ilAZlgZFnmRFeY6MmHbnSPj
 2wyCacD6QS2RwWUDYSHabi+1ZtwXxmxsnYhScE1wW6Ay7FGdy9D18J2/2M/Lodms1Tdt Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kn64v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:26:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JKar7k016744;
        Mon, 19 Sep 2022 22:26:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cmkvht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 22:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOyq3evZU0HgHrHJxu04uh2SR5vq0KBJsPk73AqmqJTRMZc5euUz3VhZDxq1QkD5C3DF5cC+gd5TXrM+T9qu1jRWRzBJRNGDCqC+pIxT7ohY+6vSuL0qLNgTgGaFPUMe13Y7psOpu+Wykk8D3dbX+imfvYGb5ZwJZwyj5rsgNImWMnbslAGJtw8BPg1LBVi4Qj3No0+rFvbGl3vbuUJVNA+IIXqpdwZGspnMYaoZzV7h5kuhAWilBfoaXfbCGXz79exY0nAU/UNMmmzWUvFCGJPgVP/x3/2Bg/HJEIPVbtB+0cp/le8SJu+o/OsZV1HfFjdf1x3+RSmVsLukTOEVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1F0Hkw6JDIfRxT0B1LOLSNCX9BlvF1PMCKL3t0vSJ4=;
 b=LlNhuWlJP0y449NNWSim6mnYT8BnULo+8XMtPr8x2g6VZXPoy/LEZ3xJw0cThun5Lh+6uhZaDztMDuQeCIELhDi3u21qY3YVwmRYC6P88fHXL3mGHGj9dX7u2jWjtWEp3/oa7iTSbSNEPNsQmwjhRdTnZJmn1+B97oUDk4MEgxzpCPpgpRzAgJazA73q0rKZFrvF7sEqMBqjpzpy+Il2+8rsvmtO0CQaDg2UstJk0yHYEJ3YXWPllymDvYvJCP6Y7VuApnq8q234dFl/ff7KtPqXvFr20t5/W3lxkMAiuZGkmU4L/bjwYUnh5xomVA1aZnv7zkksRdFmGQKozOTvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1F0Hkw6JDIfRxT0B1LOLSNCX9BlvF1PMCKL3t0vSJ4=;
 b=QGo/yk4xEEdICW7xnXe3aQtrkeQNXhQFMiBcZEXVvkhd+TxpLcxCGcKIDJsGhNlU00GaYGVbJ2o162UedPSVSxGRsvUUvwgP1RYu0bDM7wlbAsihlwUhhzPbDEd+iblVCr9fwDWFW9vE8KlWyMx/3WomVLacyMQhGZh1JaMDQqQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 22:26:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:26:47 +0000
Date:   Mon, 19 Sep 2022 15:26:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH v3 4/6] mm/hugetlb: add hugetlb_set_folio_subpool() helper
Message-ID: <Yyjso0kmBD0U4RMv@monkey>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
 <20220908193706.1716548-5-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908193706.1716548-5-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: a911e0c3-c74a-4646-30eb-08da9a8e09e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nG7Y+CFI/77B8f/cFCow9+F58b5rWBSIN7AzS4TYYOTzmJ5WDUd5aOG7al+RSUzkMumdSs7xaktSBTTlwI+CNeaw0UNp3Rj+gWMssGQR//mfZkZnqcv9yqBhgE04/aq8JwZrjaKLBLWPfTKFKdZp/YimF/f3mVIWbR32J7J7lkOfqyJ09mRTQSALI7atb+VtuQZNDV95qpXGTmLPbYTTqwDgH7JSKbFAGwNr934BQw/7lIQBZrSlgmVjfCJXFInEJ+tL/CzdowNlFDTsBvoV2Lo4m6dzpVOhGzd2oSvXypma9r7l9B4+GrZWAR72f9RA8iyDXEUe+NVpYGOCTWxRrtZdJNG32bzsvBKdNdpziII/7KjbgeGTq9cxdlcQh/8VoerGRNA8H2PZZeqNDk73Wn54pYaY5+omMKZRKopiH/NBeooBaplXyqCaqDHON37jCTBbUreR1EPFQJOOACYpYMMa1kpOUsTwB+hqhBcAfWr5fMgxYtyeGrPvkhzjL9SsmsnVWoGBoLcL4sF1w1ut6CuJ7hzj2hTsUUTjF6IDCFrZFLYEg2gugknMJFWi4HhCudinQq2+BBdgFZRy+G+ay1374lZgRzRnmvi9kHUikkCypKgDKvNecGKJvwdCfS3vXzCA8Ri4FSX+YaoypxtbOB4Kfzb/umaGewYvE7SjKoCZ3XqfJX2O+MmcTmfdx6+4C7IaAm4DkY5Li8MHmWHYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(4326008)(6486002)(8676002)(66946007)(66476007)(66556008)(83380400001)(316002)(7416002)(33716001)(44832011)(2906002)(86362001)(6862004)(8936002)(6636002)(5660300002)(478600001)(9686003)(26005)(6506007)(53546011)(38100700002)(6512007)(41300700001)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Of6e7HKT/xchKMTRU1yKB9cfmXZVNJDWjDZWc09xhAwCnpAt9rzhhontCYoC?=
 =?us-ascii?Q?EoJ102mzdbGBKRqSLPXC5uB4gGjC2UA3MGRI4kJGKF7tZ0QMNTDKHRECV7oY?=
 =?us-ascii?Q?nnnjKEFPNKVSPz7L8PaDHMdcWHvRisGmxnCA8k2EYgHMC6I2aetgbAmKrvmq?=
 =?us-ascii?Q?1sFtnn9USyHtqWbktD84Eri6RvvR0Hs0VmqS5v4Ih5pSZH1U0UZLZzfg7+Xw?=
 =?us-ascii?Q?+87v68yCWxDZScMjMiMP7QB3MqcmPj+JPKtEMSZBJrmlYCU5F2uO6fhtvkS4?=
 =?us-ascii?Q?ED7YkYUnCcbd83I9zmokeZx0ROgM3ounHEJ42zscal/A7y21BNjwLx28Lq9i?=
 =?us-ascii?Q?mZDFvsgxvD1+s3OVD3EQ8wc5YsajxDJLaj6EtdWeZlJb6D5n90j942+fRFet?=
 =?us-ascii?Q?QshPuv48IyIbuIlwRVos2hRx7POVnHgPEWKwpdz0ZFWDkVpspJhebQqePBut?=
 =?us-ascii?Q?xvnuJmMC8NSZVvq5p2Bhph96Bad5t2ggD9p3jlaceJqhuT9HH1eV+9NRPX/V?=
 =?us-ascii?Q?+VOYLjnml8Zm6RI56WeEn3CHVFftMcx3kWI7p/qTFoaE8+bpnU2D5tTQek1x?=
 =?us-ascii?Q?b4gm99zMuCST2MAj3kfUVMedUjHvha4mhb2SgmVguXWm+CHs1fugO6/fg1om?=
 =?us-ascii?Q?TBHEEHKGcWi3PQlDg2AO4JqoiKwlLD7m5uos1qhhlOX73IiJWRCbUTYrFBI/?=
 =?us-ascii?Q?rw3xz/cc21deRMcdqJRLl4s+ZD2kv6pCAv/YZixNVxV1OwTgcSKx3TEdOzWi?=
 =?us-ascii?Q?pRcv1ssZIgAEMAg1MlTWfTEb4x1DLwy67o8wHWMixTXw8P3nHo1mguz+P+r0?=
 =?us-ascii?Q?DIm2KUpl2QpMQT+TcYUOmI62Dkvzj6PN1TJBeDmMJGl0BYkMPpZ8g4G/1ETq?=
 =?us-ascii?Q?Gy9cIDQomK/92iY0EMCg9Vgnjh8DLoDbDAqQnfhfwV7x8s6nWvNqSx6tGqDN?=
 =?us-ascii?Q?vjwn5OEWz1CU3aCUdA8xZkuqrLuQhikUn9SgeJJy3YKAP2UELW4eYeFj8Tbm?=
 =?us-ascii?Q?CVpGkcNH70rriqgCHy8toKHOEHS4p01KmtkIqskvwyp29Kzj9ujB7ahBLs+X?=
 =?us-ascii?Q?/ilFiDaDH/huqYKHTugDCsRkDpQoYGXCqcM1UsgDNL2vyNgb5b6t/g48dzYz?=
 =?us-ascii?Q?cAn0mpPtcP9Rxd+y3AmkLdT69jK6JsHE4yBUGaV2yX9fbq3RIkgsGPhcTOFH?=
 =?us-ascii?Q?Qo3t1s1WwN4+ihCU1IMfuDnkMv6ng1GT7TKf8sa45fwst+9YRZFuCVLPaRKV?=
 =?us-ascii?Q?q9LUeUikUzrhjMWJ12FDS09N59hZYuZO4F1XGtvOzttwbaZJ2SPUyeRchXu7?=
 =?us-ascii?Q?fYp1QKQwAAPb5K4WmNEp5RBzyPhlbWOaZXxC4jFsBeQBknxoKAD4aHTFtlIz?=
 =?us-ascii?Q?yEjdzr2gAFRx8rSILeEk9M2lr7HJgeZpmNfQKkpFZkuFIGTQmwpenKyqKT7g?=
 =?us-ascii?Q?Tl14p4pdk/gHedF+xXoci/Uu5u65rTZ6mneW9ONgMw2/AKN2Tix/UP6nKvgk?=
 =?us-ascii?Q?eYa+00Ht553Eh1dSio1375xDi85Xt6w6zD5B2oeQAnAR23UcyIuHNIXCIR55?=
 =?us-ascii?Q?GIAbuxx1SRXy/Wh3VaUXxAo57m44X0DOFfy4SclQd8BWcwgKp5zgnlacZzPC?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a911e0c3-c74a-4646-30eb-08da9a8e09e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:26:46.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGzgvwLLGCKLO8jntBN0IXL2Jnc+VH8GoL+VadrBHyQyjzUOEmKN/LMI5hCSSvS7gRS6E3skGliPzpK2XnnA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190149
X-Proofpoint-ORIG-GUID: njhYKZ5Jp863zqYo2vhN-eJlhhbSHroq
X-Proofpoint-GUID: njhYKZ5Jp863zqYo2vhN-eJlhhbSHroq
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
> Allows hugetlb subpool information to be set through a folio.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 4 ++--
>  include/linux/hugetlb.h | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)

As previously mentioned, I would suggest just combining this with the
previous patch.  Changes look fine.
-- 
Mike Kravetz

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index c2e9c0cdbd81..d9e08c445e2f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1152,9 +1152,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>  		return rc;
>  
>  	if (hugetlb_folio_subpool(src)) {
> -		hugetlb_set_page_subpool(&dst->page,
> +		hugetlb_set_folio_subpool(dst,
>  					hugetlb_folio_subpool(src));
> -		hugetlb_set_page_subpool(&src->page, NULL);
> +		hugetlb_set_folio_subpool(src, NULL);
>  	}
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1e7c4007386e..0bcaca694ab7 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -757,10 +757,16 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
>  	return hugetlb_folio_subpool(page_folio(hpage));
>  }
>  
> +static inline void hugetlb_set_folio_subpool(struct folio *folio,
> +					struct hugepage_subpool *subpool)
> +{
> +	folio_set_private_1(folio, (unsigned long)subpool);
> +}
> +
>  static inline void hugetlb_set_page_subpool(struct page *hpage,
>  					struct hugepage_subpool *subpool)
>  {
> -	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
> +	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
>  }
>  
>  static inline struct hstate *hstate_file(struct file *f)
> -- 
> 2.31.1
> 
