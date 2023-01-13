Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DD668BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjAMFzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjAMFya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:54:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E36B181;
        Thu, 12 Jan 2023 21:52:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csVfrluJL23QP3f09FDNfCFSZBY7kdie6p8i8t9eyJLvGoLVfkmtHPziK0Mgdp0yNMUXz9AduZYtXLQ0jUnoXiIAucLsQhCld3doUfs9YQhs5tcyLzBKVMgAiwkNualnL+xCKdSsZGppiJ0Q10qTRv7QocswKIBUgO5+DR9kD4zpClXmeXdJd4+7ygAUUuClexTqdBdYK1zhImwoe9Xzr4YIqo/6aiKYu93yNkhHM4EmjS4QP/pSDqmpuy+Qr+uj+QScfoihP9K+D0nBD2+ZdQe8oAhb1P90imtaAC/gsTNkcHcKm1DdDNN+tAOZ1Kl2pS0d0TvTIEa9YVxUQTid5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0/v4AysFSr/OjdaPw9pNOT8ZNVoIj1CBnrlLZafTgo=;
 b=kdaVTMCjZbXg+9Un5obqcxlpcKnvm+moHr58m0vF0AnTn4cdH7wxenLtzp1OcPJc0Texm8BVMBwbPZ2lETTEeVuZP+Kr1jFWqf0kcRzdZo3ZT+j4oZM/peltoR9RdqZy2IlLLrt9P1HFbXQSMYuKjuwTPrIQNMsSqxCUlFX+8EAsLgi1fLAHWmSRluK9fsqn6C4bW7mn61q2KmoZ1eM6kW/TFGVoB+vl6ioQvDgF3Wc3C15hMfqXvwz+VcsngyNyyvtv72rD0/VkZTPa3JGhVG02xSvWJNgoK6x6CBF8OM4xDtXcg5Ew7Sc/uN+0JwTv2PORY7gQ+53ue2xsPavJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0/v4AysFSr/OjdaPw9pNOT8ZNVoIj1CBnrlLZafTgo=;
 b=E2tSjAdtvesXoYl3RvaOJV787cbZ62ef0o1MQGLwHkaVf5DDAdkIkan7PPGfbjHGnPEfWKTR9TMo9DUggRPusZyyE2jJvdmASrI6WuhJhx24GC/sXke/Wy5tFx5IM3kERrtD/lmMCxENS4gcwqOloyKXlU99U2v/IDiLFuR0rXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 05:52:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 05:52:30 +0000
