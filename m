Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57145632F70
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKUV71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKUV7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:59:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5C1C90B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669067964; x=1700603964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hlqvoas9cXLxBIF2K4J/J/D1/dzCxDM0xnKX6+iEm64=;
  b=UFalG1gvyVdrV+abMzcBhXN0VQZHXdar6hJJJvRyB5eAcamw5Yv2/Thu
   bTgSFib8uacaiZUZu2o4Nk8zsHn//fX7xX25bYGSSKrtiHpZHp1Y1dh1K
   3DuCPt9QqX9twdSwlTPKedLTDTYAKu+wSnianqfrRTmjT+RXLkV/WCuJK
   NM2wfwGGu6TikkcLqXGBwNuOTJniTmL9MKLYD7vXAPhCHNCWVrIM6nYF/
   +gK0aA2mqOTmhtVobwXf1uFJ8cbe9asw1na/sSCsoz4geQf/My1s+FBIV
   7+S4Xgh1jemQ+zSX4HkEIwF5yuYmCCgIryZ6dPy7Z+Hg6DhwYrcCo6j3X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312372295"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="312372295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 13:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="618974638"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="618974638"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 13:59:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 13:59:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 13:59:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 13:59:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgC7ID/di7ZS0ntNpQPLHZ5670/aR1XDY9gUTNLWHqP6R7mVqihlBT71tqW8lxMp16XjLutymiAW/7laRlVbfNYafg3I+iEMOIM/lclsuaQoRoLfPNvJuxTkQk7UwLxZkLF29ALh3RbPJcnrDQ+9LzE9aV/eSodHHBy57kYOGahYKQjSzJ/0MvOGA9lrPvB42xoZSIeezqhtBTKTEsK6vBh+kJOUa2vCQHVqs2w696SnMTTVDjgxLz5dhzITakqWVHwsKiapIpuWbCcrdOTWv9sBhQbe7uL9/krUoWhS+jGYkYlkc2IiOLQdRfth2ztBzA4w8OxKu6CkuEQH0TCDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFOlXbXL8yG0HXZD0gz543RYAdD6fQYz0JKD4/b+wNk=;
 b=Bisk2/0MWLLQWGJQe5fNDULAnIbZayvqMDY5Fm9F41m5eck/wTkgrgvntbZ48J6axCgkngzuKDUWoykRzxpqY9gHpK/JsQ1vsvRso32ZJb6chPjeiY0kFnV5IOKH1m1AVnewffDCi/QTgnbxoq8+9rUfIWURZRHm7ZbCI1gNj97t2E3ht37QYHMO789cY7HcHgdyqbi5VqWuREiAcd5AI/UwUM0EgswtZRSaPsiVqMc2t9p30h9J/DQ+cr3kO4VncyK/T8ALPyuV7y9rmKKifcyxoQHYbUPgwqLBHZpzyY/I73N/aUzcUWxMQ0qaRtIK5ldJCrY4sEozKLgeF3vXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 21 Nov
 2022 21:59:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Mon, 21 Nov
 2022 21:59:19 +0000
