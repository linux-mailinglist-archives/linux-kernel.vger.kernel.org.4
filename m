Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6465BC6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjACIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjACIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:44:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40888DFA4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnhPn8mNygji9r61PrHpHtTY9I2+a8ZYD/sakB6y+85XJD16WlLnowFi9xHdMSS3kldPd39AT4RNyw4XUVAVevyTYyhvy73fmE/8j3KZ9bPZzphys6IJQlFlERKaA6Dv7AwiMcbsSb0mvN926dgrtE8hnI03Gz4RjrCB5QEJEWjkRonBFA4NFAYz2hB7Y+9BJYl8DQY2+0570OkFpB8GiXN/xNz4CYT1MRZEHFbWJdcgY0kgTGvoBuzWnV0IpQYPbtS6Ryidz/DTvp8ZP9IGbLymtKtVcAv16PI7kU6FSEfcg/PbXACYTmVvnnIDPn2u1Dyy3z2qDU/pgerCr5AxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84AScyRPbNWnTracFXRpN3lr2M1UWkh2AKxKreheMMg=;
 b=eQE4LeByLJmTZqAtxt2adM5YnlCIkcoNne7pKaz9xszklV/Y+TgQuRc2y0mdUmDp2UuuIlEx9NxrYaL63Mtcn96MpMFM5OhvFmcp/lroXCpxgQpUeHyOJXOIDlfFuozGrvrLjlkcTIxvmSSkCnNy6yGNo0Pp4lHB0Xi5FAo72LcWw0idY+b/Gba5HVVY4uGT2/UzPnjs6RAF/wKJo4VNTK6L1qqrDMTvOgfTo9POO/NRWrYwuyuSYnLtkcsd2mhLu6S5jaH+C4EZrsun2x9+qzB5aJNqZjgrukBzQbu45P9hCGH5cb6pKbxpms8YtuyP0NIf33wX4UQI5e8VK7VzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84AScyRPbNWnTracFXRpN3lr2M1UWkh2AKxKreheMMg=;
 b=39M8CEVgBXA42rcraSEKP2pitaFHUCwh1oRFH3nBsM9cQmJBtgz00vilo1DykrGEJ3c81Im8GsSt/PsZl9rEuJECIPW4IwRndxvI0CAwu+NWIWptjyYOQp0ZnqnVGxkldRyb6jX3xwbmcJyCzFEMnRtpDJ+j1ZilD2fGTIF75cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:44:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:44:22 +0000
