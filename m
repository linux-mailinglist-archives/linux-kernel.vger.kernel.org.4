Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0464B29B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiLMJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiLMJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:46:18 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102F1759B;
        Tue, 13 Dec 2022 01:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0qWNjZUrcs6G+hxt4uLh6lBCrAR/enFK/A7XvFmDcqRIAEfh84t+bCpu0QWMCR3OXbEZFNvsrwBd0B/DR8EoS/vg4ec2/aaFltskOPyMCGE+ePkLHvrgGsjSap+LforjQeW+JXvxUaRtWCb0UeRDvaWDsC54djnwGPr/uCaL/9tzyhOHNotbwG0EnSbhadpHbU+6uLAAi4oL5K99AEm11Xa/1XC58NtDRpfTRQDvVlNOwcvX1DyHdm8TRPsn69BCk8TbIldKwjI52fEsfFDLbul69SdSBDROFuSArSpdz4NJ/si73vdd6WkTP1wKD/Crfqp3ps73wD5AVmf2wuEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YfmTS32oy5417CDdfqeCk10Hkxy3K4r1RmfEGbJ04g=;
 b=bPw5BumYy1DKQXeussFhksx1Q7rAlhkOADNjuE4mIkGHhkYeqkY5e2BeJ9qt4V2xS+LRGfPxLvD5E2jTbTxSNZ4LPtmMR7LXwAw5U5RatgnEl5yVqB6bx24nblW866MtAmR7uQ+GWJC0oc0Jled3cTspeYnIrVfB2QtEYPvuW/vDxd2frFr9x9A4ATEne8/EgetrJNCrqKx851dzQiwtk7cIoH0e2jGruM20qOk/Dl/HKiXzIy9FD7WlgrW5XC6JogHz1xyEIapgB2W9QXgFRx7TDRq2KXdMNnq8J6sYUol3DmB8QXlnQI+0dzE6hsSaWjoLgYuUVagE0Tyk864o3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YfmTS32oy5417CDdfqeCk10Hkxy3K4r1RmfEGbJ04g=;
 b=nUogewElSVD6u2EYK5RqNMuqubDbtzWMb2w5GYdN/hheEz/fEh61QVROifPVQOO+EVmRChodQ5sZQKXUE8ateYLzqCZTLeTthMUN3CPCevoU0f7Lqlag1QdptCMyuB1mhpt7xnj+AGfuL3yDHuB/r1gdT99MnDTOyghG9OPnCV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:46:15 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%3]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:46:15 +0000
