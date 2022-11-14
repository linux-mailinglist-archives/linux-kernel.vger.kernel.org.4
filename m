Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC47628C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiKNWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiKNWaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:30:20 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB21570E;
        Mon, 14 Nov 2022 14:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJUIwBybi94fEjUF/dTzsy3JFnCtUtF/c2l9gnfYX9wjubMEnOZtd/He+zZNBloL1K98tpFtsyMvFPHmIpYMpy2egX2yxm/FwhmwdnjkNBMR7MA25uvgk1IZf+ff+h5e0oOCH9VcfqWb0Bnf/t5CTOcPDen51xc+8NaIfi+Qt+ievX0qE/gxpzMviOWr2Nd1iYBuxdy96EyitssflCNVi4UyYsTBDx2Fn1k7p2aK58lLcA5zMGWX7Rcks/zU484kIIlJ9QEpHl947ro4kgnJGa+f56KKaFcS5uFh9Kzua3Q1d1eUhqnMYTnbMOxHW0mIbpVA2abkpZEGvyVlrCS96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IYQ6WWjF/Wb4s6XrIXiuWhHpQNPzt6dh2pvZiJi8CE=;
 b=gH95JjUmiOVTamUUjv9xTTN/F7yhfbhZkTAsu2qx8QKXMM4vWan3EuI8lrZTVEMlY9fRSNSz4/afmauQVhr4RXgU41kR3uFg40Sg54netTdUUT/BuCfdQNDWY2A/Csd93sPty72DWNvjNLcGS5pBEizSVP6qhNpPZezrjGEFEvP1ZE9yw/DW/THJQbvAYsoWNQZWm6XWg0dQKuLmrW5qv/UwsQfrr6I6CzINLP446EUntldfARJJZuVSEJTJd6rPaijO3tyeRfZ665+SKp+KrRjHekwDm/XCRXmOnyCrdsPDE/e+4dTvIP9/9vA8h41Quq51UzV5VZtNTiAjr/erog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IYQ6WWjF/Wb4s6XrIXiuWhHpQNPzt6dh2pvZiJi8CE=;
 b=G2yz9hT+fJM+bh6th+0Llu5Cxg8nPvKK+OlujPXUuONEgexIydBztPL2MC82Zw1FqFV5k5yZNYFAISqpfi7E38n6+Yor+gWvhtFV8aYQzZlz4eysNNvcdKQYaCBMHwU7B6v4HxFMaN8kHWzpA11dvNArI7xhsLAyxzhLZrYwInU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 22:30:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:30:14 +0000
