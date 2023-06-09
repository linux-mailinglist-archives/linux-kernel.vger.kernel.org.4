Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F17297D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjFILIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbjFILIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:08:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE71FF3;
        Fri,  9 Jun 2023 04:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTBjN1394nUS3/1iNmpDbF0VQmMLgYs9HA27x7Kt1LZ29fdfSm2WdAywjQC5sRlTy9Ow5Kk2n9UZCbyjJh8eFbU0Bd7n3cxyhpfmHKT+/pbo13K8GIhcQBRKtBZuhx0FfVjhbq+anoytpqmSpdXUVxlx/r6MPgNj59T6ab8VPvna/2J5lKdjn3D+UeKnVwKESau4XY0Ei5bpZbAh6VngFAtVrHwxJUbJ9F3/+u8jwBSDSA///mEIDCDANAbDRczMgxEbcZtbSgdY3JNRy9DFh+ZuknshYVY78tsocALQbVfJbM7LgWPJqA3nCJNiiJWbVE0ubWKQ7HcAKik9LqXvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWk8kOZChJ+Jn60fwhws/mIOdLSx4hlnqzlSCEt4Vtc=;
 b=U/5P/4d2l2S5MDS43mxXi6i/8DnDqmOZCwWgN5iGPxHGG9hbSEdZZoy1xOZAOwjGeIDwxmOEDNeLAi6PXFxVjfGR1Z28/anlyMDM3FR7DJKQTtyA0zBBeEL1/BFcHyD0chZWf6gno+NDPsKiGFCwjC+a34VnfDxkXTel1wdvRO9qGTw5JImhuX5/WDSRfWgQUYIIzf4lQkJI6OtJexBrLqcabz92JETkp0zWM7bkGRIIQp4BWfXyldyFpYOXePOCvncwicJoaLux/iyDNi/me02fisa5PL+PA06/2Jl+E28AuXqJm3M+N5CEqifJzeJMHBoLmKejhOylZcYYOs72kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWk8kOZChJ+Jn60fwhws/mIOdLSx4hlnqzlSCEt4Vtc=;
 b=gorfw7LNpJtShwy/Lmj+p9CBzVz7Ig2C4/irE+3+xEBccCGVGmY7sMnCeX6aVb8ztjTZQB0OE0y9PMX8Re35KfkWKHGnJX4oq/eKpFjEYAVRMGNIpOdqX+/25yp72MUv4hdZsvpJM8Uk/pGYc+RBi+8NW8hBS5z1uezNXiaHGCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 11:08:37 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::5f70:8e17:f854:91ed%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 11:08:36 +0000
Message-ID: <b352b0ea-09d4-58ab-3498-480d15039321@amd.com>
Date:   Fri, 9 Jun 2023 16:38:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Null pointer dereference during rcutorture test on linux-next
 from next-20230602
Content-Language: en-US
To:     paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        sfr@canb.auug.org.au, rcu@vger.kernel.org,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org,
        void@manifault.com
References: <b8311fdc-2e71-f74f-159e-db7a86f27b9a@amd.com>
 <ff0dd6b8-884e-4bcb-b7d9-72a5a8940f0d@paulmck-laptop>
 <20230608083318.GG998233@hirez.programming.kicks-ass.net>
 <05a8bdd2-6b0f-40d4-9706-4d65b74affe9@paulmck-laptop>
