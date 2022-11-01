Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFA615523
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKAWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKAWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:35:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30F2037F;
        Tue,  1 Nov 2022 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667342067; x=1698878067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L1SFAYV9b2fgrbYEEqpnEzKx2BaN6Wl0nCd69iS+KB8=;
  b=fFUU9FMyx5big7YO1R7eNq42K35VWbqeUcGQP1L68nmZanYusU5TEYCH
   Rs+BFIIR/X6mE0w08DcGWs0D4sn/DTvmKPbFI6uRRWUn2k9EQq2CJas2W
   8NG6N1cpy6S7bTZnRg3L2BQDx47/BgRPYgL8/aVOoxe7VPqMTYSIcmZL3
   yPQePgRZwQ1bR54CNgUYVjswNPtWbhQ2ENz/QUOBqnXVKd6KP2okPFa2Z
   5AF+qK99CQ+t1pqqy0K2mpp0fB/n1inwlUdp6fRvln414ZgVLmzi+UUIx
   lJ3ofr6vbFrS/13lipWiprJKTmVksOSgfFAJfxGGFu64W0Omg2rAEt1NR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371345476"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371345476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723319688"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="723319688"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Nov 2022 15:34:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 15:34:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 15:34:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 15:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUDXV2yoaiaiCRfEF86kDn/4i90FQ6bZn039hErhefuxBgJxMyLe8Pvdj+3+TuDVRNrlTBwnrhugZSlpbw8XC00zyBXXHcNtouYMwDZo+OBfzUG98m1vTppk5Nx+Rk3mrkGxGlJomeQjnLI7QEWUA9BhMFTh1/k210hT8gPvDG2ssVBwOArSYUMlqFrcsFqA2kXZn9hPNNeq2yDcCqkZa+bVihjm9WIRLL99snryk0jIJqQrITCqYJDPrfM2fLAuunoMbv0tehI4GCHCBphxcT2c0Sbejk4FDjIdEEnyxSBI9bK0SnoqreXN1tHWrzAG4c6cGZg1hUt6r57aiSwWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bybFXYupy6bMDkXcTq2YHxjb0SFuvJPYdfF0jhvRWus=;
 b=Hm5mnzMsD9i3BRyxV4TED76hiGK/v0E0HVt2hdvD5Ni8oitoxuMzds0TLkw2SM/EuUTA1YKIPAXamFjxGjYPq9aO++jL7OEmSsPt3rI0qqfStV7AUePM2jZfgHd0UGLFOLPHW7gFKWJspugqVHMvJ4wJCKqtXoZQeI9w40gX7KkL+Mf5peZJB7w6EUE4aRHXHWduRvcLTXZXYIKdUQ5r++OZCdc+UmiHHpKIbpB+UISSN4h8log4CgtkpOBzkEkZWvQ4J//e/u4UMc1arVj/Lx0IUuHV0Nb4bBM9aYpQ4XA28Clzkvuyir5iqIDDbL7kjfr+IcOuB/nLAgevQhtwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 22:34:21 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 22:34:21 +0000
