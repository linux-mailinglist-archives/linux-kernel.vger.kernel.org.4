Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F564581A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLGKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:41:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301BFDD3;
        Wed,  7 Dec 2022 02:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LW30A9WnuVhWchdvMhrP5MgRcNKqW4VzQWu0kgPzhE7kJHVil/S9h98EC5hsxiW7McATD3eZxobNSxpWlwIksKdu2jV0Wh/15ZVDAPJfyF9cn7NVBzS7wOv9IcWC/+vz0gKbqTsT0iNcNNPa0moRtIaja30xEKMoc58ye0lKHmcPYkcE1J5sTcbbs8lsvkqTcovZ7SFR49xX/BrUGZjrUCNky8j9mTA+5KdvImtMvu8rsMTIxlnYZNd7J0d2ccPhNbSoYXdgoePByEjXgCxnRLKqCNEF9DoqGtjJVj2XCPsdZvczI0Q5Y0gnHkgW7FFKFJfKooiuxYA1IcSS88SbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR2eAc8rWadbGMpXIH6VAvXlGrf3xmRzChkKGNKAwN4=;
 b=WuSTAftnA9fESlRdUhmpJl3KUYdCx6qCwERM8Dm/LNkdZrwQ9TZlt+ya8G7sJv99HHa1xc6CexbTEBIa9PU96jwzxLO/fg3TF0hoSRq2UfEwmZVNuHlPfzIbNV4rq+AXTNcCbpi8N+t4K3Y2SZxvnkER4c97Y50rrPI3apbjo8cjSn3j+CorpqDzv32uX+tABQjWsFuY6Q0dFmPv0Fyqjp7JL5NBnjmYZ/J7ysZ+QuLFeZujP9jdmdXhoUSazNVBWHsSNxrAHdMnxOInKCirr3Hi2QidpucSiwnX89xmyilgwCnf0s1pHsS5jYoTDMCtWnoPQraRZjz8rYu1M4IQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR2eAc8rWadbGMpXIH6VAvXlGrf3xmRzChkKGNKAwN4=;
 b=HZSBGYloc6KqQBiv5KtUJtzAWbtCCab+3QNswnY4Uc5TLGyYyt4VCJczN33a6vupdUAq7lvb7T31wvCmy1QcztKszCR4DQPk/lvtHdEgyQs1yl3qOMMUcrXfQ9SysruaMdvMJbcGofcbUc/c2648Y9ETpct3u3F/3cBAjwEPRAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 10:41:18 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 10:41:17 +0000
