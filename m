Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A066F623814
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiKJAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKJAVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:21:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF31580F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:21:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AA0JHgo028777;
        Thu, 10 Nov 2022 00:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UzMJcXHEjEOnl4JWzK5iLjzSG7moFQ8nK7WjbLa8B30=;
 b=FPSq8q09zsqq3HIroDSiAbcIVcGvFl11/NHNIYfc8fdOjjlmFcY8oVhh0i5jCZG+jTfB
 IyLJW9a6s9QJkHYSz/QOQQuAIfocrjVmFsTn2+Qip3KH8BDe3vafrESOEDKuBCAeq0Cp
 J2yzeO0UGu/i6lOwOvCQ9aNI1mY7kcLP3c2oqTmbPtlpMO9drR5kY7I4p4xSsRF7xF++
 svoEtewr/PqNkDIgsvH4Oom+gXnTX+hCzfChrY+pEGufpbX4KoAjE4MzmHy8C7+IjQDJ
 OD0QFGclT+W4x0tMaLMMducQwttmIGANqbakyJWp2y7zvWWdoDHyquVup947V335jzQc oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krpbt81s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:21:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9N6uWp039931;
        Thu, 10 Nov 2022 00:21:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqj8fwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 00:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUTo8IZmORQWpQFSvpmxM3odBpWaQZ3Xs0wrgFu3BB0FifkiXiiJm79IumcA7qEAuJggdgK+NetrtIMRXXjCrPX+H/7stAU6fYDnVjkxVMmkru//8CSoHxMwRhfM7Pe48RVYGXtwZ3PO1TX8bM4sRyfqS6bWx5KZcLSXN0Vbjzawms6dh71Nw7lkogHcYGQeS9b3zq421aUATSQd5oIf2tBAx5R8gMEjWZws38wQeIi5ROWq7hR+7RZgsHvqoDMtN90IAx2L+b1D8JqGE3bSLUiyvr24ZnYAxHvara3NbQpwuNBYSjUHTt4rh+W8i6G9fvOa7WpniwlSO8gcXPdC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzMJcXHEjEOnl4JWzK5iLjzSG7moFQ8nK7WjbLa8B30=;
 b=W5pUBxBXWgdiUoODOVT3N/hCuyn5yc6B4rp4yN2jyoZ2G7pI3ChLnYowZBGKjMbtYiX1w5gvCEqbsIvrZt2CycMcKb3yzAaNVlsh8JHHdISRon+9riLjhsmLymGRuHnl+ehB3tz5ndUGBUeO+yWz65m0RK2QEUfbGyjAN2ZYrNPSy0qXb8O6OQ8o/6erSxrSOjrKJ6vc4C0szdJfWyBO8YcPqAjbnQRu308iCf4XtL/R9Kw/tRdRfq/0NU2HpsR+lWEXeQqPTYfZJHIKUxcoYu1YsLMvDcJz4Iq4OcTgDCllpEF7cxS6eb25ibNkIQaYOV9m02qNTEHpJj6PxpvFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzMJcXHEjEOnl4JWzK5iLjzSG7moFQ8nK7WjbLa8B30=;
 b=R3gLLjvI4U0lYMFtkIco109WjS1i9GF72yKwLytCUkIUXcDenNI5RU8dqFnbjyx4hk9EtXywpQPd+10RZkZZh5Js2LEefkda2kNJ8uWoEJsVBeTekzpBvhAHDofeum/VpBHF0VvqqPJl0+JtcRR/eHdtL9cE115VlalUjvTbvJ0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 00:21:00 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:21:00 +0000
