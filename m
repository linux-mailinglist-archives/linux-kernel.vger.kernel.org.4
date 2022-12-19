Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69316515BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiLSWzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiLSWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:55:25 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D7C12D3D;
        Mon, 19 Dec 2022 14:55:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmEMxJdbofgVzaZBHdq1itE0Ynncf67mO1auhxkesAtaspzfE8YjehSxGyRhYP/dP6r/56V8ESey7UdwPn1bP5KtLcYw0qM/RjbIX6VDN/9jz+aL379IW7mBnorEC+vA5zGaqwY3IWQ5USnPuPkvZCc+ZRKIcbZ01S5H6JtkVq4nryLJv93bKcm4y3OQlP7jillDuYd6Q8xalVA4AjQB/qPLaT8MdXwBVrpA6SMqwXNE8PQ5v2HwYNyIJYaq7qgm7eTbrNzS3JTHujBJbstkIPPA7yfNyO/hwQqJVSrUhlIbZEQ6HZyE801KQV2/M9NImkmgCulPZIfB3EksQI/Utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNDoFPmVeb7tmsycbodwA6+cJ2kLW8Mh5F+zOTQ2ybE=;
 b=ho9O/NjMbJN0Jfyd408rlKtdGOJ/hKBLqErZlZ5s16ITRrCrmTI8F5CboD4cy1wZwk74X8j5m3cSu/FSVDu3UBU2DUnlFfJ21K//RFfYhJPHD5GpzU8mXhC8796DF6qUoYm5JkNJIdz8iogctE7SkkOT8TucdHkI6KPyIw2yqeO3/YeY9OUSal++XBWXtXPr3fRq5CvNdaTCntnsLEbzH/Ljbj+cg+cuJJ3V8ncyKoB4LFO29tE4mqdiprvDbo8sERNbfX5oPclnF0T7XhbL9sCMIvc42uAIHKiLAO/GzKR5JouPNEGn97CP+n0o4VECdXkn4ny3peqLLgDShTdgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNDoFPmVeb7tmsycbodwA6+cJ2kLW8Mh5F+zOTQ2ybE=;
 b=uvgtgAcqKYB9XuIpa9TpApFcohld/UCS3Hofgo0XL6Q0H+OxZQ2jGXEVpCvwHDnNrL9FB8OFn3UvywrSwsjIo7d0zJG34p2adPLzZ1QrUTF13oTskzZ25qDHdNoVipstvgZs1xhMyyfWQ1nR+2EdrVKXYkJcQLeUvZUka4fz9yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 22:55:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 22:55:22 +0000
