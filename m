Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7701640B82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiLBQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiLBQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:59:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336B19C11;
        Fri,  2 Dec 2022 08:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nohO5uKqOmE0DHLHy7ifxszF2MyYGB5dKsHJ9XVAaHlxh6pSu/IY/RcBxUPuCG9ZZXgtFBIAJNHbpzs54Xom/f9p0a3akaKHuzPNYqaAz+rrbavkBDnhuOP8ST2OEN9h4JoKg0wm21nmAeH7Rckhf/MooKABLv9Dnq3Iv/FPQVVl842g9v1TpkoMamPjmeShKdBZUiTHr8g75N1doJ6koxKwL8VeoSfalo78Oyqqi2LlJeaGp2Dv+IE90wARxjviWa2ooeLLzwmM/CBLklSxT19rwVip4/+0joB7zJ4+tDi4mmh6ooKysUfyz9kPe0bgcSObFzXqgYzyza8Un1oFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMXFL0UQKHiEnT6i917PuFqe0S6K5IU5Debb9/3BR1g=;
 b=hRcR/8Q9Uikfpo4ghtNxOi7opZwLaB6C1pBg1qyfawzGhnN4eIq1DOql1g86gY9S3yzKva8z2xa64LbnbmtlE2obAYBu4LlqKbU2OC3p3qJxBG43ZeRCU1pP+x/8UloKo8blKPGCMxymh+DPncQdYit/nVa9NpJFfXFIfu7lgz9hy9u7mhgZC/I9iDFkoWntH4PlN17VdPcuPlRkdp/jrMd9J4/ei0+I3L5vjxh/oEoGyd5RCiEAoZy7Q/L0DGw1q+HeqEJyeTc4G3TLTdFL15TQ9GeJ6TM5et+lvRdOU8fgmoj3rLIMbO2s8W9Yi3Vt8aLxXejaUYIGK6ery06zNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMXFL0UQKHiEnT6i917PuFqe0S6K5IU5Debb9/3BR1g=;
 b=Q0OBVYHusDL0GbmEZ8/l4wHPAyJGAF9vDPbgeM590zrFSU4XgzHvBfgmXHDC/THyNYjVNGXAr5q2D46BmSQjEOfromQEg+T49zvQif4adzvqO56tOvndtvpvDWDDNeB5M4C73qi1Pkz1eUsyuS++CHyH5ExFwQmDD68Xw+urqUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 16:58:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 16:58:23 +0000
