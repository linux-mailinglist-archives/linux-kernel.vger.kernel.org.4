Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F264D15C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLNUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLNUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:37:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761AC27
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:35:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEHFeGv019862;
        Wed, 14 Dec 2022 20:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Td5Yr0ZwaUDA4zNUtf3xk0Yb+QKgeAVvZqIIPdKNum0=;
 b=NOntu3fA7ZdxK30iAwn+D/2uADN4CxiJdVcm06x/lnRVjPjKVgJ/5O1ZpN4B3xNleW1A
 qkJ3vc553o1kms/2PDHiNUCM4s8MNf/mFrsGH94Ij+VeFghscCjb2TJ+24Uh1IEw0Mwj
 6ZX2viDpNqWyil/Oqz6RsPPQfeRzKTpY+7sqj8FApJWw41pKwZt4C0PPX9k8zgDEO60y
 6tZt+S/Tlx5EGCb0RVMwr4dAS56nrXiWIFqR8h6v29/tYreuXTa4Yz0nP234c2AfVfPR
 hn+jM5CZOw7ARI25Rn8lq4MO5z3zp0zo+mvcIz227ppdbSflW9vSM2TKPuOjtdpwGWTz zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewub1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 20:35:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BEKIbXk025106;
        Wed, 14 Dec 2022 20:35:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyemvqy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 20:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Egzj7lORvS1Elc3xaC/wlPJaOv3UHMbYdlT8JcPJ/w5CZBBDWTqdSk+oIr2TyVwpvxkUIYWK6hx+d5fib6+vcDpl3L3xVor/Bik4C7hu6BpJbh9M6epJtYnL1F1i1/7meR6a4RUWDT3oFEqqMQBePkSeIPTCaa8MUAZTlx9T0LTCevUN5woJk5TcCtVuffuicnp3r1N5NlDUDa3Q7W+7wx4bQnGu5JqiuUO5opI6ARkM5MULHaPLGKaqkVAg5/dtxtyu5h2ldJiMU04Eb4EMhCzdBMqcxlWHYgtsARLR99596XD2Mr66ZkEkriR6SVsNZNzAq0AE3mOPo/ngPP4u+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td5Yr0ZwaUDA4zNUtf3xk0Yb+QKgeAVvZqIIPdKNum0=;
 b=nxlVQ64HT088uWPaNg5CMhIjiNJsGit4BtusWrNdpx1tgAFjd6l87jCP4BxeTRX8aVVJG9DokQeuKZ8bkeUH9k5k+ZfoY8yZCJHcwqtiaHpQjZc0mk2TUAvNZQYbuOFd6mPYkcVYLiWs6PG3WL1Cg2YwGcOtsWYQv3i+ByCxDILAhKXdYXw9LHUntnAbik3j32aCutMnphjluw4NZGDTzzK46RTkNePL9qjHY/ZE2XfO/kCS6SbqMF0W0BD3VHoY1foOdJkQkjXEXsHo/UuvPJJGdTFwLRVXawPbMzDLdL3dPUBr88CTlYmJ3uRbpwc4X6aKEpXHDWfGMKogpdDgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td5Yr0ZwaUDA4zNUtf3xk0Yb+QKgeAVvZqIIPdKNum0=;
 b=jtBap0Chua2b1kFg5JG6Z4Np53XXQG3P0+28dUg+Ir9xiBtrKWBo6GKBVOPRbYnvithkfy8mS4ArDON6o+bNSybtk4oiOgbGRnHcYOEaEleoFjQYUYZnFs4Ag32h+WqxDjciQ9K/NKu37IN7SzrRRqY2eioPDV10wBHzzi4cSdQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:35:26 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 20:35:26 +0000
