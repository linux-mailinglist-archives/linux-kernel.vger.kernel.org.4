Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93785F7DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJGTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJGTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:15:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB610E4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:15:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HIZRI019409;
        Fri, 7 Oct 2022 19:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o4JHEH9dTOucfFbUEu65T+Oi2B0Ah6Bi+JHNYlwwmc0=;
 b=eBOlZHaSzBBtGAojIk2oDi6MayrkwXMJfODeHYPV66rL5qnQf0ELkoER1kZZafH1VKgv
 9nwDoIR9d0U7XVxpxuKVaVPh8Vun42Sj1yuo4P5nWxH1s+8InTL9d8MkF3yUJt/Ki/0B
 eQGvbewKjt/KTIggTQ7galM33nHpi0HKpVTf97VRDs29LWVLQqzCjTEly9ShrB52IfSc
 0ynDAS7AGuk9UDIEw2DvzEMnFyftJ4HBp70OHSVfI+YVgZ8gl2mlIXwBH4h65rX85bDn
 lvPV8fIAjPZpvImfbOWHyITpnU5lxiu19bGasJE6huzFiaBMNG/1mSWeo5Sm2ZNUGtJz Fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb303xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:14:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297GePot003054;
        Fri, 7 Oct 2022 19:14:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0dpc0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 19:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm9hFbXxiPwsIi86TXoVKl0C9GH7GpUVwoR3aHGWJqqD4dwQAv4LTxkLU6GJohXSWBOw+YsAyAJv4CP7cBYhyHIs70tOAG0ICqv2kd3pdbZqcyJBWRWRKlnZgUrk27YdNTSRr0JIUOQSXogZAT4JjttnNYQJ0FxH3XkTFxDZYJ1UAdrOyd3EEdodywpS4VSHt+dfIkt6GObplKJnRz1w8ewq4dk5965Jz7jBC7y0ND5MQCtNG6YV4xPTrR5ZoY8rB7JQ7UcV95I2pEHQuH+j3yMbyEt3t4wHANXZT4h/uYEZ7gVfApJfc5jA0LyGNQOIpIaTRtQcccfLnolw7IGNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4JHEH9dTOucfFbUEu65T+Oi2B0Ah6Bi+JHNYlwwmc0=;
 b=GcLGl17hhdyBreFodxqrmMLY3fJaC4hcbP/TlkFzb7SMxXp7KuVkvNRRJ+XDWp8gzIp1Ovjd4NQOBMvuvXB+wm/VE57HCO3O6BeymBJVZmmsV0ldE8ZNmzXi7ODoJ2lpdKH863jCknbzOH0D0jm5qW7fvU06uybW24JNv+sV0fM7HaWms2opMsjhv9MkTTFZwULCoGUybFGXMrLmkRlOUxi9e0Eyvj6pcw1zvTbzMMBLsvXtilcXfIerwta6s64f3Pl9Yd2m1CbnSPA5GB3wbeM9Af3m+gN0TEKj901yKj+Ht1GWT0KMY5csTOP5XGMC+P5NlkWe4vGzhZWieKwC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4JHEH9dTOucfFbUEu65T+Oi2B0Ah6Bi+JHNYlwwmc0=;
 b=opBvJLGPos1tE0b0B+qj1MibZ6jS79A3BvI2zql015SBzXhmUThD+bxcRuQhs6VJSjIJOFVJYzQZHC2zY0LGKF96MNZwD8yCdjEDUSxWKD8DvSZt1taem/kszqD5NTnjQvMYmW2Yt2SySh3KOA3rurjll1PSCXqE1x1N31rcSa4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB6787.namprd10.prod.outlook.com (2603:10b6:610:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 7 Oct
 2022 19:14:44 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:14:44 +0000
Message-ID: <97f2daae-f34a-86bb-6d28-8aa8314321bc@oracle.com>
Date:   Fri, 7 Oct 2022 14:14:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <8cc31b22-a061-d07c-77dc-c555b8b35af3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: bc58cbe3-1185-49e1-23f2-08daa89830fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWeBOqWp17zdVTg1deqzzOBtP4zx/UTXAAJTE3jebFwhXoJRp+Cuw7omHiDjn6Gg/CXEJzy3z4VwpMLwTAGfW/n+66g7b/XR0IwHLNNyAJghfvRmAbPCTnAiKVU+/kr4CJz5Z55d1qF9iJCwDoYUL5S4boKPjBO2qL69vGvX7l6UtQXGcVPX4DPvpIiRCz5qzdnjIclQgIhSFs6wWykXlO5Kste/TkRowLs05bvs7Pnh2g4weyBKV8f8OO3pQcsfQ9TsnxIvE8AyjdToPMATR1G3L1OK0vnWiacXecPoiow13i+QUjegiFZtqG+tPMy20utgk3Zfgqt9qJwovCrZo5BmqQFusFCCo2eqgQrZ37EdJvK4CD6UVKBL28AUJckjkMqoMgwXAAb02J2O9Nxueu/7zHYvvE5lrnJVVLrnxO54k29QBvldtyj4vFOWslUEeT4sQJgHxpzXNwsI+n9zRtOIXJQ0Zp22UxGv9lr5y7txFQbAJkeddyCC69624r+C763/K6OI9ERnPttwrgji5TKDqaU9bBgYV23HuqhLxq/XX6Y6eQ0TgGNi+3ezvBce4uxiB5MsCX8Ecrj1ju1MBLIzB9FLCxCIlbPG6Ypxs+2OaNVazsC2lasnHDhCUoVxd0z8RSV9O7oVwi+5KWbP8zrVXYjP3ZnVJO9Kq8NxL95+pGsBoKFhtHCwgaiiYx0DXQSC3t9Ct3qgPLKa6GNlzdMUR6eerXyTud+IfG2sQHBHVu7bJ3PYo7QfwZrgfMHXlyFGnqNKBuL1J53DGtzNZRVSxwPSesdkbQQbXTnT42ZrjO9odwyBCqVFMbjQSxNp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(36756003)(31686004)(6666004)(38100700002)(83380400001)(31696002)(86362001)(186003)(2616005)(6512007)(478600001)(2906002)(6506007)(5660300002)(6486002)(53546011)(7416002)(316002)(41300700001)(107886003)(66476007)(66946007)(4326008)(66556008)(8936002)(8676002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01nSnlZQzRhZnlRQmlzQzJqOG96clJldy9wTE1Ga3JuZ3J5VWY4cVVnUC8v?=
 =?utf-8?B?VUEzQTU4UGQyczJNUFliSU5iK0F4bUVFZU56VEFCZzFkL3ljMzFUcDg0d0tk?=
 =?utf-8?B?TFJkaHFOZjJGdUlQZEE3WGZqUnQxZFhQUk41cVY4VG1RYUpxTzd6cStQVjFx?=
 =?utf-8?B?MUZKSm5FZGZndzNaMkpKakRsZk5SOHJxN0QxTHZXbWI1UjFaV216cmtlSlJ2?=
 =?utf-8?B?Rm93K21pRUpXaWwwL0E0VlNWSStiVlZCaTJlUytyVFZEbTg0WlphVzRiaVJY?=
 =?utf-8?B?YUhoUi9SbDFQcWVmcEFjQ2dtLytkQjR3bjVwZGczdjloT255cngrc1JJOWUw?=
 =?utf-8?B?bHFpdXptRmZhd0NxMmF6b1pqT1FSSVFvcWYvZlR4OE9iR3lua3ZtaVNGQVJU?=
 =?utf-8?B?b0lvVHFyZTc5M3VXTUd3cHF2U0VaT0xyQllpKys3T2NUdnZGb2pjeGJ2Tlgy?=
 =?utf-8?B?VDRXaStza2NlRUd4UStlaDFna3Q1WHdwdWR2ZlJjdjRkL2R0ZFRVQ1EralYr?=
 =?utf-8?B?ZEk0QTk0b1NFbitHYmlJcGhGeEt1T20xbVRML3J5eWJ6UTZzZDJRd05IaUdE?=
 =?utf-8?B?Y3FRRFAzLzdOZ0lTeExqTnBMVS8zQlE2ek1WdGF5UkR6RHBTT1FIVUhHeTJM?=
 =?utf-8?B?Umg1cnhLS1hpd1IrZUhEREdkVnBMNHIxc05tMi9FNzRDb25qYTR3S0ZYZHNt?=
 =?utf-8?B?c2QreHh2WExZSFUvTFJWM0ttNkUrUjhkL0xGY0ZJZTRrTEpnNTBEVjZXL2tK?=
 =?utf-8?B?U1JqVzJrbEFBS0RPazF4ZEJEbk5qbXlmTUhWUU56VWdFRlFJWjZyWGZLOU5u?=
 =?utf-8?B?TDUzZDd4N3g3dXdnWC9jRm5yelc1eC9mRTM1YXFXTnFzM1NvUk5vMEgvN3Rn?=
 =?utf-8?B?c2NxekxScU9xWXZCNkE5RGlnY2xGQS9OVEhpbmlhazlzcEVheXV2VlV6ZVFx?=
 =?utf-8?B?bzNXczVXR2JiS00yVmZMUDFYcUFLV2VOZDVCVm5kSk1WN1ljM01hZDhkL1ZE?=
 =?utf-8?B?RGFpNnQ1S29DZUhWdVM5UHk5U1J4aVRVUjhrSmpQa1Rya1B2cVV6eGZ3aUhK?=
 =?utf-8?B?NFFOdmRoYXhxZEg2cGpoV1BXQ2Rob0JDQTM1MENnL3lRQVJDLzNDSm80dDFR?=
 =?utf-8?B?WDhPbHhlSktXN002Mk4wbWpEbjRzRG1JTW9LSTJYOWZnMzJaazlzT2xEUHpw?=
 =?utf-8?B?SzFIa0UraHpPUE9mWFNIMXo1MmZJekRQbFhqRVNkN2FnNUZQU1VuZnk1cmR0?=
 =?utf-8?B?eWk4dk85aTVlNk9xUnNSMFZKTkJ0dzk0OEtHZE43MkFwNUJSRk8yL3ZwZFNz?=
 =?utf-8?B?UHRzdm9HV1J0cG5OZVdtbk9xYVJTenkySDRSSXpyU3JiSTdxRERhQTJENSsr?=
 =?utf-8?B?NlNNblVBTUw2MXRJRHg5Y0tyWi9LS2cvakV1NWk4RHdiZlpTbnc0WHoxVGVv?=
 =?utf-8?B?NWFkUmphN1Y2UTQ1ZlF2WlJGS0dvakV5WFByQUFPT0V3RHU1eS92ZTdHbThr?=
 =?utf-8?B?RHdBcG1rYmRVbU5YNisyREd5cXhHZy9TRHhEeWVwbnliV01CdkJyYTBnWWEw?=
 =?utf-8?B?Uzd5ejhRRnR4V0xuWVIvTUl4VjhRd1lDaGRZR09ZNGZOWGVJVy9DM1V2VVdm?=
 =?utf-8?B?YS9DQWt3VHNlQ0JRdVpjczVyTjU4N3JvUVdsN3BqYVV2dUpFWjFjanJ2WW9G?=
 =?utf-8?B?c2RQOXdqSDNzY3Jlc29QS3ZQTXRyRUJWbytLRHJJWnQ4aDIrYlRWMVJhellF?=
 =?utf-8?B?TVFtYktQRGZuaXlieGFxV2FQYjQwcmE4eDBIak15ZHRnRFBYbUVtTWRpNlpN?=
 =?utf-8?B?VHBXNktxdldLUHlGRzJZUHNwekhWSnpmK21ScUJ4eHZTRytiWjZ5eXd4UWdq?=
 =?utf-8?B?Z09VQXN1K0ZFaXlJdE9NeTRhYi84OTg3ZjZrRWZSakNLS21YeUxGbFFBUHFa?=
 =?utf-8?B?Uml2ZG9rT01HalUxbVdVVzNTQ0U5RVZKdFVTOUcvdDY1Nkh2RmdFQTduVHVT?=
 =?utf-8?B?OTZ3a3AvMEY3cFdQc1Zkc1pDeitkSVpuS2hmc0h6VWVEcXN6dllxa05IUkNQ?=
 =?utf-8?B?eXNzWU9ERWVaTURNa2txbFVDdFJhbmNORUNHZkhqYkVHc05HOFkya1RUSzk5?=
 =?utf-8?B?YjY1VXdvaTI3V1JKVjkvUWRiaWtzZHBTNytmSWozQ0dXSE9hQTBJU0xtRjVa?=
 =?utf-8?Q?En7Oke63y9eQ6jhGNAUe/NY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc58cbe3-1185-49e1-23f2-08daa89830fb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:14:43.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isKmzWfUVxdOgJtM0uqbhEopHB3KBAgLa6zQ9Y4gWpLUhvs65YRHJC+mL88a5Q9ds3ysZoZy96QzLxikgD156x0nyxIksuOhCUhwo03MqO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070113
X-Proofpoint-GUID: OgQff144XLwcFHa0CtwJkRhzq6Vbn42k
X-Proofpoint-ORIG-GUID: OgQff144XLwcFHa0CtwJkRhzq6Vbn42k
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 12:51, Sourabh Jain wrote:
> Hello Eric,
> 
> On 10/09/22 02:35, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/crash_core.h |   8 +++
>>   include/linux/kexec.h      |  26 +++++++
>>   kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..a270f8660538 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>           unsigned long long *crash_size, unsigned long long *crash_base);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU        0
>> +#define KEXEC_CRASH_HP_ADD_CPU            1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY        2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY        3
>> +#define KEXEC_CRASH_HP_INVALID_CPU        -1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4eefa631e0ae..9597b41136ec 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -374,6 +374,13 @@ struct kimage {
>>       struct purgatory_info purgatory_info;
>>   #endif
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +    bool hotplug_event;
>> +    unsigned int offlinecpu;
>> +    bool elfcorehdr_index_valid;
>> +    int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>       /* Virtual address of IMA measurement buffer for kexec syscall */
>>       void *ima_buffer;
>> @@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>> +#ifndef arch_map_crash_pages
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +        unsigned long size)
>> +{
>> +    return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void **ptr) { }
>> +#endif
>> +
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>> +        unsigned int hp_action)
>> +{
>> +}
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 8c648fd5897a..4b15d91f0b21 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -18,6 +20,7 @@
>>   #include <crypto/sha1.h>
>>   #include "kallsyms_internal.h"
>> +#include "kexec_internal.h"
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>> @@ -612,3 +615,134 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +/*
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. The elfcorehdr memory is
>> + * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +    /* Obtain lock while changing crash information */
>> +    mutex_lock(&kexec_mutex);
>> +
>> +    /* Check kdump is loaded */
>> +    if (kexec_crash_image) {
>> +        struct kimage *image = kexec_crash_image;
>> +
>> +        if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +            hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +            pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
>> +        else
>> +            pr_debug("crash hp: hp_action %u\n", hp_action);
>> +
>> +        /*
>> +         * When the struct kimage is allocated, it is wiped to zero, so
>> +         * the elfcorehdr_index_valid defaults to false. Find the
>> +         * segment containing the elfcorehdr, if not already found.
>> +         * This works for both the kexec_load and kexec_file_load paths.
>> +         */
>> +        if (!image->elfcorehdr_index_valid) {
>> +            unsigned char *ptr;
>> +            unsigned long mem, memsz;
>> +            unsigned int n;
>> +
>> +            for (n = 0; n < image->nr_segments; n++) {
>> +                mem = image->segment[n].mem;
>> +                memsz = image->segment[n].memsz;
>> +                ptr = arch_map_crash_pages(mem, memsz);
>> +                if (ptr) {
>> +                    /* The segment containing elfcorehdr */
>> +                    if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +                        image->elfcorehdr_index = (int)n;
>> +                        image->elfcorehdr_index_valid = true;
>> +                    }
>> +                }
>> +                arch_unmap_crash_pages((void **)&ptr);
>> +            }
>> +        }
>> +
>> +        if (!image->elfcorehdr_index_valid) {
>> +            pr_err("crash hp: unable to locate elfcorehdr segment");
>> +            goto out;
>> +        }
>> +
>> +        /* Needed in order for the segments to be updated */
>> +        arch_kexec_unprotect_crashkres();
>> +
>> +        /* Flag to differentiate between normal load and hotplug */
>> +        image->hotplug_event = true;
>> +
>> +        /* Now invoke arch-specific update handler */
>> +        arch_crash_handle_hotplug_event(image, hp_action);
>> +
>> +        /* No longer handling a hotplug event */
>> +        image->hotplug_event = false;
>> +
>> +        /* Change back to read-only */
>> +        arch_kexec_protect_crashkres();
>> +    }
>> +
>> +out:
>> +    /* Release lock now that update complete */
>> +    mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +    switch (val) {
>> +    case MEM_ONLINE:
>> +        handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +        break;
>> +
>> +    case MEM_OFFLINE:
>> +        handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +        break;
>> +    }
>> +    return NOTIFY_OK;
> 
> Can we pass v (memory_notify) argument to arch_crash_handle_hotplug_event function
> via handle_hotplug_event?
> 
> Because the way memory hotplug is handled on PowerPC, it is hard to update the elfcorehdr
> without memory_notify args.
> 
> On PowePC memblock data structure is used to prepare elfcorehdr for kdump. Since the notifier
> used for memory hotplug crash handler get initiated before the memblock data structure update
> happens (as depicted below), the newly prepared elfcorehdr still holds the old memory regions.
> So if the system crash with obsolete elfcorehdr, makedumpfile failed to collect vmcore.
> 
> Sequence of actions done on PowerPC to server the memory hotplug:
> 
>   Initiate memory hot remove
>            |
>            v
>   offline pages
>            |
>            v
>   initiate memory notify call chain
>   for MEM_OFFLINE event.
>   (same is used for crash update)
>            |
>            v
>   prepare new elfcorehdr for kdump using
>   memblock data structure
>            |
>            v
>   update memblock data structure
> 
> How passing memory_notify to arch crash hotplug handler will help?
> 
> memory_notify holds the start PFN and page count, with that we can get
> the base address and size of hot unplugged memory and can use the same
> to avoid hot unplugged memeory region to get added in the elfcorehdr..
> 
> Thanks,
> Sourabh Jain
> 

Sourabh, let's see what Baoquan thinks.

Baoquan, are you OK with this request? I once had these parameters to the
crash hotplug handler and since they were unused at the time, you asked
that I remove them, which I did.

To accommodate this, how about this:

static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
      unsigned long mem_start, unsigned long mem_size)

For CPU events, I would just pass zeros for mem_start/size. For memory events,
I would pass KEXEC_CRASH_HP_INVALID_CPU.

Thanks,
eric
