Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234DB6F4202
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjEBKw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjEBKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:52:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98F4686;
        Tue,  2 May 2023 03:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsJ//6XchCACDSOX+wA9+KuV7gR3HfuU4yaFxEMXswJY7lHBS2lpdDJzZdiPm9yAABWV2oaUHcbjiCKFwTU5mwEb28rc7KjMgPecozry/ifxXes93LTNxwMwZX73i5iJWUswTZIa/hH4Gc/I6K/sA2lxWc8pzG/9W6yjs6YHv13Crqy7tyLsY4ERK6WdlUG+GxYA2nUPM+AHXWXycm6jNknxO27/paFbMq1tdkuGQeMgazZlymBwnBywdoH79Uz1TwRtB9JCdIq9+712l6AMMBXSAPmgfcTjz0dbY63wGmSm9vi5J685hsDXmR1tn0mjBfQQoLX0V94KF3NCR6IUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3GamwK2l3w+XKJmOZnjsU14jmVIzvEfdJ/r95wQ8SY=;
 b=VHTx2dThYgg9BZHhuDDxCAH5flk51NXuvcfTTLTSQ3me+lerW1fF6km/kiXPBz4CHscBIt97PE3j1XRRQb7bEhRcxMTJyp95IoS6loAX6Pf35Pqs79gwC9/G0bDRI4X8H3UFNYIUQsy+nBBg71iXXk/FWm8vBixSIWM8yDQoK76g8xWvDhLCROW9hePlqrbWWxd2YkhE+wTqd2nq9fDwX0ex3NKY7joTRTFERYAECKJze8eiVcmLRZpeYithgFeAvB9AD/Djl0BTimXM6gOupkL8s8RrgsV1Tf9NtQ/zgpJ3e+Jv81lW/FjajeMu6Nbjju6Kyg3dOi5f5vGKFPNvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3GamwK2l3w+XKJmOZnjsU14jmVIzvEfdJ/r95wQ8SY=;
 b=gQgRdY5SfHMG3+hYn+DvD8I/5JA1HX05hCunwsZ0MRsZ/ddr4CXSamP3u+MT55jgM1CJdLwOdNAnza4YueZONEtX2ID2KZLPLnR0y65PB/2N7Yed5PXhjctikOg/fVO9bVbL/JYYzdpbz9f7PMjWbxGsPwAX6aHryaiYWg5htc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 10:52:14 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 10:52:14 +0000
