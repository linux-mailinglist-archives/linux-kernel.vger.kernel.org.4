Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391486461EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLGT5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLGT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:57:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F765E3FD;
        Wed,  7 Dec 2022 11:57:09 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7GDv8G010250;
        Wed, 7 Dec 2022 19:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tMaLcJnjsya6xB/fqoO37IigfwJeuy3AOFtxwKqlfco=;
 b=jhlLKV2McvFZxY9nAuyYC7kz+YHANvfcb2AcvIKCmTlhuDYacpZbeDmxQwlldJZmSF10
 g64Un8rtQFk4VdT+TMPCmBK9X3/x6L7g/XuUZRYGfp6H46whCDS7dasyornuQJfxVRkk
 ML2XX6EUqD3QtRh8eTbsUA2+9bB+RaipmCBZVh84UTiUCszaX9Hb2PErnx8gMar+U3e3
 NhnnLPQaMEHDHqjUtPqcsfk55eyeoRMNrrGDWJ71D0BmE/VIqiVzfjuCEt5eXMZY2pvt
 tQAfXE3cJ0vlOe5uyxNqSfESTGj8ZQb1hUAOoyz9izd2dYhRnckHlQygwkMh9S1TxCUj Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudus7yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:56:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7J0HJm021708;
        Wed, 7 Dec 2022 19:56:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8gbp80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 19:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbI1vu+49AoWgryg9EEH5fCLVQHpFROmZh0SuqPK6WZ9o9a04qT+hacCQqVIOahx4wfIXdcJiHbEUFpDneTurhakV65iPmlPmd0no4g5RQ2t41IWEUNMwlROpvH5CRD22D4UBQvLcprRyJyiQGzEPQmF/B2A+wb868ae0mK6yNHhD96dxjm8f1OZsy47BvYncjt+AHa+oqbJj3an+ypmu+9mJkOkawt1KMdLALbJx0myXV5cP/EJvRz6LKqdFmTgWwPEHA57NzObM6w7HIiEe2HM2VicZC2hs3Wshf/3PVdO9HNzNNl7vo/VXCXjM9BO7gHYiVwzJfPV6mTbngc86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMaLcJnjsya6xB/fqoO37IigfwJeuy3AOFtxwKqlfco=;
 b=WbsO892j4rtfIBAAFsa2r8uO547J4GtPJvkNDG1BY+oFT+68Ae64QDaFhv/gPo2Qp4J6TltG+YbNMcvCJjWhh44P860R+xzCyXuurMFhJFpwhnkPADdH86m4t7lSkDjcKe32fkih8COT+MlcBTnh3a5PbXh8tsKF2OPnGKpsOGVcI2ILc5iQDEBUMzAAaDAgjGumai52EN54qmPyEmn6c04gIo0/P60RgmpkSGtPlng4YyF39GrPkWC+u9+3OaqBilOlv87odKYMWnlycu0daU3FohtsNnb+Lt55MVBWq6xEOP+MAbtpFZHgviXSrD3D/YlwMXTzpY/zzklkfPCneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMaLcJnjsya6xB/fqoO37IigfwJeuy3AOFtxwKqlfco=;
 b=VZMtKs0d9mGNIr2qIvYReQLnasNBmpYAxItRdmC+Nq6fAvd1rThwIvZUR14X2n6RehbEibYGRTumcPSqj457r2Z4SmAwSIBTwnOe+Rkaxy46w7u6ZwuhAaL9WG+g+h8usWK/j9t14+7w4WLLizFdCYYWHlkvjcl72Wl+dovgOMU=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:56:28 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::6a6a:2552:ef79:e2ec%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:56:28 +0000
