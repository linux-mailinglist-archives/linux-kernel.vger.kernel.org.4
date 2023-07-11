Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF54674F822
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGKSuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:50:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845E1BB;
        Tue, 11 Jul 2023 11:50:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BID480015550;
        Tue, 11 Jul 2023 18:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FIzSJDfucPBmHe2Fuh9eOX4Q25C/kqGzYMTAouhgnvs=;
 b=Tzd51CbfvIwphci8aiOSCb8+AOG6CFdpmBXFADIPR9myRvZwlQRKrrgsYEt7s0hlG1pi
 StVgtX1TObWNJ5rO61IRZnWaDQkB0bU0/Ck61DxWZIYTkuWOEs+Em/HWJ/L/SgQHleLk
 fskc0r3Yq9AM+ZIIBh1zhlgOgTtYnbqZrxNg2lt0S/LFGE+qoPNtBns1rQnagBTI6mh2
 BB6KNgULpgCG0Mm1WipvN8cAChYPJ9IqqZ6adCkYUp65lokJj2c0Hu+t1YiIgLpZy9bu
 rS5lRXZirgf6xfgjwFEP2b4rZdWy7zF82Eak6k+6Wcfj5TB8h7nJlpC02t77Ul8N5qRE zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xum2uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 18:49:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BI543x000602;
        Tue, 11 Jul 2023 18:49:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd29jp0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 18:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IquGkFi8Vl5v6JR0VWyReI/+IAE2P7Q4kuuwi8FS8BtFbQC3iYehKNLXH664t2JlWjBkr8STdESxOPbMwFnvucvMhEcqJm73CVYWpTBjLMTXLHExHaXGzwrCk7Gm1ajfsq0le3RE5jH/YJ2JgWfPXrodXAYq5E3EbZkmHzdgkEqOE4hZTsMoybiNBwCszhkZnnuSyJ04Sfa0CWMFwuxkBHhkol2kPHdJ/39cXyabilXmopftiDj/FA5ZHFWj1SmMae2eM9Urryyu2fIdCiVKorNc2wyh8TXL4Z8vuA+MYAu0q4tipqhzDEEM00O8T4Cw8MCgUCySIwjKpkWlfDLRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIzSJDfucPBmHe2Fuh9eOX4Q25C/kqGzYMTAouhgnvs=;
 b=i1/u8t1yDS3U2BnQgOihfZprfgJdWrXCkDI8k8XrFJG3/xuwoJbJC7z1IBuf+n8DLqEO/2bnPQ/4nHP5kREZOgs9ji/ZLzjjw8hWeMHwu0t556cae68pwOyTpjnGxPzy24gAu1/kmPnY+Ex1FLpK05NW/ccdYIOHu5HpGBfG6gHMjU0lHJbMRHqrRdr0gZYFHdCRsQHUmClQ5ScZyiKbQyiPeHFwcbOI6HvnjFEDYUs8iu3VKa43Gucp2+BJsrZ95OuQ6xdtTVQWMNPNDpb/aIeS10yEiR8h0HOeQZVfDr3oZJuxQuq0u41rjsIKmP4x0Ipa/pHJcgxhn2JeGM7wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIzSJDfucPBmHe2Fuh9eOX4Q25C/kqGzYMTAouhgnvs=;
 b=fmtlfPPUJacNJ9a9x6z/kZZyye2bJwf1vinvP+BwGdoBiK+cc1b6vZ8Xf6zjFQ0oj1H9g1/4mpRAaqa7JgdB1u3cSbGR7pi2SPjn1xWS8tZDG7YrdVmA9+pCqUxfD9qd7u2k8hO2bF5AuR3lnHwaPTiIVPBKnKdx99vyBgpt1G8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5562.namprd10.prod.outlook.com (2603:10b6:510:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 18:49:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4c83:52fa:a398:11a8%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:49:45 +0000
Message-ID: <b6595438-bb85-4a08-b491-559bcfc30376@oracle.com>
Date:   Tue, 11 Jul 2023 13:49:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for Jul 10
 (arch/s390/kernel/machine_kexec_file.c)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230710113814.4a4916cf@canb.auug.org.au>
 <9536c8ca-a0f2-c4be-d705-2ac1054ebf7d@infradead.org>
 <8a848504-6e4c-ba7a-4777-3175c1fdc6d7@oracle.com>
 <903448cf-b333-cb75-87e2-4bee8d1d915e@oracle.com>
 <5311ed1b-ab09-6e9c-4ca6-061fe0201de6@infradead.org>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <5311ed1b-ab09-6e9c-4ca6-061fe0201de6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 71913ebf-43bc-478e-757f-08db823f9849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3NRQmYeU74HtvgnQgKRCMO2frT/sReSGTjiljeZsZHrQbX1djKoyn5f5SD9aViGdxjghXTbM9C+gfteSDphWLbZqSsozUxvJdu5cEI4ofclJMCwmPFnt4N+bitr8g2/P2IkclR4KRQjzEk22EqckWIlFYDkHPFFDqPnIZ0cOWWwMV5DhTmn8BZDkFwlPoadV8wjJP2w/Dq/rYimlaXsI5Ent0951Lf2LndLjj5Px1Gf/tO/pZ7YXf5t58DlLtE8Clhw0EzBLiLWPyAb9CVbWjIpoRtL8vQ7e4HGN0DGKNJQbDiGMKtuv50V5OqQD5NEb1XLHpxzxpYg1/52E8A45tmDfluf/SC5pNXgcp3LZV7cUWSZuNMeylYuIGeJfThN8aiDPCsbp7TKI31mW3J/cuBwH7bgoKfwqdO07UPc8yKk8/xUn2tzIPuV8NK5/5pVAdAQ1Bq9jjZepwws0q1H9g0b9OJ/a991xUegmgBKhTJsn9ph2HbFODdCHB2YbEB/D3exGWST3CGGh64Nw0sceQj7uV5wPCJQItaWbdWq+KV/Q+Zx1moIaNP0et9fPOULGmaUBH/aC9Dc3dOG74dM9ALS8C+Vpk236Y4UtsWCGxIkFL8pvxnuPdTZxhD0+/2K29YAKTFgf/RXHPcaihvRyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(110136005)(478600001)(6666004)(6486002)(54906003)(26005)(53546011)(6506007)(186003)(6512007)(2906002)(66946007)(66556008)(41300700001)(316002)(5660300002)(66476007)(8676002)(4326008)(38100700002)(8936002)(31696002)(86362001)(36756003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODgrZFRtbms0cFg3WllrRjl6Tkhhc2szRHFrYit5cmUxT25wdEEvV0tmQzIw?=
 =?utf-8?B?K0hIQkhUNi90L1NrK1lQMFZvWFJzT1lsdHZON2ZOZDM2aXFWbE9zUmlaMlM0?=
 =?utf-8?B?RlF4cFR5L3R0eTJYQjFHcHkvNHhTenpEdFNiUHJQK1pwR3p4VENJR0J0endP?=
 =?utf-8?B?Q3BKTlJESEl1dXhFRUJWOTJ6NUNneTIwOW1WK0k5MkFWRWFhWmJ1UVRwekEx?=
 =?utf-8?B?OHBGamlsa1BjVi9oWkl2aVdCM3R4NzdHZXZaTWNtcWRRKzV5R3RzL1pkK21B?=
 =?utf-8?B?WWRrZmJ0NEtpK3VzeUJ5RzVORE1abFVxVWZMVUh1MGlVeWZkUTBFM2JqQ05E?=
 =?utf-8?B?QTliVlRsRWd1bCtTc1BYVUtCSU8xS01tVzQ0VkNhZW5tRDBkNmNxcXJzaWlV?=
 =?utf-8?B?SnN4blFMZzdUdFVOZ0VPeTFNaXEyeXcza2ZWN0s2YUdadjdJTm9mU2FwUldp?=
 =?utf-8?B?RUJ6dXcyNnFUNGpaNTVDMmxZcjhkc0xHWGU3cjMwNVA2WG1aQ1MyQ3E3VU1l?=
 =?utf-8?B?ZU5oK1VjOCtxaDFCMkdKUnNwaUp1VEMzaGVrbWt1MCt5UytmSXNEZnh3Tyty?=
 =?utf-8?B?NFM4V0hpMmc4L0JkNFViTFh3NkZhb1dPR1VacmxuSTRURmVXUmRXd3QxUGxj?=
 =?utf-8?B?ZVhPU0JoS1ZTNU5PWUx2SjdBZkxuYTdrLzh3Y3NWUW5jaDhIOUtieDV4dGhZ?=
 =?utf-8?B?ZThRb3E2NVhrL3V4dnZ4L2MzZ1NqbUtrKzZ1WlpySnZGZHBrVXRBN3hZOHcr?=
 =?utf-8?B?bGFmMVBFWE9SR0V2aE53YUFySjhZQ3FrODBoUGwzWURmRTEvNUlZYmplZlA1?=
 =?utf-8?B?b2lvUUlOZVM5cTMrbGFpM0pCVjZ2QzI3S3h6NG1oQ3k2QkpLMGlsL0QwK3BX?=
 =?utf-8?B?b2h0aysyejR3WnVWYmFLZEt3WllQUGF6eUM2ZXI2MFF2eUZ5aW80RmZEcTlT?=
 =?utf-8?B?K0VQc2xKRzZNSDFDNkl2VEQxbWQ2dmNBWWJMRVhTUW9RZ3RXZ1NSTTRCOWlY?=
 =?utf-8?B?V241VU56N0ZXUHZGdUplUDJCV0xUL1RhZ3RocmN6ank4bHkzY1lET21Qb212?=
 =?utf-8?B?eHEyZ0h5UmNRNDhrQ2RmeG9CTitoZ0UzR09IOHRscXkzeVBHSE9PV3hqYjAr?=
 =?utf-8?B?OFVCa2FhSzRqenFrZDY1eHpuNjZJN1Q1WEF4cytlUkprSUdnMTlodnFnZFlX?=
 =?utf-8?B?cFE5STNjeGlzQUIrQmJCYjJ6Nm5TQlBwU01pZFBzZVM0UDJ4bmk3RlVRMGJk?=
 =?utf-8?B?R09uRy9wZ1hFLzhuYzA4ci9jRDVsVXFDUWxCZ1ZjTlRQVVRNOGVGa1pzZTcw?=
 =?utf-8?B?SUZYZ3duNHg5MzBuSkhSR09GVThUUmxycDJGWUxkQnFEejhGQStKdmtRZG1x?=
 =?utf-8?B?Q3VJTnZOWWFGMFREYUEzVDJoMGNXU1hGeDFwbmM4TjJwbzZIWVNxNml4OTJs?=
 =?utf-8?B?M3F3RkZWUjNScTA0TENkQVB0MVF2WDZGb2ljNG5OMzBQZ0NvRjd4VW10eDNW?=
 =?utf-8?B?Y2xuQ0RPM1Y4Snp3TCtPU3BFMUZRbitRVk5UVmZ1TDZwR1ByL01IejJhdi9K?=
 =?utf-8?B?UHZNY29hYStldTRaRDU0b3FzV0dmeXFzU0RpbmRRT0VzSUtNQ09hZlBTL3Vz?=
 =?utf-8?B?SE9OMFFUV05sNmVvSmZGcCtycnRRU0dGekY4MEZVcWNEWnBBSXpqd3hxczY0?=
 =?utf-8?B?NjA0RnBxanJSUVA0OThZS0o3RDg4cXlKMW9kS3MyZ0VMNjEvaHR4TFpSNWxS?=
 =?utf-8?B?SXRDWExDNi8zRTFtdXZlbGhZVC9IRC9DS1h1SDdQVzFRaUVGNU5CR1B4dVJL?=
 =?utf-8?B?RGd3dGNUNkc3VzVXNll6V0M2QnVmK0pjMUlFaHVXV1Fad3JzUUpNUjNDZC92?=
 =?utf-8?B?dmlpMW9XN2FtL0U1b3NkeVRiWlNWWUEzcktpcGNWWmJHR01FNlJVc0ViVDQ4?=
 =?utf-8?B?UndhT29wU1J3cDlYWXhheVU4T1RMZXB2WkJXRHlORDRPWlBJNndZNDdUYmw2?=
 =?utf-8?B?WjNOUTMvUmRoZmordE5TNzIrKzV1VVl1UWQ0Yk9CMTlJWWIyUERlcVB4VFpW?=
 =?utf-8?B?b2ZSUDNmdzJUZHVFbHhqYitkbnJiSm1mWUVZNGs1TGNFdGUwVGxNQm8rSzNC?=
 =?utf-8?Q?I/hBMI4+p/ukRrgol4RQ8Ib82?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +w4o9U9hGzFSKs+5nZbXGJ7FmKkn3Bg6W01SHObValBmf0B8uUzVq3XA1oibiKnU0GmHFroeRP6bph1TjemDi0DQHEO1mBpyuBUGm3OLjAgN1L3VYnOWxNaO7BOleMlfVv/mf2JrGcwYS7TpDcG0Rcg9OL68MK8r6OlKPsvctKAj6u7gNzbVbZaqNvZoRONui1u3EY8EQbDafe60fly+Eqn/LPozFe3pzC3vuL53VgbHB1qNhJKZJ2a1xaIF0HQUAXYEKO6Cq0xiV+z/VBU61j9nJSRBTRd87ECQS4JVUKilVqiBuV75ffUpmOgGtYxoT29TXH+vgNZZKcMMYsVMt3Fa5L7Hxw07zQUchUfc1b+p1DzUzvxoj1oBgEp+nqr3ED7W00wvHWtU3QlbHU6xjYJ0/46Za4zmqekqfJuWPogLtB108FhD9tSA3MVJsFOwztJE/u3PTEiFs7jzxscRKxZLgByo6Az9ZUKmywXmM2BDCqYwi/ATJAo/JrLingfNsnmQIevPcrQdU+U6Je38mnltSE2YvIC9xDDQRAW4VMTLv7QDIgkxGguoefqUyDAGf7O6XwsEVkBmnXFSbZYGdhlhWg8VuTQH578w3kehEgvM758wIiavjFBuhjJ3NDf/pPiO7B9C+zxVPcEOTvP6VxEKM9JdYAYRhXpATiNxBdRo+5rPzP2xkaVZb8I82jxWKvAEo899/SGU7Q79XW8qt3xL7UPxPLcpPY85t+SMuf+7ND59zLmpwwXcwECVzQ+ht7snyamm1oxPHdf3Fb6agOcAzmxx+xLm+XdqR1bJit/K4g8NpcsT0TCUlrZbumk6KJNU+urR4yoXSi1XePxSljkw5+VVktqbYZAwj0Zumr8roUmgTcfijo20trhFVRamyrYV1yihJh4eotPX4GBB+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71913ebf-43bc-478e-757f-08db823f9849
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:49:45.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ifOzoF7etHCtbsEy80+SEv99RgmpO5gK2rrXIn0hgxV8ny1SEVB4tvZa0ymSDsWb6sNiZPAA/e2EkldMLAqUs4ej3w5Kfm4v79iUax1A2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110170
X-Proofpoint-GUID: 1ehWAaqHAqyyDtFzABEszoQKI9770cee
X-Proofpoint-ORIG-GUID: 1ehWAaqHAqyyDtFzABEszoQKI9770cee
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 17:15, Randy Dunlap wrote:
> 
> 
> On 7/10/23 14:27, Eric DeVolder wrote:
>>
>>
>> On 7/10/23 15:23, Eric DeVolder wrote:
>>>
>>>
>>> On 7/10/23 15:11, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 7/9/23 18:38, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20230707:
>>>>>
>>>>
>>>> on s390:
>>>>
>>>> ../arch/s390/kernel/machine_kexec_file.c: In function 's390_verify_sig':
>>>> ../arch/s390/kernel/machine_kexec_file.c:69:15: error: implicit declaration of function 'verify_pkcs7_signature' [-Werror=implicit-function-declaration]
>>>>      69 |         ret = verify_pkcs7_signature(kernel, kernel_len,
>>>>         |               ^~~~~~~~~~~~~~~~~~~~~~
>>>> cc1: some warnings being treated as errors
>>>>
>>>>
>>>> Full randconfig file is attached.
>>>>
>>>
>>> Randy,
>>> Thanks for this. This appears to be randconfig testing against linux-next.
>>> As of right now, linux-next does not contain the v5 that I posted friday.
>>> The v5 posted friday was picked up by Andrew and over the weekend no fails
>>> discovered, and the series currently sits in mm-everything branch. So hopefully
>>> it will appear soon in linux-next!
>>>
>>> Let me know if I misunderstand the situation.
>>> Thanks!
>>> eric
>>
>> Well the root cause is a missing SYSTEM_DATA_VERIFICATION. This was discussed
>> through MODULE_SIG_FORMAT thread. I don't think v5 changed anything with
>> respect to this issue, so it will likely reveal itself again.
>>
>> Since it was agreed to drop MODULE_SIG_FORMAT, and my attempt to select
>> SYSTEM_DATA_VERIFICATION results in same circular dependency as with
>> MODULE_SIG_FORMAT, I'm unsure how to proceed.
>>
>> The arch/s390/Kconfig S390 option has a 'select KEXEC' (but not KEXEC_FILE),
>> maybe we consider adding a 'select SYSTEM_DATA_VERIFICATION' as well?
> 
> Sure, since some other configs select it also.
> And as long as it doesn't cause a circular dependency problem.
> 
> thanks.

Randy, all,
I did the following for s390 and it "works", but I don't think we can use it.

Changed:

config ARCH_SUPPORTS_KEXEC_FILE
     def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390

to:

config ARCH_SELECTS_KEXEC_FILE
         def_bool y
         depends on KEXEC_FILE
         select CRYPTO
         select CRYPTO_SHA256
         select CRYPTO_SHA256_S390
         select SYSTEM_DATA_VERIFICATION

and this essentially passes my regression but for the following:

FAIL olddefconfig arch/s390/configs/defconfig
LHSB {'CONFIG_CRYPTO_SHA256_S390': 'm'}
RHSB {'CONFIG_CRYPTO_SHA256_S390': 'y'}

which simply means that the CRYPTO_SHA256_S390 is always built-in, whereas previously
it could be a module. This happens because 'select' is always =y; overwrites if
previously =m, as was the case with this particular config file.

I still don't know how to close this gap. Today I see linux-next has v5 in it.
eric