From:   Ayush Jain <ayush.jain3@amd.com>
In-Reply-To: <05a8bdd2-6b0f-40d4-9706-4d65b74affe9@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bdae03-8f98-42bd-7a62-08db68d9df00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjX3XBaO93L7yt9qT8sNtbbNRW6E3cPVxYbYoV+cF5E3JPnJr9AFMxwlt2k+/KEhHwz99aeRwxYCAob26mZ9l+lh+W1bMe3R8SZ15WS4qYawnd4+CvEJrKp9diOnhyKEi5XgWdTbrHxb3CA2/xgXygR6uC5lA4fDW2D9N0XR9uDurN9A2Se454cKWMeujWDwinDsOX0qM8b3ux8zsxi/NBPWBRjf5z42u3SMo3UvKJ2OEjHCBLvPBqy4DI8kKedZXEESUlyh7ohScfUQml0HIJVmgXtrY3bPISAMKkKbIa1vMz7yZWHFwRDM/NbmjpJWrE9MbHiyG1cEcZO0FxsdLiArjz6kcHbqlkaM/h1AiNIsVPS43Zg8ybXSrhF1DXYJdXNC+xEMTxqAI++i7xi/d+IzkZ+q1Wn+hI4f0dcVErTnj1LZYhJz0azdTlJ7SkZCeacMqkqsNdBCFNNcd4nLVmQpnQ1ooIB9b/dc31vZVH3uBXob+9SdU9Cab+ylOTiawETbLgqqj7AuFE80USfSjlbY7UltCrv41OPjZ6C/H7ngcGJinlf9WZ1o8O3xxzpHFoZ+pe82FS6QvFFOP9nYmG3Cn+en7ihhfEQSepx8sh9AGLgnUbuYAZ6BGcuqxuDUhE0VfadPg//27ZKirfoLoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(83380400001)(966005)(478600001)(8936002)(8676002)(4326008)(86362001)(66476007)(66946007)(66556008)(31696002)(6916009)(5660300002)(38100700002)(41300700001)(316002)(6666004)(6486002)(36756003)(2906002)(54906003)(6512007)(186003)(26005)(6506007)(53546011)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFBiTXByc2pqVEtYaVRUR0FsNUtzbFdoMzRaTEl2N0ZUdHlwRGU5eXJETzNT?=
 =?utf-8?B?UnlWYU9KQWNmSDhKNjg1cS9zVUVPVnh5WFE3RlpMMklGd0J5TVFJZ1hmTVdE?=
 =?utf-8?B?Q3JDaEt6ZTFpTHF4aEkyRGJNTnJ0NVdJaE9ZeUVyeWhxZmxqYWZxUUFldzha?=
 =?utf-8?B?NzExNFJWL2NqKy9wWldvY0J6VEM1T2pSUHZkRjBIdlhhVDBtYVVvbTlteElk?=
 =?utf-8?B?NVJtYitmTi90cXBKb0Q4Mkl4c2ZzNktmdFFPdWZXWWNNSTRRcWhwNktHcDhV?=
 =?utf-8?B?eXhQbWZ1OEdiSUVjcmM5MVZadktYT240dVdIR2hkTktDT3RsNkNuald4Zzdl?=
 =?utf-8?B?U1VEak1MRW0vNkRUNEtObTcvc3Nwb0NmOFdPWkx5MTFpa0h2bmVXeTdQdUNR?=
 =?utf-8?B?Ujl1N1RpTm95aUF3bVljU3Q2VGtldEpvRVg5UmJHNVlPWit0d2krS1FibHI1?=
 =?utf-8?B?cE9rRFVzYkE4MVBOK0tkRU56Y0hTMkw0OWNVWFVwNDJxZjE2UGFldHFlcFoz?=
 =?utf-8?B?dUR4V25HOEFZT0tZWnpOMXdJcWFZUmIwQTRxV21qYk8vWFphNERSUm5zUVla?=
 =?utf-8?B?RmZmSTdnNEF5SWNJWEpCbEdZMlZKMlJzNkMzNS90Y2dmVzl0K2dnODlBTW5S?=
 =?utf-8?B?UExTOFd6UkdGeFpkTEdpaHRmZnAyaXZScUZVY3VydUw4ZEZ5NjZuajRkSExC?=
 =?utf-8?B?WE10elBmUG03dGZCYnFFM0ZKbTdZQTJQeGVYWXoyd05lL3VpL1VPS0g3Z3k0?=
 =?utf-8?B?akEwSWxoTlpFMlJ3TEdMZU1YbjRwTDgrVkVUcFZ6T3ArOTBCdU8xSm94UktK?=
 =?utf-8?B?VzFObDYxSWN0Zi9CeE80VWIxdXVHanpET20xTkhGaS9EQk40Zy9pMHdqQXoz?=
 =?utf-8?B?eElTN3d1SHpvUzY5cWhpbWZ1V2NCSVlTUk9zejNhTzNaTWNSSXFaL0M2dlVU?=
 =?utf-8?B?cXhlLzR1MDBVcjFhU1hVZlBjY3RFYWRvNFZCeWF2SjN3aWtHb3ZRY0JHNWVW?=
 =?utf-8?B?YURZNzBGMktoa0ZBOXFyVXcxcmthckI0cVRsNmpVdHdIRFliQzdKL3RNT081?=
 =?utf-8?B?ODh1K1h5d2ZNaEhFSS84NkV6dkdLd1A3TFpKV3VmenBITnFyVXJKQzBiMWFZ?=
 =?utf-8?B?SDdKMFdVMnduTU1KK25sbzNDU05XMFBxV3AxTU1LRWJlVWdiYVdvQkd2ZEM5?=
 =?utf-8?B?Sm5FWEJYU0tHZ05tVWlpN2hudDZDbEhOUHNSb3lWbXZWZEpQcG5Ha2dLOUNo?=
 =?utf-8?B?cVlPZHhITmp2bW5oN0gxbG5EQzNQdGx6Q3FHRUJ6aCtuZFllNmhhNlZqZHhR?=
 =?utf-8?B?QkgvakZGOCt6ZnY4bTFsVnVCM2Q5QlRQZDNMTVJsRktzK1YvOURJVVFJYUV5?=
 =?utf-8?B?dzUvTjJBS1hmd3hMQXRQL01MRE5ibHc2WDNiL0JBRXdJNHdMUXk5bytsNndF?=
 =?utf-8?B?aXF3K3NKZkZCOXkzeVV6RTcybGFJWWdXZlpESURINmxLYk5GRHpCMElMK2RL?=
 =?utf-8?B?bjhvd2NQK1U2a0plaXIwWjltNnhzQU5vMzJta05UdU9KQVdCZGtESVpTbEd3?=
 =?utf-8?B?VmpjK2NTam5rUGZ4RHNLb24zdUZROW1aVDh1WVRaS0NQeGdlY1VDVHFnL3pP?=
 =?utf-8?B?OTJzVkNJK3doOWpkc2tRczVjbEN6RmpxL29qR0dqeHhhSVM1NnBDamJyaWNP?=
 =?utf-8?B?dC9UQkthRGc2SUVIRzA0aHlVMEw0endDeHF6K21rSUVRSmhhTG1wN1BzVmkv?=
 =?utf-8?B?a1phSXpqdlJmcVB5TUNuNTVqRkZ1anRnS2dBbm4wK2dacFVZUzJwa1Zpa2Ix?=
 =?utf-8?B?NGJvSVhSOEY0a0E3YjlyV3RkZHZNK2F6TGxlRWNOWDhodHhXcWI5TjdNMmlx?=
 =?utf-8?B?OVd4dFduV0xGQXpyZ3hJaE0xWG16Z2sxUGxmZ0hscjBtdlRaaDMyNnZNeXNs?=
 =?utf-8?B?Z0Jxd0xFRHBDQTNVbCttYTQxVGxvZjBFRmR6aThiV1kva1JSQjJtbXk0U25Y?=
 =?utf-8?B?R0J5QkJ1ZzR2UTRPcEZSd293SndValAxTURJemtTWi8zVGZiSXprRkdTbjA0?=
 =?utf-8?B?Rm9ZSXZmWThhMDk0ZUQxZUZML0J0WmVDTHdiaXRVSk0ydG1NUm9VSW1ERGlJ?=
 =?utf-8?Q?jO/1SRR5GmqfGSCgZT1CSxWqP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bdae03-8f98-42bd-7a62-08db68d9df00
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 11:08:36.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFb1MzQfQOBZTDop6J+PKajRiUeH2IJJjF0y+ceBrSSZk5p9mcSBpIyat7EJyMDSUmcFoATBNIXIn6p1pmL/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 6/8/2023 9:55 PM, Paul E. McKenney wrote:
> On Thu, Jun 08, 2023 at 10:33:18AM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 07, 2023 at 12:24:12PM -0700, Paul E. McKenney wrote:
>>> On Wed, Jun 07, 2023 at 04:48:19PM +0530, Jain, Ayush wrote:
>>>> Hello All,
>>>>
>>>> Observed null pointer dereference during rcutorture test on linux-next tree
>>>> from next-20230602.
>>>>
>>>> Commit ID: commit bc708bbd8260ee4eb3428b0109f5f3be661fae46 (HEAD, tag: next-20230602)
>>>>
>>>> Here I am attaching log trace
>>>>
>>>> [12133.344278] rcu-torture: rcu_torture_read_exit: Start of test
>>>> [12133.344282] rcu-torture: rcu_torture_read_exit: Start of episode
>>>> [12138.350637] rcu-torture: rcu_torture_read_exit: End of episode
>>>> [12143.419412] smpboot: CPU 1 is now offline
>>>> [12143.427996] BUG: kernel NULL pointer dereference, address: 0000000000000128
>>>> [12143.435777] #PF: supervisor read access in kernel mode
>>>> [12143.441517] #PF: error_code(0x0000) - not-present page
>>>> [12143.447256] PGD 0 P4D 0
>>>> [12143.450087] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>> [12143.454955] CPU: 68 PID: 978653 Comm: rcu_torture_rea Kdump: loaded Not tainted 6.4.0-rc5-next-20230606-1686061107994 #1
>>>> [12143.467095] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
>>>> [12143.475934] RIP: 0010:__bitmap_and+0x18/0x70
>>>> [12143.480713] Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 89 cb 49 89 f9 41 c1 eb 06 74 51 45 89 da 31 c0 45 31 c0 <48> 8b 3c c6 48 23 3c c2 49 89 3c c1 48 83 c0 01 49 09 f8 49 39 c2
>>>> [12143.501675] RSP: 0018:ffffa3a90db70d90 EFLAGS: 00010046
>>>> [12143.507510] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000080
>>>> [12143.515468] RDX: ffff8a1ec17a1d68 RSI: 0000000000000128 RDI: ffff8a1e800429c0
>>>> [12143.523425] RBP: ffff8a1ec17a1980 R08: 0000000000000000 R09: ffff8a1e800429c0
>>>> [12143.531385] R10: 0000000000000002 R11: 0000000000000002 R12: ffff8a1e800429c0
>>>> [12143.539352] R13: 0000000000000000 R14: 0000000000032580 R15: 0000000000000000
>>>> [12143.547320] FS:  0000000000000000(0000) GS:ffff8a2dbf100000(0000) knlGS:0000000000000000
>>>> [12143.556354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [12143.562770] CR2: 0000000000000128 CR3: 0000003089e50000 CR4: 00000000003506e0
>>>> [12143.570729] Call Trace:
>>>> [12143.573463]  <IRQ>
>>>> [12143.575714]  ? __die+0x24/0x70
>>>> [12143.579130]  ? page_fault_oops+0x82/0x150
>>>> [12143.583615]  ? exc_page_fault+0x69/0x150
>>>> [12143.588001]  ? asm_exc_page_fault+0x26/0x30
>>>> [12143.592678]  ? __bitmap_and+0x18/0x70
>>>> [12143.596768]  select_idle_cpu+0x84/0x3d0
>>>> [12143.601059]  select_idle_sibling+0x1b7/0x500
>>>> [12143.605831]  select_task_rq_fair+0x1b2/0x2e0
>>>> [12143.610603]  select_task_rq+0x7a/0xc0
>>>> [12143.614696]  try_to_wake_up+0xe8/0x550
>>>> [12143.618885]  ? update_process_times+0x83/0x90
>>>> [12143.623747]  ? __pfx_hrtimer_wakeup+0x10/0x10
>>>> [12143.628615]  hrtimer_wakeup+0x22/0x30
>>>> [12143.632706]  __hrtimer_run_queues+0x112/0x2b0
>>>> [12143.637574]  hrtimer_interrupt+0x100/0x240
>>>> [12143.642152]  __sysvec_apic_timer_interrupt+0x63/0x130
>>>> [12143.647796]  sysvec_apic_timer_interrupt+0x71/0x90
>>>> [12143.653149]  </IRQ>
>>>> [12143.655493]  <TASK>
>>>> [12143.657834]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>>
>> I'm thikning this is because of ("sched/fair: Multi-LLC
>> select_idle_sibling()") which I've already dropped from tip/sched/core
>> (and should hopefully also dissapear from -next if it hasn't already).
>>

Yes, that was very likely it, i don't see any rcutorture test failure in
today's next(next-20230609) build.

>> Also see:
>>
>>    https://lkml.kernel.org/r/20230605175636.GA4253@hirez.programming.kicks-ass.net
> 
> That sounds a lot easier than bisecting, thank you!
> 
> 							Thanx, Paul

Thank you both for your help.

Thanks & Regards,
Ayush Jain