Message-ID: <98312d02-9582-7a4b-21dd-a92f0094f401@amd.com>
Date:   Wed, 7 Dec 2022 16:11:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] perf/core: Fix cgroup events tracking
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221206025034.75125-1-zhouchengming@bytedance.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20221206025034.75125-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e03bbb2-8522-4988-667c-08dad83f9180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6EUpYR9BJ/07POHOPT59WhBFYqcHPYY4J1QKa/b5KUeayTcONHc84fz5CIcxtiVlvMj4xigvg36dPvPZmPz11snaxf6mdEnXeS+ynb2qGkHefcN6O/lRkN7HS0A9uqBnVfDACTdkn2/vEgF0aQC5h2iY9AiUjKpGWfdWnIhR3SvkBNHqabMQpYWhXLOgCVX0POOU3O16gLMHD6oNk9Wwmom5ZuOmgYg0nGVZwTIvLiBb9im39dRX+luHUiudFTVTbnDaf2QafiOWKcrq1IY88DCfQxsAGmsFnZpvmztx23p8FaGwSdHL319Wkeqlcup5QwU7TUdZmaHW2GDIqIz9PgZXIY6gPtrWgBuIKhykgnyQdLG+s5IPlBAvPh8TDfhe8zD9ZWluu0DT6oO9cDoD2zlOwH0dVFTc/c81X1DFa1znHr5VdXI6LWFZcSeSQ9sCapLmyE6XaTpweLl8Ul5WcCQp7eYVMVyJAGO4dsPUqCvSJVfpizU9pXFWkvclIlo9+acMOa3uTyQk3JHYBsJWRLcUk+FphyhRYzp+83cNtyTqt4XANNbXxarFH0kKMWKyGsrGDhanMrNKBI1Ugva5vvcPT149lia8HmTSf9EVqwi9Z0Iqho1NHyoCdL0q2HjLSWAss5ijhIgGPX9mwAnxsp2518VRtaXWS0Nswl/Cqn1073MG26WFgwfTaxJ8MWZta7CHB9xXqizwAJSsvWvdyCNP3TFNdHf4/NVnkKA30I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199015)(83380400001)(86362001)(31696002)(38100700002)(44832011)(7416002)(2906002)(8936002)(5660300002)(4326008)(41300700001)(6666004)(8676002)(26005)(6512007)(186003)(53546011)(6506007)(2616005)(316002)(66946007)(6916009)(6486002)(478600001)(66476007)(66556008)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVvdGlCenZoTjlUMGZSVmJ1VnpNelJyamd5U2dGMXl3RG9EdndOOVdjQlVY?=
 =?utf-8?B?WksrckFEUHpTdkNxaVRnUHIzUCtzSEdtYkl5QUN3ZG1HL2RZVlNDOFJVQ25E?=
 =?utf-8?B?RDJ5YWUrMlRCcng4Vk91V2F5SWJJSHZzd09YdkRqdzI2ZGRqdXBSTnZ6VkRY?=
 =?utf-8?B?WTV2ektDbEJBbCtxcjNKanhyYUhSeG93Zi92bUJKakRaTjBzV2FadjlwQ2dj?=
 =?utf-8?B?dDV3MHR1QVcwK0drOXNCY2JMckJHY2JVRXBUYXRnTk9SSzhqazZvSWxZZFdP?=
 =?utf-8?B?WHpoMm5FQVdKWG5zUWZBeTZSaFNGMmxmaUhuWHhYTVFGL2V4RWlGcE1KMWZa?=
 =?utf-8?B?b0VkTmJQcjBvWWFVc2NGOGZ6TXdHR25MY2FSYUhxNnRQbS9aQlB6alRFUkFE?=
 =?utf-8?B?Ri9KWHBkanJrZ2U0NFVUZmNvNUFWYm41akYxaVIrVjBkczJNaElGVTR0Mjdi?=
 =?utf-8?B?cGkwSCt3emtyUU8wSDJsT2x3REtjZXpOQ3hvZ2VLL21wMnVYaXhLbkdOZm5W?=
 =?utf-8?B?MlFNNUZaQjVSRWttTGMxR3J5dXdSa1NyUnVjT0F6M1h2VUoxRS9uY1lwRmJK?=
 =?utf-8?B?MS9wcmlPYWxXM1BXSytpcTRzYkFya2dhSDZYaFUwRHRueEtXNWU2dC9lZWky?=
 =?utf-8?B?eklXS0pyYWpZUUxPWUo4RHRYZ0xmS2RLZ01ndkdMaExLVVFSVHN5aTNUWVVT?=
 =?utf-8?B?d2hqUXJXMEsxNkZBdTJuS2xHdGNuV0l1c1E5dENpYlVPU2xCTEhXbHlqWGl2?=
 =?utf-8?B?cnVLaGhqMjJEaS9MRWtkanEvUVF4WHdTYmtCV00wMFJ2TGh4MzlnR293SnVO?=
 =?utf-8?B?dmtLSTNPSFdPVXhrWXJNZUlwem1UWmVDRlMvU3B2YWMvM21UYy9qSlBUdVg5?=
 =?utf-8?B?ejIreHJCQ1ZwUkRwSmRKblA0SUhUZ0ppbnkxSksxQjA5aDFVcER4ZE1wWTJT?=
 =?utf-8?B?bEFmMDV2MFltQ3d0R0JLNmh1alVuT1JiZCs5WUEyMXV2L3NYTExpMVpwWlhO?=
 =?utf-8?B?amhuejdmYnMyQ1hPaURaTk9mMExDekQ3YkZKMFh5RGZFV3RrZ2pCbC9KbFdx?=
 =?utf-8?B?SmhYU0ZOT3RURzV5QTJESWE0QUZvRzRLU0JMV2Z1QUNtcGF6bTRsc3dxTTRX?=
 =?utf-8?B?NDlPa2tub2Y4VVVsY1NkRUhBelFRWHYxT3h2R29CK01Ua0dQVU9tb29TSDVB?=
 =?utf-8?B?QmNHWlhUKzlFZE5rbkNqTHdvWklJaG5CRWNrQ3NiSUllL3BJR0dkZGR5eGov?=
 =?utf-8?B?TzNCbkUzQlpWbGNOVGtVUXhaZU9ORlRKbjBkbFhFY3RHSmFzUFNtK3lkS2Fx?=
 =?utf-8?B?VUlKVGVsYk1YRUI5M0duWktTaWRORkxJcUM2SEdSWWNCN3dxZVNyYXo1dzFm?=
 =?utf-8?B?aVdQSHVSdCtkaVhTM0xKM0VzQ2krdDBrMHhxZGZBMlFBLy8yY2wzNHFLdzhX?=
 =?utf-8?B?OWN4T2ZoRU96L0Q0d0ZmeDB3cGkxM1FWc0VEdmUyWm1jMzdieVNITWlWMWJj?=
 =?utf-8?B?bVY0QW9HYzZvMGtqMENaM3Q5eHFNQng4cTVIdWFmTTZ5UGNCcE9BaHVGaFVp?=
 =?utf-8?B?MnI2LzRyaHQwY2pFM3ozbUFZRitvNmgzSWtRTmg0U0Y5UkxieE1CZ3ovWXBY?=
 =?utf-8?B?TXI4UCtSU1RnQVFoWVBJNXUzaVFTQW9Id1MrRGROMnJuSzMwUWY0SkhQNUVN?=
 =?utf-8?B?TFV5RS8vbkhFb2xrTzd6ZTN0d2IxeVdXKzVIMXpOTXBOMUFMcEh2WER1Y2NZ?=
 =?utf-8?B?Nm1ZdjlldU1SbTU0Qm53MGNQKzFId0NMM2M1K2pCYlpNTlN1bXlrMkJGc3dx?=
 =?utf-8?B?WVh0aFE3MUdLT000TFZ1UlIrYUtvYnU3Y0dxMS8xNEd1Y013WmFlbnlEUmpp?=
 =?utf-8?B?ajNURWRRckFCY1d2TFlISkdEZzhiNGIraVNBQWdHay9qekltR1J1c0FTaWti?=
 =?utf-8?B?a2l2QVUrVDhxblRZOGF1NXFLakRVZjF2bFVVS3FZKzhPOG5pdms5OEM1dnJZ?=
 =?utf-8?B?VzRwV2VQQ011VTgvYitxRFpuZFN2LzdVT1JJL3NjNjNJRW1xNnY0alQ3bkMw?=
 =?utf-8?B?L3BnMnJlM3ljanVYSXVWMFBDb0FtUGZ3RFplZWNBT2hoTXI1c1BwQXFqMFEv?=
 =?utf-8?Q?vTwPGhGXRhMuy1s72GyQvrTpt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e03bbb2-8522-4988-667c-08dad83f9180
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 10:41:17.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsqIEkmxn6NHZc53i/DYU6CsUns0P+MmrhSrB2SWwp6hnx2E1iM47xHvw2gX8IgqC8zCfS7tj9Exz9QF2JnmqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Dec-22 8:20 AM, Chengming Zhou wrote:
> We encounter perf warnings when using cgroup events like:
> ```
> cd /sys/fs/cgroup
> mkdir test
> perf stat -e cycles -a -G test
> ```
> 
> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:849 perf_cgroup_switch+0xb2/0xc0
> [   91.393417] Call Trace:
> [   91.393772]  <TASK>
> [   91.394080]  __schedule+0x4ae/0x9f0
> [   91.394535]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [   91.395145]  ? __cond_resched+0x18/0x20
> [   91.395622]  preempt_schedule_common+0x2d/0x70
> [   91.396163]  __cond_resched+0x18/0x20
> [   91.396621]  wait_for_completion+0x2f/0x160
> [   91.397137]  ? cpu_stop_queue_work+0x9e/0x130
> [   91.397665]  affine_move_task+0x18a/0x4f0

