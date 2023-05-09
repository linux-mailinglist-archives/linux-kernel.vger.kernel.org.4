Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB9E6FD2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEIWrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIWrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:47:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0817459DC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:47:20 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349KHk6l005704;
        Tue, 9 May 2023 22:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l/eIVwRYUGvw4wNtYxX2ekfjm2TLUWV/+B2JoByuuEo=;
 b=fpmPjRv5q2Eq3xB1UACfeT8YWTB2s6Km1dCGXtU3mT5khNfy80wDKp6z9CEwFcWcSbOD
 YNxu2LZXRYLLCQTLVZLHbqgZl/k0+fw417HO3Dtev3RTD1ze6oLyykHpA/7s9S26F7cx
 SXprULKn9dNJ1mIA+vOFdivPvudniH2/FyR4W8zdskY4CJwPWfYPK6VamVeSWZSpObmN
 BrDtYPNcCnr84Uae6nx/HChzJrS/OP/LTqZly8RmPEb82INOXoKln/cYA1KfYAOJXmDZ
 U4m1rJQYeIR2Xsdw7DxTv/a0SX2zEf1uqqhKk4lpfNYvu6E+tvtWRVpfoPoJcII1kF4I Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77532vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 22:47:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 349ML6EG039339;
        Tue, 9 May 2023 22:47:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77gmk4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 22:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfEGnzC78LxOhquyCDbfXJ2kM6/SkEdlv1SAX2T9bS3e9EeivA6ByQ3xEm2gaILBulYTdpJKhTyDPYKWj61fcN1nHdTw4g1QxkWJYW8cLIGn8TSAl6AtlIho/Y1Bqx4uittBTmmnqbemU0PvFCyPbH/qpFqGEQBGdfkqT/8SLUa07HgD0jHlDlGxbAXDdNnhX6RPllT0ayQAJBFI8WgC3MjdBbEMfrgItS/+9WZ+uk2wEtZ6BDjvY2cFHuk2RuvwRwzSD0n2f4uESmtwaueebLMvmD9s2FEa9wMXlkKPaPT/nOVUAeuLKAHwtck8YaP+Zwfmqlwsh6vCpxiWy1hoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/eIVwRYUGvw4wNtYxX2ekfjm2TLUWV/+B2JoByuuEo=;
 b=MmvDjmm9iLU0HxxpHb1iBs+G4bWfGJgpP9JsjpFVJuum4oYcXjv4KBcR4lkX80ZVvK7rNyjynaPHjGhAcIodDCCSwlt9R8meZ4uUDuzB31CfsQbgm2hvjRa7mLXilErgnf0vkB48JNdzT2rcjYjzizicmKpuKakEi1VYpwl6yqAG9FZ3x4weYVWvS/y9wf9D5tngbPld7zSlRZlbs3H5aso7DL/b5L3vKLcmvGhRhIxrnivUkbE+XV9HsAZ95aJ0LM3AGsXCrtxHCTvoMvzimYVRpQ8Ql/sBmRB+cONCtXcT7v/fSvDca4g4m3X4VlqqeW6buQAycp63rgucJpImhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/eIVwRYUGvw4wNtYxX2ekfjm2TLUWV/+B2JoByuuEo=;
 b=W8OLehXU/mQ3Z5oKWDWxxc9JOP7KWDIjEWMzJTsKN1NNQ+K5Doap9zczjydKI8veScRtnibMSKyr1vIUXJPObUB+4wPrNaEHVjWoXAbEl7ZVj8o33ui2/VAVwFf73q6HKUJBvblbVaYGT9rIn2Hd0x9trFZvBt/9Uk3uCJioo84=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 22:47:11 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::f942:ba2a:1330:244b]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::f942:ba2a:1330:244b%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 22:47:11 +0000