Message-ID: <cf3f6439-ac2b-53ae-6b55-5ff0b8003fb1@oracle.com>
Date:   Wed, 14 Dec 2022 12:35:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
 <f149df8f-b3ae-b9ce-eb4c-4f684cba0fe8@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <f149df8f-b3ae-b9ce-eb4c-4f684cba0fe8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e54d1e-cf2d-496d-35a5-08dade12bb7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gnUUOeD7WQv///A+wwhZC+B/pr+s3eRbx01ek0hDL4JFvqU3X7avWAxjanDVhzKqCOAjFYiqlJMxL7sRuBKtopohxK/bHPrBDYkjDf0ixlPD9rCAqdxplPy+/pljZJ1eclVZEGY8QqDxk/wFKv1QlWktLt0h7V6ywomx3Xvkbmaiiu0INUwJHwHWruLSnP5Yac0tnhTFs+YeNhIlBm0oDwLmp2sYl0bg6OAj3RcrWO4e9wmlkXMzKnnyeOfdvuA8WNJ1wTo4/7SaRdncC98AAS0YtUVpxv6i1v5dqE72wx3z8JUh37k8ZYiR5G4wyN5Y2HxSTllPHjmrDxD8JXnEx3lTal1K/qhbJFoxOWutzwXP2iBZfEDACiEnrVRWUQskT0Smx1guFttnnla9y4RQ6ZV8gF04x8Q5qZ0lBIRb6c6pfAG30YtbpcCoDV2fD0cHTPA33XiJbvVya6e6vLUTCWr6yuLtPegOpmzAhXkei9XxHiZAsD6Hu8/gmEex6ax99a6RQgvVKV1lsc8B6iniGrtPFb40NwO10inVrNDm42qimPBmE8cYM8sO+kVQmT7bb8WzdPJ5i8ekbjIHoZ5xSoQDG1NaAsAJSKrmAb2QKPKOwDkxuNN+/UfnZI4AGbfeeaO/eQfnEWY+DJohQqVfVuiz8XA19Erh+UKuz7eTh/c77Bgp38wXVGVNTMk6UVm+Nv6O4i6webIzsNQEnz5rLo7mc773eZUKgaZkSF5s3P1584GASQzgJOPL+TCRnzAx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(44832011)(2906002)(31696002)(6666004)(6486002)(86362001)(2616005)(6506007)(53546011)(4326008)(6512007)(966005)(186003)(66946007)(66556008)(8676002)(66476007)(83380400001)(26005)(41300700001)(316002)(5660300002)(8936002)(38100700002)(31686004)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJMODRvL2dhQ3F4alhCZXhqSDNoN1MxeUJ2Q294djlzd1hpZVkwaDlsdFF0?=
 =?utf-8?B?YXVleTdOY2lUZy9sS05WZFBmMEZWdGw2TThaOEZJNXpMZ25mT1FqQjdRdnpz?=
 =?utf-8?B?cGg2a1JNRW5pWlEyaWI4VlR6cHltY2s1NzdWREsrUmZWa2h2b3ZRNU1yQ1hK?=
 =?utf-8?B?MnN1VWxxTDBzU2tPK1U3WWcrVXI5OXRPMU1uY1NoeThCdU1TK21IMnJFSVRz?=
 =?utf-8?B?Y2lQY1pKQnJOSjlIamhrT0x0WWV6dzlFS2JaZlk2WkZYRTFsVEs5VStONUFY?=
 =?utf-8?B?NTBOUm9lb3NGeWNlc0YvY05oOTRXT0svc2xYK3ZXbXFuSkJrOXdydllMclcy?=
 =?utf-8?B?V3RlNGJEUmdUK2x5VE93eEVhN2VqeExJemEvNmZUNUlCcTZTNGxKUGRSZFZG?=
 =?utf-8?B?WnpyWCswYUxCcmJGZEUzOUFBL0o2c0NCbTd3bnNuNUZsQUNTU0tkNThRMy9F?=
 =?utf-8?B?RUk2eE9laGlNNi9YZ2NiQ29mbkZBeE9BWm5QUDBLcVExVSt0aXpCQkdBU3R0?=
 =?utf-8?B?L0h1a2J4c1VFTjJLaDFEUERRSzdNS2o5eHllNS9IVVJaN2xCSjNGKzZTQmxI?=
 =?utf-8?B?TEZxaGlkU1o0Tm9WU2dqRldsWElPOGFobmhmb1plSmJYVVZRM2hXQWxmZWlB?=
 =?utf-8?B?WXhCYk1QOTVzQkY4OXdKWkNwM3RDckZxUTh4bnk4b3p4M3hCSldBbmdiaDVY?=
 =?utf-8?B?ZW9GNjN4L2lJejRvQXY1MnhqVFlFMkhudmJhOFUyMDh3YXFpZEhiYVVIZGhq?=
 =?utf-8?B?b0NRV1prM2Q0YUxuYjlDajZpZTE0L2xUd0tTWmlZWlZiZjE5VGxIQXJFeHJS?=
 =?utf-8?B?VGprSUR6Y1NUTGZRUUJuUnozWGx3WldxcUNnUkJJRm1VWnQ1R2RmdEpqeEg1?=
 =?utf-8?B?eTY5YUFFb2hoMXBsWGNRNm1SUlNaV2djQTU4NC9seTJxeEczRjRhYlFFRldl?=
 =?utf-8?B?OHhMaTZGbGJJM1YxenpxZjdKWlEwY2ZrZGJITGh4eDBaSGVQN2VuVW9hTU1O?=
 =?utf-8?B?Zi9JZXAzQlFDNzgyZU1QQm9zam01NDYxMVVRQ2FCOHcwWDlsb3psWGc5QVhy?=
 =?utf-8?B?THlDd1h3dGt4NCtaWnEzYnI4OHdIdjA2aGovWVlMMVgxdGFRa3NuMjkyQ3c1?=
 =?utf-8?B?dGRsNmdXZHlhSmJubGl3eGJOTWw3akRnKyt2YnhTWWFmQmc0S2lNMGdENWxM?=
 =?utf-8?B?UGdMUVl5T085ZmJSb0tHK2RQL3IvdmhnUXNrU1RIK0ZmNCtSNmJEdWZPdEhl?=
 =?utf-8?B?ejV5cWdCNy9yNFY0QUxGc0orR2tBd1hDTXJoVHJSUzM1Rm1FNndsU2MvVUx5?=
 =?utf-8?B?ZzBaSmREYVJQcUNJei9NZE41eWJqZWdvQjRrZXB0bHFBOWxmekJkeWU1RDNE?=
 =?utf-8?B?WVp2WTlkampBb2w4MUdGbSt0VzlQd0pOeUEvcWFNcGJHYnpxMVI0aE5iYXpq?=
 =?utf-8?B?L3I2dE9aM211anh0UDk1UjRZZk5XM2YzdXEzV2JUMHZTd2NlRzNGUitTN2VU?=
 =?utf-8?B?WkgxZHd2Rjd5SkhpUjZpMXZMOEhUSkFYQVB2RktScU5uK1NjbG5SUVh6emxm?=
 =?utf-8?B?VWJseG9nMnFTUDlCOUlJaTdJWWdscVd4MUtubFprNVBEMGtURk5VVEd2NzR5?=
 =?utf-8?B?VjFpMnlrV2FIYWNNOHNGbExZMHRyU1VBMHF6cFU1VEY3T1pwbGs5dlp1bVgz?=
 =?utf-8?B?eE01OGVxY1JlQzdoMnpXdDBwWjk5czIwZ2p5STZnbnNXRW1SbStTc1VwTXdL?=
 =?utf-8?B?OWpBbUtZTDR0TXJqRmVaTVRDZ3I3d2w3NDUvT1RpK09mYStCQmk4L1RNT0lr?=
 =?utf-8?B?NlpZUmZMWnJ4S05jRFVnaGlUZzRkd3UvVTIwb1JCVnRqdlNoaTJPYzZkUFZl?=
 =?utf-8?B?c1NkdXNTYkkzUWxnU1d5UmN1WTR5ZDRGbkN4WnRmeTBCdWxLeVV4VE5KWlhD?=
 =?utf-8?B?MVFEeU9sMHU4QjljTVRwMXRhY3hqQ1hqTWs5R1ByUS9ZYXVxcVZiWWJFVHJ3?=
 =?utf-8?B?dmpmYlpocldURjZ6emtsd2lkQThndXQzL1VYMDRRanhoMzdCUEFYN3ZDcStY?=
 =?utf-8?B?Ulp4QnBvOXN6S1l6M016eDNxQWJrMHR6Vkw1cHBBK0RVbEw5YysyalZyRHJk?=
 =?utf-8?B?c3JMcDlyKzBLRmYwb25HcDdseEF1VGM4N3oxbWgrZmgyL3ZtM2M5UFk3d2pr?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e54d1e-cf2d-496d-35a5-08dade12bb7a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:35:26.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OedS8jH9Y27Up5i1Iw3s4shSJvBxRGCWMuGcOjEi/l1cPwdmsBQLYSf6ueljEKZV1WbKaTl5RzpesNQRjdNVaVczu+9/oU6bAA9TVA52lSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_11,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140168
