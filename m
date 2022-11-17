Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F862D292
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiKQFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQFFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:05:06 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684F2FC27;
        Wed, 16 Nov 2022 21:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S72I5Sb/BS2PP9BsYygz7o/Hf6y8gIlhRa5oGavkcd0oLC+ONSlJGT2JrOGifnj4+VBo9xoPXQVx5acLmktjQS4ZLTuEhaWXBKmzKl+3NcqWV/Kefpa2MtGB5eiROPHWok/NQrHuwyQCnc3tsxLSQ9i0QhqiJMFpkFYjVAwHqd4ke6E+M1ELJl+jXCx+4xKs8904np4L73BJRIukdF4DWDlCSXksQU8ptRsfo940jEKrOHYRbKHJ1KiSNT4SUB7P85wZxs/zHBTaOAbyBM1K/qVq+YjFF22+ZVNbMFgW0l+mIx82ymXwEf1PDKQ9g+VLYb3+ln4WNX06QJgkzZt8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLldsHcaA4R1uCT4ma84vaJH78xTUHoj3cyp5Fcf4w=;
 b=Xndxl1Dgsg8BAVt+L/DAtTpZ1QtA6N8hKO3BW6T72g9eJ9RB32Eh0I/OA9jKNC6x/Ygkf7Atrs7tki0oFVwQ33SWP6MOxKX7UItgxAG5LoYIgwtEw6izg0+n1/CSX6pq1AEqys6pgbZn9QypsAJVLNlPKJbxdDRjVXuk6mqb/g8/6l1dyIn0rJeso4ak7jnr3hbYHJ9AtJ7jQlEaWhLhm4Kx6AJY5moOU8x8XobBsjd++/bxvZ5RbbSDOIHoEJqtdW8POEyoYaQFwg3D1y9sWltL4amLTuSKYZmbo3xbeN2RSwulcHRoEMAiEGCQ4TnPLQEoqIebePccCCsZX2++yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSLldsHcaA4R1uCT4ma84vaJH78xTUHoj3cyp5Fcf4w=;
 b=MtNJPVfqlxxwBGTD8vCNer64HWSg9sZz2neWANeZ78lXPq8Ri1MiuGMjCZMIy8mDtRmC9xVwQkxRTU6H1QJTBIdw26hx2OWqJDfHgBVqH24yRQuKEtpW3A5104GjNx4RI4RL6OvobnF0+pceo5JqJrBY6Lffd7UXqgmJCdxhqtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 05:05:02 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 05:05:02 +0000
Message-ID: <b3df688a-7f19-6e09-7054-3aaee57b521b@amd.com>
Date:   Thu, 17 Nov 2022 10:34:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] cpufreq: amd-pstate: change amd-pstate driver to be
 built-in type
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org,
        Mario.Limonciello@amd.com
