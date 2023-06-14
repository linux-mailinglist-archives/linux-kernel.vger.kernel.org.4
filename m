Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1772F309
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbjFNDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242121AbjFNDYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:24:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022CD198;
        Tue, 13 Jun 2023 20:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbQMr8zBTlIBJx/4BYg2eLcRdlgbLfalhJL0jReWSqvC5qLGgx+EohzXDEG9VAklNiYFdL62i0JnwT+qWKSxmdufMCJURFKG/T1rhevUr/Rfwb4qghX63CMTvK5Hec8nm64u1uRWwYh4QecmSUcAGoUpgek6pabGHar1NN7K4XWSh3a0L+dfsBbnGX1W7iux43ZqGPPjv/MjQ+tkloFwyGuJpoti/BYT8gBoYDKYKpf/jCpRCaplDC9idldbf5kK3p6gFcGZLTC+XZb+lxryK+kyXJivRaHqbeG5d9Viq4VzFk2Gw9XSgvHVhRJf8qa3I134+eHbI1Xxne+veuOL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9i8qpMF52D3C1GsgnB1xh3gH4Tpj3N1PJiDd6r6VVWM=;
 b=gr6V3NwhSxKKUjLrV6meSKy8rK5jMM2dYYvmweeqlXv3hrWqtc9ol7h4MU4HeZdCHtEVAKmC5/kAd3Kd8iHQsIoUiIUFD/RIKBfmHcP0X+gGeYxywxy+zaxKUslFnHYS+lJlNRqiD9totjUEFJzlhgl+u7J26kthAsUOBjMTMPrazW7PoDSoBT8JZynqGSnMVuA59BA/Xo30YRegqtvi0OSsBmaarXD+x6QXfXFz/rc8O/KITMhbaPt/Uw6iTaei5tVbqdfKp079AhzXpNloTyEuumPBjNJq33C/k0Pb3MnKUZsu5efbsDkh7NR7rdZfSl15TUmsvKe+Bq0fsm1+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9i8qpMF52D3C1GsgnB1xh3gH4Tpj3N1PJiDd6r6VVWM=;
 b=nen3uY57LeNVoenPSgHuIXok5Uj08Ws80TQXX2YEwCLjkfCdtBH14SMk1FaFUOmbnju1xAZQQxUJL/4dArV3WaQ2WLM4g00iS8AWGmN6rbWGithtYo00fugwMrSnSlk+chMVkHEx685jSgvp0/Mvgq2zV91foH2vPZX+Rbx4f+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 14 Jun
 2023 03:24:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 03:24:09 +0000