Message-ID: <5e192700-c54a-04cf-a223-281af7af0457@amd.com>
Date:   Tue, 3 Jan 2023 09:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit
 architectures
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Mendes?= <luis.p.mendes@gmail.com>,
        akpm@linux-foundation.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcb5e82-31a7-4e8f-d14e-08daed66b62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A2rgi7JR+c/qyLdrpPscJyGB4w7MqTOEIEUgx9EUdF8F0er8WwcT4mmVhy17MOlJIl5c7uQqdcbnEKEk3n2BuocnCLGiEBFPxshkYI9cCyRydMidn9Rwfk2EmnjH0SmLh+YBpTZmabagYMNzDjKqIjVc0icBQqe1EUrHpHGV0BkjW4f7S8jZBnWhHr9UuKtZK0poE/4zpJLpsUwrjZusPm9AklaQW9OasNgtWXXLspfhT25hZ8AcXsYlastdDHxrGYp43Fd4sfCRGmdvmd3mVJe/cjzR7fmKmtBRIjd0Lsr/rRLdEosJroiHP98FkOkmOCnHn3e+euTAvlAr3BH7kz1v/tcKH7dCw2zX49tMzwW+cGakSZvJJJj1SreJObmCKbQStVIIOKTY95aGoqm7iWMXqFU5Nqlxm2/sMLu8defuAmZxmzxoFvjrkuEbb39k1BDUvQJ5JNSNcI8rR4fcF2SrsTZFfkyqhzGnOrdxP2ryDCdhPyL7tDnuoMvG7/QEihU+HJwd475r/Nvy/bnZdgsE5yzb7qqx2T1lwrlb3TCnty7PXW5hk2qZQHyAIFUemX2gsRNy5eo69597UD7G0BYsNzziD0PJrVTDKJkAOotjvPKgN/yue4n0ibofTqVTbhSbldR13hjqJWOMBbHOi20rgiAfVkqYckvEDCp0XHgoa162DNg6akkAiECd1/VO0aiGiFld8IcGjtFyCiCbignXsMyXeZ1jFXZdUo6TavMCW/dARqYU34C8RW4EbVH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(83380400001)(38100700002)(86362001)(4001150100001)(31696002)(5660300002)(66946007)(8676002)(66476007)(2906002)(66556008)(478600001)(41300700001)(6506007)(6666004)(6512007)(186003)(66574015)(110136005)(6636002)(316002)(6486002)(8936002)(2616005)(31686004)(36756003)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01DVDFsNDkwUmhXQzNXR2llU0RlalR4bzNKTEgrcndtNC9OZTRPV2xQU3pH?=
 =?utf-8?B?N2FDMG43ejRGQzVLcVFTbDg2M2I4QkZINTZVVnZ5OTJ6UTVzSjdadlF1Rmov?=
 =?utf-8?B?bTgxT3hKM0J2T2x4MUdwQjJTVmRjOWF0REovRTNYcFAvZFZVRUJHeFdHUzV1?=
 =?utf-8?B?aFlEdmVCZk94YS9aRlh1MEZGRmZEQW1aZnZ4RGk5bHp3bDhnck9JdnJiaEd1?=
 =?utf-8?B?RlNJT3JOK2taOW5kUUNva0VOcFp0MWE3Z3hsb29jQWJxdS9yTkVLcUhSa3du?=
 =?utf-8?B?VkJySU1YMjVXQXE0UHNCckozNnNMaEVhMC9Yb05tY29PK0xPWHhqcSt0amxN?=
 =?utf-8?B?TzA2S1grTmdGajhHSVFJdllxZzg0U2YxSHk4ZVN4MmRERDVITC9ZSVZiVFNS?=
 =?utf-8?B?cTluQnlWQjQ0a3RoZDVjeERBRVdtY0Z1b2hIRFI3OGp6VCsyYmVDREIvbjI2?=
 =?utf-8?B?eE9aNm8zVHZXTk5sMXlZRFZ4N0ZVOGFPQXRaOG95d2VmbFVkRVhDWFNzUjBu?=
 =?utf-8?B?V1FRRjNIamh5UXM0bVZFQnJUdXZROWxENG5PVUFJY3J6aHJ3VTcya3pvZEx4?=
 =?utf-8?B?a0lrblZzbHY0cTZNZlo4dnZnU1JUK0lQTVhCVHpGUGRTWEQzWFhXNHBocGFJ?=
 =?utf-8?B?RlhtRUtuR0FiRFZKU1F6dmxMSmlWV2lVTVdQRmdydzhkbFcwYzVWeU5HTG5G?=
 =?utf-8?B?NHBIY2JQU0c2Z3l5SEh1ZmZ6QjJOUTJlZllpUGhRaVFEL3kyN3pvU0hLZ2M1?=
 =?utf-8?B?ZXZ6NEo1cWQ5TUQ5S1Uxei9nTGlHY08xSC9aaklFcDNaWG0yZjB0NHVLS0d5?=
 =?utf-8?B?ZDhxOFU3bmFVOE9uZm4zZGFXb1FSSTVEN29pS1JPaFpWV09KYmpGVkJIZTFt?=
 =?utf-8?B?REJoVElRdThaMzl6enJjVWs4anYvSVJ0VWp3REs1N3NXYTBGQTRFN3ErNHN0?=
 =?utf-8?B?MnZ0d1dRdXN5STVZbHVPUmw0RCtkM1ZsUDdUNmV2eFlTUHpnd1VBR0JIaGNT?=
 =?utf-8?B?V0lWV2x1eUoxRm9UeTBlbGFmSFlpQ2pvWlZEcUJiZnp6cVFTMXVhVWU4UC8v?=
 =?utf-8?B?TjRmMWV0UG1GWjhwTHJCQk9BWW16NVgxRXhYWTN2UmRtSDBocCtXaTR0VXEv?=
 =?utf-8?B?YXY0cjl5UXFETVhnZVJkSDRRb3BjZTAzMWZIZVpkK09PZ0NsT3VpRjg1UzBC?=
 =?utf-8?B?MG1TVFJHcjlqUUNDT2NXajdkNld2T3JGb1kxS3ZjZ1Zqc2lYMjVtMFNyOTN4?=
 =?utf-8?B?K0JlYWFWYlFCT1U3WGFuSTBkZnpVR0xLeEp1dDBza0lDQ3RDY1FCMCtnQTNU?=
 =?utf-8?B?MEhhL0d6L1dMelVabG9NZHdQN0t2dWFwNlJ4blgvOWcvVC9Qay81VWtOQ3JF?=
 =?utf-8?B?L0lHNERWb09PbWR2UHErWk9yRkQ5MFpxSEpoWmNmeDFnamNVdUFOQXMxWUhK?=
 =?utf-8?B?YTJtZWtGS05MRzBmQ01CS3ZmZ244YUFmZjZOUEZlbS91ZU1RRWpsRlRKQkFK?=
 =?utf-8?B?NkdxamQ5TUFoNnJPejVrM0l3WFc4M2NLYkFrYzZlTGpEOTVhNUpvQkNhSGpG?=
 =?utf-8?B?N2R4dXpCeTB5clVpUHFGME1QWXVlY0tYOTZ5a3FET2xpNHc2cURJMmpDNmd5?=
 =?utf-8?B?cC9QaktlMSswcXd3cFU3YWVDaHV1L24vakpSVFpKbjNScTFURG50UmJ0QTU4?=
 =?utf-8?B?VWViVGhOdWhlT2lKNnUxZm1zWlhZK05qQVdEcjE3OWFyQlkxN0kzdzZWOEda?=
 =?utf-8?B?Skx4RW5sSHFONDJldTFhUXAyWjBaQ3RiUjY1VitIOXdFdm90OXJERFZDMnl6?=
 =?utf-8?B?M1gxL24wSmtvMnFmZEI4Y21GQ09PcXR1R2daT0o2ZmtIYytaUWk3K1RJazlp?=
 =?utf-8?B?a2w0UWhiSURybWkwMVc2T0thcnVoVjV4RkJHUGFOOG9UOTBWcll1MUZJSWFC?=
 =?utf-8?B?VXBwMDZaY3VtRDVrT0lNRVZySVdONzMwQXlqY25hTm9WVHNQL0FNVnZob3dF?=
 =?utf-8?B?cmpYenRMVlBYL0VkbkJIQmcxTUpUeFB0WkNPWi82bzZwQTBTUStKaHNHN2V4?=
 =?utf-8?B?VThIYjlDa0F4M0x1OHFRUCswbERFMmNTL2ZhSXR0NnpzUk5yY0MvamhuVU1u?=
 =?utf-8?B?eFhLOGdLWUVueEQ4NzE4UE10bDAxMFFBaXlFSlNYMVYrUkxBYUYzY0pBMFI4?=
 =?utf-8?Q?NRFb8aZA6xITo99HbK/eLddEWV7HgzqW+N9tm2900+p9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcb5e82-31a7-4e8f-d14e-08daed66b62a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:44:22.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaXOGgG9hInCRSDVrbSC52pISAEl2Bck1yDbk+P3wrXXPrNGBcBiDpJJhMF7Ipqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.12.22 um 20:39 schrieb Luís Mendes:
> Re-sending with the correct  linux-kernel mailing list email address.
> Sorry for the inconvenience.
>
> The proposed patch fixes the issue and allows amdgpu to work again on
> armhf with a AMD RX 550 card, however it may not be the best solution
> for the issue, as detailed below.
>
> include/log2.h defined macros rounddown_pow_of_two(...) and
> roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
> architectures (tested on armv9 armhf machine) causing
> drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
> value, thus impeding amdgpu to load properly (no GUI).
>
> One option is to modify rounddown_pow_of_two(...) to detect if the
> variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u32
> n) or if the variable takes more space than 32 bits, then call
> __rounddown_pow_of_two_u64(u64 n). This would imply renaming
> __rounddown_pow_of_two(unsigne
> d long n) to
> __rounddown_pow_of_two_u32(u32 n) and add a new function
> __rounddown_pow_of_two_u64(u64 n). This would be the most transparent
> solution, however there a few complications, and they are:
> - that the mm subsystem will fail to link on armhf with an undefined
> reference on __aeabi_uldivmod
> - there a few drivers that directly call __rounddown_pow_of_two(...)
> - that other drivers and subsystems generate warnings
>
> So this alternate solution was devised which avoids touching existing
> code paths, and just updates drm_buddy which seems to be the only
> driver that is failing, however I am not sure if this is the proper
> way to go. So I would like to get a second opinion on this, by those
> who know.
>
> /include/linux/log2.h
> /drivers/gpu/drm/drm_buddy.c
>
> Signed-off-by: Luís Mendes <luis.p.mendes@gmail.com>
>> 8------------------------------------------------------8<
> diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
> linux-nextLM/drivers/gpu/drm/drm_buddy.c
> --- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
> 16:29:26.000000000 +0000
> +++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
> 17:04:32.136007116 +0000
> @@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
>           unsigned int order;
>           u64 root_size;
>
> -        root_size = rounddown_pow_of_two(size);
> +        root_size = rounddown_pow_of_two_u64(size);
>           order = ilog2(root_size) - ilog2(chunk_size);