Message-ID: <d6d5be36-78fb-e193-fda9-fbc6bee1ebb5@amd.com>
Date:   Thu, 12 Jan 2023 23:52:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/6] acpi: cppc: Add auto select register read/write
 support
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-3-wyes.karny@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230113052141.2874296-3-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:4:ad::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b0f30b-58ab-457a-f4f5-08daf52a5b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2o82AiqEaUBiTdPEfVSsxrLsS4HRymfd4T+8jmBzHmTcRB/+/fS2AerHdKkLyNL11MEgLUpjbv/x5R3LrfrYERjejZhHHYx0Sv27CPohDxdq5ScG071ActnvKrOw33EgSIHftCpI/nRX+A/ZC80ZvAPmcM839ziRqWjBUWN4Dfuw6QXG85U9EPXz5wgoJnH5XUUeIjzWtIDewY3UqhRBz3ImlkQMmZvqal6s48/Sw1juIirqtSH8wz0UdSrJHdMWpz90Ivp6BAx8/kE0XlxeYfwiDrP8gwlqIgP9E20aCixrnTEyt9PKhbtqCxym2ftnka4XL3IG6BtVWYvODrlLVh/5VHUaGh3/IKIeS4mlRDPpXZj7/9kf0yM97BE+BffaqcygqjIUbFYfSeMFrHWbkvp3nqKiH5WANBXpjrER/Vhnv1SgSq+uE1eUAl1iBAemslWstymRO1CgtT/tSjVGnod9G34bvrvB0et63C87a51GURBGI3JZePUrAbtKmYAtjF0OV9y3/Wx93J+3HcM6XtlXc7bVZnRyFheMO++NPSmwUq3cbpeiJqBS3qhejvL0B4VkB9Z3JKXuTgjzkzDuVxDwEdWoJSaWnD7sytPO6kUHWoLrTAFb20ao8qqZ7xAnsbo1n3Si2mSaUflLGx79aG3BBwGEWkJ024iW//PwHdoOcYnL0+S0BEQR5akEziqTs75Q/4ss4+AAyey7FJjetso0ptA6yTPAnNRBW7yAIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(2906002)(31686004)(44832011)(41300700001)(8936002)(66476007)(4326008)(8676002)(66556008)(66946007)(6636002)(316002)(110136005)(478600001)(6486002)(38100700002)(186003)(53546011)(6512007)(6666004)(36756003)(6506007)(5660300002)(86362001)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXN5RmdqMG8rWG1kVzhEd09kb0tvUGNLbmc3VXk3b3VNSEtJMEVudHhlQ0xu?=
 =?utf-8?B?aEN5d0hjZWtUSWxObnk2NUtXZUszMTNISUFTaFBxZ21LR1IwVTlSeGExS3pD?=
 =?utf-8?B?Nk4xREJONFZ6QlVGbUI1eUtUVmxMWm11TXRaUks4ODN0cGprT1hsNjNWT0lD?=
 =?utf-8?B?SmhaYUdrM2Z1b1E4Zm1lMUlITEFDL1hXdTJRZXJWSHFHbFNuV25GVnVQRkNa?=
 =?utf-8?B?WmpqU3RFanRvZDNOSlo5UXloNmxTZ1ZuaXJNMjNDc2JtblBCQmdkT1doU3pV?=
 =?utf-8?B?YkZzUWNDajVqNGg2c2ZtbkpTL3phakt1d2w2TU9lTG5USFcxVkg2UTUzaDFl?=
 =?utf-8?B?OFNJMEtrS0Q5UFlkMjdnZ25Relk4R0JGUVIyMkhGUHMvV2pQeHNLNmdSRzZt?=
 =?utf-8?B?UjhBYmw5UnhqL2tiTm5iUnBkN3MzVGs3QXBWUGNVck1FNW8xRWNkZk16VWti?=
 =?utf-8?B?dG5DY3ZXbE1XS0FJd0xpTDRPd1dtS2JmZExyRG43OGlYdWZZQ0VNSlpJQWE3?=
 =?utf-8?B?M1RPSHkyaFBXengzbzZhOXRrc1Ewd2lMWWpMa0RzSlFHWFlmZVNFbTJ3QlRx?=
 =?utf-8?B?TjZyQmlkREtYRFNQVXpHek9oVC91RHp2WjZmNDlNOVNYTTRHTUR6cGJXMEc0?=
 =?utf-8?B?UUc2cmdxeHgrTks1cit0ZDUrSkF1Nlk0ODlEbTY3V3NySC9iSDN4aXk3TTJZ?=
 =?utf-8?B?azdLbGUvMkMvYlBlT1NQVVRMUU9GU0hqNWdTcEtOVk9DcG9Kb0taeGJvbEkw?=
 =?utf-8?B?dEIwMDJON0N5U0VYYWFyUkhWRU5RZk9FNnhWYVVxVGxlZit3emZqc1dITXJQ?=
 =?utf-8?B?SzBDSE11eTdOSkhpYzBHdTNjT3k2aEI3cElxQVVPcFQ4ZjlHN2RXYnk5T3h1?=
 =?utf-8?B?WlROcEJReVpVY2NpQmZKelQ1Z1JPNTl6SlFiK1Vva2RpdVFnNFFzVzQwODdQ?=
 =?utf-8?B?T3ZIOGhJcjBLcHNCMkN4ZERDNVBNZmRMRkhQL0FWNXEzZVZzOGlJNnZhbjBw?=
 =?utf-8?B?WHU5NmxWeFd0L3I2REg5UVRkRFNLTUExL25iUzgrQlZmNEZUUFo0VjU5Ym95?=
 =?utf-8?B?SHhJQ29uM3BmRWUza0lxMjZ3cEVhaEtLMGRTM3VraGpnaDJIV3I5L3Z0RFpU?=
 =?utf-8?B?TDJvU3B4SVVxV1NvaWozN2YvdWIzbC9GaUZJRG1RTDZzN3FGVEc2UVZ3VkZ6?=
 =?utf-8?B?TUMzTWk4MUZRdUJkd3gzdGs3cGF6aFlBQkR3dFVBVDJwZGJrY21TY1ZOODF1?=
 =?utf-8?B?eGJudURqNDBIRlVDejJieGRrU09RSElydFEwMVNjNGNzcC94ZHBTM1E3cFl3?=
 =?utf-8?B?NCtRYzJJbGZwQmMvdjF6K2IxTExDR0VKbUJma0Z3WlV4NUdhV2hWR3Z0a2tq?=
 =?utf-8?B?OWQyVFFjMDcycTNrd0ZROFlBVGtLZ1JBc0hOUE0zb3NBcXpHWjIySVJRLzRQ?=
 =?utf-8?B?ZlhIYmVqZktKZ1IzYlAvVWZqY3RrWW1jdDY2QUZyZDBtOTg3U2JaMjFDamdz?=
 =?utf-8?B?TDhPdFVEQlJiaWdzVGZNMjhXdEo3K1d4VW14ekF3cUtaWkpFU0prKzdmdFRY?=
 =?utf-8?B?MmcvbXdOS0ZMVkZnVlBJd1lNU2ptS2Q1YmtPbVpreVVlNFR2VjdSaEZBNUpJ?=
 =?utf-8?B?ZldOcS9ERHU1M2JkdURUR2Y0RHN5eUxCeFFQdkx1SFkzQ2FDTWR5OTZrY3g4?=
 =?utf-8?B?UHFBRSs5RHgrZHNJc1hkZ1N4OVpMd252Yk9WcTkrbnBQY1U3K1c4YU1RVEdQ?=
 =?utf-8?B?R1lWVjZrQjBJRUhRLzNOcnVZRXhqNW1OSDQ0cllwM2VPRzd3Yzl3Q3VDK3Av?=
 =?utf-8?B?WGZhUU1lWFlFR3UvM2NNaCtFcTkrM0RLSWlNUUhTZ0gzRGk1aU53ZGdmNVFh?=
 =?utf-8?B?cXozM2NUTkUxYnNjd3BnNVlqQXFNRE1paUZjL1RxY2ovQ1ZRdmNtNXhDdnZn?=
 =?utf-8?B?R290ZHJGRWpxMW9tS0p5M24ySmh3RnpqYUk2T3kyZGx6c2xQbzdPWitrdms0?=
 =?utf-8?B?ZkpMQU52MGhQSitrWTQ4bXQrOWxvaFBudm9iV2ZkaWE5ZEVxeWpNOExjS1ZV?=
 =?utf-8?B?aVNqc0JMTVcreXFVQ2ZGNHVLTnZZajhBSDJnM1VNODkvUnpxREVaeHNHL3No?=
 =?utf-8?B?ZStnVVdHOVdhcHIrNUdhWVBKdGdibFZROERibDcvZGZFNEtwWFpDaXB4bWoy?=
 =?utf-8?Q?MrEZ2iG3QxdN+9dNB/RxEvt6sRKfZYyzAzy/LMAmz9nl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0f30b-58ab-457a-f4f5-08daf52a5b58
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:52:29.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TnSlP3pZK0cTR56AqkNgel/fj63S+FijXRm65F9h8g3KUIW1XrMJeF3vwIHNhdZf0jSXOjjEHvg7NypYBFBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 23:21, Wyes Karny wrote:
> For some shared memory based systems, the autonomous selection bit

