Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2E64669E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLHBnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLHBm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:42:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00FE020
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:42:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7NO3ml016818;
        Thu, 8 Dec 2022 01:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ds0t8uHxVsqA8NBXfDkgTVmBCsdCZPpOnFD1EuIujII=;
 b=xfQ5UOcM8kRqtq++1wWEPPSyQMQJumgLxLq6tKbAaxlDZrdd3IRbm2ryOuLYczpble3x
 24l6xa5agETY2rtHvwCt78GGHewgLQrZKFKIXANTvOO07rA8YESHrIVD2zQMZX65AnV5
 71Ppk8b40DX4Mhns5KocV8ythm2sTBk8sz7pstahj9s+7xdREGPgLVHeOMUyeterbqJN
 ojp77LHtZuohzvuGVdNdSo+9nnc9ZAem/ZQnKnt+4OIXSAsaDrQ+ZTehpDnmzsWQliBA
 Dd0d9c3W+kpGw8OiSIECTJK8Np2VYkxR5bDJXo5dZc54pi2GmTAxH+3Grfm25ltog9oN vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkhqe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 01:42:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B80jZbM001914;
        Thu, 8 Dec 2022 01:42:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7d8ke0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 01:42:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2QcHcLhYk/Yb71zb3gUgcYxp5GBRJ8xofD2wfzvlMRSPYVOLWC1Xc5WvGHIPza4tUJLsMMI4tQdCIyj4V+7fjqC5CsgtQNz+ef4vllPsr0gNee+8SZebtR5qEH6cqdu4UOZ+Joq+WyXwzHCvVEbl/MrdxJEdFmdE+TapJtNllQTAyeQ8CJa8cxhxGJ3Vj+HZ/OT2d4yl6cvgoumGSnPwsZ0/TcbNAj4jkSZjknEQRD/u6ws3yrMCWp3/g08xjLy3/MrLTM5imi0M3ivk6jvz3/L4/UYcIgHF1dwZKV30V4cDujx0uOCVtPJuD7utWEyac8KfKCMcOt16njBT/NLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds0t8uHxVsqA8NBXfDkgTVmBCsdCZPpOnFD1EuIujII=;
 b=DTdIgVHLsZBKNq7xairNv4DJioW8orTGoyV7Yh9g4RDgKlNvKBtJXSsj9LG2fhDmuAaKr00Z3w8KOcxDDLKOzedWF6RSAxruR6DLWOA9fgB8sXVIBt5J3qw4o/8xp/3d5x3BI8b+SAB5SYQSIuv2y8Lp1BEZywSaBo28LvzUMTq3gGJE92bFcyGjwKwy6gcT1HEEue9Lc8TX7TfiIFK4roGJFQAcyQnAfwzuZDi6UOjLScF9/3JiFlwBxH8rMikJOA4mEtt502SQR4ACBpe3PeU4f7UZEi0bRWRpnoPCoGX2yItwuRPAKi2WzvyJbliBX7DtEfSzQB+i+hUtU06yiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds0t8uHxVsqA8NBXfDkgTVmBCsdCZPpOnFD1EuIujII=;
 b=lWjoY/tkmlyeqhhaIMZ1fV/WbLVtkMI5/nonhXMDFLm7j5y2aoiPRXrFDY23oe2+Sv+LZf6dZsm2Xm+wRtvUsR5lm1LIyga1PVtcDL3JD8x1fKOE9QPIU3ezAtNPmJP1AyhBLZwORlMopBtb9dP6llud0XElLHAxuzUtDS2c9VA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:42:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 01:42:29 +0000
