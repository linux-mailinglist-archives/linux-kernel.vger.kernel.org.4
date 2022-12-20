Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037B651949
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLTDJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLTDJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:09:11 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AD1018;
        Mon, 19 Dec 2022 19:09:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P31AImkmnMWJM4snfUbAwbqxAKc0ZRS6gS0HWF6CIvIRW4d5VwAFEGEQvXQk3zn6T3ZV9MgDmaGFQw+xD64/AdGh234ub5TBh3R/ehLGOZlwVpt6ZsgkuNAF31FLIP9hbYihk8eajSPyf/idQmmpq8bAC5R+TW54Li27KM5y0G0TnBCVdBnUqWW1TOSHU6Bs5cYPnzPwjQGJsBH7QLwEjTM7aVZXln/WwYM1Rh/ckZZAT8w9GO/UN9Ij/DgNyTZUMixdpZx3bM4d3kKQvJOj6PBY+aIeopOek4tew5ftB4F+8lgAB4Z9a2aFChR3bpBXaB3vNm/bDyJ5mjTiCAScDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zDl+HZ0siCp+m+VrY5qrNYbN5Yh8UDHV9gJnHTQa5w=;
 b=eUXiqo72sMkUeCTpRumvGqKg21+iQTx9awz0siDRtj2hQRgI9l7brfem1oepAcX1uiJcN301rsuoapd/RjlTWebTE1lmilmIzs93JVBidRAWZ4Qd25nhyEKfepMJu0dDw0GST6gWFEHMMmpZQ/iI44NdKzhlHwMlNccNE35wj8Bg9R3H0pwdCzZ4V7PG0mIrTP/JRdiqCPgR0dRPB5y85uhLowkcO77K6eruudlnoGjLN6ZHer9Hss36g4Xx+MJl/NarjlpK9wLz9G86mb3IimHM43EZOosxfmDDlEWss3WRxeDJ+95Q9ZEpi393uAa7grIWmCDtu9g8lUTaj6FjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zDl+HZ0siCp+m+VrY5qrNYbN5Yh8UDHV9gJnHTQa5w=;
 b=PhIO0ooWb9JpQiUZiC5F8opVzNscOfQJzqGdzDDxNq6397JmQ2CQrYIBB5ZcXErllX9hKXMtPa1K7cjxE/9aP1Z1CFFdusBsHu1/m/D6HuaswIzRNaqbUU55yAO0bMq44W14Kz9tUL89B7vT/1ZDCpAcAfPFwNblOxV4o2QuEkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:09:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:09:06 +0000