Message-ID: <0722deb9-797b-c8b6-ac15-a6d9a7d50a67@intel.com>
Date:   Tue, 1 Nov 2022 15:34:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 13/14] Documentation/ABI: Update IFS ABI doc
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
 <20221021203413.1220137-14-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-14-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf8d726-8160-4cc5-13b2-08dabc59387f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGwKcSdxEFjHN+M6ZN4px0febrXA6xhSRsIR+tLjqhRuF2x5hgh4HOzqMiOx8PmV5PXtvsx+JDyUl4O7SPU+TOlusYfswgI5UUSE+mNzFYTFJ+NLMobOWcl1xXI2pDTgSb4XVJ2DPU+90QHsZsdQDILsRlNnRWDSBrWLbGLnSBAacQL3xHd99dNYovuSE+qtOxFvSoHtYNGJiiQ+uCJvMl651E6SXZbSyhQbAVDylO4yXwvKjxOZKllq54qUj9aGvMqa49J8uOGRAcu1zn9mTuZmQItm9mKCOrs/JWcS8h7HV8Z62bQ6lcQN8GpnmTXQH4DD7zD41ar2YOiJxx5EkKDimhEvYGasJ+/zdXUejX/zmSb7Wl8FVUqdBN3akjNj3pCdNi3Gr+ZV6/m47uaMzgFPntA25vrAprIi5rhKPPMQxbvxA8Sbr3hRnXaiQGUlMdkCxM6WCTKa7RDscj3ELUE3KPMZYeCxOIRaZauEr/JkyK0tWBE0hLhWHGvh7yaGyzfYfimf5ZiBFIJLKGFPSGmclBUdKIDip2auMquD7pZq/LebosWBuyLMd5Y7d2DqtRtQ/mJBtglnQUhbeJ0/VFOdsabnDveDgKUhXzDrkygOpJZw4IqGdp4MrjuB9DqglBHL5Cec9PAKwCNHi/yAVaA6uQi+8/8SaTDirq76MHSfS7uceS3ioYcF8UGtn1RFqvTsuwgoOrDuanovTl+6R69Abu8GtrgZXZoWI0d6n8MBt54oE4aQ6q4DrgGtLVn1T9COvzndIvd5wDKC3upmiM7rN3bOlDUWEdSw9KzNXwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(8676002)(186003)(66946007)(53546011)(66476007)(4326008)(2616005)(38100700002)(82960400001)(316002)(8936002)(86362001)(41300700001)(6506007)(36756003)(31686004)(6512007)(66556008)(5660300002)(31696002)(7416002)(6486002)(44832011)(26005)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlWa2hiaEpuc0kvUERER2d1YS9kZ2lPb2J5L2ZWZWpUK1Z4V09QSklDZSsz?=
 =?utf-8?B?T2VZdTdyUktJMlUyU29kSnBUWjhDUzd4a3JoT0NMeVpxcXI5RmRIOE5kcWVF?=
 =?utf-8?B?RXVsdHNrUUd2V3U1UDBFVURpZUg1WmdWcXliQVE4UlhBaHlNa3pRMytkR25t?=
 =?utf-8?B?eVVGeWlhUmxTRXdjREpHRzB3TmZSMFVoQzBXR3ZBYlRLZk9vYUR6SGRpN2R3?=
 =?utf-8?B?UHkzaWI2YmxSL21VYVlVeFoxTVI3SjR3aHZra3ZNZS9LekN4V1lYRnN3aVl3?=
 =?utf-8?B?MFJ5TzJIVzJqZVo4NDJ4VDUwb0xodUl3ZGNIOXA1VzlBaUtzdFZvS0NPOU9Y?=
 =?utf-8?B?VVQ4aTkyTVBCbUoydG92djVqWlpjNjZmdlJDMzRybEM5ano4ZjJJazNiZS9l?=
 =?utf-8?B?MmhxRTBaVXVBbkk5aG44cTdEdWx3OVNzQjR3clEwUEd5azQxTS8vamcrZHBi?=
 =?utf-8?B?WTg1aG9pUFVVMUQxaFpTWW1KeHdVZkVCV1lDRlVPWTV6Rkc1L3dSTFFtMFdD?=
 =?utf-8?B?eWw0T3lFdmc5ekplQ0FMNjlKYXg4eWxJZWp0TGJJaGpEd0dBN1NwSklSUkJZ?=
 =?utf-8?B?dGNoekhvMUhhNm1LR2FiT3MwZzI4dGdWYVdaR0pSd1kzY0kxNFJmOVF2S1ZJ?=
 =?utf-8?B?Uy85M2YvdzNZNFBzY2gzSzBFa2xtQVRtOW9PYmsxbS9XK2xvaE5iMXJ6NFZG?=
 =?utf-8?B?NUtLRmhBZ0VPZXNGdDlkVHhwRHYzSW9jUzhyNG92NmQzdnJ2VWZCNWlQMUow?=
 =?utf-8?B?cEw2cXJCK2tDd2FrbmVveitZc1BFcHZhU1RQSmZ3UWJTT3M3d0k4UVNLZVVW?=
 =?utf-8?B?MjcxUU9oTEhUaDNpVVcxZU53aDJNUjhlc2RIdTVROWtXQ0YrVGlGMm1QMUgy?=
 =?utf-8?B?QS8zSU5EZHUwbTYzUGNCN2gycXNlNStyeW4wc1B6eEN2MDlXcFVNSW41UlVu?=
 =?utf-8?B?YzJHbUFvSWo0RXRCQlk5WEN3ZXlvYmVqblNQcFFYbi9CeWhiZ0RkYThwazQ4?=
 =?utf-8?B?TDJ3TTBVajMwVHM1d0NsUmNoT045UlhreGRHOTdRUk5hVDZOMlZ4SjhKTW9L?=
 =?utf-8?B?N0N3SlJsNUtVWkcyekxLWG9YdTE0bExlRktZVWNMUE1WMm1Iay95Ujh1MFBR?=
 =?utf-8?B?bmljazRGakFTSkkvV3FPWHl6aW9Idnhmd3JnekV1dG9ad0s1ZHRubjBub1JW?=
 =?utf-8?B?RlFsQnhRY2VqWmk4YnVRK0lMT2JudG9NQUkyYWdNeDMyWjRBYmQvZnR0VHNv?=
 =?utf-8?B?NlN6ZWVNZm44eGMxcXluM1cvMWNrR0NXaGtrZ083YzFxU1JobUJrbzdHeEw5?=
 =?utf-8?B?TDBUK0Y1WW8zb0tONjNjZW1ia0J0VDQ4Q0czOVFSc2lMZVVHUS95U29WY3hH?=
 =?utf-8?B?cENYNnNhRlA0WmFTMU9JRUoxNmpaSFFBUUpkMWxOOE4wT1NBY3ViNmJ1STJ2?=
 =?utf-8?B?TklKdHk3cnRKRkVjNldYczVEdUlyb0h3TlE5NnhDanZnSG9vaUtKMDF3WHo0?=
 =?utf-8?B?c2dBUjZlYXhmTnJXZWdIVFhaaHQyMXZmUElNV0lYRElUbndhczJVY2tVN1dS?=
 =?utf-8?B?cWV5RDd3K3pUalBFaXpCOEdCSm9xTnd1S0VQUjJrZ3pPZ2hvc3JvRjJuVUVu?=
 =?utf-8?B?WWhoZTZSU3BwNDVRY2FlaEFYbmllY0tjZ3FxWjhEYkZoWXI5aXRORFlSWXBO?=
 =?utf-8?B?L1psV3VWL3Y5cHFWNlFPZkoxWll3MGZkSEx6cjU5V1hYbVNBd2VoVHZMcnFR?=
 =?utf-8?B?aXFIOXVOdUtiaG1RbzFJWVB3Z2N0djNvRlk0UzNIR1pjbS9aVkZPemlhSXVT?=
 =?utf-8?B?UllpUitrdmp2QXhBb21vZ2xZcjY1NjNIU2NZTlh5N0ZGaE5mUGxSL3RpcXgr?=
 =?utf-8?B?UXcwUTN0QzNIRW9EaHRBeUYxWVMvOFdsSnp2R2NGU2F5KzN5d055ejV4Y2tP?=
 =?utf-8?B?eUFiSHlNRW1uZXBFMkZsT1pjTVVMQmt3aTZROURrdzZlS0h3WHh0NjZXMytB?=
 =?utf-8?B?UkRzQ0IzQmQ2blgwWWpBN2Y3NGVMWGtkWGFXNGZtczZuNXJzbzQyMWlGV2VJ?=
 =?utf-8?B?ZWZkL3NlLzh4SG80NHoxRmRmRm93ODJ0b3ZNbmtzc0N6VDJwZTdDUGdnQlNX?=
 =?utf-8?B?SDlhSDJ4TTFudXdUUS9qRjhpenNNVlFwYXVzWG9mVTM1Rk5XYmF3N01IbVFs?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf8d726-8160-4cc5-13b2-08dabc59387f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:34:21.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ/xCqCQJ8c7ycAr3NRMH4MFZotD4liCRCCVAe2FRtwAmhrUmdwP0g4vG73gB6cU9oqtjxua1cy6GOlTahHg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
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
> +		The number written treated as the 2 digit suffix in the following file name:
> +		/lib/firmware/intel/ifs_<N>/ff-mm-ss-02x.scan
> +		Reading the file will provide the suffix of the currently loaded IFS test image.

A few places in the code use the following string: 
family-model-stepping-02x.{testname}

Does that mean that the in future there might be other extensions apart 
from .scan?

If so, current_batch would let the user identify the 2 digit suffix but 
how would they identify which testname is current loaded?