Message-ID: <60477a13-1b8b-5aad-b635-73b9d8e3f734@amd.com>
Date:   Wed, 14 Jun 2023 08:52:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] perf tool x86: Fix perf_env memory leak
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230613235416.1650755-1-irogers@google.com>
 <ZIkShy2yj1b0+GDv@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZIkShy2yj1b0+GDv@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad2196b-4644-44c5-a17a-08db6c86d0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDZzpS9qi5xG0hK+fn94FU7HUH1/KsTY9S3+GAXRGQu8XVTifp4C5jAAp7HyMstzbblHXb1NwFAPCHNmGcneGD8rStYdqj8ww+9U1w0Ac1eTT74aAr0yPnkpzaoao1g9VydK8AX7H0BAwUDhMRX0d7h/t4wJQtA53pNyqMRXYEcELxNMObGWpgGh1KNbfA2jnwVrOCjwFbfV/XrlrsMNB5i5R4tc7DwQherBA/4dK7oOv+jlvkvH7yLLc8xW1XcvvmWU/+3e3tcSeHRFgwS2oRQRHtom0NnGPP5e4eNr20aCgdwWfw71rdjCn5ou+3dm8E2kN4GjrYLBEUhind1DK05NClfGaE83y9hhRJqrqCchB65UU5llpVZx63lfICIp1waLUqbrhg7qJVIHBg5PB2ca9s4KoUmiwgzKCZo62KVQu4zkjYg/gxJlCVPx/sYPI1lkdwY6PjdA78n8csZN7QNjRIFG+l3oKE1kaVsFuXb461x3iLSqpuKU++O6d0EtIWGYQ3aJzUdVen1JVteuV2ju0L1Km4W5FBAU1QR7SjAoEQ+FZADCix/gsYU/lweJQGCRKLS+PeNNY6plX+nSayAjXIXYy64a9S6YxJ3cs9HY2oMsApA15IAJof+sjvY1C1FIJQm3T9hGQklJcJJ9Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(6486002)(6666004)(66946007)(41300700001)(66556008)(2906002)(66476007)(110136005)(38100700002)(5660300002)(8676002)(36756003)(54906003)(44832011)(316002)(86362001)(31696002)(4326008)(478600001)(7416002)(8936002)(2616005)(6506007)(53546011)(6512007)(26005)(31686004)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBEYm05TE9jenNVOGtubXNqM0hobVcrQXJzVGhJV25XaDhMT2RiZW0ra2dC?=
 =?utf-8?B?VzloTHh6a3lxM1Zyd1gvR1pDNVBwcXp4THkwRTZmTERJYmZlbGE4OGJDVmRS?=
 =?utf-8?B?azcvSnhTMUxqQVhzcjY2SzRwdGMzeVBVdFdGMHFsUTZiRkNDVzFrVFZzUnVG?=
 =?utf-8?B?MzNVVHlBTEM1dk4yTGpENTdVeWdZR25WcldHSkNEQldvTnRuQTB0d0RRYlli?=
 =?utf-8?B?ZFlNTXo2TmJYNDRRc2hhaUdLUStiRlJTbkNuRXgwd2RYWXc1NWxDa2htNlVT?=
 =?utf-8?B?eHdOTmZiVGtuUHhFOThVN0EzK1ZmaHVWSVFUekZRV0FOTkJLNXVpSURSdE9P?=
 =?utf-8?B?TmFSS2d4b2cxSlo4bXNmd3h0djdoQnQzOW1EK0dEdXRnWjNtOElHRlFESkFU?=
 =?utf-8?B?dE9xSjRnalpHY05tYWlyUnFWdEVpbm9iQUM4OUFkbkIycjkwMkNSUnRmZmZO?=
 =?utf-8?B?MlJiTWlPRHhiU3FrR1V0cHNTMEVpWWVBeGh3WG1xdmo0NWhTKy9sNUdMSGYx?=
 =?utf-8?B?WGlVS3VyMTJNWmYzWjJYNVNRVmFTTk44TjFMQ2VyNFpRRXhKeUl3OFJvb1ZH?=
 =?utf-8?B?dEJPWXhDeXRDRWhDUTRjb2pHbFl2TkhTWU9OTmxhQTlsdi9mZ0gybE0veUpQ?=
 =?utf-8?B?MjdyeWY1VUdiRi9Db3JDZzZWT29EOU9jME1WdWc0V0pPQWd2dnZQNGFZdk9h?=
 =?utf-8?B?WW9MbFdmVXpuZk9lRVdGQzBvMGZtdndvYVVXM3N5TkI2SFJ0RkJGOU93UVZw?=
 =?utf-8?B?WWg0SzZUaXdzd1ZxTjZHcXdxQ0V6dVdYd2NZTzFjYVdiMDBsbWhVdlRVSENY?=
 =?utf-8?B?TExiMjB5THY1VGVYaEs0b3pFVkJkQ1BJaVJaYmtKS0luTVFJTWNDQkdzNmEx?=
 =?utf-8?B?a3l0OStBRGdYbkZuL0wrVXlQL1VVVFcvYmJUMGFMTmw4ZGVjQ2NyOVV4WTZt?=
 =?utf-8?B?aUd5d0V6UlRIQ3ZRVEVYMzAxdWljZTk2NUxob3ZtaS83dDZiY3hkRXIzYTFl?=
 =?utf-8?B?dVVkdEFFOXc2K0pEaFozUmxFQkp5M1QwZGMzbkFkZjNORjVRNWp2NDZ4aW9k?=
 =?utf-8?B?UENqY1ZMcCtpTkJBNmZwcWpjOWpCWmR2UFlGN3RLTml2L1BnVUh6N0YrN1Ax?=
 =?utf-8?B?UG9rcW0zTHpETWlsSDNjWnpHNXF6SUxSdnhYVVFIckg5MDJBY3NYVXkzQ0VI?=
 =?utf-8?B?enh3bHBweGJPa2lndTlvdmdqNTFDdUhFZVN3ZjBVdGNqa0NxTmFBb2JLaG1z?=
 =?utf-8?B?R2FITEJyZjRSTFZlWU94UWlmYVR4M3pXa0FVWEU3empLcCsrVTJzdi9GNDZJ?=
 =?utf-8?B?Zk55dXdTWXpsNTN4RkRGdm5DSDArNFp5YmpXQ2d5U3FTYlg2aXhnYytFcVU4?=
 =?utf-8?B?NXB6N1BxWnVIOFViM0pZZ09BeUl4SlVYRW9NS3Q4bGpDVzZEOTRHTFBhbTBW?=
 =?utf-8?B?RWt1dVBjWVlSV2dEM012MGRQbUh4WlFsbU0yQVlwZzBLeFVWSkZLWm1yQUhq?=
 =?utf-8?B?OXhDNi9BNlluS0liT1FNbkgvdjJFQUozSDRQTkhKYllQYzgxSTBCUCtoMmM0?=
 =?utf-8?B?emRCSU9iNzdteUVPbDNUZE5sTi96ZTFCcDM4WW0zZkpLdkd0QVV3T2NMZ2hU?=
 =?utf-8?B?dDhwSTlwV0J5L1VlcWpIdWUvWlFVRURMbGVsZGR3ZkQ1dU1obnJsckEvVGoy?=
 =?utf-8?B?S29RdzBDdXVUT09MR2JxZWpzMXZBQWJoNk9WS1lwMG9WTXF0T1k5SkF1OG9R?=
 =?utf-8?B?bnJKcGdzakRZWGJqVytsbVZnZXpPSEtNU01TU21OYWsvM0lrVmRzdFFwYjFE?=
 =?utf-8?B?NXNISThHY3N3K0xyUWVwUmZ0UEFHZ3E0NlpkUzMrdzhrOHVhWkNqNmFZZTY3?=
 =?utf-8?B?K0YzNUlhdklQUFBiam5sdUpmcUlvbW5KTzcrS2pOTVFCQ3lkTDhoSFZZc2Ny?=
 =?utf-8?B?dFhDNnlsbDFRLzJCZHN3L0N5ZE04OW11T2hJSk0xcFZPZUVKUHdodG8xRUpV?=
 =?utf-8?B?Wm5BSlJWck5sNnpCZ3BCZzBtTzFWZUtNcjdnYXhqWGhwVldiRUJoQjlNSmNP?=
 =?utf-8?B?V2Rwa0hQcTJrU0R6bW81UWI3UVdCdzhHcytVMTBqN0JIRVFTQ0x6U0JMaWEz?=
 =?utf-8?Q?FnAInfLyareJ2mfD9IzGvO/G8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad2196b-4644-44c5-a17a-08db6c86d0cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 03:24:09.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U894kpKVJk6oIJXuRFHy8ymOh0V+3eZ1uEveEO7alkcK1VOAoWO43bQ9HB4mw5s+uYcyLoiBbEhAMI7IeCPcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

