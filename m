Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7668AB9D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjBDRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 12:19:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9912A9AA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 09:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWslnYCFCzlBgp90HPlhW0urOWb/nhMPXLuaQqc1WqrLFKt+NsdT3Rval9dudGgqdGjkFPb8d6erThSt6Hyx1MMuF4c5MYtivGWZFLbycG9f95objRQEqgURL4kDX5wWbDgxdoKXVBf+07kuyVr1df0WHP+i3qMsq3bvbQ9dbXnSkVSq7v5nzv4eDwx4nXD9tOm+l+nVzQssSMK5JHWJXzommIqqlZJ0ZOcpJ98M+z2rQfxKt9aerCLibRXlr1Mu2b7z/xat6oXMo6EUl7ScljxxLzd4Gy8hmZdiuDPJtZrNkY9HXiDK3tJWFGDH37N0uTg9fnrHK92GfKpKip6YQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc8jBfPhdqeG1XJ6DqcWogxev75X8yl7tnjxSlsKprE=;
 b=nAp6AE9ioqS5QPFLPpAH0Rgjpe/H4lnvbc1rKYiFw10biYR+CPjyBLF1QF4PRLPFlvNvjhHGCS/CekirdSsnsO1S70TVCcFtXOoTdds6kWGCILTGdK4cRFHNl0+DZ6Sdjh0M6OWslML21LmWBELHZuahUXFkUMqwx9UkqeHnyyIFTPYCG9oav9FmnnPrWXDEPUI6F7xJ4r+ZcnxeOOmqmlsbbZM/tzw4Rj8YoZVWLQU/7+rrfLytlpVWKsopPJxpWHu01GGdNVBu+bASZK0Pm/DyI20CzNDi8dsRxWYYXdgcwhSPTx3TLW62/PGelbe9URoEZ7+lrfnxsJX0xX9UFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc8jBfPhdqeG1XJ6DqcWogxev75X8yl7tnjxSlsKprE=;
 b=Re1fUedAKp0lI1z7iVKoSOGjxTe/foSbxUROzZMr3Yt9ifcHoT88GhOLVoSy3mu+kahiO76jfSEvBdCezX4p3VCF/G9ZVxdPV4kaxSig+Mx45RU0v9d3PS7/g0WPIdDR7ZqrfnLwE+D2oks6DfUUTUIlCxt/em13jDTldfZctFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Sat, 4 Feb
 2023 17:19:26 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6043.022; Sat, 4 Feb 2023
 17:19:21 +0000
