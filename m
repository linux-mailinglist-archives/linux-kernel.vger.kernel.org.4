Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEC6CDA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjC2NG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjC2NGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:06:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FB423F;
        Wed, 29 Mar 2023 06:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkwOYgfAu5b8DEBBBfrXA7lnopkQ3MAL3nrkLbDaLdyv0PhVZsdjadIXQ/QNvkq90MY3yI7grk6Q0HLF6ehcNCzyC9gArC5F71B/ReqV6yrhsIrtyxq93ws8PprCPAHcQrScdNnhjgnxZ39NERDGvI02JEdlzxYoGk1pKPlfH54SaAvRA5hTpksBNaWEXbtPCxmDFtsEHEzMgtbI02c46+G7mdX+FLspr3e3NOH3B+pB8zr7fIFM6kMJfXWgq/efWKtSeFrta70a1Xr+dgUWepN+kKV0Y40Eh498vxw9wMYpAzQysxWfm6jkumTQH6Vjyt3YflulDiyQlau/TWMPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP/ptodZyzeFAqJI7ogkwb9lm+GLHr350gJr+feW6ns=;
 b=WxY62OBTJc4Q4NM/VabJP5zSWU477urxHJRi7QGhUtoreryAS0GEdo/Hrbs2wScQEL3KZGT4VNCTyBqt4gOJsiy8hTtAa4i6QIn+dC1xAAXD/Osa94dByY3X5ieKrJFskcREUSEF5vtM1kHSO72TeMxOxaGQ5xfzGryDJsm1XT7B9VKHrskarWNiKGbuP9ArRGGstyFxinmnbls33Vkx8jMECst2xVpOjkbN12AeqKeNEymwz5jIerxd6EpTdyDbN15zdLlnb7WFQ1DF26l5i26A06hPqzMTO9NL3UaoJWnjXQxO19c4hC0IBLexU93uKfu1Zh6W731dMdR5K7ar2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP/ptodZyzeFAqJI7ogkwb9lm+GLHr350gJr+feW6ns=;
 b=D5mH1aVseqBtwHLcTsdsd2COx+T0h4X2mr+Xg5WFifisZ3RBKcEjgvToX2c/CntTduYXxl4bJJ+1vMH3Mc+MXGEikXqVX4A6Aauk7cPHvzHfeKACd3DZmZZ60WI00uhI1Fu5iVK4sSB/Ng2sUy569K6ODQX2/RLHXEL8jjijo5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 13:06:13 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 13:06:12 +0000
