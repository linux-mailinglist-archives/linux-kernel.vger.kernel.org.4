Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D5735DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFSTIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFSTIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:08:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89B101;
        Mon, 19 Jun 2023 12:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhTW/RdxJdt8WTNEKv6G+eMANRE9jpDB1+jNCDCpDWv0ebThRPT0Tqx6dfg7I9MufghdwWI/RuxFrXicAoWhT0m5XxnhIoRZ2GAajeayr+Cl5ussRJ5RNcu7rEsEgaEjFLZk0CTH70GYiS36VSWroP3hshrg0dt0KbMCQy6SRMs/QOd2vuaTw/rZUnARV44gRw1mqza9SOYtiJ8Aim7S5pAelLbpQozLcTH+T9sZUrZVqrf/ZoSB1M+gdEFCqAnnH4Gy8oQlVkKffyMRRPQdwMOIL2jQ2dZz7lkB+I2kpRoELzXPfSp089erKXd6B7OUJKm9mgpTNlJhUGPgukglDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hIL9kpOtLSJNfPX3wBS6S/3iU//uwEBOFZW/WD2zV0=;
 b=T9FDZHXYwpd8rBy+wD35e2/r7DRDdjBqBccLaF4lLn36XVa5hc40BhoRhqizEZY9AA3a4m+3l4Us+fuK5AOxrLozosnYc4gkLVQyhGIiPN/SlHZoq7vmJ10ayUOf4ewnPfa9be+BWW2eSc4LYulG3yrHRR3xcieezmC0MrmXt7rfGohJiNLAx7/AKn8DdRi1/kAdx9pRCNSFAOCvsvm+LQSdC2hpLm5VhWMVTMqJByqDsfCk5PcM4fEpf1at5rQBkoD7CVAHnN2CvJCFEHGB9MB28KTxIX5DpKzl6o1b9V+WYv3719IKDRLN4U6Pcm2NDtkQPRynbFlPgmMS/9SXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hIL9kpOtLSJNfPX3wBS6S/3iU//uwEBOFZW/WD2zV0=;
 b=P0LJ+Pl1dVj0wd6xmIxvNNtOJG20iQnA0/AIZo+Cpgte5nUahYHJSxWyPjjmMCFlzGa5PIa8razDwhVB0nsFDRRR6/30HFg+zHVXiL7RM68s+FHqyRhcDAEzReI0K1qBRjgzOoF0uBySqVsFacoeeAFidPZt0UOsmV9m1bD8lHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Mon, 19 Jun
 2023 19:08:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 19:08:35 +0000
