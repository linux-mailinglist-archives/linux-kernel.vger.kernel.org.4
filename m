Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BFB68ABC9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjBDSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:15:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8DF301AB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix7ly2cEl92LnNazcR1MftsqzQ51+/FOrBI9PveDNfXjUfv8MLIGLpV/4cKvREiWd3fySbBm/1PAjKQ90vhEezpzrZXtLQ7PE9bLqzgrMvcRVo/JaGNQtpIEdMj0DFXs+VKQ2NTragZE6HwR1il2aOIc1HjczZGj8UkITI8rEahuJeKi6iiXImSjLumE0SVnhYuGaIbNB4NNiZjtXgO/AeCEtX9mPqYBlFCHPZgGgBJh5PwpDsTjkZma9t3wjNogH/hNbLR8Qn3wFN6bj9e5iR3GobugPc3AeaqLTlwb8Sno/hmf00S7Swt2zDl5Fe9iFsIw9+D4Cux53Vr5PW/0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+/uutRptGHZc5YvA2xO/W/eKemH6WdjxrmxnOTL2MQ=;
 b=BHgAU5RPMMApS7urCbLvXAzFadpDjZ7We2wAseaDftCtPQ7vGXRFzAk/S0edEVgbFBOWbj2OLa6C51Ag9NnEGpOIBODX44QuA0N5kf0fiEz8ssDsVZBV5AgpM6Qqe5v1CUy5K98e/LD60OkiIUAlUlGIrOOSDy6fhlnOO82pyyUJjUv4HIMJnKIg4R6X+phj3GmqHkyqRqNyw2yX3raX2xj/yIJlMKEg2XToSK78vDgcs5W/qoFp+51xutC+FWqumV/N3OVRIwIcHz+YvYFqUI0wz3rvEV02JsV2ZIfkp91S2fOjP3vt6cNmzKX+ljMvwdB8TJA7oXYhTqtHgp4HBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+/uutRptGHZc5YvA2xO/W/eKemH6WdjxrmxnOTL2MQ=;
 b=PQKOYM+cFBXc63CLXy6LYld+wnskIMa1L/5v7aluUf8/8OkX61vY+GhebyvQ07NdaaUKSaCXLEGTx7DB2sMcAtqMW/8DOkTZf+JLNHBd10wFmpMNNN7Bnq6RcifLscFeVf/V9k4PvGUHPmtuU6pnQPMiYUxIqfQzI0musRGLHL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Sat, 4 Feb
 2023 18:15:09 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6043.022; Sat, 4 Feb 2023
 18:15:09 +0000
