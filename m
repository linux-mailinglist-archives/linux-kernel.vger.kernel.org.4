Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9761FDCC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKGSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiKGSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:44:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047E1D33E;
        Mon,  7 Nov 2022 10:44:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTdTotPm175v6SFejzbLXfMoJMKtVgn4MUO/bq01rE98ofLkd7di8IS6ZapkPzuojGEZ8zSO1cvXTu1x8UzfjuLxgCRLe0moyl4n0ZVidiP00ZVWNauxsOPPcqLFwGCpLZtddyg4IeMR46MGSdgzEzKh21U4XCDyIPCmv+MCpposg9agckGa5DQTU4Jsma4qChnRKvTdCezwohgf1CdJfVFAGFccHWJZtQiQhPZHmDeHVR6sSJ7JnUpYJLAfjxRqoSy/SX5GKozp3apmfSWmHjerlkChhyc5J7+klVbmmzFaUTN7IH74RA1G4dCih5vWgpVw2Fl8gkUCbVf++5pCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUw8KiQ48s1vAnUqa80H8O6rDawGe+pPao9eCruWoNE=;
 b=aMIfTqUIiCte+gRnlm9wG6hfwGzeuCWN+ejBlYjtYIkP1IP6VNki8eTwKCA3nNvdLTZ0PTrJTrDq+FWkFIweR9CW2CJtfM9S0iMDP7H+OedNOkiD7+vVufAK70vSyGUNSWqICocmT6TkZzfPc2k/B+YYf/r8wMLyJ47kbAx/PERPCjYD5n+ZY4ksZQevWAhcGo1Al/YM51YiadG3Y3usymuwc4pr2t1+BIK+fUydPYWRXgQ4/joIHeujT/nJ3seNE/4RL3pCd+l5Mnjg/C+4PpH4Q+EDseqTci5KrwuJtBnzOxVupDvf0kyn44nyCB0apANh+E116Ow91pApgnPsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUw8KiQ48s1vAnUqa80H8O6rDawGe+pPao9eCruWoNE=;
 b=xLrk2zdpkG5r6R9vhxQ2FKlUlBgMXzCgCZNHISnCM7eMpxoO5aXUae6qljnyucbPGdzAfQ0UbQqHl49YNYbduL4zP+py2nEQSUAj9P2bCZ4eKH5YmN+C3BBNC9ZcqZfxvXowUV0szcteTN1lnMEWJ6pZJnsLijObAXLgdTHrETc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4590.namprd12.prod.outlook.com (2603:10b6:806:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 18:44:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:44:38 +0000
Message-ID: <64836554-7caa-9a3e-3832-a66e87c83bf9@amd.com>
Date:   Mon, 7 Nov 2022 12:44:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-2-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-2-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef840ee-4887-4d1b-d351-08dac0f01f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGtBM/IxQjXW9nE86OwJyPv5pC1q4Ki4Nv34XKUejkejFYA7cnfnKEUo1+WKr+uLESe0Pd4oziRhW+DDkEl7FnCLTKefMm1pGQvGs8UoSklzvI2ajbo0RKBfc5sDdmEVamsIHi5XxRMthsY00FttHr3cQPcSSB1i2uYXqsC4kARh1v4RgQ532iOXPdyL2mOk/MqMGuOzajzp7unq1xC91RqJVku0wbo4POqi47LRmvKzmhOBVL+Zh7MiygGua71RYJvtwq9OMHAs6aPdDdGASK4Y8RWwdaMiLZWfM9/65ieErMwLvWCu37G4Q8IQPF0VlOLxJgjy+LK9WZlkVVjuM7jjPrSIfsVTJzFfZIMMq9PXvVTwBao1lLnWSo8sB+htxJE3lXRF1bP/dYwXkQ+ReEkc6o2L6HxoxMcW5/SCarRNriuB4fUAR2aIYVeYJx8Y/dLuZQaQgZwLyzvKoYtGiVJSKB09bQWpDnDiFcFi0N47rLItf0D1cbfneuvn/CKlpII74KxF5bxkBCfELgMWhgP3/xcw3fpfoO2zi91hfE/QMftAr606+d0uOrIgxIZ3Eg+4vRdbDTu1JxpDk0t89efYnO2w7Rqs8oTAQS7mfhcheXrbl8xTtLzC6hSs4bq54a9bW4bdQabZ0J4PxpF9VnXxmkSOn6Yl++ZYy7MbTlgbvWHV0k3rFfGe6zWG+B9c1oQp28D0MYhY6gx/uBY1n30ncPT6rTEbpX2Mdz2J6ou2JzxZpOGlIpzxsd00a71TF89ij4e0HhRLoJFlkDWMrOvufOEa6QoMEFN2B04+SNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(53546011)(6512007)(2616005)(26005)(6666004)(186003)(6506007)(83380400001)(2906002)(478600001)(6486002)(41300700001)(5660300002)(38100700002)(8936002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGlieWpoNlRJMHVMVlhLamd5MFNiVlMrRVdaWGtKa2JXY2ZNZk1LMGdCbTJi?=
 =?utf-8?B?WmhPcStQSTlxMktZNEpHQ2E4RndsNVdVRmVJd09qbXdZbVF6Y3JLeHJIdmVF?=
 =?utf-8?B?UDMxMlpjV0Fpd1FNY3pDNG1aUjdFSlRJL3NvYkIwV0Q0MmU5OWtCVHdBbEVQ?=
 =?utf-8?B?Z0I1YVRPa0FhNGNFdXZqM1k3dGZxcTJvU1ZjUTY4bGNZVnhlR2pLbCtPSy9N?=
 =?utf-8?B?VWhqeVFQUGF3Y3M3Wk1qYiszOE1zUVFVU0tCdkZiZVZUc1hnOVhXRFdkL0Rp?=
 =?utf-8?B?UFNsUHluQ1ZYaWRVSjkweFJoR2JVQ2FaRnBpbDJ5dmV3L3VjejFJZzNkTGRv?=
 =?utf-8?B?czE0ZnRiNmdBSWkyRmJ0dnBHQk43T1F0SHJ0NWJKQ2p4ellPdkE0dkZ6djFk?=
 =?utf-8?B?R0wwaFBldHNGK281NTZzdGYwTWdZUWN3L0JQM1ZVRzNwVmF1QW1JNXRzYmxa?=
 =?utf-8?B?WkRPSk9hTTNrM24wQXV5ZXl6NGRyQ3NXMmZad2E1Tk9ZM0VtVU9nTzNsZ2pW?=
 =?utf-8?B?ejdmWnhWUTVlZEEzS0x6QXlIQml4OEozMjhaTlNFbW1xdlpYaS83M2hkK1Ro?=
 =?utf-8?B?amtYcjUrS001VDhCYWhtTS84WW0wVEpEZVBiKzlpcFpjWldHd0wxa1dxSzFG?=
 =?utf-8?B?OUVmaTBIZkZsYng3VUhtWTU3R2gvN01SUlBtak5DOFFsSGlybkYyR0tQOWVY?=
 =?utf-8?B?TXJOaXdNRHZydW9pZ1pNaHVsdUx6bnZjNTgyR1BnQkpqV3QvOWNjREdsOC8z?=
 =?utf-8?B?TkltVUVlc2YxTjYvVzZTRVNFSnJkNXp2MkU5bENOSmF5eGhPSTljWHl4aGdC?=
 =?utf-8?B?T1padnM0YTZGcENJNXFjS2QvZk1LVGplTGhwa3dDQk9HQVlsbi9oS1JsZjZh?=
 =?utf-8?B?dVlWSTZEWDYrNWlDblZFNmh2Um5rVXJDcXhhOFJZcXRCNzI4N2pHWk5WcjVt?=
 =?utf-8?B?ZkhZaytXaUhyU1lNcnd2R3JRQjduZ3d3L1BzS00xZ1pYVzV1djJOVmNFaVVk?=
 =?utf-8?B?eGIyVWxxM2wvUmRCMm1pcGcwRjhMTDl0djl6ZFdYWVhnMDE5VGRRcVNTVmdQ?=
 =?utf-8?B?bkZ3ejVuKzhlcWxVRVRPNHhFTHFNaDNvSkNQVzR1aUV4ZWw4eEZRN2Vjb3hs?=
 =?utf-8?B?VzdtZk1UaXN5MGRFTTJHdzlnTUVyS0FUQVQ1eE5zQko5M0lXNk1DbWt4MEFS?=
 =?utf-8?B?UGxmZm1LaFpOTzFLYlFaa2RCQTAyZHFFSVA2R1drNlNuQzJ4MTRSV29LaEEz?=
 =?utf-8?B?aTRpZHBMVHlEOGYvdlkzUG5kcndBVjVmWnROMWVNTWFwenZCblkyNFN3UEl1?=
 =?utf-8?B?d0kybklxMmpQN2ZESE5jMzVQNHdGK1NMcEN1NnBuRUYxQmFmd3RhVUFuSmlK?=
 =?utf-8?B?bERqcG5qOWwxMGNMb1VCSlBMTEFZSzByRFFFN1kvV0ZxUW1WMDl3c0NYR1Zs?=
 =?utf-8?B?d3ZrZkZ6aWRiS2JjR3hsVGVIdTQvMnJlVGxZckRHZXdlQkxTbEhvK1lPajh2?=
 =?utf-8?B?RHRpZkttVWdGK2MxUWROaTBqRUxRZGIxYWZyOStHemUxbXdXcFhCYXVLTmoy?=
 =?utf-8?B?L3JtQWo2cXhkclZBWkVGYlJWeGRCNzF0V2dIM001cnlOdmhsMGlNVGk4Nmtl?=
 =?utf-8?B?UXNrWHBiQmhDZDVxTTRFREp4UzJTYWhud2l4V0RUOU5Mb3AwWDAxVFBLbkJ2?=
 =?utf-8?B?OTNHZEJoZWV6dkE5QlpaQ3NZb3ppMDlIV0N5cDdBalBIVWVQeUVuV0NvWHRH?=
 =?utf-8?B?aS9zRThqcXp5WHFHbExtOGsrSjNaclZidi95ZlJNdTNlZEZESm5SWVhnNEht?=
 =?utf-8?B?Y2lMcVgzdUQwQUJIWTlXNHpQNHZtL1I2RVdVZGxWQjdrVUZyT1BKU0JaQVJy?=
 =?utf-8?B?cFRNekx5cnFNNkxlK0R2OUw0ZTBhYjQ3TnBxN2gvTU9qa0JEdjdIcGJCU1dv?=
 =?utf-8?B?TEdDVVI5TnlKNGNGaXM1LzB4Y2xIL25PcFhwSE5iTUo0UFB0TmFLUEtUaDFP?=
 =?utf-8?B?RkZrSEVONkJVeW1BNmg2QUdyOXpjV0ljY3A0M2lTMlZ3NDFOZjRaVXk3WnRw?=
 =?utf-8?B?QytFa0U5MXV6SlA0VmZlMFZOc3ZpdnpPbHhKbFpqcW0rcVJqUWVsRXhwRXkw?=
 =?utf-8?Q?sUwifKlvb+1obuDUVavxt79jb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef840ee-4887-4d1b-d351-08dac0f01f78
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:44:38.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VkZZnzONdtRccNrJmf8zfOnUxQx8GiMehCst6GJWbQsqZEn4QUJ0CB3ThpfTYwIEZHWMW7TX56wNGBi8yaKBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 11:56, Perry Yuan wrote:
> Add the EPP(Energy Performance Preference) support for the
> AMD SoCs without the dedicated CPPC MSR, those SoCs need to add this
> cppc acpi functions to update EPP values and desired perf value.

As far as I can tell this is generic code.  Although the reason you're 
submitting it is for enabling AMD SoCs, the commit message should be 
worded as such.

> 
> In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
> value and cppc_set_epp_perf() will set EPP new value.
> Before the EPP works, pstate driver will use cppc_set_auto_epp() to
> enable EPP function from firmware firstly.

This could more succinctly say:

"Add support for setting and querying EPP preferences to the generic 
CPPC driver.  This enables downstream drivers such as amd-pstate to discover
and use these values."

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/acpi/cppc_acpi.c | 126 +++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h |  17 ++++++
>   2 files changed, 143 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..d9c38dee1f48 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1365,6 +1365,132 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (!CPC_SUPPORTED(energy_perf_reg))
> +		pr_warn("energy perf reg update is unsupported!\n");

No need to add a explanation point at the end.

As this is a per-CPU message I wonder if this would be better as 
pr_warn_once()?  Othewrise some systems with large numbers of cores 
might potentially show this message quite a few times.

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
> +int cppc_set_auto_epp(int cpu, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpu);

Is this actually warn worthy?  I would think it's fine a debug like we 
have for the other _CPC missing messages.

> +		return -EINVAL;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0)
> +			return -ENODEV;
> +
> +		ret = cpc_write(cpu, auto_sel_reg, enable);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +		return ret;
> +	}
> +
> +	return cpc_write(cpu, auto_sel_reg, enable);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_epp);
> +
> +/*
> + * Set Energy Performance Preference Register value through
> + * Performance Controls Interface
> + */
> +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *epp_set_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpu);

Is this actually warn worthy?  I would think it's fine a debug like we 
have for the other _CPC missing messages.

> +		return -EINVAL;
> +	}
> +
> +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (CPC_IN_PCC(epp_set_reg)) {
> +		if (pcc_ss_id < 0)
> +			return -ENODEV;
> +
> +		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);

cppc_set_auto_epp and cppc_set_epp_perf have nearly the same code in the 
if block.  I wonder if it's worth having a static helper function for 
this purpose that takes "reg" and "value" as arguments?

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
> index c5614444031f..10d91aeedaca 100644
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
> @@ -149,6 +151,9 @@ extern bool cpc_ffh_supported(void);
>   extern bool cpc_supported_by_cpu(void);
>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_set_auto_epp(int cpu, bool enable);
> +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   #else /* !CONFIG_ACPI_CPPC_LIB */
>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> @@ -202,6 +207,18 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_auto_epp(int cpu, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
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