Message-ID: <41839138-3d85-ea82-7832-5da5f9addeb1@amd.com>
Date:   Wed, 29 Mar 2023 08:06:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] docs/sp_SP: Remove ZERO WIDTH SPACE in
 memory-barriers.txt
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c38176c7-c30a-4c2c-3516-8d3be1c267dc@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <c38176c7-c30a-4c2c-3516-8d3be1c267dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 106b0ac5-eed2-4eff-dfcf-08db30565f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6zu7KLXMGt9grvLmyo4WRQ5LBkE0wzYdQOS8EXfeMCiIkV8/wg4O/W2cz6gIMPwCCt3ABueI87athKUe9HLn5uQRXVzIhmW01FhYAG6hSKU4cDjYrrH0WIwAye+kVitBTGHIt/C5wV94tup95Vikp7SousfNMolqZU5le3ymWAR1c/aWLmuAJrbXMzK9VkEjDnYPeidcZljA51PMd+Gbog/OGPxjHDGKRiBC2sm0CI6U3vKBtK9axMrbiX9tzWvm43n4nIJKDQ4Jj4PKIbOVPjArpvnBoKtLMtw7aWJ7/n6YbLjl7/6AzIW/9OhEuU9bbQlEgMbwB/cFbf+odAvV5YXHSXzJcI/mOjABt6VcRE/4iwCs2FY0a+f2/IjRrAKdYEKom1/BKweVY6EcZKgWhCB3e4SSIOaQUPEmFHDP+7rdJMlT+3/XhYzQug0nbvWlIN+GOKn8amXhOni7TwVNhcYk6SLlpeuLJA5Zd9ZPqShflt1X3Fs1mH4frh5ypeixevuxcuauVrsV7yxZ57BmOiCSangsQkm4JQU4RdMy6GuESWcwYuF9yoUex49uFmhMcMmJE03AfrDtYXarTeCH4/utyfWbeoCPAMWr4SF9hayZNWfdP0gk/LZ2OtYa6YZ0CZMRRhSfVlBzbprifohJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(66574015)(83380400001)(2906002)(44832011)(8936002)(5660300002)(38100700002)(36756003)(86362001)(31696002)(316002)(53546011)(8676002)(6506007)(6512007)(4326008)(110136005)(66476007)(66556008)(66946007)(186003)(6486002)(31686004)(41300700001)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldMeHc3TnVsZzNmb2k0THJ5TS8wQVVTVDFQOXRXWlVlZmNHMEV5Qk54K3Z3?=
 =?utf-8?B?dUhac0oxVWZQdmk0aDByQXAzR2w1QTNpckJvNlg5TmttNXBsWUoyR2hrMkNh?=
 =?utf-8?B?dXdWRndTZy9PZFVwNE9qY0Q2WnFmeWp1c2FqRXdwYmJTeDVXS1lUYk5QZm1N?=
 =?utf-8?B?R0xTVWt4Kzd4Z3JSajBYRThyYm5ITXB3QmpRQ0UzbjFHMm1IL2tYRlVOWVlu?=
 =?utf-8?B?clFBNnd5ayttY0ZoRlU1dDRGcVEzVW5VVXJSTkoxVjFHKy9wM09BQ2ZHWm9s?=
 =?utf-8?B?NTl4Z21kSHRXQjJYM05ScW5PWGhGZ0RhL3V6T005aHJjNm45VEJvRzRBY1A5?=
 =?utf-8?B?SHVZaFZJdGsvdG1RSDBwQkJJMzZtTXlialFRajZadkRmRWpZM3FUZmRndXNQ?=
 =?utf-8?B?MjZhSkI0M2pnTW9leVNSbitjVzNVczA4dTJJVzFPUEN0SFlFbENlQmE0Uis5?=
 =?utf-8?B?ZW8xTGNuQnMwVDlxUTh6Q3lBWVdwREw4QTBVTWlSRUpRYmpEd1hSNi9UNUl1?=
 =?utf-8?B?NGlJek0wc3Uwci9KUTUyb0d3TUdkVG1tajl5NFk0WldhVG1WeWZDN2luZHZj?=
 =?utf-8?B?SGJKT0pRekJIL1B5NE9WN1gwbGZCRWJIdmxQSUl2aXVZZW5zeGx5bk84dTZy?=
 =?utf-8?B?MnNtdHlQRXVOQkw2WlVvQnorbnhNSmlIbXlnZVN0MkhCakRMVm5FZS9wNVNU?=
 =?utf-8?B?Qk1RWlV0QXlaQ3Iwa0VIL3lGTi9EaDBIWmR4Q1RuenJ1bm10Vk9nNWRmSWFa?=
 =?utf-8?B?clRnTVZucTZKWk4xMUZac1FTWWpBUXVyWVV5NFV6ckRrazl0UTZoWTVwRzFE?=
 =?utf-8?B?bzlXMHE1WStFZGFwOHRRTEdoTXVGMWVJMU15NnB3d2RIeFIyMU16ZHlVUWZj?=
 =?utf-8?B?QWVmempObXQzY0ZNWUozTzFqTkJTby9aS2ZDQ3RNZEFCTlgrMDVoQ05UL2pR?=
 =?utf-8?B?MWdKL0ZhOHM3S0JYankrOWdyTnpoRDlnMmlteDhNU1VZQVE0T2I2NVY4cG1K?=
 =?utf-8?B?MUIzeUFYRWZSdmlCNi9WQzY5QThuUU5SWFlxVzY5VEhlZ1NlTkUrekxjZXJp?=
 =?utf-8?B?Z1FITlBzU2ZxRnBlRFVKVVFlcUJUWGNBYmFjTm1KVXBZdCtNc1lQZG1seHVq?=
 =?utf-8?B?VVF0RHhTcGx0eVB3aTBNeXBHRTNFOWtaMUhRbUh5ZGFCMzFvbFp5TmliWjlI?=
 =?utf-8?B?UHY5NDVlc3pxSG5zMVlrZXg1V1U3ZEdHVFlXc0Ntckh0V1BOY2RESnJscDdx?=
 =?utf-8?B?RFN6TDZuK2RjMG9IbG85RUk4aFhORHBjRThDbXh6VzZ1cUVBbFVJQWJBL2hI?=
 =?utf-8?B?L1lYb0JheTBNem5oZkxkNmg2a0NlM3VPVHVZUFNhTlZzV2U0KytXMmpRb0dy?=
 =?utf-8?B?Rm00RFE2WWRUZGcwQ1JURngwcTUvaW41QzVoVlJmcXZPd0V4Y09hYUlsQjBp?=
 =?utf-8?B?c0lPSnczZkpuVU83ZzRyS3dUc2l4SkVSK01OSmovanRVZUlxRVFhTm5UK0dG?=
 =?utf-8?B?SlRTZGxQWkt1R0paS1RYeHBsYjEzY2tKQnlORnRGVEd0WTFVa2N6TlYwcHJk?=
 =?utf-8?B?RVUwL0VPZnk4OXQ2Smk1akpvdjRWMWFTTmNqbmhrc3dTaVJEeVZSV0g5ZFha?=
 =?utf-8?B?b1NHa1ArYk5GK04wRitjQzBadEpUdUs3T243WHZld3JpR01tdDZmYVd4SGVS?=
 =?utf-8?B?OTMrM3QrZzRSMzBvR1YzMlVPNHAzU0R4S0lsdEZYUzc0bUNlSGZydlNSYWRh?=
 =?utf-8?B?cUtSc2pDczYxejV2ZVlNUFA4NlVvTFgxZTFBWnEwVE41cWNzVmpVeHh6enk3?=
 =?utf-8?B?cVdxUnpJbFRhVnp0UHFubDgvbGk4SEcweHNrWnM2cExic0M5TjYrQnRLYzM5?=
 =?utf-8?B?VFdReGFBWFhnWml1U01VL2xvMVBYcWxTbDNOeVRMbDZ6V0NwbjZPallweTJJ?=
 =?utf-8?B?NFFJQmVRMHNLcUVhcHRtRjE3dmVlTHhVbm5zV2pLSDV5WnJxY0swUTZrQnlN?=
 =?utf-8?B?NFZ2Mmw3QnNaZXZLRjl0Yjl1NzEzdHpHWGpxc0JLVHRCUnZzUGNGTDkvOS9v?=
 =?utf-8?B?V0duVkxWYkJudDUwWXZrWUtDQmlHNVlaa2xRL25jTHJSeCtvc2p3Y1IvU29F?=
 =?utf-8?B?NVlsNlcwQVVqbkVneTNOMU9rU3lSM1VLdnNHdUF0NGNkR09OYTF4NEQ3T20v?=
 =?utf-8?Q?sbJdVePgvhHNvQFW88/iEZ8r5CWGDkUW7R7swJ/ISCjQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b0ac5-eed2-4eff-dfcf-08db30565f3a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 13:06:12.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brALiIcedKb3ymryPi4S1rJrByK6kPV7Hii6R34JGYinb0LcSJdnD6kbzQlh168nP6D2AqAsdL7ULEaUvDBUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 12:22 AM, Akira Yokosawa wrote:
