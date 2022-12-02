Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78638640C47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiLBRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiLBRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:36:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862B4E8E3C;
        Fri,  2 Dec 2022 09:36:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZL1KyY5nGlmPZiPAxy2zp3zzArTzEafsyqDCgu46cwqH7heJzVQsHVbz/gxQZCs7KqNN9Q4YUqBI5hbtw2aLUdYsA4j3la31vLJbdujF0CKgj5ioTU3EFnp+ve3WxDibBysftypak17/IQuPfKajnl+RXFOJwnNesCLoC+bhTA+LHYtQjrLJwgdv8SAH1BkiaiIDu+m8g68FWUeAqJNAfPZ3ApcM11fTsy5B/WGG+8arjqtnOYNC0lUre/LM6Va/pyUT/wXSS3OIANVoqA63AUIpZ3SHdgttnAtRL8UdTqyoIahq3X4ALBYkpuIlBJ/u27a3jP1P1TA31u2TIxIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaLDJKJFR7h9S+fLwepeGiI82n3q8iTPjNh0FbI9RnQ=;
 b=j2m0+md2bRplE+OUxSUIK6of1SLkVQc+25XEfw3ha06A5r+ugopLhBVJqu/DsVmMLuEtU/iNmPdPV8i4TcNVgb0pBckq4cqEv+64TOGcTf6qiaEImi5Xfp+0IpAeg3eYe8Qx8bpZL4FkJgWZJlcJ1wcqyhM56u5nvQnQ77qwqyZ4Modf2BWaD3WVsIbF4JS16AMM6vg6hcfpOsbrJPaRuY3Oe+jGyMXr0ZW0UJKHy9ORI4uthe4xl3p7AffVkdB64+dOYI/HSpgxak4f1XmDA37O7bUUXQw0MlEzNGUurYwkunXnBA2i9Y/fDSIfukp738pl0/RsBMfwGHDCyfBGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaLDJKJFR7h9S+fLwepeGiI82n3q8iTPjNh0FbI9RnQ=;
 b=u2qAgSvZ01gzRQSzdrwIZNk5QX0LIwL3ZhVhv5i1TlJDpLJ1VYb+JgkP7++TWgkXvtVd9OtFwtCFvmEEND5xDftKLnxDOV1lliO11jcbeTJC38y8z44pwvYfeaNpquDtSVORBRolPwPzGTZWliLDSX8azmIMiWzCs0rKNgcyDcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 17:36:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 17:36:32 +0000