Message-ID: <048964e8-179f-de7b-1190-831779d9911f@amd.com>
Date:   Sat, 4 Feb 2023 23:44:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bd544d-752c-4bab-0301-08db06dbbfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nw97Gipdkd6vtxvBhwYTTVebr6bYyMbLAjWFUO3TRgi4vo1k300yo08nSXYbOpi766MT6t69SeQaTIHcwL0hjvCbLrwemhgkdv9v25+JoK25YEiB9mwkdZajbSnEmaVIrbUFSwj6klc/Ovj3mTYBzFXUc7P2WeZetsE03mIFQcCC6M6YAv/Y8xsVmGq4nr8Gwmvi0sHjiCkhE9tT7GGyahA8zY+8HoDcWQ/6oqU7o+FdjmycJQM0yrfH6MRC+LPsVN9Tqgihu0IPaXLpGqEjpFuhVCN6fZw/hTSf3kjUATx8Tx2PNdxRD8M871ywg79Dqhtil/kpQpZiymVTZLFCHvofgMcpeFZhJqaRIJRjnAnbVZp3cjL11nivxTynoiSmofgEoujBssG5z35KgN0M0WPWDvPA4VMkP5RubfTHpIlHtoOV5sY4ljVexHotqZrPoB1s+GF6Zcl7c1ov+ziX2EksSEIB0pwsFnb0PUpPktDZrYOKIU5ktUUB/ujF6seuQj9k20z4oi5N/iq5UF76cPuqDVf2DzU+0yE/jJ1m7EMVqBagfpbFR95o7s/nZ1xHmMQ+qhoGUfeXZxrDpjlb4qI4ltv64S1TxfCnADuL9nXg89sO9HsRV8cBvgYgUGOcKiPHYz3KvAZFyp3cQ8sTMQnJGWu8IIqHqYXshC4/0GfBTczJWi9nyAaFtLhGKL+BrIazLQmlO/MOjI6Ju0nDH4eNuJpMi9hspyvbe5MVcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(36756003)(66476007)(478600001)(83380400001)(66556008)(4326008)(66946007)(38100700002)(6916009)(6506007)(54906003)(8676002)(316002)(31696002)(186003)(6666004)(6512007)(26005)(6486002)(5660300002)(53546011)(41300700001)(2616005)(8936002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEZ2TEdWOWxJbEJWTHJVOXJzdWtyQjVDUTlMZWZCRGE5TFlVZS9meE1kYXdr?=
 =?utf-8?B?bVFRcXUyQkV0L2dxdGVpc2l3M3RwNkkyenFKZ1NMa2VObVlLTFovSUY5SUJh?=
 =?utf-8?B?bkVma2duUVo4ZXJnZ3NJb3R3a3J4RHJyM2JsUWFyN3AyNmtRdnR1cHgyOURt?=
 =?utf-8?B?Rm5vOXg2aDFEc0M5VlhqRFRWOUZ4aFhvVkpiWmZYK0dOQjBSbk1MaVhHZ2NP?=
 =?utf-8?B?K0k4bW9FUFNmTDhqTUFqeFo1MUlXUlRDclM5cDJuK3F5Ly9ERUdXeks2VUU1?=
 =?utf-8?B?TVNpM1cybHFMS0VBYXlPejV6NDNLQnc1d2lNbkhBNFMrQjRZdVVuVjdvZ09k?=
 =?utf-8?B?S3oyajczYjZHMkozUnVUbmdXZVRVNGhlQmdreFppdGNaLzRQTnU0Si9aRERD?=
 =?utf-8?B?VXRHSmVtOHJUeDE1cGVwWGFLOExQekxZcVIrTlNLTW1RNXVpQXBXT1VsZVli?=
 =?utf-8?B?a3JQQkIwTk5BVTM4M1h4SnZIRmZPRDJjTlR1YkZFMFhqSGRQVklhUUZzMmZj?=
 =?utf-8?B?OEdWN2lTeUUwT3lxcFJMTGVjWSswSlhOMXM4aVNyMU5laTl6TTFKRlJOYVlJ?=
 =?utf-8?B?RVZ4RWUxN1dkQlFvdTJiN2orVlZxQmRuSU5rUGpNcC81ZW4rYVFieXRTendW?=
 =?utf-8?B?SW5xNDdscXkyUmZlNXFxVVppWTFxYkdWRE9OcHB5bXJYSEE4ZUVTMnQ1TWtV?=
 =?utf-8?B?YWU1bCtocUZLQzVHTTlVcVk4UEY3c2xCZ254TStldkdoa2dLSDFQUnFkUG9k?=
 =?utf-8?B?Z294WjJsWGZnUnlLZW9RTjlrRUZOWGVwb2UxeUVXcTd2S0Vua25jYlBDckl2?=
 =?utf-8?B?VWxJQUVMYlpZOHZPUDdCeXVCc0JvU1krQmdUOUFnQjBrUFlHNGZnVlJXZ1dC?=
 =?utf-8?B?bXVDb1hvajVXZlNaaHlEbzdLV01tUmg2NCtxbkpFdlZWdjlaWWJiVVQ5ZHU4?=
 =?utf-8?B?M2dZeEdMbTQ4cUtsY3dMUnBuZlVLd1g5U2tOcE9mZUZoSGlMVEw2L3RBRjN1?=
 =?utf-8?B?QVhySTRkTHczUHkzVjFYVFRSSzhxdkhVNWhRV29hWEFQS2RRakZpOFJvZ2hN?=
 =?utf-8?B?QWVxZG1MeU1TdkdGYlZtZ3pOOEVZdWpLRHYzVVB3cDRWWEJ0K1NVZzIvNENz?=
 =?utf-8?B?cTd2Q1VUSHV1SjVJU3hGeDFxTHJxaGZETGFnMFBMakptQjU1Ymoxd1hyVDE1?=
 =?utf-8?B?RWlubFBsekhCa0RtSVljU281R25MekZMWjBpNEo2UVFYWnRKdGQ4MW9xaWVJ?=
 =?utf-8?B?NUVwMjVwTk9tSGI1aXdDV1dkOWZOcGRoY2hqMFJmTllzenpNa01KTFJYUGtB?=
 =?utf-8?B?bUFHYldtL2J3dklJZldYUHd4NmJnRUNsekV4YXJuakhRcDhaajQyRFhqcHhY?=
 =?utf-8?B?Rms3Z1A3LzZCWWU5U243dlN3NnJzNDBiK29qQm0yTm5kT09vcEFBeHRMY3R0?=
 =?utf-8?B?RDZVOFJ5bldHN1ZXL3AwSWw0SSt2M3ZwQk1IcHZra3FKcUl4RUtkUnpJRkp1?=
 =?utf-8?B?VnN5RHJ6YjN5REdlRnljZGVBZlBDa3A4WUxSeHNUQ0IzVGJkMTVzSmVqdldi?=
 =?utf-8?B?MVF0N002VDJKaEdHb2VPK2ZWYkRXcU1HVlUzTnpmbWozMVV5bHFRc0V6SGtv?=
 =?utf-8?B?L1RMSWloRnY2ME91N3VKMmtYN1llVERxTFg1RC9CNVJUZk9lMWJ2eC93TEpC?=
 =?utf-8?B?VHhpMmhxK1lNL0ZwbWtiRFZNR1gwRmhZMGROejlNTXRJMmhSckU0RWxVTmxp?=
 =?utf-8?B?bCtLcEJXZDZGSjJ5RFIwQVBKV2dLODQzclMvMnE0ZUpLT3hHTUZQazMzSVZH?=
 =?utf-8?B?dmpGOVQzN1RwNXMwMStYZ3lwOHYwVW4xamhzYTlBcWVZY2JFWWgvbkFiYmxH?=
 =?utf-8?B?Z2FOaUJGNS9OWlFqMjJFRjlHT0VaOXBub1FVM0U5ZDFTMWlwUXpzNW5sR1kx?=
 =?utf-8?B?TU0yaUM2V0RoazZ5a2hmdVM5K0RaWERVUzZVS2RpVFBOZGJobEx1Vnp1ZFgv?=
 =?utf-8?B?dUNMdkU5Tlc4RWZGTDY3WVc3L0Z5dUlCeUNDaWYza0dvUzNoN2ErUDZoT0g2?=
 =?utf-8?B?VExDVzMrV3h4dlA2ZDhNQWNuRVJIWVNOYjFNVk9ibG5TZGFpRGo3R0lNYno5?=
 =?utf-8?Q?FHtULP49s2INXTFwaiktwUkxN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bd544d-752c-4bab-0301-08db06dbbfe5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 18:15:09.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zVRxxsUWaYQmC7qtpBR2y4z6pQNkkaYfO/3XNMzaAD501UMGVDZT10lgSx5EctkIO3VgnqrtsE9ZUa6UBo2ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2023 4:45 PM, Peter Zijlstra wrote:
> On Wed, Feb 01, 2023 at 01:32:21PM +0530, Raghavendra K T wrote:
>>   During the Numa scanning make sure only relevant vmas of the
>> tasks are scanned.
>>
>> Before:
>>   All the tasks of a process participate in scanning the vma
>> even if they do not access vma in it's lifespan.
>>
>> Now:
>>   Except cases of first few unconditional scans, if a process do
>> not touch vma (exluding false positive cases of PID collisions)
>> tasks no longer scan all vma.
>>
>> Logic used:
>> 1) 6 bits of PID used to mark active bit in vma numab status during
>>   fault to remember PIDs accessing vma. (Thanks Mel)
>>
>> 2) Subsequently in scan path, vma scanning is skipped if current PID
>> had not accessed vma.
>>
>> 3) First two times we do allow unconditional scan to preserve earlier
>>   behaviour of scanning.
>>
>> Acknowledgement to Bharata B Rao <bharata@amd.com> for initial patch
>> to store pid information.
>>
>> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>>   include/linux/mm.h       | 14 ++++++++++++++
>>   include/linux/mm_types.h |  1 +
>>   kernel/sched/fair.c      | 15 +++++++++++++++
>>   mm/huge_memory.c         |  1 +
>>   mm/memory.c              |  1 +
>>   5 files changed, 32 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 74d9df1d8982..489422942482 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1381,6 +1381,16 @@ static inline int xchg_page_access_time(struct page *page, int time)
>>   	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
>>   	return last_time << PAGE_ACCESS_TIME_BUCKETS;
>>   }
>> +
>> +static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
>> +{
>> +	unsigned int active_pid_bit;
>> +
>> +	if (vma->numab) {
>> +		active_pid_bit = current->pid % BITS_PER_LONG;
>> +		vma->numab->accessing_pids |= 1UL << active_pid_bit;
>> +	}
>> +}
> 
> Perhaps:
> 
> 	if (vma->numab)
> 		__set_bit(current->pid % BITS_PER_LONG, &vma->numab->pids);
> 
> ?
> 
> Or maybe even:
> 
> 	bit = current->pid % BITS_PER_LONG;
> 	if (vma->numab && !__test_bit(bit, &vma->numab->pids))
> 		__set_bit(bit, &vma->numab->pids);
> 
> 

