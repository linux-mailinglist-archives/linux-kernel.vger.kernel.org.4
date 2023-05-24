Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3705370EBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbjEXDBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjEXDBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:01:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B40DE9;
        Tue, 23 May 2023 20:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWCdZR+S670H5N74NZ9q3OXcdBpieYe9Lgf4kBDXlQpgRPQLeeznOzS7EiJj3FkbCVtpUBun5/AGZL9/1430r6QQbXGurqA17XFzNnaTtVe7pAKDg49dZ1mLU4Zur9ijXX9jzRGkXTSm06xrrBNVPzzqzTbFiy15eeXjuVvcaOwSl5cY5sxFRD1wUFmxF97kdWbSX6hn3J1FJQ9EMrTqejXt73ivW5sMtVWLa00O8rINwBOStHWC1ZS1suDyBEzazTQAk2rntYqxRL55N0IN5Y2ZXlXYD8RPC4ZLT18TZZ4sBs0TM5qx46hszB7iEfAgBxli3SkaaGHWfvCse9EkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQJM7QN8uItZtyrJyXltWRV2n5S/UKpRQFFk8XnrIDU=;
 b=Zbg+Dzsgiu6Ao/25xxMMRXeMmSiAimwd8/QQniLLu+Wme9Bjw3Vl3/jbUP7L51fuecWnDAcNn9OeslNDMY/mV4TYo3nPsgQbEabR3X+pkP4CCb7zUtTxUuc2EkZpG3e3ujefG+LGHd6IoZoJ9baIErEs3B3h2RZmxOQa4D5aMZkCfHFm53jD/5Y7Pr0KeXF6BKFDPsVUZK4IUxIcCG89mnV/ZCD2hzzu4D6d0nZT2RIjUWRJavCnso7qXwFhFXwdoYaTuvV2iiYdCSdHtqcrFgSv7l+JWZ5tcfHrPx0vDmPxzwHmlWWQgyFRITcrZbvyTkt95Ebslct3CFa125OekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQJM7QN8uItZtyrJyXltWRV2n5S/UKpRQFFk8XnrIDU=;
 b=bJEGaaNXZUISiq2it2w5xLGqICiuQjJw8ZWWrwlToTF07ZLqcXVQkXUPCYb5cWq/XDMctKjW1PPJbS67k/GbCuz6OQ6XWkXbjNq+uVCdEMgFxJmpkjRCkEfCZlzu+8fKXe+9/6SaMuO8qdQU4WcgIcWIPH84/B8HiQmZUXwt1DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 03:01:11 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 03:01:11 +0000