> As this file is included literally, ZERO WIDTH SPACE causes
> "make pdfdocs" to emit messages which read:
> 
>   Missing character: There is no ​ (U+200B) in font DejaVu Sans Mono/OT:script=latn;language=dflt;!
>   Missing character: There is no ​ (U+200B) in font DejaVu Sans Mono/OT:script=latn;language=dflt;!
> 
> U+200B (ZERO WIDTH SPADE) has no effect in literal blocks.
> Remove them and get rid of those noises.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
> Hi,
> 
> Offending commit is 259b007f5729 ("docs/sp_SP: Add memory-barriers.txt
> Spanish translation") merged into v6.2.
> As this is not a bug fix, I'm not putting a Fixes: tag.
> 
> Note: It might be hard for human eyes to see where the removed
> ZERO WIDTH SPACEs were. :-)
> 
>         Thanks, Akira

Good catch, Akira! Acked-by: Carlos Bilbao <carlos.bilbao@amd.com>

> --
>  Documentation/translations/sp_SP/memory-barriers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/sp_SP/memory-barriers.txt b/Documentation/translations/sp_SP/memory-barriers.txt
> index f62bd797216d..27097a808c88 100644
> --- a/Documentation/translations/sp_SP/memory-barriers.txt
> +++ b/Documentation/translations/sp_SP/memory-barriers.txt
> @@ -604,7 +604,7 @@ READ_ONCE() para DEC Alpha, lo que significa que las únicas personas que
>  necesitan prestar atención a esta sección son aquellas que trabajan en el
>  código específico de la arquitectura DEC Alpha y aquellas que trabajan en
>  READ_ONCE() por dentro. Para aquellos que lo necesitan, y para aquellos que
> -estén interesados ​​desde un punto de vista histórico, aquí está la historia
> +estén interesados desde un punto de vista histórico, aquí está la historia
>  de las barreras de dependencia de dirección.
>  
>  [!] Si bien las dependencias de direcciones se observan tanto en carga a
> 
> base-commit: 4f1bb0386dfc0bda78ddad0e4fb3cd519b2886ab

Thanks,
Carlos