nit: These timestamps can be removed in commit log.

> 
> WARNING: CPU: 0 PID: 690 at kernel/events/core.c:829 ctx_sched_in+0x1cf/0x1e0
> [   91.430151] Call Trace:
> [   91.430490]  <TASK>
> [   91.430793]  ? ctx_sched_out+0xb7/0x1b0
> [   91.431274]  perf_cgroup_switch+0x88/0xc0
> [   91.431778]  __schedule+0x4ae/0x9f0
> [   91.432215]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [   91.432825]  ? __cond_resched+0x18/0x20
> [   91.433299]  preempt_schedule_common+0x2d/0x70
> [   91.433839]  __cond_resched+0x18/0x20
> [   91.434298]  wait_for_completion+0x2f/0x160
> [   91.434808]  ? cpu_stop_queue_work+0x9e/0x130
> [   91.435334]  affine_move_task+0x18a/0x4f0
> 
> The above two warnings are not complete here since I remove other
> unimportant information. The problem is caused by the perf cgroup
> events tracking:
> 
> CPU0					CPU1
> perf_event_open()
>   perf_event_alloc()
>     account_event()
>       account_event_cpu()
>         atomic_inc(perf_cgroup_events)
> 					__perf_event_task_sched_out()
> 					  if (atomic_read(perf_cgroup_events))
> 					    perf_cgroup_switch()
> 					      // kernel/events/core.c:849
> 					      WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0)
> 					      if (READ_ONCE(cpuctx->cgrp) == cgrp) // false
> 					        return
> 					      perf_ctx_lock()
> 					      ctx_sched_out()
> 					      cpuctx->cgrp = cgrp
> 					      ctx_sched_in()
> 					        perf_cgroup_set_timestamp()
> 					          // kernel/events/core.c:829
> 					          WARN_ON_ONCE(!ctx->nr_cgroups)
> 					      perf_ctx_unlock()
>   perf_install_in_context()
>     add_event_to_ctx()
>       list_add_event()
>         perf_cgroup_event_enable()
>           ctx->nr_cgroups++
>           cpuctx->cgrp = X

IIUC, since it's a cgroup event, perf_install_in_context() will do:
cpu_function_call(cpu, __perf_install_in_context, event). And thus,
callchain starting with add_event_to_ctx() will be executed on CPU1,
not on CPU0.

> We can see from above that we wrongly use percpu atomic perf_cgroup_events
> to check if we need to perf_cgroup_switch(), which should only be used
> when we know this CPU has cgroup events enabled.
> 
> The commit bd2756811766 ("perf: Rewrite core context handling") change
> to have only one context per-CPU, so we can just use cpuctx->cgrp to
> check if this CPU has cgroup events enabled.
> 
> So percpu atomic perf_cgroup_events is not needed.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Fixes: bd2756811766 ("perf: Rewrite core context handling")

Otherwise looks good.
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
