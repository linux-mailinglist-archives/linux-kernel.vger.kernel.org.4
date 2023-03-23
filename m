Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A206C6FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCWSCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:02:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F3EC78
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679594532; x=1711130532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=viEnczaBTzKqbbhef0N8sYKLK1VyXua4ZOecvjpq1Gc=;
  b=ZFCG9/++aVdwASkvy9LrplQsrUaxQT7GlxJmWQpXt6uy+szRefDq5QXk
   rFTG6wqMjZEk/8T7Vjdf/eA2kiECQYmgfDj3QQ4VBQejD7J2FrrvcufEw
   Z48LORv6odNhSQybRNb1bET5ebs5TCF7aISclfKku2tXAFk01iK2Qr9pi
   mfPEi/hVQ2LNlhwd2yTHbJ6RHYoY9s2F9WqOsT2nr4ktXctiyjrBBWuzX
   uIdHIQ50lyK33AJaDZqBoKVnfHaKH6fiboD/G2i3ut6VRoRXoQsaoxeeQ
   SYvXiSnAkq/PEJiTF1UEHnbiTh+432EV8GOLt4uhtso3XQTeONUN3q5Pl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="404484704"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="404484704"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 11:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="659714187"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="659714187"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2023 11:02:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 11:02:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 11:02:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 11:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5k6dhWMKxAHfDzn4cCtd9L3ZgeejAXDvtZdgxqwidXJ1yE0PsT29NuD977f3Xk2DSw7JgXmMFxkqjgD8GEB/VJyVMFr4EGdi0w2ONdFMcw7EQFetmcpiFOso1gC0fGUrTRehnSLNrK2JGHlAoAxSUWfUpw5qxbOIYxgxlbbZimH+EaenNcdvbxqzFlw8G+ldpIXaDj4UBwBjfpxZznYiuElfhaybbvn7IZEQg8W0URtz35QvykyGgmoN4kbSXxWBnCbbEF0T3Btqbf7lrkQoB6pU4fQ+/i8gdlJzm+R6rJyidvXlDF/XazyJdoi3sOLmXCU7OWzBPw5JNQJH/E2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOsic0G0OcImg2Jc6M9SBghaydljq4qm1CBT7Gc4kpY=;
 b=QbsjOoKSqq7M0CAsji8w7mtdlQt+L34pnJ4VEE5JC32PKk+pWioE1FqYhh2L1X5M1JDS4ZSYDK2POp90UTlH3BdKdZBciRxreChPz5Bb5dzgaU+vHLdm7LuRiHgh56/7Vz2wtB9TBkheOpkDP8EMPajRFXWtVBSwXOesUqhzDLQBaQ5g2Du9fCtkNzI6SDFN1Iqx2UrL70do77w5stbpiOeVisZwDc2VUwN5G/p230aKWOX5Q6rOM8Q70GBUAdHkI8WlDLzzProWcA/+bth7tRmXpGfDsxghDBpOnNZzD2bhuLiP81rccIB51LnlMCFxsx/MA2tIGHxolRk1nENdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 18:02:06 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.038; Thu, 23 Mar
 2023 18:02:06 +0000