Message-ID: <85e9d499-5393-f388-7d23-aa68248e5037@intel.com>
Date:   Mon, 21 Nov 2022 13:59:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] x86/resctrl: update task closid/rmid with
 task_call_func()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>, <jannh@google.com>,
        <kpsingh@google.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-3-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221115141953.816851-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6e0c92-b7e9-4561-204e-08dacc0ba3a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGtbrMimDgv6IlxoXCdaA2+znlyuuESMznH4EvpuJydlBgl1TavLytmOKdCedoWgWC5Sxc/RQ38tQtUWdokuTYsLloSWExVhXJgXhfJCRQzhSANSiwnaDQkObAcgMS0AAYKewr8bKzlhB/y2BwmqO/GnV/ls1Pwafs8J+JoVUUP9bEPUAGYhGx+eFhl5eNNXMJt9SHi8kw8ZG/XpeYLl8fx2E22PO/K1E1RybFGcTgBtPt0bnxOD2iPyP4W9Rn8YtkQXYh3HOnFDrL6eKoAuPKJz69FKRkLqZgP4PZ/oBA0MmyTEFBAjvHhvLce3EXOCGGNoMGhdqRA9I+MGdlpZS8UxWrEpHZKIGC7xx7YEBjIxUPbKCMPI77XK9aAdXFXvzUkZD8uW2m+iScPFttBuQ+rb3oqtZSkZVCisn91YhcLXbsBWhgSUX26wSXEbxQ7ZdQxYAoO3REJuoaiYmnFsIPDG+oIj4XvvtmPx0uZ4OKyASXKIqgBlfdmWP0o6jd4S83BQLuh3HBd8a4JUp4rrycUrzfmbs6B5EBlMU40b6KSZuj/cksLDqzDtISG0kQoPoOStTwNsgoIJkjX1C5XkEovC24lZUFFInNXHFfdo8I2ahdZBqrqQidRUwNPh0x+beIMzapOnjuKgeYWnVLgJC+y8GuSVEPu4wnzkMNkJtWZZcTrjiBL93jz8WeuHvGzg3IKK0EIv/dGeTScuKZKNJSaG/DPC7tIydjxjItHynDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(2906002)(83380400001)(82960400001)(186003)(44832011)(2616005)(5660300002)(8936002)(7416002)(15650500001)(38100700002)(66476007)(6512007)(53546011)(6486002)(6506007)(26005)(6666004)(66946007)(478600001)(4326008)(6636002)(316002)(8676002)(41300700001)(66556008)(31686004)(66899015)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRXbGtTcGtOUFFrUnpJUWlZL2lya3FSTU9jUmU2bW1oZHJYdzczL0wyMjhX?=
 =?utf-8?B?V0MvUXNwSVUrN3JtQ1duRTRvSXlnUXhxcHh4TU9zZ29zekwrWnpWbFhTK3JR?=
 =?utf-8?B?QzRCTUFTNlFkNitKSGYvWEg0ekRKWU5kbzBBTk1sYkFOSkJoNkxHUm5mNUhU?=
 =?utf-8?B?TVBnemNpY1NrVy9YcXQrdThmRjBWYnVEZmUxamNPOFdPcjRhVGVXMjJpS0F5?=
 =?utf-8?B?bEpRbUxYZnpMb0hPeEwrS3pCNzNTMHFCK0FWNjNHSHZ2Z2hlUTBKcWVBOGRO?=
 =?utf-8?B?dzJLY09Kb2tYVzlWTkRpVzBVUHRTdFJTQzBBUExpZXFsNVVhK3hWVVE2S2c0?=
 =?utf-8?B?QThtWFQwcUhLd2FMcDJxc0d3ZmJCUnhZR0dCaHlSYnhOVlcvTloyRWVCSit5?=
 =?utf-8?B?QWtyLy8rWDNDcjJWRG43SHpFSW1GekFoT1VHb0RUNWs2RzBBdFRZUExKd2NL?=
 =?utf-8?B?VnJTek9DWGkwYm93KzdDTzVwQmhRcFg0RzFzMVRrTzAwaFB1TkRlMno4dENr?=
 =?utf-8?B?akM0ZHJEVUVHTS9yTGx4MkRITkJrYkZDNzV2ZENkdWIyTURDc3Q5cXc2QWt1?=
 =?utf-8?B?RzJ3RmxLcS9VUm1qa0VOWmpjYkppYXV2WGpkendqYTBuM1hiZG9YaEl3clg4?=
 =?utf-8?B?QlhyMllaMFFWMjdMRER1aG1kMEkxNnJKc3NrdFZXcXZxaU9CdVdJL2ovMGxM?=
 =?utf-8?B?QSt6OG05SnRnNXIwT0hWWkwwN3ZjWGtVcDR5N21RbHNSamxqNU9nSnlWaWhS?=
 =?utf-8?B?MnR3eWsxM2hiTElqRkM3NmdycGtVakxQMmxwcTBwYkE2ampLK0tpUjRuaDVo?=
 =?utf-8?B?TkNQREtDMWJVMWpPRkt3U3RKUGg0eWJYa3VPOUd4UFJ0SkJDMk1lUytZTE1u?=
 =?utf-8?B?VVJORXZsenFabEJjeU5HV25WbXBZZDdFYWRaZGovS0daMW45b3REaW9FME50?=
 =?utf-8?B?UXJvcTZTOVVZNUQ5M1AyeXR6SFlYS2U1RUJQOFRBNkl0MDB3eHZ4ODkvU1Mz?=
 =?utf-8?B?WktxYTlJN1FtRW5FK2hPUG5aMmw2ZWxwRGs2bHJwcFNySUVTQVdJZDZhQU9L?=
 =?utf-8?B?azVoNzhIVjVvNEpnVHdsUFhWSUNIM0FuN3Q0U2RNbm1weTJOSXhSWW9vTXpk?=
 =?utf-8?B?Y2l6M0RMV3RmMnBXT1FuMEZBOUh1eVFKa2pPdEx0KzM2YjV1MmwwWnArMk83?=
 =?utf-8?B?R0V1Z3VRN3lySVJaSE1KYnpmMDJIcllZTXg4MnRva2tYb2gxL0pDL1Y2NWhZ?=
 =?utf-8?B?c1J1RXFXMHJrdFgvc3hCTkhjVmxyYlhFQmp1ZFE3Qkc5V0lkdDhKcklxSVdt?=
 =?utf-8?B?MTZVb2tOTEsxcDBsOGlUNjFyeWprbEN2Ry9pcXRjdjkrL0lZS2VPMmU1TTFl?=
 =?utf-8?B?RTgyUWtUbkp2Nk04bW55cE1YdXBvWGlVaU1KSDJ3b1ZoV01oa0pmaSttVFpT?=
 =?utf-8?B?V3NEZjY3aFpTY25KVFBLY0xJeERVU1VncXBwdkxsQTM0UlNsWFNZUVdnMWNU?=
 =?utf-8?B?d0Fwc25OL05leVpiRlFSbmx5YUVpR2lIdzlKWUJwUXMyMVRoZ2RNUlFGUXFa?=
 =?utf-8?B?Q2IzOFBDVUJndS83cHNhdW9GUEpWblAvY1Q0WTNUZnNPdXBpWTI2RU1ZQmt1?=
 =?utf-8?B?SDMrSjlBeWlyaGtkWVZZYkRGODhvalB0bDI5ajBPRWNnMXQyNWFHaU5mMWY3?=
 =?utf-8?B?T20zNHIwQnNUQWVHMytPa2FoazdraTNTNHZqSnBrbzYwcE5UcUFldlhRdnRQ?=
 =?utf-8?B?RVg3d2NtajRSYVdhREVGSldFdjB0aU9kRzFqUGVJTzRaUXdVblJPVzZZd1hu?=
 =?utf-8?B?K2EvU3ZkZzd5WlNLMkRSNnpZSjZ2VlhUSUdjbEl2NDVTb3piL3dRQ2hGSVBN?=
 =?utf-8?B?MWZrSzE0QitmbU9EaVJnOXVsOS9SQ0JoKzIzcUYzZUNFSWtkTUFyMC92c05l?=
 =?utf-8?B?SHIzSkpLN1lWeWtSREMzazFVa1VJK2F2VHduQ2VjanhpMnc1dVg1WkZRVnNF?=
 =?utf-8?B?Wm0yYk5nUTNWTC9zN0ljOVdGMUoyNWNHbTZjTFhKbVVCc01EcXNYT2lKNXBD?=
 =?utf-8?B?QTVNc3VKcWRzdkk0Y3hXem5FR1hBOVgvSGplNkVJKzdsOWo1TVpyNmFmSjFn?=
 =?utf-8?B?bkNwNWtsRXczbVI0WDlheE40ZHRQL1RzV09pU1N0eUtNNHExcmFFV1doRzAy?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6e0c92-b7e9-4561-204e-08dacc0ba3a5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 21:59:18.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwV7vl96GcG53wPpLUF+Y+HWQmR5jyVagmH46uJH9BJ5+hskgtOFTzU5Kk1TKbL5aT5/gSrbMjgCaJaTk88b31QyzQ/4/6oXeQ/OSuzmb/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6232
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Patch description in subject should start with upper case.

