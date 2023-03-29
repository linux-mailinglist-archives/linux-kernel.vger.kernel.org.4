Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924766CF339
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjC2Tf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC2Tfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:35:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4244C01;
        Wed, 29 Mar 2023 12:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErYl1282AUysaClPum1mK/ggqaxv2mEVIWLPrxWuBtP2n7cPrsqjBT/wPfsnWZ3kmV04kFcFKz8k4dKD+L33+Mdjq+EufevxLECiZJY81oZtGmwvpDJ3jm+Iguyh1/PhYepG1X9OpjVFs7Dq5o8FJWsNteKhkjzW7cPzXTkZQ7TEliyF4sanahsqjyPgB/922XsllTBW/tgPej5MqMLx3zGrlUJ1HDCRcxtuwvi75kdyEWQ8c0k4sV7ZCTpmjvddQ9cHbhv4ANSPQa6QeM18/aRcMfvxzUSoWUAAS8ExZIwH/JecevALSJa3R7E9yjl7smLvn2S87S9kB5LQbDsUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eXJ2qXxYiYKDb2UNO0DbkxVrjWDneLPaFwamExVvyY=;
 b=KKBMAlj/MuzEsC9YEiE1mgWwdMogCGyBzo+QWOsgbEx+tCQMVrGr95HicxttWW2xjWeKdhj+0EzdcG9Cg02JusYPrR8Qxo2JI3obP1CQS/4QWCKQoZakshV5AlPvnuQJT2VAd8VK2bZdgTPr6U/kEjNjJlyBqkUFUsT8yDHn3hQOJdb/BiZt34ZgS+ETnaEjWNt/ERysOAqhy/lrTmSEbMoMlBV/pfzKLiY9n/yKxrsnc5ghlQ+odh2tj86zd9FnZ6pByPLhaHm7eELUUPwcS0pHke3QfwEsV6Snc6rxyYKUdaxsjt3ZZddHbVPA7WQXcjtgbjLM6ST7hnvZu2mJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eXJ2qXxYiYKDb2UNO0DbkxVrjWDneLPaFwamExVvyY=;
 b=sdpTObZNeU86YtcAycEQ6riYzKJAcI3+hS9GHEJ8Pe94pMa2cZmXq/WElpQ0UD2WF4EiAWsSFS40H06cAfjG8K1dnSQl+JdGVY4NLNo/F5fMlHIC8AfP37bIEYSivqlh7ZuWRzyJGXOOF0qHSUXex2//Vg6mGp2fq/HyE1Nbll8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 19:35:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 19:35:45 +0000
Message-ID: <7aff0a4a-369e-6278-873b-eaad6c51d024@amd.com>
Date:   Wed, 29 Mar 2023 14:35:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] x86/acpi: acpi_is_processor_usable() dropping
 possible cpus
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>, rafael@kernel.org,
        lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvijayab@amd.com
