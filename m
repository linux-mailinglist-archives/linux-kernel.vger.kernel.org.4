Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E3644C18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLFS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLFS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:57:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64036C54
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670353019; x=1701889019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bowB9BfCSSU88LoWLU+eLspnkZ1YQkcMqIQPxIiiqUk=;
  b=AWLha9EfCGHn5djkNeYZotNM9PP5S1VE9fNHcjE2RiQrSQ81E20pot0C
   V8tbt1uMJaeVeezZfQbbx8M8E0WzYorGuiv8qQyQSKI/DDgZNjIe/EkVp
   GH4iQgD63ptrOFvopB1/1aSYpxb/M343uaG8ch0I2VbzScxqicz+PoPMI
   aOwZ+EVdk9/4svFo1G6bxSBmyJoMKjqr4J5WNOgseWbHpqOondT8t0mSy
   S+NzAqOaP/8jp9r2cwnf9nYV+3bIFkLuddpVUjVrwpRhAbHO/1xpP6l92
   npF6vH3c2LvnSidMCtzXDyWRYz6Ksg/wmnahnmDdrhKNmUSISruJhRFFf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316723989"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316723989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 10:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="678854045"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="678854045"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2022 10:56:58 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 10:56:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 10:56:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 10:56:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf19HIAhwJQCs2zfdFr4BiVERR76JxGxcEJhbm9X3QnYcNsVsGQJWYogaB8W9CX7Ry+W+j9Saqb0GQBOR11S9CIcgk5+hsSIU6os8OYQfnMK2TPiZonN4BqV2FmiR+80y+1prfHfo3csbD+NEzINt1OlSuJb/c2mINc5kVShV72xprLK5+xODUEDj1vZCdLVNjQOokIazrUghbDV+ZHmZW4SPb2wtrr/nlzUQFMUXlEi1sc9aC9uW0E1i2EhTdDeV1FGqp9anGDJ55vYRibgwhgnn7Z7UHAc8563+DZJ5j2BkPtin3UP/9RRm/JI1ZiKi5yGJfBF1tGu7xeMygxqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WAItSUGClOfNXoNihRG3dLDMu77DR1qvbbwH2dwRYY=;
 b=lU5CkWCSaooMHjnwgS4mhRBuE7f58tvTZk4CxA9G4DpeQlbtA9gUPE3GYpCmJwxjwJv0GItgQHf+/WhlHKQIMBpmnVI5MmjB6ZusNnTJW5LpLOBp3LonaTl5+klQJfjVDA5UZv9Vt+A0EH+IGijPawSR15uN4MAFD5rdAaYd+8Jim2tIMPO8w1xeiJv5p+RSuvtneyuOSIiNJjKxKdqeNb2hrHUBfpM/CDyAGiHgYG0ztnRxHq+hSryHLa7fD/nzsoOJAOz+izVO1haNdTWtuCQb5PXqtWVy3JGzhnt4uN1e6XsM4DD5ez8Wj1Zx2QrtgOFJ/Pp97h+E7Xp7LpWkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 18:56:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 18:56:54 +0000