Message-ID: <25462433-6c0b-ac6a-888e-0c42c3e045de@amd.com>
Date:   Fri, 2 Dec 2022 10:58:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 01/11] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-2-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221202074719.623673-2-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6166812c-8ef7-460f-498f-08dad4866bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+bnKgz/YZqmPMcFJbDu0vl2hNOkoP5F70EBjpFj5YLrULWTJ02/tv+HYCJqHKomhsSoKOc6uUb7u6qTQs+XSKmfn/+NrK64mVvcMdY4BpmX5jwGmDr6fgX7aQol9Y7UKUNIIOeHelsdKBu9eeV6SLksoWKlVkLa09idUi2vtqqf94Jcb4OVyhMqK+VAyCjsU/F98ESlUNT117uNTiht2oXkcKSS3jy2HgZjpHEBzUSonDOzFfQpyfeVYiEanvzpRXCvhB4hSZzSIOBzbTUfApWvElYyjVxMNMnW7zT79ZnuMh2KEOoESMtXFm4DZXU2SpyN5jhGcHb9EeSCwCed9GfYveWcXqcL4xdpSyzt1sofbDnsMN/ht56dooZ8bb0Bx6XSWyErKjBshAnaETQDvLEve/2qGXsL85qhYDcucsarcTZYjFQExV528YKvZgU5mqgBKI5xDekduAe+Aqw9aTGrbZuhoNHxbCcJtr9krTT5bx1yMtZavRc6CtdrrxX/TcB/nTO0cl7dsMChqOGKxX9M50J3nwIzkh6ZJfXgjU6QjOgrEyw1eBDPicpXAHfT9JFGNE5OqgKzFcCsLWWRTkNk8dPSYm45PAEDFvB3e6iCSaxo1zrnmUDNlkYLXX05MSTJ+KMjB/4n9atqRaDLJMcsBK99TH32udqkt8Y7gwY67h8Wmq7R0pu08BWQl6o/YOtlYKWbejwHQmOxZUYsoqg5GIRR38HOoV+IeX7IhHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(6506007)(53546011)(6486002)(6512007)(26005)(186003)(316002)(478600001)(4326008)(66556008)(66476007)(8676002)(66946007)(31686004)(2616005)(41300700001)(8936002)(5660300002)(83380400001)(2906002)(36756003)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTY2RkNIeDJrekhSUGJHMzdOUi9iN3ZOaGF0L3A2aVhKeXA3T09rb21Ub3M3?=
 =?utf-8?B?aCtmQlZlWjdSdDhuZEZLQXVDNW9RVU0zZDQvUU90cmlPVE9URTQ1UGFiUUsy?=
 =?utf-8?B?aFgrZTBFcXRVemRKdG9CMHVuUDFzekE3TzlFaHJjc2JuY3J2K1Zxdy9IdVZu?=
 =?utf-8?B?U0t6Wnh2azdkUzA0dXcvU0FaTUZCKzFXcHpscGptUUN4MFV5MFh3N3g0QVNt?=
 =?utf-8?B?bnIvRi9qWUl2ZmNMNi9wempOcm9PbmEyYzNrTjRtQmpuNEJTTnZRYWovWjF0?=
 =?utf-8?B?UEZaVmVHR25IS0lZNXBzN3VhRTJZbTV3N25RV0pEVGdhWDd1UVl1RTRvYVBL?=
 =?utf-8?B?Rys4S0lSVnR1eXJMd1ZFTzY1VkxLb0RVUU14dDJFOTF1ZzFkanVIM3FaVjR5?=
 =?utf-8?B?bGhuRWNySThBVlFvNzM5K1ZFT1Vtc0pJdnA4ajRwOUlmZnVrajJGQ1JXTElS?=
 =?utf-8?B?aG0vUVpQNmtXd2pBejY2OWNLWDgwSndQM3lZMk5HWC95RVZWV05RYTMyVndy?=
 =?utf-8?B?aWF2WlJkOGc5c0M2SVpCdzhNbVM2c0djcFFXTDJPNExoaHUrNXl2UmloUkQ3?=
 =?utf-8?B?SUpEWm5EbUdLM2RkdklrbHIzUC9CMHlHQjhqYkxIZllwbjhFbGZIeHBkckFu?=
 =?utf-8?B?THRoVzFWWnpWM3JQN3VHNnpjdTZLaGJKZEZ3L0thNFFDQjU1N2tKZ1M5MEwz?=
 =?utf-8?B?SjdBcG9KcUdVYzVldHRQdHhBbllqbktteVBpTXNWTytFNStwQVQxdGVDbjYv?=
 =?utf-8?B?KzUzYVdtcWRXbXQwbk85WnlUNHR2ZkE4aWpISVcvR1hmY1kxK3h2RE9pd0My?=
 =?utf-8?B?a2hkbVhWT1g5QjFwWG0zMTloVkl0M21sKzR0UUlYOWVvalRoZ09SRnp3Mk44?=
 =?utf-8?B?bmhtQTZRcEhuYy9uMWZuUW56V3M2cy8wQkpBM2dlVmkyZGpMVVNjcURpK09L?=
 =?utf-8?B?bm9wSi8vOFUzY2RTYlZUNXdHMDBpNHVMZGoyTlNOZ1NoRytYaWNnY3pRb1J6?=
 =?utf-8?B?UG1lVmF5emNzQzNHam1keDZJd0krS0VyZnI4cXNwV3hqZ0VlY295WFNNUVBa?=
 =?utf-8?B?bmxWZ01kcitjSm0rb0srenV6ZFlXMmN5eUhJTE9tem5Oa3JsYlB2Z1dHL1lV?=
 =?utf-8?B?U21UcUFCQTNYRktzNXFNUGJDRzdHVThrRTBFV2QwdkNzSkVjMk5OM05tS1hl?=
 =?utf-8?B?eTFDZVhzRk10Rk9CUFBVQk9DVDVkS0lKMEgyVnpQK2pvYUpCdmt5RWYwRTJ2?=
 =?utf-8?B?Mmc3c3JJc3J5b2JORFgxdGNjaTZzbVFRWHVWR2hTTWxqQSs3TlFZRmM2cnhr?=
 =?utf-8?B?YUVXclBWY0JaTzNUSDBKaUVoSkNHTlUyYVNDYVpibkIvN1h1SFI4aFJLeDhx?=
 =?utf-8?B?aFhjZ0FmeldEWmlSdzJ5R2VpN2hDZ28xNmhYa1VjSnFqaXNXenM3QXp2S1Fa?=
 =?utf-8?B?TFpOOWoyVHB6ejlSQVJQUEt2bHFBTTNuR2FSQXNQemM1ZkhYS1FsdWhjQ2ZH?=
 =?utf-8?B?YmJwQkN3MWZFVkNTem9sZEpWbzB5YmJvSEs4cGZrSElCOTA1aTlpZDBxQW9I?=
 =?utf-8?B?cFpyYU5NaHpLUG82K0QrbW5oUlFMcjJsQUd1dmdUNHJYR1FET0owbTZObWp3?=
 =?utf-8?B?QWpLWFRIZU10T0dsSythVTE2elpHNjJqdllNZjBzcnBlT2psdUVETmVFZzB1?=
 =?utf-8?B?TDdlOGdiYVhDWVh4YWpNNUVuZ1RzRlZpS0hHWExqWlJuRXNHMGpiQTJmUXlP?=
 =?utf-8?B?aS9kUDdhSjFtOGp2aVg3Q2NLM2ovVllhNE9OUUVrQlNmRE5jYWxETisvVnJQ?=
 =?utf-8?B?Ylp2di90VXk5b0Z6OEdYNDNjMVdZUnBFTTNuM0Y5a3lOVytZM2NUQlA1dzVZ?=
 =?utf-8?B?bUUwQ0JLbVNrcEZ6bTlscHhYOVVJYTJlc05VRVVWYllob2hHRVl3WnNNK0dV?=
 =?utf-8?B?QmNFSEpsbE1hSlhTdHdLaHJYMDRhazBhdHV4ZUdzdm4xUFVkSlhZajhxOGlU?=
 =?utf-8?B?RVNOZHo5WWVDdmV5d1BJbWtuOE5FNnkzck1OTkdvODFyc2pFdW1XMWQvamRq?=
 =?utf-8?B?dWdQRWs5UXd5bWxRS2FkaHBqQU9HTXdUaEkrRHhXeXdWSndGczgwOFl4NFpt?=
 =?utf-8?Q?D8rBMPvR2MiNBuvu/llQstO3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6166812c-8ef7-460f-498f-08dad4866bfd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:58:23.0376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpF91GDFV1nJGm04bwD+GII0vwehqTZFGHMGdSgN4xS2s79uBkm8nWQMq4ZPv/zig1C1QEADmycZP0Scv+O48Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The title of this first patch should not reflect amd-pstate, it's 
