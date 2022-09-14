Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68CD5B8E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiINRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiINRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:23:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D343857563;
        Wed, 14 Sep 2022 10:23:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG2DKl019638;
        Wed, 14 Sep 2022 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=h+PaQEvKJ4r0tbbFxslr+sDg1uwEY75IzzGHepYM1wM=;
 b=mbBmgzFtoW00DkdfRrmMcY6RxIq2/ZSrHT3Nxg577RxspMcsaw3AxtHd5BQ/BMHK3/Ng
 0Jjf09met41awPv1Vu4d+k4LI+6nlWMhtyIgRCZOC12hoB/HR7ovGVhxWkBMIGShuHrl
 MhGpc+1RsZU20dlAdRNEjiy64IzbaqOyJ2G7g/baA3tHBOLW0KgRlxL0gaPQ1TwYXv1/
 J0K88Py9P/uWH+6K739A/1hTYTE/yajrACEbRoDtHiZibVU42Xa09ey8yGAGcaHn++Bh
 C9duYostiywX6LFXKhGEZibP60NEop/7Vz4giHJt2JlBQM68eMVbq2e955PDQkROgmn8 hQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf2x5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 17:23:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG28F6035491;
        Wed, 14 Sep 2022 17:23:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyehf3rf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 17:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEjrbvX6WoQr1E3kDLXSU27v2ykRp2jGyUUgiG6we+5b9lJaN2ZNoT0Ch0136q7WxGI6rH2wERX1PJvl08fTlihxYafMABuWWrnEGzqnJl1eOI2FmEevaM5Cg3gNQG14n1Em9vX2PKXLTurfQxGhhbk5N5H9l6ULyNmRjwhrmnJCwXDzBhoFrH48Zc5hOkvPuA+97LMW4lsgWTvV0Q/6Nc/cNNZ70H26+pbmoTQyl2RNk507H/R/vVmf/K4JTzvQt9i4oEDaEgRsTbqYu5RdO2WrseGdZUsMHARAPCscCAIH8uZnXE6GX9jRzcmKMQg3P6N7/kDaiaawbX3yH/ZP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+PaQEvKJ4r0tbbFxslr+sDg1uwEY75IzzGHepYM1wM=;
 b=cuY+yKNzJ4nF6qt42QjQr8R2TagTWa7Frr4w/JFrB33JQ0Eqcj9dSmn/TIqCULBK5i6x9kd/X4Zy2C9X8uWeOMvRGeJRM8LgosSyJ6FphhnS/ht+LSRHDPMY5qYaXg29Pej3wXHFGC59MK4Fh6eiUbY+4+uktrnG3SADNU7Xxs1o904rphK7/gdBBSImKbTWzBunIWtFTM0Jnujx+kkbNs2rHbGZ2FfI+EKhEWKBbV6pTQp1OPtS4UhA68WC8L8C73kQOsNfxiX7/67Z/HyoxC8Hg/+1x3DqpzcHF0z+DELk1zUrIb5Tm72MqLzjxMYr54vmOcfhQ517ISfnHbgveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+PaQEvKJ4r0tbbFxslr+sDg1uwEY75IzzGHepYM1wM=;
 b=tv8dXoGHmJOEuMDIvo4nlU2mU4IQbcucOkuhn+2wVaTkpIJgupiyJtpZ7v08OtG0iazV7jFwy9oQ5GcE96E4AgvKGadr5non2VpIWOv+QxqQlh6cUgAS+zOmAGZuA4r+9hj5NpzQnxQXt0BzmIGiHdMKwv/4en/LlWgYv/3bO/g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 17:23:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:23:09 +0000
Date:   Wed, 14 Sep 2022 10:23:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on
 demote