Message-ID: <2d2aa27b-8af5-7379-07db-cfde2cda44b7@amd.com>
Date:   Fri, 2 Dec 2022 11:36:29 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 04/11] cpufreq: amd_pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-5-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221202074719.623673-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: e28d9ebc-0398-4804-da1a-08dad48bc081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y903vcBFjT4lkz3bSDwF1V5fWA1pyqUcih8MLLKxt/s0PfNVUno/V167ZycHRuPaQk40cUSb0jXiCwOScupeC/HeS6kpIL/3Sw+Vr7AatcymjpDy7MGtuXwLE7hkMLTHs6qValxpRCwCAhu+KnLpbKsO3Pe1P8AT1t0dqajrXmWfxLHb7IFTH/RppWewE5JYMyaL81T2zLYKnAwZIIONlrXoluDDNEFNssURhepTbaoxObqvgevNDxZ9niGYeoZ61s5SFWFbLVjZ7IMloDX3fk7756TT1oEhDHM71U3Id+inXOMoFRuD4qYoXS05CiHr/TU4AyHqicX6WKuG4guv+rI9G7m+c+QSPVmsQSOwou7ntlFzMNIG76tHl3yfCCg7ZUEQBUABiJEe9Xq8C/Yoa7bs0r0OdF0Iubnp2iR8HcC0dY7t4ODic8l92ETsY+wIh7rggMVxHoWOxrik/K3vdO7qwD6JIXYcLjOvubTP9Eiv5JKsI8oTPXi1IGJyftiFFwhNPwUqBqa0DYrbJqZ5bSxrHMPQzhI+qmF7GN2U3eCqTQe0cMLkwcg5vb0xS+qcCQlk1tuMfpL9R8y8flUp1TSgoZWwSN4/DgwgnQGWi8nvd/WLvHM6JQnJOkigbwkZLOezNBd3hJRyC01uKlTE5a/aXmeXjhmP+lduo3Kl8wU7jtT0RnyG2gyj9js9DIAx0LFDdRcY0Ra7ticdSp27+OpQYutOP7VLBk51gY3X2RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199015)(86362001)(31696002)(6486002)(6506007)(53546011)(41300700001)(36756003)(6666004)(478600001)(30864003)(5660300002)(66476007)(4326008)(2906002)(316002)(66556008)(8936002)(66946007)(8676002)(38100700002)(26005)(186003)(6512007)(2616005)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lDU1hQaTVTNy9YWERTU0NQb0dQYWhvbUQvNnFzOXgyZTFXdENLOTZkSDBB?=
 =?utf-8?B?VENXL3RTSmlvcXRFZmZZSTZLVkpaaXlBUU51bFBnV09Ubll0VCtlTGRqeSs0?=
 =?utf-8?B?NG1RUWdUMjlrcUFDZTAyY3BMTUR6SExIc1JPSDlXTGxTOTYydEhiRXFJbEU3?=
 =?utf-8?B?YXBFdVdqenZTa0xOTFFjVXEvcXNva3FCOHV2ZncyeGFCZlpZVlhHcnR3bGVN?=
 =?utf-8?B?bDJIUFFVYlVBOFF6R1F6Q1JGN21OUll2ZitvSU5JQzJCYXlkVU9wSDJadGpT?=
 =?utf-8?B?NkdsaFR3M1J1MnZIdkpPQlJ6aDJUYzcwdTRLcFdjZ0hCQVR1c1RJK3U0RlF5?=
 =?utf-8?B?eFhpMVM3MWt0YlM0QzAzUWNhOU55SC9kUTQ3dUN0OFlQOFJGWEFHakpPWW94?=
 =?utf-8?B?MEkyNHMxaDMzYmlIMktIb3ZVTzhLcklLamhUclhDZG5XcU1uakd2S1A3L0Zo?=
 =?utf-8?B?U1VFNVNxOTFaWHBhc0VYM2FWMGFYVVpMVlNmT212ZXdtT0JFamRtdThpd2VF?=
 =?utf-8?B?N09peWNPazNFZVFGSEE0TXFTdHJXYUxtZ0YveWtwWFRLNDJNc3YxMGZ5dWRY?=
 =?utf-8?B?bHZtVGs2aXFFZUx1OElmSTBxK2lrV1JxQWFVb3N4bFVrMmNGK1hBWm9IcUVp?=
 =?utf-8?B?eWt3OXBPT0ZYT0JiUnRlUUNSeXJ2VEtzTXhQODNvajc3S3djQldTL1R2V0dI?=
 =?utf-8?B?OE1aR3BJbGd5N3RENEFjRm9ta0FWd3Q5V0pCQ3JZTnB5OC9sMFIvUkJDcHVw?=
 =?utf-8?B?aWIrWHMyWmlQNDl0Zi9CNDNJMFBXU1loSWJtVlY5d0pORFQyempXZU9NN25C?=
 =?utf-8?B?MEpWOG5OSVphOEhaRlpDc3pWLys4ZGsvYjJUOW9lZHRPSUlWWUNZVXRnTkJM?=
 =?utf-8?B?amJSRFlDckc1Yy9oWmhJTHRMTkYreG9lS0dtb2JCR2dkT2RXVTNiUjA0Vk1G?=
 =?utf-8?B?dEVXWUVGNnVtUUNnWlJzL2dQWlRPTnBkWHJ1elFYcmRnOU1QL3hJVVEwWTM5?=
 =?utf-8?B?N1FvazJLbnR1RU53YzBBcVdoT212SU13ZTFQQTlWS3p3VENMTzVBTm0rWG1O?=
 =?utf-8?B?MGJZSmpOQ09YNjI1dlFtZ01RdmZZOUh6aVp6cnRmOGI0YmRXNHRFUmFUL0xO?=
 =?utf-8?B?MVNjV2ZMdGF5VU00QkdRZlNLWGhYTWoybU9UdHVSVGR5aEVoOG9sTGo0b2xI?=
 =?utf-8?B?V3liSXBwRFZKUXUzVkM3akV3bzVhM1lHYlJCSXJVNXFoeG5HZ3NaajM4a0R0?=
 =?utf-8?B?QWFWaVc2RjRmRmt0ampCRW1PdFFMV0xVRENGMUxLTDJMT1AzOTZ1eVpwT3B0?=
 =?utf-8?B?NkNWYVVJQjlxZUdteStuUTRzd1JBdUdQNml5S3hPdVZ3SndXVkhJVTZCV00x?=
 =?utf-8?B?dUJzSlhaWWVUcTdKcllqOFk1VXpjd0RhY01nMXVScVNNQkw4SWlITGFQU0Np?=
 =?utf-8?B?SHh5UHdjTHRtSGUvMHZoaGdXN0dHeG9wU0puU1I4cytORmREZ3lHcjJld1Fz?=
 =?utf-8?B?MDZucnBUa2hxQktPWEJSYXY1ZFNKa1VZem9LZU1Za1NkOUhwNysvWkloaFZv?=
 =?utf-8?B?ck1wTG5ReEJMYmhiSWpKVkw1TDBtWDFuaFUvamljK25zZXYvdm1ubCsxa0hO?=
 =?utf-8?B?d3k5SW5yWmxqaUpMR2Z1UWRDbm1IVWNpOXNsaGlCY040dGJHUm15RlgxN3Na?=
 =?utf-8?B?ZzdsQktuTHVRcnMvVzRpT0ZRZ2lCdFBtaHpvSE1lYllrZGRBVXE4a0dVMU5m?=
 =?utf-8?B?cmZ3LzlaT1B4MzBmaGU5QXFSRC9WdUppWHM5Z2k1ZTVJV1c4R3orRm05SHFs?=
 =?utf-8?B?RTJ1USt1NDE5RVdlOGFOd3BwM0tPUWNUZmF3OWZRdERueFhjWi9LcXd4bDNv?=
 =?utf-8?B?MGd4dTlpYTBpWWw0MmNJVGxJMGVSNUVMUER0N2FzWnZ5WUw2UzYvTFk0czdS?=
 =?utf-8?B?QUxxczRJekxsZ3FXbHhudEFuNXl6SDhtQzZlclUwTWFCZjRLSWREWm9rV005?=
 =?utf-8?B?UUdISEg2YnFYL3p0bmoycjAxNEw4b1dSalhuWTFYSDV0RmIrd3l6cjZMcUx1?=
 =?utf-8?B?elc3ejUwRlQ3SFZEc2xBYWtaK0JOcVlpVDZYbjRUcDV2SHU5MlNFeTlXZ0ww?=
 =?utf-8?Q?l4MHzm+Bt/QssJlY1+eU4ElJY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28d9ebc-0398-4804-da1a-08dad48bc081
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 17:36:32.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPgojlHV9HA7i/XljFGzlGuHXqltSeZWBwpcpPl7DF8Q9rL/W2fhUVWoRUcOLr2eBc2FlntYq60R0DCH0FphJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2022 01:47, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add EPP driver support for AMD SoCs which support a dedicated MSR for
> CPPC.  EPP is used by the DPM controller to configure the frequency that
> a core operates at during short periods of activity.
> 
> The SoC EPP targets are configured on a scale from 0 to 255 where 0
> represents maximum performance and 255 represents maximum efficiency.
> 
> The amd-pstate driver exports profile string names to userspace that are
> tied to specific EPP values.
> 
> The balance_performance string (0x80) provides the best balance for
> efficiency versus power on most systems, but users can choose other
> strings to meet their needs as well.
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> $ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
> balance_performance
> 
> To enable the driver,it needs to add `amd_pstate=active` to kernel
> command line and kernel will load the active mode epp driver
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 643 ++++++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h   |  35 ++
>   2 files changed, 672 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..5989d4d25d0f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -37,9 +37,12 @@
>   #include <linux/uaccess.h>
>   #include <linux/static_call.h>
>   #include <linux/amd-pstate.h>
> +#include <linux/cpufreq_common.h>
>   
> +#ifdef CONFIG_ACPI
>   #include <acpi/processor.h>
>   #include <acpi/cppc_acpi.h>
> +#endif
>   
>   #include <asm/msr.h>
>   #include <asm/processor.h>
> @@ -59,9 +62,130 @@
>    * we disable it by default to go acpi-cpufreq on these processors and add a
>    * module parameter to be able to enable it manually for debugging.
>    */
> -static struct cpufreq_driver amd_pstate_driver;
> +static bool cppc_active;
>   static int cppc_load __initdata;
>   
> +static struct cpufreq_driver *default_pstate_driver;
> +static struct amd_cpudata **all_cpu_data;
> +static struct amd_pstate_params global_params;
> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static bool cppc_boost __read_mostly;
> +struct kobject *amd_pstate_kobj;
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
Rather than making this conditional I would think that amd-pstate should 
probably depend on or select CONFIG_ACPI_CPPC_LIB, no?

> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	s16 epp;
> +	struct cppc_perf_caps perf_caps;
> +	int ret;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		if (!cppc_req_cached) {
> +			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +					&cppc_req_cached);
> +			if (epp)
> +				return epp;
> +		}
> +		epp = (cppc_req_cached >> 24) & 0xFF;
> +	} else {
> +		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +		epp = (s16) perf_caps.energy_perf;
> +	}
> +
> +	return epp;
> +}
> +#endif
> +
> +static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
> +{
> +	s16 epp;
> +	int index = -EINVAL;
> +
> +	epp = amd_pstate_get_epp(cpudata, 0);
> +	if (epp < 0)
> +		return epp;
> +
> +	switch (epp) {
> +	case HWP_EPP_PERFORMANCE:
> +		index = EPP_INDEX_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_PERFORMANCE:
> +		index = EPP_INDEX_BALANCE_PERFORMANCE;
> +		break;
> +	case HWP_EPP_BALANCE_POWERSAVE:
> +		index = EPP_INDEX_BALANCE_POWERSAVE;
> +		break;
> +	case HWP_EPP_POWERSAVE:
> +		index = EPP_INDEX_POWERSAVE;
> +		break;
> +	default:
> +			break;
> +	}
> +
> +	return index;
> +}
> +
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
> +{
> +	int ret;
> +	struct cppc_perf_ctrls perf_ctrls;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +		if (!ret)
> +			cpudata->epp_cached = epp;
> +	} else {
> +		perf_ctrls.energy_perf = epp;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +		cpudata->epp_cached = epp;
> +	}
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
> +		int pref_index)
> +{
> +	int epp = -EINVAL;
> +	int ret;
> +
> +	if (!pref_index) {
> +		pr_debug("EPP pref_index is invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (epp == -EINVAL)
> +		epp = epp_values[pref_index];
> +
> +	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		pr_debug("EPP cannot be set under performance policy\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = amd_pstate_set_epp(cpudata, epp);
> +
> +	return ret;
> +}
> +#endif
> +
>   static inline int pstate_enable(bool enable)
>   {
>   	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -70,11 +194,21 @@ static inline int pstate_enable(bool enable)
>   static int cppc_enable(bool enable)
>   {
>   	int cpu, ret = 0;
> +	struct cppc_perf_ctrls perf_ctrls;
>   
>   	for_each_present_cpu(cpu) {
>   		ret = cppc_set_enable(cpu, enable);
>   		if (ret)
>   			return ret;
> +
> +		/* Enable autonomous mode for EPP */
> +		if (!cppc_active) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	return ret;
> @@ -417,7 +551,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   		return;
>   
>   	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -591,10 +725,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   	return sprintf(&buf[0], "%u\n", perf);
>   }
>   
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int ret = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		ret += sysfs_emit(buf, "%s", energy_perf_strings[i++]);
> +
> +	ret += sysfs_emit(buf, "\n");
> +
> +	return ret;
> +}
> +
> +static ssize_t store_energy_performance_preference(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	char str_preference[21];
> +	ssize_t ret;
> +
> +	ret = sscanf(buf, "%20s", str_preference);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	ret = match_string(energy_perf_strings, -1, str_preference);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_limits_lock);
> +	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
> +	mutex_unlock(&amd_pstate_limits_lock);
> +
> +	return ret ?: count;
> +}
> +
> +static ssize_t show_energy_performance_preference(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	int preference;
> +
> +	preference = amd_pstate_get_energy_pref_index(cpudata);
> +	if (preference < 0)
> +		return preference;
> +
> +	return  sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);

You've got an extra space after "return".

> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> +cpufreq_freq_attr_rw(energy_performance_preference);
> +cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -603,6 +788,429 @@ static struct freq_attr *amd_pstate_attr[] = {
>   	NULL,
>   };
>   
> +static struct freq_attr *amd_pstate_epp_attr[] = {
> +	&amd_pstate_max_freq,
> +	&amd_pstate_lowest_nonlinear_freq,
> +	&amd_pstate_highest_perf,
> +	&energy_performance_preference,
> +	&energy_performance_available_preferences,
> +	NULL,
> +};
> +
> +static inline void update_boost_state(void)
> +{
> +	u64 misc_en;
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[0];
> +	rdmsrl(MSR_K7_HWCR, misc_en);
> +	global_params.cppc_boost_disabled = misc_en & BIT_ULL(25);
> +}
> +
> +static bool amd_pstate_acpi_pm_profile_server(void)
> +{
> +	if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
> +	    acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
> +		return true;
> +
> +	return false;
> +}

Right now this is only used to control boost, but I wonder if this 
should instad also control the default EPP policy as all?

> +
> +static int amd_pstate_init_cpu(unsigned int cpunum)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	cpudata = all_cpu_data[cpunum];
> +	if (!cpudata) {
> +		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +		if (!cpudata)
> +			return -ENOMEM;
> +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> +
> +		cpudata->cpu = cpunum;
> +
> +		if (cppc_active) {
> +			if (amd_pstate_acpi_pm_profile_server())
> +				cppc_boost = true;
> +		}
> +
> +	}
> +	cpudata->epp_powersave = -EINVAL;
> +	cpudata->epp_policy = 0; > +	pr_debug("controlling: cpu %d\n", cpunum);
> +	return 0;
> +}
> +
> +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;
> +
> +	rc = amd_pstate_init_cpu(policy->cpu);
> +	if (rc)
> +		return rc;
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
> +
> +	rc = amd_pstate_init_perf(cpudata);
> +	if (rc)
> +		goto free_cpudata1;
> +
> +	min_freq = amd_get_min_freq(cpudata);
> +	max_freq = amd_get_max_freq(cpudata);
> +	nominal_freq = amd_get_nominal_freq(cpudata);
> +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> +				min_freq, max_freq);
> +		ret = -EINVAL;
> +		goto free_cpudata1;
> +	}
> +
> +	policy->min = min_freq;
> +	policy->max = max_freq;
> +
> +	policy->cpuinfo.min_freq = min_freq;
> +	policy->cpuinfo.max_freq = max_freq;
> +	/* It will be updated by governor */
> +	policy->cur = policy->cpuinfo.min_freq;
> +
> +	/* Initial processor data capability frequencies */
> +	cpudata->max_freq = max_freq;
> +	cpudata->min_freq = min_freq;
> +	cpudata->nominal_freq = nominal_freq;
> +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> +
> +	policy->driver_data = cpudata;
> +
> +	update_boost_state();
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC))
> +		policy->fast_switch_possible = true;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> +	}
> +	amd_pstate_boost_init(cpudata);
> +
> +	return 0;
> +
> +free_cpudata1:
> +	kfree(cpudata);
> +	return ret;
> +}
> +
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	ret = __amd_pstate_cpu_init(policy);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);
> +
> +	if (!policy)
> +		return;
> +
> +	refresh_frequency_limits(policy);
> +	cpufreq_cpu_put(policy);
> +}
> +
> +static void amd_pstate_epp_update_limits(unsigned int cpu)
> +{
> +	mutex_lock(&amd_pstate_driver_lock);
> +	update_boost_state();
> +	if (global_params.cppc_boost_disabled) {
> +		for_each_possible_cpu(cpu)
> +			amd_pstate_update_max_freq(cpu);
> +	} else {
> +		cpufreq_update_policy(cpu);
> +	}
> +	mutex_unlock(&amd_pstate_driver_lock);
> +}
> +
> +static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
> +
> +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u32 max_limit = (hwp_req & 0xff);
> +	u32 min_limit = (hwp_req & 0xff00) >> 8;
> +	u32 boost_level1;
> +
> +	/* If max and min are equal or already at max, nothing to boost */
> +	if (max_limit == min_limit)
> +		return;
> +
> +	/* Set boost max and min to initial value */
> +	if (!cpudata->cppc_boost_min)
> +		cpudata->cppc_boost_min = min_limit;
> +
> +	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) + min_limit) >> 1);
> +
> +	if (cpudata->cppc_boost_min < boost_level1)
> +		cpudata->cppc_boost_min = boost_level1;
> +	else if (cpudata->cppc_boost_min < AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = AMD_CPPC_NOMINAL_PERF(hwp_cap);
> +	else if (cpudata->cppc_boost_min == AMD_CPPC_NOMINAL_PERF(hwp_cap))
> +		cpudata->cppc_boost_min = max_limit;
> +	else
> +		return;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> +{
> +	bool expired;
> +
> +	if (cpudata->cppc_boost_min) {
> +		expired = time_after64(cpudata->sample.time, cpudata->last_update +
> +					cppc_boost_hold_time_ns);
> +
> +		if (expired) {
> +			wrmsrl(MSR_AMD_CPPC_REQ, cpudata->cppc_req_cached);
> +			cpudata->cppc_boost_min = 0;
> +		}
> +	}
> +
> +	cpudata->last_update = cpudata->sample.time;
> +}
> +
> +static inline void amd_pstate_boost_update_util(struct amd_cpudata *cpudata,
> +						      u64 time)
> +{
> +	cpudata->sample.time = time;
> +	if (smp_processor_id() != cpudata->cpu)
> +		return;
> +
> +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> +		bool do_io = false;
> +
> +		cpudata->sched_flags = 0;
> +		/*
> +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> +		 * is set all the time, we can't just conclude that there is
> +		 * some IO bound activity is scheduled on this CPU with just
> +		 * one occurrence. If we receive at least two in two
> +		 * consecutive ticks, then we treat as boost candidate.
> +		 * This is leveraged from Intel Pstate driver.
> +		 */
> +		if (time_before64(time, cpudata->last_io_update + 2 * TICK_NSEC))
> +			do_io = true;
> +
> +		cpudata->last_io_update = time;
> +
> +		if (do_io)
> +			amd_pstate_boost_up(cpudata);
> +
> +	} else {
> +		amd_pstate_boost_down(cpudata);
> +	}
> +}
> +
> +static inline void amd_pstate_cppc_update_hook(struct update_util_data *data,
> +						u64 time, unsigned int flags)
> +{
> +	struct amd_cpudata *cpudata = container_of(data,
> +				struct amd_cpudata, update_util);
> +
> +	cpudata->sched_flags |= flags;
> +
> +	if (smp_processor_id() == cpudata->cpu)
> +		amd_pstate_boost_update_util(cpudata, time);
> +}
> +
> +static void amd_pstate_clear_update_util_hook(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +
> +	if (!cpudata->update_util_set)
> +		return;
> +
> +	cpufreq_remove_update_util_hook(cpu);
> +	cpudata->update_util_set = false;
> +	synchronize_rcu();
> +}
> +
> +static void amd_pstate_set_update_util_hook(unsigned int cpu_num)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
> +
> +	if (!cppc_boost) {
> +		if (cpudata->update_util_set)
> +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> +		return;
> +	}
> +
> +	if (cpudata->update_util_set)
> +		return;
> +
> +	cpudata->sample.time = 0;
> +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> +						amd_pstate_cppc_update_hook);
> +	cpudata->update_util_set = true;
> +}
> +
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
> +	int ret;
> +
> +	max_perf = READ_ONCE(cpudata->highest_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> +		min_perf = max_perf;
> +
> +	/* Initial min/max values for CPPC Performance Controls Register */
> +	value &= ~AMD_CPPC_MIN_PERF(~0L);
> +	value |= AMD_CPPC_MIN_PERF(min_perf);
> +
> +	value &= ~AMD_CPPC_MAX_PERF(~0L);
> +	value |= AMD_CPPC_MAX_PERF(max_perf);
> +
> +	/* CPPC EPP feature require to set zero to the desire perf bit */
> +	value &= ~AMD_CPPC_DES_PERF(~0L);
> +	value |= AMD_CPPC_DES_PERF(0);
> +
> +	if (cpudata->epp_policy == cpudata->policy)
> +		goto skip_epp;
> +
> +	cpudata->epp_policy = cpudata->policy;
> +
> +	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		cpudata->epp_powersave = epp;
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		if (cpudata->epp_powersave < 0)
> +			goto skip_epp;
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +		epp = cpudata->epp_powersave;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +	if (!ret)
> +		cpudata->epp_cached = epp;
> +}
> +
> +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata)
> +{
> +	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
> +	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
> +	u32 max_limit = (hwp_cap >> 24) & 0xff;
> +
> +	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
> +	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
> +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
> +	cpudata = all_cpu_data[policy->cpu];
> +	cpudata->policy = policy->policy;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		mutex_lock(&amd_pstate_limits_lock);
> +
> +		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +			amd_pstate_clear_update_util_hook(policy->cpu);
> +			amd_pstate_set_max_limits(cpudata);
> +		} else {
> +			amd_pstate_set_update_util_hook(policy->cpu);
> +		}
> +
> +		if (boot_cpu_has(X86_FEATURE_CPPC))
> +			amd_pstate_epp_init(policy->cpu);
> +
> +		mutex_unlock(&amd_pstate_limits_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> +					   struct cpufreq_policy_data *policy)
> +{
> +	update_boost_state();
> +	cpufreq_verify_within_cpu_limits(policy);
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>   static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
> @@ -616,8 +1224,20 @@ static struct cpufreq_driver amd_pstate_driver = {
>   	.attr		= amd_pstate_attr,
>   };
>   
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.update_limits	= amd_pstate_epp_update_limits,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>   static int __init amd_pstate_init(void)
>   {
> +	static struct amd_cpudata **cpudata;
>   	int ret;
>   
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> @@ -644,7 +1264,8 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (!cppc_active)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>   		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -652,6 +1273,10 @@ static int __init amd_pstate_init(void)
>   		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>   	}
>   
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> @@ -659,9 +1284,9 @@ static int __init amd_pstate_init(void)
>   		return ret;
>   	}
>   
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> +		pr_err("failed to register amd pstate driver with return %d\n",
>   		       ret);
>   
>   	return ret;
> @@ -676,8 +1301,14 @@ static int __init amd_pstate_param(char *str)
>   	if (!strcmp(str, "disable")) {
>   		cppc_load = 0;
>   		pr_info("driver is explicitly disabled\n");
> -	} else if (!strcmp(str, "passive"))
> +	} else if (!strcmp(str, "passive")) {
>   		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_driver;
> +	} else if (!strcmp(str, "active")) {
> +		cppc_active = 1;
> +		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	}
>   
>   	return 0;
>   }
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 1c4b8659f171..888af62040f1 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -25,6 +25,7 @@ struct amd_aperf_mperf {
>   	u64 aperf;
>   	u64 mperf;
>   	u64 tsc;
> +	u64 time;
>   };
>   
>   /**
> @@ -47,6 +48,18 @@ struct amd_aperf_mperf {
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value
>    * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_powersave: Last saved CPPC energy performance preference
> +				when policy switched to performance
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @sched_flags: Store scheduler flags for possible cross CPU update
> + * @update_util_set: CPUFreq utility callback is set
> + * @last_update: Time stamp of the last performance state update
> + * @cppc_boost_min: Last CPPC boosted min performance state
> + * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
> + * @update_util: Cpufreq utility callback information
> + * @sample: the stored performance sample
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +85,28 @@ struct amd_cpudata {
>   
>   	u64	freq;
>   	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_powersave;
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u32	sched_flags;
> +	bool	update_util_set;
> +	u64	last_update;
> +	u64	last_io_update;
> +	u32	cppc_boost_min;
> +	u64	cppc_cap1_cached;
> +	struct	update_util_data update_util;
> +	struct	amd_aperf_mperf sample;
> +};
> +
> +/**
> + * struct amd_pstate_params - global parameters for the performance control
> + * @ cppc_boost_disabled wheher the core performance boost disabled
> + */
> +struct amd_pstate_params {
> +	bool cppc_boost_disabled;
>   };
>   
>   #endif /* _LINUX_AMD_PSTATE_H */

