Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2D63FDEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLBCGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLBCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:06:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492AD4259
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669946767; x=1701482767;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2ZH1VsEQXctyYi2w6zHMkfp7kKsWc+GZ2pEy5zxXWcA=;
  b=R55IT4LTBYRyAq6R1xuWdMT7v9PCh8K5u1kR3UBrhLWKGc7qXJCgLGXC
   m4OFmvxI9DuiH4CR1jC8G0PHvyDUD+HBEBlRNMnz28H/bDMvr8d7f+4X8
   hhli4l9FbkwadTY2ffnO8COnyg+7iUJAj8nvhgWbgeiRduPjc95AAEsq0
   Vmk05/hKuXh+WAXN8LG/lj6U+hsEWida3moCXimW3rVumICupT/AZ2FTr
   RulJ0gDYER0qu7oP6Xyt3JPRTOXL7jcxgxLTO0ZIaqQguqyOCUvWq4Kxi
   HNcxwi39jTSWR+IBE7K0GipYYnlWv8YoeznAe7TZHz4LZD0JLTcruh5P2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315876562"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="315876562"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="646990316"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="646990316"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2022 18:06:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 18:06:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 18:06:05 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 18:06:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRigmK7+bL5sUyqeSF/Umnk1KJT1fn/ZaRtyXp2do4/EFv6GgTJDgQnT5TZAzxfAQ9ChNvKxxit6n6KirsKN+JG4NUy37jP/jHsndnJrUN3ISrx2CUC16X4hkWpD/dB6ZNbaGQSWin6SqmpENextTkKxssEuxLFoyLXYEQCTi5dxqu/8H8eyfshUYa6lDZFHlmxn89eYIV2tb8AeZUIZsU8iBY46IIpHSNBJI7s39MB5S4AjMnsT7GqJSZs9uGLH4iFZunrgftKyto8Pp5RxaTFPVFl2VGF1EnHil3pr48yB+P0nabi48EkSFZezRoCth1yztTov5N2qQ2vGIXZMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnX0AUV/t3tniv1rVD7jqZ9eQ03NR8EPsPZp3DfPn38=;
 b=YbXxyEWGTEFAfS42gkweFz8M640qOT098vByESRnRewI9fC9UBoYr5atTMPF8B9dIigdYPVYgrLa6AkLvEpj34qRpe4sC4xqHJVlqTFKpKJpkFlV/OWDGL0tH4PTolNmUwGVsDfFbPGCZ7owJJbSYH4sX/iJdk5ZrupbyiI4wGejc2n30pfA3y8UTNTKHk+jjZUm61USJW1FsNH0T1KFBpzxbAT2GUl1lYBroY25eJWoNDIQ4QnlAECHXFQEDRXPCIVXko4Rv5Bm0dQrdb53A2UZqI/qotNl2s/ResHm1og9fMqf9rDA1Xl4mRpGsn0DgZP/TD2JU91/ky0bTdIZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 02:06:03 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 02:06:03 +0000
Date:   Fri, 2 Dec 2022 10:02:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <corbet@lwn.net>, <Mark.Rutland@arm.com>, <maz@kernel.org>,
        <kernel-team@meta.com>, <ak@linux.intel.com>,
        <zhengjun.xing@intel.com>, Chris Mason <clm@meta.com>,
        John Stultz <jstultz@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH clocksource 1/3] clocksource: Reject bogus watchdog
 clocksource measurements
