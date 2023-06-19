Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5606A7349D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjFSB61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSB60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:58:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E5E44;
        Sun, 18 Jun 2023 18:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io7lIAU39T5gYEr+yg+XwhcbaU3aLeGh883yhuv78FdEML0zk46xpXJ5P+TogpJV+Py4KQAhCn3Mo0IfvYdDqANppmdruPTLV91oMt0uvWeZgzNOCyLoBeddpRohxVgPYO1+inCzvH6roUUWyJAGFaCVYMFf4hN45OFbdQAAnTR7fbYt2ThxFpxP29Slj2NACmK+ngM5YxMdXG8N8Op3ttTXnmc0bKkgRkATQaWjRmTy/YtLyBgPsae7la9FQHIHDb4nxvMweDyGSZGc+9vuFSNRHVWdAOqSLVlW+V01Ybe1EhBKFKgJnDoQEUXRH/eIu0hE8ioPScvZKp0vjLzUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7IyC5eBR72u3qT25LgkVs3Ha7OgwOLOtOOp/K0ALyQ=;
 b=fDxwJpFRzt3gHh7BTqiEC3XPFIpBQxE7W08tIois1TRZOfriUWM8+Kkb9NS1m/l1+Q/QICNH00np3aiuVvuSrIzF/ER21khqpk0F6caGUzQWulaGB6jR3yF8tUmtURsQMsew/QQF2rq72gd7sQmCUU7rQds6OaA4PTMlkYIhNwG606BXU9RnQ/aFisLCQgCM3CCtBAwJ5+7OidKPoCZ7Xy0GMy/a7ZyDrX9+6Zqx8P7QHUZCaUre1LWn21G49n2EeN2pmL/57h0Kt+ShNXzSNMxHJJ2ZUA+WfZbe8SpHpdlZR0M7JJXzfBgWhBattCfBbL26W0DeFYOyAcAmMss6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7IyC5eBR72u3qT25LgkVs3Ha7OgwOLOtOOp/K0ALyQ=;
 b=F12cJC5D4+Za3yXqk18cT5tnnozAoZKoZyhC+JPk+0O1cVXM0zOKqOOMvG4uohQs3pBde1lAXg0Yysmi2dO035lAte7/qgeMvSvdkvbgug3DWzWgCMgzFvAOMbrXGKdjEkoITbbAYKJ13gDFJpPlqe3lLErf2kTd6sD8Z65gnj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 01:58:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 01:58:16 +0000
