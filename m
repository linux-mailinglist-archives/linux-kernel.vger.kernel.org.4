Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F137D662A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjAIPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbjAIPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:45 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D715833;
        Mon,  9 Jan 2023 07:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azxh+7ctfkPZVy3C/IOTLX87Dj1fgk5MRlQ4OM9sy/HnkwYEI2BrdHGGDW8c293AH50GzymDA6uWGJ5o9vZhOZupxBAKF+cBV3umxoPN1afPcx95Qw86GnRSdF16sxgGZFCyyN6/NTuWOpntD78TbMksxL5Yq/g/OYd14CRJKInGfgqFK0VgMpPlGqqWPDfXYcecybS9w+PLAZUfUzn/i1lNKul9S6gCH456nVy7fSLX+yMdN0RT5Tryy1QPUl29FmZdoyEhte3IYqICWRTSCVPWDd5c7LmTs0bWOuICavZBzGbhTT3I1uzFiId6zCFLtqp1/sj8Hi5Fr3VYhS8eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjJ0lw2lwUXr67b43HvDYwVHvtEyVazgcWeR0xbw9iI=;
 b=Ma14otPvN9ByFPXe5dsKV7itlZy4bA+d9J43N1qMPW+iDBK/2EiBAWwSwskxG9pqre6+AJoN/u5hNTrUTPvEG7BDfz+pUzvCH4yDbyqDIvSLUM4hlCYsg+caEEGqsAAVDEd62cmWelHZ1xg0BYkw9tAYRWnGwFqL2HYAmEYuRrsSevElZ1tRz0TJFVPCwdhiveJVOQXdiv72l3c8ifSWUFS3xkheDNTZCCR3FcTu47FN6e6DwieGlJ6CaCVO62/5xrdC0P9UkYbikZnl6KWCLfB0N7Yv3jKeV994VYZly3SgizemIjOqmXo+KYvAR7Rj0UR4RDIb3vtMQh4/arbPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjJ0lw2lwUXr67b43HvDYwVHvtEyVazgcWeR0xbw9iI=;
 b=3n/Stmq5sYU3dXdgfQInld5HZ0/KkzxMWnyiGBWa18xDnp+64Cwi2+89S74iEd4NmWv55b3K2rFggJsd5/Vnet1+YA9FBtvuTdMJ3oQnW81C5wlUS+QnrhyreGQW+UifQYtMHddDPPDzcZ/VPbVp/WutKqIsYo++VLz9j2pycbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:39:05 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:39:05 +0000
