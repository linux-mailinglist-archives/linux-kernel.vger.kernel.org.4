Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD762D298
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiKQFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQFIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:08:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083A391DB;
        Wed, 16 Nov 2022 21:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFNyUM24POjfD1w/ghVEgwBR5qbKHtr4P+i9jDXiV1VbwOEfW+rVFcgWKk05TDlgxosTnD7y+XJsalhk1FlwwjkHNW8G5ll2ass56LApb8dWvXko+IDREOeu0M7R0lemPRMZMxWqJUiwjE9jCfw/tEqhEnxb2zv8Crc6PXQHKpORJ92L2JSpfqxe+ZMWpgSD9oiyfYra6nLLNGqT6TppKsFDP1Wmpfsjnl3XLv0cbDBYYuoiNCQuTGzqVBl4qDNXhOjTSecSBQCGrkfkl8aVOkqoNN+/+I6uoPWf7laa53sXVJ3MZ83byrhYoryFWGrPzpSRf+sVLoV7a/9yov9h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIl1o7KNtuyIJGXNp6SMhCHksRTQshDUo4cnRUJDhZY=;
 b=Hb/8+j4rtychnWf9M7cLL/SEg6Jv/5T0wV22Icf3evRsCR0YMKqFXQzWW7fu9Ls3Vc4rjXSNhMFRPRMVJPF0BKbWgC6HwoUVNCl36TLMgyD9J8yO3HRRiFMWq0mS9lS+YMZRfR0uHFe6mEZjvzvLQde8g9u0jCoPllu5eSZ7E8I//vllpxdypbSmp8l5Asu1a9mzuYH4GJZermf7khLKfT8YJ7aX7CqhVkbt3edOP9Ne+c/6OgbpOrncK8VStfWxq4+cJLjf1SkBPVHrhXCczbjNl97lr5fglnliEf2aQnzp09sXZ5LXtIe1xjZaHm6KGnqary+qx2kaY+ZFFhTw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIl1o7KNtuyIJGXNp6SMhCHksRTQshDUo4cnRUJDhZY=;
 b=rWb74K009/ydRhFtQRSrJ+xstnrGHLNEugZeI30ZpqK54s1RHMYvwt6j1RpHD0e9PSrRb8x96RRrOonNXyl72WyFSMdY5bHtNWdWrRVby2YTwtJVt2J8JDlNZZMP7Id1XjqHf3HDZlHukwkskKknUfHJ8FeEw5dSX/igbJm0Vp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 05:08:43 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 05:08:43 +0000
Message-ID: <2b004975-76d7-0db9-1ded-649c2da5a729@amd.com>
Date:   Thu, 17 Nov 2022 10:38:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] Documentation: add amd-pstate kernel command line
 options
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org,
        Mario.Limonciello@amd.com
