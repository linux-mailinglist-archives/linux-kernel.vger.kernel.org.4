Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE006DA7DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDGDEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDGDEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:04:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EFD7290
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:04:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3370mYii004201;
        Fri, 7 Apr 2023 03:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=b1r9M5x6AH4hYUF21dAAdXWPHYjbaurFr9J3OoVmNRQ=;
 b=V7w22OA7GDgVQ5ObSq+YNVkG9fYsjTOU7PdgrW5fY/zXnIuQLFAKxskdkbyZT9uRF5R7
 l0uNYw4mkx/LAQpca7kcsmBPnMEUsiTvJSghiKpRnAZMlPNf1byvW+xrEPuonoEukBN1
 NbMPcpa8DlOZQci2GqASAkb4iRyg1rOGX4EMetHAhSRnV2qmQnWqZ8R6cKJawm8K+J9n
 zHK9xAwFvat0pMmPqChMUzDtUBgsdLZI2VS5X/8Y8aIJLW7pPp0Y/35dXf9BBHRfdG1n
 G8rOBXKLvSkdF/J82nyX+tyTt00E9zy257oNiNXG20H6hQGFN8XuysrWsmuuDn2nm37P +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71vcaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 03:03:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33732Trp018513;
        Fri, 7 Apr 2023 03:03:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt2aexw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 03:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGDkuFdSMakMhHI/RLtIjk7HvPsGvmud2oQp0fwXa5BATnmttKki0bFbiQEoZ6jrfdBjXnwNYJJfVRExTe7Uw2l1dxacEfy4tJ99yd3rWqmDihMd796YlZ04w9EPF6hu2CQz7t2a1D8EjKE/bY4KNZvvUphi1MnA/dXLV2fNqu9KQj+Okle5P5fsqI8v8/DbLQ8SVjA/E42+uzLD6RgUJCOnK7PLdLbtSCAvgHuaVM3Yr8O1xgzbYWSUcCG5TDvHJ6sUkZrueNzt9fTUxWknv0YBHKT59oQfnlpFT3erCCXybdzkVSwlqkLOid2Ka677mho874AY6/hDPOh8NHiTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1r9M5x6AH4hYUF21dAAdXWPHYjbaurFr9J3OoVmNRQ=;
 b=Hi67EtMVvrfUzX34Dnc1jxL3YxDb70/lWGZLcDzB6JEoI+v0TfxARkFIjSiKP4nHsIvdaDhJukiJyJQDt0gPsHtW+H39sWKpJ4nPJ6qEFJudedQNCYRVTLHk5voByHYfYSoy99vGcODZwZjn6h8kK27AZdY1bNE7ZpyhxXCLBxP/e9fH5/jcdW7ikEwJs6LHyYQouau+gvcABqXb3zha2yas+/jIiVn9ZpBSwbzXztYEP+2lOUszwVj5EP1KNkn/WvZDL3mY2weFbKlwMxg9fNRVqgQm/VAZjKcFgFINer39px7qprOHrnccUcyg8kGRf2Dn4k/6kLe4IG2iZPLpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1r9M5x6AH4hYUF21dAAdXWPHYjbaurFr9J3OoVmNRQ=;
 b=RTikX4ZU2OtrCTExFIdTwYnA9wv2H3jfXeRalN9rQAtCPJEXIY0g60OPm2MW7mlNGuFpIDO9sogmIU5URI6IDVju7pIOCNLbN/3ArISP0Eeaenxsv0edio3rmARc5hiTWxy/bED/t+fcEv9YSeEGeB7ymSbM6NLmdtAtNsVxlzI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Fri, 7 Apr
 2023 03:03:42 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 03:03:42 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-5-ankur.a.arora@oracle.com>
 <20230406081933.GD386572@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 4/9] x86/clear_page: parameterize clear_page*() to
 specify length
