Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206163F3DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiLAP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiLAP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A56AA8E7;
        Thu,  1 Dec 2022 07:29:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwVz56abMZwn3xVN2z1AQGA+DrT0CnqFGtweicwDNDv7f9fTYOg3ATxB5/a7rD7L0fA8Rwmyqx907y703mQW0nRQ8iPyyZS7h3ugIikeKIHLdNXIL/ZHzdcJQWHKw8G/jIbyj2abs+C2f6KT2hYotOCb9thWiNYizVcoz5wtskAwgOMV0qUKzmM7yDm2NCWK2zw/P6x3Tjv8wO87Ual8qHxH0FTXs/2EQRaohQ2UDA7ttwyBCa1tr1O2dZhsP4xxoVVMsv8+jFLiK3VLuXrRr/AOIbqxEArquV9KdRjnXrbvc5QYy/9PzoP58bzcR87/yZ7me+C2vLIF73upLOu1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxHaxGzPVT0Z1LSufu51bHMV9aoiRZPwRzUBN3Hxmhs=;
 b=Yy2wgkXlK5b96WwRRyFTTSodLTCi4r7GC4ulidrN5SXqwfU5wCkZ3vwF7a0heloIhiciYONdiIQaUZNvUaDdtM0dDZ+gWg9WG8iCc+lVYBbhJX6Cw13bmAvW2ATZXUOOJYIeMQVpRaC/3mltqrSrF473LMvtqzAENaOWATdCdgU/OtSiyA2W+IuGHCQKA03FKZbpZtAAn9uKpYcpWYLPlAOvTvmVe/rzluTvzctjJipr4zQBjFXjOvH857k8x6QCdvn/ElzGZUoFuSyoKdNii8s0UibBjS5Ezn2HXclec+M8XBvpJePcGu0IwpbBrOaRH4UmvtLG5IVnt35KLscWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxHaxGzPVT0Z1LSufu51bHMV9aoiRZPwRzUBN3Hxmhs=;
 b=f6DW10TAOYzEP0rWvt81uP/sNGA5R7EVLwKQb30p8aLwTlDE+ZBso/a4HaAvCkPy+rr3uMbQgDdmKKZat7GDXpsfUWOqfziI+o0J2DVPzq1XmVcYQsjkJNPa1oPdo6H4DNdkT5aCmYRf3oXYcn6PP0vw810BJvLpkuDaXcve+Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:29:21 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 15:29:21 +0000
