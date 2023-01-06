Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457A765FF74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAFLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAFLTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:19:25 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E8625DC;
        Fri,  6 Jan 2023 03:19:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBGSudiCJZK9eKxL0tlTbh2792F1wlxjPDHzUUSbVc2qLbpPvKChZKt/MKsfGxSNH1PrEOf/GItYwS6/Q7X7wSbfxlSYGMty0Vh9AJDqmZuj5FVXCNyDAU4I7Gi9RfBeJ3x7XTqI7nr4Qs18XMQTq0242LjadndrpfuVrkVkL7s1VqTDph6TKfOlJjGjyIoif68qhJU01+6TX8BGPmUwKujTZ1Cv36CC8lxqqF7WmHHg4O/NC6YDGumhefbd13kMigW/HHHCsn99v5cOfPh1GdTk2W0PN4keyL/5L//Moh09hcws4xswooHstfxCoWzVx4BXmuk1RnFkk7NMH2J7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcuH+TQ/FIVfZQ3H9sb19u7CJxZlMZQp4vWleAgM7eg=;
 b=IGRPh7F+WF8V+UMNqmoudYieU+gD11gUydpLSw7Rvn4lkM5FYjfUqaRhNj9FLwI7bQ0RFxCNLSwlMWXK7l5ozgLPlMli1f6/iHJvxM3Kl4EwZY4H+LRw28VgK9oUlU3KIVyvaFnZulKyt4eazSiUpXFZCwG3aDIdBAvGhzTWSzyjIUDVZSMqltiXT4//QfyGIBx5cl31fr7jyFaxq6cudm3290NDURhf66YKe2LzN6Ga5T0wQ75FzM3jpxeWXnkdBcDxdalblP5JjGClDVKDWisnO70ZXugHNJ60ohMSSOSSkeMbMwwsm+JepnJBrRdz3sx6VdcLcViFZUMf1/R0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcuH+TQ/FIVfZQ3H9sb19u7CJxZlMZQp4vWleAgM7eg=;
 b=CMxZiImXVyXm9VycWZ9/iC1hXCh2OcPldBc/6vt3TF3afiqrhPNtJJxr5OWDglLjG8f1fkeRRSdACiGwvTDzHR717Wf4TcxMMBtNHoBtwnkJwnn4hVdlj8thdZJE4EvtOGpX8ceY9uK7BWII70iXlRK3EOmMQnuYbg16QYexlmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 11:19:20 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 11:19:20 +0000