Message-ID: <a713ba13-634d-3061-933c-25a8d62eb0be@intel.com>
Date:   Tue, 6 Dec 2022 10:56:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with
 task_call_func()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>, <jannh@google.com>,
        <kpsingh@google.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20221129111055.953833-1-peternewman@google.com>
 <20221129111055.953833-2-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221129111055.953833-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: bba6f79c-bbc9-4784-0639-08dad7bba426
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQl17OtYaQpGBh4A87jUWedeE4CHTIr+jX5UshEBf7bb/+Pbfhr32NMB0kDIGXCKazYFWY+sb4SlOKmVAXVx50AzZyrNaEkhJQQXjE5W0HSdZgpNVaaOnvznS7Zrbr4keju09dLegfMBujbaBHXHAsQeCUvSLc0GyCKuKD/sFK84TNFLyJjLkEmhQf9eB/OIS0sMR0a1VYT36ctIae1bOO60DJwyNPxBIgHfhvu05lF7xaRP10clHBIB4zjbxxw3M7OejEtTKSZGwgdY9gQrXz5V1mOFvD1zGP72riLlnMj/uFf/jMeNLcBa1o3pIM95JBXN56V+3JZuSIsqcswxkr10YQFKnL64bEnSEgh/pfMtITdT56cxzQP1cm7n4jsJhhCSnHDHOyORZlxFpySWz7Saik4lRNdpjefcP8F417xiIlziSHqH1fWPBPH4ECTvKsfPcpOFvPeQPHlaPifbc3KgpmHRkD8LGlbDK5q7tDZe6FJ+K4N5Uy4u927XdKfa+/TvF8k/i1HtMmRh0QnwQC0P6EJM/0kcbXShJLa5Cod7iZdTINba2LAPJsKsyjQGC6McSAPeFY6TxVEtxcIn6gfCP+njPWdlhaf1MHmPn8TQfRzQZ68DaUrPHJoXsVRJfRBtAprz57cVuEp8/grsK8YfXo2Ej66q6+kZx0tR1vdRbZOUIaGY5NRxiGk0RIaeaR09pfEgk7G9MpxIA4Nofdj3gnn7ZK2K4OsaBfpjNIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(2906002)(44832011)(6486002)(15650500001)(82960400001)(478600001)(41300700001)(4326008)(8676002)(66556008)(86362001)(31696002)(7416002)(5660300002)(8936002)(66946007)(66476007)(31686004)(36756003)(6512007)(26005)(186003)(2616005)(6636002)(38100700002)(6666004)(83380400001)(316002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2RUN2VlUk9jSzlUZEZKdnEwOG1wNUJCcnlUdDlWc2dTVm9iZWxBSWxkQmtK?=
 =?utf-8?B?TjZkYnlJZGFSV1IwU2h5cm9mSm8yZWN4SnBIQVhYcWpPS0JZdnpvb3Z0RlN0?=
 =?utf-8?B?NFI0V2F1cXRCemptRXkwKzhCc2NBeWRVTlZvTzIwZ1gvNWhYRFpNYllXdTVN?=
 =?utf-8?B?ZlA2UGZDdXE5Zmw3NGlzTGNjR3BPS2NwK0RCTEJWejRFZGNGc0VXckVlZDdB?=
 =?utf-8?B?aFpQdEdFODVJTldQbmZKZzdsUkt3ak5qWXRLYzRzVE52L1d4bVEzQWhhWWRo?=
 =?utf-8?B?S1JyckY4YlFUNjVmcmllOUw2cG1aelpoRmZHS0gwZXpFS2dsRnVueVZEblBt?=
 =?utf-8?B?MWpmT3JNTjBUUS9XUm1zbW9uT0ZnZmxJN1ovSi8vVFlPdU8wM2I2aUdZeWJM?=
 =?utf-8?B?cWNrRnF2NmdMR0swRzVsNkU4UlB3NHNTTTU5eGVoYklhY3JaY2wxQkhYV1l4?=
 =?utf-8?B?SGFXaFNwclQxWENWbVBrb0ZIV2pjNkdMWGtlMDVueGpReTZFcXR1K2Y2cVJh?=
 =?utf-8?B?NWJPRmorWXR3Qnp2NGkzVkZxRVJ1TWd0Qm1LRkp3QkFCeEtUOEI1TEJGK3h5?=
 =?utf-8?B?dFNhQVI5dUF5aGVTcSt2eFVpL0lmdWpFR1Q1Yy9taVFVOU1HZmd1L3UvclMy?=
 =?utf-8?B?RDZEcGFzd29FSXRjd2E3dGp2L3hKbU1kSTh3NmYyWllhc2xERGZPWVZQMHd3?=
 =?utf-8?B?Mk83Y096VFdPVU5EcWovY2FBYlkzTDRRZHhrby9BM1NLbW9QbkExSmtSSzVS?=
 =?utf-8?B?UE45dTh4OTVoU1dKcmxFZndGT1QyZUNhQ2k4RGF6amVZZE90U3BXUkczUURS?=
 =?utf-8?B?dk5oUXNuU2NMd1htaHNIcXhZUFhoaUZha2hqUG0wNXVFcTlJRndWVHdsVDMv?=
 =?utf-8?B?L3YvN2RBQTlVSmo1bWExUTZsTlI2Zzc2ODQzQzdtcVZxQ2RzUmJleW1mc2Jj?=
 =?utf-8?B?WWZtTWhkNnhYRXRueTI3VU5PY2thY1F4TUhIOExOTW55TE9WZ2xBVFFZRGxL?=
 =?utf-8?B?UWpid1g5TDhKYUNtbXZGVVQybFlNd2dTVm1JZ0Vsam81UGxVT1YxUUsyMUdM?=
 =?utf-8?B?Y2xONGlsN2cwcXp2ZE4rVmVZZHJPNEtwVk1oTW4wMzBCb2RCZWVOSGtsK1hP?=
 =?utf-8?B?V1Ira2k5RXk5NkliaUN5RThMdkswQVVTM2oxOGg4aTFrc0VKcVJyWWxlaGFz?=
 =?utf-8?B?YzBkRnJ5bnBWYWt0b1dRakpwdUNSYVFPWDljRnZiSCtsSC90MENDbjliMmxB?=
 =?utf-8?B?anYwbThhRkxnQlFBL05RLzVpT1dYUGtJZkpWdkpBalhlWWh0QXIvUkR3UFBW?=
 =?utf-8?B?LzM3UjNhbkRkNG15K3VHTTZleXlMekExZnRRLzVIOWQ0bWhDTCt5RmllbWR1?=
 =?utf-8?B?NXE5aWlvV0YzZTdyUlRncEl4a09ZRFk0NjhqekVEMGxMQ1A4dnJmRVAyK0VY?=
 =?utf-8?B?MFkzUThUUk1JYjRWTzJKUDRRWnVvUHZqWVduamRGNXJCR0FqandLakllc1Fm?=
 =?utf-8?B?ZVlHK095SGdPQ3EveXlBOHRUUkNYSVpKbFBvUzEzUXZleUxPMzlKUytUaWha?=
 =?utf-8?B?UWNYMklSZnJCSktCZTlackN2QUJXVllxbVBQakdpeTJtQzBlYzE3WmdpVWMx?=
 =?utf-8?B?YUJnS2ludHN4cjQ2ODRQdmE5OWRjUVVYUHpoMC9yV1hSMFlmZHplc2xZd3RU?=
 =?utf-8?B?YUhGb0lOdTJvZ3RhQjUxTjdJcytmUkxwcm5QSjRvZHNXVnZYSmtWM1NlQkUw?=
 =?utf-8?B?cWZGUTgyeHJSR1h4UTM2b2NnTG9waHFmbG14aW5EU2Z6ZVlaYzBBTDFjUEpD?=
 =?utf-8?B?a1RNQ3pHckVYZEczRWVlaFF1bW5hNGZyWnlwV1JnNUlxV2VKb3dqWXIzaXBq?=
 =?utf-8?B?S05JTFR0V0VuVmR4aFJHOGVjU1N6VzFDQVVpZnM5dmJpd2tlWm5EenhyZUpI?=
 =?utf-8?B?azlVV3RENGVjR3ZVMHNTM28zazJ0U2JXeE5PbzYzUVRCMWEraE1QaVhqS0JG?=
 =?utf-8?B?eHZCNm91ZXNaNWorbFdMdVAvUHlMNVY4VzRSRUVsc2dtYUZMUkh3VHlJMDZY?=
 =?utf-8?B?bTBHeW9yUFR1RVVaNFVjVG9CcVJMQTkvM0xWOHp5VGNIVHRKbFBTYUc4QmZD?=
 =?utf-8?B?SEVKK1VNMHprUlpFSjFieUVwaU1tL0tTYk81MFp5UlBmcnJWaUNVQS8wVWtP?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bba6f79c-bbc9-4784-0639-08dad7bba426
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 18:56:54.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAkNQrt7LC5f1xkLgowlm+RVCZYNK/SkjMeVVz6fJVBT7rOBrwDtcjQh/ue4Y6F+0stul/AATgf8mG/9QgE2BXqc87krPdksW97IVWpnZLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/29/2022 3:10 AM, Peter Newman wrote:
> When the user moves a running task to a new rdtgroup using the tasks
> file interface, the resulting change in CLOSID/RMID must be immediately
> propagated to the PQR_ASSOC MSR on the task's CPU.
> 
> It is possible for a task to wake up or migrate while it is being moved
> to a new group. If __rdtgroup_move_task() fails to observe that a task
> has begun running or misses that it migrated to a new CPU, the task will
> continue to use the old CLOSID or RMID until it switches in again.
> 
> __rdtgroup_move_task() assumes that if the task migrates off of its CPU
> before it can IPI the task, then the task has already observed the
> updated CLOSID/RMID. Because this is done locklessly and an x86 CPU can
> delay stores until after loads, the following incorrect scenarios are
> possible:
> 
>  1. __rdtgroup_move_task() stores the new closid and rmid in
>     the task structure after it loads task_curr() and task_cpu().

Stating how this scenario encounters the problem would help
so perhaps something like (please feel free to change):
"If the task starts running between a reordered task_curr() check and
the CLOSID/RMID update then it will start running with the old CLOSID/RMID
until it is switched again because __rdtgroup_move_task() failed to determine 
that it needs to be interrupted to obtain the new CLOSID/RMID."

>  2. resctrl_sched_in() loads t->{closid,rmid} before the calling context
>     switch stores new task_curr() and task_cpu() values.

This scenario is not clear to me. Could you please provide more detail about it?
I was trying to follow the context_switch() flow and resctrl_sched_in() is
one of the last things done (context_switch()->switch_to()->resctrl_sched_in()).
From what I can tell rq->curr, as used by task_curr() is set before
even context_switch() is called ... and since the next task is picked from
the CPU's runqueue (and set_task_cpu() sets the task's cpu when moved to
a runqueue) it seems to me that the value used by task_cpu() would also
be set early (before context_switch() is called). It is thus not clear to
me how the above reordering could occur so an example would help a lot.