Message-ID: <99090f35-ea14-243d-b266-ae07ae118155@amd.com>
Date:   Mon, 19 Dec 2022 21:09:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-7-perry.yuan@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-7-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e883369-4d11-497e-9660-08dae2378e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7nT9+6d74xSCMt0uXZDd/rd6VcvmKOQ9kCi7r5CiTVvHLL6gf6o3qW9zRnZD3ZM4iJin8X2io7z6Qyr/uXrERyTQpLYHkHzcWKZ7XKiMz7Gp0/WUb9zwwJH70BKRj8MiDMhfljA+2cQJ/A/xwVrtCA3AEuzEgCBib2AFDHgbi8UTdLy2OsmXt5YlOo0MPpcUi9GZ5v3r1839GCYnAzOqFNKqFEmnB8kPg5LQUxOsb+M9UEDOfkL3zpYviGI2q6R+yDM3MopHtv2hc3O64Dpfs60gC9OWmrNuizOA0jmgZdROnXU7UaY7Wv3Xbsx2DWhqsyhLd0v5oRthuOS1spevcthz87RbnoMP6aANWsRQ7HW4VFnCQbsG0WI2AaensQImAfjQyk2k2c/vb7id+h92rKU6Gpvxys3tLjuP8N00JVPMK2vCnmtSdgL40JnSLCDD/Npqos0zY7QMq+fOyh2QL77UHmk7i7Ezy4u4GFteEXv5Nq0zsqIujnqZJtlftCUPDVtoQ99diyJWCF0ApiIPvamCiQvIsRQm30pQtrR3lRquF7sWFsWwD3X9qvEXc4sBTXQ40RMqtZJJVdO8V8SY28+/1mTN/DtPkwbSgAGtk0/ybbEOtI/+56Dth20MWSYpyma8JaX9xmoDhlKPEFiy/fofj87oShjZ1GIhgo6XMWrUJ6pNgpPKmcFHgQpuBd4C8CrW6IJjYx2p+5UPkINwIXhEggbg49RGegzLw5Ax4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(66556008)(66476007)(31696002)(66946007)(86362001)(4326008)(8676002)(316002)(5660300002)(36756003)(8936002)(41300700001)(53546011)(2616005)(6666004)(6506007)(6512007)(186003)(83380400001)(38100700002)(6486002)(478600001)(44832011)(2906002)(31686004)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtWT3ByWUxEN3hZSG9IYStMdER1LzM3SXpkN2VvTVJadHoyN3BsNnplNHBO?=
 =?utf-8?B?bXJNaVQ2Q0V4RS84UTJCS2JMU29rWWtIYmMyTDVCTVZNbWI3Y2wvUW13MWxQ?=
 =?utf-8?B?MHYxRGI1VjVqUkxpN2Fjd0diVDIrR1hYMDNMSUIrQmtNY0pUK1NkVnR4S2hB?=
 =?utf-8?B?dXAvUU1IWXcyc2kwaXM4QVFNaDdJSXNlTzJ4NFhzd3Ixczdqem5Wbm5mb01D?=
 =?utf-8?B?V0x5cyt5cWlWR2Z6NDJkUlpnQlRTZG5xMHgybm9hOExEUUpJd1RTWjEyVkY1?=
 =?utf-8?B?UmlhNXlvSCs2NTRzbUt3dEo4ZTBhRG9TTmJzMWlkOS9yMC9VdGlURFdmTW5l?=
 =?utf-8?B?MWxhTFdQZVptN1k2TnU2WmNmMEZTMTdjTEN6S01uZGw4ekV1TUM2b0NYbHdi?=
 =?utf-8?B?ZSsrMXRGRml5NXQ3aUhQU1dnQmltdHUraFVKcHd5SUxuU09TV3ZmSm4zb2F6?=
 =?utf-8?B?cWh2VWwzNlZsUmR4QzNleUxMbVdxSitNL3dySU5WOE1Ed21DRUZUcDZnNzZy?=
 =?utf-8?B?aHBwY252dzVXQWZyVXRqbGRsZEpHdUZ2b05BUFk4TFpYd1lLd1F3ZWFyUlZX?=
 =?utf-8?B?cWNtTFJQYTlYb3IzZlUzaGt0SVg0NEFVL0RpbnRabE9BY2gwb2VJeVBoUWxW?=
 =?utf-8?B?WS9uUXJwVEhpbkxBZFQyZnU1Tnlpc2JuZjlyR2NkbVNnd1NVY01xU1dkM2NG?=
 =?utf-8?B?U29WQ28yVDdPNkl0RHJ1ck9uemlYdmxsZ01NeXhFOGVXQVZMbEpJSTJtQ3l3?=
 =?utf-8?B?aDlsRFg1Tk03VU5WQ0dVMWU1SWFmZ3dQZlh6aDlGTit4b2V5Q0U3ZjdxYVFP?=
 =?utf-8?B?OVg2d2NaN2RjRS95T0ROMWkyYTZDaVo0czNNTVFGZTcvdHlvUGtQZ0svU2dU?=
 =?utf-8?B?cmtXdmFmR1ptVW9PTGdicUQrQnp0VUlxL3EwUWYvVkRDNXFUT3loWERhZm80?=
 =?utf-8?B?RjVOaVpYa3B5d3JhT2ZXNmh6aG5rdk9OMlQwalJPWGtHK0E5c3d5b2dkR3Ro?=
 =?utf-8?B?NXNlQWRkdmN2cVR4YzV1bkNTRW8yeEtUQytpb2Y0bkVLS1llUzRWQkJienhw?=
 =?utf-8?B?cE1zd2hGb1VvVlNDYXpCdHhsUVBDS1RwVEZLQzRBVE1kekE4SHV0ajB1dEVq?=
 =?utf-8?B?OXZvTEJkTmFxQk14TXdtNkhiOEE2ZGh4NVVVUHN5OWNnTzBFWlVvUVdMSDhq?=
 =?utf-8?B?ZjZvWWg1Q1Q0VVdWUjhyWDZWekxtQ0RHb2RnTVFQUUEzYmJVQU44OElZZUdB?=
 =?utf-8?B?QjR2VFVYOWw4SkoydzhvRHAwdEVmVFNzQWlpWTR6YjB6UDZHaXVLQi95aVFU?=
 =?utf-8?B?MmJWRjNXYTR0WEMrN0dWb0JGbVEvOEUrOUErWnlwaGNLU0QycHVvZXFJaGU4?=
 =?utf-8?B?a1BVZkJ1ZWQ5dEVXU2s1bE51d0UzNG00cnFYRWwvWVBUL1lLWXJlQlgzdThN?=
 =?utf-8?B?WVQ3SUFpUmdMdDU1alVSck9TZnBNZFdtbFJac1FNb2hLWk9KQ3hweVd2T2V0?=
 =?utf-8?B?dDU0R1NqZEtGWjFGWDRHbVc3d2txUytnTWZpSElsdjB1Q1krMUVLbW9NTU9Q?=
 =?utf-8?B?MnN3OWNXY2NZY2wyb0J5bUpCUmRpeFFZYjRiei9MNVdpUUJrckI1aklPSzIr?=
 =?utf-8?B?YjJJM3JadFRxb1g4UjByU0ZaTFUvSlJMM1hlWTJUN1FSeDhXUmExcksvNHRv?=
 =?utf-8?B?Z091RUxYbUMvSWdvM1JVb2RYdjcwRm9pRVFEOFFPNERza01DUDJCM1p3aW14?=
 =?utf-8?B?QUduTFJvVmphSXZHMHMrUlljZnpJaC9aWHRqSEVCd0phanl5U0dRMis1bDlW?=
 =?utf-8?B?YTVPcGtQR0x0T2o1enNZU1QxeDJzclV0QXRvY0p5dUg2N1huVWVpbVdIQ1VS?=
 =?utf-8?B?cERGdzd1S3gwQTF0SWYzeVZVOU92Z1NvTlp3QnZrOEpnTTlqSnorU2pWcVZl?=
 =?utf-8?B?M1hYaGdKWUEySlI5L3plS202UmxZVWxwZi9NVTlIZndNOEdvVXZIZTVMWXc3?=
 =?utf-8?B?NXFFOGtMM1hVZFhQWHBQamwvSDRPZC9ISHlmTVNWWGd6c092NUtYMHY1dXhZ?=
 =?utf-8?B?UU15dHlqZ2lva3dPRjBmTHc5OUZEazRmSXhBcGZsUG14M0VvSmlrY2FSTEF2?=
 =?utf-8?B?eVBBY3BkWkpKTzdRMjVSWVQ1R3JvMHkzcXJIOUdqeHFlZFh1RGZmTDJVRExN?=
 =?utf-8?Q?PKe6aTbp++p9/Dv03UDn3bfJl1QlI9LzICCyl2nF2YSm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e883369-4d11-497e-9660-08dae2378e34
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:09:06.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuYCwe1zBLohcOYHH1PG6GudzCdI7pQI3k+p66bVng1QzerbBdW22DioEyh4p7OgllhiSwIi9JASLbQNX5wXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 00:40, Perry Yuan wrote:
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
>   drivers/cpufreq/amd-pstate.c | 447 ++++++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h   |  10 +
>   2 files changed, 451 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 861a905f9324..66b39457a312 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,7 +59,10 @@
>    * we disable it by default to go acpi-cpufreq on these processors and add a
>    * module parameter to be able to enable it manually for debugging.
>    */
> +static struct cpufreq_driver *default_pstate_driver;
>   static struct cpufreq_driver amd_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct amd_cpudata **all_cpu_data;
>   static int cppc_state = AMD_PSTATE_DISABLE;
>   
>   static inline int get_mode_idx_from_str(const char *str, size_t size)
> @@ -70,9 +73,128 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>   		if (!strncmp(str, amd_pstate_mode_string[i], size))
>   			return i;
>   	}
> +

