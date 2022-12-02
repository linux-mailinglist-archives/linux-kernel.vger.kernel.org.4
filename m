Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE29640E39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiLBTLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiLBTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:11:02 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7EEF882;
        Fri,  2 Dec 2022 11:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNaxLnfaZfl2qZ6quqgfPRTDdWoJ/VPzVpcfqZsry53sGkgbcFrGcfraUBetsiXGEBHHhrSVuiUuflC5HdN+R57/31ZCP7fxhIdGDrIoZOeQmAtVK2fNnCAZv/dv2L5YNjI5bhjs0k24R/SAv3r1dj642eHlUt/Z7eXPku9Ct+TBCLKFoOHHhj8SI0YDi1lyUcDh5siqVPLjVFfcyYK8iWV14EAga7p4ikkuaQNvplw5vKZTXECdVgpeKO6cpMFaqHwkATbgy2+K8qC3bcJujiY0muDIrEiy8ygHkU86onBJKjcMigNE5KU8bC9EmH9gwhUKnpyDDLoF8svr0F3X3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kP8S4Bs1zxav33tbYyWVH9hvZ7dt2khGdTL4x4ht40=;
 b=HbmG3l6Iqfk1YWKnzbvjMBIr2nKKNcsU07S5g+5hpE9af/ESLCvMqr2RSC7sGSQEXcV1mc3jk5PMxRfy54iFQlN+5X93UbMTT89xck+e7P5dRhs5h9v+ZftBpoMDWch+NdfSlAV71cpU6V9lPJxd2OgBUSdNNKqKzqNQBMCy4FsZ4h3PjHYhRVBbXQz5lJ6L0mhvYbxhBt2Avl5Nxh5C8QXZSYp6fVW4ZwO5u/x5h0haf6PV6jgMoOc6oiKWxOT4KklvjngpUUp1jfqLn+jYSijMqPd6kPYivXaTFs6E8Faxv1AbLHxBGPBDs6QK2crMVwj9DODFTKlhUfqKu3NnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kP8S4Bs1zxav33tbYyWVH9hvZ7dt2khGdTL4x4ht40=;
 b=DLBIZ77jeoo60r4HsV5FgvC8HxX5ggjnMDiGTJJ7Za61m2oEefMlCObaxW5h36rSfZna9H2lQDA9gmZ8laSbLaJi2meXpgMsCoIcgNz62S0BSwhCDb0D7gdCZsIwRKCLAXy2MdmvMfuji8bk9NLJHWp/27icawc9vLFSW15GXBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Fri, 2 Dec 2022 19:10:57 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::818b:be51:fc53:5adc]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::818b:be51:fc53:5adc%6]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 19:10:57 +0000
