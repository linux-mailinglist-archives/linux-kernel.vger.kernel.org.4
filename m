Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F763EC11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLAJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLAJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:13:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6527932;
        Thu,  1 Dec 2022 01:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtCdNlcUNlcO9TydOfiaT3YMZwM1jHk1OkBi39i0qMGnumMoOqEcmTmlpIzuK/8NqVpcHH5Ss9/wn5zDbaubwgyZL/90t2Z8NDEDl1mbrGzze7biUoA38+suKpQiXJbmSVf+b3ayV6/X3zLGPPCjffwoTUPlW42PGspkZM9+RnDsVWY9IIUptpZHYBmXjQXxh5onWgzjpl4sYIOVEodcW/WefXIZs7Ze/9owUhJ3pHxQ+EaCi1bXDelUiREouV5wGAR4fTekZGwIrwxD4GnC5+zzriTNsTkc8wp2SgBT6t3sHJ/Kl0ZLGJfL2k13r+swITdO8pHVjh1N7IVj3mUf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rtS79x4RmooVY/M2/u0G0LK3iwLj2uBihwyo3YKbd8=;
 b=IRlAVjTqXtBInP0Vn9fJJw52tXgxOMLe7GEp1CTsCC00FqiSFnjgax8NM1RtX7Jjc1kJ828u9+TLObB5HR0GprnCbolMDwz0RJ4Kp1wo7YEP+dvX+07avTzkVOuZWFM3TWtzKkQpOyzKCyUS2NvE9d9e/WRmLJycYXKBPWA0goLyb4ny9O4u2VDUl/jOkNTgS2HCV692Dzhz6jXH0P580ELYO0HmyAntwWDPrdSq/KfnupY48Ozika5+ATUdy7NRy5fCgSigyqMoQNacIRLNrAh04e9LQTkJuXSwRiUbLNSbRf0f46HzrlWeFISK/7Iui0UAZhe/oTtERibIwYNQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rtS79x4RmooVY/M2/u0G0LK3iwLj2uBihwyo3YKbd8=;
 b=Pf/zEYVCBC3MMpU3sy9SYXnSILgRecV/RlG0iPRfilJJT1BlhvpZVJ9a3hKQIfb0MAXor7NFhDxrvP6XGQxJvVoD7WUHKd2aMZMKo+T9m6r8ft6nSbxgr7MKWLRLoznO+aWMwV4HipNqjZ/gLl/5WJ3izi37A3LFiidN+AELtNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 09:13:44 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 09:13:43 +0000
