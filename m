Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F0622F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKIPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKIPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:50:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7413F7E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:50:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9FllXo029498;
        Wed, 9 Nov 2022 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gBKlWJyK96uSEmTPaJ6xAQ2sDli4RNPEwvLVTZxN4lo=;
 b=upvrJOnGp38kciwuo3/FRNvXF8oith6sjUTsqyGxcA+/Y7ko4tTef6B1lytvdBN9Nfc3
 l/RNiNFL4DuFJbMb1jGNqGJhYyoFhckpaP7Jkb2l0pb7WcXWOpO21qn26ueH9u/mjqlW
 EK0ZO5MVr0rzC1seFkZmg2ODOXxtNXafRP+RbAiQOJsOwGNFv1ZshQZqwJE1E5cQr1K1
 RMRxbewwhlO/idxNmloAbRw9oIuyFF7w7wKbx2ubNDKN5BuKlQ+7gFJpm4YOJ4EP8G7F
 MQ672otaPPL2JsGkZRhcWNLLo5jGvKsYn160QBd1YZXT55/elfemUmBRll9gyh2EwPmi FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krf5mg0b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 15:50:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EH918036389;
        Wed, 9 Nov 2022 15:48:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyqen6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 15:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iw7BnbvBS6ss3rY3QVH73Cprau2AfIttpOwCNDGy/FXOA90b1S440xrw1UC/HA3Sa3OpSEvIiFqvYLk/hSU7EXcBOTCRB+EY2qEt6xmneoKLz/e7tgXdKR/VvpGukMM8WBzI1Q+F54i+CXzi1dFS5M0AV9yhq4nQG1WDFbTRwoLi33hneVHvEYY8ilcIEAP+xiIaQ2N8rA5g3prakZNHTSfVTYl/sAzrRl9L7OGQ6bs7cPI2/nDj1nISIEx4hRJHL/+qWa+Zgr2MGOdprpdDbJLG/YUHBcaTwxnDH6nV4E+egKEHLeFAWWWTw7KqENynPPZvtUVrWk8ua+drsGPOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBKlWJyK96uSEmTPaJ6xAQ2sDli4RNPEwvLVTZxN4lo=;
 b=WpL1oy/npvpA3RQ6glE/nVV+6/E0w4RxK5NaQn6LGCPuKQwL2E6dca3AV+Axsgy+L2S1G/WHkZEAWVZEjm0A3GaM0K9CloQAGSaRaZo46DWEo841PLsCRrKG/RV9w0zRpWGqwiTwwyXvtO9+dPdJw6hPvM7ZvCO+H5C+P2OnSfrpPLfnArH0gBkw60Eskmq+4Hge4acFIHUpVD4WsfcKGYjnH8RTrQSaZf18Mn7OFa/SVodLAXXnMEWfrAyCHkAVnk/a148tpxjsUvPCpjznH6WFZD5ghIidv7mMcCzfnfDmEEEhX1YMBKIwjpoebNas+4qQNDB5l6bUr6udUm94xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBKlWJyK96uSEmTPaJ6xAQ2sDli4RNPEwvLVTZxN4lo=;
 b=jwyesztJ7qUYOA33ew5/Yg62BUeWdr00jG/pxgntHm1gKj1AIsm/BwmqJjRmafkBgtZkfTAJJuZU4zCfG1fD54RJkgwUbOC+SvAoEWDCihr1ACwTPSe+x/o6dwYVFY/RqimGXvj5952eYlSsgoJkfeJsuwZbg5urOv3B6h9C1Z8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 15:48:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 15:48:41 +0000