For some "AMD" shared memory systems.

> needed to be set explicitly. Add autonomous selection register related
> APIs to acpi driver, which amd_pstate driver uses later.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h | 11 +++++
>   2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c936ff503965..e47b2cfe022e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1432,6 +1432,103 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   
> +/*
> + * cppc_get_auto_sel_caps - Read autonomous selection register.
> + * @cpunum : CPU from which to read register.
> + * @perf_caps : struct where autonomous selection register value is updated.
> + */
> +int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *auto_sel_reg;
> +	u64  auto_sel;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	if (!CPC_SUPPORTED(auto_sel_reg))
> +		pr_warn_once("Autonomous mode is not unsupported!\n");
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
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
> +			cpc_read(cpunum, auto_sel_reg, &auto_sel);
> +			perf_caps->auto_sel = (bool)auto_sel;
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
> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
> +
> +/*
> + * cppc_set_auto_sel - Write autonomous selection register.
> + * @cpunum : CPU to which to write register.
> + * @enable : the desired value of autonomous selection resiter to be updated.
> + */
> +int cppc_set_auto_sel(int cpu, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
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
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
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
> +EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
> +
> +
>   /**
>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>    * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6b487a5bd638..6126c977ece0 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -109,6 +109,7 @@ struct cppc_perf_caps {
>   	u32 lowest_freq;
>   	u32 nominal_freq;
>   	u32 energy_perf;
> +	bool auto_sel;
>   };
>   
>   struct cppc_perf_ctrls {
> @@ -153,6 +154,8 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> +extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> +extern int cppc_set_auto_sel(int cpu, bool enable);
>   #else /* !CONFIG_ACPI_CPPC_LIB */
>   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> @@ -214,6 +217,14 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline int cppc_set_auto_sel(int cpu, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>   #endif /* !CONFIG_ACPI_CPPC_LIB */
>   
>   #endif /* _CPPC_ACPI_H*/

