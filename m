Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06B66679B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjALA2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjALA15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:27:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6578A2F799
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673483276; x=1705019276;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Pozu9yndicdqBLJmlcVG3oCSk70a2x10uvd16MJa9no=;
  b=aDyks9fh8xlluwC5Y7vwhjbyotUNUTP6BfHYw58tgK/rNiEo6xZrDENs
   zyrFLXmzpiW1Xv5UbIDZLsnmk1j5044wYkW/A/KjFvxD29FxJcZit6ch4
   U8/KwKLial6fq/HUwJUYlvIMArrkQkn2sgnDZ9xVKv4iSUM+56fOp7wv2
   DtTaYDoWNg2BlWPl6dftIgkVcOO3aV/pnX4TUIioAfbwLt2lsWuve/s4T
   pAl/Q0y3G4kp4CuPIm8KihqKRudacdsgKQGABJJ20jSaq9M3N0e2SB3Cy
   1IXNBi9hbYXfoGXic4TGTe3JcB6jp1TlyPDAQS7PgzPYcOe1qOMV+P0nQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303949616"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303949616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 16:27:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781574180"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="781574180"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 16:27:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 16:27:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 16:27:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 16:27:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8YD74/EQ/akDpIpLxCB+HiHVH62QZ2kXRvUf5B8e6XPyLawpDDksZ50CVSQXgRixk7Btn5Cy00+77iYbrKSCjOIqpo6YiObJb3AWFTVhn1z4K03e+EWmwwR6wD8+lpGT5pM6v14Fkec6L5nWSwZznLUCbyQGuvsa4y3JZwo5nNbIeVjY7N75dP/50XYD/+MhelDLsjFRGXo9a/QLX3yQLHAmrQSITVEyHZpsV5hZn7AjfTREWISF8GyRxbz7uNom/VG1twp7+DZD/wahuSBoZ6aTF/ayJ1zHXRs+kObaSw3Rr8v8A8CuvX1kfIXUisNmt8meXffVVafRwTsazEj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf4JY5TtDiTcMVPDOXZj7tCXrs01A5iaGtkt6u+bkG4=;
 b=JWnlhQHoxR4Yn9RTIiescyg/2hdm5NfelI2o750v9gdNX4oZtM/V3du4sQ7ZbZ/Q1izj8IgkA44bI6AYCVtm0kOfPviDo08Kd93YHK2aruFJt3a+AOIZEX6j9FYwUHWrxxig7pQFdtoIXmsbspx0/Swm1M3ctxe8R9ZlTCTAFLx4aNqviMrfB8tMdOlSxJdaKoveUaXKpHW5EUjzrNGhPW1EOxMUD8zjxOC19AkLFnmYb9R32nnQ9vpIVWKhlRao0DrBMa6NMiCRusSOZBjjGj/724181C2NDObhXQz5MO6UKIT9qanfViAFttwoUdTaQVDKJ5Ea7A1ufUB5dL254g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by BN9PR11MB5500.namprd11.prod.outlook.com (2603:10b6:408:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 00:27:52 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:27:52 +0000
Message-ID: <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
Date:   Wed, 11 Jan 2023 16:27:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|BN9PR11MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: ba566e63-2689-4852-2101-08daf433d76d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euFggibwm3KQrcmF1CEC5ZBWNOV95bLSl7xA0dg6Hffgc96vX5+2nFO0ra8xeHp2CZTOyx47RpRXi23D0nEtJrDcGLX1XoqBjHG/LeF0wkTxOrOdt5QPAlAWZ5lqTuUh/zWzeyKgTbWn/NVhBh97C322XCdmVHfd35ZTrbreHVbPs2LYYLclmIeJb/IyBwmHQ3NzKAubipcF+BM3Uq3Nb3mJ7VZf3xQ5RjbkUWctXpTpqJDJIDTs0QSreYsl93xSMnFIbfSbVYD88nFmfoRucSlNSNLjlL8AKTjwcALlpTz6sOMX7VRKDzFxP4jZU2ulocfV5LUJQVSPOLOyixAKg4lsBrzl2QFMZ7zhMoy7sGbpcsy85hoCcqyOE+hf6UTEM7TgWvefhVUADbq+9cH7BETuc3nXJB02E5lkSvCEx/fnAhUSOneF7fIN9QZT4RomKbBMGSSSQlMSWTRX89JMpfzY6Dy+suI5LXD73WYAdKby7K4QDfeKh9a40b51s2E4g6D+GEveERnUWB4wE3dHOUX7Cn8xg6+r1enwNSLlKqYaeCoFCtePg30GM/bxiKgqhDMbuKVazsU7N2SfJLJXjX2I+3oNx9otOxJ62Mtgf4ZhuBvtXpek0o4NHilKCtoXxOStL0WqQtvBWtjd6VNtW96g8M3hEgV7uFVPLgTJT+rwupsNpUHqU7no4mKYuYjC1Nbu/BND0uXgD5xG7suz3UrlQL3hZ+AJl9MIOTUMquM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(8676002)(186003)(316002)(26005)(5660300002)(6512007)(86362001)(6486002)(478600001)(2616005)(31696002)(41300700001)(66556008)(110136005)(66476007)(66946007)(6636002)(36756003)(8936002)(83380400001)(31686004)(6666004)(6506007)(82960400001)(38100700002)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJvLzA3QXpjd3d1UytEMEJxaUpmeXE4NjVDK3lva001V3lDQ2l6bUVwWktj?=
 =?utf-8?B?c3V3aFMvUUJGTW1TdWlzYXBjSWFpWlRSZncxcTA0T1M1dm53aTQwTm5QeGNi?=
 =?utf-8?B?eDNIdXRpV0paVTgzQUxuQzBHU0tKbHYzVDdNWCtTLzluL0FDZmt4allSNndQ?=
 =?utf-8?B?ejJyOG9tSHVXVm1ERFhLMGNwZkJ0dndMOU90TXI2dXpRdWdORGh5MHBtdnQw?=
 =?utf-8?B?Q0MxQkVqRzFDbStLbnJkYjVSeHRrQzZJWmZWYjhRRWFOUVhDYktjb1lwKzBz?=
 =?utf-8?B?UFJIV3hTL0RxcHcwUFlyTXdyOHQwZkUwd0lTeXBFOTlGNkx0cVhnaU5ORnBs?=
 =?utf-8?B?SVZkNWVZZTh6YUxxYTZ1WktxaTI4bXh4NGM3ekNYbm1KT3ZCN05RV2xPeWYv?=
 =?utf-8?B?bGhQcGlvbmZGODZ6eGdKSDFSeGVhVU9UdStFaE9QY2pnVituQ1MzZDZVUk5T?=
 =?utf-8?B?TDE2ZDRjWVFXVG1SVUEvc1lsSmNNZzFpVkJ0aXNCRDVyMWpsaWJEY0lGTkRo?=
 =?utf-8?B?M2E4c3dVQklNRnZCWDNjdndZUGR5d1ZCaFRVRFBBOHdOWnRGRUk5Misza0ht?=
 =?utf-8?B?d1VxQ2lUOHVkSHRwUDFHbVlVRHZWNEdVS2xTaHRHQ3dVbXpYMXkxeWlxNXRK?=
 =?utf-8?B?L1lnM21EUjg2RjlINVNFNnM1M2UrZnFTczFLSk9nU0ZmSm45RkFnYkpsQjMx?=
 =?utf-8?B?QWlCY3NiZng2ZHBGS2ZMYk55OGNlK05DR3dSZU1hVlRwZGp4Nk5aSEZVWkNY?=
 =?utf-8?B?R0ZiNmdzaEczOWw5dnJ3a3dhOVpPK3dPaHcwY0xOQUNBNWhGamhtMUFSb2p1?=
 =?utf-8?B?Y2tXMlFXRFBYVk5JNURDZzd4RXlNbHpIM0NMd2swTkpPM21uNzkzWmF1V2I0?=
 =?utf-8?B?VllRNGRHWFNRM2IzQmwvQkt1UTE2RG83NkZPNG9FTnJzTERkZUFzTHZGWTZX?=
 =?utf-8?B?TVBpWlhJZk10ay9BR3E2QnlSc283Rk9TaTRtSENDY0VOZUwvaTE4TmxQQlBx?=
 =?utf-8?B?ZURCYWhSVUpqL3ZUM09pUkRMU2NidnRlNlE3Q21PTnNOUFFxRlhNQzlsMTc3?=
 =?utf-8?B?ZW42elpPN2VsbSs1ckdzMlRMOWs2WnR2UTZFazRWWXVMdlFGVEtkMXczSHFQ?=
 =?utf-8?B?Zkg2Y1ZtckJ1STZvdUpHMFR5S2JBOG1VZlE3UDExRUFoc0JDYnlUbG95Z0dq?=
 =?utf-8?B?RUtxTUZEblNKOG5EZGJqc0JERVk1WXZINzg0aE9RZjJmTHpMZ0VWN2ZMbmpo?=
 =?utf-8?B?OHdaOWRYL3pPRFprU2hFNlZqZUtVR2hOK3FHRThNVEZVQjJIdVJsTTgyMDR5?=
 =?utf-8?B?UitpcU5DTkQ3YXlNeXZQUHV3clJYUW45dzd3bXZjSXVXYjFyTG1qS1BaQzJD?=
 =?utf-8?B?RkU3L1hUUFE2bElVM3RjWUZJS0dlZ0d4RG1vZHpnV0FFeGljcWF2Vld5ekM5?=
 =?utf-8?B?amd6ekoxc2lYd2U0OW1XcHl3ZDJrNmpLY21paWNWV3RlMGRhZ09SQ3Z4RWRJ?=
 =?utf-8?B?OHA3UXB2ZlJINDNlNHNZNmJDVldFcFROSWhMcERhWlVlMWU0NlpJOHZMdlNX?=
 =?utf-8?B?YWluNWhwN2VJeGpsSUFiSzlhdHNVWjNQK1NaQVhVQVkyWUJhVzdscC9ESDg1?=
 =?utf-8?B?M3ZscWhnRUtkb3dsbUlJYXc2dXlTM3NSQW53Tm9LNHovcElTT3duMllwbGk5?=
 =?utf-8?B?WnlGQ3Zpa0FWaWtDMFg1U2t5aHMyZVQ1R3h3YVNCVmFCaUZRdWdMOHd1U1dR?=
 =?utf-8?B?MGFIdnZraVViVnM5dU1jL1AxVk1reTdaK2VvZW02Uy8xL2FBYWhZUTVCWjZP?=
 =?utf-8?B?U3NYTW52SExOYmlkUzlHaklYQjNCeVFQTUsyVEoyK3c2d2JsWSsrK1M4aEVY?=
 =?utf-8?B?SkJqYnZQanRDby9uTUVKS2VKMnZmY1NIM2UxT2dwTzZjVWt5bGYxSWlRZEZ3?=
 =?utf-8?B?bGx2dldZS2N2VG0vV2xVdGdPK2pJWkx4VGd0VU9WVEp2M1FhMzRtdDA3Y0hN?=
 =?utf-8?B?M1MyWG5hVHArclB5aXBsSWszM3pmKy9MR09CMUhWWXlXdWhGcEhnV2ZSR1ND?=
 =?utf-8?B?dVhSVmtGd2dMblR2V3lUcUVZK21kbjhVL1hqeFRPSkJTWFUralYwbStkbHhu?=
 =?utf-8?Q?2dhypuiRwdvVZzrsGEEtTTFsP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba566e63-2689-4852-2101-08daf433d76d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 00:27:52.2671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYXoIuco6WaHK+jpuBPrBtYuubr8KSqLRGCVy/Y2al2s6DfwMTxI1/0cSlj2JoJAk9egcduMNzIdXJ1xe5s9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5500
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 2:41 PM, Sohil Mehta wrote:
> On 1/9/2023 9:52 PM, Yian Chen wrote:
> 
>> LASS stops access to a lower half address in kernel,
>> and this can be deactivated if AC bit in EFLAGS
>> register is set. Hence use stac and clac instructions
>> around access to the address to avoid triggering a
>> LASS #GP fault.
>>
> 
> It seems we are implicitly relying on the on stac() and clac() calls 
> that are added for SMAP. Have you tried running with SMAP disabled  i.e 
> "clearcpuid=smap"?
>
Yes, I tested with clearcpuid=smap.

> I believe there needs to be a dependency between LASS and SMAP.
> 
Yes, In kernel mode, LASS depends on SMAP to work. And in user mode, it 
doesn't, so the dependency description in following may miss user space 
effect.

> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c 
> b/arch/x86/kernel/cpu/cpuid-deps.c
> index d95221117129..00bc7e4a65d2 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -79,6 +79,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>       { X86_FEATURE_XFD,            X86_FEATURE_XSAVES    },
>       { X86_FEATURE_XFD,            X86_FEATURE_XGETBV1   },
>       { X86_FEATURE_AMX_TILE,            X86_FEATURE_XFD       },
> +    { X86_FEATURE_LASS,            X86_FEATURE_SMAP      },
>       {}
>   };

Thanks,
Yian