Message-ID: <873c17ad-0a7f-f3a3-0bad-952739d9b394@amd.com>
Date:   Mon, 14 Nov 2022 16:30:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 8/9] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-9-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221110175847.3098728-9-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:610:77::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6c3961-787f-4fd2-ac57-08dac68fccab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFZGMX3gwqL7xmO1FUurx9G6ufhvY1us79MEKjgW7YskKbCu+wg68F5sa6U+8wNFJqz/h1z0iSxfbN5zoGswCxPoAQsmh2CRWFBCyfeilGAi8eSQTvbxMUtds51/3b8gmQMcaiB1oEhelEaqPQshIfnVZnWYyhm76oe5vp0CvpgtlVrIrSOqxv3TN+daCLfufB8droe2AWGnKl6jy2UDl+cY+YSkawPSs/CNGKNB1J7ZG4Q1Oym+OKpykRacSRR9CQ2AzjAHVZF3vv92yUtmnOatSXdKJ6Q9pomuhu5Z7scWsuQhrI6TuverBWch1FTyeOljlaX3F58aKZyO1m+KAUFFRslcHJPonZc/jHl528PiycQ8kILelinUOaCoFbTkFymoaIEJyVvSwl4BcDZBNl4sPB9gLFoy2cOagRV7PVLasTRAayXPt/nhswe3Xee91a0lQnuGcyT40txXT8oUrtQsRaNkIT2+Butp/bbeORPBe7vzvQjqBF+G4QdzmpnH0ThEPcwUNJRmrbSfCB3u4D9Mf6XkEkeIzOTeSzaFN96Ms3oO73tc6DpqAU4rikZmxEatHFGX+90/F7qqzjybTdkOIFRQLjM9BQJx3ua6WYijUnu0mw+BbtanL0K4kkc4oIOjvMlSkhWaeEhD+KOHByxSB6fzDYYuN2S/vs9WVmAofR38jAM5t9WLmjpqmOGiaZ4sGD1oxVI7gFtBu3FXBcSpGBsFSc21HHMzJeTWXtjjJNXr0VLkdEnXGNwY3b/om69pb3wM00tmrFIzq3KFA6KySwh3kkPlOI1fdsCApgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(5660300002)(2906002)(41300700001)(8936002)(66556008)(4326008)(66476007)(66946007)(8676002)(316002)(36756003)(6506007)(53546011)(6666004)(478600001)(6486002)(31686004)(86362001)(186003)(31696002)(26005)(38100700002)(6512007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXdBN1VxYTh4RS9xNWtNZUZpbFVOT3RaTWJMK2lpZHdCalVhOEtYMXVkL2gz?=
 =?utf-8?B?N2tONmh4TG1MMjZFdXo1SzZndS96Vm5CaUpQNlRscjN4dU50RVNWTWZNWm5m?=
 =?utf-8?B?azdIVFdnS0MyLzNPem1DOUkrdnFWb1pHT0F2Z0d6eGhtSmdJb2xidzZhSlRx?=
 =?utf-8?B?QmJJYWpWYnliTHVsZmJoZm1TdGxvWlpnRERablIyeFQzcy8rS3Q2enVHZkJG?=
 =?utf-8?B?bTJSZmNPY2tacElQRjVPY2w2MnNjbFRSOXF4Q3ZCd1Z6c0l4bE9qZUgxVndF?=
 =?utf-8?B?UHZLMkhPYVdYMDZFR09yd1V4eU5lZ3lZaTlYMHp5YWFrZ2pTRnAwVHd3ZjJ3?=
 =?utf-8?B?cnVFcENnWmhTbzVTUFV2MHhGbjdjQnd0SmhiU3pCbWtpL1JmbWlUNGMxTHhD?=
 =?utf-8?B?ckNmWiswZGlQRTIvcURkcEo1NFpnanAzdjN0T0tzcTU3aE9WRHJlZjJ1K2FL?=
 =?utf-8?B?SXZDM0hqYnRJUWRuL1Z2ZmhkRkhlRitudWlTZ3BxUjZiWWFDZVdGMDQ4SGlS?=
 =?utf-8?B?Mm5wTU00VnZaSStTNEdOSDlHZXZ0TW9QZWs1ajBDcmMrblZtWWx6UjRhS3cz?=
 =?utf-8?B?MU41NFFpdXlzS1MxZXhLV1JYSFl3NDQwNGFnZjZ2T2tIOXlJQmFMTFVrZlVM?=
 =?utf-8?B?U1pBV0kxbTd1NG5SOVVmaUQxamROOS8xSlBmMGkyMGoreWJ2MlhBeTNaM0hY?=
 =?utf-8?B?MDR1a0RmSzhIbFYyZkZROWZEd2lxaGpNSWU3bVVFbEVGNGgxbjR3eklJaGdp?=
 =?utf-8?B?czhTbnozRnBHS1J4NUNINXg4K05JSXFvRXpXQThSSmNORVFWS2VIbEU2TVhH?=
 =?utf-8?B?eDlhQXpqQWVaUFZIcXJlc2E2eTRMR1hLTmJmNG5iREN3VnYrYzZtc3JUVVAw?=
 =?utf-8?B?R045NzZwMC9ZNVdrU1FvTDQ4Q2YrSHl0Slg3VHlDUHZRcjY1VlJZSXJHVjB3?=
 =?utf-8?B?dHRWcWZiSUx2NWZDRWxpYWJsL3A5dThTVEF5aXdhNVVuZUZvZkt2MGRMTmo3?=
 =?utf-8?B?R0ViK1BPbXo2R2lOSkdWK2xkVHpWL2x0T3FyL0ExT09rQW9ndE1nRWpvVUwy?=
 =?utf-8?B?ZDMvNm1QSWlMWmlEZmc2dlhRZFBWTlhwcU5HakljdEFFZ0JabVREUC9kZVhO?=
 =?utf-8?B?ZEFOSHpPWnhNS09IVWpseGtBL3UveGxTdlhFalJGWnlNakxVK0JDVGRaNDF0?=
 =?utf-8?B?ZW9kcWMyUkQ4dHlPK3kyM2RPc1BqUE1jUTRDbktmcE5sOWxHbDdlT0ZsMHZI?=
 =?utf-8?B?aDVJLzQyekVFRnZkM0hqWUhveXo0eFYzYXdJRFJTSmczM09VYTUrRnFQY0N5?=
 =?utf-8?B?ZHA4YnZLNG1Hd01PQzZqbGlrRERXakk2a1pGdWJZOCsvblZ5L0crTlk4bk9Y?=
 =?utf-8?B?WmF2cjNHdWM3WTFMQkJoTG9yWWxzblB0Z0lXODdLTjZVODI3Sy9hNENWOWxx?=
 =?utf-8?B?QWcvZGtJUFB1RjF3WGFjYjZiQXBNSTVzNDVLWUNMdTFCb21ick5SY3I3Q2M4?=
 =?utf-8?B?MlR2MkcwbVdsTXR2VjBQb3R2OEFCcWlFcEhVeCtTTTlOc1IzSk1XblhmenJI?=
 =?utf-8?B?YWl1bkRvamtoZzJpWmhRd1hjS3MzTVI5LzZIbHBZNjlNREhkUWJ4MFJCT0Ns?=
 =?utf-8?B?M0lRbU9BRVE3V1hFb1FuVnVtYTBKbDhMWGxVMWxNcXhxRVA3RTB1QnpXanln?=
 =?utf-8?B?Q3lIMTBvOWEvREc3Z0RicUtkczI3TDdwZTdoa2JqYnBHYlF2cXFjZUlzYWR6?=
 =?utf-8?B?RDRuMUFZb0wxZEVwRTdYVkdIU2tJZWNNelBEbzUzTDZCdG1KSlNSNmd1aXpN?=
 =?utf-8?B?TG0raTRmcE5CVk5oTVhxcnVlcUkrT2RVSzY4emkvY3Q4K296N3NEekt1eFMx?=
 =?utf-8?B?c1dnU21RVzN3YThYSW15NzJnalZ4N0ErM3Flb0RPRGdRZGxhSWZtNHRxeVJm?=
 =?utf-8?B?T1I5aEQxUVl2NWFQc2VIY2dKYytWcjAwdEFBalk0ZnUvVkRnK0ZkMzBQNFkv?=
 =?utf-8?B?WVF6clBMdjZSL0lseGZITUtoalB3UGhnMUZZR2tYbXdKcXBkb05rRjlkVC9h?=
 =?utf-8?B?NkJEK1dYVXlJZzY0ZGhHOFNuWXFJSmgrTzREd0tUbWRvc29GU0Z1UDhGb21X?=
 =?utf-8?Q?bsq49mwr8fXQ5BdEo7hmG5xmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6c3961-787f-4fd2-ac57-08dac68fccab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 22:30:14.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwPx5ZWU14HLR/mbkSY5DOmeQ7CNYaXKteuNJm7GCTrT4KFaKTo5/1Etu0QAahz4PgEV0Rh+0ONkO7UHU2f/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11:58, Perry Yuan wrote:
> While amd-pstate driver was loaded with specific driver mode, it will
> need to check which mode is enabled for the pstate driver,add this sysfs
> entry to show the current status
> 
> $ cat /sys/devices/system/cpu/amd-pstate/status
> active
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b71bfbbb7639..6a3b610cb084 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -65,6 +65,8 @@ static int cppc_load __initdata;
>   static int epp_off __initdata;
>   
>   static struct cpufreq_driver *default_pstate_driver;
> +static struct cpufreq_driver amd_pstate_epp_driver;
> +static struct cpufreq_driver amd_pstate_driver;
>   static struct amd_cpudata **all_cpu_data;
>   
>   static struct amd_pstate_params global_params;
> @@ -798,6 +800,46 @@ static ssize_t store_boost(struct kobject *a,
>   	return count;
>   }
>   
> +static ssize_t amd_pstate_show_status(char *buf)
> +{
> +	if (!default_pstate_driver)
> +		return sprintf(buf, "off\n");
> +
> +	return sprintf(buf, "%s\n", default_pstate_driver == &amd_pstate_epp_driver ?
> +					"active" : "passive");
> +}

For new code I believe you should use the new helper sysfs_emit() instead.

> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	/* FIXME! */
> +	return -EOPNOTSUPP;
> +}
> +
> +static ssize_t show_status(struct kobject *kobj,
> +			   struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_show_status(buf);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	ret = amd_pstate_update_status(buf, p ? p - buf : count);
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -805,6 +847,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   define_one_global_rw(boost);
> +define_one_global_rw(status);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -824,6 +867,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&boost.attr,
> +	&status.attr,
>   	NULL
>   };
>   