Message-ID: <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com>
Date:   Wed, 9 Nov 2022 09:48:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com> <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com> <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:6e::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd595f6-fa74-420c-02f3-08dac269dfc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RBEXq87shcv+14M8qSJyEOscKRgog7xiy3IMi9T+dxQfZy2n89i6r5Ct4N51QKhJLRDXZfhs8BTNItp5QEW9BkCZ+8XmYBExmtXx8ZjDXpW5zDRf7BeF8PClbNgZxzCcFbykpCDaBtazYhNyGSty8HIxwFcY9hM4/YFuGiMVyzMdi3pBP+AiRY68ppXoZG/ocMJVJl11SnMA7dYeakIQ9J0i16rj53oI1vkHlboKh6r6RwvjmlTjM0IhNsFoGOgr6dwj9ls+tla0XuFb9LRy7vqEKqAyL3XG13+9CThJDKDMXxqL6ned1fLkkwvJ8m6ZwFdig1qxAIz63IOJMytAX/ovkeYJicumbEJsuV4P4BUZf+DRkOEZVhSJKcSlt85YJpk6h0yMUmYbRGXT3415BSjveXUKGOsQYcABr33JRRE1saNA98OZoOqEy4GbkTF9PqfWZLDh5BC+AmliDT5zhMHAIRk8cS1xWpiYmtIXjQ7EHIRyiWD02csce3CIIeHqwYOpQYKGgCyYo1YbxuifrTFvn3NPbuweBko2gDVE92ZBJaBlB1+qcTNNb5dnT72G8Cifc6zL3WLzWttVUYVhl5fqia7Q/AG86dMZeca8NiwP34XUdCuXoflXpCZXWwVPxOSuxTJhE9yDAW8gIVSSKqempYvHr8VDnGFzd2GP+vFaQEwTdse9yU7xlzZSMgAFDY4pY1ciz9T16gBruMnkf4ExC4T2PjnTN+/qSD5M4YyAC/7h/2L5n+Yice9+lfP8v1x19h9MCC2r4llVaMmcPGouy2NhFCFQiEMJ0844zA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(478600001)(38100700002)(2906002)(6486002)(2616005)(83380400001)(186003)(6666004)(107886003)(6512007)(53546011)(6506007)(36756003)(316002)(66476007)(66556008)(4326008)(8676002)(31686004)(66946007)(86362001)(31696002)(8936002)(5660300002)(7416002)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJrOHMzaWRuaWN1akRlUVBmR3drZDRmQ2dtMmNScFlhUkxmbnJ5SldENmFZ?=
 =?utf-8?B?UFVBd0lFbnlRd1JpdnA1QXg3Q05JejIxc3JqY2JJZVREMlhHWFplV2ozdG4w?=
 =?utf-8?B?YmluWlE2VEgvWnZUbHBqb01KQ213VmJQMFl6OTI3SDBLdHM2b21tNGhFZXha?=
 =?utf-8?B?QnJDZlZTdlZtcjJMNCswV3cvY05aNW1qOXBTUWtaUFZLdnE3MDM2Nm5qSFNN?=
 =?utf-8?B?bnlxT2ZIelJsU2ZZaWtPSktKT0k4UlhqMVFJVGFPN3lhMnRscHJRSEd0T0hm?=
 =?utf-8?B?bk5DTnMxMHdYbUFBVWY4YWlSVkl1N2UzQ25KQTNQdkUvRmcxSmtrdVF2ZlBO?=
 =?utf-8?B?dzZtekxIYnF1bVAzSE5jMGdodmh1VllyV0JGeHdTb0JHVmFqbFIyL1hoUjAx?=
 =?utf-8?B?b1RGM1BLWC9zNWE5RElVQ0pVQk40Ri9CZjF3RmlrWWRLMjdhbXhvMG56b3lQ?=
 =?utf-8?B?SENkTTluSzRpU2JNNmVlVTBhTnh6cktxTUZkUlp2NlRPcW9XNHlJMGRwTFBV?=
 =?utf-8?B?TVdXNjUwVkUxR3ExOGJaaVdmUzB6Y3hTa2ZCaHdXc1dwaFpWT2hXZ3VCaXBl?=
 =?utf-8?B?YmZqditXN0VhU2Zpck9PZzAwNC9XbWl1MS9IRkhqYmF1YTFLVnFGOEtUcUJK?=
 =?utf-8?B?RjVlQnZCZEJ6dU9WS2dFRlJJN2ZWQ1JKUkxNTHFRN2tTWjd4dXErQWxobzdI?=
 =?utf-8?B?RlNPdXgrQkxvQkJkRnpYeDZiY0FYV2VkMkdLUEhvbEFscXNRZ2MxN2Y0TTFX?=
 =?utf-8?B?eEVyTlpzUE9WY0N4dEhQaU45WVd5K3IyVjlVL3VZTit6bC8zeklFdVFIVjlm?=
 =?utf-8?B?c0RxMnBSalJKMUpWRnUya1RXQTVjNVRyWXRQa3g2bzVJanFjWkZ6Si9lVmgr?=
 =?utf-8?B?UXRmRVV0RHdVaHl5YzJEUHlJMU1KYXFuRmJoL3cxVUFlWEJWNTJaQjlyS3dq?=
 =?utf-8?B?ZmYxMnB3U25NVEo3dG83WFZRZ2dqMVE1elF5S0Q4WjZXUUVOVWV4eHA4SDJ1?=
 =?utf-8?B?L2FiQjNTNW1FaTJ4TzZIcmxldVJLV3YvdFduM3ROZUp1UkljWTE0VHMrbHd1?=
 =?utf-8?B?cVYzeFVjc0ZZQzFqOEV1L1ZhTG1aeE9wRmk5T1NlT09pdDIwL1dDbmVHT04y?=
 =?utf-8?B?TGp6cHJocnYrc1A0ZDA4VWcxdG5UeGRQOVV2K1ovdSsxdy9PTmliQ0pUa096?=
 =?utf-8?B?UnZsREppUTRYcDE3M1hpdkk1eERtOWpOdnBVS0J2QWJoWXNDZzZxSmYxZzlm?=
 =?utf-8?B?Rm9tSWYrV2ZMazAwUFN2ejBTRklRbklBbmxDZVB1a3NMV3pJcUh5VFQ1QzZu?=
 =?utf-8?B?Y2M4dnZlVnVidDdWMXlHOWNhWWhWUldJRkFOSURlWjJJZHowb0NBTGZIWUtx?=
 =?utf-8?B?ekVTajFUSTUxWmdiUTcvYmU3cDdDWXZtVCtTeFRhY2E1MXBQRjVkZHhqa01V?=
 =?utf-8?B?VXFRaDVQR1RZNmJrVmRqQWIyNXFISlI0UkpZNlc1WWpHREdKd1BDN1IyWUF1?=
 =?utf-8?B?aW9xWEdXNVR1QVZ5cUVteWRSOGlIMkozOGxlVXNlV0lDTDRPVVpzWUsxakI1?=
 =?utf-8?B?NU9QVXlhai9JZERhZVdvTHgwczgzNVRtVWhpbWM3cE1DQzl5SXBEdHVpZVoy?=
 =?utf-8?B?VGVWUFhCUFE3RE8xK0ovRXlsQ2lJckQyZis1a2ZYR2JLWjg1bVZoT29RTk9I?=
 =?utf-8?B?RlM5S0k0SWUxSmNGNGtSM0dUVTFYYzFVb0hJcEtoQU1ZVHA3am1HcHMrZ2Y4?=
 =?utf-8?B?bGh2bmlUSjNvTThjcnVacEFRbTRJQndpTkZaZzY1Q3pzMDBVdW9ncWwvYm4r?=
 =?utf-8?B?NUdqRytSOXpBVVl6MGk3QndLRy9vSUhkSWJFWnRtUW9zSHVMV01NOUFaNHZD?=
 =?utf-8?B?cU9BanhlVFR1YVZuendQRWNOWXRYT2x4dzcycW1SNC91NXJhMjdHcWowd0xX?=
 =?utf-8?B?ZmM0bDlQSVpsQkY2eTlTUWc4VmNXQ1d4Rk1BblJYdGNDeHpiM2FValR4aWN1?=
 =?utf-8?B?d211dThYdytqNHlnZk1lb09EQTJPYUZ1R3ZpZEJERERjVE1ONS9pZnNLbENn?=
 =?utf-8?B?WFhUWlllbEJEK1hsKzRNRndMaFVSTnFBMW5yVG04UXJwUnNiMFE5S2dJYi9u?=
 =?utf-8?B?cHYrN0xlRUNWcDhJU0N2Qk5ORm1wdzBTeDFtS1psL1YvcXhvWEkwYnZXb3pn?=
 =?utf-8?Q?tb8sPrKOhIKqFhwrOxS6nec=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd595f6-fa74-420c-02f3-08dac269dfc1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 15:48:41.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRop5+vlNhNG7edFoCA5qgSTny8utnPeSgIvDK9ZSnfw1YrZUii1aQYm/a6ml+vg+/pXRhNuM4XBhUBRq5xZgTo69FqoSCbBqJaADJ+ouJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090120