I think this can be handled much easier if keep around the root_order 
instead of the root_size in the first place.

Cause ilog2() does the right thing even for non power of two values and 
so we just need the order for the offset subtraction below.

Arun can you take a closer look at this?

Regards,
Christian.

>
>           root = drm_block_alloc(mm, NULL, order, offset);
> diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux/log2.h
> --- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 +0000
> +++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.319901492 +0000
> @@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
>   }
>
>   /**
> + * __roundup_pow_of_two_u64() - round up to nearest power of two
> + * (unsgined 64-bits precision version)
> + * @n: value to round up
> + */
> +static inline __attribute__((const))
> +u64 __roundup_pow_of_two_u64(u64 n)
> +{
> +    return 1ULL << fls64(n - 1);
> +}
> +
> +
> +/**
>    * __rounddown_pow_of_two() - round down to nearest power of two
>    * @n: value to round down
>    */
> @@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
>   }
>
>   /**
> + * __rounddown_pow_of_two_u64() - round down to nearest power of two
> + * (unsgined 64-bits precision version)
> + * @n: value to round down
> + */
> +static inline __attribute__((const))
> +u64 __rounddown_pow_of_two_u64(u64 n)
> +{
> +    return 1ULL << (fls64(n) - 1);
> +}
> +
> +/**
>    * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
>    * @n: parameter
>    *
> @@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
>       __ilog2_u64(n)            \
>    )
>
> +
>   /**
>    * roundup_pow_of_two - round the given value up to nearest power of two
>    * @n: parameter
> @@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
>    )
>
>   /**
> + * roundup_pow_of_two_u64 - round the given value up to nearest power of two
> + * (unsgined 64-bits precision version)
> + * @n: parameter
> + *
> + * round the given value up to the nearest power of two
> + * - the result is undefined when n == 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define roundup_pow_of_two_u64(n)            \
> +(                        \
> +    __builtin_constant_p(n) ? (        \
> +        ((n) == 1) ? 1 :        \
> +        (1ULL << (ilog2((n) - 1) + 1))    \
> +                   ) :        \
> +    __roundup_pow_of_two_u64(n)            \
> + )
> +
> +
> +/**
>    * rounddown_pow_of_two - round the given value down to nearest power of two
>    * @n: parameter
>    *
> @@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
>       __rounddown_pow_of_two(n)        \
>    )
>
> +/**
> + * rounddown_pow_of_two_u64 - round the given value down to nearest
> power of two
> + * (unsgined 64-bits precision version)
> + * @n: parameter
> + *
> + * round the given value down to the nearest power of two
> + * - the result is undefined when n == 0
> + * - this can be used to initialise global variables from constant data
> + */
> +#define rounddown_pow_of_two_u64(n)            \
> +(                        \
> +    __builtin_constant_p(n) ? (        \
> +        (1ULL << ilog2(n))) :        \
> +    __rounddown_pow_of_two_u64(n)        \
> + )
> +
>   static inline __attribute_const__
>   int __order_base_2(unsigned long n)
>   {