Message-ID: <27b6ec56-4c19-2d05-b8cf-731b7ebd4460@amd.com>
Date:   Mon, 9 Jan 2023 21:08:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106054856.37403-1-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230106054856.37403-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::26) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: b917e4bd-f301-4b0f-22cf-08daf257a3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAPPry9Oadi1QFxG2IMSlzZkhNb5Q4DvLpXBLR0bRMJhwzsr8RQ2aJGSSK0TyNDJB9nKY9HrGJHtEMR9H4cHm9dGGecrsDLVsF7ljXKf6Ey6SikeF9LjaxtPf2lJj7RxCOzX5cXx3nik42ckXYTnebDB3A0ym5S3yFIxqRMiMeN0kzod5fl6+p5/1RXCOVSQ5iun1iGMCKnNwldG5yz/QhKlMxSP2bWyNok6yrJqMo6+Jx6aX+C7r/WFVLf2AtMq8oqdPNqidYz599KdRCrDuzMpu4qkQyeFi/dRnz1SIyc6ccEOzwOpmyRK3cvWqIH5dJV+V+o5Ja0tJIVZ7ILh8mmLvfZC//CZ5ek48d5pR9BuRSLCBOBg3ne0QufAJY/JDz+bDeBsaRlWtwhrve3Ow30o3CMaYvp8J2XD+RmbmLHCfxyImC6EQYXbLrIII8vJcGVBvzdKNQAbJXtTThlvBIzSdUS9btD+PYOR4rAubV4h5dFXSNyB47WfcqcxgsEtPawPndNMCKHHGyGfNJS51WHYgjPHYjcoNCi+ZLnk/zRcEZSLQ7MSybPLqw3xtdyghkRVcegt3Uc8QHxJXSjNVPaDdY3jlb8QYeg8dWAnaLr51q4GNi3zcAhf3MPb9i4JdHJqxUW0otuA29pnleLiIgkcnwz5NUrplyr9213rWjdsASTvxI3dZWvcvPZ7iS5LIMoZtlzHFW0PDo5udfRBxobGhS4WJXF1zgBZozWJ37U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(316002)(5660300002)(44832011)(26005)(6512007)(186003)(478600001)(6486002)(2616005)(41300700001)(31696002)(4326008)(66946007)(66476007)(66556008)(8676002)(8936002)(83380400001)(86362001)(36756003)(6666004)(31686004)(53546011)(6506007)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWd5aG9aaHdXL2hwZ2NFMzJjY2FvY1M2L09Dd0Jxa2xobmwyVkxFclFwZ3RI?=
 =?utf-8?B?ZVRuNmRVL1VJdDE3V21UZk5tUUUrV1E2MHVIa2RJRDJkalZpRkZaSGMvRDF4?=
 =?utf-8?B?ZmZiQXVyU1IwdGROc3pjcFZ1T1dUYTVzUkxjRmZYWVMvWUNJL3pxRnEwak1L?=
 =?utf-8?B?bzl5Z3ZWMFpoSUdMQnUwNlZBK3F3Nm5Tbk5xQUtRTzF5YnplaXcySDQ0RXdX?=
 =?utf-8?B?ZmQwcUxuZi9kQU8rUG54bVdDRHhGeWNXbTNLLzh3ZGFkWVdEYklFM1lXNENR?=
 =?utf-8?B?M0l4SGZpVzJadm5YcmJ5TThhOStEZXZsNWpFVDFUZmtVVWt2dzhXVUNweTJJ?=
 =?utf-8?B?amFweW4zK3NwL09XUDdRMHh0QkdYK1Erci9WSlY1cXRNOEMvbk52Sm5COHho?=
 =?utf-8?B?YWw4L21mOVVYSVdHQ0FKNWo3VjlwOXlYdEM1LzhHd25WMTdLdmFNSVRzUG1j?=
 =?utf-8?B?dTZIc2x6eTRqMDNjaU9TSzYvUk13TmIwVlE1RWd1UCt1d1VDdFg5VTVIUnFx?=
 =?utf-8?B?NS9UT2xtMFBKNzlYSjRKK1g5NlczYTg2L2hxTFhJM1dMYXhpS0Vkc0Y1SzVo?=
 =?utf-8?B?bjhNTlIzSzlsblh2eUxpUkFUSFllUEVvRzRoN0o1eHYwYytvV1FvNlNkWUpE?=
 =?utf-8?B?Qk9obnJkdjhRL0pRdVludmoyd2MvMGFOaSt4L1FHdHdSUVhJTzlTdXJsL0Vo?=
 =?utf-8?B?cXB0UkNLSW1INVpQZ0hITTdVU0s0aGR1MmtHSVhXZTdDR0t4eFJjc1EzZ200?=
 =?utf-8?B?dnc1bVlpTyt3aUVoeTlTUDFiMGxzM3ZGY2FpMGJ5VTZjeGUzcHJvb1k0a2xK?=
 =?utf-8?B?d1BFM3NFNGlIYXlpOUd3TEtJMWFJQW0zNS8vZklsVU5vS082aTUybUdPRWla?=
 =?utf-8?B?K3pnVUxwc2Q0MkFKVE5JaHRacFRRb3hMbHAvVmpPckZyU3ZOM0NENGFqNGVn?=
 =?utf-8?B?KzI0TDdsbzRiMlZBRU5HNGZUcHJ4a084OVB3c0ZrYVV6YVltd0pBL1ZJWHJs?=
 =?utf-8?B?bmF4RlRXWXFxQmt6R1ZwdTd0MUpPSklkVDl4QSt2ZjJXc0JlVG5MdHBneDY1?=
 =?utf-8?B?NGg4TE13eWJCK3hlNHRoVFZpQ2FCVFVBbUNSZ2UyTUJGVUhIZWc2bFNpMlp6?=
 =?utf-8?B?NTRYUG9SdURrNWd3eWh1UVdZUnNCWC81MGNjcC8zYnVIZWUxWk5tMm5RY0Vz?=
 =?utf-8?B?VGVwSkh3a05CMjVpelJpbWRKN3ZrY0d6QnNZbWZtZ0JDSHNQa2xwV3RxTHpl?=
 =?utf-8?B?d0pSWjg4WnN5MnZtMFFqZWZCU1JuVWhjN0FhK1B6Y09IZzM2Rm4ydVJZVE9x?=
 =?utf-8?B?VXYwTDBPSnNKZFFNbmRSYlI4d3F1MlFvRUFxdUNrME9Wd2M4ZEhTV2ZvVyta?=
 =?utf-8?B?cE81TzlxTkhLaG9WUXFlQzkxQWJ0QzNHcXRHSXhMT21JekZxemhKK0RSbkZ1?=
 =?utf-8?B?TUlRY28rQk00YldmZVBZeUxSSXpZNjdzeWxkMWh4RnR5bzVkUkw5MlFZQ01B?=
 =?utf-8?B?cnFTYkp1QXpLZHpoM1FwTXZSY2I2WGw2eStGTjBXeTdjOW9xTUZzdjk2a256?=
 =?utf-8?B?dWJzblp3Wk9UamVFQ3F2bkdFKzE3TCtkSmw4Q1ZjUVdnYjdxTnk0Z0VxV1RC?=
 =?utf-8?B?emhneC9WdW1sWFJVWExFRFdVcUJLVUtuYy8xOWp0NStKaXRKemVwYzVWcmxj?=
 =?utf-8?B?TmxQQzhRVGNnRGpvZWFna0RqNEVqekZrdFZrOFB0akV4OThOUCtzQkZ0Tk8y?=
 =?utf-8?B?Q2xjRG1EZmRVRlo0UElORWM5amtqa3Q4aVBORnRTbTV6V05WSXRyTWRJM1Bx?=
 =?utf-8?B?cFo4QzJEejVQQTZPZDdCQ3ZKZndlUVl6eFprSmJla291NVM2TVl4QnlpSFhU?=
 =?utf-8?B?RjJhTEsxYXlwSG5sWE8yOVV5bUFVMEM5M0xLNFFidklLUDZCWGFUL3lMdHUw?=
 =?utf-8?B?RWdhamljU09YN2NqSnI4a2Z6eXl5SUZvYnJIcUlzMVNEZWZMR0tGT0JMNWRH?=
 =?utf-8?B?a0lSY1dtR3piS25NN2d5LzJ1MFhjdmFOZTBDNjdzVTRlVXhpRWhzempQaEt2?=
 =?utf-8?B?Sk5IZWpzWFNMajEzSW5kS001anJjVFplSSs5ZkE0V3hKdUo4N3phOTZDcmk4?=
 =?utf-8?Q?xut2WRHXDdSrbp1yxzHpf7WPq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b917e4bd-f301-4b0f-22cf-08daf257a3e2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 15:39:05.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dVAwm3uKAToxc1JFWC7/zugXfAuQFbDVBWakZZyVD9qQSW2XkQZEvd6qajT/7HP6+UIs7Rdq0yuTJteqovQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/2023 11:18 AM, Perry Yuan wrote:
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Tested-by: Wyes Karny <wyes.karny@amd.com>

> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..c17bd845f5fc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  		max_perf = min_perf;
>  
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)


-- 
Thanks & Regards,
Wyes
