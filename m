Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B866478AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLHWNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLHWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:12:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38264CA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:12:38 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8M1Wln026858;
        Thu, 8 Dec 2022 22:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xdGgwpGgQR6kft1inHRIJZtbAAYUvqG56SuHRKcFZ0Q=;
 b=hwE3eWCysm0+EO4oHIh5eLnEtxV2ljMKq3Eh5zT9dRlKyvp3NG9ByDhXR8t7Z5jahknm
 V37QaAYoursUMtWYzpEO/TvRm8BkrQ6K+tr+FfCIdbnk0tG7jKg7NVU0Dwiocnc3+NJV
 mzLim/bj8kJ4svmcWhpyPZmcKCQuz9sjKFQwMieu86mdem6em9U4pxDXuQSDvAAN4mrJ
 ZzsaQwmHqDqm3HNKGIRkvVPiHtWlXRYxw5rtdTxsYoiueLu/OSLEb3+UYib221AUKCDQ
 pPqmiOSKt3URH8FeBU39ycg9npwKKlbaEB1m7eTSLgGfYEmEncB26ljmq6+yiKP+87kU OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkkv7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:12:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8KSdEP008380;
        Thu, 8 Dec 2022 22:12:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa61hmyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 22:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuNLU5iI/ZEaYXulGJID2R5+pLT0NIzAWoxBgaIRpvrJxY/ZUYjz2p63xD1YQwL4SZoYiEK97SsgrQRPlQwtR4vleSC98I5BQaPiNjo6oBv3fPS9ZghyhrY0fnMY0b4/5I+iXArdueTU7p9z58+88Oa69+5Bq5N0hwjMa5ZKuHYWwakEMl+ztuP34wmVVQUMhtaCjD4lwczKir1UOLflHutntxXUAPUP6TjZFWM8PKX8YM/WTYTnXhPdHfsYHLNfzTfiLN4aSXcvB+uyG7g03oBocXSweRvvM+kfpRxtpFUNv5OZDBUmfx8nfNRS37Jmfs3+c6jQqKN94mWVo3M4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdGgwpGgQR6kft1inHRIJZtbAAYUvqG56SuHRKcFZ0Q=;
 b=CFCxLOW1pq60uSI54gX4xZqYTZ6fU6zxRc+M5QcSpC+7jaPo9k7X2vAYeLG18bttWRq/xXJXzPihw16+arivdfKnTHZGYDgik1XWyUOklwjZy71WALRTGXU0BwPaMb4hXEKUNClILXZiiEuzfSMeOsgWQwPoYyyf2tJnWRdhug0Zz8aIApNUV/sUo8YpBUPua93g1nyL2/a1Ig4fI/0V4CQ7Ia0gLC46RgOd88rPTimsb9oT6q8YvjvE8fsKg6KNTlebzlKtY73oROY3qkCMtSF/fwfW/rCFlxaPtOwqWwQ2ea0l4Yv7yJixpxDhcl1J0QaD/85uAt3VqKIsj3qZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdGgwpGgQR6kft1inHRIJZtbAAYUvqG56SuHRKcFZ0Q=;
 b=gIrkekiHLdKo6vSrRJGxeHbSxyi6ugfvy+Xt063OT94CwfAW5ICCuLd88PQlzXFez39T8hcM4P1Slv53gWfCOhg/Z4AZ+BcVO0cwhE36X+AiqgmHDEsWlmdp95RIUyxphfpPpOtrYETNQekoFR0qY4Vp7ZY5THC4+Ccc30JyCKU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 22:12:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.016; Thu, 8 Dec 2022
 22:12:23 +0000
