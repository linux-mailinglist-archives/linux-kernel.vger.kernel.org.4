Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E54728EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjFIEBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFIEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:01:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE2B1BE2;
        Thu,  8 Jun 2023 21:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stvu6lncDWwHpwbLhvD7z2SPiJAsW9YVImdRFRt90CnkfY7UKkK9cax2cZn3q3z9kkef/iTeg9ZlSa/7xOkp+fHOfLc+nmfIAyk0xFe9Lww2IrtXlqBXPGhZk9K/6RD+t1wvLjX7pcBzQMMiw3IjuXiRbm5oNX8RwLiJhqhrs389jV1p3TU22oBBOpqq3kqqA07ZReSijLi0KUt83PI2p3pmC0lMTNIINnbB4GpHFQ/0iiHswu8uvc7/y9JKQNtfF++V/j8zyJbIZUxPOhiGWIGkImcfUPbgxJGgrezzMMQ/eP14oS1uQDYNI2hZusoo6BCyMlPzBJ5GoTGsECk+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZY7YPoKwUWamgZwXyjbWIGAEOG6C3UIlBxPcernnS4=;
 b=J1Jr514wXrf0ghd3CPDMCI8BcTJ1D+FV8w4EwIVLlxtcuEMOqqJK/Bonn0pMx21hXdDf7ADzCx7EiikyaAmra6Ury0Aa8QMMe6yWVa0Dy15Xd0c3dUta94mQ/LNPI+YeHJcO46IEjZrdp8Jk9jTFvKjMHvNZISBnwSjwTdZfJTiJlhxn008NOTwVJHIPg6ni2qSv+eNHnaE1eC/a2FEw8Wj3REXOqp3xD2OpeIzB7cK9+51qObKd3Y0EnaY9jQ27JxLspq1SAu0Nf0lR43iF90IGHdzo8tgqoY3BY22JX9ldfwOlhYim0ARuilEBxmpPC2UOaw0oZbppFODoGRdXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZY7YPoKwUWamgZwXyjbWIGAEOG6C3UIlBxPcernnS4=;
 b=43MRyyiAFUAHG9Akp/2jd+F4o/goXhQcymf/dSTQI9pydxcmOWs8WnLHIPvMcSOlTXoDiqSbYW7dR+Bh6ssr3hYX1YRIiguZNP3C3AFmR0jB3GBcXoTMbsjRWFXW6RxvpE8Arf5KzJdE8/dOfGZu3ovjO9qVEOXlCdFzpEMRSHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 04:00:57 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 04:00:56 +0000