Message-ID: <2d0ab154-596e-437f-1575-3d25fe421b86@oracle.com>
Date:   Tue, 9 May 2023 18:47:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
References: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
 <20230509111646.369661-4-suravee.suthikulpanit@amd.com>
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230509111646.369661-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0474.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::11) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 587ab4b8-7737-4fff-c2a5-08db50df5379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8dOw170mrqYXiYBM7x1s7fnHKd/VOY89NeUZrzTvJsmqishBeT0MLALQybckPdUJFKalgC0Il/JSkL8M0Uq0f9pFdCPX+rrbRAM81/VAiJ1bPjnxgv0vbF2ih5XfJ/VstI2yFaV6pBmdkUPhvO1tcSjPtXdjj8KcPSz1sJW5GYkF1H0SO0cIQFUljwYQSLrLgwNMt4H/Rjf3v0AiyXopf7rN+1tRcp7qbKZTUMd704H+8PYehnR5KcNQ4k4TiVpxyRr3eC0uaEc5Ysv0o7UfOHmObTVtjYowRGs/6tBKF/plv713YGD9hOxMtY/EH6QwEZ+9gLqhDRB+facgK7X+gq6zHS16ybIVJ47HiZrHllG018GIxLI5YbhKYeuiJq2EuzQq1RvupphbMch5jYsTZK6jWWZhh0ki2Qs4WPdIYdpRDYgjYuhLdFcxP2b7R+Olz1oUhgEmpjBkrlHPIz5021Koi6X+fUt+MwUa+h7hOjMH8iWg4X88Md4FjiqjMiox2TotYGJP33Z6Dp/+pU24uAbHeEgeeBHlzUYOP5HQtoEJA3ywore5ILXKdQfQwadzEs1OoEjAoCEuB0BPrnw3EDzZmfoxfC+hNQinExvR3fWKGVuGZStNoJkFmU0smx+KkfaBz34Ux2WNqFHXQ2now==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(478600001)(31696002)(31686004)(41300700001)(86362001)(66946007)(66476007)(66556008)(4326008)(316002)(8676002)(8936002)(6666004)(36916002)(83380400001)(6486002)(36756003)(5660300002)(38100700002)(26005)(53546011)(6512007)(2906002)(6506007)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmx3UnI1eisyTjlFY1locE4rTzhqTTkxdWxOT3FkeGs0VklOck95U0ErQ1Na?=
 =?utf-8?B?bVVmSnpMdXZ6WEpmYTFlQjRqK1Q4a1p2eVdyMTlmay9hVXVzM0U4aU80and0?=
 =?utf-8?B?VU13c0VPQXNOaE8wWnVqditaQ0tJSTdUUFFTNDRzSjQ0anByUmZGcTdTZ1N2?=
 =?utf-8?B?T28xQWNTa0hEdTltc05yZlBRY1N4WllzcVpCTCtQd21mdkRQdWswMkFHR3FI?=
 =?utf-8?B?VkZONkV3cmFsSlUwSklYS0FOTlpyVTJTM2xORjVjOG13dDIzMU00cDFHaXly?=
 =?utf-8?B?TDZ0QmcyVWxNRXhiNW5tM1Y4QnE2S3duQ3U4em1pNXBDMGdhc0p6L3BuNTI0?=
 =?utf-8?B?aURwRzMrd1hnazlTMDh5VmNZdXNBYkR5dEhyNkgraDdGQ0l0UXQ1L3lOYWFI?=
 =?utf-8?B?OUVPa2xycS90K1lweUlwVWx3K1Nnd3Z3WmNyenFoUlRWaFQydDBLY0Zpbm9x?=
 =?utf-8?B?YlVNdzNFTk1IdWpXMm9za3VJdzVWYzNJdTUvVzRXTHQ2TzhRbHc5M3ZHM1or?=
 =?utf-8?B?V0dEUXVaY3FNcmNpaUVNQWxuTzhKanpIWE16TWZZMDJBYVUyakl4a1VaU3Vi?=
 =?utf-8?B?UnZnMHNOaGx6S2xKdTN4WEswc2Q3OGFmKzRlMk01SjUyMUVIaEozVXdXTFor?=
 =?utf-8?B?QUp2WkI2d1I5ODVqY29RcEdFUEFMSzJhelBEOUlhaVI1VVNvQVQ2WGd4TXJq?=
 =?utf-8?B?U3pVODY4OUpENm9aMGRuVXBmSnA0MUJzTjkreWVWUWVYWWQ1cWRIM09tVnlo?=
 =?utf-8?B?SklpNndVTFFGbXVYeVd3eGZNaFJuSnhyMU05dnIzaTBnQ0E1YzlUKzltVVdv?=
 =?utf-8?B?ODhEcENHOE54Z0VKdmM0QnhXM2UxL3JYOGVNV3ZRZ2x6bitVdzNxbUxZcXMy?=
 =?utf-8?B?ZWljQmttL0h4M2V1bzJIWGZZOFY1dDRGVzVUdk4xTTczQ0tIUmNGSjhibTFU?=
 =?utf-8?B?MXFDZFJZUEVSbjRKWmxoakVXYWhBdGh5MjV5eTQwY015ZUJkYnVUQjIwSWtV?=
 =?utf-8?B?U2R2ZngxQ09TZ0pja2hEVmYxN3VCcVJhMVl3SXBBajJuWEQrdHlMamdmSGti?=
 =?utf-8?B?Q0lvcXYrdlB5VWVCM2JCVDJsYXdYdjZPdDNmTytXdlpienR6SU04T3dGQVBI?=
 =?utf-8?B?WWdvT1MvNnFtUFBzMjEvS3ByWTZ3SWNOVkFxNkVxMEt1ZGJQUGtXQXFpeFRE?=
 =?utf-8?B?QStxU24zR2hFN3FSODJEM1ZCRUVZQkk5a1kwSUUxbEVJYldSYUlsOHgvN08v?=
 =?utf-8?B?ejMxZG1SanEyZHNuZ1B0dXFYUHp1NVhUZEx3WGF2a2hoeXdvUGFaRjU3N29L?=
 =?utf-8?B?TjlhMVRCTmtiVUFPdHpjNGE5RDNIMTRMYmMrZkNYUjFxZk5VK1JGckp0U3M5?=
 =?utf-8?B?TTArUEhGMXUwbFpmenFRdExnbU8xU2VOZVc4RmxnSzVoRkhsTm1GenNxTk9w?=
 =?utf-8?B?cEVFK0I4WkVEeittQmhDdlU0TlhVdU5IRXl0RjdybGpHUG1lUmZVcXEvV0Zq?=
 =?utf-8?B?dklQYUttbjlLMnhkSlBjQ05wa2xlMlNyMHV5WVJRNFJEeHYvYnd6Z3FkRkkx?=
 =?utf-8?B?bUJqbmg1WE83T2pMZ3pEeXlxZ2d6TTNaZkxVK2tNaUNyczRuT2t3dnBwMzNt?=
 =?utf-8?B?aDArNGxLSlRJL1V2T3k0VmlYbG9kem1ML0UzZ3FWZDhNRzN3bURHYnVXRXpo?=
 =?utf-8?B?azJvYnNBU2RIVk1nZEZoczU0SG5GUnNDbnNKVS9ldGZZNW04TUhFZ0tEZURq?=
 =?utf-8?B?bkNBYnZjeGxXZmliejlRclR4K04vR2huOE15S1o0N1U3T0dwWUduWHFiRUtp?=
 =?utf-8?B?M1Q4cXp0MEZPNjB6S3czcHloTFE2TlNrWTlRZnFZdTRmUjR3ZUtOQWpObnR2?=
 =?utf-8?B?RFg1Y1hkdWdRSHdkZTFEQ1RuMExUYk5peW9yRlNDUEU3c1VqQWFNK3BpeURr?=
 =?utf-8?B?WGFLbWVJZzJULzd4VUdSTWtUOXNuZmhzNHM4VStkRTcrSFJFZlVZcmozZ0h0?=
 =?utf-8?B?ZHBydlRGY0NuK01pNFFoYi9ORDdYRGp2TEo5c1hnalpDRGRiZWN0K3VOY3ky?=
 =?utf-8?B?SUVuYW9GMGRHbHcwOXZDSmhMcXBEN3hKaElURGdyWUxudm8vR1d3RkhtZ2Z1?=
 =?utf-8?B?ZFpEUTE5MTFCRmFCV3hLeFRUUmtvbHRhNXVoRndQV2VwSkhuZXh2ZFFUNGpB?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dy1LQL+icHy4N70AXYppXAexEJI/+urR4UtRusw9so3mtVAHHOtjGTQ/4BNnVAVbcET7XKYr+9j52Yklw9hf+NJkN1g3dVphafL7im2sNoiLiQP6z4MJt2Vw1eNdD+nEIm/atI/E5T+vNeFbK+1bTINkG/FmDolpdjpi/y7M0tV5/b8bOBLx26d7VhfMELPN4P3CVPHX/gcFN18u+GiuiA4UY9RGFh+lRtBX9N9qnQCr/ukFHME+UpK8cpivx1WZvJbwVf8Yk4r+MzuOjmUQTHXCkNPWVp97UHRKihr/zcw28sr4gw3h77OX+/Vt5YZQKztGgJWpWyN3K5AK8CpgguAR99AJwVFr2C4+iVe/bsZXU0cM+5rpn3K/7Gt/d7nO9jvzPSP18Kk7HyixlWgOf30SbdOcqFvWkGVqg+HzGiNdxcHM8kC06lavlr2q9mFgVLYcMS+PeE0fuI/PdKF64bzszvHfQjAdcBj8jVVnUfZBX6o0R19EiWHJMO5A/nJVt8dCF3Ylc0nFEJ3Y2ghZAkwyRMvD2PkgUzGcSXIWqrwykrjR5A0YEHfnBCrtVV0R5GZAlz0rXL+HTnEvU7YwVYN+J/N0gj52a8W1eBkkVF+zz54jTszBO5C3iBypPKnF3YnsiDibO7QIyx14Yd6DdVKv7QjGEZyeMMWTXQ2vlup7l90Vttc3puv6yOf7A5uPu/muoghAAyLeSCYGa6mYQ8t89dVPHfKVeevLQ2UrqINsqkDM0pVQbp7mAt5QXSjhjDFpgfM/sNTbQl1Ng0sDxUdN/GgjzSJtQHkcssOZNZAhZD8UOQAPKoPk0H9yYjlmAuL1RSdcuqJ3AZaCdfmAksxulDahXynQfjw+gwsCmCNEPMiJW6NshhVTHJ9ZHD+Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587ab4b8-7737-4fff-c2a5-08db50df5379
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:47:11.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55gGKV36cl5xpaaZRrKt/nUu1nBfKTo1VCsokPzVATDgxRX7JDfKtUlkDL9wFKIBQWUd8UrUHmw8wvNglt926PtKH1xoHMZ+YYgDeVxKl1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090185
X-Proofpoint-GUID: Q5dE-tjADhR-S9K-T0mKQVofmCeyzxMZ
X-Proofpoint-ORIG-GUID: Q5dE-tjADhR-S9K-T0mKQVofmCeyzxMZ
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