Message-ID: <62399b9c-d5ef-4c56-4592-d2cf1af503d6@amd.com>
Date:   Thu, 1 Dec 2022 14:43:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221129111946.409-1-ravi.bangoria@amd.com>
 <20221129111946.409-3-ravi.bangoria@amd.com>
 <0dd566ab-38fd-2204-f59c-e74b2244828b@linux.intel.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <0dd566ab-38fd-2204-f59c-e74b2244828b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bad2597-a255-459e-ec91-08dad37c57f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ob/TveXXa1jnu64et7xqDzs5bCY3Tiqt4wUqETOXFf1VHwreYNknnIZfxDO8+DMER+oBF2KPpNwTxKK2m/5YcvYsSSbjwG51EjGZgtcuEpzbL5yU+KoviQlHqY6xjBvmXmUd4+TCQQj34F3mk8mh2oz2knNuZrB4S0LLAI8+461j670cCK1LqmKqvxXkrbXFfNi93iCJ2oyyJBgQmZgBhaWbotMonQzPs2F7kpQt6Thd87sgCKueRQ/JyxudSkL/3GVq/AoX5HdWwAqRO4td7AsJWNAQHAmYNg/OgS+soRPJfKs+gtd3cqjreFJBdOAvwbgdd2Lhy7nEcxN1/+J8APf+lmO0YYACySpgqS40M/zkb5pn7VON8VIZxyaC4pYqEi68wGqsqeS+MwoYyWdgWsO/miZP7o2ad+RdmFEmHub5NBKWKmwVIDFgUwChdboQl+JdMNWAxT38tpAJinri5HSvjoOmVTWXOLBo7/brOZL4FLpWNeJYAnjT9DOphVeADH3af5IiYO83dBhJs0YUSs6EzXQDDih0UthLQ30nnvXyLHircg9kHjCFxL5UZJCi0gCFiWJnMo9d+RgWW6Bd269VFMMQT4kyL/Og3OuuoLhFuPk8kgfM3WY8e9XYWhOWjxsUauN4v66ruzEY70WL5805LpEN7lQmcV24aiirAWaIKLyhDkiWaIs2OZrW74djOZXjeiBUZ+YVpiTmY1WeXsFcCGJl6yE+Iw18MnZE0PSuOHPP4pbSdfeKP99nGgJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(4326008)(31686004)(83380400001)(41300700001)(8676002)(6486002)(6916009)(316002)(478600001)(5660300002)(8936002)(66476007)(7416002)(66946007)(44832011)(66556008)(6506007)(6512007)(26005)(2906002)(2616005)(6666004)(38100700002)(86362001)(31696002)(36756003)(186003)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RvK2xaRjFEdTFaY2gydHdOYlJKSTQwSGg0a3JnNXRqTys2Wmt2b1hONExl?=
 =?utf-8?B?TDhMYVpZOTljNkR6RExYaTVqZHBuSi96QUxoYTFESy91aG4rYm5aVlRjUGpB?=
 =?utf-8?B?N0c0dDVwS0U2OGZ2YzZ4NnVPc0N4a2VqZ0dQZDhNbTRGTnZweldmY3dyUzlQ?=
 =?utf-8?B?UUhweFE4WDdrYzdKSE5SWDgrR21uVURGbTdLVmpHeS9CRW9CU0UwcWlnaDBi?=
 =?utf-8?B?OE9zcUZyMWEzeDBQaUdPZUxUL0FBWlFCWENPT2FjQzdQRzFFdlc5Y0twdTYx?=
 =?utf-8?B?NExxWG8vN1FWVGtEYjYvOEttcU1yV0pKcEFGWnF3akVrRkUxNHlyNGZvUU5Y?=
 =?utf-8?B?aVlqS05SMVlLZWZ2RHNlbUo5bEpMOC9halJVUVZEMjVUZUNvTUN6bGZhN3Ix?=
 =?utf-8?B?V1JDMzQwTWs5a0lXQkJsZC92YUpDcFZPK20yekh4SEpYQjFIZWdyL0V5cWhh?=
 =?utf-8?B?SmxDTFkzVGxMcTh6ZzYyRHR3VVQ2bTZ2U2o2cWxMc1h5cWpsbHhPcm9sbkN6?=
 =?utf-8?B?QU40Ry8ra3Y1azl2SlJ0Yy9JQTBJNXBLMDIrKzNnQVRneEJldUVRY2YvYzU5?=
 =?utf-8?B?N285cUl0RG9nbWtDSmVYcy80bkVjdk1MQ2xLSFludmwzVUdudXNBTk1jQXNS?=
 =?utf-8?B?T3N2M3ZDV0UzSm1BZnAza1RscFJVL1JGcXBvZW9PaWxIdUVnVzNEcU1Vazhz?=
 =?utf-8?B?b3N0Ti9CUUJIRit4dmtkc3YwVnpVdDB6THVtVmE3Z1lFU2ZXcm1mRVR1SXAy?=
 =?utf-8?B?Tmk5M3N5dDF5OTBORGhwakNYL05TN29YNjFYekRVZk9tN01IZjRCdXFwNmx5?=
 =?utf-8?B?WkJtTTM1OUdKUkx4SmpROExVV2EwdmpwbzNBYlByUWxlbXA4M3BLMWJqck1u?=
 =?utf-8?B?bzY5Njk1MXN1eUtHTDVwNHpPVTgrZHhSZFE0Q0doN2k0dXlHQ0VUYnVVUzd6?=
 =?utf-8?B?TTZpc3R1L0xpcFc4eUNXdml2US9DSGpVYmxNNEkyVFUveC9VWnBYNFFqTXhi?=
 =?utf-8?B?NTYyeEhiTUlXUXN2bnZHa1lVR3JGQmZld0JBN3N0eXRSelo1bEJUUjVBQyt6?=
 =?utf-8?B?MmVCdy9sZXlpdGttWWkrNU5tUldRMjc2S3ZoY1VUQXRXa29NKzdmYUV5MzVt?=
 =?utf-8?B?OHNyZ1pXcmgzdTFoM0s3ci85S0EzWXhHcXk2OUorT0ZVSmlETDNNWHkwaERw?=
 =?utf-8?B?SWxzZkI5Y0VaUHprbUJnMlc4RzI4SWRsWUJBcDNYRktLYVhleHQ1Uzlqd0ha?=
 =?utf-8?B?R1AyQUw2dEh5ekxOcit0K3ExV1ZybkFaMlQ1RG5QVXBFZUZMekpJK3ZXQ0NO?=
 =?utf-8?B?elc2SmMvZi91MXZrc0VwdTF1R1k4d0pHYzhSVU1LZVU3aTA1T3BDUGpQYXZp?=
 =?utf-8?B?dU1MUGdKOHRCbmZUK2JXNzk3MU5OeVQrajFvTk5CSUNVWmZwcmRNQkdyOFcr?=
 =?utf-8?B?R01iZm52UzRaOFBybnJ3RWl2bXhJbXZaOGw4SUZIdG1oTE1VYk5UbzBoY3g1?=
 =?utf-8?B?aURYSHIzbzVFYy9hbXdTRUM2czB4Qm0wR3ZXdU95a3RvcWtIL3JiR1hXYkcz?=
 =?utf-8?B?dk4wNGhZS1dXU1pwVGZCL3I4OFVDZmxsUHJIMDZQV281NmtJQjJkdC9kNXpS?=
 =?utf-8?B?bnNkVjVrSEpzcjhZZU5PTE1nalZrQ01xZ0xKbnNXL29ZQjNpQXBFQnFnbXlL?=
 =?utf-8?B?MlJuZHhRRW1CUnlDZnVoNmlUU0cvR3U0RCtBOGVKNGVzOVhlKzIzZUhTMDBj?=
 =?utf-8?B?MU5EOVNVd1BqSUlObTJ2dzlJM0YzcWNpbHpwK2J0L0l3TEZDQVBzeVRRdWJX?=
 =?utf-8?B?WVlCaXM3cWZqUVJpT3B2dWw2dUxYMDJRSzRaWE1ERjRQNUFqckxPWkFwQzVv?=
 =?utf-8?B?NlZXS2FUbGYwSXIwMVE1M2p5WG9WTlEzbnJHa1FYcEhtYTdsS3JjVU9UQzFr?=
 =?utf-8?B?OU41R1dXaFRqODRpYW9pbE9tbWVOYmlGTUpvWjhWcDRCeG9waVZ4dTZZSUZ5?=
 =?utf-8?B?RnN0RDA4TU1pMXFQM3R4L00wTHowZ1luSDdvRmRGd1VOd3l1Q1FSL0JLeDVn?=
 =?utf-8?B?WWZueUYrZ3hVa2ZjbkJ2KytTVFNWQ0M5ZVd2bDUzcVN2U1NzYWJmRnViSjhS?=
 =?utf-8?Q?cLldeyxRSIvMwggk5Ke2W9mUx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bad2597-a255-459e-ec91-08dad37c57f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 09:13:43.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl0449EiGr53E9NAElO5ML9kn6qabkqtWNePN8Bh6z17CtxDuJaS9emx/wo80mw0tTDq9qHvdMg9Kbo7TvFucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