Message-ID: <ba140594-5276-8353-2fa5-d7499f5bb7a4@amd.com>
Date:   Sat, 4 Feb 2023 22:49:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 1/3] sched/numa: Apply the scan delay to every vma
 instead of tasks
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <1aebc55030925998a3df3cafb79c5cd28b199ea8.1675159422.git.raghavendra.kt@amd.com>
 <Y9zg46/Y7fGUvKCQ@hirez.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y9zg46/Y7fGUvKCQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e3860f-a367-4b77-440d-08db06d3f431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oha/nmC/wEdwQ6z0rPWQkAVgskvGixCFSBCyVjwaC6Tyi5nt2ErKxnEsbatZb9GEBTy+IaU3lgQW2HMhKAvAs9++pbbaOxwwn4TePehh7+7aqygAv1ZVcBaTGALJof6oja7ydqS5gjBOS51KR2odoDZqeUlmtg0dnFr7HtF75P5VOllW+diTspUpt94xPe3lUizEq/c3P0P60JKIE4BCBLZ41e17PN3Bvu7ZlSvJyQCf6uXaaUIDfGCzT8Rxu1bmwMTWvf4IXPnXObUYnCEEDFMWY0hc6RkiQwTuXwcSUGclGK2u4IrmqnRiAMUVpRZhYKRcLw5yvzgvEaVQnmfidD9qjavoJqfSnZeOqONdluWzzXj3Mi/gn/I7xavZCtl9+k04lDrkoj3d5JwcWT5k6vjjakKaIK5V889YF2tZSw8mpIot5TCR9jQCJSYkc+ETrAkJIgPUaMiNsdT6I3RkApmr16bruL7LEM1a9cKuS66KnwRP432qCDptYYyBlP2kO133FOx1NspJmTJhYWdL0xbJ40ZmZfG0dvsqKq7c+TA0Yl2ZSeO46ngpEf+PvEUltt1uC3kXe2ilrrwEPLndG50pD/Lk66mlzmyzz07LN3tAJausEzqtOFeq6vqpnHVb1O58d2/MrlcqZI7huMzoPYVfIKwvOf8U+faiVFG+rJbuUVIIuy7Rx/KtWk0Ry9aWXOal2Uwl/K3kOsgCmb45OQcLC4Y7WqCJwaalzU2cW24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39850400004)(396003)(376002)(451199018)(38100700002)(6486002)(478600001)(186003)(6512007)(26005)(2906002)(66946007)(6666004)(6506007)(41300700001)(8936002)(8676002)(6916009)(66556008)(53546011)(66476007)(4326008)(5660300002)(54906003)(316002)(31696002)(36756003)(2616005)(83380400001)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjBmdHUvQTV2R3BManFkRjBzUTlTZXhkMm9Cc2xzZGN4MGc2R3JwRlpqbnhq?=
 =?utf-8?B?NkFzVERTUnFWVnFpZlJnV0lrcmRoWVhQc2lUNmwzUENYVGR4N3NjYkwyRWhy?=
 =?utf-8?B?VmNzenVOMHBPRHE3Q3EwSVdQRHBqVmllbTdLR09OWDlsTWo1Rm1pVnltNDdS?=
 =?utf-8?B?VU80TFZsUzJaVmxHK1dVTG9hbHJQeWF3aG5uV3ZLdGE5R0l0cHNVeW9UWnJO?=
 =?utf-8?B?OHdmQURCZVdWNFlSYmR2bE9XdUlWdkVJRmpQYndGYmxUTzRYa3ZLYzhBMkJP?=
 =?utf-8?B?c2pHVW1SVE4zRnB1RzY3RmdQamx6NGYzMTlCbDAyeDJpeGtqcWQ0MmF5MFJn?=
 =?utf-8?B?NENhUTN6dVBqTzFyWGcxdWdLc3BobzFBNVJDRERlSXRLbnRMMlU4ZTRxdGVv?=
 =?utf-8?B?NWc4MVAybktVU1AxUUlHTTdqeXp5eUZhWVhPVFVUWVdsbVYydHZ4eUdqZEYx?=
 =?utf-8?B?eDVTVUZxbjBIMENDVGZCcnQzQUorbVZNdVFoL0hzSHY4K1ErbGhIUXB4TjFl?=
 =?utf-8?B?Y3lZNUd6Qmh4S2F6aVVRNlFCajhQNXY0OTRjMzdIV1RyUGM3bmJvRkZyTHEr?=
 =?utf-8?B?RG5rOGc1ZWtEbW56MzMzZEk0WldXZUdWRnJqd09CUXQ4dTE1d0Flek5ibkl6?=
 =?utf-8?B?VXNzbndJMkNySnJLVVJha2JBWHM2WjVyajlnbDhESmtYd0hKNHorL21odzBy?=
 =?utf-8?B?L0l5ZkRrQUhHczdIY0JqcnVzMHFLNUVmTGMvTDJhOWNPb3ljcEc5KytjWGV1?=
 =?utf-8?B?bUlFSTUrSStWejFteHJ0bXBZbm5aUnNlOGEyMUEweExFNHFBdzdkWkh3TEFD?=
 =?utf-8?B?YzFXaU9IQlVUMW9pVEpRMDAvNU45YUdpcnRoRmhIRzZIQ2xUd3M5WUtucEE2?=
 =?utf-8?B?WFZRS2NMMDB5RVdaMnNIK0h0MllYM3UxYTFibXhubnJtWFlDN1FUR011SXhi?=
 =?utf-8?B?OXdJNmp3MTFGbTdwVnVzRFJ6RU1LUTFoQWRxQ0FSaTVwaHdwcGc1Q244Nm1n?=
 =?utf-8?B?WWZGZHFldk5PZlJHc0hvNVR2VmlvejRXSGk5N0JzaXZabm5TM0lsQmtVem9n?=
 =?utf-8?B?Q3BacWRDSzBBS05pK1FxSjBVY240ZmZsdUR0eStidUtPR2NWUFVKc0d6ak9I?=
 =?utf-8?B?RUdCb3Y0WWZicFdjQmluUm5QNnpQSE4zWEV0Zjc4VkFJR1hUYjBtanJETXhG?=
 =?utf-8?B?N1FScUJLUVRCaTVWeVJLQzlYUktDWG4vZWs2OSsyWUNlK2JIZFI0SjhROGQy?=
 =?utf-8?B?VldPU2Zqc1ZobkhLR2FYSjN3Mjc2VU9ING81eFhEcGprWjRoMlB3VVZkL2tC?=
 =?utf-8?B?RktFYVM0dnQ2N2hhMzE5UlZhLzkwdjRtaU9WUE9FMTNnN1FlRVFlWnByd1h1?=
 =?utf-8?B?V3NFZjN1UUU4aEFaanM3TGNOVzdFZDRkNXgwa3dta2FHVEQzazd3R1p6MWll?=
 =?utf-8?B?VlN1c3UzTUV3OC9CQndaU1ZueE5vUHdXRkVWcU1CWkphNHViN1hLNkxUKzFk?=
 =?utf-8?B?NkZERGNSQUpKenNkWkVEZHV5T1RlWWZ5K0UwUHFLOWt2bVJGOWV1SWJmMStk?=
 =?utf-8?B?T3g1UldrWlludTVkN0s3N3BkTjMra0hpbUwvVkRmbmpDbktYellHOVoyUTNN?=
 =?utf-8?B?b2pSNlVldktSSlNENVNjY0JlTHhiNWRZdjNCSTNNSkRDbEtCeno5SzhxOEdZ?=
 =?utf-8?B?U2hhczc2QUlPZU9pZGdkZ0YrTWpOaWFXZHZhcG40RGZFUlVob0FoRi85ODM5?=
 =?utf-8?B?Zm5GQ0NBWWZRUzJjbXpWaFMxVkp3TXhtaXRLcytvQk00SUhEM3N2V2dTUFQr?=
 =?utf-8?B?aGlIY3RLa092d25nd0pVdGNWVHZhUzBjRXBDN3U2aCtlUFpKMnZvT2pYdnY5?=
 =?utf-8?B?cUluekgzS2tsUUx5RjlrZzlPN0ZMRFhqSWwrRCtnaTBEdmhuOTAxaThFZVhG?=
 =?utf-8?B?T3dVUjN0ekZ6ZlRqenREVXBzOVk1MlNrSS9uODRWVXFZQzZ6ajN5S0RiWWNV?=
 =?utf-8?B?cVMxMkFYOEVvRjFwNDJtRU5nNXpsdnBwV0daalVEdzUwSXh5a2RTTnhFaVdz?=
 =?utf-8?B?Y3VzSUtURHlMaDVBazVDdGJGN21WM2lzNC90UXljb0MydE9WWDZvMTYrVXFl?=
 =?utf-8?Q?4ZXd6w2gCFpakUvAcfRz7MU6b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e3860f-a367-4b77-440d-08db06d3f431
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 17:19:21.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn6o5xMN4ONcxVp1j6aZh5B2X7zPPAofu+2Qul5PkZYka3FT5cmSwJfovjhQD/o5LG4DrYNHgWUTr5XA/2NESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2023 3:54 PM, Peter Zijlstra wrote:
> On Wed, Feb 01, 2023 at 01:32:20PM +0530, Raghavendra K T wrote:
>> From: Mel Gorman <mgorman@techsingularity.net>
>>
>>   Avoid scanning new or very short-lived VMAs.
>>
>> (Raghavendra: Add initialization in vm_area_dup())
> 
> Given this is a performance centric patch -- some sort of qualification
> / justification would be much appreciated.
> 