Message-ID: <0eb0cc59-d28d-8e42-3233-2587123e291d@amd.com>
Date:   Thu, 1 Dec 2022 20:59:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>, irogers@google.com
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
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
 <62399b9c-d5ef-4c56-4592-d2cf1af503d6@amd.com>
 <7449d858-2110-1ddf-f7e1-013015cbd791@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <7449d858-2110-1ddf-f7e1-013015cbd791@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH2PR12MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 657a44cc-5d2c-4d1d-42c6-08dad3b0d1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP34oBrx+PCiNaWBJdN9j0daqYOY2FGzFvIIopeB0mO5TxrwgHiAmdh/m/8ojywhwPebzeYPJkvf6dSx9nxux4QxAaY+W5GvDVIDW7I34Wv0FTJd3WWuKE3FqY3bDeFbkszZf3ryHcZFXh9nLlTCZPa6FXCWsSFLhRsAtXPY6HFw6iR7MfY7YC8dEcQB8a/BGHvzUYD5DQxWzT58xziLsGdxcPOc+AeDmjZ8pJhcWqVKkCDCm1XHChEpE+AMFGj/ejWmwvjOB3Dhwy+W+c1gygO6qAmg8Fpmzs6x+Ts2MdbS5bZ4jHD5Twiin9gkaeyvEs17sqnwEHT6BrPZkD96PYvutuKRwssun6yC8yZXDZloOXZ+rXEIGD+8SckFZ2QOX+l2wdSkL5hd4yAKsAIkDqr3gIGgi4Sbyg9nVXYf9a54TBpgwAgJ3/xsU7+Ky0id4rZhNFvR49TCmo6yELqkwtajP+Q9IgPbKWaaIqOeDbZftgXszYFlGzqqbWM6HLs32pw90mDWAyiA+9IIKcpAQgSpecBzEezCXKD2NzEkjvfx09CQpqGUdrKC62jRlD7TegHIwAeKCKXp3JApfcqQ5l4fdCyUMsc8Zbts01u8oMadLKu0Qjuk9i6g5VFdSSkJKMQcMVkf9rTWj5XG3B+0aoF4/ofD/esNwHWGDhqjy4MhV2fMQk6eWt9SV/rSAmEubvSIB8izKadgOsYVqipZM7HqYX54xCRp8wX4mHGkqOQPGBRP9H39kNlEuuYpzQvH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(31686004)(2616005)(316002)(6486002)(31696002)(36756003)(86362001)(38100700002)(6666004)(6506007)(26005)(186003)(6512007)(2906002)(5660300002)(44832011)(478600001)(66476007)(8936002)(66556008)(8676002)(4326008)(66946007)(7416002)(41300700001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtwNXc4OEFrNDdPdWFSdGJ5SE8rWi9JL09CV21BRUtQdmVxQ3pzN3lEMGs0?=
 =?utf-8?B?WUhFQU1qS2RpS0VhdExrcXpGRExwTkhLWGFLbE42OUU0aWhlTUxsV2g4d09C?=
 =?utf-8?B?UUUxZkMrL2VIS2dUd3hqLzc0OVJKT2tnS0FNR2N4SUhOS3lKNVE0ZXA3M0xj?=
 =?utf-8?B?RGFiamo1QjRvdXhqRmVUZldldGFQUW9sbnRibmIvWDhhM0ErOXZtdlpaa2ZZ?=
 =?utf-8?B?ZytYMWRTRm5iTUtEWjVzZ21lYy9GSXNJOU9STFVEVGZ6RlA0N0VmVWd0K2dp?=
 =?utf-8?B?dnFLM3dMQldPNWdXRVp0QmJHVlFFeUxiQ3RscFk1cnBBS21YWXkxTklmdEZ2?=
 =?utf-8?B?cWRPelk2TERXSDljN1NuYzNhMXVKV09raHNiTnNUWG53bXhrR2ZUREZkTFJX?=
 =?utf-8?B?U1ltWCtiQTlycStTS0lOQWRqelhwRFNZUEY5bkphMzlHQ1c1Q3cxblBpcCtO?=
 =?utf-8?B?TmhPbS9vSis2Y2Y2bWV3VEFvL1JRdWRJVjA0SXNzbmFCbW94QmFYUy8yQnNM?=
 =?utf-8?B?cE45ZHdjMk1kRnhMSWQ4UTBOaUFETk5IYlVtVlBZMUZWT2RXUk5COWc5NUxn?=
 =?utf-8?B?UzR0Y2NNT3BIMVNaMldsekM2cmVFVTMrTm52YTVFSmNwSkNrYWMzempINUtI?=
 =?utf-8?B?MWpRUDVWekRZd1djczkvQTRyc1c0KzFoeW5JQlQrUzBIcFVPQ2FiS08vRnkv?=
 =?utf-8?B?RStFemNTdUZ3ZDNZeThKRlR0RExENkNobGxnUG9uajJUK3JpMkJUbHoyUkpm?=
 =?utf-8?B?Qm1FMGtNc0pnSWgvdGlNam92dzU1WTRIdGtzZ0lwYUtyZmtyN1ZPR0x5QTNF?=
 =?utf-8?B?WUJwWFhSdUYvVDFUNmczSlZWUWpJRi81T3FwTEpXV2FGbStrVWl1S1g0VGRC?=
 =?utf-8?B?SkFCaU5ueU5xOVA4ZC90VGxnd0psbDJvanJ3aHVLRk1iMnhjNFBYMlZLaGNK?=
 =?utf-8?B?c3cyOExHRGdBK0x1TGZqVWkxYWNuWnJRb2pmR3VWRjVyTWlNbU14UHBxSnQx?=
 =?utf-8?B?NVdJSFZ3VjJpY0F5bGozdlNSNDlUa1VDKzhLVmpMQWNQbWF4SVdkZW9vcVg0?=
 =?utf-8?B?a0RPdGlmV2c0QVJkakpySHRqQmh5aW9qUW56VmJkbFkvYVVpMkJUR3ZGdEIy?=
 =?utf-8?B?TzErbzcrc20zSVlFZDJZTjloUEI4eFlTRUxVUFd4R2VDYlpYcmh3elhwMHdD?=
 =?utf-8?B?aFBSTG1HcGJ0TXhTb0IzTGpJLzJtRE1LZkpNbWV5bGdyd09hNExEK1JSai9J?=
 =?utf-8?B?Rk1WbHZvL2JMVTlwZWkvUnFmZTJJRUczaEJPRnVqYzFDZ1FUQjhzeGRqY0ds?=
 =?utf-8?B?RHhuWnorck1ORHlrREZxTTNYTXFQQVFBS21kR2RXelNKRXYzMi9RQkxIZlZo?=
 =?utf-8?B?K1RoUWR4WlRaQ2hmdUxndU9aVUVPcEZWQVBFS1FSZ2lUOTRtMmphcDBDaDYx?=
 =?utf-8?B?ckowVEtNT1dDc0xTbzZKZ0tUd3ZyVnZyQU4rVWtCNWx0R0ZIU2RaMVE0M2VP?=
 =?utf-8?B?RUM5TnhOZmtpNThrQm9UU0pVUDRWTTRlTHI2QVNhVXUydW5KQjV5WUszUjRY?=
 =?utf-8?B?OUU3bnZZdmE0NlJLTGdVS0Y5LzBQOXVpL2x0T0xJRGNUbVkyY3NaMEZUcFlY?=
 =?utf-8?B?bVhMeDBtZXhkc0F2bXFyQXphVC9tYlBudVJxUG5Qbjl0K1p2R1BOU1JQSktV?=
 =?utf-8?B?QkFXTm5iNXdnWTliVU8vbk80YnowVXNtaEgyM05rc0cwZWtVVmwwUy9GbUh1?=
 =?utf-8?B?cCtOWnFwYXhFa1AvaDQ5TVZlNld0RVJ1VS82UzBWdUwwcGlXRG9lT0lWU2ZN?=
 =?utf-8?B?SkIwVVcwODJFZS8zUDhUSkJRWTQ4MnRhVEIyMFl3aU5JWTBaTEI5aE1Dbm1R?=
 =?utf-8?B?NEtYQ21kc2VLTlU2amZBV0FvbVJydXRnZXhoRy9mSllFRkNxajhrNFJmOWNl?=
 =?utf-8?B?aitFbEhDYzE5OXlJV1JJQ1lTaUNkcUsrRXhsNDhscG0wWXpzZnlvaFo0RjVh?=
 =?utf-8?B?RTFOM0VpeUdwRC93bVE1TjdiUnNvZ3lOWHF5K3Z5c1FXOUQwZFZsR2JOZ21B?=
 =?utf-8?B?OERORTV4TFNOVFl1OVFLOHk5WDJKY2IxTFVpcEEyWnUvZmRGcDJVQUVzUnlT?=
 =?utf-8?Q?3N9eDJ2G6+GEZ+5Rrwgg0NejH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a44cc-5d2c-4d1d-42c6-08dad3b0d1a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:29:21.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UNmtlMxlzwu5aM3SbHKbvvFc/0hYMt4KMF9UCQ26IAwc3zhLo+o9asddghoZlcgAcFXN/u9/QDeuX1DblRroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   /* Uncore pmus that support more than 3 counters */
>>   static struct uncore_pmus {
>>       char *name;
>>       unsigned long config;
>>   } uncore_pmus[] = {
>>       { "amd_l3",         0x0  },
>>       { "amd_df",         0x0  },
>>       { "uncore_imc_xxx", 0xff },   /* Intel */
> 
> IMC seems a safe choice. AFAIK, we should have at least uncore_imc_0 for
> all the existing Intel platforms. { "uncore_imc_0", 0x1 }

Ok. Ian said he don't see uncore_imc_0 on his tigerlake machine. Are you
sure uncore_imc_0 should be present on all existing Intel platforms?

>>       { "intel_xxx_pmu2", 0xff },   /* Intel */
> 
> Intel doesn't have such uncore PMUs.

Yeah this was just for example purpose.

>>       { "abc_pmu1",       0x0  },   /* Arm */
>>       { "hv_24x7",        0xa  },   /* PowerPC */
>>       { ...                    },
>>   };
>>
>>   perf_pmus__for_each_pmu(pmu) {
>>       if (pmu present in uncore_pmus[])
>>           type[2] = pmu->type;
>>           config[2] = pmu->config;>   }
> 
> 
> Not sure the uncore_pmus[] can cover all possible names for all
> architectures.

It doesn't need to cover _all_ possible names. It just needs to cover
minimal set of names which can cover all platforms for that architecture.

> Maybe we should fall back to the first uncore PMU and try again if
> nothing match the uncore_pmus[].

That's a good point. However, this can endup with the same problem you
mentioned: it may trigger false alarm on some platform. So better to
skip the test(and let someone add proper pmu in this list) rather than
proving false negative result?

Thanks,
Ravi
