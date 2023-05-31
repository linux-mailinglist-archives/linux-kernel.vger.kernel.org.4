Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83945717854
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjEaHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjEaHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:34:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFEA113;
        Wed, 31 May 2023 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685518449; x=1717054449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X+Z5BYy2GWnwVBq0qWTJHwS85v502csmKTGi5xDTbak=;
  b=cdiSWQH0XUS+36ij93GLQr5hgvyeP/hz7EksIF7IxvHbyrRXwtZhT5cy
   7rpEHYN6cyDMbAnNZQkgyOSe84UWJGLDLdMRcYbw5Yg1d6huVTK4L2s+G
   fFNLBjQiIJ6PmkB1cCGfHsE/9Xxbn9brAMU6Wqun9pt89gVjQNs4dam5x
   kiJenpViJK4Z8JkjEKbc69QIwRi4PcVKouOloXApXzFNIILe8J8wIV81F
   ea8c3CD/ov4/7EOg4YX1ne5ERUGp3EX5rBXaVwHzMZrqOtYFfr5m+0/kX
   1+z/S7LaI4gEXOO6JTi1daUWRpDL0vOuJjJu8ZWlHubBDol2PCYbvBMDO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354008229"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="354008229"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="657214044"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="657214044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2023 00:33:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:33:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 00:33:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 00:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzuhsvtVT2pkXITgDfDKvoUfBMjd4q4LZFSYLOJJYx3ZBLNUMYRJE8O05zqp2hxoxc8vAs6emwz7uRPxh9LvJkQ32dnls97KppexW2ixwEBDDqFCQScs62X0zzkqvrNKAKrBcY48SZj97rGVpKKTHdcqQ97Y+Ty8KEt/Vr2pEpuFfZk6xCk1r1Mc58sqnxpxxmJSaNL7r+zzp2+xwrfpMRPqSY1N3wdgITbqc5V3b17njJq0mYSn9GqieQyOMzGAeBRyLlkRG8koDqvM30pNfC+jLpZ9TP2MOY7EjkWpRy1IM1hr1r0f/sFqY+0q/0DkbcfyefHuzzAwxkDx66bsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyw0cRRRWesM/poxuOAE2DnXeNRoejRXKIsJ4jGw9Ws=;
 b=YzaW8QXzqVt02PmFQmDqnGJcYy6xbn10Q0IYhwKT+wDJD2EmFsLWZAkOKXuTCK3aMLHzGAg4qhtJR7sLDA5OPAJ8NJl0ZeunelEkWlAtUdDX0vMZYCZIhWDULvGgj2+3/H2bJozyMe17X4XIUAC3WN+/7p8q5f1988NkiqOyk11Ma6ahKtOsrHFG0MmPyZvb0BV/KUQBfq2g6phnkifiTXqHSC2XMi0YZRyZkV/gyMH8opcP7rGZjiQ9+jYSvGidTj/SobCg4irO6jRWnGGLxZaQ7zr0wglaR2bCU1UVaUtmfG4fngw4SoyMcX0tICcdQ/jlew6/VeKnwwPwCpBmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 07:33:51 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 07:33:51 +0000
