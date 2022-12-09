Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC45864809D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLIKFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLIKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:04:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F763B90;
        Fri,  9 Dec 2022 02:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzbcV48YyBWwgqpCWaUoWl/Rh2/WeXMzX2esW8b8RJz7rRD/WcMhQKwJMrhM0dKymuwQQ9TicqUGIlMrj6DJX3dJJY68euzGu/x/2qWsGqen/70uSBDn+4jBOJ8txJOhzl/IfhnwO9/eS1U51/jZQX+3qlFSa19SIJRlDDh+2py3U9vtnHupV6JNAckaCPfg236ZV4/cGGDCZzrPb2oQaVIn0fpcK+y8hDgHHGQ6FEPoUBnM3QBdLiMBMrKRQ+YKsOsvBvTkBrllzXmBFNy76Qi0DX2Gmp58FsgzvidyTurfKh7kF+Gf6auUaNyK58vbgGxqExYVUsnrKkOf/gr8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uHmQkfTVeLQQ3ARz6mPCHvI5t/ufkyMypamyJu2OSQ=;
 b=AqB0TBpth1jsyZVswCxsWGVH4G5/lku7tedSthle0Vi/lwnrWOP7k7T65xhuO032hxwLXgXcisjkhKT54BT2TT29uYeT7lu8+ntAsewUAeYOgpRvk68pJxgEtw8b9bLl2jJ9OU9rW4I3eXoYjc7SQAZCkIzRtRNcc70dJqrfs5wJyzYAf23fwZUr5+D9oK7BCLp8Ji5/REcJpdcV9cGOuTW8R+Yaji3b7qoX5Ky18jOYmuYjOaEChD3mQ6DEuFIQAY4HFJp18nbgZhTLy0jsRRArEETzvvyKFoitDivbIjoLNS+gK4zmNRaBTUS62kB2trjmxwq5hGgPSYpuBSuR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uHmQkfTVeLQQ3ARz6mPCHvI5t/ufkyMypamyJu2OSQ=;
 b=bbPz/RxUAbp9ae1lWjxtWnYYNy+hM9DyLvXAT7tYTkSJoadAajykJP2YBoXwCPz5c9Erlh9yk+EZTH4PUlKcq1uLM6sSlwLSgH/hEccW76iCsYP4fpuXdvjRDYT8dlmvE/KBKQTIxSugo7Xx7KbIiSB73ofQ0cT2jgHxEql6Aw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 10:04:41 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 10:04:41 +0000