Message-ID: <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
Date:   Wed, 7 Dec 2022 17:42:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        david@redhat.com
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c290ba3-3cc9-445f-df62-08dad8bd775b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVJ89AA6l17MuVkPPseJlIDQ9MH9esG3mMYovMnDS/wP0a/3RwnPxswU/eAucgzgBNXQ4HfgeqdgX+SSBucUDhJkQFaqTpNPWonRa1zOJXfq1WfLer3RvrekEZv/I1w1MXHNe/oVWi6mCj5B2UqXg6HBBscH+Uq6sUFd1huF7Lbj9gioVBnNtvCMKuqcqoWjrRzjnN77UItsJhqUOHo0LwhO5W2Ueqy9SPbvx+OitxSz6R5mbalgV7LHZBhlNsFmfdZSnLh/3sOTPJUSpSMi2AnfWwxS2e2QCx93RmaHnmjOMLqFqI3BTMrDdBPhd9kDNaEL4JDgGvN1TnIuEDYNxMwVS33rfUVv/HJGo/MhU0GTmS0aoA3XBnpAO37FsHUCuXdALJ60SWtWhCBhb1j2w8nB1ohDCcbRetFP5EKhE5jla+qX/1w/cJmhls3yrhMz816r8Qfs0irtYfoLFRNFOpE7J9Vi+J/Z+3UpINlQ8KnosRETGchapgo7yG+r+stKdiB53Nii7TK30MxvPUJ72Q2ZXM3POd9r1WGyiQhpXOCc853qI4oF5gAp2d3dPzUuoJAQEU1ATM8Umhy3E/YJGj5bPBidlCqTjc1234w1vInub0llPY98aJazUEL2Mq5RaRXhumrfdIDl/EatbW3O0tuKtLogwIJYFtR4v88Gqf9WopVT4n8W5aXM7WhiocV5JghUQEzYRLn0M1K5VMxen6qmqpHjz3FgUeb13oKHhio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(83380400001)(41300700001)(86362001)(38100700002)(31696002)(5660300002)(8936002)(8676002)(2906002)(4326008)(186003)(53546011)(6512007)(6666004)(6506007)(44832011)(316002)(6486002)(2616005)(66946007)(478600001)(66476007)(66556008)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U242Ly9xNFFSTWVoVTh4WlpaUGtra1g2ODR3NlV2S0dPamJXdDBvT0RoQkNn?=
 =?utf-8?B?MStld3JqMDRlVkVhNE16TVVFVG1qeXJNdVFSSkNNMGVzRXdYaERVdFp1alZm?=
 =?utf-8?B?RU1vTmk0d0hEdkZmd2ZoMmdMSmY1N3BHa1R3TldKNGp6NVNJWVd3LzEwaEhF?=
 =?utf-8?B?Mi9YbnJhYU5ZZTUxa3dEeXZDVmU2dHpnMk9INTU2eU03NUhwSnpwWm1HRzk2?=
 =?utf-8?B?SHNndUVSdzZSTUdycVppSVRPTi9TL28vT2R5QVhKRm52QzhPWktqSnlmUlhy?=
 =?utf-8?B?M3ZSL1U4dkRxbjIxcjU0Z1AyZ2FJT3cwZnBaYXM2Vy9UaHBOU010QzVYUjRG?=
 =?utf-8?B?dS94YnkyZmJmbDRtOERIN1ludDlZMnlIU3c0T0p5SVJpYUhCQnYyTmQvRUFa?=
 =?utf-8?B?a0tnekh5Y1NicGlmZ1JsYVAzUVVYNnVkTVlCWVFJUC8zUlM3aFhQVHNQR2JR?=
 =?utf-8?B?b3dHREhDWGxZK21CcGlkdVdiRkVlNTZ3RWpTa3Qrektzc3V5Uk43a1lJdkRH?=
 =?utf-8?B?MmRzZ0tnbG15N214OEp3cmdBbCtqc0ZDQnRnc3JNZ0F0UmNXTTM1VVdRbnBt?=
 =?utf-8?B?em9DRmwrQk4xU3hSd01pTUFtVlFwaXhWb2dBMFdyRVJ2ckRsejJLUFArd3hW?=
 =?utf-8?B?NFl4UHVWL1VKL3JnclVWVnlwMElqYmFhVlFqY0tnRmU4SXYxZ1FQU0I3L0F3?=
 =?utf-8?B?TjE5Z3djMEJoM3VhK01jTFN5TXlwVHc5RE5vdEdBU1VYNUcwVGhRSEkxYnd1?=
 =?utf-8?B?c29waFJScDI2YkhWNlArQWtVZ1Rxeklqcnh3bFhIN1RDM05XYjk3dVFSeXRy?=
 =?utf-8?B?WjdkdC9xZG9nUC9Id3o2K01nL2Y4WlB4T3NmbWxUUGIwbm5DTUxUWTQ1dVc4?=
 =?utf-8?B?eFA5T1Z1TW1NaG56VzZnVGJpbXB4VWZCWlI5aDZVWUl6Y3JwSmRWWDNNN1lu?=
 =?utf-8?B?SlBtWVVHRnZNa01ZNCtyUXFCWHQzNkJYTDdrWlpoSy8rY2JTa0NSTGd5dXQr?=
 =?utf-8?B?Wklva1VGOG9WVTV2WWRGQ1hIdVd3eWxzZFJ4OTFBS0RKbmxGekMrNnFtclR2?=
 =?utf-8?B?a1RMbnM4QVdSNlB1M3RwWlZnY1VrWHA2dm1WMGJKOEZsTE52ZmpKVHNidTht?=
 =?utf-8?B?dk9mYkI4YmZZNlV6VjlLWkVKYXVtZ0liM20xcnBuZWhFbFh1c2plMjFONVZ2?=
 =?utf-8?B?cTNveDdnZzRQQnBMMnJNaFdMd01meDNVRmNTeXRIT2wrNm1VamNVMTFqeXRB?=
 =?utf-8?B?cjA0U3o0dDNmWjl2T2lQS3AvK1dnMnl4WmJOODl3UlA5OEpSbkF2MEZadnkr?=
 =?utf-8?B?aTQ2cjJNQm40MmIxZXVONXEzdmRtZi80S0Ixb0FsTytZVW5KTDhPbTBXM1lL?=
 =?utf-8?B?czZMU1prZktDN2Q4V2pvQTRvK0NmQ0NDemMzRUFDS2JIRnprSGo5UlhhdWlk?=
 =?utf-8?B?MHA5bFN3eXFrQWNoOFhxbWduRURiZm91MHZSWTJFRGhsamc3VHBQWUZIRUxp?=
 =?utf-8?B?UWhjY2lTZUVXNzAxWEF6c3oxaGl5U2licXRJMXVDdmRkVFFuYU0rNkVldUZI?=
 =?utf-8?B?RGo5SUZnc2VGVFlvb21HaXJxQjhPei9COVJkSFJjSnNvQVBmeVVUTndMMnZK?=
 =?utf-8?B?UlFNZTVqV2R5TkVyR1FYMjdrR0RHKy9NYlJVQUpWOHJLTG9zcEhvSUZDN3cv?=
 =?utf-8?B?d256U3UrRno5VmFvV3JpcncxUzg4dTF6Z3NuRVloSWJ5Ulc2ZUFFbnljMWpB?=
 =?utf-8?B?RmVraDl3dUc5QlpHeERKS0Z4bDRLSkdmcGhtc3RRNmxMcHMvRlpGLzhFaU1m?=
 =?utf-8?B?UWYzZ24wZEZ5MTlldHBrcDZiRE5LT21YNkYwdmRlSXh2NUNDa2ViMFFBUUtX?=
 =?utf-8?B?RzA0bGkwMjY3blFqcTVnamtTT2ZhcWcxYTM0QTZUczZGZzUyMW5icC9JaXMz?=
 =?utf-8?B?SUs1K2Z1a1pqU1BPUmwza1lybXpzTFVHRTh2SGJWSGJCVjhFSjBmWkgvdDA2?=
 =?utf-8?B?L2JvR3BVeExSa21HTWE1MkhPRFdKbWJCdS9Ja2NIQzVhTEhBaUwrcE5rVEw5?=
 =?utf-8?B?RkQ4QnVORFZCZ3JTQUhwejlkWG8wQ3IzU1lHQTdZVGl2bk9zZnJ5eG1JMWMx?=
 =?utf-8?B?WWRUdCt2UU9haW5vZ0lzS1VhZHFMZGpEaUp5YjB0d3JaZU0wck9jYzAxWjMw?=
 =?utf-8?B?VHF0bE12d1RqVi9GNU9yS28zTndPY0RMMFhNTDBFNHcveGc2NzE5djZ1YTNV?=
 =?utf-8?B?S1hTblM4dnFLemt1cmxjc0ZEeVVBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c290ba3-3cc9-445f-df62-08dad8bd775b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:42:29.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnEdGN/r1f/FDtNyWA05Zcy2mHFObIjFQBcKXIUFoUnvRGiKl0o7OxaisDf92I2ubqY+L9aTi9NzoXba1IsOuWSbOFOTMr/LE4eU/OsBW1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_11,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080011