Message-ID: <Y4lc04C6KqYUG5lf@feng-clx>
References: <Y4az+FT5YjpAWjZc@feng-clx>
 <20221130041206.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bg1H/HLRLfucNO@feng-clx>
 <20221130051600.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4brjD/xUDlzJ4v7@feng-clx>
 <20221130055024.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4bxZCEAmPnALsRV@feng-clx>
 <20221201172405.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4lQdKaKh2P7eLBG@feng-clx>
 <20221202014428.GN4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221202014428.GN4001@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: ca55d1fc-2442-44cc-8161-08dad409c3a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Amil39j2KzG566ojXwTXSgMKo7ik8eLYx8yTEup4UVkmRhcsX175YpWTOUSf1Gg6Mq1mry/r/CzZMdowsYGDPYrccWX9Y6S+wJ33FziKtIYdapPjnOESZx0LpmSaww4JLnbzHPHzU5ByTcNtSY+/uXwD6v7FlPpStvq4KcqybTZceeX1xFYV+5O1iG+21IWzimdcPJhWnX69/H0CXHsGx+26insFJ0ITByy4aWfReHcYKKoQDPY3eB0/4rmjkI8ZSdVWVoOr/ixlUtHhx+l617psu76ucsw6fpel9qtWQRkXJLRJRtuiLuu6gEeLlhNRKRvlCPo6OeAqGXRfWC3dcX5vBG+a7OiZHers8+71/1D3I0IBew/Msl6s2mqscd2+VekrJGeW98tKRivZIGwGYDt/Ifyh91nyCioLrQc8o0Faa6JEzdCreOKk0K+TWDjRB/RkrsVvvuX10keE63nM59hi04amy8c+zo4pqTWFcxu0dRUsu7m5Ik9yEWV6+6JWwAp+KIXw3QNuyhdqLSptd4v42QVYU4FvgbiXPKAMZ0aYSowtR7jfMoSiQ4TGRvyBTqarYpyt12q94tdPp5mmiu2PmLhenvIQ92Vc1k7rT4Y8XYfMIXTmc0ckPUR4PnNA7IR16iger5VK9PMV5hOxBLUaQDRlOdbGF22wTrSRG34/2Al4yFeta0LnW5U3/ph
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(83380400001)(33716001)(44832011)(86362001)(9686003)(6512007)(6506007)(6486002)(82960400001)(38100700002)(186003)(26005)(7416002)(5660300002)(41300700001)(6666004)(478600001)(66556008)(66476007)(66946007)(4326008)(6916009)(54906003)(8936002)(316002)(8676002)(2906002)(57894002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBDLzNPNlYwTTZZYS9HK0NkZ3pUMnk5Tkg3WDB1SXR4d2lDMFEzcU5mbDR2?=
 =?utf-8?B?NHNHZFh5YXhxMkMzQldkWlV2Q0xEUHRGL1dhOWZEOS9uekpGSEs4aFFhMllv?=
 =?utf-8?B?dFVPYkNWR1gvWTRzdmZBUENlN3Z3V1FBMmFHS3lnMzVlSW10UjlaYW5BV2R6?=
 =?utf-8?B?ejh5a25qODhBUW1lRlRtZ2pFekltUzlkUG1VRkJuSFZDaFozQnJOUUdmdUp1?=
 =?utf-8?B?c2owK2tuYkd1WTBwaGlENmFiMjNITEhqWHYrVmlmdmt0dnA2Wng4dVpPWnN4?=
 =?utf-8?B?UmZCUU0wQ2JYSU9GR1pLT2phc0FMOWhGTTlkQlZnOFlhWDlFVElGK0VRcTE5?=
 =?utf-8?B?WUxINGZsak40NHIrVzJFcVJaWHkrdUFuL0l3OWJVVjFPTHdtVUJ3Q0NpU0hC?=
 =?utf-8?B?d2Q3RUhPNXpSbkIyQ0ExK09SUGNDOXByWG1jQWg1aXFFcGpCa28rWTJ1RjhR?=
 =?utf-8?B?QjZ1Q0V3a0l3Z2RQcktiMUVCTFgyNDN1cDRMR3BLSDYxc1Y1MldkOEJ6a1B0?=
 =?utf-8?B?dFdaSUU4TkRKQmlPZ0x4a1RPZDVQb2ZEYmx2UUVpQ0pJS1U3enFpcVJWYjRD?=
 =?utf-8?B?U0p3dXFrOTdLWlhUUTVPQTAzRGE3STM3Rk45THJWeklJNWhtSmhkZEVJQzc4?=
 =?utf-8?B?ZCtTeGF6UUIyN3M3Vy9LNVpiWE9uQnFRTFlNNmRWRTZ0eURMcHNUSElDNWM2?=
 =?utf-8?B?QTlDMW93bFJ1aEhXblA1YTZ5K2E0RnUvMDNHNUw5TFhXOTk4dWdUWVEvcHFs?=
 =?utf-8?B?NnJnZ0lVQzY4cE9jMFNUaktvdUVlZlpIMEpzZDJ3T3JHbjYwakV5cmNhcmFU?=
 =?utf-8?B?TGFQK1ZjWXYwUEg1aGNvTjZlS0h6VllJMHV0WmVSMG5HUXQvdm9IM1gzWTd6?=
 =?utf-8?B?Q2cxMFhWejh4NlFHV1VzdGNJbWxEcUtwL2tIY0thbHdsWUVSV2hmSnN3em10?=
 =?utf-8?B?emNOTm5Hell6U0VsVjRBNEQ1LzVxK0QzaUNEc2o1UFl5QXN3QzNRVEt1U1BU?=
 =?utf-8?B?d0IrMHNteks3eSsrK1BIcm4wZHZRY2ExUTRCRGVlZUdjWC81clRzT3hWUmFH?=
 =?utf-8?B?ZFpGTnNWYjJQdTQ1aVpNWWhyQjVianl6OGJ4VklnV2lNZ29nSnF6S2hGcW13?=
 =?utf-8?B?TGxrVTA1Z0g1cThmU2NzK2ZuUHJ5ZW5OaXpTNFNrbkZROTdCeGJTMmcxcks3?=
 =?utf-8?B?SERjVGhVOW1uWjdJRUsrTGRjMXJDUkxCMUZWNUR4TFhacTJjRFpYL1IzRzdB?=
 =?utf-8?B?VW5OcDJ2Rk05ZmRRVHFWbnZjSXY0Njd3UGRyemk0dGFqUmF4T0ZUR1RlQmY2?=
 =?utf-8?B?MisreGczczlZZlQxYlpQQlRxdGlHbXRCekNFMjh3eVZyM0pLLzU2WGw0Q2ln?=
 =?utf-8?B?aTJHRUtVbWN2cFpxNHdqbWdQRkIyaFRFRjlPRjhSRXlHS2RMZVd6YzNETFdC?=
 =?utf-8?B?RVg2WnZSWGE3SksyYmhVTk5mVmpRcVd6UTV6RlU4R2c4L01vMUlwYkRReWJn?=
 =?utf-8?B?RG9jWDZsYnJUZEFMM05ZK2RwQU1DQ1UxVkFuYm9GaWphN3p0NlpxUDdMOSts?=
 =?utf-8?B?SjgzSTFUdnZkRW1rMXNiay96S1ZobnNXbVlMU1JDT0ZpMmorb3plamRRUjFp?=
 =?utf-8?B?VDBzUU43WVZ1RmtRQ2pZL3NPdm4yRnpsaU1qeXEwQ2dqSVhoQzFFT1ZFdXZl?=
 =?utf-8?B?dE9tTE1kVCtUcTMzYnRaVnJZSFIyZXgvdHU0TXlKVTV1cXp4dkVXQ0V6SUdt?=
 =?utf-8?B?dzQ5emRCSms0cStheldvYXdrSkZzUFZ2eFBxditSKzI0dzdzdGpOaEp6OUFw?=
 =?utf-8?B?SFBrMFhRdU1wcm5yb2w1bytqNEMwVGJTaE1weno4QjBzMU5wdXRXOElPZVpF?=
 =?utf-8?B?cFA4ZDBOeG5rYUNOR1ZYdWtWQTRMVkpwZnNDRldDaEQ1ZkdBbS9zQWRJMkVB?=
 =?utf-8?B?MCtHamlzMjlPcnpoT1ZaS1VUb3h1ZW9hS2dzRmRsWnUwTWd2MmwyNVpGcThh?=
 =?utf-8?B?S3VKRGlHQ0cvSEE4WCt5c09BSVRBUkdpcHpUaHoxeDJZWk5YdG9Qcml4dVE3?=
 =?utf-8?B?c0tsQVh2UzcvUDl6a0o4R1prRGtKT0pnYXBncEZaTXpGTU1oNWwxcld4OG5h?=
 =?utf-8?Q?LabzGN2AxzohYN8QdvPZMGxxD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca55d1fc-2442-44cc-8161-08dad409c3a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 02:06:03.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfgnPmk4VBmQtbx3ih9kdmApparXSyQTa7Nz8kPn+LswA/PY0iGvVwdWAltQwwVdrDorop1KpKGksVprFBMSjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:44:28PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 02, 2022 at 09:10:12AM +0800, Feng Tang wrote:
> > On Thu, Dec 01, 2022 at 09:24:05AM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 30, 2022 at 02:00:04PM +0800, Feng Tang wrote:
> > > > On Tue, Nov 29, 2022 at 09:50:24PM -0800, Paul E. McKenney wrote:
> > > > [...]
> > > > > >  
> > > > > > Great! As both HPET and PM_TIMER get the same calibration 1975.000 MHz,
> > > > > > and it matches the 40ms drift per second you mentioned earlier, this
> > > > > > seems like the CPUID(0x15) gave the wrong frequence number.
> > > > > > 
> > > > > > Or unlikely, HPET and PM_TIMER are driven by the same circuit source,
> > > > > > which has deviation.
> > > > > > 
> > > > > > Either way, I think the HW/FW could have some problem.
> > > > > 
> > > > > And this time with your printk()s:
> > > > > 
> > > > > [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> > > > > [    0.000000] tsc: Detected 1900.000 MHz processor
> > > > > [    0.000000] tsc: Detected 1896.000 MHz TSC
> > > > > [    5.268858] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> > > > > [   25.706231] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > [   32.223011] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> > > > > [   57.823933] clocksource: Switched to clocksource tsc-early
> > > > > [   58.144840] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> > > > > [   63.613713] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> > > > > [   63.637323] clocksource: Switched to clocksource tsc
> > > > > [   64.673579] tsc: Warning: TSC freq calibrated by CPUID/MSR differs from what is calibrated by HW timer, please check with vendor!!
> > > > > [   64.703719] tsc: Previous calibrated TSC freq:        1896.000 MHz
> > > > > [   64.716816] tsc: TSC freq recalibrated by [PM_TIMER]:         1974.999 MHz
> > > > 
> > > > This confirms the tsc frequency is calculated from CPUID(0x15).
> > > > 
> > > > > What would be good next steps to check up on the hardware and firmware?
> > > > 
> > > > Maybe raise it to vendor? I have no idea how to check thos black boxes :)
> > > 
> > > Done, but no high hopes here.  (What, me cynical?  Better believe it!!!)
> > > 
> > > > > (My next step involves a pillow, but will follow up tomorrow morning
> > > > > Pacific Time.)
> > > >  
> > > > Really thanks for checking this through late night!
> > > 
> > > No problem, and I guess it is instead the day after tomorrow, but
> > > I thought you might be interested in chronyd's opinion:
> > > 
> > > [root@rtptest1029.snc8 ~]# cat /var/lib/chrony/drift
> > >         40001.074911             0.002098
> > > 
> > > In contrast, on my Fedora laptop:
> > > 
> > > $ sudo cat /var/lib/chrony/drift
> > >             2.074313             0.186606
> > > 
> > > I am (perhaps incorrectly) taking this to indicate that TSC is in fact
> > > drifting with respect to standard time.
> >  
> > This info is very useful! It further confirms the CPUID(0x15) gave
> > the wrong frequency info. 
> 
> So the TSC is just doing what it is told.  ;-)
> 
> This indicates a firmware problem?
> 
> > Also I don't think TSC itself is drifting, and the drift some from
> > the wrong match calculation(1896 MHz), if we give it the correct
> > number (likely 1975 MHz here), there shouldn't be big chrony drift
> > like your Fedora laptop.
> 
> Resetting so that the clocksource watchdog once again gets rid of TSC,
> but leaving nohpet:
> 
> [    0.000000] tsc: using CPUID[0x15] crystal_khz= 24000 kHz ebx=158 eax=2
> [    0.000000] tsc: Detected 1900.000 MHz processor
> [    0.000000] tsc: Detected 1896.000 MHz TSC
> [    5.287750] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [   17.963947] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x36a8d32ce31, max_idle_ns: 881590731004 ns
> [   19.996287] clocksource: timekeeping watchdog on CPU3: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> [   20.040287] clocksource:                       'refined-jiffies' wd_nsec: 503923392 wd_now: fffb73f8 wd_last: fffb7200 mask: ffffffff
> [   20.067286] clocksource:                       'tsc-early' cs_nsec: 588021368 cs_now: 581c1eb378 cs_last: 57d9aad9e8 mask: ffffffffffffffff
>  [   20.096286] clocksource:                       No current clocksource.
>  [   20.111286] tsc: Marking TSC unstable due to clocksource watchdog
>  [   24.582541] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
>  [   49.739301] clocksource: Switched to clocksource refined-jiffies
>  [   50.046356] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>  [   50.066475] clocksource: Switched to clocksource acpi_pm
> 
> # cat /var/lib/chrony/drift 
>             1.372570             0.020049
> 
> I interpret this to mean that acpi_pm (and thus from prior observations,
> HPET as well) are counting at the correct rate.

Correct. And this is a good news! that 1975 MHz seems to be the right
number.

Could you try below patch, it should override the CPUID calculation
and forced to use HW timer calibrated number:

---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a78e73da4a74..68a2fea4961d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1417,7 +1417,8 @@ static int __init init_tsc_clocksource(void)
 	 * When TSC frequency is known (retrieved via MSR or CPUID), we skip
 	 * the refined calibration and directly register it as a clocksource.
 	 */
-	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+//	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
+	if (false) {
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
---

And together with b50db7095fe0 "x86/tsc: Disable clocksource watchdog
for TSC on qualified platorms". I assume this will tell TSC to use
1975 MHZ as its frequency.


Thanks,
Feng