Sure ..will use one of the above.

>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 060b241ce3c5..3505ae57c07c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2916,6 +2916,18 @@ static void reset_ptenuma_scan(struct task_struct *p)
>>   	p->mm->numa_scan_offset = 0;
>>   }
>>   
>> +static bool vma_is_accessed(struct vm_area_struct *vma)
>> +{
>> +	unsigned int active_pid_bit;
>> +
> 	/*
> 	 * Tell us why 2....
> 	 */

Agree. The logic is more towards allowing unconditional scan first two
times to build task/page relation. I will experiment if we further need
to allow for two full passes if "multi-stage node selection" (=4), to
take care of early migration.

But only doubt I have is numa_scan_seq is per mm and thus will it create
corner cases or we need to have a per vma count separately when a new
VMA is created..

>> +	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
>> +		return true;
>> +
>> +	active_pid_bit = current->pid % BITS_PER_LONG;
>> +
>> +	return vma->numab->accessing_pids & (1UL << active_pid_bit);
> 	return __test_bit(current->pid % BITS_PER_LONG, &vma->numab->pids)
>> +}
>> +
>>   /*
>>    * The expensive part of numa migration is done from task_work context.
>>    * Triggered from task_tick_numa().
>> @@ -3032,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
>>   		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
>>   			continue;
>>   
> 		/*
> 		 * tell us more...
> 		 */