Message-ID: <f103ec28-01b4-d4ca-f6e9-d557ea4efb81@intel.com>
Date:   Thu, 23 Mar 2023 11:02:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/3] x86/resctrl: Parameterize rdt_move_group_tasks()
 task matching
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-3-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230308131452.383914-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: d61eca25-de66-4e86-4011-08db2bc8b67b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8mJJuJyMTAvkrmPUMCetJKifSvNYprv0v1deDi0lJfTOo4kTV7oFLcwG0iVVDAjEPH2sBEJYlEp2CXVcUmqCGWi0Vp1+AWmf2dKqIXjiRTe641j7QTkgz3+bONjqWHDHOoI2+QPzgnlRE0zcAJ1lGH7r/bLhE1gAhdY6OptuFgqXHAy785mw8dehYy8xv8b/dkvvfmjB0jHh7PhMUaOp13ofBpg4HuYxRVrRaWaAEWgO9cCFktG+ucuDys094MM9DqZs7Lyxu9uvurZoL9JJoidLvPOVpiEjggycmtKr07JL5Necjx0udDV9shZK8Bb98uiJYwvU96xT08KFMxe6bP3BYPJ76BsJfHlCiheaXVWV/dgpjfCaBdPuBUAbEPzCTJZAuyxPD1SOJkCDSjXkZIzzyHBrgUeFiE0OMVd3RDOV5EGatVpcOzopwjxkQCXwz/S1dKxDag+4kxT2RSLf7bjjU3CtPOAIYVlpTO47kXOd6VFC6f1w0pXApQZXPrDmIHIGQbVDq+0HnedsnI4r0vKpdjBpM55Xw/A9/hXq4jqazs4SmOWh2vXq5FP6FN2h2qs+7FGQ5BDULzPRrobvgEVoCq/hyPOuv1RJAfMOEZnh7m7ImRHs+oD2TghpH6v8TvQm1nXFCrv6v2sHPqETI2g7UakthyMChHYDcraVmwbyDUJmxkKg9wk1/Nw6Uq48f9lqGfjdPVc6jlJTUin93QfkgoDDl2HG2bekG+M5ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199018)(31696002)(86362001)(36756003)(82960400001)(38100700002)(41300700001)(44832011)(7416002)(4326008)(2906002)(5660300002)(8676002)(66476007)(66556008)(8936002)(6636002)(2616005)(6512007)(66946007)(186003)(53546011)(6506007)(83380400001)(26005)(316002)(6486002)(6666004)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHluTWwwdjNYUUhKYW9XTXM4ZHdtRDI0NWZ1OS9TSThJVXVRaUcvYkRUeXkz?=
 =?utf-8?B?QXY1cXR4NTRSWUdBQXdaUDZFYjR0ZWJVOHNibUdhdkRpMUhNS2luM0JrS1k5?=
 =?utf-8?B?aS9oZ0JmczYxUDZEb2N0SE9RWEl6YUUwQjgva3hIN1hiZzdtS0liVStXTHdr?=
 =?utf-8?B?UTFSZkY2RkdHTFhobnFlUzIrVFMwV0NJNkE1T1pNeTMxc0Frejk3RmMycnI3?=
 =?utf-8?B?OUtuWXRpUlB3ZEp3OEx5TXhNTUp2M2dwNnpLa0VXRUt3T25Vbm1IODFuMjE5?=
 =?utf-8?B?c2gvc3k2NkxzU0hCMHBieTNEVURXaDNjV0JNemVDRXhaVkNGSC9qUjZiKzh0?=
 =?utf-8?B?eEFGMU5ndmlJR2twVGE2YUt5RFNPYjJzWGRFTlpqS1FweEhDTERpYjJ1bVM4?=
 =?utf-8?B?cUtuNW5GVGZqK2FoUnlWd2NiWExkZW9aSjllWUN5bDlNdmhUM0U3R3QwZ2xs?=
 =?utf-8?B?SkVIOWdKSUMySjNBWUpJSXF3VEEyNVhPRERnODhDelRTUDI0dFM4a2JWWjlz?=
 =?utf-8?B?V3VMZ3dFYUwzRTNxUVhKOWFBaWlpT1BaWWxyYzJIQk11K3d0WVVYQ2pYczBK?=
 =?utf-8?B?dDI0dFladzVVR3Fva21Tekw4K0RhTmFnYUVmUmprQzRnTTNpRHlQakNlZVhG?=
 =?utf-8?B?SUdXRVBvZ1dZYXduYkEvMVBxQmpUQ3E3Sld0N1I5TER2RGNscjlVTlBEY0sr?=
 =?utf-8?B?aG5xdFUyMTEzSU5DQ0ZUdzJPeXBYb1hQMFdwREV1QlAyZkQ1aTlWNzJlMWJo?=
 =?utf-8?B?MDRDQldXSmJqMFpQaW51ZmpKV3RON0N2MXA5UmpLM0xEMTFrbHZYVko2Z3Fl?=
 =?utf-8?B?ZFNBRmJhU3RTMk1sMUNoWWg2VnhJdmNSTFVlTmFFcWtlbHZZMmx2UmtEWldX?=
 =?utf-8?B?K1MyT1hDcjQrZnJVNENQM3ZPWCs4dzRVUU9MUVQ0YXlRTnc0dXBIN3FmT2ln?=
 =?utf-8?B?K0Rmc3JSMmx1ckh2dmJ5WlYrRHRLeHNwSGphY2RqVHNlYXBDaTNuY3k3Y21s?=
 =?utf-8?B?T011RU1YMFdDcHdsWkNPaTlWazEzZVNLRUdINlo0ZzA3TGwwcTZ0YXNxaVN1?=
 =?utf-8?B?Sm9DSkErVEc3UTlicjZhbE14ZisyNFVJcmRGS0dDTEdYd2YxZ1FUOUNKa0dR?=
 =?utf-8?B?allVRzZBTldneURZRnlra09pd2lwNDNvY3dpQzd4M04wZU81Um1lZ3AvNHNn?=
 =?utf-8?B?RXFubEdqeUxubm5USUVxWmhublRkeGhxNVErSFEvVkdIbDVBcE04TFo1OGVn?=
 =?utf-8?B?MVllcUxEVm9WekszaEE5QlpTS0hwc3JUOERkd3pTRGRWV0c5Wm5hcUd6UXJx?=
 =?utf-8?B?eTRidDlONlVPcjJHZkhWcXd2Y01ySENlQllBT0EvMHBVS0dOOHBpNEg3c2JF?=
 =?utf-8?B?RTZKb3FpVXp2emRYbDUxb2lPUkN5K2c1alhiSzVDUDhTTFM3YUVHUGIxNUNZ?=
 =?utf-8?B?NEhuYWIxcnFBYnkwWDlSOFAxOFJQNytDT2FlSEwyd083WFNyUWZzV2dJc0FZ?=
 =?utf-8?B?T2tqVHp6RDFsMU5sOEZXZHA0d05RRUNRbytPSzZWaFpvNVRUTngvaG4xbHla?=
 =?utf-8?B?dDdtQ1Y0K2FheXJTdjA0V0dEdEdvSm5MR1VMbndXWnJCWUVXZVhXdnBNSnJH?=
 =?utf-8?B?UjlIckNJaUJYaU8vQytuVktFeU5oS09zZGJ2UTB4MllhWUkvSDZ1S0IyQzdI?=
 =?utf-8?B?dDNoeEFyOGhjc2Fta1RtaWhwNW1uVzhPQ0V1L1I3dUJObDUzSWRvWVBJOS82?=
 =?utf-8?B?bmFHcHpQbzJKRWtGUFc4UlNjMXBweVVaUGFNbUFZL2M0RlQ2V2Y5NXlGNEtM?=
 =?utf-8?B?T2JoVmdjSWJYU1F5ZjU4d0x0TnZOcGdwUElObzdQSEpwOS9GRHFWMDd2SFcr?=
 =?utf-8?B?WVRuV2czd1QySzRHUkxBWCtXd0MycW4yWGRFVnRaekVrSHB0aFM5TkRXeFJ2?=
 =?utf-8?B?c0Faa0VTWUtEVloyTzFsTnNSU0pYS1NEMDg3cy9aanErUElyUzdnVVU3WG53?=
 =?utf-8?B?Sks1eFRMSjNVbFU0MFhLWE9LczVUL0x5QmZBMXNJSGh6amoralJDSFVIMmZG?=
 =?utf-8?B?a3lYK0lja000MndzemxiTTV6b3VQMEY0RWxJVGxwNWQrZk8zbnNVWk1nNUZx?=
 =?utf-8?B?MWFYa2pud0dCZmwrOXFUb1ZsVkh5cnNWTWFqenlWd3ZpU2trb013aEpXdHRS?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d61eca25-de66-4e86-4011-08db2bc8b67b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 18:02:06.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLK6whhYA61HUWQpASlW4hFCPGB4ozw/UsmVEfLcrZtQgYOttTyLljJSzlxZCqAUOiZG40WleTVKeHeIqi5ody5yT504sEODzlc/L5F2g4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/8/2023 5:14 AM, Peter Newman wrote:
> Allow rdt_move_group_tasks() to be used for new group-scope operations.

This changelog jumps right into the solution. By doing so it makes what
follows hard to parse. Could you please start with the context, then
the problem and end with the solution?

> This function is currently only used to implement rmdir on a group or
> unmounting resctrlfs.
> 
> Callers now provide a filtering function to indicate which tasks should
> be moved.
> 
> No functional change.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 +++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c3fb525d52e9..84af23a29612 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2393,22 +2393,29 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  }
>  
>  /*
> - * Move tasks from one to the other group. If @from is NULL, then all tasks
> - * in the systems are moved unconditionally (used for teardown).
> + * Move tasks from one to the other group.
> + *
> + * @from:		passed unmodified to task_match_fn() for each task

When using this format it usually starts with a description of the parameter
before moving to how the parameter is used. Perhaps prefix the above with
something like "Resource group tasks are moved from." (Please feel free to
improve.) When starting to provide multiple sentences it helps formatting
to have each sentence start with a capital letter and end with a period.

> + * @to:			group providing new config values for matching tasks
> + * @task_match_fn:	callback returning true when a task requires update

Could this order please match the order of the parameters in the function?

> + * @mask:		output-parameter indicating set of CPUs impacted by this
> + *			operation
>   *
>   * If @mask is not NULL the cpus on which moved tasks are running are set
>   * in that mask so the update smp function call is restricted to affected
>   * cpus.

Could the above be merged with the earlier description of @mask? Please change
cpus to CPUs if you do.

>   */
> -static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
> -				 struct cpumask *mask)
> +static void rdt_move_group_tasks(struct rdtgroup *from,
> +				 struct rdtgroup *to,
> +				 struct cpumask *mask,
> +				 bool task_match_fn(struct task_struct *,
> +						    struct rdtgroup *))
>  {
>  	struct task_struct *p, *t;
>  
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(p, t) {
> -		if (!from || is_closid_match(t, from) ||
> -		    is_rmid_match(t, from)) {
> +		if (task_match_fn(t, from)) {
>  			WRITE_ONCE(t->closid, to->closid);
>  			WRITE_ONCE(t->rmid, to->mon.rmid);
>  
> @@ -2451,6 +2458,15 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
>  	}
>  }
>  
> +/*
> + * If @from is NULL, then all tasks in the systems are moved unconditionally
> + * (used for teardown).

Could this description be expanded to describe what the matching does? Just jumping
in with the above sentence is quite cryptic.

> + */
> +static bool rmdir_match(struct task_struct *t, struct rdtgroup *from)

Could the function's name please reflect what the function does as opposed to
what the current users are doing at the time they call it? Perhaps
something like "task_in_any_group()" (thinking ahead about a possible
"task_in_mon_group()" for the next patch, please feel free to change).
Also note that the "from" is another naming that reflects the usage as
opposed to what the function does. It could just be "rdtgrp".

> +{
> +	return !from || is_closid_match(t, from) || is_rmid_match(t, from);
> +}
> +
>  /*
>   * Forcibly remove all of subdirectories under root.
>   */
> @@ -2459,7 +2475,7 @@ static void rmdir_all_sub(void)
>  	struct rdtgroup *rdtgrp, *tmp;
>  
>  	/* Move all tasks to the default resource group */
> -	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
> +	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL, rmdir_match);
>  
>  	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
>  		/* Free any child rmids */
> @@ -3124,7 +3140,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	int cpu;
>  
>  	/* Give any tasks back to the parent group */
> -	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask, rmdir_match);
>  
>  	/* Update per cpu rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> @@ -3164,7 +3180,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  	int cpu;
>  
>  	/* Give any tasks back to the default group */
> -	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask, rmdir_match);
>  
>  	/* Give any CPUs back to the default group */
>  	cpumask_or(&rdtgroup_default.cpu_mask,

This looks good. Thanks for creating the match function. I think it
turned out well.

Reinette