On 11/15/2022 6:19 AM, Peter Newman wrote:
> When determining whether running tasks need to be interrupted due to a
> closid/rmid change, it was possible for the task in question to migrate
> or wake up concurrently without observing the updated values.

Mixing tenses can quickly become confusing. Please stick to imperative tone. 

Also, please start with the context of this work before jumping to
the problem description.

For example (not a requirement to use - feel free to change):
"A task is moved to a resource group when its task id is written to the
destination resource group's "tasks" file. Moving a task to a new
resource group involves updating the task's closid and rmid (found
in its task_struct) and updating the PQR_ASSOC MSR if the task
is current on a CPU.

It is possible for the task to migrate or wake up while it is moved
to a new resource group. In this scenario the task starts running
with the old closid and rmid values but it may not be considered
as running and thus continue running with the old values until it is
rescheduled."

> 
> In particular, __rdtgroup_move_task() assumed that a CPU migrating
> implied that it observed the updated closid/rmid. This assumption is
> broken by the following reorderings, both of which are allowed on x86:
> 
>  1. In __rdtgroup_move_task(), stores updating the closid and rmid in
>     the task structure could reorder with the loads in task_curr() and
>     task_cpu().
>  2. In resctrl_sched_in(), the earlier stores to the fields read by
>     task_curr() could be delayed until after the loads from
>     t->{closid,rmid}.
> 
> Preventing this reordering with barriers would have required an smp_mb()
> in all context switches whenever resctrlfs is mounted.  Instead, when
> moving a single task, use task_call_func() to serialize updates to the
> closid and rmid fields in the task_struct with context switch.