Message-ID: <910badde-2014-0acc-64c0-5d5cf07716fe@amd.com>
Date:   Mon, 19 Dec 2022 16:55:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 04/13] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-5-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221219064042.661122-5-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0412.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: d6499a7b-b6f3-41a9-0b89-08dae2141bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Jq8PaF1JB3BTMxtAuiERxzQQwDzpH+c4Ed75LqquIfSi30HJzD4imoCXFlX73B1Alh5x5GR+zm8lQSF+gBbiAhnouv6hzNpS/OAzZr6sJQWdBsrXkXqAaXsrMJ8ukcvSkgqLw+FpXPg4aOIwKr3ubOYwBPno2uQLk/AykBLHnyxQVaVp+Vd5Wm956dThYMaevy2Mt4zBrYRzsBdwBPXP1RgVHyHUi+O8VTkLalx2o3vDuq9a6Kx5EsGJkxYee6hOCAtWbluSLk8MtMQbPBIL0nIarlS42xnO8zKjUJHQllCMmfWyplJ3+3xK9JPW9ugG8PvzvxfLDuU0Sfur5aAeuhkBxL5qO6HSYGjEUXX2Qf+kNUSoBYX4tL6x0CyOkZEYrN+XEK7ZD6TI1sJBSh0g5hEf8LZVRNFvG7T+i5XZQCWVXPlWwkL2jVARTH2Ib486XfvduJtZdThBe2AIvKfwLCoZZZPXFxsl/843PxUhwP7tghtN4VlvhLhajdkVsm5xTBNK81Ni7UEAGs3PnWD4cFg4gTpAN+RrLGCtkhd8wqge9/AaeV7tHVSybTTmrHAzHhcnXldxwRqWwidsaoqFVhOqwBntKujsXoqW1HkHgTNuWTaG3X64pIGrcB+XpYQt/PN078WtY9dsdc2ewQuWPBKrfXLRfoXJKUvA1MLeQzi8u8UIA1A71HavwU5a6eOeD/Xqin10aKBdGZKel2NlIlpCnGv/GE77UJn6S6er8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(6666004)(316002)(31686004)(2906002)(38100700002)(6512007)(66946007)(478600001)(31696002)(66476007)(66556008)(86362001)(26005)(4326008)(186003)(8676002)(36756003)(2616005)(8936002)(6486002)(6506007)(41300700001)(53546011)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9Rd2l0dmIxTnlqYU5tNDBGMDNERkhEeldmMHFBajBrdklTWHRSQmF2Vjlu?=
 =?utf-8?B?d0ZxL2VVMy9uZElvYlVWbGYzQXF1c2lqMEFCcG9GMElBdGsxNFpCZmJyZ01E?=
 =?utf-8?B?dnZqSXNTTTlaelY3Qm90TUtVTi9WV01NVnBGYmdmTXBsQmtJWEtBRnNJYjQ5?=
 =?utf-8?B?bFQxVm9XQmVXamxtTXBPSlBIcGx2b0hUQ25HQWJKTDVDaW1sMWRlengra3Ez?=
 =?utf-8?B?bm9rNk9wNWRHVVErL0tRWFFnU0tzUm1teGVONnNBRDJrajltWjBUSFpSSEl4?=
 =?utf-8?B?YUcvSkx1ZHZNKzNaTVZ4eXNGOHZTTFhpTnV3UkNDSHp3aXJHMFhrVSthTzRZ?=
 =?utf-8?B?VEhFUjhvM2hBaHJBekhWL2plajgyRHYrQ0lHYmVjT1E5QlRpYnlrcWNHelhr?=
 =?utf-8?B?bGR4bElRK0dHeU5BeWpST3J3cmx1WHVqTTMyZHpiUXFvWXBpKzVjR2VrSDNB?=
 =?utf-8?B?N2d5MkNnMHVzZC9CTWJCSlNid2hoZUhmL2pBZGJBUWsxYTZGUlRNc0JWeU8y?=
 =?utf-8?B?WEZXYnlFdmd2MEZLZzFuNHUzaVVkM2ZVVS9pcEpLOTcvcFBMNWorNE02SGdF?=
 =?utf-8?B?UUVRbmtuQ1pOa0haZlp3anJxVjduMHNyeWlHS0JFeUR3UFpiMW5ldGlYb1VQ?=
 =?utf-8?B?UkQ1OGptb2N0RUVDZ283MFEwYmZmRGNPRkxxdEhSUDgrUnVPOVpJOEVwb0x5?=
 =?utf-8?B?cDl0dHNrTmt2aTdrQVBEVmpZaHpRWEp5RTkraU9uSmtUNDdESXhXWlFTNkwx?=
 =?utf-8?B?L21sMnRaOTNHdFBQeFc4aFdiTWR0UWNCclRoOHFhRmw5MXh0bXdvSmhhOUhv?=
 =?utf-8?B?bUowdWNCZDdjUWR6cW9EYUNFdXIvTFR0cEdsRzZFdVJyQ2xqcjA1WFFYV2VH?=
 =?utf-8?B?aHNJOVFScmtocDY2R3U0b0tGOGg2Nm5jRWRwQ09SZDQycEQyTEx3emVaU2R1?=
 =?utf-8?B?N01KalRFbDlhQnJYcVFCaHFQbjllTHdwNVVvem5xcHNBVEpVNXdFT0NTeVJC?=
 =?utf-8?B?VXQyR2EyL3NpUXhuQUFwMjNnclpoOHkzK3M2QkhpdUFOMXkxVmdGcDRWZUFa?=
 =?utf-8?B?T1gxUXY0UmR0Q2N0ZHVueXgvMUVkVEhJa3dsVmRUQU9CUEZiOXZ3MGwzWWlq?=
 =?utf-8?B?dUJmYVBFNWdGMUdUcmpYNVQ3UWlyN3ZNNmhHeWt0cXZ4Q2R4SVg1Wi9Rbncy?=
 =?utf-8?B?L1lYWEJEUWxKYno3YVJ5U1AvVUFzV0NtOVRKNlpjNkNpaXRvQUMrM0pCenhE?=
 =?utf-8?B?cGFtNWZlWGZ5WE9YSnpYUmNrdW01UzA2bkNab0QwVzYrTlNObWk4eStxS1lR?=
 =?utf-8?B?WU0yYW9WMVBIRmRQRGE1dlpCNEJiWkhEbWRyVHV0K2dXRXRPb2dNak9vUDM4?=
 =?utf-8?B?VFRMcjdwT2ptenRpL0tZTSs5OTZEYURSOUliZGRJWVdxWE43SlhzamMzZFJD?=
 =?utf-8?B?WDUwdG9kaTJ2Q1ZZdXNadThkYkxxK21ja1E2T1A5OTNEQitHRUNYMitvQWkx?=
 =?utf-8?B?UDB4d1g0V1ZrckN1eExxV3pReFFnOFQyZEx6bTVURnlzM2xKVnBGZnNMNTMw?=
 =?utf-8?B?MytmRjJmV2xheVdSM1lkcVYzL092SHlBTUVzQkxBa1pvQmxxRFJUM0xuVGRE?=
 =?utf-8?B?V2E4ck10ODlkdmZYcHVRRmhIeVBSYmNwYUNOc3BTVEVieVBET2ZwWWhKT2dX?=
 =?utf-8?B?dzNjZzdXQ2M2ZnNaQ2I1YVpyeU1CVzRRM2k2NHFyTHZDSzI3ZWJkakVMRnpU?=
 =?utf-8?B?NEJyOWpCbXdoeDk2WGpiRThyeHI5ZEN4bW90QzZKU3lpS0JIUEsyeXF5ajFU?=
 =?utf-8?B?LzM3bjRObGd1ZlhOa1VkNW1vcUdYbXdnd0pxQWdEQlVCVFQzS3gvUU5BU2xZ?=
 =?utf-8?B?a3ZBRFF5bEJqbU9RNjRFZ1F6TUhITFY2VnpDSkJBbUlDODArbFRzaGFGbTM4?=
 =?utf-8?B?U0Mrbm41SjJRclBRdDZDMmdpZTFScGt5ZVBiR0c3bkpnUkhsSDRRV0tnNFlp?=
 =?utf-8?B?dm9uM1BMNWlBcGRJL05tUzdaL05RMzZER2VWZExGQ1c1K1JHclhjODluQUtt?=
 =?utf-8?B?bWRJdThFVWYydFlPcG10clVNenBUcTF5Sm9nOXJZZDlseW5rMGhCcGxZc2JV?=
 =?utf-8?Q?m4Yyk/FWJomNuWRrnCl7It3VI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6499a7b-b6f3-41a9-0b89-08dae2141bda
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 22:55:22.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbWf02nHPNsmFQrTf0wV9G+aC4JNCVGzVAExLbYgSfQDmrKXpUpncwc80z+ZSgHOybnRqy4EqH09E/rWpOxHGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2022 00:40, Perry Yuan wrote:
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>

Even if this patch comes into mainline through the series, this 
particular patch should go to stable too to fix users unloading 
amd-pstate with the existing passive mode.

Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/amd-pstate.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..c17bd845f5fc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   		max_perf = min_perf;
>   
>   	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	cpufreq_cpu_put(policy);
>   }
>   
>   static int amd_get_min_freq(struct amd_cpudata *cpudata)