X-Proofpoint-GUID: Bo36abczxZ5O0rlpxj_9lBdKRYMVcUxu
X-Proofpoint-ORIG-GUID: Bo36abczxZ5O0rlpxj_9lBdKRYMVcUxu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 04:26, Borislav Petkov wrote:
> On Tue, Nov 01, 2022 at 10:45:00AM -0500, Eric DeVolder wrote:
>> As I'm re-reading that message, I suspect now the preference is to just to
>> strike this ifdiffery line in this file and have the code always present?
>>
>> If the preference is actually for CRASH_HOTPLUG, then let me know.
> 
> Well, it is this part:
> 
> "But on a plain simple laptop or workstation which has CPU hotplug,
> would it make sense for the crash ranges to get updated too when CPUs
> are offlined?
> 
> If so, I think you want this code present there too, without a Kconfig
> item."
> 
> IOW, if this thing doesn't make sense to have on the majority of
> machines out there - and memory hotplug machines are not the majority -
> then it should be behind a Kconfig item which is default off and gets
> enabled only when the user selects crash and memory hotplug...
> 
> I'd say.
> 
Boris,
I apologize for the delay in responding, I've been away for the past week.

I'm re-reading the thread on this topic, and I apologize for backing up a bit,
but as I read the last paragraph again, your contention is that the bit of
code in this file *should* be behind a Kconfig item, and default to off, as
"memory hotplug machines are not the majority".

Does this mean then that I need to introduce CRASH_HOTPLUG again, so it can be
default off?

Examining arch/x86/configs/x86_64_defconfig, neither HOTPLUG_CPU or MEMORY_HOTPLUG are present, but 
CONFIG_SMP=y.

And in examining arch/x86/Kconfig, I see:

config HOTPLUG_CPU
     def_bool y
     depends on SMP

which then defaults HOTPLUG_CPU to on and thus this code/ifdef in question.

And as a reminder, the '#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)' shows up 
in only three locations: include/linux/kexec.h,  kernel/crash_core.c and arch/x86/kernel/crash.c.

And we resolved in this thread last week that this patch series is useful for cpu and/or memory hotplug.

So at this point, I'm still not sure if you want the ifdef line:
  - removed altogether
  - transitioned to CRASH_HOTPLUG
  - leave as is

If I could get clarity on that, that would be much appreciated!
Thanks!
eric



