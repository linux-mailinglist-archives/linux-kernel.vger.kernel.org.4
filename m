Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732F747CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGEFs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGEFsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:48:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB718187
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 22:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YffFZpkD70tzGb5Q4UZaillLlIbdfWU79V2H7lz+8ht72VheN1p9A+chnoHD+wclfeRLjqA6biNCnoEJ7Sh3U8i9TNUfGe6AfTOeQ1k1kX52XotsUn3wjztZIXLBpLT0sRxSSzshyfX84a/zGYE+C92hTmylJxPsgE8owTaUhnl2InqQzLgIOnlz0yODY1Tcn+c7rCjmR9EdDqLD5vHKNUM4pRfQDpk21Djq0NxJXtFaRnN2cKaKvFdsAvhi040jKJ8iC1C4jR4kjA5QZtOv0XdeDdyZwbL3sFuc2nKHgVXct9seF1M9GZBbTR984iG6muerqr564KvXFrebzamMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc0oF8SwQVHhiE2hiLKBCNAZz0N9L745h3DwjZM41IQ=;
 b=NwqlSy6RsGPOvXxBk+ntmbCxv1SW+vKs/ktCDkeFeA7T4P8z26+Qo4V0mqi2Vfu6ajmtDk++ZUq+q95+gMcWhK52Md04ZfwoB7I+fucdjcpb2cuLRwehzyo2etgEs446vAdujlVu45EbjcXKOoIisNvGfH4GmuufoU9PU+QcIUUEKSS13Kbibg4vGWRX3NNsoKWp29XsLEdctXbwnva62ua8HXqbg8X18yuR40g5oeHGdty+DLwluTZeWVopXrhjDNa9tzaOpSR2Yq3hA381u5KjGZE4w6QEIyEXqrZZrI9djm9X6+fIMtO+MB66MRrigjK0m0uRDU9EtqC10gerSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc0oF8SwQVHhiE2hiLKBCNAZz0N9L745h3DwjZM41IQ=;
 b=jL86X3liID+Kbk7EqgEXe2+TDrF0Djod7olhbQC/iYsVSh5TwaLJTYdxSZ8YYztX7DWK2oMnKwoOjlx2RoI7+NCX6nddrs7d5GTjUaTe4tUgRKI8PhLT1bZyNsY1a0k1RhAX6HxPt4slXlDUBlpGO1Qh9TJrWgMfdZHmQVmhD3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:48:50 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 05:48:49 +0000