In-reply-to: <20230406081933.GD386572@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 20:03:52 -0700
Message-ID: <87mt3kgzqf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:907::28)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 492f5e03-40f6-4637-a092-08db3714b170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdoSOIrwCnWPa/9JAA4G+eOELw2/k+BoGCql8lcU96BsfmNbdOJEdewITYNG7vFkjezSRgza16FhKv4Pqsv2AL4K/1SzazMHwrggNSNYqzwCqpTEb5cxzb/rbI2nR8+MHk3t1FcsjDJr1k+zZfTig1qaY3AldKPIuiW2ZjQ9VnT9COP0LS6YUylmvZYuPRg4A+KDHYMBOHfsgatl4lclz+zGidhK9NwGmW3ylwxU+AmuAohzGvpsebZ3E7/qvxjVcX6+6+L+mzCIuVl1lNM4reYdrJAQNx+dQ45uHVimB9w4IzLuJ4Ekc62uB/rTM0+OFXbGdW/22I4G4A3PKNqxR4CFr+oTIvEjs1Mq2x6nA+j8wr6c1mBW/g6zSuS8QaASeBmBOU/u6Lpm5//bwZT2LD+MVvc/fvJYFKJ0gm3Ak2oJUDzelPSGOCMS4VUtOpZqg0jTedk3+mQ4ROFHY4xYeLNhNb67eBlg0AOt9H7JBQYcKQKxGcGErVPHoIrgmnNNr1KqMOTtNgkGdf2N70iivh/jqpN/Q8bKw++SRm70rgMiSa9b4PxU5qNqtHKfFDw2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(7416002)(41300700001)(2616005)(2906002)(83380400001)(5660300002)(38100700002)(8936002)(8676002)(26005)(186003)(6512007)(6506007)(4326008)(66556008)(6666004)(66946007)(36756003)(6916009)(6486002)(66476007)(316002)(86362001)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBveQiyCegP5HEBi7+5ABrYucOQ8NxozIaSo48e2f+xQJmkzV0hGNEnRJ2+l?=
 =?us-ascii?Q?PTnsCIirJAz6p6pedX5TKXPExfoTXNsSeAlHKo1KaAffeFXujY9VB+oOa5Jo?=
 =?us-ascii?Q?LLFUtNKo9CSOBwjpW+A25kR+hjBgOaNwqPBYPky1D+kWhih+bRmRBhktJk50?=
 =?us-ascii?Q?lcTEgGiSuatscBjUz2wzqPWxNhHQqRCxkZobH4Q8l6P0QaiuRCRKCHHLsSh9?=
 =?us-ascii?Q?/Q41j1z6XZEcttqX3p31GtH3bC4S87xdTk21Z+gvNTZFJEr+murK4YNuzrgz?=
 =?us-ascii?Q?/IjY9BrcMF9SCaOJrMo8y5L8ttIDoqjgKSxDMcQ5xhnuLCZIUQZjWzq61koD?=
 =?us-ascii?Q?jhhFpXSm79a/PYEXYWYhIBmSVySk8XFuSH/fq4NHqSfg63/MxVEZQN08ABtb?=
 =?us-ascii?Q?E1DiHjuy2hwI9X3Kiy9Nv3dIfLn9mhuBjKsRF7oRXqkeVyeuSEZlq4Ef9qGD?=
 =?us-ascii?Q?msBKlXY0P+o4VH0L6oydCQfyCMZjjCYpopIkNtOl0vqaEAZr0ki649quEFCT?=
 =?us-ascii?Q?6KGlqkUwvXxBy4ws6o+uJYe5IV7jbFpEtKgj5ZzfkGEPyu3kHM+ov8Sexvt1?=
 =?us-ascii?Q?p+vMWKEm8dIkFETouwXl5TPvinJb4CLleiJ649mwTrpDv9Sx1U+fRQIzBaZY?=
 =?us-ascii?Q?A5aPciSaztk830SZYbsG56U+HZ0Ks9hLCSkzs3DwuVJziLFmChXDR2r3ZSzb?=
 =?us-ascii?Q?EoqyhN2zmUHJRZKJibZ+l2Y3vHClqCQD2WUAoDIDVrttK+/g4luADcPvL8qn?=
 =?us-ascii?Q?6VSk8kojwBeVfpX7bDlM7dDATYQb5r0ckVoLc7+as7QaTzGFrF9W/FnldxhI?=
 =?us-ascii?Q?HrD4RatY2xySHLlBqYZm4eU2gLrm1oyUFm3hM4GZrabH887fWXuHGiIsmu+7?=
 =?us-ascii?Q?bqCpw/j/z/MUWo55B+IWmNUxQGCBfKuR7tKvgiKT+c0uCWamyd3JjqRMTNyx?=
 =?us-ascii?Q?QEhDsiPI9h3TOPrbLlZuvHx4U0RDovXdUMayvBowUzEIjxJdjQ1l+tdBfhV0?=
 =?us-ascii?Q?dwgF5jUIbdOHDcbClWa/7bz3JBnzqHAE2Xa4lpLREkzSK9FCkg9C6buDnZM0?=
 =?us-ascii?Q?EkuO2shMKTcl3xQMWB6m/IGMvYIC7+qHue92NzUAOgCNqtIKRqf36SbQua8C?=
 =?us-ascii?Q?/3wlRqP4lMXryxfypgwtCT7Dr3dDF01TKy8EGFU30f/4OmIyy/GJ+abg1odb?=
 =?us-ascii?Q?03LdoTJgWn/jlWznw8xrLSGnytAockyYvGJS0QRQ3IgFiaE7dTN6PJkXgvMM?=
 =?us-ascii?Q?IPQb8xOqTOXOF6zBVjdM/67Dq4XUtHEWLPhqIsGX5vm+v21DHRgP5OZO7Wuf?=
 =?us-ascii?Q?47HBlMbzVKFahAiVtg6WyaFNr4HsTOQIM/pIfP03fzZWrcmbr2jyZW2Lomwl?=
 =?us-ascii?Q?AEDDYwxBDfmZJ1kQC0eMTfm49UyX3zFTsWQ5Ij1q1eBFd3NHZpEyLuiPMvPB?=
 =?us-ascii?Q?7OkuDAqXehuMIVxPbWlhX+15CVPtX0l/vm0z8JrtDuMu+VhhhzLeTE4bkZsf?=
 =?us-ascii?Q?Wt/4I/1U3BumX+EMmu/nQBesXmnixYCc6k/pDXmoLAItAdCxgCnpmHP1t/t1?=
 =?us-ascii?Q?L0ehckUWrT/AYLtzygFIsr3mjbHvKRrnojJol8W3UKGqocpQAho7/FKIUCsh?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OoP5CFeAKULm24aMGQKM2ti+JaW7KkucYclPlq9oRXS8Tp1BpY78GpwJiDFd?=
 =?us-ascii?Q?VzQP93qe+1POpglSoC52k2rluMGF34RXDUJR7CXlnigWueli8dx5ruT0F4uI?=
 =?us-ascii?Q?n1uvHm3FVY4DkMejRzWtRDe1zkZ00tPrpw4U+LOFrOaMZn6E7qHBBrXY9gzB?=
 =?us-ascii?Q?0r7CUTpIPBo4uPZgk9L1AJN1kT9nBHD8AmBzzP1RCwugai/mFcBfrMwUtdMV?=
 =?us-ascii?Q?csZHXBGVaOPaXEorVejva49l0wkSNRLn95RQfgTBL1FmbH9+wYVAUyOv5/3u?=
 =?us-ascii?Q?P24g/cd+ieZQwzeEOPPLh9UXv6g7R7M8+TDP3SqqFGvHLwN8GEiKYTBV7FgU?=
 =?us-ascii?Q?ZCUXSczvk2Uz0ksOgfSn7pBWIlR8/CeeT4RcgM10zxgNqcZEyZDhXrr1nczf?=
 =?us-ascii?Q?tASDfq3ji8lxKRPaEf+V4J1l/EyiMgGR+Mq4/b0Eo3gW9jx+RUWj+17/aaet?=
 =?us-ascii?Q?q+vGMiJfMEXLQODdyFwj8SZrRp2VjMVmptlAh/JPzQhVIxRI0/p61H+pxAIS?=
 =?us-ascii?Q?1J0L9wqvGNaJQfKG8UzqwEl5w+Y970iCHwusGpNusQbRWJx1aWYO2Moy5Evz?=
 =?us-ascii?Q?k4Tc208rHVLgPV7XTviuhMOxOTMZkyypijkwZm7o/bmOS33uD49UO+GN4U1x?=
 =?us-ascii?Q?GpGGb8MYjyzQetDcXXn1puYLuq+sZQ5Pl5fJQ5L7ssQ6zPuMMNdHg2PDCt5h?=
 =?us-ascii?Q?pfq+ZGVKz2ocivTyAAUnRrzKwdKR/gaTiQZA827qkTRPpAcVBRlzjYucjGxn?=
 =?us-ascii?Q?em5m+7KyYJRTiHTzic4DwxdhfOvO648OZ6akNAGNzNWsBx2InmgnsEvppiTj?=
 =?us-ascii?Q?iGd8HEaYv1II2Lq2pUeJ34UZxeqXt4mJr/abwFPAiTsbroYV72GJ0YLSvts0?=
 =?us-ascii?Q?4sW20pzuefS8nUZ3ZKK5/l1uKGkASrcnNyqA58+OgMTX5zEwheyQbpo56Clx?=
 =?us-ascii?Q?a+mZG2NzQv/oAjmIShYasb9NJW2AwEit7qA1cUNAIdP8R2Ahm38n7gAkyTzc?=
 =?us-ascii?Q?gLfwgBkavXY/N57dm1ONghHqsa4tgnO/kAJ36AXMZgoYPh0OwZ6010puHC0s?=
 =?us-ascii?Q?iFncqQe0UlASh8O2QQ36jAFImetEWZ1VTk7LD1Fcj9apTfn87G5has7e6o5P?=
 =?us-ascii?Q?5mxjY6FgL6k+b06GclxGjMjdWlIHcSESuQ4KyuHRWGoAeN/brNsa1M0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492f5e03-40f6-4637-a092-08db3714b170
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 03:03:42.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW6E7/FODWWcGFeT2Gj9g8T+IZzhpcLeZ2I4MexmxPlBBaNiMWQEXYT/FRZ3BLzAtT03KjkSb+bRGf09l+W4Z8AWygKeaZKeR2YO0HhWP0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070028
X-Proofpoint-ORIG-GUID: YFtDAr9Jmb8kk7mR_L55dGBlTOfQK4hu
X-Proofpoint-GUID: YFtDAr9Jmb8kk7mR_L55dGBlTOfQK4hu
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Apr 02, 2023 at 10:22:28PM -0700, Ankur Arora wrote:
>> Change clear_page*() to take a length parameter.
>> Rename to clear_pages_*().
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
>> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
>> index ecbfb4dd3b01..6069acf6072f 100644
>> --- a/arch/x86/lib/clear_page_64.S
>> +++ b/arch/x86/lib/clear_page_64.S

