Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE556F44DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjEBNP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjEBNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:15:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F093
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:15:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKmx0009007;
        Tue, 2 May 2023 13:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lLAeP5LWcrcOLm9HYIgsZJ3t6WcQ7r5KhudnE5P6ARg=;
 b=rBbeR3zQ+AiTaGsFHdRuLFvAQhM+lBwfIE/cIDJXi1fX28jf4hXkVgVad9GH8FjgHDSO
 hIPjiJdawjzFC3y0wrWR+cjauTcV/VEsx+Si79ZCagn/YeqAz056MAaueVLl0S9v/L1y
 4LaDZo92EoA5iHxhw0KT4mfs91bWlflVpkmwS2xYTsaPhqpeLBPcdHNiqOiLfPYTe68J
 rP7bkL5uZezi+bJJ3sjdriNRwh1j1UTQoT10o5sGx7wXDX+9x20nDdMZ6iGPyPxYg7sO
 t0b3BVWuYrFEjA4Ad/ghp/rWxLvoGpOn7ilYpjf0C+lIr4EeDL8jBchccK4ySoOqYSGN AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fmq5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 13:13:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342CmIf1009890;
        Tue, 2 May 2023 13:13:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp67dc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 13:13:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/cT0soyEyjaG7px7rYJ9JD+zieOsanRUKKmD6XIJqCfJNVUqE+5e0Ja8DtBe79ORvOJJD7gFy4daLhuYQn2R0gDiDdB1/7wPOhFlnqB+L6M1fm++TwXaQ99JYumI+TdDEBNu5ASgdq7q6Q6lsvB9Txf7kztWcfOR0Uqvg84dlXWCZyO/l24zpe/51IngUjEwKBaJ2K5RMwUx91Oh8IqVvc27+prNYna6vetOi1yDAEtxjzCPeOinCSjnsSJLPOB2KKcq9AcccrRX2Y94UlwEEc8fXVF7XyWxl2zdCKBvRNKveBRD19Ji9mWQBpTEKE+0JExAzQ5ouokC6E0rYEe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLAeP5LWcrcOLm9HYIgsZJ3t6WcQ7r5KhudnE5P6ARg=;
 b=Z6ZURbGGpWwOH/B7etMo0VStU3tTKmxqwkGr8Lb/OfdSSr7VgokKr+TbNDGVUL8sHkhbOSXkRqxj8ifhkEimfxgeBghfyBkg9YM8PyaR1dgKd2kCql5Ev511/Cy80+aW8fJtiFzbgi0eCZdfWP5YMqOoLkKTJD5D2VhYzIyT8F4+C9vkFYGhnZDpR36xGf/y27dkagMlMNvGcD0H9rjj2yHRSaX5eTuMYpgn2eCB+wVQOITZ6xJZxdyYr/sGSVEPUpsWCoEaT9XzboTt2UWV0muByjTM0y0KEfi86o63mT9QIt+GvSqL2YC2nE42g0iyyafO5Mr70HguqAkKwh+mUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLAeP5LWcrcOLm9HYIgsZJ3t6WcQ7r5KhudnE5P6ARg=;
 b=UDAZMesy+jD/R1PtIL+BHzOa4KDxGCpNT6sn3D1CAg08eFf7Hj6HeW/u+d9oRzaHW9JrDSDM7mveB0sWSfvZtR45cATztC0VWIy6TO7vzBkXiuqu+Evw/1M0r502tHaT1ZS4Ix//pL6JyoRp7NUpZdCPJUIattJRkyQ8f9lRA0w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:13:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 13:13:18 +0000