Message-ID: <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com>
Date:   Fri, 9 Jun 2023 09:29:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
References: <20230527072210.2900565-1-irogers@google.com>
 <20230527072210.2900565-29-irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230527072210.2900565-29-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d77bf3b-7688-4f89-81f3-08db689e2054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ls+zu6hYa6tBe+61r+sjG1ZGSeoZgxqgYVq8RxWGv12TpWYrGwWDLUZQkrhlyhtTkjEPM0xNLxw5MRDMCc7cfQMnMKF4YT47Bz8CkxW6n4S7/DqZQNzoxuW1ZYB3sDB02/HKbYHp1LvbeUWsKe6MZOcJDus56oAlHnoB6FIkm5/AsNbtgMR+y9ZtI2be05V1p3yoIFy2mHlVxCyrT/jbDSB+ZKj6b95H8tipVWof1I5ZAm+xKnDgQu90HioaK71OGdIbeYxgwX9z2LcrWGE+cZRLiWcq24d7kiD9bnn8GJ94bav+pqg3yYvzgS9cLrYZeeSK6E9d5B+IewX0ZA3At8my4/9Qulm3pJwlE15ejFqy+jD8yftBErrWuSbmgQLdHmzBWmQdAMAET9TzRIA3/bT/rrWZ0+MuQ68HpainlRBKQ1N/dx02JhvTK82KZnn/oO71AnoY8bNIosqbQE7us2tX11+i54FAW2JLa2dvgRBh4Pga3t3M19WrMRLHiebS0k0Bngs31BkCD7o8yv3qWBvpY4fgKclYsmNSBJ2NGv1VNH7NLRGp29+BcFoq8jxhNtS2ykdgZuv6HJ67T143xQ3OyXmDL1Fr+QPjFgcelNn3DTjhQPEQaFAFPnhNUxq7vjBm9t1syKOvimTI+wMtVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(54906003)(478600001)(6916009)(316002)(8936002)(41300700001)(8676002)(66946007)(4326008)(66476007)(66556008)(38100700002)(186003)(2616005)(53546011)(6666004)(83380400001)(6486002)(26005)(6506007)(6512007)(86362001)(7406005)(44832011)(31696002)(7416002)(2906002)(36756003)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjU0dEZhbHNQTHh0YXM3bEFBV1FCNjVhMjQ2TE5iZmpSd1l1K3NyTFRpd21I?=
 =?utf-8?B?OXdmT21xYTJxdzFTZDBaeFlZVVJKYzlVSmdYS0ozdkNwbnl4d0ZnZlR0NzNv?=
 =?utf-8?B?Sm1kaUNFY09uNVEyWVVxWWtqSldFYmN2Z095MXZSeGl6V2JkeHV1Z2tmMHJw?=
 =?utf-8?B?V3llNklpOHY2YVJvQ0NpQTNTcVVTekNBZnJOR05WaExVTlo5YnFzS2h0Vi9Z?=
 =?utf-8?B?NVpMcWJIeXdvUmQ4dTh5bTVVVkJtbC9GODAwU2dQYk9rZjFCR211V3hRVHFL?=
 =?utf-8?B?WUhTbHJTa3FpaFZ5elNkMDJSZ1BMVFFXeW05b25mM1NGRkxZQ3FQRVBvVmlx?=
 =?utf-8?B?Y2ZKbGVjbkpPMHdMcVduTGpuSmJGOGdoQnM1OExDcGpYZmMxM2ZIQnNBa1Iy?=
 =?utf-8?B?S1lNYVVMNHB0MWZTd2VwRVVKVUVYNklLbjdjOURzQ0ZyYVF5dmlEVndCbGVv?=
 =?utf-8?B?WkpOdG8zbXlja2pJTytqbllDMXRCMDZ0VzdCVW94cWtwWFJoMkxyVTZ1YTJr?=
 =?utf-8?B?QlBCLzAwdi9HNUE5aGxrWXllaVRtQTBmcEhmakRTcGpPdGVtbDlLTTZXT25C?=
 =?utf-8?B?TXBUd3c1T3RKRDhLS3hBQXdXMGQzM1R2SDdDeWR4L3hVOHhQZFZzNWQxWlNB?=
 =?utf-8?B?OVBDVnYxeGx0ZzNxd0MyVzdNcm9YQlhNQ2RPRmNVQzA4ZXM3Y1FwbFFJdTdI?=
 =?utf-8?B?TzhuRjhGRzk4MWI0OGU3WjZTQ2xkUjNwcE1WenlCM1Mxa3lTbE9FR3lndEt5?=
 =?utf-8?B?Y0dkMUdPelQ2eTlaUGNaaHRFRlM3UWpESHV5d0F3Z3p3d1dxLzFkMVc5MzZO?=
 =?utf-8?B?eXZsVzdWUlAxQ0RaNnYvOFNVUWN6bnBkQUJNQVcwalJJVGFJdmg3N0ZnbHRO?=
 =?utf-8?B?eGdwZjVxSFE2R2ZSWDNjK09qSDVENVNCN2xvck9HMzZ1TWJibm9nYzhSVGc3?=
 =?utf-8?B?dXNOTW5oUm5URVVMT2VVQXVMa0d0UVFmYmlDVE9TM3dLcnEvQkxobERxUzlu?=
 =?utf-8?B?M01TZHkzMm9WbCtnY0hLR1FMTGlNS2R2a1BhLzZkRmdqcUtOWGNlM0NjVUY3?=
 =?utf-8?B?ZzV1U0QvdHErb3RxVjl0MVlFdDRIZUI5dmExNmpJM1B1eTFFTVNSY09PQlZM?=
 =?utf-8?B?Nm84ckZQeDVoakYzcE91SVRueVlmMUR1YWRHYUJxSlpSUnJsVGs5eTUxWFdj?=
 =?utf-8?B?S3llZnRHditCaEY3WmFDaXBRbHFTZFhaMmRReVBuSVM0RW4wRXJFWVBMYkJz?=
 =?utf-8?B?WUhMM0RHd3dZY1Q3T3ZKb2FqblUybWJlTjAwMXlqZm92VWVveExSMWtVaXhP?=
 =?utf-8?B?b0tScVNPVUw2QVlDZ01ob0tCb3h2UHZTTXFZdlgxV3R1a0hSdmdhNkw0b3Nr?=
 =?utf-8?B?V1NYcThYK1pVMngwRkZXSktONkVOYURENXpkalNYVmhkLzNBY0xENVNSNFRt?=
 =?utf-8?B?WlBHVVlLdFNQLzlLeHE4SDdNOHRrNUtkNWRPeTY4OWk3Qjd1N25jUzFzd3pZ?=
 =?utf-8?B?QXhvdVJTRzVUUHd6ZlhzWnd3N2orWUQ2bkVqSjNLa0VQc0pHT3ZaWTVXOWNZ?=
 =?utf-8?B?R3pRTVZzOVJIUUlBTDhzMUM2QjJoQTlwQmhWc3AyOWlTaERNUWx1bnF2Nkdq?=
 =?utf-8?B?a0pGdm54RlRQZmdTc2M0QklMRmJGVFNPLzJiOFVpNGxmR0VreXg5Nk5qQjFa?=
 =?utf-8?B?M3lPUVZiS0dDYSs4Z0pxZlh1NjZyREdlbFdJNFQ4YTBPRCtDa3FSLzEyWU04?=
 =?utf-8?B?ZU9GOHBrajBXSTFRckJwVGJ1Y2M4RWpNWiswUG5IUnBqTlJab3VMTkpsYmpv?=
 =?utf-8?B?ZnNydnp1RExrOVQ0dDFtTEM4dHcyajNyWlJPQ29ERGVGdzFKTm5OTlRFWjhU?=
 =?utf-8?B?OGN1WkJlV1hiSk1PdTFaNWNwTjZGQmorK3RPQWYvNFRiTnNFMFVueGNlNHBD?=
 =?utf-8?B?bFIrNVBvOVVFMjBoQ2dUTFN6RHNST3FzekpvejlzWG5hbEdlSFpwaDNYc291?=
 =?utf-8?B?S1BCbVo2TlZzc1pjcDJHOVBHSXFOTVU3eGRzWmQ1dko2M00wdEMzbi9rbE1s?=
 =?utf-8?B?Mkp3azNoMEZuS0w5OGxOSWtaTGc5VFZKRVFkSnpxN2lqbFg1ckxERWRwUWNp?=
 =?utf-8?Q?7OIRl6jGMVRcpyJKLH/MSX3Il?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d77bf3b-7688-4f89-81f3-08db689e2054
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 04:00:56.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHhfdv1qiCWCnlbhI+3DyM9ccHxPgOl5cH8u9yBup+WQWA8tqSUweKBDStWMTDdUh643aplvBowzh3x8lz1ksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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

Hi Ian,

On 27-May-23 12:52 PM, Ian Rogers wrote:
> Split the pmus list into core and other. This will later allow for
> the core and other pmus to be populated separately.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 58ff7937e9b7..4ef4fecd335f 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -12,13 +12,19 @@
>  #include "pmu.h"
>  #include "print-events.h"
>  
> -static LIST_HEAD(pmus);
> +static LIST_HEAD(core_pmus);
> +static LIST_HEAD(other_pmus);

AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent of
core hw pmu. I wonder where does IBS fit. Currently it's part of other_pmus.
So, is it safe to assume that other_pmus are not just uncore pmus? In that
case shall we add a comment here?

Thanks,
Ravi
