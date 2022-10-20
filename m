Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194E6062E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJTOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJTOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:23:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C073E1AE2BF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:23:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KDxbi8013099;
        Thu, 20 Oct 2022 14:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oDA76FvYITBlSHbEfX0s8L75NKxf4Oi+JoKzayh4O2Q=;
 b=zne8gIKT0+IExqS7hp6KB5W8PRoqXABzj+duhUuRf91gLOdip2RixFgt227uAA+7LiWh
 WkXIQ/21tXhPqx/M8Nlot0xI9Oi/SopyooUet3/SwQSWX72N45sioUT6LNifNcm7bLIM
 FhymyBx4SPeJ9ClWbE82/CrkRgYOk4w2/ctEeu5ph309IY4cOSYdLoM11Sh/jUGxQQDQ
 EoxgG0R/1Y1PQFTlxMfGvBEhYklPRtIXxbsZlwytj641OGiwZTPIesQHwrLBR+Wszy62
 TmXemAXk9yeq7lgQk1+e81/Lb8qdHzat/0lM6e/BzVOSPhsE38y8Lum9jfsOvx66c3Qh bQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nthkt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 14:22:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KCvH5B027423;
        Thu, 20 Oct 2022 14:22:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htjmb6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 14:22:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnKwZgBwfRK0z7t2Tbt6UQMGUd+U9emLavrkp6ByfTDUbQkhX95wfv3iD870qk6T2ChYfgaei/Q5R2lQVySTFjzoPTuPitWj4UBYDpQDS/P0eDlJJRXkyNH7YYuVRaLZpEHl11eC8z7VBxs9s7sR5nVof8TEFapJL8cPOLRRGpJlxbMeAdq/ZFBzMc+zovZ1NJ9YA/nM9GXDgrfKCxYPYvb3XqwoDtBsDVPvCjqMgqKrm7aX6Rsc79rYvDLQ8omiW0donJgGhLHs8Bsld/vCgnC2fYOeGuD4umW0R9hZRf8+qlQrogZAjA9vU6kkpOjLHIThcnmzuSXBd0ua5eKS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDA76FvYITBlSHbEfX0s8L75NKxf4Oi+JoKzayh4O2Q=;
 b=CpfT2FeH99LetQkpnCUx31LUUI8YBl4Xe44QsxDJv591WlrmQS1WqBhlvJlyYrqaJi0pHv3jbPXe56e7e3ogwf0lNPHWYExxfD8Mv+A/Ad7q3oxl7KUn+Nnrb/rlwxg6tr9Vdt091+88JsiKFxaxhad2vzh4VyzrjAOYJ6yFLny/WbPJ4MglqycbJ8xgDE0lPbUUPnN4ulFbd9PaixqCq2LoXmqaOb0TMjaCLdqlY9+l/Kvt9f2kLJrIQPkgrVVxM6hfThS9ql4lkdtrkkI7rUeXwzr4gZBLFWwdL4DEf+ozsdwdjs18zgMg6F/Jk8csgQTpM6VyyCDjq4K1bUFEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDA76FvYITBlSHbEfX0s8L75NKxf4Oi+JoKzayh4O2Q=;
 b=VEHM8PAqfHAxU1wfFfkIrBxSjSJ46adJrSgrZ+Ro9neHvBu8dV3Ir9oag68WDkLuJ1QW8ii2KOtkitGMvC/HGddoTRCrHz4Plnr7M9kgdwLG3TglEAGxhHQC+4yVl7wab55yVwy8eOr+zBm+Chk5bc3THxbwOH3uDyh3/z0joP0=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 14:22:22 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcd4:3c82:8227:3fd]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::dcd4:3c82:8227:3fd%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 14:22:22 +0000