Message-ID: <c347688e-7426-8eda-b618-af64de4af35a@amd.com>
Date:   Fri, 2 Dec 2022 13:10:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] perf/x86/amd: fix potential integer overflow on
 shift of a int
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202135149.1797974-1-colin.i.king@gmail.com>
 <CAP-5=fWKbC_wOLiAnEnPV42mM9fpobJD++wKohFYVU66LdaJ-g@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <CAP-5=fWKbC_wOLiAnEnPV42mM9fpobJD++wKohFYVU66LdaJ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:2d::47) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: a0938c36-8b5f-4a30-654b-08dad498f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UpOJbKj3QDBUIxh6OnHo00DRjqyQ1HvtqegdC1LGc3VeVU97l+M4DPm++18q9xsGEfl/nKavmRVW5WFRjs1qoswfVb6PMbQhLkDIBgkwWKFJzOqRhjNhBkUaxxcOiRoDkGLWcaFZPzY40pRFFF8TXNgggKvnNR0ZyJeuCyCye+SOWZOHs/w9OtGpCHOpDbc5MldcCHEMvWrx8k5gexd99Pq8VYevWKVZN7m1BbDRZUiQjPFpAl9EOZp7hGVlnKp6yaMVqoCx5dzNFkcNZDJDr1hDlMns/VTBtsN9fCUJ0DP2fDWMZ++jFs/VkYRpe1hAL37Bhui5oz0NDMRS9WL8YR1YUCdCnY0KKP5nMcF7Tjp2Q/Jo6vFst5B3z1Wl7pvSuInm1xvzMoJB5wioBMjowxccWY9UwolGq5231pjvDqD+y44aCeHJGfKlPx0thbE5/ktm5FRtD50A2xibfrLqC46HlMQiTmiwMoxutu+fcsGiNzm5xehcTvAhmBy3TRhS83dDz8BbiiJNacQY/5LlRB1LyKtEfYd6h1593pvZITj7ARwJfLOqtapiB6e4nZJ8tijfR11epq9TAD2OaeLz4eARiAaWAYo/SpuO1yEXyiomCbUAP2OAQWbCplnz4JesgbTL0qra/+pMV/p9muIIDuSpY4iWAEWzqOGgaW999JXhgI0d+oMW54zvtBI+VzC0QYDgpfVkrSoXo74JJgGosSIhoick2T+rdNrlWvnQak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(66946007)(4744005)(66556008)(36756003)(44832011)(7416002)(36916002)(110136005)(5660300002)(38100700002)(54906003)(316002)(6512007)(186003)(31696002)(41300700001)(6506007)(8936002)(2616005)(6666004)(8676002)(66476007)(4326008)(6486002)(478600001)(53546011)(31686004)(2906002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBxOG40N1BIOExmeElUejZUdERMNWlndU4rdHhlVW1kMUZkdUV1b3IxUmlW?=
 =?utf-8?B?K2RSSHYzd09BRnVWZEFvK0RUUGJQeDhMbXc2WC9jd292d0M2VHhOazBQNExy?=
 =?utf-8?B?WXlocHViVVFXdWNPMHRwS1NiNDNTZUVvMTFuMWk2LzYwRzRtZHNHWWVEMXpB?=
 =?utf-8?B?ZE4zbXo4TTZpZFJ4TkU0V3pyQVNrdVNwSmh3cnpHU0VZbnQxdFlidEIzcVFh?=
 =?utf-8?B?RVVuR3IxTjNVWnJkazQwbk9keWdEandLZXhUSjhmNEZNTk5vVk5lNFZhYWln?=
 =?utf-8?B?NTBnWWhHdVZvYWVCSU1WZytaSE1SdUl6OWlsZlZ5SExqUys0TTVEZmFmTXM1?=
 =?utf-8?B?ZjcyM1AvVmtFK2YvR29OcndMSVJCL0Q3RmFrd1pyaWVaVXloSzNXZ2ZUcnAz?=
 =?utf-8?B?cjJQdnhBWkovMHg3aDVlRkZoM2trZll3cFdjZHkyT2xuRnVoYmxPZzl4ekpw?=
 =?utf-8?B?QnNyRjVlOFhTbnpBMXUwMXR4clVBYnNsc0x4WXBObFdkZXNWYWhIV0d6cDFp?=
 =?utf-8?B?b2Y5MlVsaVA3ZzdDSTJnK0JQdnhLVlZMOWdkLzJFUFpLemlGWHNxMjVZK1Mz?=
 =?utf-8?B?L2RZdjRYSDBTbUUxMnI5NmprU1c4YmNGMU5YY0N6eHBCU3ZmcmRPREh2SUZL?=
 =?utf-8?B?Wk9mWmloalN5YXpOSDRydXJYMzFzNXdUMFRkbUI5Z2MvNWYydDdDVXJCOUJM?=
 =?utf-8?B?TjNuNnFWL0pLczNWUWFXY0tQQmYvdnpkdjBtVUZmZmNYVjZUL3VSOHdWeXFj?=
 =?utf-8?B?RUJDTDhHQ1RZRCtJdWpLUk1HWWpsNUN3aFRtb0xjOUN0bVJacTg5c1VUVUZ1?=
 =?utf-8?B?SWpWKzE2Z1FzdmNXVTZSWU1uczl0KytuTk9sY0VtN0FCZ01iNFVsd3hieW4v?=
 =?utf-8?B?ZGh4cUxYUWtTQnFKeXo1bUFBa1RxdUF6TkdiMllHSklNaC81SlhoQlNpaElE?=
 =?utf-8?B?bGd0UFVWcC9tMzdZb0pFUlM4R2ljVXIwQ1N0ZUlya0VEdTJOeEl2Uk5NWUN4?=
 =?utf-8?B?NGJJZkFmcXNCanFsWkpRNG8zRlVjNXdTTmIvMW01cU1NR0YzbWR5MXlKOVY3?=
 =?utf-8?B?blNyQjNyc2ZOMjBlNUNTQnFuOHRXdHBXZDR5dHAwNE9oTkM5M0ptQ3ozK2Zx?=
 =?utf-8?B?Y3I2clNHdVU4SzJmM2g5K3diNHgzdEQvKzJibk1ybkJkeVRHdWtBdktMcFNp?=
 =?utf-8?B?U2xtRnFtV3MvNjJvWWNjSjdQNmpoUHNWdnhLMVlidjRqeXlncjJyWHEzTGFl?=
 =?utf-8?B?ekJUZHJ1K1RCck1mQWpSNjV2OTlsanNWbjlUR1J4cVViOGdmbEw1dkxkZ3dP?=
 =?utf-8?B?aUQ0U1pnWmVtK3I0UXVVc2JkOUNsQzM2aC9FK25Ub0JkOHc1Z2M4Tzk1NTNE?=
 =?utf-8?B?QUJKUnBQbTFFUmh0d2haMXN1N0JqRjlrVU5GN0MvajI4SU5PNHZOcEVMZHN2?=
 =?utf-8?B?aDJYM2xpc04vUVkrWitESU85RlphajRkNzVVNmVYeU9GK0VxTHpqRE41Umtq?=
 =?utf-8?B?NDY5KytTOXZXTGxnY1U4SC9OTGNlZXJaTHgxTTFCQjc1aGRKWG40ZHF3Sk1r?=
 =?utf-8?B?TzlVdDhkRGRHNkI0cUhFUHRjYzNRYmxyNEZPMDhRcDNjNVJZZDlMOCtwUEVW?=
 =?utf-8?B?VStqQzBOcGwxZ09uRVhkTjFOa2Y4MnFmd2hleDFaVTcvYk5rNHYvL3cvemRk?=
 =?utf-8?B?NVA2T1E1N292TDJwNkhQNzRsZ2JYWkRFWU8rc01JbmxHbHRsTlBPdkNqeUZK?=
 =?utf-8?B?SkZhWG10NGI5SmNhN2dVNVZjNDVjTzBsY0FaelRRd2grT2FzM0RhcWx4Ync2?=
 =?utf-8?B?N1RhNFBKQjJVOU8zTnBlTllpY2ZjdDNDTWxyQkRFYlFuN1JXQXFqNXZDdVo2?=
 =?utf-8?B?bFhuZDBxam1McVo3dWozcUdxV1BjOSt6Unl4Wkhoa21va1ZQZkh1OWpiOEZm?=
 =?utf-8?B?ZHJuWUtsS1crMVNmcXpneGxudUxlSEFjS2Nncll5c0p4bmlKMWxrUG93dTNz?=
 =?utf-8?B?Rnl1bkJSTkZHQmFzMVhYb2szdm9wK29yckl2MWtHczVzVFlubzV3dE5LaVBJ?=
 =?utf-8?B?YUFIb3Nqcmdhd1d4TDhCYmYxUmloVlpMMHloNFprUFVwS00xK0ExU1lLSXN6?=
 =?utf-8?B?ckh6aW5MTnB0SmJpYkNpTUM5RUUvSE5oVXpzejJ6bkNDQUYvRmJ4LzBySHcy?=
 =?utf-8?Q?swAmEw6UZrBfAVHsFsHsHQtNwE/mJp20dnX/TJRxuRz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0938c36-8b5f-4a30-654b-08dad498f108
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 19:10:57.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUMziUs6AglfWUEZHGL7R9kkzMZbxmx4vVgjmJVfXXUCzSLHff42QVqnt4t+eKKPqjH7MUISPnzqWWwdh2Bvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 11:36 AM, Ian Rogers wrote:
> On Fri, Dec 2, 2022 at 5:52 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>> The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
>> arithmetic and then passed as a 64 bit function argument. In the case where
>> i is 32 or more this can lead to an overflow.  Avoid this by shifting
>> using the BIT_ULL macro instead.
>>
>> Fixes: 471af006a747 ("perf/x86/amd: Constrain Large Increment per Cycle events")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