Message-ID: <348fbe1a-6c2d-68d2-b4fc-278407ede33c@amd.com>
Date:   Sun, 18 Jun 2023 20:58:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/5] cpupower: Recognise amd-pstate active mode driver
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616120620.147643-2-wyes.karny@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230616120620.147643-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:806:20::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0a8872-3ced-4949-6425-08db7068a5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnYtbbuJDNlON6Qndo9ZuA3+o9nWWw1WMseHssNk6HRYIdEBmHI0MOclPA6L5tNeOMLapJKePPw4OvvfS88Tf+UF5lx06Muq9clvP3lB0sKESJ3AO6xIYyHQkentI5Gp/PEA5kP6EoT0y5S26FenwCThE66moGyNWG0Ak5za2eKfyQ8aEbXiMRlKe/cYVHA2CSk5T7yZXl0iNH7kQ0mjRYdekN8OwtlweGH0zJUgBANJpK0qNJ3FKX2UPq5812pVRd2xNx/SVQ9l4Cpq/fyGJhBQPeGwoQjOC0CorTTyPJ6/lsjQQl6aQrL2czog2GWFbhS0JmxZfqoNeeNcBbKsHys8zIOSG3/fGxFgsWLBNK+ZPP9pzmNNj6oyO1C9idybHHARO5u/tAQW0T264vq3pdF8bYeFSRRqOeP8lPe+wJzR8svO8FRT9zu7un1iH0vug1V2PWRi8KiNvBr054bJJIt7SE0OSq1lm1IhGHWOGktGAD1Q7jmGKtzRfXlIW3tl20PJitn0sPlGuVhNU1Zb3DJhfS9oMPyUtZcZXBLLyKWVt36ypJIL4GX4hbVJpFbxVXVAV0836HarcJZadEng6tvbZIcmz8VjEF5jNsZEr2qlx1NgMi8K2vEOJJ4Vs32YM/dq/5QONnLeLBx4C8MleQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(478600001)(66946007)(31686004)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38100700002)(83380400001)(31696002)(44832011)(6486002)(86362001)(2906002)(5660300002)(6666004)(316002)(8936002)(6506007)(53546011)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzE5K1RPaUVNMmRkSE1kZzdETlI1NllvZy9HTzE0dEJTWTNkcHMyN2FWYnhX?=
 =?utf-8?B?RlF6T3FtM3RsYnplZVZWOXlDQUJYRHR1KzcrWUVqUHpYYWN5VTd5UkdCc3ox?=
 =?utf-8?B?ZzY5NVVlQkUzbG1BMlNHdXZNT1RLYWgvSWQvbkR0aVZKNG1OV2grN1B0aXJZ?=
 =?utf-8?B?QTdGNTIrMkN4cU96ME95bnFZSGN4Qm5xa3hnWDVad2hsUFBhMDZHdFhNVWhQ?=
 =?utf-8?B?MmdxUnBZdkRGU2g2Qk91RTlEVEdMRlJHUllDTEcwc0tHSXhGTkZMbU9ESFha?=
 =?utf-8?B?cmxnRlZ1M1hBLzdabFNEemlRdXMxQWt2Q0VyVkNjTUxobW9hNktuczNFNE5R?=
 =?utf-8?B?eWN1UHpnTDdvY0xEUXJKcXk1TCtGR0lvT3YyM25ZYkFLYUpUaHZiVElKeWZo?=
 =?utf-8?B?UG8xdm1uQjBnc0JoUlpRWm9YTS9VdXNGT3NrOUpHY2F2S1VGTmRncU5ocWdm?=
 =?utf-8?B?OEJSMWdJQVdhRUFtR2xSY3BNUzZ2MjdpU3o1NllxK0xoVGdXaFIxdlNzb2I0?=
 =?utf-8?B?UlY2eVJHdnd4OWYwMENpNnlyQkxQMmtZc3VYZ3VBYW5IMlBjRlNyS3UwaHFC?=
 =?utf-8?B?WGFOcXdPOXB6NXY0a3ZKY2R5aGhQaEhxTU81ZVVnYUdWb211cHJTRzVOTWcr?=
 =?utf-8?B?ZWpxL2E5aFJhbndROWx1SW85UXhyQ1hyNEVjWmFPQUZBNjhxdVZINHl2Y2Yr?=
 =?utf-8?B?R3piUXR1SERmOWJDQnNYKzBXbHRaMEdJNlZNZm9yazliNGZ4U1N6TlNna0Zy?=
 =?utf-8?B?ZHRXcmNlQ0ppMVdEK3I5Q2F0R3l4ejduMFpuaXdrNUY0THpEUWF6YnEvT2pG?=
 =?utf-8?B?cjZMNmc4RmlxWURsVURYUURPaE83ZzBRYk9aZndLZkhHRU5RM3JLbVlDVDhv?=
 =?utf-8?B?dEczamNzYkdzS05iL21kUkp2TFBCNkhXNUlwZXBOVVZzdnN6TVYwdjdDTlJ2?=
 =?utf-8?B?ajNRVTRJOG54U2lGT2dxa21rTjRDYVVVZ1BZR1doUzJJdnYwU2MrcEQzRmxZ?=
 =?utf-8?B?VS9UQmUwYjJ2QkpjT3pFcnZlOUNMZGNGY3pOQ05wY1U0YlpsUE91clBiQ24y?=
 =?utf-8?B?Q3IyVTBlbmt4L1JMTytJOE4rNk5WUVkxNlRZcEp4US9ra0JlY0Vva1lROU5Y?=
 =?utf-8?B?SU0xMHRKblg4MDdIbGErdmF5cHhsMDJPL2dTWVBQdUI3ZTAwQVJzbnhMTzFW?=
 =?utf-8?B?MndSZTY3ZlFiOGdqTno0TFoyWVpud0hSWmpiK0pSZDhPRDlpTk0zNHlkdnZn?=
 =?utf-8?B?WE9LT0R4cXpnTVFza1dGNit2clZIdW5iZjBZMjFseXFiYzluNktDQ1U2M1E0?=
 =?utf-8?B?aTA2RHY3VU1qTWNPTzg1RVRHa3p2VC91QnlOUk41a1N3QStTUlptMHN6U1Mr?=
 =?utf-8?B?UnNSeWJYWUxzdExlUWtyRHhlK0F6RXdKZTVwMGltWjVrMElLbnRQdEtOK0RR?=
 =?utf-8?B?OXUxSlAxMFJNWUZkcHZUUTlBeWhZMThIR1BEYmxVdjNxeGt2UUFPZlMyamVQ?=
 =?utf-8?B?bGdLYjZ2V2FmWmdlK3o2RlFmbFdGV2dWa2hIWjJucUhmQ1lvUTRDRmVtbW5J?=
 =?utf-8?B?MUFJU3NVSmtjZHlJRkg0eXZGbTlRSDhkNTJyUWlIL080RGlNTVpqK09aMzFm?=
 =?utf-8?B?UzFEbDFaa0drSXJPc2F3MTY4S2JFYXNQTldnNkNHeEdLRjRPaDkwNVd2YnRy?=
 =?utf-8?B?dW1nY1RjV2ZXVDRnY1dFeTc1NlFXbXRCakpkaU16ckhPc0l4TEVtcjRnOHpX?=
 =?utf-8?B?dFhhREVXcVRFZk95UkphcU5Qb3NVdFFHaDgwWXhEZmxtY0VnNlYrR0d0RDJt?=
 =?utf-8?B?bm5WMXZLcnA5a2NCTzdBenplZDAvRExMdXh4bGtCdmVXaEtTaTRjbnphdU50?=
 =?utf-8?B?ME1qZVlhUmwzUVo3S09ib2R5RytKL2RORzRtbUsydnU5NzcvTVdsUDRPUTBM?=
 =?utf-8?B?ckVXVGtNUXg0U3JhVDZVQVZ6M2JVbHZXdlFhRUJSMVExYkFiMDRxbDJ0Nk5q?=
 =?utf-8?B?VUIyUjdESU90SUNhU1B2MW81d1k3bWlqMWZWOWFVcDUvUzRuTWRLQkdHOFJQ?=
 =?utf-8?B?TjlMKzE0cTZpNjNaR0RZNmlVbFNlVkhZN3crR3pjbkJwU1Fka3lQdk53S1I0?=
 =?utf-8?B?UGsyYVFsajdtYzBxS0lFN1V4enhYcE1RTlB3K2F3RXB6TEtldkhTRTB5SnNs?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0a8872-3ced-4949-6425-08db7068a5b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 01:58:16.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK6fVDQPHFYmFRRub+Kru2rF+Z5tlInzs9SmpJj4700kmljl8z99ip+GhP+O2okP/Sax9gx0LAxnOOrQWFIvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 07:06, Wyes Karny wrote:
> amd-pstate active mode driver name is "amd-pstate-epp".  Add this to the
> string matching condition to recognise amd-pstate active mode driver.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/misc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7..21f653cd472c 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>   	if (!driver)
>   		return ret;
>   
> -	if (!strcmp(driver, "amd-pstate"))
> +	if (!strcmp(driver, "amd-pstate") || !strcmp(driver, "amd-pstate-epp"))

To avoid getting caught in the case that a kernel didn't have the patch 
separated from this series (for example if a distro missed it in a 
backport from separate directories), how about using strncmp() instead 
and just look for the prefix?

This would also let the tool be more future proofed in the case another 
amd-pstate driver was introduced later down the road as long as it stuck 
to "amd-pstate*"

>   		ret = true;
>   
>   	cpufreq_put_driver(driver);