Message-ID: <f0bda73a-0092-0328-6599-25046b14b550@amd.com>
Date:   Fri, 6 Jan 2023 16:49:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 05/12] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106061420.95715-1-perry.yuan@amd.com>
 <20230106061420.95715-6-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230106061420.95715-6-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 974ec5f7-95c0-4e55-1c01-08daefd7db3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lESxrkByjqivmu3vnlldjkKOE0qpUEWRPXLBQIhrzGoMzpGFkqUiJw2/2XGx0TXZlDJCGvAtTQPQylBbyAiJ2fVqGLFfJZd8o7MH13J9woWmxucA7gXWLKjk3wQTubY1B2/cSi0JxiAxM3vImU9DzqK8sSF7bfCjteLc9wDD1vuk114Zx+/CjGtgHdzIpYCJIN0A6vE+aQvYwQtWRIa35uphkAaa78JPV7nQww84HspjYWhV6+9ZJGQ0lMvj5mDYVDh6pU7TkPKi+8ZWV/+XcjW6md49VKhsjq6yZuLnWsf/4zu8VrTf6dI3ru2jXO68qYnMef7fqsbbnENR6fYEbrce2Vft0/yKEnU5A36zctB0EKXDC6v0lm2hz0e+7AEAR8FUd+brMHaRi+Q3DMksQUH9bXns/x+of8HXQcee2V+Br3g2WYhLyDJnRd58YQ7eJcS84HMspOWP6bwUygk7AR1KhwH7Uk75Zipk4QpAFfQSf1bgyV/udAAg8wWXQCYOvJ7x4Mmc/2rcORbguWsxkTh03kxHRMr+2Cl8RDNAZn2T0MMZ8qM/2f5i4wnDMMZ6AdNsIaLaJEopF5XRqz4EGtK/wm24gbQPndNP8qEx4BsiW01jVGf1iE13z6+FQM2B00F5xo130aJLCyw7Ql3B4fBgiHv5SJRj5brspvxnHJ1kfNXT2NQLWxHK8Fa3C0GNvvz9z+9fM0pq8dWR/wHLYJya30zkac53LeQYpP+5o/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(31686004)(8936002)(4326008)(41300700001)(5660300002)(66476007)(6666004)(8676002)(66556008)(66946007)(2906002)(6512007)(316002)(44832011)(6506007)(478600001)(26005)(53546011)(186003)(6486002)(86362001)(31696002)(83380400001)(2616005)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRCYW5VOVIrOU1jVEYxVTlPOXJYUDJuSHdIYmpFWkpVNnNLVDZqVWRaRXgz?=
 =?utf-8?B?V1huV2dBa0xMeHhLWlJBcjkwTzV6MWRSc2hycTlHNFRMRmxiSXV4S2FtWVk1?=
 =?utf-8?B?U3ZITitUbkkxckxIQWFCNDBRdnlQVVh0YjRSMHB2ZmtSMUNtS1pMbHZieXZt?=
 =?utf-8?B?WTlmQVZrS0tDdm5CcmJWM1R1Ynk5aDQ0RDV2TTljaVBDb01uaHlTYTJaMHUx?=
 =?utf-8?B?OWdGMDRIbmpzaXEwUjNidU0vaWpmUXVnR01pdkVXUVJZNjZoNm9YQU8vN2Uv?=
 =?utf-8?B?SnhJOFhIUHh2eDg4VWl6NHZEZ0JuTEdJeFQrZzZjNWx4M25TWmZ1TWU0d1o0?=
 =?utf-8?B?aGpRbG5QSmsxRnExVC82c3E1VHZLZXZiekhqV0V0NDBoWExFVU04MUdoTFJs?=
 =?utf-8?B?NjVBeXJZckcwNWVaNTZFbmF3VGpEUUNYSFFxRStENUZ2YkQ3MTE1eU9JemZv?=
 =?utf-8?B?M0dweUJpVno0OFQrVUVuK3MvUnVKZGhSLzNaS2k3dW4wRnRBVmhLYXJzb1Rx?=
 =?utf-8?B?MVJwallhejkraUllYmRPM0JoQ050aGhlVUMydERTTE1NN3hCRVRUSkpIc1FC?=
 =?utf-8?B?VWxmalJvYnBEWGFqNkVubFpBVnUxaXVoQTdEL1dBcTI5bS9QdXlBS3FIOEhj?=
 =?utf-8?B?OUNsbzFRUTNEV05UeWdwclo2U1hyUjlQcXhsamViOVVmVk5aMGZKOU8yQlZ5?=
 =?utf-8?B?cGk1a0FZSkJ3a2w3MnRNenZFRHFJVXVqY3BSV0g3UTY0SEVVVjV4WGpBdVFa?=
 =?utf-8?B?WTl2SzdKZkQrQTA5YXYwbHZlSFpwc1pidS9rZVFOckZnb2RsRmZyUENLVkJw?=
 =?utf-8?B?NzJLdWZTdlByY2svSFVRWUk0TEF4Q2NxWkg5QW1TTUJYTEhYanMvTWtwRFlG?=
 =?utf-8?B?VXY1NmxXSFVFZDdHVWFqY0xZSzBrbTg0SWx0cjE1TGs1OUR4N0FOVElSR3Uv?=
 =?utf-8?B?a3QzQmJybGpQQW5PdlJYaEZFOSs2R1BSRjVQcWJPNk8wdmlHWFJSVzVxbnFV?=
 =?utf-8?B?dlhvVW1QYVBRZmF1WlpBYThncGZwSVE2ZGl6VDMvTGNybm8xRlhwMThLUHp5?=
 =?utf-8?B?YmxDRldNUHhEajJmMUY2M2x6ZHZDeGR4WjMxNjBUUnhQTFhTUTJoaFU4SUdw?=
 =?utf-8?B?aEl6Yk41WG9vaWVIZGdVMVNBaVo5RXNYZzdvcVdtT3ZQZEx1VkhjcDZoREZk?=
 =?utf-8?B?WE5HOUJjL3lBUGIwSWhzTzZaN2xqN3BvOXdxbVpsSElvQXRWdVoycG1qUldX?=
 =?utf-8?B?cVU3NHZqd3pZNnlCQ2E4aUgwZDhkS0xkNE5TYTRmWW1kSVVCRThyWStoSEF5?=
 =?utf-8?B?eVN6b1FaeHB5TFJZbEhzVXdjUCtRZFNXU1BsZUZnQlRyTnRRRWc3UlkrNkg0?=
 =?utf-8?B?WllGWG5XdzY2Zm45ZDl1MDJocGdWUm1XMXJkSXhQeTVodlM3WVBWZDBRa2lj?=
 =?utf-8?B?cUJ4SEZwb09yK1hqU3RDNEJvbDMyVjMweFRSNkZoS0U3TkxRQWhqTkJCRWdX?=
 =?utf-8?B?VnloV291UWkyZjhtUTdRMFVZSkZyc1lPclVlbEZXbkJ5bXZsOGZ5Um9vTTAx?=
 =?utf-8?B?VnAyL0ZQM1A2cVk1RHF0NkU1TGNhWCtONXRCOU15bytJWmMvZG1uTGxrbE9h?=
 =?utf-8?B?aFpYT3A4Wk5LalhnSEl6K05iVGRXZUgwLzRUTXFVSDVsWWQ3S1lkYVhxS3kx?=
 =?utf-8?B?NFA5cTdjQjZlb1JsN3BITEpvT001WExGSUhSSUkxQXR6SExFcVM5WFZBWmFC?=
 =?utf-8?B?ZTQzclRmUmx0UmxWSjNHV0djK0ltSGxwQ1dpRGJhVU41VzAwQ3g4UkpRRStT?=
 =?utf-8?B?WlhxTERJY0pZTVg2T1Y4STdtRWFCSDZldEswMzRhWFFzWWRrMzQ4djMvZ1o1?=
 =?utf-8?B?T01EditwOGlFdm1jZ2lHNmhqN085RFQvbFR4b1BVeHhMQzcvcGhPUG5BWlF4?=
 =?utf-8?B?NDdyRnN5ZE55bGREZ1ZWRGVpL0lRdGxvWS9CdG01dnlrWFNjNWVnUU5pTzFS?=
 =?utf-8?B?ZjYxbnA2dG00Y3hGZHl4NFZ4dWQ0cVFLSStFbFYvRm9TSXhmOTNzYUh1SjJp?=
 =?utf-8?B?anZOcEorZVREa1d3WHFTQ2hxVWJRRnlwY2VLV0RHNVREOERsdXJuU1Vxa2Rw?=
 =?utf-8?Q?tQbLEBBXE7Wu0ve9U352E//MJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974ec5f7-95c0-4e55-1c01-08daefd7db3b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 11:19:20.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcoVS7PbX5GM98y1JXl117Y/3iVYdsliY9CNpcIf+Kg6B5+CKMxCmcP7b4zPsVgwI2XfFqnjBs02voCeiL/g8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 1/6/2023 11:44 AM, Perry Yuan wrote:
----------------------------------->8------------------------------------------
> +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> +{
> +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> +	struct amd_cpudata *cpudata;
> +	struct device *dev;
> +	int rc;
> +	u64 value;

Please call `amd_perf_ctl_reset` function here, otherwise amd_pstate would
behave unexpectedly.

> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		goto free_cpudata1;
> +
> +	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> +	if (!cpudata)
> +		return -ENOMEM;
> +
> +	cpudata->cpu = policy->cpu;
> +	cpudata->epp_policy = 0;
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
> +static void amd_pstate_epp_init(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
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
> +	cpufreq_cpu_put(policy);
> +}
> +
> +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!policy->cpuinfo.max_freq)
> +		return -ENODEV;
> +
> +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> +				policy->cpuinfo.max_freq, policy->max);
> +
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
>  static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
> @@ -627,6 +973,16 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.attr		= amd_pstate_attr,
>  };
>  
> +static struct cpufreq_driver amd_pstate_epp_driver = {
> +	.flags		= CPUFREQ_CONST_LOOPS,
> +	.verify		= amd_pstate_epp_verify_policy,
> +	.setpolicy	= amd_pstate_epp_set_policy,
> +	.init		= amd_pstate_epp_cpu_init,
> +	.exit		= amd_pstate_epp_cpu_exit,
> +	.name		= "amd_pstate_epp",
> +	.attr		= amd_pstate_epp_attr,
> +};
> +
>  static int __init amd_pstate_init(void)
>  {
>  	int ret;
> @@ -655,7 +1011,8 @@ static int __init amd_pstate_init(void)
>  	/* capability check */
>  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>  		pr_debug("AMD CPPC MSR based functionality is supported\n");
> -		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
>  	} else {
>  		pr_debug("AMD CPPC shared memory based functionality is supported\n");
>  		static_call_update(amd_pstate_enable, cppc_enable);
> @@ -666,14 +1023,13 @@ static int __init amd_pstate_init(void)
>  	/* enable amd pstate feature */
>  	ret = amd_pstate_enable(true);
>  	if (ret) {
> -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> +		pr_err("failed to enable with return %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = cpufreq_register_driver(&amd_pstate_driver);
> +	ret = cpufreq_register_driver(current_pstate_driver);
>  	if (ret)
> -		pr_err("failed to register amd_pstate_driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register with return %d\n", ret);
>  
>  	return ret;
>  }
> @@ -695,6 +1051,12 @@ static int __init amd_pstate_param(char *str)
>  		if (cppc_state == AMD_PSTATE_DISABLE)
>  			pr_info("driver is explicitly disabled\n");
>  
> +		if (cppc_state == AMD_PSTATE_ACTIVE)
> +			current_pstate_driver = &amd_pstate_epp_driver;
> +
> +		if (cppc_state == AMD_PSTATE_PASSIVE)
> +			current_pstate_driver = &amd_pstate_driver;
> +
>  		return 0;
>  	}
>  
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index dae2ce0f6735..8341a2a2948a 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
>   * @prev: Last Aperf/Mperf/tsc count value read from register
>   * @freq: current cpu frequency value
>   * @boost_supported: check whether the Processor or SBIOS supports boost mode
> + * @epp_policy: Last saved policy used to set energy-performance preference
> + * @epp_cached: Cached CPPC energy-performance preference value
> + * @policy: Cpufreq policy value
> + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
>   *
>   * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>   * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -72,6 +76,12 @@ struct amd_cpudata {
>  
>  	u64	freq;
>  	bool	boost_supported;
> +
> +	/* EPP feature related attributes*/
> +	s16	epp_policy;
> +	s16	epp_cached;
> +	u32	policy;
> +	u64	cppc_cap1_cached;
>  };
>  
>  /*

-- 
Thanks & Regards,
Wyes