Message-ID: <99fdd501-9cc3-1570-21fb-7d5878e21543@amd.com>
Date:   Fri, 9 Dec 2022 15:34:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] cpufreq: amd_pstate: Add guided autonomous mode
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-2-wyes.karny@amd.com> <Y5LnB+zUjy7aJmOr@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <Y5LnB+zUjy7aJmOr@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: f08f7174-dbba-4f56-222c-08dad9ccca05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U87VgzdIsvudEl4SvcFJJovjfYgFWd2remKg50EdiDAEUbHS0EVhHi94MOkk+joy422RMQ7MYm2pltTT6tsEfahN0bje304KxI9+ezfYRhR5TeWnV/Gi5rGc9gKSrZSW1b0kKY7Lz4wMLi/yzfbfMGVM9drz2U3xopXQOQ+p3ZIiWrrIFyBTI605VvDLGroS2Js5Mrja38JvasbnVtFVXtOO2NcVybhvar8vdk2OtKdF00PQXdllA5PS+V6TkV8Nz/5i3rnSAhKYZL8s0PF5477WuH8v/5k+TkfYj4nwlV0A+AiAc0OvboDjTaE4/TnSZZG3uQCWejQgCqZKIxqZO9XiHtaZdiHVGu42TZnL14+3UmxVfmCyLDqPJcp1awj7ZroYLmRWtYdW4R3s5s02MbeMBPTGlSkZoWWdVNM7tsZyFtyBtVgluty2EDfPsmMzehHxgA2TeJAzjhm79AmV33lR00FLzihMMXrn5jZ2ftc+JX2N5QqlzkjEOxPuc3l/QBfNtd+L3YQtfHmgJvfoqrIw66RNWHUVIoFkIjqY6iGnrzRa+n5HXvoAbQFKo0rRUuwiQjl1rlHHLR631ATkMIBl+YQ4a5DcffpaNHZRZn6BsEh+J3PTDNBvmn+4PH4RVuVVdvepcmCBuxJ0QnfCrLNZRFEuBDlXC8rwrkROBvPDwju3pTc4s9kaS2P6RcJupm4h1VRIkRoQNwvccBUivfuH578HVIdcL8UVp2pfLx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(6512007)(83380400001)(6506007)(26005)(53546011)(186003)(6666004)(2616005)(38100700002)(31696002)(36756003)(6486002)(478600001)(86362001)(66556008)(37006003)(8936002)(66946007)(66476007)(6636002)(4326008)(316002)(5660300002)(44832011)(41300700001)(54906003)(2906002)(8676002)(6862004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5hNThqeG1JS3A5WVpjQzZ0L29tTVBvZytQTnVtL0o1S2Npb3FUcUJseUZh?=
 =?utf-8?B?QWFaTC9JZGxzVVdiRmJ4VVp3RGVic251Zjl0V3FHNm5WUWg5MmhKcmFhNEVn?=
 =?utf-8?B?THpwK3VNc1dkMXFaQmRiYmZIdVJGWUFKY1grTDVsSUlJdmF6OENnMzJXOWJx?=
 =?utf-8?B?NEMyc2RVdmQ0dzAzS0NPam0zMlRJOUZ6UnMrckJwMklkWHVtbXhseFU3d2xT?=
 =?utf-8?B?bXNTTFFCSXh3cDNzblR4d3k5S3JZTk41WUp0eFduWWhmbVFmdnltZlQrdHpn?=
 =?utf-8?B?T2JmSXNHTFFuRFgyMUNKL3YyZVROWnRJV1o0VVVIK2V3d3hhSHQyY0tpUHl4?=
 =?utf-8?B?UTdUN0hTTGlhZFY5N2MvczREd1V3K0VvMTNPZkthSWZRblp4RC93azRtREhz?=
 =?utf-8?B?clI1S0RDS0hibFlFSHdxVHQyWXVDV29wUUVpcld0ejY1dEJzdVd2RDlJTmNi?=
 =?utf-8?B?cFhNUkZvWXpEUDZoeWVrSHB0bU1IQkMrUFdObjBjYmpGV3E0T3lzd3hKSjNr?=
 =?utf-8?B?M3lwei94U2ZrbFZWTC9rUTNSY3JWSDhhQ0pza2JWUlJ3TmhnM1luMUk3bWNi?=
 =?utf-8?B?dHExN3pnaGdUdFRKWnpyZUVNeDZoSkNQWFdHSU1BWUgrQVFJVUR6RWg2S1ZD?=
 =?utf-8?B?Y0s0aGFEekVLVmV0b0dDbVZLY1BiSEpNNlhKRk5ySEY4NFZsUTlRZVFlMmI1?=
 =?utf-8?B?U0RjdFRteUJRQndwUmZnbnIwRkQ2LzF5SkhKUklLME9tYXc5VUh2U3hkSEcx?=
 =?utf-8?B?TjVTWWVLNm1DWUk4VTdZdmY0b3AzNi8xV3U5dFpyMWs1RlZDL01OWFpDTVk3?=
 =?utf-8?B?blZITjh1ZExidm5xc0ZRS1F1RVA4UVZraytmcjBVNnBlVEwyVXpmSXVybmJE?=
 =?utf-8?B?U3ZJWklNTmQya1RCWFQrUnNjOWNVM3BlR09vYVBsQktTeDRzY1dhc3ZwT0o3?=
 =?utf-8?B?aC85Zk82SlkvVER5cTB3Y0lkaHpIeHU0SnRVOWhDbGMvc2ZUNTBBZHZ5MVJE?=
 =?utf-8?B?a2wrc3lJZ3JkaFpFeER3b0N4UXZpSHZYU3VjZEI3S3RqYTFmNWN2dno2eExB?=
 =?utf-8?B?RjZzQjZNbjBVcDZTR2ZWckU5K3hiK3dZbmo3UnRJQmhKN29LeXg5NFdlZ3Ns?=
 =?utf-8?B?eWNWQlE2ei9YclpXZEh0cXpEM0M5MjdwNk0wekFZRnE4TUxuZ05qREt5SXVj?=
 =?utf-8?B?akRsMXNySWVLbTF3bmlaQU1obHZGQWJEdHorK2lIa3c3WkNaUUdXc0V1RE9j?=
 =?utf-8?B?VHV6WHc5a2VmUDEyS0Y0S1djanVJMlU1U1UvYTIvaTZoUWlLdjc5Q1lGMW9J?=
 =?utf-8?B?aEs4RVlSOHY1SW1tOG5IKzhCYzJ5MlBzL2VVZ0owNlQ3RXF1TTltQlFFb0g3?=
 =?utf-8?B?QUphQUc1dUgzTy9rcG9yWDF1cFlqTkI1eGx2SlBaUTVZK1NGSzE4SDNXdzBT?=
 =?utf-8?B?eWF4TFZMb3NoS3R2RE85K2xjeTFSaW5neXNtNTkzOEJMaFJyMHdpZUcyTmNh?=
 =?utf-8?B?MmZGM3RpbDg5VXZkb0x5V1ZLbTc1SStwd2lremp1ZHZCQnA2N0hZK0ZQeGR3?=
 =?utf-8?B?V2xMVVN5USsveEIzYmg5WHlpZ0s3UlQyWVFJczE4ZUdlbWtscnFlbFFVbTZi?=
 =?utf-8?B?NTFEUHR1YWU2UFIxbWRucjliSjczaDUvYmdpN1Z1eUlQRkluQlloQ1JwaXBt?=
 =?utf-8?B?ODF6YmFKaFptRSt0bVFXTXZBOGhUWVc2Snp4dWlKZnNMWENadDBNQitLTit2?=
 =?utf-8?B?SjFpRHE3V1NpNFI5dWdWS1lEOHFKcm5DRjRxTlA4djVYazl5TWM3UDBPMnBI?=
 =?utf-8?B?QzlpMHZPVi9LbWROc1FoQkN0U0lvQUNQaEtzQXlneS9aTUUwQmlPak5VWTVv?=
 =?utf-8?B?ai9aUDJQVVVGV1dFQ1NCN3UvOSs3a3ZFS1lCQ1NzdlIxeElpMG9xZjFjdVNB?=
 =?utf-8?B?cjdEQkFZTnYvbC9UQmhvU0hUaEgzaEtqU0RBaVV3Y0NaT1Z4bkVGbStIS2R0?=
 =?utf-8?B?VEdveDZLWVdmcEFxZFFjVkQ3Nm9xV0RVOHF6UFZSaE84dXBua3doNXc2aGU4?=
 =?utf-8?B?ZzVqNDh0UUt5QkRiSFZWdW4yRVNOSUNZQkYxZmQ2cnQ1bXpDNk83RFZpekJz?=
 =?utf-8?Q?C+Q6Dq7V82gSShBXuMrodyYYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08f7174-dbba-4f56-222c-08dad9ccca05
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 10:04:41.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4saKOp0pRrEsvoVt0PTGtePkRk7Y9Omg/0A/iqOsq/nh9mz7DRnqjVplycbRLsS+sTaB+DwbUDiAewgAi9ErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

On 12/9/2022 1:13 PM, Huang Rui wrote:
> On Wed, Dec 07, 2022 at 11:46:45PM +0800, Karny, Wyes wrote:
>> From ACPI spec below 3 modes for CPPC can be defined:
>> 1. Non autonomous: OS scaling governor specifies operating frequency/
>>    performance level through `Desired Performance` register and PMFW
>> follows that.
>> 2. Guided autonomous: OS scaling governor specifies min and max
>>    frequencies/ performance levels through `Minimum Performance` and
>> `Maximum Performance` register, and PMFW can autonomously select an
>> operating frequency in this range.
>> 3. Fully autonomous: OS only hints (via EPP) to PMFW for the required
>>    energy performance preference for the workload and PMFW autonomously
>> scales the frequency.
>>
>> Currently (1) is supported by amd_pstate as passive mode, and (3) is
>> implemented by EPP support. This change is to support (2).
>>
>> In guided autonomous mode the min_perf is based on the input from the
>> scaling governor. For example, in case of schedutil this value depends
>> on the current utilization. And max_perf is set to max capacity.
>>
>> To activate guided auto mode ``amd_pstate=guided`` command line
>> parameter has to be passed in the kernel.
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  4 ++
>>  drivers/cpufreq/amd-pstate.c                  | 60 +++++++++++++++----
>>  2 files changed, 53 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 42af9ca0127e..75e57afba77e 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6970,3 +6970,7 @@
>>  			  management firmware translates the requests into actual
>>  			  hardware states (core frequency, data fabric and memory
>>  			  clocks etc.)
>> +			guided
>> +			  Activate guided autonomous mode. Driver requests minimum
>> +			  performance and maximum performance and the PMFW autonomously
>> +			  selects frequencies in this range.
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 204e39006dda..05e4003a77ee 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -50,6 +50,20 @@
>>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
>>  #define AMD_PSTATE_TRANSITION_DELAY	1000
>>  
>> +enum amd_pstate_mode {
>> +	CPPC_DISABLE = 0,
>> +	CPPC_PASSIVE,
>> +	CPPC_GUIDED,
>> +	CPPC_MODE_MAX,
>> +};
>> +
>> +static const char * const amd_pstate_mode_string[] = {
>> +	[CPPC_DISABLE]     = "disable",
>> +	[CPPC_PASSIVE]     = "passive",
>> +	[CPPC_GUIDED]      = "guided",
>> +	NULL,
>> +};
>> +
>>  /*
>>   * TODO: We need more time to fine tune processors with shared memory solution
>>   * with community together.
>> @@ -60,7 +74,18 @@
>>   * module parameter to be able to enable it manually for debugging.
>>   */
>>  static struct cpufreq_driver amd_pstate_driver;
>> -static int cppc_load __initdata;
>> +static int cppc_state = CPPC_DISABLE;
>> +
>> +static inline int get_mode_idx_from_str(const char *str, size_t size)
>> +{
>> +	int i = 0;
>> +
>> +	for (; i < CPPC_MODE_MAX; ++i) {
>> +		if (!strncmp(str, amd_pstate_mode_string[i], size))
>> +			return i;
>> +	}
>> +	return -EINVAL;
>> +}
>>  
>>  static inline int pstate_enable(bool enable)
>>  {
>> @@ -212,12 +237,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>>  }
>>  
>>  static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>> -			      u32 des_perf, u32 max_perf, bool fast_switch)
>> +			      u32 des_perf, u32 max_perf, bool fast_switch, int flags)
>>  {
>>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>>  	u64 value = prev;
>>  
>>  	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
>> +
>> +	if (cppc_state == CPPC_GUIDED && flags & CPUFREQ_GOV_DYNAMIC_SWITCHING) {
>> +		min_perf = des_perf;
>> +		des_perf = 0;
>> +	}
> 
> Since we would like to modify the min_perf on share memory processors as
> well. The current cppc_set_perf() in cppc_acpi doesn't provide the MIN/MAX
> values. Could you please add the max_perf/min_perf in cppc_acpi.c as well?
> Then the APIs will be available on the share memory processors like Rome.

Sure. Thanks for pointing this out.

> 
> Thanks,
> Ray
> 
>> +
>>  	value &= ~AMD_CPPC_MIN_PERF(~0L);
>>  	value |= AMD_CPPC_MIN_PERF(min_perf);
>>  
>> @@ -272,7 +303,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>>  
>>  	cpufreq_freq_transition_begin(policy, &freqs);
>>  	amd_pstate_update(cpudata, min_perf, des_perf,
>> -			  max_perf, false);
>> +			  max_perf, false, policy->governor->flags);
>>  	cpufreq_freq_transition_end(policy, &freqs, false);
>>  
>>  	return 0;
>> @@ -306,7 +337,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>>  	if (max_perf < min_perf)
>>  		max_perf = min_perf;
>>  
>> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
>> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>> +			policy->governor->flags);
>>  }
>>  
>>  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>> @@ -627,7 +659,7 @@ static int __init amd_pstate_init(void)
>>  	 * enable the amd_pstate passive mode driver explicitly
>>  	 * with amd_pstate=passive in kernel command line
>>  	 */
>> -	if (!cppc_load) {
>> +	if (cppc_state == CPPC_DISABLE) {
>>  		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
>>  		return -ENODEV;
>>  	}
>> @@ -670,16 +702,22 @@ device_initcall(amd_pstate_init);
>>  
>>  static int __init amd_pstate_param(char *str)
>>  {
>> +	int size, mode_idx;
>> +
>>  	if (!str)
>>  		return -EINVAL;
>>  
>> -	if (!strcmp(str, "disable")) {
>> -		cppc_load = 0;
>> -		pr_info("driver is explicitly disabled\n");
>> -	} else if (!strcmp(str, "passive"))
>> -		cppc_load = 1;
>> +	size = strlen(str);
>> +	mode_idx = get_mode_idx_from_str(str, size);
>>  
>> -	return 0;
>> +	if (mode_idx >= CPPC_DISABLE && mode_idx < CPPC_MODE_MAX) {
>> +		cppc_state = mode_idx;
>> +		if (cppc_state == CPPC_DISABLE)
>> +			pr_info("driver is explicitly disabled\n");
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>>  }
>>  early_param("amd_pstate", amd_pstate_param);
>>  
>> -- 
>> 2.34.1
>>

-- 
Thanks & Regards,
Wyes