> So it seems to me that clear_user_*() and clear_page_*() are now very
> similar; is there really no way to de-duplicate all that?

I'm not sure I see a good way to do that. The clear_page_*() variants
are way simpler because they don't do alignment or uacess exception
handling.

The innermost loop in them could be unified -- but both clear_pages_rep()
and clear_pages_erms() are pretty trivial.

One place where it might be worth doing is clear_user_original() and
clear_pages_orig(). These two have also diverged some (clear_pages_orig
unrolls its loop and uses a register mov):

inner loop in clear_pages_orig:
.Lloop:
        decl    %ecx
#define PUT(x) movq %rax,x*8(%rdi)
        movq %rax,(%rdi)
        PUT(1)
        PUT(2)
        PUT(3)
        PUT(4)
        PUT(5)
        PUT(6)
        PUT(7)
        leaq    64(%rdi),%rdi
        jnz     .Lloop
        nop

inner loop in clear_user_original:
.Lqwords:
        movq $0,(%rdi)
        lea 8(%rdi),%rdi
        dec %rcx
        jnz .Lqwords

Maybe something like this?

---
 arch/x86/lib/clear_page_64.S | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 6069acf6072f..795a82214d99 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -28,36 +28,6 @@ SYM_FUNC_START(clear_pages_rep)
 SYM_FUNC_END(clear_pages_rep)
 EXPORT_SYMBOL_GPL(clear_pages_rep)