Message-ID: <34332121-488f-c0b9-13bc-08d6e06ad4a7@oracle.com>
Date:   Wed, 9 Nov 2022 16:20:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*()
 to folios
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-4-sidhartha.kumar@oracle.com>
 <6935E6F8-9950-465F-8752-5CADF1C7D317@linux.dev>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <6935E6F8-9950-465F-8752-5CADF1C7D317@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 16249971-d5f2-4000-8159-08dac2b17167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWWJcfr3ZHEdmg9/f4pP7/2h7am7FpzhBqqavR48I0rstIrBWlGCc1oHPZlfkg20CWaUEUzDChp33iiGn3tY2KknS7x+AosDGz+O0GIJiUn1/YHJkxvtqVG/OyEja3JWe73xFjyqZTSRLzAHDVSCUYBJH6fIhgRrCti91GemvDsqJ2+XzaEi1b9odolHAbxo4yYpV4TbHODk/MljEEDt0Tgj8wmRlvQvOAIJQuZ+kCncHlgr1dgWB2efwrH49jEHi98W5wfmE/xU4Hn4lQfGVAbZIxPDg9RbVDe8wWV6oLhUGya+sQxQhVN82tboWpq7U+aH2vlPScouyswQib3NnDtitKktbFo4WXaUj0gvIhLULHUBaZSANyU7fgv/zBMOVDmwicxq1xGjFvfWTbhTz/4M7NplO0DCMeXVjDpLO0mZbjeiWUgSRreTAobEpfxzymG2RA3NgFegVUCtIydhdPyv0mN/T/BTXXMik3ZkrM6Pq8dbkrha8J7ezeiAfZR6l5ecCR5Qp2fmAJQKZvGlM5PKD+ShwyFzbr5LNSZK4yGYReJY/fIVhbGVipZZEGfmZH94tP23Nb89p1KoICBxIjr3HvPiyxrJX9YTWCT1bhxoNCClakGmKNK2XeauMxWzEBKDxNv6msEFpKVvGbePQQo3oKygpC/nXt/ayJaQnR0MNR9E1DwWjupMHA6ENf7isLNfYlm25sZehr/d1R7cW9EA5XWW9UDJqFMESWZZg+QlXq431cGBBp2nNYn8Re/d8ZeIc5VlWxAvp5tjy6x8Xs1QLYbsVtOXGdoPAaCjpteonCNdknyR6tnK9vb05Dg0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199015)(2906002)(31686004)(44832011)(36756003)(5660300002)(86362001)(31696002)(6916009)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(7416002)(8936002)(6666004)(6506007)(6512007)(26005)(54906003)(966005)(478600001)(8676002)(53546011)(4326008)(66556008)(66946007)(6486002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnB6dTNDV3g3QmpjNG90RldjR2NjZ1hUVng5dmlQTDEyOVNlMGNyM0UxQXdw?=
 =?utf-8?B?aGc4MmZHUGVVaFJOQVExNjZlMGt6RlZ2cDNkTi9zcFVkUHJ3MitmSUUyV0Fp?=
 =?utf-8?B?WDJSY2hoWitUWUdSakwvMzBzQ2o4MmYrUU8vSjFnaTZRR3JFcTZGRkQ2YmRV?=
 =?utf-8?B?SFp5SW54OE82RGFSSmtUTThaUXF6VlRwRHo1SzRIY2FkY0twVGtjSW1SZUtE?=
 =?utf-8?B?YUNkWnJYWDFseDJlNGEzdE9OWERyQWFza3hTRU9kZi96OFpIOUdrRU16a054?=
 =?utf-8?B?OVhRNjRFa0FKcFAzMjk2MEFCRkJVMGdRRlRCcWpPRU16QXM0Q1BlZmpMVzR3?=
 =?utf-8?B?ZEZsRUFrUVRQZGdMb3hxMTlCOHBOem14Yy96Zy8zdkVNalFuM0MxeHU2Y21q?=
 =?utf-8?B?azlPUjc5YUJOL3laSW0vcXJvZmFhZDcvSzFnTUl0VEdXQ2RLUkJERnMzc1p5?=
 =?utf-8?B?KzBma29qRW5BM05XRmtqcFltMWJTaithVWVYVEdqSnBuZHpXZDJqZmxFaUZp?=
 =?utf-8?B?aVpTcFJmV3Z2NnBveVZScklqVzR0MmdJR2lWMDBCL3VkNjl4TzJpdG1iN0xp?=
 =?utf-8?B?UGNLZ05oaU9vN3dqc1Y5MUJLSEFiTGZzL3pITlJsQTR5ZEVSVDNwTzQ2VnRL?=
 =?utf-8?B?Z2tNOHJpRnJNVFViTzAzenRPN0Y0WUplc3FTOHhuazhib1dTWm9DQVBENGty?=
 =?utf-8?B?NWVCc2REQUtqS0FBWUNxSmR6NndrUUpHTW5QeHNsTmp4KzcwbXdVQlVNVUsz?=
 =?utf-8?B?bUVCV2E3Y3lzTXlKK2x5Q3h6WDZyR1BqcTlBS0FLemVvTXRNSmZWVVZHMnVq?=
 =?utf-8?B?aHRpVHFlVklqOUpuZlhzWmhpT2RRK24ybDBldkxDNWg2b29xdHQyeHRSSUZ0?=
 =?utf-8?B?cXZjNUlOR3BCLzAxakxiV2xvMFdxaE9KUmE2dytHZlc4bG1QbFlPaXJNUjNz?=
 =?utf-8?B?TFNmQjRMY1dvU0l2OGQ4UVBXSDBtVkZ3ZEQxQ3hEYjYvRm5NQ1dLbzlud3gr?=
 =?utf-8?B?RTVZVUhjMUlFOXlSWEtkZWlQNkgwZXRFV2ljb2JYNzZyNS8zL1dML2VMaGVj?=
 =?utf-8?B?bjEvNCtaa3hhY2lDa29IbnEzWUhZOVY2c1lEelE3Z2I0MERvRGhFNUZmL2Rk?=
 =?utf-8?B?MGFmVDJJbmZQYzA5aHJkcEFwTmhwQVlRcVlERTcwR01JTi93UjlEL0V2MXpI?=
 =?utf-8?B?bXZuK05vVEQxMDJscG9yRXQvVE1SSFkxQVRQM2I0emIwcnRyNGRwV2Q3dDVB?=
 =?utf-8?B?ME1OeHk4Z3NrNGl4THVDdWp6MW9nQ0NsbmlkZkhkelhOV0J5RmhYMTdrT1ZP?=
 =?utf-8?B?K1JSZWxsY3ZJSjFBR255WCtzWmxyLzJXMk5jM2lEaE5xZTBXakZIeVdqellI?=
 =?utf-8?B?Ym5LUkNRbitjYmZYS21BS3dYZ2F6OUU4NGtFQWVCbklNV2REajk5M1RzZVVT?=
 =?utf-8?B?UmZuc1ZOT3NQempnTmQzNHVDb01GRW00OGxySUZSUVVmRm5heUdCV2xSbjMx?=
 =?utf-8?B?VE5OMFVsTDFuWDk3RHh3OHE2cFlJalFKWUtYdDFtZmVNMEtIUkdlV2pNRVVh?=
 =?utf-8?B?L1V6dkxnUkRtUkJONUlVNkdjS0p6K0JuNS9nYWdjMXNlSk56Zld4QUIyNm9R?=
 =?utf-8?B?alZwVWFaU1hqWG5XU29UYXZxbzJLZEJ2bnR4Qmg0MlJmREZrRW1vSlB1UVNr?=
 =?utf-8?B?U0IxVkxaT29sSHAwc2kwRjdRUmozSXlmS3hWY2h5ZWFyREx6cEpaSU5vWURm?=
 =?utf-8?B?eTM2SGV4MTVpbHlzQVA4SVA2S1RqTWx5ZE5RellNR0J5M2NaeHRuRVJMdHl6?=
 =?utf-8?B?Yk9LWE02UzRhKzBvNjRSb1FRMVRQbG5ENmcrZ1RCeFVxWFNpVTVHNGlHd3pE?=
 =?utf-8?B?NTFkVE15ZGpqMENCS2lyT1NxQS8rTFdOR1pEREg2L1VJREtBcGFVa21hcWto?=
 =?utf-8?B?VE0rNjBxWFdDMStzOUlndnhTMTZmNE12UXFLRFhUMDRhNTAxRU9JYkpQMW1p?=
 =?utf-8?B?Q0FxNnNLM2lJTmtVU0dWbTdta0p6MGt0U3FuNXM5ZHZEZnNoQTNSZEZ6R3l3?=
 =?utf-8?B?NUlIZFNaQXdEa1dkSWNERDBZRVRMaGVjNndyY3o3eDFaeE9HWUFOR29iY1pD?=
 =?utf-8?B?THpwNGJQMDdteXBDZCsvUDYxU1pNbzViUStnT0lIU0Qxb1B6aXVSSU5sdDVs?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16249971-d5f2-4000-8159-08dac2b17167
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 00:20:59.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywbzPpAr6KhWtI9pf9FoNcLvg2M24PbrOTXBZIV5IX83dbTQmIFY+YbvSMaswAvmpMj4Ip35mdsfJt72HT7a1Bpg2i3DPIrOm7ca31rNC2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100000
X-Proofpoint-GUID: bY0xJwVWc1uo_vju7wMdt5MXcp97L2hc
X-Proofpoint-ORIG-GUID: bY0xJwVWc1uo_vju7wMdt5MXcp97L2hc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/22 11:45 PM, Muchun Song wrote:
>
>> On Nov 2, 2022, at 06:30, Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:
>>
>> Allows __prep_new_huge_page() to operate on a folio by converting
>> set_hugetlb_cgroup*() to take in a folio.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>> include/linux/hugetlb_cgroup.h | 12 ++++++------
>> mm/hugetlb.c                   | 33 +++++++++++++++++++--------------
>> mm/hugetlb_cgroup.c            | 11 ++++++-----
>> 3 files changed, 31 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
>> index feb2edafc8b6..a7e3540f7f38 100644
>> --- a/include/linux/hugetlb_cgroup.h
>> +++ b/include/linux/hugetlb_cgroup.h
>> @@ -112,16 +112,16 @@ static inline void __set_hugetlb_cgroup(struct folio *folio,
>> (unsigned long)h_cg);
>> }
>>
>> -static inline void set_hugetlb_cgroup(struct page *page,
>> +static inline void set_hugetlb_cgroup(struct folio *folio,
>>      struct hugetlb_cgroup *h_cg)
>> {
>> - __set_hugetlb_cgroup(page_folio(page), h_cg, false);
>> + __set_hugetlb_cgroup(folio, h_cg, false);
>> }
>>
>> -static inline void set_hugetlb_cgroup_rsvd(struct page *page,
>> +static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
>>   struct hugetlb_cgroup *h_cg)
>> {
>> - __set_hugetlb_cgroup(page_folio(page), h_cg, true);
>> + __set_hugetlb_cgroup(folio, h_cg, true);
>> }
>>
>> static inline bool hugetlb_cgroup_disabled(void)
>> @@ -199,12 +199,12 @@ hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
>> return NULL;
>> }
>>
>> -static inline void set_hugetlb_cgroup(struct page *page,
>> +static inline void set_hugetlb_cgroup(struct folio *folio,
>>      struct hugetlb_cgroup *h_cg)
>> {
>> }
>>
>> -static inline void set_hugetlb_cgroup_rsvd(struct page *page,
>> +static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
>>   struct hugetlb_cgroup *h_cg)
>> {
>> }
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 27b87dc85c48..a6384fb0b57f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1758,19 +1758,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
>> h->nr_huge_pages_node[nid]++;
>> }
>>
>> -static void __prep_new_huge_page(struct hstate *h, struct page *page)
>> +static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
>> {
>> - hugetlb_vmemmap_optimize(h, page);
>> - INIT_LIST_HEAD(&page->lru);
>> - set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>> - hugetlb_set_page_subpool(page, NULL);
>> - set_hugetlb_cgroup(page, NULL);
>> - set_hugetlb_cgroup_rsvd(page, NULL);
>> + hugetlb_vmemmap_optimize(h, &folio->page);
>> + INIT_LIST_HEAD(&folio->lru);
>> + folio->_folio_dtor = HUGETLB_PAGE_DTOR;
> Seems like a variant of set_compound_page_dtor() for folio is missing,
> e.g. set_large_folio_dtor(). It's better to add it in this series.
>
> Thanks.

Hi Muchun thanks for taking a look,

Would it be ok to add this functionality in a separate patch series? 
Some of the earlier patches in this series were modified by Hugh's 
series[1] so I'm not sure how a v3 of this series would look now. Let me 
know which approach you would prefer.


Thanks,

Sidhartha Kumar

[1] 
https://lore.kernel.org/linux-mm/3818cc9a-9999-d064-d778-9c94c5911e6@google.com/

>> + hugetlb_set_folio_subpool(folio, NULL);
>> + set_hugetlb_cgroup(folio, NULL);
>> + set_hugetlb_cgroup_rsvd(folio, NULL);
>> }
>>
>> static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>> {
>> - __prep_new_huge_page(h, page);
>> + struct folio *folio = page_folio(page);
>> +
>> + __prep_new_hugetlb_folio(h, folio);
>> spin_lock_irq(&hugetlb_lock);
>> __prep_account_new_huge_page(h, nid);
>> spin_unlock_irq(&hugetlb_lock);
>> @@ -2731,8 +2733,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>> struct list_head *list)
>> {
>> gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>> - int nid = page_to_nid(old_page);
>> + struct folio *old_folio = page_folio(old_page);
>> + int nid = folio_nid(old_folio);
>> struct page *new_page;
>> + struct folio *new_folio;
>> int ret = 0;
>>
>> /*
>> @@ -2745,16 +2749,17 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>> new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
>> if (!new_page)
>> return -ENOMEM;
>> - __prep_new_huge_page(h, new_page);
>> + new_folio = page_folio(new_page);
>> + __prep_new_hugetlb_folio(h, new_folio);
>>
>> retry:
>> spin_lock_irq(&hugetlb_lock);
>> - if (!PageHuge(old_page)) {
>> + if (!folio_test_hugetlb(old_folio)) {
>> /*
>> * Freed from under us. Drop new_page too.
>> */
>> goto free_new;
>> - } else if (page_count(old_page)) {
>> + } else if (folio_ref_count(old_folio)) {
>> /*
>> * Someone has grabbed the page, try to isolate it here.
>> * Fail with -EBUSY if not possible.
>> @@ -2763,7 +2768,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>> ret = isolate_hugetlb(old_page, list);
>> spin_lock_irq(&hugetlb_lock);
>> goto free_new;
>> - } else if (!HPageFreed(old_page)) {
>> + } else if (!folio_test_hugetlb_freed(old_folio)) {
>> /*
>> * Page's refcount is 0 but it has not been enqueued in the
>> * freelist yet. Race window is small, so we can succeed here if
>> @@ -2801,7 +2806,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>> free_new:
>> spin_unlock_irq(&hugetlb_lock);
>> /* Page has a zero ref count, but needs a ref to be freed */
>> - set_page_refcounted(new_page);
>> + folio_ref_unfreeze(new_folio, 1);
>> update_and_free_page(h, new_page, false);
>>
>> return ret;
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index 600c98560a0f..692b23b5d423 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -212,7 +212,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
>> /* Take the pages off the local counter */
>> page_counter_cancel(counter, nr_pages);
>>
>> - set_hugetlb_cgroup(page, parent);
>> + set_hugetlb_cgroup(folio, parent);
>> out:
>> return;
>> }
>> @@ -894,6 +894,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>> struct hugetlb_cgroup *h_cg_rsvd;
>> struct hstate *h = page_hstate(oldhpage);
>> struct folio *old_folio = page_folio(oldhpage);
>> + struct folio *new_folio = page_folio(newhpage);
>>
>> if (hugetlb_cgroup_disabled())
>> return;
>> @@ -901,12 +902,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>> spin_lock_irq(&hugetlb_lock);
>> h_cg = hugetlb_cgroup_from_folio(old_folio);
>> h_cg_rsvd = hugetlb_cgroup_from_folio_rsvd(old_folio);
>> - set_hugetlb_cgroup(oldhpage, NULL);
>> - set_hugetlb_cgroup_rsvd(oldhpage, NULL);
>> + set_hugetlb_cgroup(old_folio, NULL);
>> + set_hugetlb_cgroup_rsvd(old_folio, NULL);
>>
>> /* move the h_cg details to new cgroup */
>> - set_hugetlb_cgroup(newhpage, h_cg);
>> - set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
>> + set_hugetlb_cgroup(new_folio, h_cg);
>> + set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
>> list_move(&newhpage->lru, &h->hugepage_activelist);
>> spin_unlock_irq(&hugetlb_lock);
>> return;
>> -- 
>> 2.31.1
>>
>>
>