Thanks for the review.

>> +static int setup_uncore_event(void)
>> +{
>> +	struct perf_pmu *pmu;
>> +
>> +	if (list_empty(&pmus))
>> +		perf_pmu__scan(NULL);
>> +
>> +	perf_pmus__for_each_pmu(pmu) {
>> +		if (pmu->is_uncore) {
> 
> Always using the first uncore PMU may trigger false alarm on some Intel
> platforms. For example, Intel has free running uncore PMUs (e.g.,
> uncore_imc_free_running_0), which only supports special event encoding
> 0xff. The config 0 must fails.
> You may want to add the below check to ignore the free running uncore PMUs.
>                         if (strstr(pmu->name, "free_running"))
>                                 continue;
> 
> 
> Also, some uncore PMUs only support two counters. But the test assumes
> that the number of counters > 2. You may want to limit the size of the
> group for 2 for a pure uncore group.

That seems hacky. Instead of ignoring, would it be possible to provide
a list of testable pmus? Example with random values:

  /* Uncore pmus that support more than 3 counters */
  static struct uncore_pmus {
      char *name;
      unsigned long config;
  } uncore_pmus[] = {
      { "amd_l3",         0x0  },
      { "amd_df",         0x0  },
      { "uncore_imc_xxx", 0xff },   /* Intel */
      { "intel_xxx_pmu2", 0xff },   /* Intel */
      { "abc_pmu1",       0x0  },   /* Arm */
      { "hv_24x7",        0xa  },   /* PowerPC */
      { ...                    },
  };

  perf_pmus__for_each_pmu(pmu) {
      if (pmu present in uncore_pmus[])
          type[2] = pmu->type;
          config[2] = pmu->config;
  }

Ofcourse, this should work for all architectures. Arm, PowerPC, s390 folks?

Thanks,
Ravi