Message-ID: <YyIN+bpKdCb3JuuY@monkey>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-3-opendmb@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913195508.3511038-3-opendmb@gmail.com>
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d828d97-a7f8-44c4-4780-08da9675cb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 001A9UoCE4rZbhRv+OosaTYqInoyW/02ys7QDy/8c6ph/GzLfPFFwOtqA5fARcYuArcShQGSbmcCRhaq4PpjWzJSlJgPgLX4XMR1fy9KEM/hyh6fTRXfzS1rAtUkBFH2KYzqlhctoMEHmk9rp+9RTnUhsGyPuQKFJQ5S+TuXUURBuZ54C1b27N9ONE24J8xgEYWk+d88Y3/fdWmDAFapp3vmQkR5I/INuoTKIIZWBZrnMb1/e42h28JJiJSIdGOmx4X3Jz5e2tzZsaZpmDK2KbnmWeNGgcqE4ad3cxd9n88lb3hlU/eByWSheJfFzN377Fs2RKScaCxHE7bUrhf8meUD2enh9kycUjZxznqPLlgB4UOeelv14b0M3acmF4nv6Y5RhxdCTG4CA0v3WUvEgL5csRxpWyC28jnlI4eq7kGUmta3+ubIVxDdliGC0DoQ9KhXymyj2qvdJHi8jxTtDpX7DUO+M/dHSbOH6mUSWKOGtXlxKyDPcXNpF1didGlX3dJbSXU7Y5yti0HSm1xd6fGmnycKIUehIUCNd3k6ZBMZyoPQ3P4rgYTkkTzPtB4XGAf1ULBeoPJPv0X+ahU38ePcoldUIwOZllnQnX3fAd3lXs54etOETVkHPEmgnTxoVFxyaORUjm1Gbq7tf4BNCC4ujYeOk2nd9g5G8LZfW0s8Gyz1TJYpTo2IAR/Ts9Anjf/2iOWPJvfQM2k4tlu3PGJQC4HCv9qnmm1okjAlqaTr6IlWxNKySqZSiGKlWzk59whwHUM9cPcJo4cHLpkxqOcZ+gRs8Pm3QSWmvON9+fjpWdiiN6EvaY+TYA5qkGIG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(66476007)(478600001)(41300700001)(6916009)(316002)(5660300002)(54906003)(33716001)(26005)(6512007)(53546011)(6506007)(966005)(6486002)(66556008)(9686003)(8676002)(44832011)(8936002)(7406005)(7416002)(86362001)(83380400001)(66946007)(4326008)(38100700002)(186003)(6666004)(2906002)(14583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jWxZzc/w8ssMdHiYmT1waRhQaJKPHMgn61ESc8oM1iZefpbvNUxyfeT/u6cH?=
 =?us-ascii?Q?XONhigA1KFOM2nWAG8WiEc0dezsRmfVyBJpXxe70Po7+Aaz+9xR+ZXkUM+i5?=
 =?us-ascii?Q?UkHdHYA52yzxW5Sbrd6xgNr93F+9rqnLH8lkuOy1Y4mLyVerlKdcVFqv+veo?=
 =?us-ascii?Q?j8ScNNquwLVk3ezORLg6ztVZI+syTLfKP1jfg41jzX2f/BUfdKd+sFWJUj/W?=
 =?us-ascii?Q?BaWkt/fSWv9bE5gpfT16V9bzM/0gXXRxjPIz2yQcLU0R2+hlDQWUgbGs9erI?=
 =?us-ascii?Q?ZhQxO2GGR1GvpjKPueY0uL24hHyWyv0NoBfNFQUy1WilDOZvuK3EfxbHyFNr?=
 =?us-ascii?Q?w9+2Kh0CeZExwuhmGCQEebg3m/Cer2UXcpUIw6XD+giKtsB+DnZf/IiODaGL?=
 =?us-ascii?Q?VavV90fLmOi8pv5zGU378snBjkUzPFqsEPYPYdN2BuAneLZ2CcbJD3y0WsM5?=
 =?us-ascii?Q?qXxGJswssEb1Zq+AH/APSbfUooxIptocWuWF1WGcrdJCIRPWyhtpiX5rPGFv?=
 =?us-ascii?Q?P6CJ3YsU/WtFj6t7gGrLNa7Wdf8QUk452EIgt2k4HsTNuVeHKiLYi4frLK+x?=
 =?us-ascii?Q?AxUQhb9J4uwB3V8ZJzs34KtQ23YTwh5p5zgrFAX1MBUB7cvw1wRKyIg2mv/i?=
 =?us-ascii?Q?XMxH9AgYZGrEs7QB/D7rA2Zord3uL1dIa7Btz+DxVeLQLCSWfHcytyWDFWwR?=
 =?us-ascii?Q?6fDvUPSngYbgsngN7XwKuYKzFiSAT9wHXT3iyGICvob/FcKgJbhXq8oRiH8n?=
 =?us-ascii?Q?vPLIf1dDAK7k5BgpX8ma22rK0V7avy9HR9GjxNdJQEXcY9Fb8sFbk9XzKUJ2?=
 =?us-ascii?Q?kayHGEhXaKkNQU5jEIyRzfRfduQG5xZ9w+xWpJJszbRm+vwVMTZduEt/WOie?=
 =?us-ascii?Q?2v0dQ7Wnkj06Q8jpTYC+qbuG22tnPmfZGBwrPUad8zUcp0BaT0u8M2WWEwNL?=
 =?us-ascii?Q?a0UhNBmcAspRU/OlIDjwo0l93lGSGgz4OsEj8SXuw8SCn3tVvZjahRsO9l9H?=
 =?us-ascii?Q?kem89+mb2pi1fmnD2RPLzMOO9KqL4U3tjPM079GVHJ+flfjCYrxa/o8ythYw?=
 =?us-ascii?Q?va9aXHfM/YjphE5PHIjh+tcH7zCqwXn9FwxuXA4fknhpi443KJbeZYslXcg9?=
 =?us-ascii?Q?eQX+BZC5/Gt21aRPiG/DMECf08FoSoB1OUwMhDStY3yanl9le9XwdG3t2KIk?=
 =?us-ascii?Q?TUwm2XC3DN2BRgoSNdvIhZ8/srcegzYOI+xXmivHPTsEBrWOW8eXK3Fjrm+Q?=
 =?us-ascii?Q?/pdhThKj4Em/6Hkc8bSgFe/GWEAY9zYsXSgnMbDvxOEGT6Thsc+Dt6Fp1SIH?=
 =?us-ascii?Q?cSJDRlkEsLLx5y3DCaPQwxySFZ7xVYPSfaitFn6OwnItjoUYn2btZHJ9Gdk9?=
 =?us-ascii?Q?6InXsgfHAd6lqksDylJiQUsGUWNkmIRVBgdMiMgxuctjzdEiG0j5wEg5R+v0?=
 =?us-ascii?Q?hU1V2q24kYUDgcMIlaU68/NgK06Fxd9whXICPyqfTAfwrw+l55YgEbA/HJN7?=
 =?us-ascii?Q?EAtDqXTDI3v4o4025ZFzkBOw+P9LnnynD0SfM87q2mBDI6oMkLB66tepGZ7B?=
 =?us-ascii?Q?EERgwB7VhXRiIwMEew96unmXj6EYLKcGGTL+uoZ7klX08lKkWmUy4FqQHcuY?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d828d97-a7f8-44c4-4780-08da9675cb49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 17:23:09.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiyyC6tr8+bCI4DtZoKnp86BkJjelXA5D90WfTQLbiDv4fl3Hk3DXpfm2Qv+BcypM0CY8/EwvfDyZgnwE95FlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140084
X-Proofpoint-GUID: J0_9jbn1IrJ7aUfBVnKUSi73kqx83noA
X-Proofpoint-ORIG-GUID: J0_9jbn1IrJ7aUfBVnKUSi73kqx83noA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/22 12:54, Doug Berger wrote:
> When demoting a hugepage to a smaller order, the number of pages
> added to the target hstate will be the size of the large page
> divided by the size of the smaller page.
> 
> Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e070b8593b37..79949893ac12 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>  	 * based on pool changes for the demoted page.
>  	 */
>  	h->max_huge_pages--;
> -	target_hstate->max_huge_pages += pages_per_huge_page(h);
> +	target_hstate->max_huge_pages += pages_per_huge_page(h) /
> +					 pages_per_huge_page(target_hstate);
>  
>  	return rc;
>  }

This has already been fixed here,

https://lore.kernel.org/linux-mm/20220823030209.57434-2-linmiaohe@huawei.com/

-- 
Mike Kravetz