A couple of additional comments below:

On 5/9/2023 7:16 AM, Suravee Suthikulpanit wrote:
> An Interrupt Remapping Table (IRT) stores interrupt remapping configuration
> for each device. In a normal operation, the AMD IOMMU caches the table
> to optimize subsequent data accesses. This requires the IOMMU driver to
> invalidate IRT whenever it updates the table. The invalidation process
> includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
> a COMPLETION_WAIT command.
>
> However, there are cases in which the IRT is updated at a high rate.
> For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
> vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
> amount of vcpus and VFIO PCI pass-through devices, the invalidation
> process could potentially become a performance bottleneck.
>
> Introducing a new kernel boot option:
>
>      amd_iommu=irtcachedis
>
> which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
> Control register, and bypass the IRT invalidation process.
>
> Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> [Awaiting sign-off-by Alejandro]
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   drivers/iommu/amd/amd_iommu_types.h           |  4 +++
>   drivers/iommu/amd/init.c                      | 25 +++++++++++++++++++
>   3 files changed, 30 insertions(+)
[snip]
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index fd487c33b28a..01d131e75de4 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
>   static bool amd_iommu_detected;
>   static bool amd_iommu_disabled __initdata;
>   static bool amd_iommu_force_enable __initdata;
> +static bool amd_iommu_irtcachedis __initdata;
Lets drop the __initdata attribute above, since amd_iommu_irtcachedis is 
used by early_enable_iommus(), which is in .text (causes modpost warning).