Please adjust the above to imperative tone.

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 +++++++++++++++-----------
>  1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 049971efea2f..511b7cea143f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -538,10 +538,47 @@ static void _update_task_closid_rmid(void *task)
>  		resctrl_sched_in();
>  }
>  
> -static void update_task_closid_rmid(struct task_struct *t)
> +static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
>  {
> -	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> -		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> +	struct rdtgroup *rdtgrp = arg;
> +
> +	/*
> +	 * We assume task_call_func() has provided the necessary serialization
> +	 * with resctrl_sched_in().

Please no "we".

Also, either task_call_func() provides serialization or it does not. Wording
it as "assume" creates uncertainty about this change.

> +	 */
> +	if (rdtgrp->type == RDTCTRL_GROUP) {
> +		t->closid = rdtgrp->closid;
> +		t->rmid = rdtgrp->mon.rmid;
> +	} else if (rdtgrp->type == RDTMON_GROUP) {
> +		t->rmid = rdtgrp->mon.rmid;
> +	}

wrt the READ_ONCE() in __resctrl_sched_in() ... memory_barriers.txt tells me
that "When dealing with CPU-CPU interactions, certain types of memory barrier
should always be paired.  A lack of appropriate pairing is almost certainly
an error." 

> +
> +	/*
> +	 * If the task is current on a CPU, the PQR_ASSOC MSR needs to be
> +	 * updated to make the resource group go into effect. If the task is not
> +	 * current, the MSR will be updated when the task is scheduled in.
> +	 */
> +	return task_curr(t);
> +}
> +
> +static void update_task_closid_rmid(struct task_struct *t,
> +				    struct rdtgroup *rdtgrp)
> +{
> +	/*
> +	 * Serialize the closid and rmid update with context switch. If this
> +	 * function indicates that the task was running, then it needs to be

What does "this function" refer to? Please replace with function name to be
specific since there are a few functions below.

/was running/is running/?

> +	 * interrupted to install the new closid and rmid.
> +	 */
> +	if (task_call_func(t, update_locked_task_closid_rmid, rdtgrp) &&
> +	    IS_ENABLED(CONFIG_SMP))
> +		/*
> +		 * If the task has migrated away from the CPU indicated by
> +		 * task_cpu() below, then it has already switched in on the
> +		 * new CPU using the updated closid and rmid and the call below
> +		 * unnecessary, but harmless.

is unnecessary ?

> +		 */
> +		smp_call_function_single(task_cpu(t),
> +					 _update_task_closid_rmid, t, 1);
>  	else
>  		_update_task_closid_rmid(t);
>  }

Could you please keep update_task_closid_rmid() and
_update_task_closid_rmid() together?

> @@ -557,39 +594,16 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  		return 0;
>  
>  	/*
> -	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
> -	 * updated by them.
> -	 *
> -	 * For ctrl_mon groups, move both closid and rmid.
>  	 * For monitor groups, can move the tasks only from
>  	 * their parent CTRL group.
>  	 */
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP) {
> -		WRITE_ONCE(tsk->closid, rdtgrp->closid);
> -		WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -	} else if (rdtgrp->type == RDTMON_GROUP) {
> -		if (rdtgrp->mon.parent->closid == tsk->closid) {
> -			WRITE_ONCE(tsk->rmid, rdtgrp->mon.rmid);
> -		} else {
> -			rdt_last_cmd_puts("Can't move task to different control group\n");
> -			return -EINVAL;
> -		}
> +	if (rdtgrp->type == RDTMON_GROUP &&
> +	    rdtgrp->mon.parent->closid != tsk->closid) {
> +		rdt_last_cmd_puts("Can't move task to different control group\n");
> +		return -EINVAL;
>  	}
>  
> -	/*
> -	 * Ensure the task's closid and rmid are written before determining if
> -	 * the task is current that will decide if it will be interrupted.
> -	 */
> -	barrier();
> -
> -	/*
> -	 * By now, the task's closid and rmid are set. If the task is current
> -	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
> -	 * group go into effect. If the task is not current, the MSR will be
> -	 * updated when the task is scheduled in.
> -	 */
> -	update_task_closid_rmid(tsk);
> +	update_task_closid_rmid(tsk, rdtgrp);
>  
>  	return 0;
>  }

Reinette