Message-ID: <bec28fc0-0148-f792-6491-60d6acd2c64b@amd.com>
Date:   Tue, 13 Dec 2022 15:15:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] perf vendor events amd: Add Zen 4 metrics
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
References: <20221207053007.336806-1-sandipan.das@amd.com>
 <20221207053007.336806-5-sandipan.das@amd.com>
 <CAP-5=fUyG07H1w6pV4bne=mZfwx+OMr+KZRNOOE8stJuiDPUCw@mail.gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fUyG07H1w6pV4bne=mZfwx+OMr+KZRNOOE8stJuiDPUCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::21) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: e92e450d-a5ff-444d-abd9-08dadceedf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWc9aqzd0wwJcQN8iTQsX1dfx8Z0kCqeS0l/mLkFNGPuvO4LKzdnDZnqNdNC8JFZjhF0TSF5y8KFqPhRwQuvRgSVvh+JLYGTualwDJz8iTFt05vYIdl3V6h2BUk5RpMHq/PyiMcdh6o9hiReUf1sCyFAsYe8jOoHNrxA4+Uvdy0WVE/CW0vQJ2LwVTEFDO501s/sgv8MSB5f3+MCC7sUmK/RLe2S6AF+f0+XHHUNi9vFGewFhspc0AOqCjo+q/UhCxQplfPauqeNKQEfZ2jeTahU9L0NEG+YJYxFW2BFIVWY+xiPAMN/5ddtrWCU+wi26YI+v5el42Ae5aCEzAWXduiuFi5WQ63JiMDtBvY3AWo68+h3FvmRi4egL+i0MQs57uLgLjVV2B7y1tB0a5QG1mp5IHVZQbrI5/CJAraoY2dhFWz72IgJ4BaqXENsqTe4BXcyDgj5+fpmckUxlA4dwqYYPv4X0Gwlfd9djLp8+AVK2DsdEyFodHhUXNRczy8kSY1aCfAmn9KRbfgeXpkSUaulFCzTVYIM5CkRz0wOMoIF2InLuH4LZsum1NQ534972WNztyqNbpYkiLZYM9v39Ttf9ucsjq/7Qt2/vpA/M7cM4+gBBM1aekqo7A8X41aMmyC8FVrhJZnv73JJc14028pAnqv4Bf8cWTRCnRGwe8mhWuTZGUewTNZRnDgDAscg2T9D4NJBiUPYPes53P2NSohOEpPO008sJttYWKQUhHQ0L+n+PfvmnV8ZBgxguQV18MiOsw7O6xV/lUoViPX8qxQkLDnAsekipX5fWvK+YQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199015)(16799955002)(38100700002)(478600001)(6486002)(966005)(2906002)(2616005)(53546011)(26005)(6512007)(6666004)(186003)(6506007)(36756003)(66556008)(31696002)(7416002)(8936002)(44832011)(31686004)(41300700001)(4326008)(8676002)(316002)(66476007)(66946007)(5660300002)(86362001)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWduOUx1b3NtQTI1VXo5SGNudDc5dmVUcWRLZDhVdytURHA5Yk9CT2ROamV3?=
 =?utf-8?B?ZXAyKzdVSkxjdDcwV1k1clZzaDN4TWRreVZMd3lOUjJoTlhqQ2taMUFTcFF4?=
 =?utf-8?B?V05saVB2UmVFMG1FWXZYdDJwVFl2YXEvWmpBT0ZTN2NsWElQb2tCa1dMbnFZ?=
 =?utf-8?B?Q2lmQjJKRmN1eUhFQmtudVUrZ1NFNHFrVmVMdU5VdlhoMUpieEZneVBrcHJC?=
 =?utf-8?B?dy83WW9jMDBPZWdiNGxjMzNNL2hDV1pTQ2M3NDFVdEhKZ0xHOHl0dnk0OTVP?=
 =?utf-8?B?cUM3VzRwY3ZsWUFoaU9WU2hjRmZ1UUVTOGRVaE5wQ29oU1pOQXc3WnJZdlY1?=
 =?utf-8?B?eG1Rb2Z0NmVtdTVEcm5xTXFJY0YvTms0TWJLMy9YREhxVEUyQVhWTmQ3VEVG?=
 =?utf-8?B?VjV4Q2ZhZHRaRllqUTU3TWpOOVhGTC9XRVE5MXJYakcwOEsyRlFXVG1nQVhG?=
 =?utf-8?B?ZzVzWk1NUkpaekoydkpRTDdFVG9taXc2TTJDNEw5MHhacHJHTktkRzFWY2ox?=
 =?utf-8?B?cWpSSURIWGt2V0pzWUZlK0QvdzlGTDg4enY4dEM3VDM2czVQelRNTEJkQ00r?=
 =?utf-8?B?ZUFSdUNhamRhZHlOSGg4TER4d0Y3b1AxL1N6U3VnMDZQUGRpOTdXZ0ZnZlFG?=
 =?utf-8?B?VUxRUHF4Ly9QNVFsTzBWajNDdW40WEpCLzNXcEtjUkttNXNJQWN1dnFWMDJ1?=
 =?utf-8?B?Wmo4d0hyYUFDVTF5Mlk3eVEzOGtKb3NadjFOaU4xNXpKZDZSSlVhZXNNNFZi?=
 =?utf-8?B?ZHN5THRqYzRXc0QrYXdJSUZrM3owSll3Y1FJUmxxL3dIZXFIK3VjQitEM0Mz?=
 =?utf-8?B?R09WVVVyeHdSb0M2bG5JSE9ZY3V3TW9rNHJFN1B5V0Nsd1BveUZDZEtMUU5H?=
 =?utf-8?B?VG1ZNCtrOGVSNU13M2FaUFdYTEt0ZXQzZk5QaS9YY2p0M0dnWTVzQXZGcEpp?=
 =?utf-8?B?dHp5djBGT0RUMmVoanBHYW1tSjJjSkhjY1p3N2Ficmh4U3BZSWg5aGNLWG95?=
 =?utf-8?B?ODdiZ0xmQktGeDJuOEtqNDNmUElVdld1STYrSm5zclRRZHllWlQ4TFpwZHVP?=
 =?utf-8?B?MjJ3ZTB5TEFPbDFweFV4alJNMVNOdU1pSVI2ZWlOR1UxVE5uR0w3S1VVbXlB?=
 =?utf-8?B?ZkN1OEFoVU04S294QThKWHd4eGhBN1lZMTdnSVp1bDcrRVZUa1grUUxRTWhy?=
 =?utf-8?B?N1YyVzhURHd3Ty9MYW5DdkRzY25jWGFwZDBOQktxeTczVysyYlBqRWFDV1Vs?=
 =?utf-8?B?dGIySnBYQUpjSXBwc0ovS1dvZjc4bzhVam5jdEJEUVFmeDVBSDIxVVB2d2FE?=
 =?utf-8?B?TXBmcTExT1J1ZUVTU3JNUHdlT0E5RVdDeEpUWENvL1dhNExCVmwra0VhWXEv?=
 =?utf-8?B?UzlNSnRTV0owZmVaRzk4ZmpHaEhib01XbXRkQVhnbk9NU29XYkJNaTUzN3Fs?=
 =?utf-8?B?eEt6S1BDa09XY3RDbkJoemR6SFFyWFU1c1laVHFWQTZ4NUlWWjJsS3I2UXVE?=
 =?utf-8?B?TmRXVWlFSzZrWTZpYThPek9XRjYwTU5TQTdTVS9HM3pWQ3R1ZG1KVG9WK1BE?=
 =?utf-8?B?VEI2T0VHRkRWRUpXazVMNjR0ZXJvMXJzMHkxNGlib2JteExhSWFyNFpGL1BO?=
 =?utf-8?B?TCtiZzdTM0NNMzZwR1lVSVBtRWRFNmg1MTdJdUpsR2ljbUV2cWMzdklPN3la?=
 =?utf-8?B?aFhEcGRnNUJxS3Z5YmJPc1FVclU0cldMMGl3c0RYNGJVZlEwOWFZYmdiaXRW?=
 =?utf-8?B?Vnh3OHJDTjVnRHVjZWxNYVRaRzhvZnI1S0ZhR0l2SkxrQzNrRHNQWUNHVWRW?=
 =?utf-8?B?T05DZ295aVVYNjVnSEQ3OFUwYzFkTU4yTWt5Q21kRW5tKzFrMzZDOEk5QW1P?=
 =?utf-8?B?L25yVm9wdnpUSnJOejJnM1dmakU1aExvRXorS1lTRkswOG4yV0xEQ2huVWdB?=
 =?utf-8?B?K0lnRlZKZCsvclNhcHRVT3A1Zk5mWS9uQmlna3VYVzFnSXNFUFNwS2ZTM2tO?=
 =?utf-8?B?aUVnUzBqVXZQOERqTHN1ZkpNWm1WTVUwVTMxVFRjc2ZkUFppQ0dLSVk1MVF1?=
 =?utf-8?B?UzJQTXM5clFjQTZkSkdkQ0QyNGFnWmlEelZqN2NIWnJmaHFWSVBRcDJubDA0?=
 =?utf-8?Q?NrU/0diE9Y7HMw542PeKciJe6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92e450d-a5ff-444d-abd9-08dadceedf98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 09:46:15.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuMogzEBuDlOjfSAk4HxUKOWHXqD/zvX59zqvzFiNr5J83MvikL7kvvgArwmm3Ihv3Equj0X0s5uBJ+ScfiKXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2022 11:14 PM, Ian Rogers wrote:
> On Tue, Dec 6, 2022 at 9:32 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Add metrics taken from Section 2.1.15.2 "Performance Measurement" in
>> the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
>> Revision B1 processors.
>>
>> The recommended metrics are sourced from Table 27 "Guidance for Common
>> Performance Statistics with Complex Event Selects".
>>
>> The pipeline utilization metrics are sourced from Table 28 "Guidance
>> for Pipeline Utilization Analysis Statistics". These are new to Zen 4
>> processors and useful for finding performance bottlenecks by analyzing
>> activity at different stages of the pipeline. Metric groups have been
>> added for Level 1 and Level 2 analysis.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  .../pmu-events/arch/x86/amdzen4/pipeline.json |  98 +++++
>>  .../arch/x86/amdzen4/recommended.json         | 334 ++++++++++++++++++
>>  2 files changed, 432 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>> new file mode 100644
>> index 000000000000..23d1f35d0903
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>> @@ -0,0 +1,98 @@
>> +[
>> +  {
>> +    "MetricName": "total_dispatch_slots",
>> +    "BriefDescription": "Total dispatch slots (upto 6 instructions can be dispatched in each cycle).",
>> +    "MetricExpr": "6 * ls_not_halted_cyc"
>> +  },
>> +  {
>> +    "MetricName": "frontend_bound",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level1",
> 
> It might be useful here to add the metric group TopdownL1, there was a
> proposal to use this with --topdown when topdown events aren't
> present:
> https://lore.kernel.org/linux-perf-users/20211214184240.24215-2-andrew.kilroy@arm.com/
> We also describe topdown analysis using metrics starting from this metric group:
> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> 

Thanks for the suggestion.

After looking at Section 3 "Top-Down Analysis" from the original paper [1]
on top-down analysis, my understanding is that a specific categorization of
metrics is expected at each level. E.g. for Level 1 analysis, the metrics
are "Retiring", "Bad Speculation", "Frontend Bound" and "Backend Bound".
For Zen 4, an additional metric here is "SMT Contention". So the pipeline
utilization data has information that overlaps but is also different at the
same time. Hence, the classification may not strictly adhere to the current
notion of top-down.

[1] "A Top-Down method for performance analysis and counters architecture"
    https://ieeexplore.ieee.org/document/6844459

>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "bad_speculation",
>> +    "BriefDescription": "Fraction of dispatched ops that did not retire.",
>> +    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "backend_bound",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of backend stalls.",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "smt_contention",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because the other thread was selected.",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "retiring",
>> +    "BriefDescription": "Fraction of dispatch slots used by ops that retired.",
>> +    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level1",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "frontend_bound_latency",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
>> +    "MetricExpr": "d_ratio((6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
> 
> From:
> https://perf.wiki.kernel.org/index.php/Top-Down_Analysis
> perhaps this should be in a group "frontend_bound_group", to make the
> drill down more obvious.
> 

Agreed. I'll try to keep the group naming familiar wherever possible.

>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "frontend_bound_bandwidth",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
>> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x6@), total_dispatch_slots)",
>> +    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "bad_speculation_mispredicts",
>> +    "BriefDescription": "Fraction of dispatched ops that were flushed due to branch mispredicts.",
>> +    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + resyncs_or_nc_redirects)",
>> +    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "bad_speculation_pipeline_restarts",
>> +    "BriefDescription": "Fraction of dispatched ops that were flushed due to pipeline restarts (resyncs).",
>> +    "MetricExpr": "d_ratio(bad_speculation * resyncs_or_nc_redirects, ex_ret_brn_misp + resyncs_or_nc_redirects)",
>> +    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
>> +    "ScaleUnit": "100%"
>> +  },
>> +  {
>> +    "MetricName": "backend_bound_memory",
>> +    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls due to the memory subsystem.",
>> +    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
>> +    "MetricGroup": "pipeline_utilization_level2;backend_bound_level2",
> 
> Similarly there could be a "backend_bound_group", etc.
> 

Agreed.

- Sandipan