generic code.

On 12/2/2022 01:47, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values
> 
> In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
> value and cppc_set_epp_perf() will set EPP new value.
> Before the EPP works, pstate driver will use cppc_set_auto_epp() to
> enable EPP function from firmware firstly.

My suggestion at rewording this:

Downstream drivers that want to use the new symbols cppc_get_epp_caps 
and cppc_set_epp_perf for querying and setting EPP preferences will need 
to call cppc_set_auto_epp to enable the EPP function first.

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 114 +++++++++++++++++++++++++++++++++++++--
>   include/acpi/cppc_acpi.h |  12 +++++
>   2 files changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..37fa75f25f62 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>   	struct cpc_register_resource *reg;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
>   
>   	if (!cpc_desc) {
>   		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1102,10 +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   	reg = &cpc_desc->cpc_regs[reg_idx];
>   
>   	if (CPC_IN_PCC(reg)) {
> -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> -		struct cppc_pcc_data *pcc_ss_data = NULL;
> -		int ret = 0;
> -
>   		if (pcc_ss_id < 0)
>   			return -EIO;
>   
> @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   
>   	cpc_read(cpunum, reg, perf);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   /**
> @@ -1365,6 +1364,111 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>   
> +/**
> + * cppc_get_epp_caps - Get the energy preference register value.
> + * @cpunum: CPU from which to get epp preference level.
> + * @perf_caps: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *energy_perf_reg;
> +	u64 energy_perf;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (!CPC_SUPPORTED(energy_perf_reg))
> +		pr_warn_once("energy perf reg update is unsupported!\n");
> +
> +	if (CPC_IN_PCC(energy_perf_reg)) {
> +		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +		struct cppc_pcc_data *pcc_ss_data = NULL;
> +		int ret = 0;
> +
> +		if (pcc_ss_id < 0)
> +			return -ENODEV;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> +			cpc_read(cpunum, energy_perf_reg, &energy_perf);
> +			perf_caps->energy_perf = energy_perf;
> +		} else {
> +			ret = -EIO;
> +		}
> +
> +		up_write(&pcc_ss_data->pcc_lock);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> +
> +/*
> + * Set Energy Performance Preference Register value through
> + * Performance Controls Interface
> + */
> +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *epp_set_reg;
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id\n");
> +			return -ENODEV;
> +		}
> +
> +		if (CPC_SUPPORTED(auto_sel_reg)) {
> +			ret = cpc_write(cpu, auto_sel_reg, enable);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (CPC_SUPPORTED(epp_set_reg)) {
> +			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +	} else {
> +		ret = -ENOTSUPP;
> +		pr_debug("_CPC in PCC is not supported\n");
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> +
>   /**
>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>    * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c5614444031f..a45bb876a19c 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -108,12 +108,14 @@ struct cppc_perf_caps {
>   	u32 lowest_nonlinear_perf;
>   	u32 lowest_freq;
>   	u32 nominal_freq;
> +	u32 energy_perf;
>   };
>   
>   struct cppc_perf_ctrls {
>   	u32 max_perf;
>   	u32 min_perf;
>   	u32 desired_perf;
> +	u32 energy_perf;
>   };
>   
>   struct cppc_perf_fb_ctrs {
> @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);
>   extern bool cpc_supported_by_cpu(void);
>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   #else /* !CONFIG_ACPI_CPPC_LIB */
>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> @@ -202,6 +206,14 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>   #endif /* !CONFIG_ACPI_CPPC_LIB */
>   
>   #endif /* _CPPC_ACPI_H*/

