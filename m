Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3172F3EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbjFNFDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFNFDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:03:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D46122;
        Tue, 13 Jun 2023 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686719023; x=1718255023;
  h=message-id:date:to:cc:references:from:subject:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X5ZaGXxFzvy3n3gEc4WH/4Awoy87DuiJdShoxkVbxD4=;
  b=b27vD64KMRVWyONdeaQ1uWYPuPiRqIrWQSznoi+opBsSIye1sZbfw1yW
   +VnQ+hwGjydRCR7dHwNCsV+D+UJdgWI+wusN5ubZHjl6SdVhNF3sY89AX
   TK/yO3a8XeHWmZSHxrM3qgMIVTglrWXxbtSEHM2y3OPmcu5QH30OvUIIg
   0ZMIG3aVIPN7FNb26k2ORNoSnrK/N3lPiIYlXM2zOSlX+kDiszOqszMbZ
   Q9dk/JldAlhggI+0oUvIpOvWKYcE70G1FVJZi4D+15BI/NKkH64MTcCeR
   phBsc9u+YfLEzXHGnVBGgx12zwT3F9mxUAxh54Mrwi2SM+QSFH04pay+u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338874346"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338874346"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 22:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744947288"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="744947288"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 22:03:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 22:03:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 22:03:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 22:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDZ6TbCIBPtrHIaMPZq9aVePyPuntIjysn0/BXElO0sB6AagPyhoo3MIpBVoxfdSK+UqK5AKpBReBfDpiArnqwiRVsxCtrfy3DAt/XbXe+jZDHaUly+zK3/ngPbrDSLryQbYVDmoiq+W+66/BkD2ihWBMJ22nt6hq11QaYK43My5alFuKTrlcRh76rsVU3rFOPbG9vds4bqIDirTA6Cp025vbD6w5q/OdvFdw4+K7x+cJ5bCWCLPFnOAJspZ7YnRkr/knSyoOr1VW1hzeK3nAJB6oyZsP4dsbrX+TWPP8Z8gaqLTZOovnuOOEGliNX2YI7Uq2MDizbJVgOI3/cmBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVqoM9NXr/Q1k/t+scsX2DF+DrPJZMbyCcF1gDh75X8=;
 b=jYnGF98j8Ji9+H8rZ1gVYSUr8wdBixr+iB4UbCv4tJjsGUXTwCkGi912KpW92mcJPRq5w20K6EcRG533rO/drvpMQROg6MyS+Y8VPUCVXRXfDSltsms6PPMNFO29DaB/BHRFxzlToHPqEd8q8PKaYYvV0s2B/oflqGXk8MHM9YQ4xmI+2uC5Ox2o/AqFKVYRRmyx87kcilLjvag4etuPtyoF42znrNZ4hEz+BZEeYqpHG8HNTakoQ1TBkxNS2ab/BWBNT37Xlzdqa4CC9zxjPdmNZd2YKTZrKxU4REoiskGiaa1zPWA5ppdzKYQ8Mb6fnek5c/laNXx/dH8bbTWwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN9PR11MB5465.namprd11.prod.outlook.com (2603:10b6:408:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 05:03:33 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 05:03:33 +0000
Message-ID: <23dc1c47-88ee-6b2d-1a5a-d6c812bb1761@intel.com>
Date:   Tue, 13 Jun 2023 22:03:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
        "Nikolay Borisov" <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, <loongarch@lists.linux.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-m68k@lists.linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-mips@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        <linux-sh@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        <linux-um@lists.infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
In-Reply-To: <20230613224545.902376621@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BN9PR11MB5465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9876c98c-4192-4147-96d9-08db6c94b384
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZy+o22ciHCiVWsL2ieOGRQs/1xJFEln4x+7dmckFk/l1XUWAacpGrehoqO81mSQKgwq/AhyV/nQOCthZyYStwBW/8Aj+oBx/6z2WDez1poko6zKpElGGBKgD+JwMPtZnGeDtvet0j30aOsyuYIi9127TsdM+hETLqLdvVvJPi+kBWY2/YSRzBZpBR9YSiP9HsYBnrrna5lNMS9w/vwwokFFUCc2NEfY5PpVEC3OElgtmyM0/NClBKGo4o4MgvDKSpO+o2HKsK7G0smP+Jv8EKfzHakIbf00A6jvaC8rCaYP6s2WOJbo67wIbLmpu6SQ79lr1n6lCWSpJYMrENpWotbsMTUj6yfqIzlhVY5JnY8lrLb/F3JYWxn2ynmajP5lcgovGZ6T8ZIqTzOTf0KmWVHC1F62nYIjcjL2zwu7jNhQByBi8yUAae/S6y9cdLI1fm3s8q4HERhXDIIkzg+VAmazX25/u1bR4nVZEeWaYbCtSpwgeMdt6Ivf1ZtmBlMIFNBWWFBJ9X2E8SUMAwgsazR/7Nt2KS/yJYSGOHvjvQnh53asEN0su5CT0NfeJ5POYBOI4UT9AE8Pu6EZvhjFpRMC64fu85H7dgR0idwyTR0wBt7uSnfDrGWrkGfE7630zGfFPl2trMcLvN/uR6BYDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(8676002)(66476007)(66946007)(66556008)(54906003)(478600001)(110136005)(5660300002)(36756003)(8936002)(6666004)(31686004)(4326008)(316002)(41300700001)(966005)(6486002)(38100700002)(82960400001)(186003)(6506007)(7416002)(86362001)(2906002)(53546011)(7406005)(4744005)(26005)(31696002)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJDNk10RTJtV2pMR012UHdnamtIY0MxZHFWTXY5S3UyMzFvbnFCVGJUcjg0?=
 =?utf-8?B?TWgrTWR5eGQxTmlHMmlLUU00Wk1NYjMrc1RhWmxMcU53YWFaTERvQ0xDNlBK?=
 =?utf-8?B?aExhQ1AxN2VQS0xVY3grT3YzM2R6SFhlTGg4WkVCTktjazUwMUhuZFY0bWp0?=
 =?utf-8?B?VjdDMnkzZHB4RHVhbVJ1OTR6aGJBRHdQWWJtVldhRW1jY3p1L3lIdFZJSEVU?=
 =?utf-8?B?S0dGQnF5WUJFM1VsYitNdS9DdXBsTGVlVTMrYUU4YXRXcU45UU9NVG5xSHE2?=
 =?utf-8?B?TE5Zd0VUTG9xM1d6TUhQNWw5WlZaajFMeFhPOFgxbHF6U3BDM21CYWlrMnNP?=
 =?utf-8?B?RGR2VGJ2QWRFWUlRUUgreUEyNDNtNmc0c1hGWk53NElabTdaRUdOako3M0NI?=
 =?utf-8?B?S2hhUy9HU1kvNmVkdDhOdXZoYWN3elk2MEpCdk94TWh1SVNtRDBLTFNwK3l1?=
 =?utf-8?B?M0lEWFQrTXQwWHk3OTBXVkNzbzdReXBlQk83MVNsdWIxeGt3RDhZRXVrOEla?=
 =?utf-8?B?bnFBbkZpNVM4WGxPeWVGUTNqbms4VEhtRmNydnRXMG1ESERxQkFLanNpQksx?=
 =?utf-8?B?K0tKK2xTNDdQOHQ3K1VxaW1OMG1GSjBwMkVVeDhta3ZmcmQrYmVKbW9oUlRG?=
 =?utf-8?B?UzZiMnY0ei9qTkFXWUNmOCtSeDFnTlZuZ05zNmdaSi94NDNUTnJUeGpsTEFV?=
 =?utf-8?B?RlBqVUZWbWFxRVZsNXVwdEIyQzRBcHNzRTlOVndHTmhuZTZTTFNmYnBON3RU?=
 =?utf-8?B?azVocFM3V0RzbHhoMDFHNkpwRXE2SzdvTXVYTURmOENLSi9jQVdxMkJ6eFdr?=
 =?utf-8?B?Vk82N1QyTmhLSlJkWkthcTllem03WTBHT3RRMVJYdjRoYXp3b0ErK0RoSUsx?=
 =?utf-8?B?eFNHMHV4d0NHUHN4ODdxVkVTQ2szUnh1c3N1bml5aWYvR3BNQWlNZGlOWlZo?=
 =?utf-8?B?U3JCeTNDQWhleUp1dTNKMlA0NHBsZFVYMENieUM1aTc5OFEveGdiNEZKQitp?=
 =?utf-8?B?WDlUT2I1ckd4cXNGZmhMZFpHZkVXTi9qZkJETDJRbEh2dE1tTURvTm1wNExh?=
 =?utf-8?B?MmYzVVhaT1RWRUV4MFVnbE1aNEl4alpmNUZ1VS9Ya1FFeTF6MExMRkY4bEty?=
 =?utf-8?B?Zys0WFFPdTVPTmpjTUs4TGhhQk9uTnJOMmJpS3plV0VyVlVTT3l1b3owcW40?=
 =?utf-8?B?REZJU2Jyb1ZwTGJEUkNJdTdqS1hMSGR3WFkra3BaRlExemtubmVSQ0YzUVlN?=
 =?utf-8?B?a3NRYXQrRm1BbXU3OURzcHJRTWwxV0ZVSGExcHNWRlUwVCtXMFBpbW5Ua3Yx?=
 =?utf-8?B?Um5NZlkzcGFqMVJ6QzhKVnR5OGV3ZTE1WVJVYXJRN1Byb1dsdHJFSTROOUlk?=
 =?utf-8?B?Yyt6T3N1MTk1UHNuUnJRSGhsUDlXWGdjTEtKV3pvSXZucmxBK1BQQUdGZkd0?=
 =?utf-8?B?T3A4TjBKcWIyZXdiZUJTbHFMNzBReE5IT0JYVGNRUUEwK1hQUThZcW5tcU9L?=
 =?utf-8?B?NW9xeHVVSFB5TTlhUDZSUzY5YlNRTVJwcHVmdWZZeURWM1RxVjZML2hoc2I5?=
 =?utf-8?B?YWxtU2toTjdZYzhwYTg5WDFFV3A5MWhteTZlQnQrM0NZUFBQWTkwSHZ3THM0?=
 =?utf-8?B?cWw2d1RjYjVvV1AyTDRYTEw3LzV1dERHS0xpbHRBZFdDd1pMMHJxemtTZTA5?=
 =?utf-8?B?a1cwdXNzTjlsRTNYbVhpS0dZV2VuVHhPQm1RamtGY3FDTGdmVlF3bzN5NG1n?=
 =?utf-8?B?elZYTXFjUFVHdnkreDJ0YmpERktLbUxqSTNGZldCVFIyaXN3VnZzQkNLWXp1?=
 =?utf-8?B?TEZEd1FiZGF2TlNxL212U1JJWHppaHlYSmd0bmlUc09NbGJESkFNRUc4MnQ3?=
 =?utf-8?B?eDlRWEdHM1lvYXFJMjJGUXdkdGQ1UXVQcEtFOWswYUd4bjF1RnRCbU9KbDZG?=
 =?utf-8?B?VGJRcXlpa09uY3VLcFF3QS96WGs3MGFrWU01cEljKzJabFI0SWpydFp6NGww?=
 =?utf-8?B?c1hPNXM3Tnoycy9IRnR4MHdJaVV5NWE4L0FPTEhoemlMbVUzY3pPQm1RM2ZR?=
 =?utf-8?B?L09JQVlYOHQyWVBjTGZkZkM5WkI1SmJiMytSZlp3R1EzSWJ6SHlIUERsRmxC?=
 =?utf-8?B?aTF2d3pJWXNGYTVDdkROMEwxcVlRYTBEcVh3SW1jWlFlOC9mMDBUQzgzbTFW?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9876c98c-4192-4147-96d9-08db6c94b384
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 05:03:32.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d46p/S7Yr//r4uFBzUR70vDqh7oPaCC+qJ5cPwIvNYfOh/ApB+MYoTtZ5hY7e2tejjHbjdjimqR0N7iZOrhJOKk7zikZPNFSp3vdJFA4VqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5465
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/2023 4:39 PM, Thomas Gleixner wrote:
>   
> @@ -2396,6 +2393,13 @@ void __init arch_cpu_finalize_init(void)
>   			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
>   	}
>   
> +	/*
> +	 * Must be before alternatives because it might set or clear
> +	 * feature bits.
> +	 */
> +	fpu__init_system();
> +	fpu__init_cpu();

fpu__init_cpu() appears to be duplicated here because fpu__init_system() 
invoked this already:

void __init fpu__init_system(void)
{
...
	/*
	 * The FPU has to be operational for some of the
	 * later FPU init activities:
	 */
	fpu__init_cpu();
...
}

https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/tree/arch/x86/kernel/fpu/init.c?h=init#n223

Thanks,
Chang

