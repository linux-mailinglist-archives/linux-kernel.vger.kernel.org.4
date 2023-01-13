Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3439668E64
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjAMGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbjAMGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356280AEB;
        Thu, 12 Jan 2023 22:38:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj6OpqQe3qQT463EdSvuCcxstybrN2hdYdsSKsL9d3t3zrHBQV/AUn7RCn7bhWK1vOJxaQ0AECjZIOgKcL7rH3NR2i8dmUI2kPNxpqFRqtuaLITyoZqLnwhFUghPhZ5FG+GY7utMlMQwDdUxiP9mgzTmzHgnnr2/cNdySsotddHOIQwm0QDujoHlFgjTHyWMRjK4yx9r5CP4Nc+1kJTa7CC1ZbyC1lKAuvGzYTgEd/5uy/Op7kV5dCiOYJ59drdSi+y8dubN1/bI49PqnNn9dZ3vWEvzov27NEYezqmdh4S5ow+Ag6gc+sP8DncKG88SZYbvgUgnOENWuOUEfDabbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9K8FPjHrQ4wDjZ/GT1tCP2ENJOS87zsaG90azpGA6E=;
 b=HFWB+50qeI1uzHKooRbU2vr4RdU5GO0FHh76j9akYsbHS5ky9dMlTCJG15Sk5OUCsdhyOYUHEEPo5U+8qz13oDmrq20DZaTq6KHWGMqF0THwGyqZP758GVhBHDO6O93RN/xNYRZpO7uSX82W4ftnV0jyApUocKacNHy9j5hsniwl0K0d0fuX1oZ2WzUKcpsK/+NZBTOaXl8id/sq7LBeROtrQsI7/mmzoDX7WPj7HHhvu28kI7+TvYr4vR7t/zfQMMh3KsVsqBa5ODkHHs2bFuRQMx4dF31/whZ4LgWN1n38EX991Hr6mOVrjCRrtenrEpZ+T51Ltt8kbcasnsC55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9K8FPjHrQ4wDjZ/GT1tCP2ENJOS87zsaG90azpGA6E=;
 b=YKBNmmuWrckhGe9X33RbbEWC4poPgN69PEYkzro+enLZYy9S/aqmvKShkCBpWF/UXvt399PwXRjz5+khXqqF+eT3jdnMIQINe8lqD4KP1mfkDIM3M3ygFIiKNU9q859sxCO/E7U4loQgiTrIZaaCsBwK6TQVnJxxUtmrWbTZfJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 06:38:18 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 06:38:18 +0000