Message-ID: <3ebff16b-01ec-1457-7282-d54220382f98@amd.com>
Date:   Wed, 24 May 2023 08:30:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 2/5] perf stat: Setup the foundation to allow
 aggregation based on cache topology
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, ravi.bangoria@amd.com, sandipan.das@amd.com,
        ananth.narayan@amd.com, gautham.shenoy@amd.com, eranian@google.com,
        irogers@google.com, puwen@hygon.cn
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
 <20230517172745.5833-3-kprateek.nayak@amd.com> <ZG0QFGgwqv3GVsn2@kernel.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZG0QFGgwqv3GVsn2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: bc452c9b-518a-4aa6-7ece-08db5c032079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+eiJJTjoAau70QCtUhJc7V+A4qdjw49qHLI4dAtLlLg4Bm/9MMFbwGvuwmETKohLI8MHC+aF/ue/OeiKzM11OrqttmY0lZkb+KCb92tm/dofvDmJqSAw3zRhrx0wLADiuBsYnmf1qzEE1S63kQkQc6V5YZGzv16CO+yqavU8AvnZXqeMuUKzxGj2YKlACHLnIskV0nL9MTzDKID0xmZYFjDM6xATOlyFKouvmOccTCWRvHEbISli003gdzyYEI/0nZO6+ycvXSsNFDr/GSX1mxxMTAqsQ1ghKKHK8U399z44YvodMwt5Q/Sy0vBdk0Do/JCFj39oEMaYuroXfR+YeHaKQugp3S9RrBrpXC0yV4cX1x86VfbeRrt9JQeNtb12jKrIvIyQ/y2cu3VbGiXKMJ0S+DtSB5/CuSMjTUdsNQ6wrSzbKsAZ7V+T8OF96gqVeuCrjvC8RJj8GrGoTywBwFqQUHSUIpVdYe8edUj/8fXt4O94zqfkyCjiNnA2BJdYnfJLLu2JVpUPnTTBbImHBxylNonLk77xcyjFAoX7+BLFTvMw1trh43txE0c90P++pi5nZWyZW7bGgM0csM5LWMAY8rgyf0f3ZdQT5tcbyuMTpCKXFvIUr2PmBtgjSMleTMwHxbJpltGJx54n0r/RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66476007)(66556008)(31686004)(66946007)(6666004)(6512007)(6506007)(26005)(107886003)(316002)(4326008)(6916009)(6486002)(41300700001)(478600001)(8676002)(5660300002)(8936002)(7416002)(2616005)(83380400001)(86362001)(36756003)(2906002)(38100700002)(31696002)(186003)(30864003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZOY3hJWjZLUjYvNlV5ZnBBa1JlSGNmYVlWMCtNa3BQQko3WkRWYUxlckVa?=
 =?utf-8?B?QWRmVDJWdzlKZmRsNXRKNjJHY2xHdU1BNGhPS2t3ZHJwdXZqS2cxS2NNWi9O?=
 =?utf-8?B?ZFBsUk5MNGFMZ0FUclFsek1pN3N4c3NFUGw3bEJ0dUxnbERteE9XQS9JZFhy?=
 =?utf-8?B?QWZvemRVYXJ4YXQ0WUgwREdHK3h4TjlubzNrbWZZVERPdkxBVE9yVDhIRURq?=
 =?utf-8?B?eEsyRDVRcXhIQTRjNG1lRHhuZVFSK2lPQWlZdVVYRlUwTTgwUi93a1k3RDll?=
 =?utf-8?B?MXp4eHlNQTdTRW1MSW85RWNKZDNDdER0TjlZajl5dFcrcnF0NjBOUDNWY2V4?=
 =?utf-8?B?cjJVYjhPTlRzcFRZMi9rWWxoV0NVYTdMdkxHZVVOdFp1VzM1N3RyVnpxS2Jy?=
 =?utf-8?B?Vk1VNmk1b3FoZ3VvOGI4ZHFtZVh3a1o5aW9TWmpMZCtnYjRpQ2N5UG9pa1Zt?=
 =?utf-8?B?cURGeWxwMU1uYzVMVlg5Um13cTJxbHpjSExwN2dpTXU5eGhmTGRaa3hGNUpv?=
 =?utf-8?B?aVpDMy9CS21FditlUUViZGtkNDc4Z0paT0ViQmNCN2x2UHdTeGhkQS9wSENp?=
 =?utf-8?B?T0o4Wk10eUMzaVNsSmw4SmpGaG5SQW03UVh3bXBXSWdjU1VHSzBGanBtZzlw?=
 =?utf-8?B?U3JNVG5qVEpIMDJlc3ptVXhhWGdIOWlpUmM4WDBPYzRkZWVaZVRzSTAvUGRi?=
 =?utf-8?B?YmloVkp1VURiRmV3WGZ6STBYY0lDOVd6UjFTaWpINFZUU1g5Mis0UXBwRE9y?=
 =?utf-8?B?TVAzZnphMHQ4b1dPM1l5OVNNQ3h2UTZTbzljcjFaLzV0a25CWmIwZXN6ZmIy?=
 =?utf-8?B?dTNwU3R6bVB1TGJEcnRNWUNJMk0yLzZtVGtlRXNjQk8wVWdEUldBMGd0Qk8v?=
 =?utf-8?B?VlQzY3lHZEZTaEVoY2REOGNTeWlsVjFkdFJVOW1pMGtvNmE3UWdrZ241YUFW?=
 =?utf-8?B?Z1NsbVoxSXBwdUU2YUs5Q0R2NHRtcFVXNWl4VU5qd3dSWENyQmtHQ3QraTYr?=
 =?utf-8?B?WWFKL2RVL1NPOUFyY3dBSThIZG9DM0hySHdGL0xONVNLcTVwWmtXOTFkdVVJ?=
 =?utf-8?B?Q3JoTjJ0U2RyekVCUitPa2hPRE1xZVk2dGNZZk1Nd3hkYmtXcGhXRWlVcno1?=
 =?utf-8?B?RVBKUzExejNRZVlHcmV5TkNXVzlrTTlQNHVqYVlTN0ZHL3NlVENkMjhVOS9l?=
 =?utf-8?B?Rld4Q0s4SVMyOFZYYk5tQ0NpUjc5SWZzTC8yb1pVcXZuU0o4b095RlNYdEc1?=
 =?utf-8?B?czA2NXAwbllwSEl1cmxWem9ma25Da0VCeDNzaG9kaGlHVkhCVjE4L1hHcDhM?=
 =?utf-8?B?TnVVS0wvVkZEa1FBQit3dEd1RHQxVzBGQ2tZU0JoTVdpSitqK3V5Z0RranF3?=
 =?utf-8?B?UjhYVUZVSnlaVEwxN3JrVjV4V1N6QWFEUGpLbHNqWmphTmdXY05PZFZEMlNX?=
 =?utf-8?B?ZXQ0bXdrcjRvczZuZHU0WkkycUFSb241bmc4SDVEU1ovdWs0ZWx0emE1aWhG?=
 =?utf-8?B?bHhhK3RvYXhwZ0ZraDBMWWNjdG95WXhUcytjandnNDNocWhNSzBmdDBEQTlD?=
 =?utf-8?B?WEZWclZkYWlTQ2hJMFo4Zm04ZHBCeVdzdytmbDVlL24vYnpMdis0WTRVUXFF?=
 =?utf-8?B?aHU2QmtjUjdFMEVoejNOS2dMdFpuRkplOFVEbnl3Yk5WTEk1TjRsNnFFWjlE?=
 =?utf-8?B?VWEyZG9tUUNOUDBQRS9aNUcwYmVJWnIyd1lZRmRSSGdnRXI5aW5kbDVpMGph?=
 =?utf-8?B?enNBcHVtQ3Qxb25MRWZiVWd6VVpiVG5qd1RIV3lnVHVhL2E4Si9sZTIzTUhl?=
 =?utf-8?B?YUIxTzZlK2VZZi9wem9NTTdYUDdIM1YzaHZLODBVMFRNSDNBZkhDYnhEdFhW?=
 =?utf-8?B?Ni9tOHVISkFWY1FlUjBsQ3VNa01vMkJOS1dXdVd2MGtndWc1ck44TUNWb3ds?=
 =?utf-8?B?MXFhRjROL29KOXZyQUtGOWlkM1VpVzNuZE00eWFwdFlubi90TmhybGFzNFV4?=
 =?utf-8?B?dnpMY1N2M3dqNFNkUEhrRHlrVE1uWXdaS2pBVXBTeTFXR2l6VVNpekd2ci9w?=
 =?utf-8?B?V3F5K1lhRlA3V0tCVHE0OVdhUiszQVViUWdtZlhvYmptQlVueWp2aFdSbWVl?=
 =?utf-8?Q?NMGCql46SkTVdUlycFEJ2XK7e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc452c9b-518a-4aa6-7ece-08db5c032079
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 03:01:10.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDTMYtbksiNKIuvUqgItF5qjZuvOrW8ioVwOzIb1uH4YQCmdfqSI2nxdhdjuvArbOcLS6MHX1jfrWPG5cuBlSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo,

On 5/24/2023 12:42 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 17, 2023 at 10:57:42PM +0530, K Prateek Nayak escreveu:
>> Processors based on chiplet architecture, such as AMD EPYC and Hygon do
>> not expose the chiplet details in the sysfs CPU topology information.
>> However, this information can be derived from the per CPU cache level
>> information from the sysfs.
>>
>> perf stat has already supported aggregation based on topology
>> information using core ID, socket ID, etc. It'll be useful to aggregate
>> based on the cache topology to detect problems like imbalance and
>> cache-to-cache sharing at various cache levels.
>>
>> This patch lays the foundation for aggregating data in perf stat based
>> on the processor's cache topology. The cmdline option to aggregate data
>> based on the cache topology is added in Patch 4 of the series while this
>> patch sets up all the necessary functions and variables required to
>> support the new aggregation option.
>>
>> The patch also adds support to display per-cache aggregation, or save it
>> as a JSON or CSV, as splitting it into a separate patch would break
>> builds when compiling with "-Werror=switch-enum" where the compiler will
>> complain about the lack of handling for the AGGR_CACHE case in the
>> output functions.
>>
>> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Changelog:
>> o v3->v4:
>>   - Some parts of the previous Patch 2 have been put into subsequent
>>     smaller patches (while being careful not to introduce any build
>>     errors in case someone were to bisect through the series)
>>   - Fixed comments.
> 
> So I had to make the following changes, added this explanation to the
> resulting cset:
> 
>     Committer notes:
> 
>     Don't use perf_stat_config in tools/perf/util/cpumap.c, this would make
>     code that is in util/, thus not really specific to a single builtin, use
>     a specific builtin config structure.
> 
>     Move the functions introduced in this patch from
>     tools/perf/util/cpumap.c since it needs access to builtin specific
>     and is not strictly needed to live in the util/ directory.
> 
>     With this 'perf test python' is back building.
> 
> - Arnaldo

An oversight on my part. Sorry about that. Thank you for fixing this and
picking up the changes :)

> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 68294ea499ae51d9..0528d1bc15d27705 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -150,7 +150,7 @@ static struct perf_stat		perf_stat;
>  
>  static volatile sig_atomic_t done = 0;
>  
> -struct perf_stat_config stat_config = {
> +static struct perf_stat_config stat_config = {
>  	.aggr_mode		= AGGR_GLOBAL,
>  	.aggr_level		= MAX_CACHE_LVL + 1,
>  	.scale			= true,
> @@ -1251,6 +1251,129 @@ static struct option stat_options[] = {
>  	OPT_END()
>  };
>  
> +/**
> + * Calculate the cache instance ID from the map in
> + * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> + * Cache instance ID is the first CPU reported in the shared_cpu_list file.
> + */
> +static int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
> +{
> +	int id;
> +	struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
> +
> +	/*
> +	 * If the map contains no CPU, consider the current CPU to
> +	 * be the first online CPU in the cache domain else use the
> +	 * first online CPU of the cache domain as the ID.
> +	 */
> +	if (perf_cpu_map__empty(cpu_map))
> +		id = cpu.cpu;
> +	else
> +		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
> +
> +	/* Free the perf_cpu_map used to find the cache ID */
> +	perf_cpu_map__put(cpu_map);
> +
> +	return id;
> +}
> +
> +/**
> + * cpu__get_cache_id - Returns 0 if successful in populating the
> + * cache level and cache id. Cache level is read from
> + * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instance ID
> + * is the first CPU reported by
> + * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> + */
> +static int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
> +{
> +	int ret = 0;
> +	u32 cache_level = stat_config.aggr_level;
> +	struct cpu_cache_level caches[MAX_CACHE_LVL];
> +	u32 i = 0, caches_cnt = 0;
> +
> +	cache->cache_lvl = (cache_level > MAX_CACHE_LVL) ? 0 : cache_level;
> +	cache->cache = -1;
> +
> +	ret = build_caches_for_cpu(cpu.cpu, caches, &caches_cnt);
> +	if (ret) {
> +		/*
> +		 * If caches_cnt is not 0, cpu_cache_level data
> +		 * was allocated when building the topology.
> +		 * Free the allocated data before returning.
> +		 */
> +		if (caches_cnt)
> +			goto free_caches;
> +
> +		return ret;
> +	}
> +
> +	if (!caches_cnt)
> +		return -1;
> +
> +	/*
> +	 * Save the data for the highest level if no
> +	 * level was specified by the user.
> +	 */
> +	if (cache_level > MAX_CACHE_LVL) {
> +		int max_level_index = 0;
> +
> +		for (i = 1; i < caches_cnt; ++i) {
> +			if (caches[i].level > caches[max_level_index].level)
> +				max_level_index = i;
> +		}
> +
> +		cache->cache_lvl = caches[max_level_index].level;
> +		cache->cache = cpu__get_cache_id_from_map(cpu, caches[max_level_index].map);
> +
> +		/* Reset i to 0 to free entire caches[] */
> +		i = 0;
> +		goto free_caches;
> +	}
> +
> +	for (i = 0; i < caches_cnt; ++i) {
> +		if (caches[i].level == cache_level) {
> +			cache->cache_lvl = cache_level;
> +			cache->cache = cpu__get_cache_id_from_map(cpu, caches[i].map);
> +		}
> +
> +		cpu_cache_level__free(&caches[i]);
> +	}
> +
> +free_caches:
> +	/*
> +	 * Free all the allocated cpu_cache_level data.
> +	 */
> +	while (i < caches_cnt)
> +		cpu_cache_level__free(&caches[i++]);
> +
> +	return ret;
> +}
> +
> +/**
> + * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, cache
> + * level, die and socket populated with the cache instache ID, cache level,
> + * die and socket for cpu. The function signature is compatible with
> + * aggr_cpu_id_get_t.
> + */
> +static struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
> +{
> +	int ret;
> +	struct aggr_cpu_id id;
> +	struct perf_cache cache;
> +
> +	id = aggr_cpu_id__die(cpu, data);
> +	if (aggr_cpu_id__is_empty(&id))
> +		return id;
> +
> +	ret = cpu__get_cache_details(cpu, &cache);
> +	if (ret)
> +		return id;
> +
> +	id.cache_lvl = cache.cache_lvl;
> +	id.cache = cache.cache;
> +	return id;
> +}
> +
>  static const char *const aggr_mode__string[] = {
>  	[AGGR_CORE] = "core",
>  	[AGGR_CACHE] = "cache",
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 88d387200745de2f..a0719816a218d441 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -3,8 +3,6 @@
>  #include "cpumap.h"
>  #include "debug.h"
>  #include "event.h"
> -#include "header.h"
> -#include "stat.h"
>  #include <assert.h>
>  #include <dirent.h>
>  #include <stdio.h>
> @@ -311,113 +309,6 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
>  	return id;
>  }
>  
> -extern struct perf_stat_config stat_config;
> -
> -int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
> -{
> -	int id;
> -	struct perf_cpu_map *cpu_map = perf_cpu_map__new(map);
> -
> -	/*
> -	 * If the map contains no CPU, consider the current CPU to
> -	 * be the first online CPU in the cache domain else use the
> -	 * first online CPU of the cache domain as the ID.
> -	 */
> -	if (perf_cpu_map__empty(cpu_map))
> -		id = cpu.cpu;
> -	else
> -		id = perf_cpu_map__cpu(cpu_map, 0).cpu;
> -
> -	/* Free the perf_cpu_map used to find the cache ID */
> -	perf_cpu_map__put(cpu_map);
> -
> -	return id;
> -}
> -
> -int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache)
> -{
> -	int ret = 0;
> -	struct cpu_cache_level caches[MAX_CACHE_LVL];
> -	u32 cache_level = stat_config.aggr_level;
> -	u32 i = 0, caches_cnt = 0;
> -
> -	cache->cache_lvl = (cache_level > MAX_CACHE_LVL) ? 0 : cache_level;
> -	cache->cache = -1;
> -
> -	ret = build_caches_for_cpu(cpu.cpu, caches, &caches_cnt);
> -	if (ret) {
> -		/*
> -		 * If caches_cnt is not 0, cpu_cache_level data
> -		 * was allocated when building the topology.
> -		 * Free the allocated data before returning.
> -		 */
> -		if (caches_cnt)
> -			goto free_caches;
> -
> -		return ret;
> -	}
> -
> -	if (!caches_cnt)
> -		return -1;
> -
> -	/*
> -	 * Save the data for the highest level if no
> -	 * level was specified by the user.
> -	 */
> -	if (cache_level > MAX_CACHE_LVL) {
> -		int max_level_index = 0;
> -
> -		for (i = 1; i < caches_cnt; ++i) {
> -			if (caches[i].level > caches[max_level_index].level)
> -				max_level_index = i;
> -		}
> -
> -		cache->cache_lvl = caches[max_level_index].level;
> -		cache->cache = cpu__get_cache_id_from_map(cpu, caches[max_level_index].map);
> -
> -		/* Reset i to 0 to free entire caches[] */
> -		i = 0;
> -		goto free_caches;
> -	}
> -
> -	for (i = 0; i < caches_cnt; ++i) {
> -		if (caches[i].level == cache_level) {
> -			cache->cache_lvl = cache_level;
> -			cache->cache = cpu__get_cache_id_from_map(cpu, caches[i].map);
> -		}
> -
> -		cpu_cache_level__free(&caches[i]);
> -	}
> -
> -free_caches:
> -	/*
> -	 * Free all the allocated cpu_cache_level data.
> -	 */
> -	while (i < caches_cnt)
> -		cpu_cache_level__free(&caches[i++]);
> -
> -	return ret;
> -}
> -
> -struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
> -{
> -	int ret;
> -	struct aggr_cpu_id id;
> -	struct perf_cache cache;
> -
> -	id = aggr_cpu_id__die(cpu, data);
> -	if (aggr_cpu_id__is_empty(&id))
> -		return id;
> -
> -	ret = cpu__get_cache_details(cpu, &cache);
> -	if (ret)
> -		return id;
> -
> -	id.cache_lvl = cache.cache_lvl;
> -	id.cache = cache.cache;
> -	return id;
> -}
> -
>  int cpu__get_core_id(struct perf_cpu cpu)
>  {
>  	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 1212b4ab19386293..f394ccc0ccfbca4c 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -86,20 +86,6 @@ int cpu__get_socket_id(struct perf_cpu cpu);
>   * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
>   */
>  int cpu__get_die_id(struct perf_cpu cpu);
> -/**
> - * Calculate the cache instance ID from the map in
> - * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> - * Cache instance ID is the first CPU reported in the shared_cpu_list file.
> - */
> -int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map);
> -/**
> - * cpu__get_cache_id - Returns 0 if successful in populating the
> - * cache level and cache id. Cache level is read from
> - * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instance ID
> - * is the first CPU reported by
> - * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> - */
> -int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache);
>  /**
>   * cpu__get_core_id - Returns the core id as read from
>   * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
> @@ -140,13 +126,6 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
>   * aggr_cpu_id_get_t.
>   */
>  struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
> -/**
> - * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, cache
> - * level, die and socket populated with the cache instache ID, cache level,
> - * die and socket for cpu. The function signature is compatible with
> - * aggr_cpu_id_get_t.
> - */
> -struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data);
>  /**
>   * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
>   * populated with the core, die and socket for cpu. The function signature is

--
Thanks and Regards,
Prateek