> 
> Use task_call_func() in __rdtgroup_move_task() to serialize updates to
> the closid and rmid fields in the task_struct with context switch.

Is there a reason why there is a switch between the all caps CLOSID/RMID
at the beginning to the no caps here? 

> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 78 ++++++++++++++++----------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e5a48f05e787..59b7ffcd53bb 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -528,6 +528,31 @@ static void rdtgroup_remove(struct rdtgroup *rdtgrp)
>  	kfree(rdtgrp);
>  }
>  
> +static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
> +{
> +	struct rdtgroup *rdtgrp = arg;
> +
> +	/*
> +	 * Although task_call_func() serializes the writes below with the paired
> +	 * reads in resctrl_sched_in(), resctrl_sched_in() still needs
> +	 * READ_ONCE() due to rdt_move_group_tasks(), so use WRITE_ONCE() here
> +	 * to conform.
> +	 */
> +	if (rdtgrp->type == RDTCTRL_GROUP) {
> +		WRITE_ONCE(t->closid, rdtgrp->closid);
> +		WRITE_ONCE(t->rmid, rdtgrp->mon.rmid);
> +	} else if (rdtgrp->type == RDTMON_GROUP) {
> +		WRITE_ONCE(t->rmid, rdtgrp->mon.rmid);
> +	}
> +
> +	/*
> +	 * If the task is current on a CPU, the PQR_ASSOC MSR needs to be
> +	 * updated to make the resource group go into effect. If the task is not
> +	 * current, the MSR will be updated when the task is scheduled in.
> +	 */
> +	return task_curr(t);
> +}
> +
>  static void _update_task_closid_rmid(void *task)
>  {
>  	/*
> @@ -538,10 +563,24 @@ static void _update_task_closid_rmid(void *task)
>  		resctrl_sched_in();
>  }
>  
> -static void update_task_closid_rmid(struct task_struct *t)
> +static void update_task_closid_rmid(struct task_struct *t,
> +				    struct rdtgroup *rdtgrp)
>  {
> -	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> -		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> +	/*
> +	 * Serialize the closid and rmid update with context switch. If
> +	 * task_call_func() indicates that the task was running during
> +	 * update_locked_task_closid_rmid(), then interrupt it.
> +	 */
> +	if (task_call_func(t, update_locked_task_closid_rmid, rdtgrp) &&
> +	    IS_ENABLED(CONFIG_SMP))
> +		/*
> +		 * If the task has migrated away from the CPU indicated by
> +		 * task_cpu() below, then it has already switched in on the
> +		 * new CPU using the updated closid and rmid and the call below
> +		 * is unnecessary, but harmless.
> +		 */
> +		smp_call_function_single(task_cpu(t),
> +					 _update_task_closid_rmid, t, 1);
>  	else
>  		_update_task_closid_rmid(t);
>  }
> @@ -557,39 +596,16 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
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

The change looks good to me.

Reinette