Message-ID: <be6e2b30-e1da-7028-2ac2-6eb0f9ba0632@intel.com>
Date:   Wed, 31 May 2023 09:33:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/5] ACPI: thermal: Use BIT() macro for defining flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5675481.DvuYhMxLoT@kreacher> <3229381.aeNJFYEL58@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <3229381.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 757ed175-6e3f-430e-1b6c-08db61a960c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTOammmBLcPKcIN3svxyH7wRqExAHfS5HRL0qbP+pca7FWAlGyxXn17+tkaZGH6EpqxcRUi5/Pqv7UR7KW7sZAZy0pjZH+UcWUYIUidWa8KXBXrFbUtnQKJrns+DxhQJHfrDlkQ5fXrn57MJ8qf5+qygl4e3xAHbFVPnSzWBrUk+F2s6VrBDNBhpY1KkgIPAUJBb4W7LWNjmBncEOMaQmJMffTloI97F4dYGCaNL+RsKxN1eRFKBzyYe+rpcaT0w4HcyTG905HvvztVtPbJvRHoh3KuMq0gTerEGJOkuIslIINc24w51a8SoYI/R8ETm9oJQR2cMmjryJR0s3Am585PBF6tONB959X7sztrNIEQZZ2mSD8kJKDOtpK45vtQRdGlmh5ZZ2Mv3vE5x8FuRZNVZ4bWhiXV1KKzBHNBCp+abragaFVOVLL6Tli/e1pnCQmG/gWGjizwLlvLUN78stgF/FX+WcNHW3zVsXHvp1e3t9WPJnR3GvV0PXij55L2iREmIhPBhjf/PSkvW38UdkRiHSr8C8KI7TWUlSbaCyBQPJ7L3LOoSoUCDmqSdGqnwRtsRFsqdQP42JSd1gDZI47gKUMYDUzGLhuHByKno2lUjwI5AaSW+WbguY75cHKMbwCMsQGLiCDCdvKIi6OlDlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(86362001)(31696002)(36756003)(82960400001)(38100700002)(478600001)(6666004)(54906003)(110136005)(84970400001)(6486002)(5660300002)(8676002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(31686004)(316002)(41300700001)(2616005)(53546011)(186003)(83380400001)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clgyZVI0c2p3TENQSWorczRPVEU3SzB6eGpzOVZybENvM2xhRjRnTlFQZ3o0?=
 =?utf-8?B?K1M1N3BXWG4zRm1CZ3FZWDBCRS9SQzNEUDBhWXYybUhnaGJBbHk4bDNJYkNK?=
 =?utf-8?B?U05RZmNqbDVDSUZoZXhvb3FEbDl1cG92TmcrV1puSFBqaHJBbE51akN3ZFkr?=
 =?utf-8?B?NE0wMlJnR0FIdy95MnlxY2ErdE5MN2hvTlhDbmF5b2tIbU1RRll6Q2kvR1Ni?=
 =?utf-8?B?blBqL2xhQmhBZERkZXdCTE4yKzJmQm94d3V3aXBTTFZZai81WUlRY2pZVUJY?=
 =?utf-8?B?WHJJOWdrcmluSzZscDB3WmNLWXBmYnZxOGtKbTNLMWlVdE9qQ1JLNkhOQUd0?=
 =?utf-8?B?V00rc2M5SjB2UkYrSHp3UWVNTDNrT3dYTmQ0blB3U050RnBYWUNCcklVKzMx?=
 =?utf-8?B?cWRLeWVJL3Rvb0hkNVVEMjMrSzc3YnIxN1hNSVhBUHFNSjJIMlZSUVJGY09k?=
 =?utf-8?B?dnR1dmVNVWZwQkNNNnFLeUNGUXNJSURIVGlrcHhoL1NoTWEvckRKMG5ZQmNF?=
 =?utf-8?B?S2kyRXVzdVdyclViZ2FwSVlacFRkTFI4Wkh4WkdYZ0h0R3BrdnE0bDZmZFhG?=
 =?utf-8?B?YmRXbk1EWjlwZ0lzamkxSC9ZVEhndFRwRzEvRld6VElJK2FUNE9UQ2tPTG9F?=
 =?utf-8?B?bDlXS2RzVVM5K09KVXlzYmgveHBVblNZQWVwaHpyejVJNDRqVjhFWGxYcFI4?=
 =?utf-8?B?YjZOVzBmT01QcXV6eEp3bG4xYVc1UFFrNklMcDdGdUdTRTBsUzVmcjRjemdJ?=
 =?utf-8?B?cGMwWEs0VXREcHNGeXpDS3dlM1pYeld1cDhMcnJnU21sZXhtZ0UzWlhmL3JG?=
 =?utf-8?B?UXFGOEl1NWRvUVR2ZTRHcVFuTVNRM0ltc1dtc3N3VzZWaVZGa2RVdFB1Z2Z4?=
 =?utf-8?B?cVRHbDdMTEpQVnN4akhXZDFaeEJOSXFaZjFZNHFKazRBR3RROWxxbHc3Ujd5?=
 =?utf-8?B?d2p5RUt4WHpLWkkyMmthZlJXV2NnRTJIbHVUMmo5RnZnMDJrWnFSU1VTbjY2?=
 =?utf-8?B?UWxJS0RSRmZ0VElKdndlWUVHYkxsWXllb0hnMElONDRLQlhrbjRlTDNITURu?=
 =?utf-8?B?dzBRcmdTeDc1YUkxYUFNd2orUThTdEZmNGdKUjNsb3k2Nzl2SHZ6NEpuZnVx?=
 =?utf-8?B?OExqWEJMQXgrejlmME9JVjRkbnVTbW16cTFRZGIzMjJhQko0cktzZlplS3BW?=
 =?utf-8?B?Z2dnL2RZdnVXRU44ZEZ4ZTRDZUsyN1RuZXp2dWxYZlFJenJvNG5URUNvbTFW?=
 =?utf-8?B?TllMWldSL2JqRHlVNTA3WmlaSXV5NkkyTGw5MkFIQ2tLa2l3VmEvRFptN05I?=
 =?utf-8?B?clQ2V2c4NTFtRlNoSWxTMVNGUzFNUDFzT2doOXFrNU40NmFSWFhsZnN2Tyth?=
 =?utf-8?B?bCtQSGRGR1YwYkQ3Q3RpelE4RFVlWHdIVVJXRVErUjJlK2VDMVpONHhHTlRp?=
 =?utf-8?B?WHRBUWhWRVZ3dWhvZDFMUGVLdWt1NHR3QTVJbWVkS2ZJZVQ2ckllckZ2enJa?=
 =?utf-8?B?c09iMXEySnlBekp4UjhIVjJjUXBUSU1tRkNGQUdmQjErOTN2U0dtWnJUaXR0?=
 =?utf-8?B?cDRzQzJTVGRPaXM5UW1iamhiaXkzcWl5dFlmWTJhRnhFMHUyZDFtM2VyWml5?=
 =?utf-8?B?dm5WQUlwWWNFazRqdU5GMThidkdTSit2dlVEZytoRkJGQ2tzdEI5RlAveTZ4?=
 =?utf-8?B?UFdIUjF4YTdkeThUclhLQU5QaUt4Y1B3Z1d6MkdwNUlyOWNjV2k0S3B0NXFL?=
 =?utf-8?B?bGZBV0o2aVo2cUd1eXVUYXp5ek9WNUZBcEhlU2sxbkcxSVNDMVdCTHpTQVNl?=
 =?utf-8?B?cEhLcGxTRitxMGY1NjMxM0diTU12djBiNUJEMVpNQWgvM01mNDBvcEVRWG5D?=
 =?utf-8?B?V0dIZGNkem1uM2xwWmZtdGZtRXo2S29XSHpWQnlrYS85dGVaR0lxYnZFZ3dm?=
 =?utf-8?B?MXFEUTZwT2toMkRqVWd3eTYrSGdHU3dUV1ZvOXQvM1ZXVG1pVG5ERzBiU3JN?=
 =?utf-8?B?ait1Z2lCemFyblEyTmpmaG9rYVpVK1NOUDlBczNOMWQzMytDY1pqcm9mTG12?=
 =?utf-8?B?Rm1DdnVJdjh0TWJQa0VJZ0UxbUNhUXM1OVVoczRIVVlOejM4UDdqUWhlajFS?=
 =?utf-8?B?SDdoclhYdkpVYit0UDluNHAyWGxudHd0TUJKb0ZMbVZvc3ZaY3ZYUUpkUmE4?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 757ed175-6e3f-430e-1b6c-08db61a960c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:33:50.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zj8BKSxpgFkAmfPo0dqE2YJ3OL/N9DDPblYEVMiETzegTGdJXQpkrCRgYcX/B4eKkvRawjSF/4g4h0wWg5THmC+A783ueR5lqXM/2pMmA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 5:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Use the BIT() macro for defining flag symbols in the ACPI thermal driver
> instead of using "raw" values for the flags.
>
> No functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -232,11 +232,11 @@ static int acpi_thermal_set_cooling_mode
>  	return 0;
>  }
>  
> -#define ACPI_TRIPS_CRITICAL	0x01
> -#define ACPI_TRIPS_HOT		0x02
> -#define ACPI_TRIPS_PASSIVE	0x04
> -#define ACPI_TRIPS_ACTIVE	0x08
> -#define ACPI_TRIPS_DEVICES	0x10
> +#define ACPI_TRIPS_CRITICAL	BIT(0)
> +#define ACPI_TRIPS_HOT		BIT(1)
> +#define ACPI_TRIPS_PASSIVE	BIT(2)
> +#define ACPI_TRIPS_ACTIVE	BIT(3)
> +#define ACPI_TRIPS_DEVICES	BIT(4)
>  
>  #define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
>  #define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES

Looks good to me,

Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

>
>