Message-ID: <7fad3782-daf5-654c-f89d-e4dfb92bbf8f@oracle.com>
Date:   Thu, 20 Oct 2022 10:22:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH] x86/xen: silence smatch warning in pmu_msr_chk_emulated()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221020113759.17402-1-jgross@suse.com>
 <47668d94-6b55-2894-fa6d-82b1f17312bf@suse.com>
 <26bae6db-0e17-2b54-4046-0e85b26f6401@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <26bae6db-0e17-2b54-4046-0e85b26f6401@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 67da7cc3-60e9-4bc0-7459-08dab2a68088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzIpak83jz0mJUCNx+Z2tYjYxePZZpaia02PICBH2ySBeQ4wz/0SGqiGOwZ1CptMTBAY3658HxrCzvQH9f/uPygyxtc0ReTp86F2jEKUgzgTUT5arPFMkohjUdN5cgx6c3EWfzoscnFqNtTiNAJWmfdJSuUgRMbAHsUtmCKgVp1ftRGEDfpdQulTe6RXWNp+g6R5sdgq9+HbskL9Qk9XZ61aZqEU+j+0o+TSOVhYkpiuRRtyiFUCpyzR81wc6DPi5o5k8b2F7UpNV6J0T3gGjYzytgeRFYyiG/7t3+iIUSH9Ur0bspmbiN8oNICve0jpIS5+taRPy+VHwMy4EH/P81VFInHF0x58mf96RIn1ZAIt2AvbZpp7gdfvVS8Mu+FyxP+vF8H8iIMkhUUpB+MjwnAL/RbKCbqbvjbSG/mJI4ky9iHvCmZKmSt1HMS32V4Jxd0R6DELkz4TvOQxi2TAcTKVKV/MWjREkW1aBDloht3B6C2LKdJjuxAlRmrRPljMgE+D2lNbZiOKpzUoQBjKVgYXrJjPBjLHdxj5cZ3JAlzk2hWAvvbosBQDGvKOuWq3SmN3JS2Uh9n9DMGXZB5WhATcBVYMJw13jXXMvsOQNvaTAhYGcgdNYgP3AJYFu7gBOYBvwTVK+zhFK3j549zXJdR/ZuWCMitpxYSSehhQ3UE0ERRNPgrEuTO8Kp7b6g/dkKXggi6Jzn822AVwBCE8itsoCXb4CXuBxranvWz6AeQ7HUND/rxdPd0hXANrun7PdT+D/DVhZgcjVeOX72dkp3yUAOqzLuvZaT/Lbs2FET0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(186003)(2906002)(6486002)(38100700002)(478600001)(2616005)(53546011)(66476007)(66556008)(66946007)(86362001)(6512007)(6506007)(26005)(8676002)(4326008)(44832011)(54906003)(110136005)(316002)(6666004)(31686004)(8936002)(5660300002)(36756003)(83380400001)(31696002)(41300700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkVaSnhVbUZuYUh5Wno2RTV0cURBc1Jram5KVTNsNHo2U1NQQjBnUzlkK3ZN?=
 =?utf-8?B?bGhWamxTVlpUQ25VU0UzTVIwVU9aS0MzTzFXMVpUV0h6SWlSQUlzMi9Hbzdn?=
 =?utf-8?B?VVFuU2FiS3ViYUxpeHBFb1MrRUpFZzRocDgraUwvRVBrNWM0aFRPM1UwRitB?=
 =?utf-8?B?a09yV09MYzdId250cFRubW40RzNGbHc1enlJTDBBK0RpN3VFQmNyczZzR0Jv?=
 =?utf-8?B?UEY5Z1dmL2dwTEJqTThTOEhBdE5yS3pTeGpqdXUrbnBicXVsTmVTNTRrVWdk?=
 =?utf-8?B?UWFJMjV0NTI4WEZBcytiV1pvVnFRRkZocmRTQXZ5ZjhMNlBDc0p0OHZqUXlG?=
 =?utf-8?B?T1hNdTdadE9udjE3K0taZjQ4Wmd5M2dlZXFtc1g4RFJjYnVHazRRbXpqNm9y?=
 =?utf-8?B?TGV2SW9vWGNhbEl4Tmh4Q0ZyclFHZzZBN0dNU3JVN3k4ZDdENUNkZGpicGF6?=
 =?utf-8?B?bXNxT1hqTGZUUWMxaTNNVW5qcGNGRHNVWURuVjRUanNhMm05N3hzSitVUUNj?=
 =?utf-8?B?SVFib3QwSlpSc1AzS3h4dXNVNGxkZ1BaRlpLZTNsemcwMWk0cWlNaHZuU085?=
 =?utf-8?B?RnBzd2ZRR2VxNnlYU1JhSE1FV3VNNDF2SzQ3Z3Z3NFJnam90UDBqVHBzMkdQ?=
 =?utf-8?B?U1BtYzcvZnA2Z1JnTmE1dWZFeVJjMGdPdkx3QitGRlVqZ1h4a0EvM0Myc1Jr?=
 =?utf-8?B?N1BQZVBGNjFFVGxnbWV2S05oVG9WVmtOeGpMMk9BclZMQ09uR1hFN0lzNkxU?=
 =?utf-8?B?YXFyQkY1UVBTZ2Rid1hndGpZU1JQNjEzSVNyZ0UrOEdydlRpWW1HRFFRVFY4?=
 =?utf-8?B?M3A4MGQyOVlJWERPczZrUVpoQ3N4UjZyL1VBKzdwVGR0c2cxaUNOekVjejB3?=
 =?utf-8?B?RStibVQ1SmpFWmFqU1UrUXBPTXhyR0JIN0VjbDBWYWpidG1PakxRdWVZbmRz?=
 =?utf-8?B?bHNpQUwwWVAxMFJyM3dsa1MwOTRzN1RJZ0xOSTZmUmpRT1FNeTg1ZENqK1BH?=
 =?utf-8?B?dmdPMm9JZy9LOUNHR0d4RWFJTjA5anpHdStzUjNvM0dVdVBoL0Q2ZFpxTXA4?=
 =?utf-8?B?c1VLZ1NBR0wwN0l0S0ZGcnhjSXV2OTBYSWt5dTd0bDFhaFdPUU9odGQ2UnBx?=
 =?utf-8?B?VUZyMHBCVTRLSGNMNmljMUc1ZVJ0L3AwbjB0TnFRYjVIcHp5Q0FFTm04dHNj?=
 =?utf-8?B?TFV3VHB1MFRqN3JnVkhsTFdZWWRleTkxaStEaWlyTkFBcEZjVTVBQjF0NWs5?=
 =?utf-8?B?Tk5NN0hDZTBRYVZuTjJhMjdwNzZPUkpBZjI1OHdFWEU2RzNBdjJHNDNxQWJO?=
 =?utf-8?B?NFVjZ1pOT2Vnb0w4eXpTa3BZQWhjMVE3T0RJVFFLQkRMeERWalhYbmFuU09Y?=
 =?utf-8?B?QjgxU1BGd3FTQnAzemE3bndHTXpBVjdWdmcyMmh4T3daVWFJdy8vOSsxbmNK?=
 =?utf-8?B?TVVoQjBqWUVpOU1hNkpOYnJGL1JPeDZLeDY0TDhiTlE3K3htN1YwMHVzTVdk?=
 =?utf-8?B?enoxNVlrT0MwOE42MUdoSmlsVlp5ZXJqdGxWRVhVa3hYelVCSVkvUW1hU044?=
 =?utf-8?B?amFxRkp6d2Z4aVRtbEZXd2dYKzVJZ01hTkt6QlJCZXg0b1JsM2U1ajh1NFhr?=
 =?utf-8?B?M3pqaXBMeEFZbGlWM0k2R0dqbzgyUUdsT0hVSXM0bmtkZlE1NkNmU2NUZkgr?=
 =?utf-8?B?MElBb3VJVUs1TTQ2N0RjdVMzU0hNSWpIWTREdWtkZFZZS1U2U01FMXpFWXUx?=
 =?utf-8?B?TUdNUVl5Y1N1MGtxbkRtQUFYWXFyV01sblVRU1FOWTZXamg5YVl6UzRzcWJI?=
 =?utf-8?B?cmNkZnV5ZXhTc0hUa01BcmR1ZG5TOWt6SGdpcDlXR2x2cDhNQ0RKbHpVOVoz?=
 =?utf-8?B?aGlPeTVvVU16RUY2d3BDalE0cFRnN2syVE12a1VJcFloeDRtamhmdU41SWdV?=
 =?utf-8?B?N2hXVGIrWWJxOVBoaUZSbmdYb2QrZTF3bHJjY0JoK2xOMGJ0M1ZJd3ZtaWZ1?=
 =?utf-8?B?VDIzZXdqL2RNaXEyRnRTR1R5TWFWb3dGR05NOVpydldaQ2s4NU9JanYzNzRm?=
 =?utf-8?B?R3cyOXdadkFRc2drL3l5SnMwMzQ0bDZSUU5jbXRjTXVXWFFHQWoxRXVBODN2?=
 =?utf-8?B?S3lrbTZPSXJIS0xxMjNNNFR6cFRwSkhaeTh6Zm5wNEY4U2QwTWdZNFd5Z2x2?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da7cc3-60e9-4bc0-7459-08dab2a68088
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 14:22:22.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCganyRDOODqedaDF2hpSOjjxCZjHOc7O4k9rmqoj5jDrMb8InEaD2NlYJ2SzQutYNHyjWB12/u2tnZQzhE0Zt0YdaMoqTNqlTnWUYbOYow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_05,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200085
X-Proofpoint-ORIG-GUID: jyncAmDMA-NPX_ZWfE3p3kVUMZXuqUd-
X-Proofpoint-GUID: jyncAmDMA-NPX_ZWfE3p3kVUMZXuqUd-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/22 9:34 AM, Juergen Gross wrote:
> On 20.10.22 15:16, Jan Beulich wrote:
>> On 20.10.2022 13:37, Juergen Gross wrote:
>>> Commit 8714f7bcd3c2 ("xen/pv: add fault recovery control to pmu msr
>>> accesses") introduced code resulting in a warning issued by the smatch
>>> static checker, claiming to use an uninitialized variable.
>>>
>>> This is a false positive, but work around the warning nevertheless.
>>
>> The risk of introducing a problem might be quite low here, but in general
>> it exists: With the adjustment you remove any chance of the compiler
>> spotting a missing initialization before use. And I'm not convinced using
>> 0 in such a case would actually be ending up sufficiently benign.
>
> Hmm, an alternative would be to initialize it to -1 and add a test for the
> index to be >= 0 before using it.
>
> Or to live with the smash warning with the chance, that a compiler might be
> warning for the same reason in the future.


Is smatch complaining about both variables or just index? There are two cases in is_intel_pmu_msr() where it returns true but index is not set so perhaps that's what bothers smatch? It shold not complain if is_intel_pmu_msr() returns false.


-boris