Sure. Since this is the core of the whole logic where we want to confine 
VMA scan to PIDs of interest mostly.

>> +		if (!vma_is_accessed(vma))
>> +			continue;
>> +
>>   		do {
>>   			start = max(start, vma->vm_start);
>>   			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
> 
> 
> This feels wrong, specifically we track numa_scan_offset per mm, now, if
> we divide the threads into two dis-joint groups each only using their
> own set of vmas (in fact quite common for workloads with proper data
> partitioning) it is possible to consistently sample one set of threads
> and thus not scan the other set of vmas.
> 
> It seems somewhat unlikely, but not impossible to create significant
> unfairness.
> 

Agree, But that is the reason why we want to allow first few
unconditional scans Or am I missing something?

>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 811d19b5c4f6..d908aa95f3c3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1485,6 +1485,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	bool was_writable = pmd_savedwrite(oldpmd);
>>   	int flags = 0;
>>   
>> +	vma_set_active_pid_bit(vma);
>>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>   	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>>   		spin_unlock(vmf->ptl);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 8c8420934d60..2ec3045cb8b3 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4718,6 +4718,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	bool was_writable = pte_savedwrite(vmf->orig_pte);
>>   	int flags = 0;
>>   
>> +	vma_set_active_pid_bit(vma);
>>   	/*
>>   	 * The "pte" at this point cannot be used safely without
>>   	 * validation through pte_unmap_same(). It's of NUMA type but
> 
> Urghh... do_*numa_page() is two near identical functions.. is there
> really no sane way to de-duplicate at least some of that?
> 

Agree. I will explore and will take that as a separate TODO.

> Also, is this placement right, you're marking the thread even before we
> know there's even a page there. I would expect this somewhere around
> where we track lastpid.
> 

Good point. I will check this again

> Maybe numa_migrate_prep() ?

yes.. there was no hurry to record accessing pid early above...