Message-ID: <b888fb1c-7e44-fbf5-0323-deea156758fa@amd.com>
Date:   Mon, 19 Jun 2023 14:08:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, gautham.shenoy@amd.com, Ray.Huang@amd.com,
        Perry.Yuan@amd.com
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-2-wyes.karny@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230619190503.4061-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0004.namprd05.prod.outlook.com
 (2603:10b6:803:40::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 42394fec-5c81-47f3-3710-08db70f894eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN39D+CCyzB/SlWKqTdWm2SGQCVb7SqtuY1dNTpnK6ieu9JN5ruI7SOqykAOgvjuUmDXNU2Gw3cU3J1fHDTHe3E253AXe3fSw9y9OvrkAl4962J4rLUHE2oe4dXw2b9g7/Qa4sNZZ7iVy/adZLYiNV4iKmefWbd5aHYQ4uDnOfoA3k2YjIRJps+imZzUKwcTnJJ7TmNKUYlkvcoEYVEIx8tHgPCakSCmV3oIbiJPwxkVcGJwhbom1no5F2zs/TTbiMfp6EREr5VPKOq1eW4c4aPxUmeHzK+8qXPydoUto4c22YpPPxEWDwQZJZmpYXasNIEwg9Fy6jDgfGNO8gGpu6Jed3HYE5GOn8VgOVoNEr4WmVnelBxdxvnw0/7cr2qw/U1LUlvqZc/Jxm7/I/yxrbZS6RfFpV66+03ikD8OCE1RFUrXFGr+0oVHFzYQfnA25JhryrZ+UrwdyFBIMCDbTuAZSp6jaBShaSv1vfd4ORqx0dwHEJ6jORunktIA5zeR5aCcNfsTU4K3GSxGCbLlTdPvN+sfVi7xTjaCOM0gXgrjCri6cZoV0XepWnFTBrLk/95eMlT7N4GgmuBx6ziZmTZNHBzm1LQvOxvw0/4Mi9O74WnpDvQUIFxVIHdzXqJ2i1dSkaEqbZ3TzxHMwTmG/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(5660300002)(186003)(83380400001)(2906002)(31686004)(2616005)(6506007)(4744005)(41300700001)(6512007)(8936002)(26005)(8676002)(6486002)(31696002)(316002)(53546011)(36756003)(478600001)(86362001)(66476007)(38100700002)(66556008)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWk2RmtQdFFCS0tFWnRtMTRJNks2ZHZERmtYY1V4MGRvZXUxOWFOY2hJN0hv?=
 =?utf-8?B?MXZWUzNVbTIrMGpVamdaOTVCZWpsVExwM040aW90dHdTV2VRTHFqZ1ZRMjhL?=
 =?utf-8?B?Wkw0R3RKbGZiSytwUXIxRHord2o4bDEvN2VXcFQ3M3pVR0psdkYvUm1qUGlU?=
 =?utf-8?B?RHFRUERCUGZaeU8rM0RoRzkxeURCUW9oc01LN2VXMURMdkdMV0tyRUhSd2g0?=
 =?utf-8?B?ckZvSk8vazg1UktjUGM2U0NUQStXbGF1OU5rVURTZ0RoVm1lUEczVnNFbm82?=
 =?utf-8?B?NVNaanlBZVlzNXViUlZNcjZnNElYbS90REc0ai9LY0F4ZVovVmxMcUpCR2R2?=
 =?utf-8?B?TFdZZEdGb2srVUpIbEs3Vjg4cFpuV2V4d0JPWGJkOXg4M0dJRGk4VDVrSkQx?=
 =?utf-8?B?bHhFNzFCYUtYZ1lXS1YwbmM1SzBGdjZPclRHL3h4dFFRQTBRekZhalpWdVB6?=
 =?utf-8?B?YkRDeUh5NWxpbjBTbVQyU0psYkhtWHBZUEFPUkpFaS9GYzBGQlF6aW1Hc3hQ?=
 =?utf-8?B?aVFUcjFrQU1rNE5KeE9CaTRsbWpmd3ZjUmJwUkhMTkFVRW5ydFpCTUl6amxW?=
 =?utf-8?B?Rm9TU0k0azJDRjRMVVNlNnNObHB0S2taREJPWHVxZ3pNMjMweXgva011cXkv?=
 =?utf-8?B?SVd4NkVkU1c4dmxtN2JzZHc2WitEY1RNMUczNWo3c3hvK1V0UFRiZ21LY3lE?=
 =?utf-8?B?WTFtTGM5ZVdha1Vncm9DZ3NOYlhBTFB5cm04L2NEU1hWM3FKQXVQWEp1d2RE?=
 =?utf-8?B?dzAvaXdENzdpd3VsWVFabGswTFpVaTQzN25ORlpuR0QxZWVGUlNpdGhnY01m?=
 =?utf-8?B?Z0JoaTJnS1JKUkc5dmR0Y3R5K1dIM1hNZlZHSCszOFBxYllkSWdvL1ZaY2ww?=
 =?utf-8?B?TVFPTjRBbUhZR29mS2tMTTZsQjJ3ZnVRUzVBTjhJS2JEcEd0UndNNktKM205?=
 =?utf-8?B?Y2tOV1hYTjF4dFFnTHVWa080eitxTjVZQXk2aUZzQWoyZWpvWHR0VTVBUlJi?=
 =?utf-8?B?Vlc0THJNUFRSMGVZeStoR3ovcy9xVFZkZnc0eVdsWHc3eXBlOXhqUGQ1Z2JR?=
 =?utf-8?B?TEFDY2ZSOHkya0ZVK3YyRTRGeTl1M0wrY2ZDMmkvcnAwU3Y3N3RSak11UTFq?=
 =?utf-8?B?YkhxOXB4L013WUkzeUF0WGdzOVdHNnIwNUQrNkh0WjM2bHhZMEFCbngwbWdi?=
 =?utf-8?B?eEN3U0JCSWtKNWJhK3B0RjNqdkF2U0RRTDFEV2FRT0RVMms2UG1xSGFScHVQ?=
 =?utf-8?B?STA4T2Rod1k1UXh5UzJyTWF4Q0pzK29aV2hxRzVhd2FBSUZBWVpTQnBPUGlx?=
 =?utf-8?B?RmM5VTJmLzR1R2tjRDhyWmdpTXhENEpFNUtRaCt1THdSTGpIWUVmT25lWWo3?=
 =?utf-8?B?Mk1tTEMvQ0dndXFZWllmUHdSZ3F3MzZ4S1crRXd6ZGhxUVFQNVM5RGp1ek5R?=
 =?utf-8?B?bExYWm50NFhmdFN3UUhJMUxnbDFYNGJJTU5LVUJJdGpCTys2TktIYVN5WG5m?=
 =?utf-8?B?cThjMnY4cCtYRTQvZlNaOFpEMVZMNktrSkJLaCthcy9OakZHbURFQlJOUXVn?=
 =?utf-8?B?UlEybldPTnF1cnpRa3A3Zk1QT2tvMVYxR1V5U0lDV2pwZ0pjV2RQaGlHTmRE?=
 =?utf-8?B?bVBSMmxHVUN2cEEySU11bHZHZmIwSXljUjRjQnZJVURLVm8wS2lPSjNuMXY4?=
 =?utf-8?B?L1FBMzdEVHQwZzhkS0Z2MGRZQlhtRFFTUldXbFR3SVM1YWx3V1VkZWM1ZWFu?=
 =?utf-8?B?ckpIckJ1MzlORm44K2dtVzFmdmQ5NWh6MTJLZms3dU9oVU9yaEd5a1pqT2NR?=
 =?utf-8?B?VjRtSXlSSFBQNFBPaTdUeEhTQUxMb1EzM2VONFpPNkk1YTR1MW51MXAwWDNi?=
 =?utf-8?B?aFU1RlNLc1BXb0x6K1dQVHFkWU5qdTk1WnY3LzJyWWppbzRhVUltS3FZNjBo?=
 =?utf-8?B?WWdaN0pBSzFMZHpLWXIyQUJXenpHRjVISExlWnQ0LzdQVWVpS2hYNmFweDA1?=
 =?utf-8?B?bndPNytSdW14c1NPejV2OVE0Q29jSVlmall3RkVRdnQrYjNOdWxxeWRZeFBw?=
 =?utf-8?B?MHlqZXRlTC9UN3JKMXAydmpMdFozeUxHSDQxNjVVQW8vU0NNcVJ4QkIxSE8w?=
 =?utf-8?Q?ctLsErm9hKuXeFcjjOVEdZbbo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42394fec-5c81-47f3-3710-08db70f894eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 19:08:35.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ccqp3cKcmT+Mt0uBIAp40v1i/Jb65GYx+LcrbvgdzDeUOZxRx8Goi0Ko1U20MzM7B6y3x6ELisz6ZQi12+lQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/19/2023 2:04 PM, Wyes Karny wrote:
> amd-pstate active mode driver name is "amd-pstate-epp". Use common
> prefix for string matching condition to recognise amd-pstate active mode
> driver.
>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   tools/power/cpupower/utils/helpers/misc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7..0c56fc77f93b 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>   	if (!driver)
>   		return ret;
>   
> -	if (!strcmp(driver, "amd-pstate"))
> +	if (!strncmp(driver, "amd", 3))
>   		ret = true;
>   
>   	cpufreq_put_driver(driver);
