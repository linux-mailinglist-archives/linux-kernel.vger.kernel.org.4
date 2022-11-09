Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100626237C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKIXzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:55:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4201E3CC;
        Wed,  9 Nov 2022 15:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038111; x=1699574111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eaM7jzbn6YeSji18WzR19Jg8/yYhlwaWJglIoz1EwRE=;
  b=FZKa1Apnzamjtm5jFBJjfxsABYcBPkP6fyeMqEi5As0lQmSWdpx+YEZv
   noEKes2p1YSX8OcNQ2UxOC0vJER/zJRwR21Aej+6RmL+WzNFmtWRPRkhd
   6mi34mQKD/zowbOlFsBVhz3WdRAi4ht0RsuN/+9qzNT3YcR5VKM17weGt
   i58pmuIBE9eo+mSosDR3SxGr8ZcemcuzaFWAhWiyuSR82/3ub/GPSepzo
   8gtrsF7tT1kDlrYsW3/W2HkzZY8tSkQQbCxl/MfvRs0z3v7HqK3hyTfwP
   7d879NO1/GkA/6u4v5JiR3pLAuShA2IK/JlyZYlWjQIX05AvVyvlB3Db9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311157170"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="311157170"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 15:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="966191521"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="966191521"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 09 Nov 2022 15:55:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 15:55:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 15:55:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 15:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0jwkPGvcpmSZd9K1PnwyVniekXJnnF692CQfE8jcHt4u/dN4ZW4e53Fz2CPPOM/Iwh1OLKZn8qR5fpgQMCjd8odmib42Be4gtwLtfwvOROQjrn3iTuctKO4N7/HuYrEHQExZZuVFNtOmKh5dPCL11Xa3rJeMka9HwjRiXjFUh2SGIU9JWmGIKm9Tycx6bA4PlWtRROzj1EKSjp2m56+3IAsaHUA/+ZHrPwAmqwcOBhtut+suPS5jjhmI/HUp7a8AJlXWgQM0jz7yaHwpAucv7X+Hp4MO/kBpDPSDZsYxq0v27ZaeTlJgi5qhlreqBramXprMPPvwNsc3hAOJipH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5tKpANdXKskGyUs9Q868ipm2PhQpPRAnK//omgX2uw=;
 b=gVzKTnF0F0YiHIn0+4Bc/PxHn2j805PSp353CrWg6GVtLnuPdcDk0eIEGaM1psKqTx/bU3Pr8/ot+LZWHXW5uifPwlUwcbUM7yapppuKMPP+PNw78gHiAzxAAsG2PIIXjf13ZxJXbnUT4JuzZe5E0okxPJonPm2TeoOU0iRTSDHn8RVS4PIghKJ1D4vP9y2DFt9hGHJJhMZ45Li1xG/4BDApw1xgXeV0GSZj2IxSkJyojuMuZhNAddeez75TA2t25zhTaKD+ocyj3uRdRwEgIOSwoU9ZeiBRU91rwT6Sh6iFSTDQswvIMuqz1mHYApzbP9VjMGrk3aOm1SpXzHV5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB6330.namprd11.prod.outlook.com (2603:10b6:510:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 23:55:07 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 23:55:07 +0000
Message-ID: <503ba3e8-f060-002d-846a-8dec7e84c83b@intel.com>
Date:   Wed, 9 Nov 2022 15:55:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 13/14] Documentation/ABI: Update IFS ABI doc
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-14-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-14-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 126cbaf9-8067-402f-3be4-08dac2add403
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kF8i7iXmqoryV0tGC3yvf/WRluTSuUEU6tchIrFmoSRokUw1l/swq0FRDlEKzGWDECAIzln44ZtMb7cKItxzfKQ49ZF/+ogY32dGhUnJm5uVs7HfIJbjbzan0mbOZPwlPDLD2ewNvVz4ziCRgoTN7FZjpWqvC1JL+qEyDyb7yIyRzPUii90AY2aAzwNAOPUGZqEQc31xS6kQDcVOfa0BmrH9fbzTvFl/I5TH3WWIgfR2YmruvPsu9ksZCok1RDHwNOpNCI8niRmuOyrX/cTpY4Zv/gtkIXDCQYS8WnT7ehyEb0RJaS1R/M7kRG49ZVaeb2Nyhs+wJ88x1uyvmSoWKvAV8iAJ+l6ezczAP4a3Tkk7jc8om8WBxuKqj1zXZ0CionbF6yLB4f3Jb1HzfBtcS1EdlnrueGiGMo2/0DcO/9snLuM5xZGdyGBZ1btQ6bx+WZBSwx4Rj+jr3FPXVgZO6jANraH4xvGio9aRm/EgOqUdgom3R6caM5lgRN1jkB1fLm7NnDIvfiqS6dNhJRt716/lczsiFo8qDEIshPRe0k5fyPWiGFDHqRhAu13ZHsOAbCH+ByTr0UsUVe0fUa+wDtphdb3MiVEbnjbQUG7lhGs6Y+oL94Tox47Bue+2omw32OreIjcGiyijw4b8KAPUjtCECT8a/JMTuFxDwbtNOC6G437VtyPsdE4c/Zl3dReFUhmY5uKBN9A4tPh+r8LG2Mcd72xJxaZewA5N6zt1g0POQ/irth5X5fEObfxjZk0TaMREJRoUbpJDTBaPdfrRHy/mtWO89N/ftSoQ+sDFc0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(2616005)(44832011)(186003)(83380400001)(7416002)(53546011)(38100700002)(82960400001)(15650500001)(2906002)(5660300002)(478600001)(86362001)(6486002)(6666004)(6512007)(66556008)(66946007)(6506007)(8676002)(26005)(31696002)(8936002)(316002)(4326008)(41300700001)(66476007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStneE55VEVNYnd4VFdkRC9VVGxlNTJveFJHV2R2a1RIR2lIVG01ODFlcEk5?=
 =?utf-8?B?dzlCcjNxbitWeTBKUm1UYUJTUTlPMzVhTE5tYnZWTGMreDJUVHRkV0lYTnUy?=
 =?utf-8?B?VFVTTC9RRGtYVFQvK2dIQ0VIdjY5L0ZKcGswUjQ4ZHI5NC9oWFRIQTlwSzJa?=
 =?utf-8?B?NUtDNnNQZjd2RVdzNlZSVTlqd0xkVmdUcTdEK1F4U3BkLzJaWURxYXo5T0du?=
 =?utf-8?B?T1RxWW1Yb3ZPanJlcXNUUklTa3dGdG42Y29yNWhkUmg1STFQemVzMHNLZzA3?=
 =?utf-8?B?cnJUd3ZzdmJLaTJ4anppVFcvaTZ5MVR4MS9Fa2VKWS9pMTludG9MQ05BRmd1?=
 =?utf-8?B?WkVBaXZqd3pJbDlBeG0wOCs2K3BLU294Ym1tK0pnUXFBVzhHQW5HVVpraTRj?=
 =?utf-8?B?REVEN2lscU9QajdKRm5nRE1mOTB4SFFLSno3ajJiWng4U0ZaUVJyZENCZktp?=
 =?utf-8?B?aTdLdWl4RmpleFdZVzJqY3JraitFODJlZlNRckpHSlRiRGQ1b2NhYlhRWDYy?=
 =?utf-8?B?eW1BVms5ZGExeHYvUzRsY1Z4Yk1ZaUkvLzFONGpyWDRLU0RRWGdlVWtXU3BS?=
 =?utf-8?B?cU5PVlNGSTVGNmsvUVBEeXlhMFNqdk9UdFRkQjJMdG10ejNvZURaS2F5NUNS?=
 =?utf-8?B?WldqM254QWRCeTZVMXRkRE0zeTFiRElycUh4QWhFYkcrZWtSbUtYVm5zaWww?=
 =?utf-8?B?eU04YTBFRmk3a3hVUDNFVEFjNytUcDFTZkdQM3EvRk50YWhxajVTc29rNEE2?=
 =?utf-8?B?bWVYK3VXU1VvOURENEJ6WjhyamRGYzZBRm5zTmdUcXBza1BtUTdUUXpVVnZU?=
 =?utf-8?B?bkRudHFnMjF5a2x1N1Z1NUJPOGxDam9ZbWxVTGxVUk9lOGFjVnlWWjVyNEE1?=
 =?utf-8?B?UnZpOUxGQjdRamxRbGtQSjgwWjdXeE4zaHFKM0wzNG9WaXJraWxybnQ5U0hF?=
 =?utf-8?B?ZVRodW1zRndHZTRZcXlka2FZenhsUlNsTlYxVmFBNVVzc3FJVWFkbWdzVkc4?=
 =?utf-8?B?VzFZb2syeGRIVmJYdm9ZWVFsTU9lSCtsQWlNeDhvYXNKTkc0M05UZ3pZSXdP?=
 =?utf-8?B?NEgzMFdZcUJydnFPeXp5NEhCSml3R3dVbmYvNEN0M0d3LzRKOFpoRlFwVFRR?=
 =?utf-8?B?VldCWnlMVEcyTWVyZi82VWxKYzlwQzRSdldqSklBY3R5V3ZxaHMzRTdrSTBV?=
 =?utf-8?B?UkdhUUZ5RGVxRm5IZWExSE91VW1tdUlqRDNJa2UvSEphYWtibDlTMzB4NkdD?=
 =?utf-8?B?emMwOElveTRhUlFNRzNOcGN4cm1Sek93bXJZZG5uUjJZQjdIZ3lNMlVFREV2?=
 =?utf-8?B?b0gyaWo5UkIrY2Z1SEFrcTlXVENuTDFjUWgxQlREZ3Ywell2M25IZ2t0cndk?=
 =?utf-8?B?UjU3VnhrN0dtSEtiVFdxcVJaTGNicmZtSjJtVHhZTlhHTllPSHF0eXo0NXln?=
 =?utf-8?B?a3h2Zmh1WEhzTHhCWDFMaGp1OTY2ZXlZSGh3M1FEUWN2YmRsdTdZWVhKSDJU?=
 =?utf-8?B?WDRjeXE0VmIwQmtUY3NFZnM3QXNxNzJLTVh0UnlqTlNvSmhjMEN2QzBQWGZ2?=
 =?utf-8?B?aCtqZFJBeDA3VHM4ekxxTlkxRzc3dVFqVE1zQ051b1BMVVVOVjN2RkdYUmw4?=
 =?utf-8?B?NklMMGdzZzU4clhYWEpBWFVsMlNkd1gwUWdPdlJmRVJiMUQ1WHZ6QmkvSkpl?=
 =?utf-8?B?ZHcrQmhranBLSmV6WlRhK3dMSmN4U0NhVkc3c2JxR3NneEJrajhqaktJaVlv?=
 =?utf-8?B?bEFvS1Bsb0g5cFFxaGM3Vkg0RHVoTFNvRTdSY3lnWUpKcTVIcm0yQnRLVWpv?=
 =?utf-8?B?a3ZtZlBQRkRHVmRQMzJnVWs1YWFTYTFvUTYwRm0xcThubElDdUVEczUweXNY?=
 =?utf-8?B?bGhsdGNnNVh1eVRYZDkrQTd2ajVHa0FWV3U3WnVYcnVGWWVCaVcraEFnUWdS?=
 =?utf-8?B?UVVyQ0VPck93OGRieUNlbVNDNkllQUUwcEhzQTBYSk55dnc4cWJHVGpZaEN1?=
 =?utf-8?B?NVB6dVBSQ0xOUWZRUHZKSGgxaXk0U2pvYXJmQk9pbDVzbHFRcnB1RzRKbmVq?=
 =?utf-8?B?OFJHSjN0bVRad3BYVlc4U25wRHA2TGZyZjFrZEVmLzlqR0hwZjlEZ3BaUlpG?=
 =?utf-8?B?OGF0ZDNud0xkNENVMk95RVEyVnhNM012c1d5UGdybXJJd281SjVMMWtpM0VW?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 126cbaf9-8067-402f-3be4-08dac2add403
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 23:55:07.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oAfKGB51VAekMX19UKuXnFkmZNX+7/J6tJZfJqAEWTTMmSbWdAEza6M52ulYKPtp4bfWyrAmdj9hRR8esigyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6330
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> Remove reload documentation and add current_batch documentation.
> Update the kernel version and date for all the entries.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

A clarification below.

>   
> -What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
> -Date:		April 21 2022
> -KernelVersion:	5.19
> +What:		/sys/devices/virtual/misc/intel_ifs_<N>/current_batch
> +Date:		Sept 30 2022
> +KernelVersion:	6.2
>   Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
> -Description:	Write "1" (or "y" or "Y") to reload the IFS image from
> -		/lib/firmware/intel/ifs/ff-mm-ss.scan.
> +Description:	Write a number less than or equal to 0xff to load an IFS test image.

Can the number start from 0 or is it expected to start from 1? It might 
be useful to mention that if there is a constraint.

> +		The number written treated as the 2 digit suffix in the following file name:
> +		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
> +		Reading the file will provide the suffix of the currently loaded IFS test image.

Sohil