Date:   Wed, 7 Dec 2022 14:56:23 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/2] padata: Mark padata_work_init() as __ref
Message-ID: <20221207195623.mk4jt5vkc76s77cf@parnassus.localdomain>
References: <20221207191657.2852229-1-nathan@kernel.org>
 <20221207191657.2852229-2-nathan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207191657.2852229-2-nathan@kernel.org>
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: a17c4525-103b-4eef-62f2-08dad88d2090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tGa7qDiFVYufyKCZ3E1xQi324DN4yswjgCcS2pJRFOqWLgDdLJF3gxuvZomcX9YiyXGYaf58z+AdCkBKJq/zKCr4GamaNJdvtEGMYiBnJDMQ8UNE4snqAYf+IOOIISIQOpslvYOX6Ay3J39trz3xik2+EP5Bfmm5NXZioCSpezVbjRRPeMrqVRCxpdp8Nj1IL4K9SPBw6uamrPkxVnQsSwU8Oy9uSwmyZvYNnHWtD7tjFqfphfJz8+PMYA8KMf4CZlLMrhfnjq0ktLS3rcSLsF82UZ3Mce5bBchskYFXSFx4yUVUOisq5smaRrU5GqBw+iUg/2+x3eh7HhjowbMllT0+SGDoMuffx5uWOyk6lZyDKAQKD7KyuksKTn9QrOnzifAGX2KX+xBK7tCiX8Ef04HkEURy5Y80DPWSSko0ArJSZ+BBuOVxHvA1/R6kcLaSTBKqYb8nPJsV7yKWUYG4M1uPtqgZ/CKnrjQKg131NiR960jMuuZbNpdjJUQTVyMGLOjXKQ8ZvbONe1sG4fTXGyhLOj69kgqIgkVsoXm23Tk0uARI9FPRkACkofXpq/zsvzGUr2a2HpZIw1kGz9nlRNDTSQqT0g6YwqddluOeULt7ARBK8XNw25xFrCp79BalEKxWVtsu9H5gjEyRZEY0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(2906002)(83380400001)(41300700001)(1076003)(86362001)(66476007)(38100700002)(9686003)(26005)(6512007)(8676002)(8936002)(5660300002)(4326008)(7416002)(186003)(66946007)(316002)(6486002)(6506007)(6666004)(54906003)(478600001)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dl7PRs98j2XTuThZspcYpqYZbdg50l1JuqZT+i5J/rnL83u5SJlE7WDjNiim?=
 =?us-ascii?Q?3YkDARRWJ6vfffx0I0qKHYF835RzyBRqsB5g0Xi+Bu6W2xRwNJlw4/LW3Il+?=
 =?us-ascii?Q?89l3TpD8005uTwBd1ylAu6p8UdBi41foaDtVo7BoHPzF2fxl68Z/cqCouQyq?=
 =?us-ascii?Q?3VRIA1nx9KXZn87es15b1BLd91ahbesUYwJxaimNYaGSTL0vAK/O1ZD5PoTQ?=
 =?us-ascii?Q?PU4KxsPvSzOK4f05YBvOFwf+lmX6zBrqNhwqj8gwsz4srNCeLnwA3e7C5jXE?=
 =?us-ascii?Q?ZhORi1/Fy5gx6RFhQNhxTU5lhnmnvD29sJSr6QMv1YUfZXAKQXapQAw3DGYq?=
 =?us-ascii?Q?+Yd4LUXd9vLyomcqKwWfDxWljyKwa7+6i7Zi6VPJpfAgI3KRjJYC1AfaM8WE?=
 =?us-ascii?Q?nEbj4rKObn0XaCiId6Swk/CPX83PitgK43pEPxljci5rMqpK8hkeoyujJxZO?=
 =?us-ascii?Q?GolLc5I33sQGCX6LwjLyVd7gZnJ3JWckpcnzkXN0tbf+b4nlm+5gBOGtXFMm?=
 =?us-ascii?Q?1z4oPXiVcNs/uInAsuAvIdOGnmqmwOyNoDyKBstBCVSHGlJGiZJrlKiXAOK7?=
 =?us-ascii?Q?xoL5V3GdvqivAjNv1FQjxeXmTi/RM0dACiYq1Y1wcp03/nK/L4Mq5lMOU/vo?=
 =?us-ascii?Q?+NOqsQL4GDEKx9AaNMEN3jg/weF8qfnzfJbWCITwNaQDJQZ3AKUxIqxLtYV9?=
 =?us-ascii?Q?0f8ic8XPbYXHLUablU94lOr47XNaQJzwG+Qt3pOuP+LsBe1djhFCqweoTNnz?=
 =?us-ascii?Q?5WL6h/8NbG9TMm8012A46NTpOGDN/w54cwzS/nj32tziCQ3DCQKFtgCvuFqm?=
 =?us-ascii?Q?gf5KiVK76ShLbP5jOXtzAp6f7V9YHYg8NjfaT1uNfy0mDqq/wUVzZ6Yc6JW2?=
 =?us-ascii?Q?T4nXrsp70zHb4HY6X9RSqUPr7Py7YxN3Oq/3SGiJu+T7+VtUhkcw7Pw/9XXk?=
 =?us-ascii?Q?VDUGHQHybqxBFRO56LoIDpesaMw7cVqT6yStTNlgxZeGje17+3dYeOFDPYK7?=
 =?us-ascii?Q?luiHazZhyhEfUA+ZkWl1USjg5mKV7VDHeS5mlMMHKLYKq9G7lInRnMn+zPA2?=
 =?us-ascii?Q?MkugwKRZDSt27rrtz4J33CrgirB86ZXLAQMtPFp61xDMAVuBKgFVylzNjVuy?=
 =?us-ascii?Q?QenlTtfq+uLPSNu4ziPKv8DU9sjKEPjrlgF+84EfgQ1jggqDCFzmL8p0G3xF?=
 =?us-ascii?Q?doMQyDSDxpcrOv2O64Uve/iViuyPCnQU2Amls0RA2ShIko+YEOBjuxdTK/rf?=
 =?us-ascii?Q?DiF8BVhHgwf+zBf9z9ckHPi73V8b8+t3D2XbKgL7ITaNUfL9X6YSHimXRW7u?=
 =?us-ascii?Q?BIONnLEfle4HU1C6dLKFR8hhdLFaxdxujXcvLAkeMIwpBST7tIkh2uZuWFVd?=
 =?us-ascii?Q?aa6ldMPAHMsqhlHRlWwMzgILWLzUTZWtbB4xpXaEc9bYnvq+jxUIosUXKgEe?=
 =?us-ascii?Q?gX1wWAEHITsGY1hFlBdoilxG/zCvAsxSX7+hnV0e0Wjy/ioUteQor1U7YL0u?=
 =?us-ascii?Q?3c1Jj8uuXmnQUen4o2b9HiNZLV1LACIxog9YzWZLQnFQn0LAqmstjsx65rvS?=
 =?us-ascii?Q?60tZbk00objWSw6zni0WmDAtFMjlRPZOsYxvmIum5SF2E24Ka+xNbijoPj/q?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c4525-103b-4eef-62f2-08dad88d2090
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:56:28.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZOQ/lSeA4ApVGwIIJvolw69q3F4s3uCVww2t1oW+uMfk1J/baPyVe3cFI+2IrY5lbi4SvEUe1P6QUFNBI6D6sWVLpvt1vvkfowmpjGJ7AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_09,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070168
X-Proofpoint-ORIG-GUID: np24030zaTgUIVB0KjHf4nZtyT8Y3pVp
X-Proofpoint-GUID: np24030zaTgUIVB0KjHf4nZtyT8Y3pVp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 12:16:56PM -0700, Nathan Chancellor wrote:
> When building arm64 allmodconfig + ThinLTO with clang and a proposed
> modpost update to account for -ffuncton-sections, the following warning
> appears:
> 
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: padata_work_init (section: .text.padata_work_init) -> padata_mt_helper (section: .init.text)
> 
> LLVM has optimized padata_work_init() to include the address of
> padata_mt_helper() directly, which causes modpost to complain since
> padata_work_init() is not __init, whereas padata_mt_helper() is. In
> reality, padata_work_init() is only called with padata_mt_helper() as
> the work_fn argument in code that is __init, so this warning will not
> result in any problems. Silence it with __ref, which makes it clear to
> modpost that padata_work_init() can only use padata_mt_helper() in
> __init code.

Thanks!

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: linux-crypto@vger.kernel.org
> ---
>  kernel/padata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e5819bb8bd1d..4c3137fe8449 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -83,8 +83,8 @@ static struct padata_work *padata_work_alloc(void)
>  	return pw;
>  }
>  
> -static void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> -			     void *data, int flags)
> +static __ref void padata_work_init(struct padata_work *pw, work_func_t work_fn,
> +				   void *data, int flags)
>  {
>  	if (flags & PADATA_WORK_ONSTACK)
>  		INIT_WORK_ONSTACK(&pw->pw_work, work_fn);
> 
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> -- 
> 2.38.1
> 