[snip]
>   
> +static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
> +{
> +	u64 ctrl;
> +
> +	if (amd_iommu_irtcachedis) {
> +		/*
> +		 * Note:
> +		 * The support for IRTCacheDis feature is dertermined by
> +		 * checking if the bit is writable.
> +		 */
> +		iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
> +		ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
> +		ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
> +		if (ctrl)
> +			iommu->irtcachedis_enabled = true;
> +		pr_info("iommu%d (%#06x) : IRT cache is %s\n",
> +			iommu->index, iommu->devid,
> +			iommu->irtcachedis_enabled ? "disabled" : "enabled");
> +	}
> +}
> +
>   static void early_enable_iommu(struct amd_iommu *iommu)
>   {
>   	iommu_disable(iommu);
> @@ -2710,6 +2732,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>   	iommu_set_exclusion_range(iommu);
>   	iommu_enable_ga(iommu);
>   	iommu_enable_xt(iommu);
> +	iommu_enable_irtcachedis(iommu);
>   	iommu_enable(iommu);
>   	iommu_flush_all_caches(iommu);
>   }
I need to understand better the code flow around kdump, and it is not 
clear from my reading of the spec that this is required, but shouldn't 
iommu_enable_irtcachedis() also be called in the else{} block of 
early_enable_iommus()?

Thank you,
Alejandro