Date:   Tue, 2 May 2023 09:13:15 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-ID: <20230502131315.fiq3tbc46f4mozum@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ2PR10MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f055dbb-8315-43d9-d786-08db4b0eff03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoSoCM5q1IanpDhCYWz3xULZNfYaMwYrcCBEA3ADvTr2OVqq5jd8BQAYkG0G6guCreYpmA2Hs2+4EMgaNHCFsFlMYVzpweqSinm8PDKKcCsToRJmqilYjjZlpQuOoB+mozY4TCjk2L5GoshYukM+INxhqOgmZvd4T8v2sSJ0vUsYpaf/aMoeD61WGlUZvoBfbbdZ8ypY7WE7WJgZi7ljEfqrtX091ehP2rLMDxFf8LZ8cfQaj72wPfohwiOtlBQYvkuPY6n97t3Pt+jT53ZkwidYu7yjO+7Uf5lKNeaWwrszJ7c09MCl15p5LKEAwd6283B0FGGHYaUphcqcT4GjcTrhgfqPPUDgWpMJg9ecXowWfnqt1KsB9r1Xi55vI5sGA49NkXJrLxTq2SSQscjD+KBvbQxFxvu2z+yjmUv8u2Rj2qmYoFpPJ2KGZbdTKouOL8Tple9p+qIolM0eqNUXQAVIbdeGkNXeWc9EX4XjMrVrPJIbu5FrwpY7Xx3vbt+25dudJtoUj6YVUKuHmqNWplvcWZn4Q41jID65zBIpLXy1/mkqv0dmSGCs32pyKJBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(5660300002)(8936002)(41300700001)(8676002)(316002)(66556008)(33716001)(86362001)(2906002)(38100700002)(186003)(478600001)(83380400001)(6666004)(26005)(6486002)(6506007)(1076003)(6512007)(9686003)(54906003)(4326008)(66946007)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1KB15lstY8Q9tSNTA7Tk5XRldQZlOI7iyjvAOwj5yHgI4Low+YFHZXPvfzq?=
 =?us-ascii?Q?7F/OOVFbJmUHO5cP5DjPM2Joo9WMZiXB/U1x2g5C6nOiC1yC7DJ6KJOqBSMh?=
 =?us-ascii?Q?r3c17D64IPCkuY4YtSdVUPPmeurTt9JLVlSuE5uIcLEdjK/P8uizVa0/uwcf?=
 =?us-ascii?Q?WDM0CtHs8FJTwYiHYED/zKAV7rmw3iKEnyvcAxiaHwRm0nWqNIF0TnqGPF5l?=
 =?us-ascii?Q?lkidYihYNvLNmPv22OhjFmGP8SL2yrSCeeg4FrUZbJfD4Lfb/GQKppxmv6lx?=
 =?us-ascii?Q?s78rnkTYS0e2Wj7y9ORJyO1xXR/3F6OStxx4M6/+SyyTIAoUvNp4Yw8At6MG?=
 =?us-ascii?Q?p1pwdUTJq5UIx9IDN4CW5J/Zt11TM6hqV3H8B1+mlVd17U2dq1+PdpSioYZk?=
 =?us-ascii?Q?zYuRVozJtU3emw+Y15UukkZ20NA1C05BlahV2t/SiUKdXiaWyCRGZtHnaZki?=
 =?us-ascii?Q?gaVUocPLNy2b39okU8erQRdszs5ojZHbYjkCsIuUbD6I3TCRAtCXpYMm/yXv?=
 =?us-ascii?Q?0zhOctkse76V9lcsdJfrUWXK+517JJdTvLBuvNPr6GpBZIpsEJo1tJQ+s7nS?=
 =?us-ascii?Q?SHop56Smcv39aFlwdCa0x2hJqP5jOXHTZl+zWNUpsDoPdhqEHzih0VjmL4uT?=
 =?us-ascii?Q?9s9yFj4qqz+j/gjpEHlWjRuQvtED5jxBFebxkfgInGWmfDMOPrkEnfKcx9iK?=
 =?us-ascii?Q?O50XOl4KNl+xcJJfxVT66czy9g0YMdFAApUJ7NsPIeqDNCBeLlGux0K4BCqc?=
 =?us-ascii?Q?XGkWCRhiUhb4MObgHinq8Kn/d/bURRSRv2xZM0yxPTfStvYR2IUYWAGyqByL?=
 =?us-ascii?Q?PHd/WOVJeaHTmnZRryRqfboBPRO+twi29TKjqraQ7KvtRBsrxIfQOwQ63ObG?=
 =?us-ascii?Q?9pYaCHcnjBrEeizjgHl7TJAaMhh5CnGCVlEP1O/DrLx2n+4ofPHcmCBnyfRm?=
 =?us-ascii?Q?d/pqe80P2aND1NPMlqybx4vBZ+mNdIQRWiSTecHflje8a26MudV/hNeRZSla?=
 =?us-ascii?Q?zxARMPRGTbde/1ax6hCmTqspZBj8oUeQ8xtDHaFSnkS723qh+2fEbTgY2knh?=
 =?us-ascii?Q?Hk6gu1wzUvpBly3IYGMUkZxkj0HGVA4LnuEfciJGNuuX5uE66RtmkHJo5DTs?=
 =?us-ascii?Q?OcKIHUInJ1lviVZMpX/dzMqENxGmOjHdVjeFPtFTWNE5dpm/YC89ahFdPfWW?=
 =?us-ascii?Q?R76Q7/2qX4KRNUi4YE7WBs7QSSumBuXkQfOkpZXtt9fyjmhc3U/oU/BgKKEN?=
 =?us-ascii?Q?Z1XLCDcKAElJ6EOuZCuqPJAMIvnyzonRBcYzu2LHCIjiGLx5fM3EP7itR4bn?=
 =?us-ascii?Q?TFeMhubf7ppOpUQV1piThmXQQvHecFU2ojxpyNcNRR03QVDlSU68LiFVqaYj?=
 =?us-ascii?Q?6m2GWDT1jwKuzZwfxb6KVsGcYe+0V7IMLJ/35U/IaonWGF+wdp8LYbLSO21w?=
 =?us-ascii?Q?E1EA2zsz3Fa48cMtI1djEgjZmCtEnZQ8kEHIW0+noE6hdMw3J76NERgXS1eq?=
 =?us-ascii?Q?0Y7rBlZaoxqNoyNoamyV1z0Ywsl2/YFzjfJZGeNGEG8HGWg31QWXqXtFqouC?=
 =?us-ascii?Q?VXlMTs7tRlebLWu9OOW5KosaiYsXRAOrj3Wj7bw2pg65G+xLOLu273M+5SKI?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TkeXA1rRWaFSnm2Gk4PNdOA6OqPf/TBsNwnZ4buAUwkaxCauHQSM/RI/fy425DY6PPQB1zPFOW4FAFx92ajTJ7XQGIsAN4nIhwbLL8ChcZBap2wGtJW8n1yMfgVPhpTrPp83BquNhjT9rhzU5NWb+Uv7VaqmscYgYcRFY31nVxwKRO7qOvTHuBXxE8v2faEh0UITsjjTDhpzjgC7L9L/s/A9qUpU1BvTD9Pf1N+w7oUeoSrd5T9d3aAgBF/2V6f5rzNWHkAO7ckW8WDr+ZoXUp4isZ/+mFxKTDaA4bAMyjuIq7Ki8hvchprLZQhYnV8Pe3IWDk6/kupOSAkCMhXWk08b7OB3DxFrXoe8AFft+60DcorrBKGcHGiYKCehlmMRVEBgju+dMM6LLp5VbzeOgwbGotFwo6qPL+nvJlu3MC8q5tXfxsyrXNju2G7jod4CH5m9Z46jymsTrAiaty08ZOEG+E+s1Skm49dtYuabJArWHv2hL/8UiEH1xyZXLqZMxRfZKCiofMuQ+VaIlmn5swXo7C61N1JUZH4ZeL1u57uF+5Y2+TCXlkVQ6Ocg7Oam2cj5d7nZA1lsrBLw9ubzM2Ai/1q9VzGUHXFTnTLHCk61Grg7FOPBLIRDzycwnb8ulH+GSGtyhD1ky3dCiaHkNd0Oa8ytcCFnNm9EqKrO1LJd6qAdMhCfjRtpj/m9Hy38R4bym7wjFHs9NCrCesF9Po0n2m0BKOWJfpl9ep1ownsO9QI0JyFGW4p8g2q+Sk8uzo92qeVzkPeaT1FTOzyw1gfkSc9Ifg0+/NLfskyqbHhTQpnO5UuX/gO1Zey0TJMidMzFOrIc5Znt8exKi0C3gyoRQNKqtWSj54qGLziFy+wg9OwjTxqcrt7A3bImi8b0UnIBjR4NmO7jI4PSoVR1NQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f055dbb-8315-43d9-d786-08db4b0eff03
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:13:18.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCEIA/GL0CjSQk3i4XljeKE+ZwMitsUJTAI/a0VgqEJLkhTCfA3/3lC+J3awUR4/uEI08brl5HPIKHm7rAOT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=785 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020112
X-Proofpoint-GUID: Hk52TNFhTj1_furpYO21hhI4PzNWE20G
X-Proofpoint-ORIG-GUID: Hk52TNFhTj1_furpYO21hhI4PzNWE20G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [230430 16:19]:
> We may still have inconsistent input parameters even if we choose not to
> merge and the vma_merge() invariant checks are useful for checking this
> with no production runtime cost (these are only relevant when
> CONFIG_DEBUG_VM is specified).
> 
> Therefore, perform these checks regardless of whether we merge.
> 
> This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> Correctly update prev when policy is equal on mbind") in the mbind logic
> was only picked up in the 6.2.y stable branch where these assertions are
> performed prior to determining mergeability.
> 
> Had this remained the same in mainline this issue may have been picked up
> faster, so moving forward let's always check them.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5522130ae606..13678edaa22c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		merge_next = true;
>  	}
>  
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);
> +
>  	if (!merge_prev && !merge_next)
>  		return NULL; /* Not mergeable. */
>  
>  	res = vma = prev;
>  	remove = remove2 = adjust = NULL;
>  
> -	/* Verify some invariant that must be enforced by the caller. */
> -	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> -	VM_WARN_ON(addr >= end);
> -
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> -- 
> 2.40.1
> 
