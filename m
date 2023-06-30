Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644B743F65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF3QED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjF3QD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:03:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A41B1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:03:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEnJh5030976;
        Fri, 30 Jun 2023 16:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=18FfTXuPw98bUMrn+a8RKWJwHwMZjQjrMaRwtbIHOIA=;
 b=mIBNgUnp0qk2W8fAHqdc1ZNhMbObkofpXxmgKr5+5D3vVcnmT6J3AOVePaVJJhcjvjLF
 RTRq6LacpgIcIOfdY2tGV34wmQ5XKzZshKuKPtz8BfBYUiT6VCuDU5XTT3UZQY+JaCFO
 SS3tnFmfE9SyD6k06UKoMwUS2IORkD6YHoUQo/IyPtmKZ3ZwqyTMhxekyeHiBNa4uaNU
 SLApBNoBwpps9ZFt3404WHmlgdkPsv1zqpE2mHuw4G++/+MknZVojXEBLtj3yLqfVlm1
 nAcvrlB1ZsxbV1fB7zhIA1QoNqSp5e7LCPiVXSdfgQtwZDDg+TfxJgj+TYE6b8A5bwQJ gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdu1dya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:03:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UF3gnf038194;
        Fri, 30 Jun 2023 16:03:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxfjqwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 16:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhpAWnxMlaHMTdUB6rAznpOxWBIRkGG+nsqdUIn0Cj/T8bbJK76qlY48L6qZBSA8DMy6mEZCxoM4X4gkEnRQvRXz2YMv8Hiut+QSkMayNBy0ouBEgXMGwq2rfQRg310qYRKvT5Gt4/hfdyri9NZWygK9N3ZIH/XAw3ZlszlVGVR6z0xmg3E8Cal/psykQhBHm/W+43x8Xp33KZwrlVJmrPdW5UOcvpTOyzpxtb/HMcJTv+96wOZANlNnREPmA2ZtsJnHp4TOBh40ruZ5TGRZ4YIhqwgHxSiAd4cbtZ/g7B/Z48yzszVbSB8j/4cv9HvGmuOAsl8I5fW7Ml5sc5H1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18FfTXuPw98bUMrn+a8RKWJwHwMZjQjrMaRwtbIHOIA=;
 b=VtqLZvjVlAGeU5A9vtlblKVbYWvW+MyBhjJM4UbIaNruKdutRGk4gFEDJOsVwHo7V6MQq+tAAhPKEYIkEkds8kYgy2Y1gt+6lXBcXWyd5e0RXpm7QE7GHOnOPQNixrP3Ng4qRgStr29vSxJhKIOnmdJh7s2T/u26FjEmO7BioHNQKhdh3/gVvX/FUgRcKwMt7sj2lyz3kdqdSooWc52/Hf5OHgbwA2hgQ4LEHPiYnim9anxpd5JPrJs4Elyf+1uYmHbRKDkzjhardi7K30ObevWt4Qk5PdhCAgwsz9zWJH2d3FUqACq2UrWmCn+bOZn8p1UKbFHuVGuNXgVNPGhLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18FfTXuPw98bUMrn+a8RKWJwHwMZjQjrMaRwtbIHOIA=;
 b=TIi6SgA4WgU+1Ki1IZzISzhKQEMH/Y9+EH/LWzy6mimVJbTBuD1E+MteQibINbq0F1WTBu1/DCepeiLi33FTYqNzTbD4TVcPwx2EHEy55W/yAti7y2kSLsFR3RCfjIa+d0pcat+XBPFVEtggF8wNvnBAREAaIzph7vTrY28Eg64=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS7PR10MB4989.namprd10.prod.outlook.com (2603:10b6:5:3a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 16:03:40 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:03:40 +0000
Message-ID: <b235b65b-3b1d-9d97-5461-b5a2ed4dfccc@oracle.com>
Date:   Fri, 30 Jun 2023 12:03:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] mm: remove page_rmapping()
Content-Language: en-US
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
 <20230630121310.165700-2-zhangpeng362@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230630121310.165700-2-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:408:4c::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS7PR10MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b5409a-dd42-417f-e226-08db79839214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AM0LYlh793Xujl/upe/GkIoPhUVcPHRRTRMDQgNyONR/LYyXQlDSH+rh1xU8HOhfmkIixFxFLuEuVkQt/YRc+drZgsuBGWFmNKRV7u6RFBwA42A9/bVpEhXioMVejSa5wNa80xVQc2Ffgtpg4zjcmzr7p4uN8l8UUlDfjJRbOtUB8mMg09F05lwNBf3c35Qj06soN1FVrmC6czbGGMXi5dWJ490iQOvlAe60CKkKBViNZV0XfuWaMcruelTFBCtHaJNSvPtqksQZgiAU6tDiZhQj3f0E+zPGl7p0P8Z7ka63lyLi/kI5Dc50gBY7IK70Zm2KPNcfQKZjpo59vLuG4Kn/UFw7BQ6fymNjPeuV8q66t2KZzGwwNvrsb9czZGAg5IZgL+c6y/QPkKIP0mkBQJIMLOmskLfqwBfVJVbNHTXpsQ39GnroYW7qRyxMCiNDh0aR//eFSusdRU54/N2lKGNyBYug20oRolGYIpHmDzlt+3vitst6fP0Lld/jAw6aJtSl4DC6LVqoDR0Xy77GOA77ABxEQp2P+GfO3iau1T0BzuCdrTxPDFqu58eQaS3racLkadh9jteY7oAj6MMcPcwHmYRjAfduISHUd5QIHn9jlPWNgm3Rd0O35a4yk/d8EpNw8sO+XfK7LQgM9VzPvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(31686004)(86362001)(8936002)(8676002)(5660300002)(31696002)(26005)(6506007)(44832011)(53546011)(6486002)(478600001)(66946007)(66556008)(66476007)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVQMFNmcU81c0hrQWUxcHNHWFE0czFPWEhiRWx6dDB5STlQdTFHemkrOTFi?=
 =?utf-8?B?OEcrcVpMSitPN213bkVDaC8wSWhSSGxnbWFZMUg4R3o1MG9wQ0JHWm1mc0Mv?=
 =?utf-8?B?QXEvUnRWYjliYnY4ZWNUaW9Ka3djM2htTDRsQ2E5bDdzOWVLMXZoTFlJOVlT?=
 =?utf-8?B?dFBiUlFsNTZDWXMyeEZ4N1JaOURWWlNWZzIvWHZ0c0gxOFpXcFlpcFRsZGsz?=
 =?utf-8?B?Ti9EKzAyTExqTEFCaHZ3RWF5MXhCR0RabklOd25LUHRRT3pxTllhd3g3aFFD?=
 =?utf-8?B?TmNGNzhMRjIySFRsMzVrbHIwR0RMNitCL0c0MU9OVmg3RGR0bmRTQS8vY0dD?=
 =?utf-8?B?VDJubEZqTGF2REx0RHFrZ20xYUE4dVhrdEczMzZ3NVppV21PVUE1Y2dicVFu?=
 =?utf-8?B?S3R5cFVLVWxKWXd0N2Q1UFBZVDZINVlPeGJYMXRvVWlGVnI4V2tHMW5BMm5a?=
 =?utf-8?B?THhHZVNFV1dFUEVMVThVNGQwc0U0bWhGZExWTjJRclNtYkZGejlpSkRZT0RB?=
 =?utf-8?B?WSs4ZGNuTXRaKzRHWXp0aTBpTHBRWVhwRE4yR0s3RHZqeDFRS3cxUzRZZ1VS?=
 =?utf-8?B?VC9NN3ZrN1BITHV2TkFuWU5QRDVDNmJPRUtZRUlIMFJmSktLOEdCV2ZSbjAr?=
 =?utf-8?B?dFlja3cxb1RqOTdPVzhRdXdXTU9zOXdyZ1FMNjFuOGpzWCtKL090M1JqM2Yr?=
 =?utf-8?B?T1Fpa0lCVkEwRlRQSmE2TTgxUGJYc3BEZ2t1QjFlMUFxNDBKUlNIM21kZFZS?=
 =?utf-8?B?eFVDSVIxbmxHVEFLQ3I0TXAvZmlLVkJ6b3IyMzdLSGt1VTBnT3EwbGFmYXB5?=
 =?utf-8?B?by8zMjF1SFFZSm8xRjhncWlxbnBFT2RHajk5Wkd5dEdramV4UUZkY2ZYVjVu?=
 =?utf-8?B?RXdHdUttMFZ0VnU3N05aYnBjRzA3dlpkY3RSYlFnWi92N1JxdlQ3bjI0ZUNM?=
 =?utf-8?B?K3EvZHhBaktmb3ZnN0J3ZDc3QXBZTTlkNERjUlFGS2lYblBmZ2tEZ3RETlFJ?=
 =?utf-8?B?dldqYmp1VzQxV2pFYytYK2VudDk0eGxhTGJSQnc5d3BESXgzaGtNRFI3d1p3?=
 =?utf-8?B?VWZ3Z2YxOWd4KzFwMlhrQ3JiU1dubXBZZ2NRSTFLT1lYRmt3eDA3VFpZb2Z5?=
 =?utf-8?B?ZnFXU1piWWxuQWRPWlhSaVJvcUhTcktWRjFmekRmUlg0cHpVZDcyUG11bFpm?=
 =?utf-8?B?RTgzSStOY2ltMklkREtUTWErMlVsVWdiYXN5UTNVczliSWM4K0NpWnBla0lW?=
 =?utf-8?B?MElhOWhaUlVNREhlQlFkK2I1MTM3OWgvcUZpUmFlVDMzSlNmWmpudHp1cXJM?=
 =?utf-8?B?dVhwSGFiamg5STlKL1VyU3V4eW10MEViSlVBcDNFS2ZqNitoTFVrbVVyeU1w?=
 =?utf-8?B?VmxHbncwRzlMWmppeTJvZkZiKy9IcTVOeFRPUTNmWm1CL3dqbW5YWmRzOG5m?=
 =?utf-8?B?VVA3SjRuYjZzdnJMWW1oUURQUEFKbHA2TnRkbEI4NzFrOE4zbEhRM29lYWl3?=
 =?utf-8?B?V2o1dmR5RFc0VkRKUzg2elJlWFNOZkRieVp3UldqdVJwK2FGWjVTWUpML21Q?=
 =?utf-8?B?WGZwdlZqOHdiNFd4M2NidGpweTdoMk93OHFOeTFjWjZVSTFCbTk2NmV6L3k5?=
 =?utf-8?B?S0M2TWpNYU95cWVWaktQaWZydFVJMlpwajdCamFYbytQUndUVXM1WjhNbEI4?=
 =?utf-8?B?cjhHTDk2RVRzN0dicVZkak11Y1AyOXpqVkl4d3c5QVZvWmlhOGl0cDlNMldp?=
 =?utf-8?B?WGd4bGs4eXFqY05UUVhZZ1RvclIvSEgzbGhvOE9uM1lidjhjMVoxLzB4V1hV?=
 =?utf-8?B?ZlRwSm9KNTJ6TmRqUUxJZUlmY3JlMHNXWm1iZVJQdzdoZUhQZDZINnZyWTJx?=
 =?utf-8?B?QklrU1VKV3lWcGwrRWZ0eUR0UU5aWGIzZUdlN2psSkZmTklLbXZXUjFVUWRS?=
 =?utf-8?B?K2Y5MG1iTWJmb1lRMHVqZ3JIVE9BNnVxQjVGQkdJNm5VY2JXZDhlVXRvOFpH?=
 =?utf-8?B?R203ZjRxVG9yamNlb0UzZitWZ2dKTXJ1RVh4UDcvTHpGeFBMUFQvZFhHcXRZ?=
 =?utf-8?B?bkhpcUw4dzhmTnZjcjAzWmU4dm9DQ2ZiYmswWFIwb3pZdjZhNTd3eXh3WHB0?=
 =?utf-8?B?ZkZZazZhOEd6VUpUWmM0NDBZTkZmNUszSGFZbk13OXBMZGdVR0xUSkZvbVQy?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F+0R9GBZeMumjASu+nuzB6xZbAMp8U3ifUtl/hxm8o1gIkuPDLJqCJQ8Tbb75vDWaGqOOV8lPs0RdEvraZq5USkx4tAr2SaqetymkS0a5Uv1qfYSTKJkFOqCgw8ZyGq2uRcT9Q8Hk0ni3EyGp7QVeWlppSpSwjxWnQMRK9/MMDioAMeE5KBcMPLd9UtxPMNnHogY4gF19Hp/QvoBM2Dx8KCuQgc1cKJOXzlA/mENgnOGXlIlqKJZPltqapWTBJgLPCd3gJNqD389cjAtd3F+gKnVH2f7d50it16pYMQ5kF37H7Xl4AhnYDgkclDl+OOPmRQobTThoNgNl3WH6jp3E9PYPBlOouFsPInWRUYEXTmmDlzO+MP/MAUwBBo49RbhnDgJnI/PYnMlzB0aRmdaIHvWAnE6q1RMroyrnNWWAnG6duDT0+jCCcw8rovveb6QoYC8B/s6R0CsxlFZIKEer0YhDs3KMDiZEBEno4NlSdk8uLZBdKe/JyL4MQpZV8/wr2SgF44dYNrbnviAdP8kUEHWPmBczojzDyS31E/TgA61ofcBHkQLmOWH/GpuucZGzoMtZL04E+xD8bYOO0zxj6SRgJr/ZevL3L6J7t/EWHStS1oKkm965QtJboVrmYetYicbt8Q6bs2m9Dv2f3aOZmmPQwzJKNdgBeu7sBPrBpK5ii/Kc5Z+SicnU30EoMDqhoD8xiMGfEVpXsJ6AABIlz84MK734ea1d6TSWDbznZy9YqhIexjRqiOhAZrISXFTEkQ3Gr5LGDjvmkTNHRZFNtbIaqvqkXnZDEo0qjca0nQLaY0gr3g9ZSLI6PS0ZCAd+UlsJXfnpWj4Yzi3y6Xg6wCw15m+WpbP7YQSN7pqHlh/JG0wX2rqS6VGl8zivN5srRJ6Yhm6WJFC+MWxw+vJHkfWksDiRH48AyQDmQ/Ngm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b5409a-dd42-417f-e226-08db79839214
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:03:40.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jpqyar6e6KJXjNpK/qlvdBJzFTV4WCOLTjU6vXuKZYnhVq5TtaKtqtSAG1NRVWVp0XOmkw1Uo85DSB1dYkRie3reO4yAc4pOalpv8sLLDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300137
X-Proofpoint-GUID: Ijza_jKv-hhiUY1O5pdI-pCp0R5M6__X
X-Proofpoint-ORIG-GUID: Ijza_jKv-hhiUY1O5pdI-pCp0R5M6__X
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 5:13 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> After converting the last user to folio_raw_mapping(), we can safely
> remove the function.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   include/linux/mm.h | 1 -
>   mm/memory.c        | 2 +-
>   mm/util.c          | 6 ------
>   3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9ecb8b9c07f6..8c7eba7370b2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2129,7 +2129,6 @@ static inline void *folio_address(const struct folio *folio)
>   	return page_address(&folio->page);
>   }
>   
> -extern void *page_rmapping(struct page *page);
>   extern pgoff_t __page_file_index(struct page *page);
>   
>   /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 21fab2727209..6921df44a99f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2979,7 +2979,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>   	 * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
>   	 * release semantics to prevent the compiler from undoing this copying.
>   	 */


	struct page *page = vmf->page;
	
	...

	dirtied = set_page_dirty(page);
	VM_BUG_ON_PAGE(PageAnon(page), page);

Can this earlier part of the function be converted to folios so a folio 
can be passed directly in folio_raw_mapping()?
> -	mapping = page_rmapping(page);
> +	mapping = folio_raw_mapping(page_folio(page));
>   	unlock_page(page);
>   
>   	if (!page_mkwrite)
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4..5e9305189c3f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -734,12 +734,6 @@ void *vcalloc(size_t n, size_t size)
>   }
>   EXPORT_SYMBOL(vcalloc);
>   
> -/* Neutral page->mapping pointer to address_space or anon_vma or other */
> -void *page_rmapping(struct page *page)
> -{
> -	return folio_raw_mapping(page_folio(page));
> -}
> -
>   struct anon_vma *folio_anon_vma(struct folio *folio)
>   {
>   	unsigned long mapping = (unsigned long)folio->mapping;