Cc:     miguel.luis@oracle.com, boris.ostrovsky@oracle.com
References: <20230327191026.3454-1-eric.devolder@oracle.com>
 <20230327191026.3454-2-eric.devolder@oracle.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230327191026.3454-2-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:610:b3::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e48ea1-6557-45d9-f7fe-08db308cca85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2BC/82KoNUHAm/PbKJ17hMcnDMzK6TO64jW2Qe0BOqc/xqiX9KwEaqu39lXOugmcPFcsRLcCDX2ZThfbUYzlL1P9Lj/tsvu6vFk9BEN4DehK2U0fRl7O+yrOhxv4wAJ9xSljsegXF7rNmHOigb8+z40tJkoPek0SLi7+hILjiaUW/1lJ2L1je8V+nt04zva7LM5mgP8krCG6hqBsfyzXxTfX2Mn5jn4ck6KeYb3BVNe1AV5DEZSyS5bacP26AE8ptVWwx1eKf+sRXm6ShoWlTHiQhBABPfTL+vXCqwAT1P2RUZRjV+uECHCxRP47+s05J8FgwyomKY+ohdYRaWOuHDPpber7wSwWJaFhf9iEMmrsjvrXAD+CC7j2ehK30hf+k33z8sNdphg1x4K3A/I9qUk5rjd4TYyMVWgSHnOUF9jQtfJJu8CqQmxFPeoep82FYjJSIVyaWGd+sFsR9bDA3wDRKJKT+/m4ezE/oWld64NrLji7oFxza1bmMETTF8tfAEa5JlGIBbUmhG7lzbemYh/DxBE+R8a7IoSnRnOZOh0DgNLDhKH2lUE6Z7g2UxcFdcYPovrPS9fT3HquYo9+Jmn8rgtfWQZIPv4X13244FmcKvXv8e6sk8Bhe4324wPyzZRKhS0BASQNxaNsysVJJ7688mtwN1vz5tyC5SX/rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(316002)(6636002)(478600001)(921005)(31696002)(86362001)(8936002)(36756003)(5660300002)(66556008)(7416002)(38100700002)(66476007)(4326008)(8676002)(2906002)(66946007)(6506007)(41300700001)(186003)(6666004)(53546011)(6512007)(26005)(2616005)(83380400001)(31686004)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVORzZJY2g1VWJqUnNVOXdJV25FUkU0b0grVFZSemFlc2RpRjhOWURab0Nj?=
 =?utf-8?B?NEMzOFZiV1g3VXhLRHc5Unh6OXA0eGp3T2doRG1KRXVHUnJCTUFxbE4rUUFZ?=
 =?utf-8?B?dFJGaWcyanppZVRqM2w2YmJvN3RiRlQ1K1pwUElrS1dIaHVZZ3hWeUl5ZnJr?=
 =?utf-8?B?MGxLNi9zSm9KWXlQRVFMRWR0TllKU1QxTDNScysvSWNqN05LdFVCdG9SbHFS?=
 =?utf-8?B?NVNUUWRvVU5BbjJLNlc0T2srRlNMOVRVNnh2SEdwY3lhK3hNUmlyYjlibjQ4?=
 =?utf-8?B?dExzL29ucDhBNVFLOXgxSCtBSDdPNXNWVjRhUUYvcUhPZXAzZlJ1c2ErNTlO?=
 =?utf-8?B?THpraFNZZTlrVlFWbk1zNEtnSUVMc0F6RGtXT2RwNVg1Z0xyNmNHbXFsVHh0?=
 =?utf-8?B?bm9UbUNPYjdDOC9sRUY3R2V1VHN1bEtKUzFjTmc1ZHUwMEMvbnhSRGc4cWJr?=
 =?utf-8?B?Z3JtMGlKYys4R1RRdnUyN21aeWJSYjhVaEY1SnZEbEJibW1hYW5qT2p0OWFa?=
 =?utf-8?B?TDVwWnhaVmYyQkR0N1BSNFBmZ1JqOE1ickQyMDc3T2wwblBEb2s0R0NLZVBz?=
 =?utf-8?B?V0hFWCsrNnlBVzdBZVhvWGVOMXF4RFc2cklnY0NJZGlwYnhPMnFFVytIdmpw?=
 =?utf-8?B?VXhVTVBZN3JOTlFXWXhBUHhvN2g1cHlvSXdkdXpqVDAxay94MGNncHQ1TFE3?=
 =?utf-8?B?dFhQRVlUczJKMVVmZjRmK3ZlbWpud3U5U2pyOUhyQlZkWWpha3Q1VTB6UUts?=
 =?utf-8?B?UXVjV09RTmkwbVdrREJ1SzNlRVhreFpJUTFrelh1bGx5bEJuUUVIdGlPYTJI?=
 =?utf-8?B?dTFXUEg4R2RKSjlSU0FvdGVibW5pWC9lZ1ZMUG8vUGNRTVE0VkdDcExzOGcw?=
 =?utf-8?B?aU01ZEN3TGpCZlcyWUd5Rjc1bFlvNGtTZlB2TnBNZytkdFYrTGJmbVRrT2lo?=
 =?utf-8?B?b2NWNU4ybEdXdjVlUHkxbWJuYWd3TlpsV29lU3VtNkxoZmZLblFyak9RUzB0?=
 =?utf-8?B?dmpuZ1NTZEFkNjVXcmRVN1l5VWhaV0g5QjhjMmZTaDZNNHJUdGRaa2F2OHlk?=
 =?utf-8?B?MXc3N1NwbU9NclNEQzRnRjhjVEJRZURUR2tTOW5ianBNRUZ0VS9hdmlMN1pL?=
 =?utf-8?B?dnRlMlFlbHFqQVJXejlYMGg0TVZnRzJKU2ZxNmlBQWtNN21OM0NBaVFEOExW?=
 =?utf-8?B?L3BDYzdhRVgyV0ZxbzZ0S1dPUTd2aEdsUzVXaytSdGU0bnVCdXp6c2Q0Z2Vt?=
 =?utf-8?B?Zm4zYjdobzdLL1dzT2l4b1Z3dXoxVEY0QnVxZXB4TnVHVWowczlpTFA4TUxj?=
 =?utf-8?B?WnIzd09zZURYMy9BR2tCZ1ZITWx6Vlh0ZnhtamxRM04xQ3hBOGRBdzlKaStL?=
 =?utf-8?B?OXh4ZHZIeTdHZUFHcTZISTdHcEZNVnF6a3ZyUUtIQ0ZOdWg3Sno2Zmt0STZk?=
 =?utf-8?B?SEpOMURWZjZLdU1NN0J1cVdjUWVLWU51V3JrY2Z0WDZEZjg3VEdzTGlTbXpa?=
 =?utf-8?B?VGJSQStTcmNzd3ZLM1ozVUxMaENXSTJJTk1EMW10QWYzYjY5SjJjd3cyM0Yx?=
 =?utf-8?B?amJNSGNLaks2M3J2cEIxYzYzTEEwd2FHdEt1THVDYTZqdE9ZK0dTaDRXK2xv?=
 =?utf-8?B?YUdQNkFKQ2E1UFh6Rms2RDk1VXg4Tk0xL0J2L2hvSmZBb3o3RktEa1lSYlVM?=
 =?utf-8?B?OGdLbVJXMmFjVGUzTHM1Y1p1c0JiUVU1Mi96anpucGlxY3hYSkpQRHJmR0Np?=
 =?utf-8?B?cmRBaXkvTGd4ZW9RQVgzT2UyV2ZZZVA3MjROc1dFbll5c0p2dkFTWkU2clp6?=
 =?utf-8?B?K2x6TEdMT0V0cG1xaktjN2QvODNiYm4wS1U1L2p1eEUwZG9NK2ovWU9HSk9t?=
 =?utf-8?B?VDZOQ2NKd21lRXgvK1h3cWdhYUIvUHE2SUxrelRlMjdZV1pXM2ZpK3MyTHVQ?=
 =?utf-8?B?YXFVMWNCQ1Q5aS8vdUQ3eFRodEhKc05PZ2cxZ09wSkp6aU14c0Rqallwdy9z?=
 =?utf-8?B?SmhHWDdQR2pYNFNUV3I2anpsSi9HcXhyTmtCVkMzeHJpNzZ2QlhGNU9vZFgy?=
 =?utf-8?B?UE42NnRMU0NGRmpKckR6YXJFbGQzS1h0b3RwSytjczZGODA3cWNWZnZ1VXZZ?=
 =?utf-8?Q?IrfGe45oBCl+Z76WuqbUal8Yv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e48ea1-6557-45d9-f7fe-08db308cca85
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:35:45.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaLNE1DjATQsms5N+CH36ReDKW/QqVWzyMYuOUxVqv+oXj3b7iG9kcM+JNvbjnECQHMwH01oPUFJHt75JIoEgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2023 14:10, Eric DeVolder wrote:
> The logic in acpi_is_processor_usable() requires the Online Capable
> bit be set for hotpluggable cpus.  The Online Capable bit is
> introduced in ACPI 6.3 and MADT.revision 5.
> 
> However, as currently coded, for MADT.revision < 5,
> acpi_is_processor_usable() no longer allows for possible hot
> pluggable cpus, which is a regressive change in behavior.
> 
> This patch restores the behavior where for MADT.revision < 5, the
> presence of the lapic/x2apic structure implies a possible hotpluggable
> cpu.
> 
> Fixes: e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
> Suggested-by: Miguel Luis <miguel.luis@oracle.com>
> Suggested-by: Boris Ostrovsky <boris.ovstrosky@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: David R <david@unsolicited.net>
Link: 
https://lore.kernel.org/all/a15c6a64-dcd7-b102-9d9f-0225dfa1172b@unsolicited.net/T/

>   arch/x86/kernel/acpi/boot.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f01..7b5b8ed018b0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -193,7 +193,13 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
>   	if (lapic_flags & ACPI_MADT_ENABLED)
>   		return true;
>   
> -	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +	/*
> +	 * Prior to MADT.revision 5, the presence of the Local x2/APIC
> +	 * structure _implicitly_ noted a possible hotpluggable cpu.
> +	 * Starting with MADT.revision 5, the Online Capable bit
> +	 * _explicitly_ indicates a hotpluggable cpu.
> +	 */
> +	if (!acpi_support_online_capable || (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>   		return true;
>   
>   	return false;