On 14-Jun-23 6:36 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 13, 2023 at 04:54:16PM -0700, Ian Rogers escreveu:
>> Found by leak sanitizer:
>> ```
>> ==1632594==ERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 21 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
>>     #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
>>     #2 0x556701d70589 in perf_env__cpuid util/env.c:465
>>     #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
>>     #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c:83
>>     #5 0x556701d8f78b in evsel__config util/evsel.c:1366
>>     #6 0x556701ef5872 in evlist__config util/record.c:108
>>     #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
>>     #8 0x556701cacd07 in run_test tests/builtin-test.c:236
>>     #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
>>     #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
>>     #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
>>     #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
>>     #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:377
>>     #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
>>     #15 0x556701d3c3f8 in main tools/perf/perf.c:537
>>     #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>>
>> SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
>> ```
>>
>> Fixes: daea405f5f06 ("perf tool x86: Consolidate is_amd check into single function")
> 
> Its a fix, yes, but it is not for this daea405f5f06 patch, he just moved the
> perf_mem_is_amd_cpu(), that was leaky, to a different file, the fixes is
> for  for:
> 
> f7b58cbdb3ff36eb ("perf mem/c2c: Add load store event mappings for
> AMD").
> 
> Right?

Yeah that's correct "Fixes" commit. Thanks for the fix Ian!

Ravi