Message-ID: <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
Date:   Thu, 8 Dec 2022 14:12:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, david@redhat.com
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd6bc16-e8d3-4f41-9d08-08dad9694843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ut5bGVPlaKBGMMrH6Z9kY1Jdp4FPvshsFrMIXYoaQaTBoGc/38E1buu3tPcQYBvLdUS5W4EGe5cBNpbbMlMhchDmT+Tma0228vPeIYAxLcfurbNYHuO7BMzVjzIdgwkZ15t7OQlB9E/iPsltAX3i5L1nSBBqigC9IWCKY73CjT+ZtLRpy+6MzvFnns7Yo9WRMYJKk32RPqAN51CRyounfN1y+66Eichn8SYEznR7jF79vSukgz02FdqBxE25vHXYWW2B9emSRyetI2XtQQWw6VUUnQdvD8ivEeXgMWbSfyJDj1j5JWt0TBohlLZrNXPLXfVMPKwA3UApH5gtBixDfvKNzFbw8+RDrHjMYxUi/K3Wg5wDvi6iVhOYUJ67aBstYWfzp4Qc2S9+q3j9Kg4nzN5yGmajinyIH9uNPZ4o4mzhP+BEAHiEAz1gbMnNh/IHGjdWKCm96zY4f5rMQTMFlV/7Y3yFFzPmdOKItCV3gsACc/1AxcqdZYLYlJPEE4sl1rU+K5JkoeOO+9ipd1jMx2edCCt+c8wsEQOVzk9t8lt4ZgLgJgm0FBgZ7CFgIhzTCW6TiOKOGrTVwUteI27BQIlt6SyklXkKsmmHEPDvmYdQ1x6PLYO892EvVR+F2oOqa7/79MgJdN+miNBmnBHOtHaifi3fiLUfaOxUmE3qu0o5X+t3ZOk37AWuBnJ5KhFozNZf1UaFGoILXz4zS+501TMP/mpWxSO11h1UgcoSptY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(36756003)(31686004)(44832011)(4326008)(2906002)(83380400001)(5660300002)(8936002)(38100700002)(6486002)(478600001)(66946007)(316002)(66556008)(31696002)(110136005)(86362001)(186003)(8676002)(41300700001)(66476007)(2616005)(53546011)(6666004)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THB3dCtaUER5RnZ3M2xHa0RTTjN5YVRDZ05jTHJpZjUzRTgwdHFIdTh5MndE?=
 =?utf-8?B?Ukd3dVptc2dxWnNzZVRIWWNGSlNQNTFIa0JSMkx2NUR3Y0lXaEJhRVo2MlZy?=
 =?utf-8?B?NEVCNXdUSlRpRzFwU0tEK2RGUUdmUjJHTGRWbTkwSE9Ma3FkTzI2T2R5R0d0?=
 =?utf-8?B?VjdjTFJ5RncvRnJMVWozWWMvYmVIZXJPUVBSSlF0eS96WnVtblgwM1JTZWRG?=
 =?utf-8?B?V08zc3VPVXpTSzlMUnpWWEJyT1diYVBJL2lsSnNVa3lSdWVPL3lGVHhBUFJl?=
 =?utf-8?B?eHB4M0FqbTluQTVtell6WWlQZEtUZS81b2JSQVQ0b1d1SDh5NmEyMEZwS2tN?=
 =?utf-8?B?NUw4ME4rd0NGMGkwU2FvRmp3bS80b0hGVnU5VERZS1RodVVZcDk0dEYvQytU?=
 =?utf-8?B?ZVpRcW80V1ZQa0wyN0tpckk0dVlVSHBHNGpkenNRa09ra09TYTZwT1NlZzRv?=
 =?utf-8?B?OFhJN2E0VHcxVEFEbUkrc3dLQS95RFNaZEQzQlBOQzF0MjJJaXB3a2g3UUl0?=
 =?utf-8?B?cGNwUzBlVnRYb0s5NHo4bjhrVWRZcitZYWNGakdKMzVwcUhPYnlxeTE0RmV2?=
 =?utf-8?B?dkxJUG9OL1piN01IbXhZZXRqbE02Vkg2M3pGSWxia3NSMHo0ZXlNNTZpdy9l?=
 =?utf-8?B?ZWVHS2hjZnMxWUZDM282dVpqQ3JVVzhmeXl2b1owK1RkbnVDSE50czUxMmZR?=
 =?utf-8?B?aDQrV3J3VGE4MzMwSFpiREZCQkR1VUc1OVBBSml2VU5FRGgwU01rSHVtTzJK?=
 =?utf-8?B?cE9lZDMyZ3M4LzJxNzVBNDU1eU53R2d5RHNHa0lNMDVPT2Frd1VrQWRqTEcx?=
 =?utf-8?B?ZHlVN3pKYzVaT0RvRVJrcWRwTTh2OFVDdjB3YVdKQ05GYzgxcmRJKzgrQVBC?=
 =?utf-8?B?Y01OV01ubEwrOWxRTDQ3Q0UxMFZmMVcvMERrdzdmblYrUkJWNVQzMkg4SG5J?=
 =?utf-8?B?RDF2TUR5L0dCZ0pnbTdwTk53MUliY1BoSXVVNzE5TDg4ampGcUxzVThMS0pR?=
 =?utf-8?B?OUY4dCs3ZG9rWDhoemV0Q0ZJQmIvTXcrNm1QZG5Dd2Q3dlM0YnZuUGs1T1hu?=
 =?utf-8?B?QktJOWthQWlYV24zeEJwU2Y1Ky9yU2N4UllXSlBOVTVIcWl1RXlpd0p2Ly9P?=
 =?utf-8?B?MnR2VCtHYjRwU0R6UVptY3cxV1hTMFpkWW0rL3YxdVR3UndKeXVHS1BKb1BJ?=
 =?utf-8?B?clc0Q3h6aTJQTHRKcHFFaVhVWXFyWTdnZVdDOVcwUkN5LzhiT3NGamtxdk54?=
 =?utf-8?B?VWFwTlNmU0NCR2NId2d6a04vRVMvaVpTaGJkQS9nelR3Qis0VW1WVUZmaXgr?=
 =?utf-8?B?alZvZ1JwTDdpVmdCOERKdXMxbXR5WUF2bU1LTVBFeXZaRE0vWXdhbUZZVDNS?=
 =?utf-8?B?bkJKMi9oZnY5SEcrMWY3NXNPd0RwMEd0Kzc5MlFxSjdJb1RMM3B3ZUY0MjU0?=
 =?utf-8?B?S3JuMDQyWHNmVUFUUFV4RkRYeWcrSXFlR2swelZuU3ZtZGlWaGVLaHIrUTVU?=
 =?utf-8?B?NTlGUlRPeVF5RU10U2FvVmgraTBKMXVwVVA0c2VvT054VHpLSENWVm5aL01F?=
 =?utf-8?B?SjZVbjYrRWVydFNxOEJzUDUzU3BpOElqTkVxaVVQazkxUjlVYTVqK3N2Q0tY?=
 =?utf-8?B?Qmp5eGN5eEF5M1JPc0ZGdWpWYzBnalVEWWlXSW9oQXZQVEtvRXFiK29lK3BL?=
 =?utf-8?B?cStoMnorczBVdm1odVhQb1ZFcmpKYjQ2TWFOTUJYUm41WkZ3RS9JYTZKQXJw?=
 =?utf-8?B?OE9kT1JEY09JRmlTcWhMMVhENDJqN05CWW90MDVPZitPWlZMVHZES3U3ci9n?=
 =?utf-8?B?N3ZoQlQ3VWlMVjBZTWhyaHRYdjhxbWt6bExxdnhxVHVZL2xiSjNuUmkxc24z?=
 =?utf-8?B?UE5YVjhObDRRaGlSeG1mOVJ6ZXBqQ2EvVmRXdGQ0Slh1bWxNVFhYSmhXbjI3?=
 =?utf-8?B?UUFsM3RtZ05SL0Zxb1FZalVPeDRYdnNvUGl0VWJlanl3QUFQMWhNSnQ0VjZo?=
 =?utf-8?B?ZUJoelZHV0NveGZOVGppR3hrVHlJcEZYRDFpenFLTi82aTh1S1BkQWJNdkhu?=
 =?utf-8?B?VlNnUSswWjhldlFWS0I0allTOFB6YUpYaFQvb2NmRWo3dE1vU3A0TFZKT2VY?=
 =?utf-8?B?T1BhUml1YjB2OU1xREZxKzVEdU1yMkU4QUNsbEorMGlpdzNWeS9rWWkwSXF4?=
 =?utf-8?B?cmRWOXkyV0R1N3liV0hIVldFR3Vrci9scG1jRUYwTkorNWIzRGNHOW8zOElq?=
 =?utf-8?B?ZE00LzBUUTJCbFlQUFRNRHRwN2xRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd6bc16-e8d3-4f41-9d08-08dad9694843
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:12:23.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV1ZvoGRZQORqPEZHpbD/4aoEhPVch0Eubn+Tl96A+sKkqlxy+RzyxuwyKvoO/yL6I0yCi2rAQEMpSiCEui8z7/zScj4YtaM2gMbaGj/TeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080184
X-Proofpoint-ORIG-GUID: t4PXUD0S_EY1rmzqA_E3Xmekw7yrFrKc
X-Proofpoint-GUID: t4PXUD0S_EY1rmzqA_E3Xmekw7yrFrKc
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 2:01 PM, John Hubbard wrote:
> On 12/8/22 13:58, Sidhartha Kumar wrote:
>> Thanks John, Mike, Matthew, and Muchun for the feedback.
>>
>> To summarize this discussion and outline the next version of this 
>> patch, the changes I'll make include:
>>
>> 1) change the name of folio_set_compound_order() to folio_set_order()
>> 2) change the placement of this function from mm.h to mm/internal.h
>> 3) folio_set_order() will set both _folio_order and _folio_nr_pages 
>> and handle the zero order case correctly.
>> 4) remove the comment about hugetlb's specific use for zero orders
>> 5) improve the style of folio_set_order() by removing ifdefs from 
>> inside the function to doing
>>
>> #ifdef CONFIG_64BIT
>>   static inline void folio_set_order(struct folio *folio,
>>                   unsigned int order)
>>   {
>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 
> Sounds good, except for this part: why is a function named
> folio_set_order() BUG-ing on a non-large folio? The naming
> is still wrong, perhaps?
> 

This is because the _folio_nr_pages and _folio_order fields are part of 
the first tail page in the folio. folio_test_large returns if the folio 
is larger than one page which would be required for setting the fields.

>>
>>       folio->_folio_order = order;
>>           folio->_folio_nr_pages = order ? 1U << order : 0;
>> }
>> #else
>> static inline void folio_set_order(struct folio *folio,
>>                   unsigned int order)
>>   {
>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>>       folio->_folio_order = order;
>> }
>> #endif
>>
>> Please let me know if I missing something.
>> Thanks,
>> Sidhartha Kumar
>>> Thanks,
>>
> 
> thanks,