Cc:     Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Deepak.Sharma@amd.com, Shimmer.Huang@amd.com, Li.Meng@amd.com,
        Xiaojian.Du@amd.com, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-6-Perry.Yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221117024955.3319484-6-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 490965f4-e07b-4b92-4289-08dac859cc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ps4IRCwXQnInmsJhqMxZR8MPgsDtd5eS7DA7nNEuxrItetR+o0bDIvgkWPkbWdBcMTrHrf1Ga4QCL9pn7jGoId2RcIaAytXncT0D+uyFCXCxJEKLVtsAI6FNWuzyj7o5h8/PNVt4uoDXOp2yLIRB9xBHIsRc3xrXHMhxsPu3AcGZD+QXAu44Gk3nDzspGE+dQOoXUmNgQ51s2b9dsNJX2+3vwYMlKA0uXlzIJcDSbd+G/1H8NnZAxojq0H0LGILZkV/2jnA+tNBoc6s4QTcYNAgIK/ZhEcqYf/dF4keMv5p60fFBGUUu0PuW0vNuocEf/mxmsf50tpZGw76v9/jK7oKRl+TCOlW1ds63wWl78Pjqk2rhV0sgBJQMKKx6/j5K+UWMWuakQPQ4r+zgGK1qUqgXIKRJZ6nNoYQkkKHoDMHnKcq6Io9Jw07jcexlONCI3DKguwtTjxK8yIYmFgrMqS6paDkfbzkUcVdACgjitRxtuhKiTRZ0biOCUV2wbD/w6COmwIgH4ONhKCblmtpmDOmCeacQ1uk4BnFnWVp6+4IyD3vS2xAtSFhDAyQPgapKsxB4SIwg0IB0UQgj1EyuFqaqkSzvc6JcF5Gncg1CKNhxKCU4TxZiUHW/dz26d+jHaw/dVoYshZokHXVJ1n+N5d+fWWLsK6d/V+Qy2r2jxQBwejVm3tdVQJzBlOVJHG8+GSvWfPh3SMrCl3rAbDRS7IByBMrzeFkhgpe1331E3Ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(316002)(6636002)(41300700001)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(5660300002)(31696002)(2616005)(186003)(38100700002)(83380400001)(8936002)(44832011)(86362001)(26005)(2906002)(53546011)(6666004)(478600001)(6486002)(6506007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnBoNTFvZ1hSck5sZjg0ZlZEeExHRUs4L2dtUE5ZcjVLM1kyNTZ6cjAxU2ox?=
 =?utf-8?B?WTdRNUVzRWNmWDVsci9DN0h5TWtQakhYcjV4dnhlVVdlVlZ1bWk5TGFSUE8v?=
 =?utf-8?B?TSszODBHNy93TlZtcW9DWG0vMkJWRlVEQ0t1NDIrSmJlcVBJUU5JU1NpNXE1?=
 =?utf-8?B?bTRPcnpKWkRIYTJ5VzFZdFZBRURUL3hWN0p4alZYZEl3M3FCWFNwdW5tbWl6?=
 =?utf-8?B?d0dPeExGNzZuUk41VzJoY2xPNnpDWDY4ZUlqc0NLMnArU1JlMFNXQXhjVm5C?=
 =?utf-8?B?UzBMQ2E1SE5MRjVvSm1kVzQ3U3NacW4zWGRWWWI4bklQMWZYYmUyR2cyZU53?=
 =?utf-8?B?UHhsV0E3dEJrNXUyOWVxam45QnZ4L0Y5bU9TUmtBT3RjRlR0SEZtTXora0Nr?=
 =?utf-8?B?R1MxRnhTZGdDU2Y5ZlhlZzVxWGt5QWVrbnNrdUdaWm94UjZJVlhjTTNEWVBO?=
 =?utf-8?B?Ym5ORk1EMzNvVEFOT3hxbXA2NUxhOG1jZWRzdElnVDFMWWJpYjNSUVluUURQ?=
 =?utf-8?B?dGNQRkRYbHltK1h2c1l6THpEZU9FVUxKdHZwV090cW5wMVhvY0pkelRiUHYz?=
 =?utf-8?B?c2UxMzhyNlhZYzB0biswajVpNXQ2VC9JOEtDcDhCcmpYMTE1VTNaSVZSN1Ny?=
 =?utf-8?B?Z3hmdHhtVmdPUE1yWHNmZEtFUjVaUDhxTGY4ZzZ0QTNuYU4rTEdZNUN5U0gx?=
 =?utf-8?B?SVNCa3ZSaUV1L3dDQ1RVRERqVGpBaUtycS9oQ0cyNmZXQ1BlVDBHOTlsL3FG?=
 =?utf-8?B?cEQ0VjNJMU1scWdiNVA5SmdWamRqVHNOQWduSmVudS9kbFo5VjdDTTdWbWo2?=
 =?utf-8?B?bnBnNGhGSHpYTHRJU2pLWWF4Qlk0TW93L2VSTk5ucGNkNnA5N3pLWnZEY2Yy?=
 =?utf-8?B?NEtEN3dIV0VlWVlwcEhPYzRuMEExUXNRZ3JHVitWdkttME8xSGZTMkpoQjMy?=
 =?utf-8?B?TTMxS1BMbXBuVGppTVRDN2RJaVZwOGVObWowOHVjTnNzZXdhSUxXby9BbWdQ?=
 =?utf-8?B?dC8vWGVXWS8wU0lBRmtFU2gyVjhXbVQ1bWZQNWlrUEIyL3hSODAweXhiYnBH?=
 =?utf-8?B?a2UyOHA5VTBCNnJJdnNOQ2paV241eGxEdFRobWVqOS9GTVgyL3dOOXk3cWpM?=
 =?utf-8?B?cGg2Qnl1ck8rZng0L1ZJVTFLanpyaWxkWHBvTlo4QkZ4aGtzU1p2ZkJDb1Vy?=
 =?utf-8?B?c05mMHRHWHN5UitwaUdkM1NZaUplNUNGbFcrZHl1ckNVUFJLYlBERlVieXN5?=
 =?utf-8?B?Tm9sTS9YL1hmMzVoWWNLemR2Q0I3TUdod2xTeEJnbkc2Qk4zL1dyOHliVkF5?=
 =?utf-8?B?c1BjVTkzZXg4Q3dwRVkvQmZqQU1Ma3JOdC80ODRCNjFBQVBsM0tybjRncjFR?=
 =?utf-8?B?Uk4wS0dleUJ1bThNbGdGWFRkNzdoSDkyeHI0alMrTzAvdkJ0RkhaOVFEelhx?=
 =?utf-8?B?bStGMzJyUm9MT0RyN1VVR2Rvd25LV2tJczRGbTJLRlN3U3lBN0dzbDMzTVRr?=
 =?utf-8?B?VitqZkpMekxhaWRoNWhEWG9nekdxSU92WXZSbUZSYjdWQkNqTzRrdUF0YWJw?=
 =?utf-8?B?WHdMeEszLzNpak5SOUlQVmkvMXR4U1ZXVUVURU9UUjJSSTNYdGNPZzJEQTB3?=
 =?utf-8?B?amEyNnMrNmF3MjluVmhHaHc0dE0xcm5uR0lDVXdBeXp5em1tS0VOaGlGWUxq?=
 =?utf-8?B?dS9VcTVKTXExZDY3MlBYNDdCOElsWldRVEVQMm13dDlYZE5YTHhZZktjTk5m?=
 =?utf-8?B?YXFQQ0ZSdkpwMUxTc2RYUHV4cjZpNVVxamRTNzduaVFMN1hFdlZraTAzT0po?=
 =?utf-8?B?MW5HR253QXBMZkhucEJKZzhjTWlIYmI5M1habkRiV3UvbldUQmNEUytnbVZL?=
 =?utf-8?B?TXVoVjNLVFF4R2lDeTY2UHowOW5IaDA1czBIOEJkcU01Vm55aGhTaVlpSlBB?=
 =?utf-8?B?MnNuUTFMdFd5TTQyUEduV3QwUXlTZ2ROcGFoL0dHa1JmdTRXR3JjeGdWeHJL?=
 =?utf-8?B?aW9vRy95d3pCaDVQeU42R1FnOVBzOUtxT1VTdmd5MUlFcGkyNTMweWtPVElX?=
 =?utf-8?B?c1RYTUpySmRWbGJVcUN4SlVtZUVTR1ZmWGNtdy9BRmhnYlkzVHdVVnl0NEpp?=
 =?utf-8?Q?mwcMPDpkgoeke+HMahDGSPe4S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490965f4-e07b-4b92-4289-08dac859cc45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:08:43.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMjNdqvRRSwJlZP9lY7lZJM+5Ixf6MgB2nxRBgXZhHMc1eeUhtRYDign0uoII7D5L4B4SSAZuPoOAdUuhnPfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2022 8:19 AM, Perry Yuan wrote:
> Add a new amd pstate driver command line option to enable driver passive
> working mode via MSR and shared memory interface to request desired
> performance within abstract scale and the power management firmware
> (SMU) convert the perf requests into actual hardware pstates.
> 
> Also the `disable` parameter can disable the pstate driver loading by
> adding `amd_pstate=disable` to kernel command line.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Tested-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774..42af9ca0127e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6959,3 +6959,14 @@
>  				memory, and other data can't be written using
>  				xmon commands.
>  			off	xmon is disabled.
> +
> +	amd_pstate=	[X86]
> +			disable
> +			  Do not enable amd_pstate as the default
> +			  scaling driver for the supported processors
> +			passive
> +			  Use amd_pstate as a scaling driver, driver requests a
> +			  desired performance on this abstract scale and the power
> +			  management firmware translates the requests into actual
> +			  hardware states (core frequency, data fabric and memory
> +			  clocks etc.)

-- 
Thanks & Regards,
Wyes