Unrelated whitespace change.

>   	return -EINVAL;
>   }
>   
> +/**
> + * struct amd_pstate_params - global parameters for the performance control
> + * @ cppc_boost_disabled wheher the core performance boost disabled
> + */
> +struct amd_pstate_params {
> +	bool cppc_boost_disabled;
> +};
> +
> +static struct amd_pstate_params global_params;
> +
> +static DEFINE_MUTEX(amd_pstate_limits_lock);
> +static DEFINE_MUTEX(amd_pstate_driver_lock);
> +
> +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
> +{
> +	u64 epp;
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
> +		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
> +		if (ret < 0) {
> +			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return (s16)(epp & 0xff); > +}
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

Extra tab here

> +	}
> +
> +	return index;
> +}
> +
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
> +		return -EINVAL > +	}
> +
> +	if (epp == -EINVAL)
> +		epp = epp_values[pref_index];

Didn't you just hardcode epp to -EINVAL at the beginning of function?

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
> +
>   static inline int pstate_enable(bool enable)
>   {
>   	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> @@ -81,11 +203,21 @@ static inline int pstate_enable(bool enable)
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
> +		if (cppc_state == AMD_PSTATE_ACTIVE) {
> +			/* Set desired perf as zero to allow EPP firmware control */
> +			perf_ctrls.desired_perf = 0;
> +			ret = cppc_set_perf(cpu, &perf_ctrls);
> +			if (ret)
> +				return ret;
> +		}
>   	}
>   
>   	return ret;
> @@ -429,7 +561,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
>   		return;
>   
>   	cpudata->boost_supported = true;
> -	amd_pstate_driver.boost_enabled = true;
> +	default_pstate_driver->boost_enabled = true;
>   }
>   
>   static void amd_perf_ctl_reset(unsigned int cpu)
> @@ -603,10 +735,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>   	return sprintf(&buf[0], "%u\n", perf);
>   }
>   
> +static ssize_t show_energy_performance_available_preferences(
> +				struct cpufreq_policy *policy, char *buf)
> +{
> +	int i = 0;
> +	int offset = 0;
> +
> +	while (energy_perf_strings[i] != NULL)
> +		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
> +
> +	sysfs_emit_at(buf, offset, "\n");
> +
> +	return offset;
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
> +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
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
> @@ -615,6 +798,235 @@ static struct freq_attr *amd_pstate_attr[] = {
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
> +	}
> +
> +	cpudata->epp_policy = 0;
> +	pr_debug("controlling: cpu %d\n", cpunum);
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
> +	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
> +
> +	policy->min = policy->cpuinfo.min_freq;
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	/*
> +	 * Set the policy to powersave to provide a valid fallback value in case
> +	 * the default cpufreq governor is neither powersave nor performance.
> +	 */
> +	policy->policy = CPUFREQ_POLICY_POWERSAVE;
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		policy->fast_switch_possible = true;
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
> +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d exiting\n", policy->cpu);
> +	policy->fast_switch_possible = false;
> +	return 0;
> +}
> +
> +static void amd_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
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
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct amd_cpudata *cpudata = all_cpu_data[cpu];
> +	u32 max_perf, min_perf;
> +	u64 value;
> +	s16 epp;
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
> +		if (epp < 0)
> +			goto skip_epp;
> +		/* force the epp value to be zero for performance policy */
> +		epp = 0;
> +	} else {
> +		/* Get BIOS pre-defined epp value */
> +		epp = amd_pstate_get_epp(cpudata, value);
> +		if (epp)
> +			goto skip_epp;
> +	}
> +	/* Set initial EPP value */
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		value &= ~GENMASK_ULL(31, 24);
> +		value |= (u64)epp << 24;
> +	}
> +
> +skip_epp:
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +	amd_pstate_set_epp(cpudata, epp);
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
> +	amd_pstate_epp_init(policy->cpu);
> +
> +	return 0;
> +}
> +
> +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
> +{
> +	cpufreq_verify_within_cpu_limits(policy);
> +	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
> +	return 0;
> +}
> +
>   static struct cpufreq_driver amd_pstate_driver = {
>   	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>   	.verify		= amd_pstate_verify,
> @@ -628,8 +1040,20 @@ static struct cpufreq_driver amd_pstate_driver = {
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
> @@ -656,7 +1080,8 @@ static int __init amd_pstate_init(void)
>   	/* capability check */
>   	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>   		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>   	} else {
>   		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>   		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -664,17 +1089,21 @@ static int __init amd_pstate_init(void)
>   		static_call_update(amd_pstate_update_perf, cppc_update_perf);
>   	}
>   
> +	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> +	if (!cpudata)
> +		return -ENOMEM;
> +	WRITE_ONCE(all_cpu_data, cpudata);
> +
>   	/* enable amd pstate feature */
>   	ret = amd_pstate_enable(true);
>   	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>   
>   	return ret;
>   }
> @@ -696,6 +1125,12 @@ static int __init amd_pstate_param(char *str)
>   		if (cppc_state == AMD_PSTATE_DISABLE)
>   			pr_info("driver is explicitly disabled\n");
>   
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			default_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			default_pstate_driver = &amd_pstate_driver;
> +
>   		return 0;
>   	}
>   
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 922d05a13902..fe1aef743c09 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>    * @prev: Last Aperf/Mperf/tsc count value read from register
>    * @freq: current cpu frequency value
>    * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>   
>   	u64	freq;
>   	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>   };
>   
>   /**