-/*
- * Original page zeroing loop.
- * %rdi	- page
- * %esi	- page-length
- *
- * Clobbers: %rax, %rcx, %rflags
- */
-SYM_FUNC_START(clear_pages_orig)
-	movl   %esi, %ecx
-	xorl   %eax,%eax
-	shrl   $6,%ecx
-	.p2align 4
-.Lloop:
-	decl	%ecx
-#define PUT(x) movq %rax,x*8(%rdi)
-	movq %rax,(%rdi)
-	PUT(1)
-	PUT(2)
-	PUT(3)
-	PUT(4)
-	PUT(5)
-	PUT(6)
-	PUT(7)
-	leaq	64(%rdi),%rdi
-	jnz	.Lloop
-	nop
-	RET
-SYM_FUNC_END(clear_pages_orig)
-EXPORT_SYMBOL_GPL(clear_pages_orig)
-
 /*
  * Zero a page.
  * %rdi	- page
@@ -92,6 +62,9 @@ SYM_FUNC_START(clear_user_original)
 	jz .Lrest_bytes

 	# do the qwords first
+SYM_INNER_LABEL(clear_pages_orig, SYM_L_GLOBAL)
+	movl   %esi, %ecx
+	shr    $3,%rcx
 	.p2align 4
 .Lqwords:
 	movq $0,(%rdi)
@@ -135,6 +108,8 @@ SYM_FUNC_START(clear_user_original)
 SYM_FUNC_END(clear_user_original)
 EXPORT_SYMBOL(clear_user_original)

+EXPORT_SYMBOL_GPL(clear_pages_orig)
+
 /*
  * Alternative clear user-space when CPU feature X86_FEATURE_REP_GOOD is
  * present.