Thank you Peter for the review.
Sure will add more detailed result in cover and summary for the patch
commit message.

> Also, perhaps explain the rationale for the actual heuristics chosen.
> 

Sure will add more detail in the V3

>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>>   include/linux/mm.h       |  9 +++++++++
>>   include/linux/mm_types.h |  7 +++++++
>>   kernel/fork.c            |  2 ++
>>   kernel/sched/fair.c      | 17 +++++++++++++++++
>>   4 files changed, 35 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 974ccca609d2..74d9df1d8982 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -611,6 +611,14 @@ struct vm_operations_struct {
>>   					  unsigned long addr);
>>   };
>>   
>> +#ifdef CONFIG_NUMA_BALANCING
>> +#define vma_numab_init(vma) do { (vma)->numab = NULL; } while (0)
>> +#define vma_numab_free(vma) do { kfree((vma)->numab); } while (0)
>> +#else
>> +static inline void vma_numab_init(struct vm_area_struct *vma) {}
>> +static inline void vma_numab_free(struct vm_area_struct *vma) {}
>> +#endif /* CONFIG_NUMA_BALANCING */
> 
> I'm tripping over the inconsistency of macros and functions here. I'd
> suggest making both cases functions.
> 
> 

Sure will do that

>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 500e536796ca..e84f95a77321 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -435,6 +435,10 @@ struct anon_vma_name {
>>   	char name[];
>>   };
>>   
>> +struct vma_numab {
>> +	unsigned long next_scan;
>> +};
> 
> I'm not sure what a numab is; contraction of new-kebab, something else?
> 
> While I appreciate short names, they'd ideally also make sense. If we
> cannot come up with a better one, perhaps elucidate the reader with a
> comment.

Agree.. How about vma_nuamb vma_numab_state or vma_numab_info as
abbreviation for vma_numa_balancing_info /state?

> 
>> +
>>   /*
>>    * This struct describes a virtual memory area. There is one of these
>>    * per VM-area/task. A VM area is any part of the process virtual memory
>> @@ -504,6 +508,9 @@ struct vm_area_struct {
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..060b241ce3c5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3015,6 +3015,23 @@ static void task_numa_work(struct callback_head *work)
>>   		if (!vma_is_accessible(vma))
>>   			continue;
>>   
>> +		/* Initialise new per-VMA NUMAB state. */
>> +		if (!vma->numab) {
>> +			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
>> +			if (!vma->numab)
>> +				continue;
>> +
>> +			vma->numab->next_scan = now +
>> +				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
>> +		}
>> +
>> +		/*
>> +		 * After the first scan is complete, delay the balancing scan
>> +		 * for new VMAs.
>> +		 */
>> +		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
>> +			continue;
> 
> I think I sorta see why, but I'm thinking it would be good to include
> more of the why in that comment.

Sure. Will add something in the lines of.. "scanning the VMA's of short
lived tasks add more overhead than benefit...."