Cc:     Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-3-Perry.Yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221117024955.3319484-3-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c309908-1346-4f18-2c4b-08dac859488b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3X/dpxPYhcmaV80s7Xeo2caCmXnnAFUJeeGJLO/yUoK2p7dZFnNkuZwFkJj2nSyFRaYDM4/IVa/lhcy0DfZwJ24YkuXuWMLaVQnaYtcNBUaUNfH+3hHOsDW8i9j8tnlUW2wSXEV0AQdmk1lbQf3HvxX2d8Gk+2QtR9fzhKhEROYreol4oBwIMhy+Xwf7DIEA9dpsGAsSpOAfieGecPCY1MtpeW1ubfRFQkapi0bRs7x/++ba+QAmWQoKJ+vacoTycNN5FtroYGYv65r7Kco0Z0qHj9UCzh6SQEawpTS7gHBJGJJQPZIAw0k8qdtQCY3GrqViZryxLhJrZIleAfslAWBRh935BCqQdPqgvG/d8DAhYD4dWO4dK3Blgaszlk1YhO/sGXO+6PO3+AY3C6CU85FWzo751y5CjpXjVPnTN0BFkDpCfD9Dzkg+6yQUxaS3gtFErmiulW5NJWEpl+cs/nTgmtPJqAEznuoN97g+a9VMYkg49JfJOfdDoYFORmxPy7/0mP27i1qLrBtVqmWMOKCBqboW3NUBKRCsbsKWsNLDTWJR/FAXjlpb4oC/3P+DB5l3Jew2olzKQJOebPZtpHwDm2ToNM2iX4idETrJ/tqZ30D17Y7EWVGhHc1OOsgPspoh2E/WbQvuPQG28ontu+9ulRw7urkzWuTPme+ZjxvQcsa4arn+2aYcuNVPSBg4J3TLl3/3EIvWqAW19jPINqHyWSZfrJk4MO4Du7yEyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(38100700002)(31686004)(31696002)(86362001)(36756003)(41300700001)(186003)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(2616005)(83380400001)(6486002)(478600001)(6512007)(5660300002)(44832011)(6506007)(6666004)(2906002)(53546011)(26005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZwbXRtMkY0SXoyWEJJNXhDemFXZTdIbHRPeEZCVWZxQUlpOVlrTXR3WFhi?=
 =?utf-8?B?T2Y4WHQ0d2lZaHlmY1NrOFBsSzJrQi9iWS8zVkZGdVRwUWt6UnlCbzRrSmpC?=
 =?utf-8?B?b2tqVTNQNWhqSklZQm1UNEJCWmN5VC9hYncxTDJKa2FiNDc4SzZFTFlqaXRi?=
 =?utf-8?B?ODdTRE1xMW9qZWNFMi9MSG5vMkJmbXdpME5pNGxjTGZIZmM3aFRtOC92Ykdo?=
 =?utf-8?B?a0o3M1k3WVJjZXBIeWVxekFCUXdleng1Y0ZJZld0djBieGZBZ3lyKzh0ZCtU?=
 =?utf-8?B?MVZhQjI3QkRObVhjZy9ON1hPQ0puN2xtRUl4NFNyL2JkUElsaXN3NytPNHph?=
 =?utf-8?B?Qms0SWNWRnVuV3pHS1lacXdVZk55V1gwZFdNYXIzMmFaa3FsOFJ4Q1BYeHUx?=
 =?utf-8?B?aDE1TWpHSmpsN3RVOS9OV1pkSDJuRVZTV082em1NejVqZmlBZ3huOFlXTmh3?=
 =?utf-8?B?U2FtNldQT2U4eU9RVzJTU0JrWEwvK2grcXVwVmYyOEtDa1YzTmhQUGJISVhO?=
 =?utf-8?B?OXR4cjVuUnZhTCt0SE4xM2NubERReDNnMXBUU0VJc0VSWU1zRU1ZRjVWRTJ5?=
 =?utf-8?B?KzdzdUNSbzlteWRIdlZUTnl3d2taRGVaUlBZbFlNSDV1dWIxc1F1eFo3N3JM?=
 =?utf-8?B?ZzRDRWdoWnZvQnNNTTRmYU5UUkJ1aENPWlo2eCtGT1VETFRnMEZQVW1rSjJu?=
 =?utf-8?B?S1FTeWZLdVZMNEt6TUI5MFErRW5tbk96cXk1NFVQcEtKRjlHV3hvdmFnamRk?=
 =?utf-8?B?SjB6dFU3dWRmZ1hnVVVYSEppdTg3MjhwZFh6aDNEdEZuMmJ0Vkg3Q29Ibm9E?=
 =?utf-8?B?RFBLZXBxVk81bDFVbVpMWWFjUVQ2a3ZFb0R3YnJRSCtmWFFKVHpWM05ocEEw?=
 =?utf-8?B?dDNLYUFMRVBzZDdGZnFJMTZ6L0R6RENBenlKRkRhZXZYNHdmek5JYzFyVGMy?=
 =?utf-8?B?SEo3Y0xObkcyWmtOUFRBWTVqMUFwazVkN1loUjU2eURyRmU4elVHdjBsWDRP?=
 =?utf-8?B?aFN6K3U4SUFhMzF6T295M1NiTytvNzlDWlJUSzVXQWlhQ1VGb0wvMkpSTk1w?=
 =?utf-8?B?NUZHZVRYam9hZGZvTDUrTEhac0Z2SzB6dDlnVXFGaHNSTmcxdkloMHRPVEZp?=
 =?utf-8?B?WkNicGNuL1lpeEhKZHUwbnl2dER1QU9mTkhLVG5SeTZ3ZlB2MEpBUGhnN1Zw?=
 =?utf-8?B?N3VYVXNHb2lRNEc2akZtdm80WFpOcVExSUJrN1RtekhUWHRYV1VnSEFtMTJl?=
 =?utf-8?B?Tnd2VWJmdHFxejQ1RnAvM2JRNmdDdWhlOXlISUhTVjR2Y05mWnB5SFBXV0ov?=
 =?utf-8?B?eUZ6cTBRN3MwdWNCeVdnQ1FFVVpKejhwRzRpV1pITXdVVFdvZEgvWTB1b3dK?=
 =?utf-8?B?QkZidkhEWnRYNExYTkU3TGgyK2VITThxUHh2U25Td0crNDVMeHZoVmdKYm1i?=
 =?utf-8?B?Y1FBbW82dVJISUFHb1IwQjR6ME00Ynl3R2pMREVKZWE0eUxuQlcwejZpYlR4?=
 =?utf-8?B?ZUsyb0U4ZFZ2RkoxQmVZckRwWXQ1bUk4ZW1lTnVBQ3Zyd2YvMFcxUFloM09s?=
 =?utf-8?B?a1E2UnAwYnlFZDhoM0MzQ2NDK1hjQjBKdnQ1QUpXektHWFJ1Tk9CTGwycmNk?=
 =?utf-8?B?U09SU0wzbmlIZkdWMEdQYXpIQnZVamMwUWdyaHNsY0VJdVIxY1NJczVyUVdW?=
 =?utf-8?B?aHVwTElmNlBQSWlHVDVORGM3cFNjQlpRcWVjUWFnR2hodk5FVlZFVXdscUdU?=
 =?utf-8?B?aDJnSVNaOEtCbVpVT3Z6eXljbGZLc0Mwb2pyZkdSei82Q2ZJYmNNZlhwQWNG?=
 =?utf-8?B?Zi80Z090OEVYTzZPamdJRXJRblNMWTR0elJ1V1lYcnFOZmQxUHZ4SXBldFhZ?=
 =?utf-8?B?ZllHVzNUSDFzQmxOWFNpNzg4emlkTUZpaHo1Uk1iL29DdnB3d09LbW51Z3Q3?=
 =?utf-8?B?WUZQa05tbzFsSXpTUDB4MlpXQ2xFZDcreGNhd2lpNk5XK0d5dHhUc1dNZFlH?=
 =?utf-8?B?Q1VUeERSbHQ5eVdLSXgvcVlNaUFYcWtINStRRFNpVjFpTVYyWHh3SS82NFdR?=
 =?utf-8?B?Ky82bWEvL2RXa1E1RngrRkxRMlcxeHZTWmw4RVhSblFrY0ZRamV4ckpSR2Yy?=
 =?utf-8?Q?QFqyJYQmBOYm16G3NzFWcizm/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c309908-1346-4f18-2c4b-08dac859488b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:05:02.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEdCV/enqe3kx4BwMUjn47W8Ys585bH/P+MdsB+/XMxxpoGYfDG/Z3U6dtS0uC0UffIOfL2iH7exu5AM7Qbq4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 8:19 AM, Perry Yuan wrote:
> Currently when the amd-pstate and acpi_cpufreq are both built into
> kernel as module driver, amd-pstate will not be loaded by default
> in this case.
> 
> Change amd-pstate driver as built-in type, it will resolve the loading
> sequence problem to allow user to make amd-pstate driver as the default
> cpufreq scaling driver.
> 
> Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Tested-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86  |  2 +-
>  drivers/cpufreq/amd-pstate.c | 11 +----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 310779b07daf..00476e94db90 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -35,7 +35,7 @@ config X86_PCC_CPUFREQ
>  	  If in doubt, say N.
>  
>  config X86_AMD_PSTATE
> -	tristate "AMD Processor P-State driver"
> +	bool "AMD Processor P-State driver"
>  	depends on X86 && ACPI
>  	select ACPI_PROCESSOR
>  	select ACPI_CPPC_LIB if X86_64
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d844c6f97caf..701f49d6d240 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -663,16 +663,7 @@ static int __init amd_pstate_init(void)
>  
>  	return ret;
>  }
> -
> -static void __exit amd_pstate_exit(void)
> -{
> -	cpufreq_unregister_driver(&amd_pstate_driver);
> -
> -	amd_pstate_enable(false);
> -}
> -
> -module_init(amd_pstate_init);
> -module_exit(amd_pstate_exit);
> +device_initcall(amd_pstate_init);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

-- 
Thanks & Regards,
Wyes
