Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC775FDE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJMQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:26:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6EE09F2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665678402; x=1697214402;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=toSodBOlO8DDxGKG6HfO6x+4eUOjWEtwaPmcx/PR/3Y=;
  b=hlN5vIalI1fTjUA/NpAk5uSrJONLSDONlvBstfHPgVYg/UHJhS94PjiL
   exB5rfdT6wQiBLD5aKE5ZIREU9VFuQhskjQRjkNGpIFTVPx9+OFm9oy2i
   gBCNrlB92/h24I6XzoQ/E7HeoH3km04TwWVlwgxTejwQJ3uRBc3t8a4Xo
   lyKzQg2zzGf1OaR/Q2XWOcBqcnmCyLXEG86GoHvWOE1z7MDVSftKuhmlm
   NfjODIe4XPPbsyS8NzfhMUr5UKa3A/AukZQSajuzNbmI86dWJmLOxqxp3
   JrcOyrMpC2CzUmoqLOIzygKFlJujux6xvKmrm6n12Ow816FhacZZGR132
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302744256"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302744256"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 09:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="802305927"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="802305927"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2022 09:23:24 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 09:23:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 09:23:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 09:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hacbkjs8P5tEHyjoJ8oNN2PtuZ5x+IeYoy1+EKwnaT//2Gv7x/dSG3psfHGlgB2kcfHrE2MDn1vFDLuAtFkLwncWSCJVzOCC7P+l5BFmQ0uV5RFfitIBfEdGZCBl42hpkgqPa+HfLGqT1IZAftCHTHvKd864TtuCaJ6utlGPQIoVctdL3eVrLPP/J5a8L6JfjJIYuDmeu9reNJo5SvxAO47YDpnSbKjkQ6GexCQrD9v3iO5yzX3t6fxKEhRKL08SfnGbjDckpWSx1I5cHOktDtCzchLvhM3JO6uKFSW74sSBigaIII0URpbhI09ZIwoZ77bHp+kcQX7LQmGKytbVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTUSI4TXo/FPJAGqE32rjS42LMVPDNFVHLs6AsyRBoQ=;
 b=Myu7+7H73TZWgFFMrhyWJ5g2RUtn8d9VcTSfGZJxVsQ6pO4ocQ+AxlSj7ynGzOugYUBK/xvAFYSkMc9pqDQ9o06SZLbo99tNyKT7dLya+kwkteklqqqlpv9fTWox4ACpvOheVX0dW2HNngWoT4QWKQHqvSIgmBZawBjT3pHISoYw9BEeU4N4LAiNN0b+65NTozbpKP00kBqsUyYnQ/JoUxWRsfSto25dspBJydzo4xsNfAf2Huv8ggdZ9Du5cQFQ9owHA1nd4D6J/WK2CYnl6pkNvvHv50hMey7+bxNIHpBpmDRdJdgPZcHDunua3VdEZNzhf9pmkHDQNuS+fs96ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN0PR11MB5695.namprd11.prod.outlook.com (2603:10b6:408:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 16:23:22 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 16:23:22 +0000
Message-ID: <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
Date:   Thu, 13 Oct 2022 09:23:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     "Yao, Yuan" <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BN0PR11MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7192f5c7-23dc-42c7-27c3-08daad373f35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZ7CKnzQGpNilYrFWMr7xMmfLXrdi0sFPTJx7XHTd370lvrgWObYi05yv3z8SVx58hopOP+o1sxtjTAzHqPq5bSrRRwCpzM6N6oQlGtIiaP8HV3vEjL8Ba/R35X2r9HLd1q+Hke8rj5jzMo5aTGIxpVR+0LyLNbl4Eov40ZPHiz+CDS6jxKDMwIbFSFb/hIhAMjcM0lKWb8GlaL59nPo6IIBs/gwbe1OeOJbpt2u6TxgdXxPaUvTdp7vuQdww+9QoauRaEdOGK2EffZqO7pzYo80UW2xJzLHFrVRjA6n+xQs2XY5uEWCffoEm6C6AwSoDUUIa9tMBUuetb7OJK8zihhlLZ4nBlzbGSAklVjHe01cqp53Fs6tHMFpUw3KzlCfQagFvz8BgLiic60oqdoT6YWyPyw+pxMvKzF62if9ZzHvO1hcfmjv0flR+0+y1xISFd8gf5qQWzYMIq2/LIBnC2UcfD0DVeJs5rQsL2JalW+vSI2HETM4PhxECs/km4HrgG9LfKYbj8aqjYeGzOliBI9r4RvvuZckmglylKCB50Bo6JykEA7IY64nVDd5BMUtKkKAvNboLI/qCVqJxxJrlEf6diMPEIQ74uCDmS6mj5R/7S2+LrqG1Phc8YNZIoJ317tNQWYYfXTg50n3bwdzdJZ3v97M8L1YR3jGwlDA1mGbtiI3snFLxOvFvoDpCuoWYF9dOLYr396YGnZkId0uXtpVCFCVvLwT+s+66TlFbyRWvkLDIEpO0++RpYz6svj0WSWPvZ0EKgK16pYGvhQbCdB3mNVP3vsdE/srkv6izVYd4it7iaJ0bw3InXRYtidnGL/dYYS7hYecfZ/5wX5yv/HFKWzKA+Pryc6SY3YQnfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(83380400001)(2616005)(31686004)(2906002)(86362001)(36756003)(8676002)(4326008)(53546011)(41300700001)(6506007)(82960400001)(38100700002)(110136005)(54906003)(478600001)(5660300002)(186003)(6486002)(26005)(6512007)(8936002)(31696002)(66946007)(66476007)(316002)(66556008)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JIQlBQMDNTdFR2NWJ1ZXBVUG9UdjR0ZFM2UGkvZFRYQ3NxcUhYQ3BDUUIw?=
 =?utf-8?B?UEkxc0VmdHphMzFPbDU5dGlEUVVWQjRtc0oyK0lFWWhrUUJmR01pdkRmM1JT?=
 =?utf-8?B?Njhsczl1ZFVncjNlcnRWcFdjdldpd29QeUo3TmoyRXI4QkFxYUtnUFEvdnRZ?=
 =?utf-8?B?ZytBcDNCVUpsZEhJZkJzNzA3SlQvNDlOSlJ5WVlQM3R5Y3E1cFprV0k5NHc1?=
 =?utf-8?B?b0V1UzI2VW5EZzhvTWdjWk9WYWlsYk01QVdBSjVGVjdoS3V3dWNvNXBnbFpZ?=
 =?utf-8?B?REZmWkdIVTNVOU5lSHd0dk1pRW5pWTlFTmx6YU5ocTlhcExjemRNeGVEcnhh?=
 =?utf-8?B?WTVoOGc4SzAwb2lQYjd3c0NGa1RNTUlPZ3RydlNGd0FIeG8veHh5QWlQZklE?=
 =?utf-8?B?NFJIV21Da2htRVNpUnZ0UGd5Zy9zMGZrS3RFeFRZSGpFZE5PbEFNdDgveHQr?=
 =?utf-8?B?M3FRbnVPZC92eFlJOFZUczVvL0Z6MHNKM0g3M05xQi9Hb1hvVjN2Q3FHZkFZ?=
 =?utf-8?B?RlRxMjY4TGhmOGpGUFJMV092Vm8xbEJUZ3BBYzlybWZtOWY0YnlBbHdYbGdo?=
 =?utf-8?B?Mm9kaksxMDhLd2hSUG9vS2hvOFlUNmpGK2x1bnVoTDZZMWRWOVN3U1JxaTEy?=
 =?utf-8?B?SkYyNHBMOHlOdXAzVGJKc0dNTmdtblZ5RVQ5MG90SkpPdFFqdkJ0bE9JbkI3?=
 =?utf-8?B?a3M4NFlweXZBeTlURGtKRm9WRysvWlhWVFpPU2lqc3F3S0U3YXlLMkx3RmZo?=
 =?utf-8?B?RGZZcURSNjVsSTVMaUJJZVNaNDNyblUwalVJQmlRQ3c1c0lPaXh1ZExhN0Z4?=
 =?utf-8?B?MkF2Umt0akxwN0RIN2R2dXA2MVI4UTZudlptNUdmcHpOaFZiWHBqVXQ5bWFZ?=
 =?utf-8?B?TGxJVmtMRVRQWGUvRkE1YXRlRkNhT0JZWVA4VThUWnJvUWJ4QlJWZXlJWU4v?=
 =?utf-8?B?TjZMKzhWcUJaZnFSalNDSWNkWGhydEVQeThSTnJXYVJEK25PTlBSZDRQSkJl?=
 =?utf-8?B?bWg1emIxMlVwVFE3SHBFQ3hnMWxha0l2ZXFJSllmanBYOXA3SnhlNkZnUDA1?=
 =?utf-8?B?ZWhLb2VjUFNzMTlGY3QwdUNTdUpHRDM2VXhTVEVFR3RLNHdYb3JLNkhtNWdj?=
 =?utf-8?B?cjk4VUo3Rlk2WnM4engyZDYraVVpaXZoandvSVJYV3lvYk11aW1oUkxJT1lr?=
 =?utf-8?B?cDdEdjkzVzRQL2J4eW5IYlY3MmsrZDBkN0ZPa1VHQnVVVzRyZVZFN0dFcHlR?=
 =?utf-8?B?THFEdU0vVjFBQ0I2QnVKc3FlT1ZCbWNDSFo4NXJkWTFFU3REbmREZ05YS29U?=
 =?utf-8?B?U1NtODVneXZxa2g1di9raGhCUmlSN0d0OXU4aGhWV09jakZrS0NSYlk0SW9Q?=
 =?utf-8?B?TU5uWFEzSkh3Qzd2cmw1TzZrdVZjR1RDRWM5OFVXZWtDZzBwaWFOZDh1ckJ2?=
 =?utf-8?B?YzVhaUNKemNwaTdXa3U3Y0xyK2huNGJYWHNYQlRHbmNkSVdqZFZSd2R1RTJw?=
 =?utf-8?B?dzlHUGJUVmViOWJ1Y2Jad245eEZFOS9wS29vNG9MUjR0YUY2akFwVlVkanND?=
 =?utf-8?B?MVJzTmZOQ1FPMU5LU0ZmMmhxNE5VVkh1UG5pQ1RiQ05ldnl0T2thYWc4Q3E4?=
 =?utf-8?B?NnlKYUhsZ3RCWUdiU2NPVS8zcmRTdExkWEVSMDk1aXdIVzBXZzYzbnlhUTJR?=
 =?utf-8?B?bjE3MEpLZGhGeXhBTEVpemsvNDAxeFdmN1NydUQ3RElrOGJrMGtmWHJFTmY1?=
 =?utf-8?B?Q25hQ1JVMlF4ZytlQ1dvZksxaFJLOGxrUkp4ckxnbUdvRjFad2h0bWJKa3J6?=
 =?utf-8?B?blJBMHZQTTZXajdnNUdZMG05SEVQdWsrZW9zTHc2ZTZRY0lVUENTNS9tbCs5?=
 =?utf-8?B?UW5CWnlsSGIwODQzRCt0M0g4d0drT0NvdjV3MERLczVxdXNPdlhOQkRDRTFu?=
 =?utf-8?B?a1paeG9mN3RNMkNKWWozam03dVc0VUtRcXBnVHEwSGFLTVBYYUw0eExyUE5z?=
 =?utf-8?B?YnNxbzFoRDEwRy9SSVZwRGRrblRseC96dTBiNWpabUQxaGpYMTNhdERrWDJK?=
 =?utf-8?B?TkhsOHBVZEtBc3VVdDhpamlsTlRqMERIc3JLN2E3RDF0bFR6bjZTMlJhMVNN?=
 =?utf-8?B?U2VnVWpCQmNVaHE2cXhKV2d5NnFTRUNUc0U5bUdRb2ZKdzVsVXRpQUhrelNk?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192f5c7-23dc-42c7-27c3-08daad373f35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 16:23:22.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSzS95qwewdK2PILvAmF0NeEOtjCWroOsgB7Exj382n4wPkDnG80bB1RaV3fbHxNiUf1kDQcKSmr0FZVChv0Ld1UIPsX4dr2TlLrHzJiUfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 8:35 PM, Yao, Yuan wrote:
> 
> The reason is __copy_xstate_to_uabi_buf() copies data from &init_fpstate when the component
> is not existed in the source kernel fpstate (here is the AMX tile component), but the
> AMX TILE bit is removed from init_fpstate due to this patch, so the WARN is triggered and return
> NULL which causes kernel NULL pointer dereference later.

We have this in __copy_xstate_to_uabi_buf() [1]:

	mask = fpstate->user_xfeatures;

	for_each_extended_xfeature(i, mask) {
	...
	}

And the KVM code seems to set dynamic features regardless of the buffer 
reallocation [2]:

	vcpu->arch.guest_fpu.fpstate->user_xfeatures =
		vcpu->arch.guest_supported_xcr0 | XFEATURE_MASK_FPSSE;

The kernel code seems to be aware of this as fpstate_realloc() does [3]:

	if (!guest_fpu)
		newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;

But it updates the 'xfeature' bitmask for all:

	newfps->xfeatures = curfps->xfeatures | xfeatures;

So, I think we can do something like this here:

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..8ea7d0e95f1a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1127,8 +1127,12 @@ void __copy_xstate_to_uabi_buf(struct membuf to, 
struct fpstate *fpstate,
          * non-compacted format disabled features still occupy state space,
          * but there is no state to copy from in the compacted
          * init_fpstate. The gap tracking will zero these states.
+        *
+        * In the case of guest fpstate, this user_xfeatures does not
+        * dynamically reflect the capacity of the XSAVE buffer but
+        * xfeatures does. So AND them together.
          */
-       mask = fpstate->user_xfeatures;
+       mask = fpstate->user_xfeatures & fpstate->xfeatures;

Let me also test this by running KVM.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1131
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kvm/cpuid.c#n346
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1448