Message-ID: <88d0c858-586b-bf59-8d57-d31ec63a9e35@amd.com>
Date:   Wed, 5 Jul 2023 11:18:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 968bed6d-3afe-4c79-73fd-08db7d1b8134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVv3C56d5kIdOyRRS3ExUpi3swRqPQSKk/i04md86TNU5Bhfdpjcqg8vdQtFp23lQd10Zl1lTwnh+ZPOceptu+LED3VJwgREuAOzTpt7RmXt348ZzXhEJIwnCtmwoIboKxf93rceSvYYs6mK6FkZZStnWciFyh7fSIYgvbAL7n1kGdKG9Fnap4Pj3Cr0ylKJFsYxi8f6YyB6BdnZFIsXoRNAYsgMqNEmmSGvr60LcgrACPtkxE3ra5Ot+YukN+vYBz5uCwLeWOSztirPY7udZl2+hKo69Fcz405bjZIc/y0/SGh8aL7bndRAARu6l7Y5hAw3vW9UjPlHpifmqhErxfNj4toBazkWd/RZw0l+YKXKO3yvEDGEdg8EiV5rS5ADfLqpiCZhGUSrS9qqA2WKyXsAM17VMKTCWuJCPy+QAXAf0JmSqIfw+5xDw7cdl8i+5Rb/KRqLW4xB7hO8o/A6Ye1X/J9HwZEhb8S9iTVAp0G3UaIYgsbsxz7TElWgCkf3E5Do7TzVmXv5duoT8k7w1sbcjOUywY1OoVtGwqP9hCPInAfp2YE+eVQOGtr8oNWC8gm7hCRGBrD8FlKWd1Tv6TZ/IOSsvYLl/bGegSPhmU0GM+l7BneR2mV0h0xOl6A+CiuUk43x+hop/TiOzZvS1V8gxmI1CdBN3HVTN0KxBAbxGXj0msxMWL5uJQ0Be03F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(41300700001)(6486002)(6666004)(83380400001)(2616005)(53546011)(6506007)(186003)(38100700002)(26005)(6512007)(966005)(31696002)(54906003)(36756003)(316002)(66946007)(66476007)(66556008)(4326008)(2906002)(8676002)(6916009)(8936002)(31686004)(7416002)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBVTmVBVytPc0ZMUm9aTEpLeGo4SGpZMWIyTGN0Y3VyR3k1VTF5Y1B3Zk1j?=
 =?utf-8?B?MHZuYU00TVpNdHU0R21jWmZ5SUlQRkJXTjFSaTFHdm5HdVpyWlgxOUlNYktC?=
 =?utf-8?B?NWM4MzlOaHh2bmlLUzFEdlB4MzVRbjRDdWdOVmZndzNLUFgzRXFaS2pOVmJt?=
 =?utf-8?B?YUxOSlZpRlJDeS9DdTN2bm1JUmV2R1dKNVo0RVJST3ZZWVlyR0hVOUl3Q25D?=
 =?utf-8?B?T09ya09XakJLMHM0REZTa0tkQmQ5cElNSEZGcmZ3QXQzYWg0bS8wdFRFWmxo?=
 =?utf-8?B?U2JxTjRScGlXTDFQQzFjVXpzRXF3aGlPTWdmV09HNHgxTDI3TWQwbzdrK09I?=
 =?utf-8?B?cmd4ajBEZjQxbHpXNkYvRFFsWW5VQlBnb2JRWTd5N2M4d2UwUnVpUXU5bkYz?=
 =?utf-8?B?bmVkd2N4aEVoTWFtSFJkSVhrck1aQXB5dThDM3ZGdmZGSzdZN0U2aEMvSkRZ?=
 =?utf-8?B?bUlqZkUrOWRkRXpQaGZueFM5R1ZQKzV1eksranVXeFMxdlRPK1VNMS9pV0Va?=
 =?utf-8?B?ZHZHSVdFcVNYT3J6ZWJKNHlVaUJBWlZRWVpMdjBNZ25HeURMTk5GUDRHVkJK?=
 =?utf-8?B?U2RMVnJXcVAwa3FVN25xbVhvaWxwU1pqS3AxcTlzMmMvSjZRcDVNdDVwQ094?=
 =?utf-8?B?SC9ZN1lXYUFJQzZjQkxrc3BoNm13aitDTWV3eStJNkt5QU1TWWhieTBtYmVu?=
 =?utf-8?B?a2RMeTR6UUlObit5cVdOTlRkVXU5OXFyYmFRMWhwbzQ1Ry9GcEE3VDdtSEpD?=
 =?utf-8?B?R2dySWZqR2JWMk9GMWF1UmhnQW1iNzVJbXFuaUVCcDhDWU0xYnRFU2o5OTJY?=
 =?utf-8?B?aDFzOWR0cUhza29JQ2xpaHIzak5OdS9MS0lRUHFMK01NWXZ0NDBEUzdGei82?=
 =?utf-8?B?TDBoeXcya3Y1QzFDcS9MODlNUnNwS1kyVnk2Y2RnRk5EOTFXR3ZHTE9kZStw?=
 =?utf-8?B?cDBJeUY2YWhyOVlJajN3YzZ1eGJidXNLeE5yWEFOd0lIOVpid20wankwYTg1?=
 =?utf-8?B?S2pZZGNUWU8wRlJOQ0RvcG9SWnYySjVZUCsvU0s1dmJLbTkzK0pPMDE1VENC?=
 =?utf-8?B?TGoxbHp5VVY0K043cUwwdVNSVDdRcHhlblFGR2s0bVZoa2d3dkNjdUUvT1ZV?=
 =?utf-8?B?bnVjRTM0aXl5eE1NSVowQmNjQmwyd011SFhUNXZ6OER1dDZpcjQwY0RRYUdK?=
 =?utf-8?B?TG9nMldpK3hRRDVLNmh0RUVqRlViUGFvdTBITnArcDdQMmhpQnp4OXVCUEZB?=
 =?utf-8?B?Z1JqMmF4WmtQZHRjdTk2YWVWd2JOaG5wZE5pT0xUbXFnWlI5aDBGQ3NrR2hi?=
 =?utf-8?B?QkdncVJiRW9LWmc4Smh6b0kxZlVkN1FKb1JENFFZZG9HMmNpVzVnc0JSV3B2?=
 =?utf-8?B?VDRQQ1hBVXFSbXFjUGVnQm1sTHVpbGNMWUMxTjZISUpkVGhYekUrWnpMUDFP?=
 =?utf-8?B?cDNSVlJWTFVrWkdWdUNsSlZYU3dKRzVCV0gzT2haQVYxN3VDLzZ1M09YVzU5?=
 =?utf-8?B?MncrL2xCMGRXYVNybkFNdmIwcFI1UnhSSWFPYzF4UFVnYXlic3pkWG1SeHcw?=
 =?utf-8?B?aXR0TFpzNTlQWEpUMjFPYkwvazh1bkt4VVVhUTNPcDhnR1FxYmJUckp6V0V1?=
 =?utf-8?B?SlZXRmZVT3hZRWhYSlhFRmVyTjJHajNoQVdBdHp0OEN6ZnlIdG5pMHIzdGNI?=
 =?utf-8?B?dTBuWThiTkRHUFVUYXJ5WUY2c005RmxhbHdNaUZ1bklyUE5GS0prU3BlUzVk?=
 =?utf-8?B?MEpua01lQWpxQ2ozOFdKZnRQeGtQb2tVODRHWllEQ1BpenpjOVpuTTZTb0tp?=
 =?utf-8?B?dEQwaXRiUmVIMnBkVVRvSmJkQ1g3aCtqeTE4d2VFUjJ2bytMYzJ3OUtPUk80?=
 =?utf-8?B?cEl4ZmdYSTdNbXRTcEc5aDlKQ1hIRCtGekQrZ0M3RzM2UWpaMkI2MXRZZEJS?=
 =?utf-8?B?a3JGZGdXckxhd1NMS3lGeEZTeWxpYjF6NkZQYnd3YmU2TitpZ3M3N1dsR2Yw?=
 =?utf-8?B?Ly80TlFOd1BZajhIRmxYcDhrTlNMMUsrTmNzZXJOcW4xUDNDc0thVzVhU0xl?=
 =?utf-8?B?aFhCWU5kNEpWYTZNblI0aWR4VE5BQnp0eXM5dVFuVTJ2Y3JweWpwT2w2eXVH?=
 =?utf-8?Q?MU3zBwwrbMrRofyho05Xnvd/K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968bed6d-3afe-4c79-73fd-08db7d1b8134
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:48:49.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgQN/eTbXdD2fyEsjgQtCkUsMhNx/gCYotRNNQhM9b9oC8GVWN9CcseFTLFferM9idh4K+Ece4FHzk+r9dEpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/2023 9:55 AM, Raghavendra K T wrote:
>   With the numa scan enhancements [1], only the threads which had previously
> accessed vma are allowed to scan.
> 
> While this had improved significant system time overhead, there were corner
> cases, which genuinely need some relaxation. For e.g.,
> 
> 1) Concern raised by PeterZ, where if there are N partition sets of vmas
> belonging to tasks, then unfairness in allowing these threads to scan could
> potentially amplify the side effect of some of the vmas being left
> unscanned.
> 
> 2) Below reports of LKP numa01 benchmark regression.
> 
> Currently this is handled by allowing first two scanning unconditional
> as indicated by mm->numa_scan_seq. This is imprecise since for some
> benchmark vma scanning might itself start at numa_scan_seq > 2.
> 
> Solution:
> Allow unconditional scanning of vmas of tasks depending on vma size. This
> is achieved by maintaining a per vma scan counter, where
> 
> f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
> 
> Result:
> numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
>                  	base-numascan	base		base+fix
> real    		1m1.507s	1m23.259s	1m2.632s
> user    		213m51.336s	251m46.363s	220m35.528s
> sys     		3m3.397s	0m12.492s	2m41.393s
> 
> numa_hit 		5615517		4560123		4963875
> numa_local 		5615505		4560024		4963700
> numa_other 		12		99		175
> numa_pte_updates 	1822797		493		1559111
> numa_hint_faults 	1307113		523		1469031
> numa_hint_faults_local 	612617		488		884829
> numa_pages_migrated 	694370		35		584202
> 
> Summary: Regression in base is recovered by allowing scanning as required.
> 
> [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> regression.
> Reported-by: Aithal Srikanth <sraithal@amd.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

Hello kernel test robot,

Gentle ping to check if the patch has helped your regression report.

Thanks
- Raghu