Message-ID: <e6e162b0-7b69-cac5-b0d3-b33a589cb8dc@amd.com>
Date:   Fri, 13 Jan 2023 12:08:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-6-wyes.karny@amd.com>
 <00f4f977-b381-1b1a-a9a5-e2d342979b83@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <00f4f977-b381-1b1a-a9a5-e2d342979b83@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::23) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1229bd-7fb2-430c-1bdb-08daf530c193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3SxG1UzejkIckSuKy86xzwotsBvOjb8ytk1kljt+LBH1kEp5BQvrCGKaZoyKD2dBLj+2n6NS7Ae6e/HI01enN5qlnhY7/rIEBW3VXGjc9Y5wsJuhze38mBUyCp6i6lHtUQNrWjQYMlkUv/TmfaJ1X7cy6Y+gxDK+YAjJj84F4j7P05ZTr75GoblCzV1YR3Bjo3ZId3MuGa4zHNgF6WbVl8BqjqwS0nvk45LiTemF2ntHkQ5+tYl9+DZi3Ebte3SfSNZ5kFn/bAqOHEG85M2redlSZsuiwqtlfwDBEoxwIBUpBptRX18053FqO2cPUijuqz5+GOLh/nRR8L08xhm4zm9sFrkuhAWNrFiTkbsJLiiyzI2axDqVPdV+2htPaZ8q8OKKsGIYMphH+8In3vFdS1+Rcxu8pxWeCYVyQ3ZLrKD6yjNcVXiSf2vs+wInbd6DgfiDCQu+LySKwQ3ZdzSM1In5agpUgT04bcRa3oVq/WeVMOV1NDEHAgruqbybSHKexH6pmT7E1pG3JuiaLuZgX+OA3PsUIrnj/wpMOiTaXu3exq0VRwkwKuim9TXaXU2cGhCwsgI4BVP6roHQHfRW4ksoSI9REyR9kqUlAz4kx4/1dyoILJrHU/aNRBdW34nNqTTD/aEsoEDJ9WPFBlbap/sx31dQLjBjfzemEFD/kg389Jtva9tdtO0cR2Gy33Ldfd6eSmVOqZ+8BPBUFRuV+T0PPXTdKDO5QK7Mgg6eTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(86362001)(31696002)(41300700001)(36756003)(44832011)(186003)(26005)(5660300002)(8936002)(53546011)(6512007)(6506007)(478600001)(6666004)(6486002)(83380400001)(2616005)(316002)(6636002)(4326008)(8676002)(66946007)(66476007)(38100700002)(66556008)(110136005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUgwTGtVK3FHejU1bjhibUpFTlo4Rnd2cVBXOHRCaGJGRDFwRWpnR2pIdWZw?=
 =?utf-8?B?NVZWYnc1WnRSU1gvSVJiSGtmLzRwTlVNaVFadzdlSUxhcmlaeHhkd0l0c3J1?=
 =?utf-8?B?VVhYTS8rS2ZLOVBzbmpCcEFpUjFoZTVLa3g4eWYrb0hQVDByVWt2WTB2WU9Y?=
 =?utf-8?B?Uk05TjkvQkFnMzRjbUI0UGlYVjNjNlVoWlB2MEdJenk2YktGa0xmdXFVMUUv?=
 =?utf-8?B?NjVXU093eFRLbzd6NzhCcXN6RDMzN0lUSFI3OWZXUEhwRUZwdXVxbS8zRXBG?=
 =?utf-8?B?OU1MWTRuT0NDTHZPQnhyNytNZm1laDhqaVVRUzltN01PdUh4VVBuUVBBT0dy?=
 =?utf-8?B?b0wyakYraStEVkpjeGd4emt1cEd5eC9VYVhSbTFmbm5abVBqT2hCYVJZMkhT?=
 =?utf-8?B?WTZqT2FnZGpsWWIyeVQrVWxENis5MVlyV1RiaDNVS3JlNkt1ck81V2swTW5k?=
 =?utf-8?B?bkNNOExTd0c0b0wrSzFHZUZSVVUzN24rM1dxMW5zc3huQVdaa0pqMkhoNTRw?=
 =?utf-8?B?NjlteTcrMmR6V2FWcEJUdDExdG5iM3dHejhrOGFQeTJaUUlRblArOGpiKzFw?=
 =?utf-8?B?TnNZMEFTSGpFdXBUMmVNZ21WZElUbWtvWFF6RzVSenVzMldLSDBscEtxWitS?=
 =?utf-8?B?Qjg0RC9CVVlkdW9RQ0FYOEpEV2hIY0hMWFlSS1Y1L25WNDdVZlB3VDJ1Y3k3?=
 =?utf-8?B?YWNKUk9BazhlUTNPRUc1aWQ5NGNzUmpzaDFxQUFDNSsxNXdqU0tKSWJpVGts?=
 =?utf-8?B?OEJjajZxeGc4YU9RNEJVb0JSRzNIQkpnQUVncVVlZE5RTkhUVStzQlAraC9u?=
 =?utf-8?B?Y0RsdEErZ3lac0JUNVVqay9wcExRclNTa0E0RjVIQ1pmemxFRGppbVdqZFdw?=
 =?utf-8?B?NGRJTmxobFJ4RjBsU01IMW9WbjlwWnVSRnk2WlFwb3N4VGw2Q2w5TXcwQnFz?=
 =?utf-8?B?OERXZHcwSmFTemxTbE42cUxBUUZOWGpYd0oyZk0xNStPT3hIR2V3TlhZWTdj?=
 =?utf-8?B?WXFvUThtbFVsYmEwVkdxSjZzd2ptVGhEUFM5ZmVpM3lSTWVsam9IMlpBUnlr?=
 =?utf-8?B?azF5dStOUENqODkrVmU1dXZHQmxCZXY4NGtMTU9rNnJBeFBEVlpIUG51UUNS?=
 =?utf-8?B?UHhmWDVsV1hycGNTWkM4K0dCeXRicDhPRXpFbEdLdC91eUlzaDVnVEg5a1Jt?=
 =?utf-8?B?eTV1cWhVZUovRGpNTmZIYTh5VHJFL1FHRmJOUHJjcW14VTU5emFSLzRpakJu?=
 =?utf-8?B?Zk10VXFLVjhPZnlpU1NzOUxlR3hxenFJWFdRQkR3OVpUSGk1WlFKaytQdmlp?=
 =?utf-8?B?NDBXMEdSOHJRbklYdkdGUVlNaGtUcGRaNXRvRC91WUdIdmdkRERxd0JDc0cw?=
 =?utf-8?B?cjF1U0I2TU0vNGhYMkI5ZVJ0SzQ4blBuQUdTSUJHYk9CSU9paDhCNU04bUdr?=
 =?utf-8?B?Z09YMVBCQ2Z1TEZ4UWZUSXo3WWE3UGl1djZBOW44M2dOT3h1WllrV3J3dERP?=
 =?utf-8?B?Mm9DcVkwbExFandTYjh4UkRxbTBXVTJpdG5lQm5JeUE1QVpJZ2JUWWdhaXBj?=
 =?utf-8?B?TzRuSU9jYXdJQlZKbkROb1gwd2QydXJEdllSTXdTRm5sZmQxaEtFWUZlQ01C?=
 =?utf-8?B?L1B5eXFqdVBrUEM0M3JySHMwVlNhVDI5NDNCblhjbFpmb05mVmdlN1ZxdUNL?=
 =?utf-8?B?NERXWnFWd2F3b3hnTjVGSWlKS0JmVEtpYnlDaEdzNVBVZ3AwOXFNek1lQ0g0?=
 =?utf-8?B?Q0lQSURWRnFSRWk0cmtuVmdzQkwxTXZORkZQZ2QwRkdVdjFDcHhVdmhLQ01D?=
 =?utf-8?B?NUZLS3FWMmtBQTZ1UHNSdnN2V1cwcTFISGdoekMyM2drYm5keE9RL2JIQ2xi?=
 =?utf-8?B?VmkrbXU5VC85T0JWYVFpRkRTRlFzZnNSTkp3SDFsbGxGQkFrMjJ2OXBzOUZn?=
 =?utf-8?B?c3RCbU9wSmltWTRHaktvRVIwdUNxNmRzQzZDM2xPWm1tTW5qdnZZekozMHFS?=
 =?utf-8?B?bm1nRVlkMys5WHZuQno4emRVTks1M0lyY0I0dTQ5ZEVwWnpLa0dkcDdTeWsx?=
 =?utf-8?B?UWgyVk8reUR5ZmlRY1c3K0VqeUVzTDE0OHhRN0xidFB3OUNpazdLMmpYWXox?=
 =?utf-8?Q?tmXwSVbiSgYZZ1JZUFnUVup7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1229bd-7fb2-430c-1bdb-08daf530c193
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:38:18.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKb7huZIrG+XpAAg5nQoNbi4WMyxEt3M5MSyczRt03gOuxcSZhPeCtryo/u3id3wdMEgt6jXqqpGSkz6XFyP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 11:18 AM, Mario Limonciello wrote:
> On 1/12/23 23:21, Wyes Karny wrote:
>> amd_pstate driver's `status` sysfs entry helps to control the driver's
>> mode dynamically by user. After the addition of guided mode the
>> combinations of mode transitions have been increased (16 combinations).
>> Therefore optimise the amd_pstate_update_status function by implementing
>> a state transition table.
>>
>> There are 4 states amd_pstate supports, namely: 'disable', 'passive',
>> 'active', and 'guided'.  The transition from any state to any other
>> state is possible after this change. Only if the state requested matches
>> with the current state then -EBUSY value is returned.
>>
>> Sysfs interface:
>>
>> To disable amd_pstate driver:
>>   # echo disable > /sys/devices/system/cpu/amd_pstate/status
>>
>> To enable passive mode:
>>   # echo passive > /sys/devices/system/cpu/amd_pstate/status
>>
>> To change mode to active:
>>   # echo active > /sys/devices/system/cpu/amd_pstate/status
>>
>> To change mode to guided:
>>   # echo guided > /sys/devices/system/cpu/amd_pstate/status
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 144 ++++++++++++++++++++++++++---------
>>   1 file changed, 109 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 20d78dad712d..4a2b559fd712 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -65,6 +65,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>>   static int cppc_state = AMD_PSTATE_DISABLE;
>>   struct kobject *amd_pstate_kobj;
>>   +typedef int (*cppc_mode_transition_fn)(int);
>> +
>>   static inline int get_mode_idx_from_str(const char *str, size_t size)
>>   {
>>       int i;
>> @@ -806,55 +808,127 @@ static ssize_t amd_pstate_show_status(char *buf)
>>     static void amd_pstate_driver_cleanup(void)
>>   {
>> +    amd_pstate_enable(false);
>> +    cppc_state = AMD_PSTATE_DISABLE;
>>       default_pstate_driver = NULL;
>>   }
>>   -static int amd_pstate_update_status(const char *buf, size_t size)
>> +static int amd_pstate_register_driver(int mode)
>>   {
>>       int ret;
>> -    int mode_idx;
>>   -    if (size > 7 || size < 3)
>> +    if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
>> +        default_pstate_driver = &amd_pstate_driver;
>> +    else if (mode == AMD_PSTATE_ACTIVE)
>> +        default_pstate_driver = &amd_pstate_epp_driver;
>> +    else
>>           return -EINVAL;
>> -    mode_idx = get_mode_idx_from_str(buf, size);
>>   -    switch(mode_idx) {
>> -    case AMD_PSTATE_DISABLE:
>> -        if (!default_pstate_driver)
>> -            return -EINVAL;
>> -        if (cppc_state == AMD_PSTATE_ACTIVE)
>> -            return -EBUSY;
>> -        ret = cpufreq_unregister_driver(default_pstate_driver);
>> +    ret = cpufreq_register_driver(default_pstate_driver);
>> +    if (ret) {
>>           amd_pstate_driver_cleanup();
>> -        break;
>> -    case AMD_PSTATE_PASSIVE:
>> -        if (default_pstate_driver) {
>> -            if (default_pstate_driver == &amd_pstate_driver)
>> -                return 0;
>> -            cpufreq_unregister_driver(default_pstate_driver);
>> -            cppc_state = AMD_PSTATE_PASSIVE;
>> -            default_pstate_driver = &amd_pstate_driver;
>> -        }
>> +        return ret;
>> +    }
>>   -        ret = cpufreq_register_driver(default_pstate_driver);
>> -        break;
>> -    case AMD_PSTATE_ACTIVE:
>> -        if (default_pstate_driver) {
>> -            if (default_pstate_driver == &amd_pstate_epp_driver)
>> -                return 0;
>> -            cpufreq_unregister_driver(default_pstate_driver);
>> -            default_pstate_driver = &amd_pstate_epp_driver;
>> -            cppc_state = AMD_PSTATE_ACTIVE;
>> +    cppc_state = mode;
>> +    return 0;
>> +}
>> +
>> +static int amd_pstate_unregister_driver(int dummy)
>> +{
>> +    int ret;
>> +
>> +    ret = cpufreq_unregister_driver(default_pstate_driver);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    amd_pstate_driver_cleanup();
>> +    return 0;
>> +}
>> +
>> +static void amd_pstate_change_mode_without_dvr_change(int mode)
>> +{
>> +    int cpu = 0;
>> +
>> +    cppc_state = mode;
>> +    if (!boot_cpu_has(X86_FEATURE_CPPC)) {
> 
> You can save some indentation by inverting the check and calling "return

Makes sense. Thanks!
> 
>> +        if (cppc_state == AMD_PSTATE_PASSIVE) {
>> +            for_each_present_cpu(cpu) {
>> +                cppc_set_auto_sel(cpu, 0);
>> +            }
>> +        } else if (cppc_state == AMD_PSTATE_GUIDED) {
>> +                for_each_present_cpu(cpu) {
>> +                    cppc_set_auto_sel(cpu, 1);
>> +                }
>>           }
>> +    }
>> +}
>>   -        ret = cpufreq_register_driver(default_pstate_driver);
>> -        break;
>> -    default:
>> -        break;
>> -        ret = -EINVAL;
>> +static int amd_pstate_change_driver_mode(int mode)
>> +{
>> +    int ret;
>> +
>> +    if ((mode == AMD_PSTATE_GUIDED && cppc_state == AMD_PSTATE_PASSIVE) ||
>> +            (mode == AMD_PSTATE_PASSIVE && cppc_state == AMD_PSTATE_GUIDED)) {
>> +        amd_pstate_change_mode_without_dvr_change(mode);
>> +        return 0;
> 
> This feels like you're duplicating your logic of your mode transition table.  How about having the mode transition table call the function for changing modes without a driver change directly instead for those cases?

Makes sense. Will add this in the table.
> 
>>       }
>>   -    return ret;
>> +    ret = amd_pstate_unregister_driver(0);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = amd_pstate_register_driver(mode);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return 0;
>> +}
>> +
>> +/* Mode transition table */
>> +cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
>> +    [AMD_PSTATE_DISABLE]         = {
>> +        [AMD_PSTATE_DISABLE]     = NULL,
>> +        [AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
>> +        [AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
>> +        [AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
>> +    },
>> +    [AMD_PSTATE_PASSIVE]         = {
>> +        [AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
>> +        [AMD_PSTATE_PASSIVE]     = NULL,
>> +        [AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
>> +        [AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
>> +    },
>> +    [AMD_PSTATE_ACTIVE]          = {
>> +        [AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
>> +        [AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
>> +        [AMD_PSTATE_ACTIVE]      = NULL,
>> +        [AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
>> +    },
>> +    [AMD_PSTATE_GUIDED]          = {
>> +        [AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
>> +        [AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
>> +        [AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
>> +        [AMD_PSTATE_GUIDED]      = NULL,
>> +    },
>> +};
>> +
>> +static int amd_pstate_update_status(const char *buf, size_t size)
>> +{
>> +    int mode_idx;
>> +
>> +    if (size > 7 || size < 3)
>> +        return -EINVAL;
> 
> The compiler typically inlines strlen.  Perhaps to make this more obvious what these boundaries are maybe do this:
> 
> size > strlen("passive") || size < strlen("off")
> 
>> +    mode_idx = get_mode_idx_from_str(buf, size);
>> +
>> +    if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>> +        return -EINVAL;
>> +
>> +    if (mode_state_machine[cppc_state][mode_idx])
>> +        return mode_state_machine[cppc_state][mode_idx](mode_idx);
>> +
>> +    return -EBUSY;
>>   }
>>     static ssize_t show_status(struct kobject *kobj,
> 

-- 
Thanks & Regards,
Wyes