X-Proofpoint-GUID: cjaVCa2hAhJu2H05NNPKHqeYxrdDKu88
X-Proofpoint-ORIG-GUID: cjaVCa2hAhJu2H05NNPKHqeYxrdDKu88
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 12:43 AM, John Hubbard wrote:
> On 12/13/22 13:20, Sidhartha Kumar wrote:
>> folio_set_compound_order() is moved to an mm-internal location so external
>> folio users cannot misuse this function. Change the name of the function
>> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
>> handle the case if a non-large folio is passed and add clarifying comments
>> to the function.
>>
>> Link: https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle.com/T/
>> Fixes: 9fd330582b2f ("mm: add folio dtor and order setter functions")
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   include/linux/mm.h | 16 ----------------
>>   mm/hugetlb.c       |  6 +++---
>>   mm/internal.h      | 21 +++++++++++++++++++++
>>   3 files changed, 24 insertions(+), 19 deletions(-)
> 
> I think this looks good. One small question below.
> 
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7dc376052d40..300d92d2b49d 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1019,22 +1019,6 @@ static inline void set_compound_order(struct page *page, unsigned int order)
>>   #endif
>>   }
>>   
>> -/*
>> - * folio_set_compound_order is generally passed a non-zero order to
>> - * initialize a large folio.  However, hugetlb code abuses this by
>> - * passing in zero when 'dissolving' a large folio.
>> - */
>> -static inline void folio_set_compound_order(struct folio *folio,
>> -		unsigned int order)
>> -{
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> -
>> -	folio->_folio_order = order;
>> -#ifdef CONFIG_64BIT
>> -	folio->_folio_nr_pages = order ? 1U << order : 0;
>> -#endif
>> -}
>> -
>>   /* Returns the number of pages in this potentially compound page. */
>>   static inline unsigned long compound_nr(struct page *page)
>>   {
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7cdbcc22587b..810e840bb4f1 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1344,7 +1344,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>>   			set_page_refcounted(p);
>>   	}
>>   
>> -	folio_set_compound_order(folio, 0);
>> +	folio_set_order(folio, 0);
>>   	__folio_clear_head(folio);
>>   }
>>   
>> @@ -1808,7 +1808,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>   	__folio_clear_reserved(folio);
>>   	__folio_set_head(folio);
>>   	/* we rely on prep_new_hugetlb_folio to set the destructor */
>> -	folio_set_compound_order(folio, order);
>> +	folio_set_order(folio, order);
>>   	for (i = 0; i < nr_pages; i++) {
>>   		p = folio_page(folio, i);
>>   
>> @@ -1872,7 +1872,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>>   		p = folio_page(folio, j);
>>   		__ClearPageReserved(p);
>>   	}
>> -	folio_set_compound_order(folio, 0);
>> +	folio_set_order(folio, 0);
>>   	__folio_clear_head(folio);
>>   	return false;
>>   }
>> diff --git a/mm/internal.h b/mm/internal.h
>> index bcf75a8b032d..829b6a60ceb7 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -378,6 +378,27 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>>   int split_free_page(struct page *free_page,
>>   			unsigned int order, unsigned long split_pfn_offset);
>>   
>> +/*
>> + * This will have no effect, other than possibly generating a warning, if the
>> + * caller passes in a non-large folio.
>> + */
>> +static inline void folio_set_order(struct folio *folio, unsigned int order)
>> +{
>> +	if (!folio_test_large(folio)) {
>> +		WARN_ON_ONCE(order);
>> +		return;
>> +	}
> 
> Would it be better to do this (below)? I'm not sure of the value of
> warning on "order"--it's a little odd and unexplained and doesn't really
> do anything more helpful than simply warning about what why the code is
> failing, which is really about !large, rather than order. Unless I'm
> missing something?
> 
> 	if (WARN_ON_ONCE(!folio_test_large(folio)))
> 		return;
>I agree that warning this way is clearer, I will change in a v2.

> Sorry to drive you crazy over nits. This is the last one from me. :)
> 
No worries, I appreciate the feedback.

Thanks,
Sidhartha Kumar

> thanks,