Message-ID: <a5153c87-044a-655d-acb4-aff9c33ab686@amd.com>
Date:   Tue, 2 May 2023 16:21:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 32/46] perf stat: Make cputype filter generic
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230429053506.1962559-1-irogers@google.com>
 <20230429053506.1962559-33-irogers@google.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230429053506.1962559-33-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: ba186619-0b95-49fe-0dbd-08db4afb4a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ygio6Xwf9O79Kiv7QnD4tn2RWPGcA0oGGSzYTPcyf9dmtqG+BxveKNWkIMW04cpqY2n4nErDFY2SUkwJ0Q17DuzPJ9fT532UoWBsQBRgYafPfFmoySJ2SdQUmfnLSITxTD04DUntoCknDLnKSQhVBNW9z3xXm7w3HAL8L6q43J/l69ggV4sA0OyubMkgUtYNOtoDHvnsCcImzLAsUTCvqt4wHZk0KgKBAPa0mqYfwzR7M7PmHII58aRlxi2dlMag1SGXUu9kuAx0dI4esLXVfoUm3hAEO/Jy9aEQkf1T1jkQWQKk+grgCbX6KekJ8MGgUOoMTHOva2PrcakJPWF06wuA4JeLJyWb8Br1IkpXjqmE+kIyP1iTY52lubS5z529+CY5tTOByOoNbZZ508wFuzz3TqAvFEFsAiG1cuZyIX8ow70CdqNlzCUPVrlqEwubzwkC368nIhRhJXoMvVFkOBl+/JkLDVhywr/DfksaHqRhrUWp9rbWenMEUJ5ccYjCiFP9os1fMwV1DdHsO/d32zVn19Na0uAPamze3mgLNN1rLEfGfVrgogOoJbgVdyPGkqZ8JdDsMim4QoeGTsW7Y20n2Gp1+EtxNP7z17MWLhAnOdrfCs432R4EKRPpO13+mBeyjLD55hVnUcuAikxMyFFj0j5fZr3tcmX6RKND4NrzKQP7euLTXioKvDh7A+7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(186003)(66556008)(66476007)(66946007)(921005)(316002)(478600001)(6486002)(110136005)(31696002)(86362001)(36756003)(6666004)(6512007)(26005)(6506007)(2906002)(2616005)(38100700002)(53546011)(7406005)(7416002)(31686004)(83380400001)(5660300002)(8676002)(44832011)(8936002)(41300700001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxMbDJMUVJqMFZIRUU3emMyRUxSUmhoTDdBeDhHdTJLYlg5WEhyQ3BJT0FD?=
 =?utf-8?B?eGxYZzZveGlaVWRFeTBtNUZveHFDTHVwMzNXTU42Mk9ndDlnYVpTSzQ1S2tG?=
 =?utf-8?B?TXd3a1VlRXB6aHUxSCtuSUhjak1sNkNCK1owL1BwY3Q2Vlk5cWxFemJHc1cv?=
 =?utf-8?B?U3JyU1RudGNrenJDZzgxd3lwYTA4Zm9XK2x2MCtPT3E2cXBsOUtDNjhnaklD?=
 =?utf-8?B?Szk4VFlsclNweTN6OE1FUmczalRpODNhVnJjOXpDUmVvSWQrdVY0bmZTK3dP?=
 =?utf-8?B?MEYybEdoVEpDNzlzR1Z6N2MwYVVZdnh4MmVoTG90aGxtZDZ3QXcwK2tZOFJ4?=
 =?utf-8?B?UjE1bU90aXZiaWJ0Wko1STUyOVMwOHFLdEdRWTlBQWZEazdFUi9RZkYzY1pp?=
 =?utf-8?B?bXJBVjFxNlpUMVhzTU9CSDMvY2ZvT0ZRVEdHUVVlZnZHRCt6UUdHUzc1Z04w?=
 =?utf-8?B?SUY5Q084R2NhK09xbktBQkNtc2o5dVZDcm1qNEczeWdWMTVlV0VYVm01aDNx?=
 =?utf-8?B?TzNaa0o3SzhVN2N4c0JUU2d2Q3JvV3BoMGhMSzFETlFRQjFjZzBRUENUS0tt?=
 =?utf-8?B?NC9heXoxZktVRUMvQ1JIV3RJWS94ZFNwbUZ1SDIvMkFHM2p1QkVNR0NHT2lh?=
 =?utf-8?B?RUlpTXZwQTE3ZlFzNEdVTWk5UUhLMDE0dG9NWnErTHRKUE5BSG40cjEwNFp5?=
 =?utf-8?B?S1lzUXU0Z2JQRGNHVjA5dXVaOUE1d0MrQXplT0RSYXI1ODY3WXE4bTd3eWt1?=
 =?utf-8?B?c04vZVVPeFIvOVhDTFN4TGxvL2sveVMwM0JMMk1QR0g5ZG9UbWxTWXBvUWZC?=
 =?utf-8?B?NUVTb2hWVWFDNTVaRFV4Q0xGOVorT2FhbmtidmlFcVZWNEE5OXZuRnZjUThr?=
 =?utf-8?B?U2ZEeEF4T3ZvMnBUc0pFcVk1amErbnhVVlhTS0RVeWxpZ1h3dHJpYTBHR1Fh?=
 =?utf-8?B?Rmsvb2lwcElMR1dwMlFqY1cremxoTW4rcUtrTnNKWS91TFREL0VkRTQ5YlVh?=
 =?utf-8?B?dllwVGF5SldWZWt1MFMrM01iSjVyb2FSUHpLSzJVVTl0NDY0V0M2akhwREpW?=
 =?utf-8?B?aHFOdkpDS0RybWNYVmFZU1Q4SE9SWUxGR04wRUFtNW8wOENVWmM4c2tIdXhQ?=
 =?utf-8?B?Nkp2V0pScDVJMk5qMFl5SVVXb0VmSzZJd1FNL29jbFhhai9NSkpmM2V2a1Jl?=
 =?utf-8?B?VEdON0xCamVBVnJCWXdWNmhnTjM3enhPR0hjV1VlaE82YmVEUy9UTkxRcEVp?=
 =?utf-8?B?ZUM5QzZqZldwQitWdjJpOGsvQllXZ05kYVRlWTdEeWIyOVNuUVZOUXhJQTd6?=
 =?utf-8?B?ZldQOXFOTUE4MXREbkpwdnloS0J1dGoxeGlid2c3Snlrd0NmbGVyVmNESURC?=
 =?utf-8?B?RzVXbzRWVmt3SUx2NS83WWdkcENvT2hrQ0NFa25ZVnBrMTN4VjQzaXI2bmU5?=
 =?utf-8?B?RlNaYnIxaEVzekdCT3RBS2NkMHZaZFdPR21uK2l6T2w1QXZ6U2NEZjlvSGwy?=
 =?utf-8?B?K0hsdkEySFpUeVhWTE82UkNQMnJUMGZ1clJnSk9UR2YwSGl2WXZhZXNJSTBl?=
 =?utf-8?B?OW5jM0dwTkJGNG0rdWYrSncxSHA5SURQaXVWWkU4cXROclB3Rzl4SUdteXp4?=
 =?utf-8?B?b1JHV1dha0tNd1ZZTzdkK2xVMXRxRVhwS3I2a0duUnB5bmIwV1BKS2FHNWdP?=
 =?utf-8?B?QXpvcm9idVRSajYwNWpEZHcyMkNGdkpxOE1nWWRlWDArOTVCTW9YOFlNem55?=
 =?utf-8?B?akdPZzVsQjN3TGR1enltZlQ1ZzhvUGNFdlhYUVRtc0lOeTg5Z0hBOEVlVE5L?=
 =?utf-8?B?VmVwU2p0WmhsN1M2WHRva2lCZC9wOE83UkZ1alVTSjBpQU5URWxtcUNvdURD?=
 =?utf-8?B?L3hwSHIvWjRiTjZqQ0Fzem9Ud1FZNHVwMW5BbCsyWGpKYXM3dDlGa0tYanQy?=
 =?utf-8?B?eXdhNmdzV2tLWXNqcFlWWU11SngwS25yN1JPZFhhYXIzbFkzb3VETTRLRDgw?=
 =?utf-8?B?QVdUS1QwOFNSYzU2R1FXeTFHTzhHMEhJZUhjUGxBR0dyUE5nQnFTOWpKMjVF?=
 =?utf-8?B?REpxd0JZbEs3YVBXeWk1WUp6Y2M3bGtiUFVCSnM0aHpGZm5qb0NTRno1aWNr?=
 =?utf-8?Q?3IdBNloqhKkgL7B6aNOckNTZJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba186619-0b95-49fe-0dbd-08db4afb4a04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:52:14.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7x8+XOpvyaKDiBeiNm8UsRzb6GeDWRU1JOesEGYOs/TeY9C5a7RAgvluU6i+JKe6fcpC/l8heDEWP0gs+vdi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Apr-23 11:04 AM, Ian Rogers wrote:
> Rather than limit the --cputype argument for "perf list" and "perf
> stat" to hybrid PMUs of just cpu_atom and cpu_core, allow any PMU.

I've couple of doubts:

1. Can you please explain intention to do this esp for perf list. Since, IIUC,
   `perf list --unit` option provide the same functionality.

2. Since we are already specifying pmu name for non-standerd/arch-specific
   events like `pmu/attributes/`, I'm not sure where `perf stat --cputype=pmu`
   is useful. Can you please explain perf stat usability aspect for non-hybrid
   pmus.

3. What am I missing here:

   $ sudo ./perf stat --cputype=amd_df -e amd_l3/event=0x4,umask=0xff/ -C 0 -- sleep 1
    Performance counter stats for 'CPU(s) 0':

           108,267      amd_l3/event=0x4,umask=0xff/                                         

       1.061290167 seconds time elapsed

3. Also, IMHO, using --cputype option to specify _pmu name_ is bit odd.

> 
> Note, that if cpu_atom isn't mounted but a filter of cpu_atom is
> requested, then this will now fail. As such a filter would never
> succeed, no events can come from that unmounted PMU, then this
> behavior could never have been useful and failing is clearer.

I'm hitting a segfault if I use non-existing pmu:

$ sudo ./perf list --cputype=random
WARNING: cputype is not supported!
Segmentation fault


> @@ -443,8 +443,8 @@ int cmd_list(int argc, const char **argv)
>  			    "Print information on the perf event names and expressions used internally by events."),
>  		OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
>  			    "Print deprecated events."),
> -		OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> -			   "Limit PMU or metric printing to the given hybrid PMU (e.g. core or atom)."),
> +		OPT_STRING(0, "cputype", &cputype, "cpu type",
> +			   "Limit PMU or metric printing to the given PMU (e.g. cpu, core or atom)."),

man perf-list does not describe --cputype. I think we should add it as part
of this patch?

Similarly, man perf-stat also needs to be updated.


> +const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (!strcmp(pmu->name, str))
> +			return pmu;
> +		/* Ignore "uncore_" prefix. */
> +		if (!strncmp(pmu->name, "uncore_", 7)) {
> +			if (!strcmp(pmu->name + 7, str))
> +				return pmu;

Any specific reason to ignore "uncore_"? IMHO, ignoring prefix of some
pmus and not of others is bit confusing for naive user.