X-Proofpoint-ORIG-GUID: cf4drvQJTaMGZ_-Gqkv3AK-fz7bbFrql
X-Proofpoint-GUID: cf4drvQJTaMGZ_-Gqkv3AK-fz7bbFrql
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 4:38 PM, John Hubbard wrote:
> On 12/7/22 14:37, Sidhartha Kumar wrote:
>> Document hugetlb's use of a zero compound order so support for zero
>> orders is not removed from folio_set_compound_order().
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Suggested-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> This can be folded into f2b67a51d0ef6871d4fb0c3e8199f278112bd108
>> mm: add folio dtor and order setter functions
>>
>>   include/linux/mm.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 443d496949a8..cd8508d728f1 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -999,9 +999,16 @@ static inline void set_compound_order(struct page 
>> *page, unsigned int order)
>>   #endif
>>   }
>> +/*
>> + * folio_set_compound_order is generally passed a non-zero order to
>> + * initialize a large folio.  However, hugetlb code abuses this by
>> + * passing in zero when 'dissolving' a large folio.
>> + */
> 
> Wouldn't it be better to instead just create a new function for that
> case, such as:
> 
>      dissolve_large_folio()
> 

Prior to the folio conversion, the helper function 
__destroy_compound_gigantic_page() did:

	set_compound_order(page, 0);
#ifdef CONFIG_64BIT
	page[1].compound_nr = 0;
#endif

as part of dissolving the page. My goal for this patch was to create a 
function that would encapsulate that segment of code with a single call 
of folio_set_compound_order(folio, 0). set_compound_order() does not set 
compound_nr to 0 when 0 is passed in to the order argument so explicitly 
setting it is required. I don't think a separate dissolve_large_folio() 
function for the hugetlb case is needed as 
__destroy_compound_gigantic_folio() is pretty concise as it is.

> ?
> 
>>   static inline void folio_set_compound_order(struct folio *folio,
>>           unsigned int order)
>>   {
>> +    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> +
>>       folio->_folio_order = order;
>>   #ifdef CONFIG_64BIT
>>       folio->_folio_nr_pages = order ? 1U << order : 0;
> 
> thanks,

