Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673E70C256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjEVP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjEVP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:27:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83387BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684769263; x=1716305263;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WQef/pm2TPUS4aJmbiKah9CiN9r6Un7OGLujllXU3jE=;
  b=MSG0toz65spASBe0c9qEUbPuNk9X9hZyzNfnWHZOVY5g3FiFbiIqnz4r
   RKZU4KnrRrIWfBa7/055L8hB3C8PC7bjpOIYKUd4AZI+nhIjuhXs1+Pz6
   BvyXlggJy09q64knWXxdhitJWHGuOSWitkf+dBlNLVDFqNCW7UPBrEjPa
   V6O4AyHGmGUOaXeDDSuSK9PBCAUmSwXLTp5cEDhqhfvXPwRYuXZk1HpYg
   Q+8ZGa8H6FdxJOW1IaZc5G4ZJcvIV8DQB69MXi84WjwYC0lrxwhEPq6jk
   1pH1QP8CECCMxCmQ+mDI31zGyLPWpki4hM95ECrKFAGuBUzJIawkfLz/F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381184145"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="381184145"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="827743951"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="827743951"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2023 08:27:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 08:27:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 08:27:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 08:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atNg0/zzT4xAGfvKar4KM8JaQAERZ0qwAqasIHB2hIPsPDE51BG7wmT/md4k3YT0Dlwy2YYvqXINvJFwXZ1pfsEyQIZBk46m3yrKtXLVvLz1ozyUflO6t7gYT9Ncd2ElcbIiAIXSaFgb6jaOB0IbWNZyQkdT7Ma0V6Fu6diJ+14Q0EL7mehjai49KRb9y0zHpNvy4IxKFnhSpAbMUS3FBXeDIva2h4XGEn0fXKdSvopQxvZKhZttK2EdsUUBQyBjqBGVB+7OPVYZ1+5Dix5a7/arXQrE++hN8GyvJoywQuwdLpBt3zbmK8r0cXYT6NnPKS6DOdJ/kyWEzpgtAJGaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgjDuyad1cje9Swnw1pyHCL4tDnxauIEZzW9BU3qQhg=;
 b=Dh9RD6KgS/VMIhAJlrU3Xzyhy5K7pstFnqmc3/Cq07p6day8JY1II9dwRomiFPjz5y8JszXPmbqstr92fyspmM6WnSfVUcbuvXF7zlkf2aRpOxZ/I2fDrmVSfKPLV2PPuG3MpJf0VORQOHJrjlgPTB8HIPKq05Cvu3DVtOHvZ7HdVgXDa0xGvZ88cW7ZnedXPkrUxqx7RkhSK+22Xq55kzZUewjOv0TMRSpArXWIVIlB7KOMzn9zNcEHpYa1FJdh8hIXAF0tU9RdqiephhpWAhKiDFkenqTqQdskFMGqjzwTrX9+lhWRzJoSH/rKEN1y4PxMmYfjhEdMKczihpAAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7043.namprd11.prod.outlook.com (2603:10b6:806:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:27:08 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:27:07 +0000
Date:   Mon, 22 May 2023 23:20:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <paulmck@kernel.org>,
        <rui.zhang@intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bin.gao@intel.com>
Subject: Re: [PATCH RFC] x86/tsc: Make recalibration default on for
 TSC_KNOWN_FREQ cases
Message-ID: <ZGuIL6tyzzZP3kyR@feng-clx>
References: <20230522033018.1276836-1-feng.tang@intel.com>
 <87h6s4ye9b.ffs@tglx>
 <ZGssENXFKmOk/zL7@feng-clx>
 <87zg5wwppa.ffs@tglx>
 <ZGtnUQJy+1Nrazhy@feng-clx>
 <87pm6swi7z.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pm6swi7z.ffs@tglx>
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 47de02f0-a8a9-435c-8c49-08db5ad90114
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38XF+9OBbx/a1dV9NBXPh5pbfba2qvwSHedYiyBFLu/j8iIiJQ5A0E9Tz1Zp7TT4HYdhvpnpUF3ortrfJNJGc1LssFbFk5eoLVFjpWpPhIGgDVuR37iR918epd7oKbUukgK+0srOoETVlYfJg8vR68vxmpDHP7QoxkgcK+AeCnJZfZiKmnf7a9K0WwYjsQ4uRIoBNVJKJjOeWmebAjC09Gwi+T2WKxBTEBxt8yomLtpGqNorLiTh45ESFVGgqKA+PF1PSbc9yqyiyQBYKoIswAw/0MXDpvQjYG5t0pewDdojJckzsUv334ewLFxebryY3vykQOZm5uuQWhe9g3rebUGe8XEIv1aV/2z73Sd+8tMzY/V+fjVR+mYCps/6QT2ZiJg9q24iImJxlMzPbOiQ2K8bR1wdGTTQx1bIQKMZDqxGkqSXEs+e/hwklbxx8A4IMirtl1G6syis9R+XDJxEyymZ2b+DQ6MX84z14nhUSISUTnT7WSmSwVBhLOolIBVmh+RZ7TfvPcvLHMM+x/jEGtBeX2mpu3OvTxaNB2mdCKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(2906002)(107886003)(44832011)(5660300002)(8936002)(8676002)(41300700001)(316002)(478600001)(54906003)(966005)(82960400001)(83380400001)(6666004)(6486002)(38100700002)(33716001)(9686003)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCdIFGir4oSgtsky2dquiMFf+AnR47I96fSwOm8RYj/ypBhsGWdlUUmUINu0?=
 =?us-ascii?Q?CDuq4QYr7NM4imD1PW9oZG30lex5l4P3cGq/wMghQAbkX1Of+ivlmI0CAyo7?=
 =?us-ascii?Q?qITALnvEDZVFLpDVH8BpIiK/FE6sAyLZjOtIxHER7/6cmv9tzmi5Pz/71CNr?=
 =?us-ascii?Q?6oAONiCphYB5edRfrRirJ4OZ6qPTgTbFCFgRXQAKi2rSKIB412VWxyu+8ZR8?=
 =?us-ascii?Q?IU+ULG2JVRnArd0rstfiBe4WyfFWWG2O1vb0NXUT5NWdJYojgypD0VxG8uf9?=
 =?us-ascii?Q?pZmHKbpLZ4Bpqu37p6wH4fij6k2fP0+5zEpS6YnADx5CYJou3wtJeH0ngDfN?=
 =?us-ascii?Q?U3BUkFG/+tiKDa3429/lFlCUj80qfIIThGxRiIfTG8tlx0mvJmhz+hO1LTyT?=
 =?us-ascii?Q?6gqDYcIvEwMkAP+hb5W1Qrnu1Yro48E+24bkI58fmqi3c91plVU7lGKxDZGU?=
 =?us-ascii?Q?BZ/SDIHzyinTphQLBuoU7X2k7YXneeOLGcV+lWH7yxnI4oQOcpSCLw0+NUeT?=
 =?us-ascii?Q?d9n3ogYTI1usvlPrXlnHIoGDaIys/+wKxR0BNX+DOVuzf7VtDTT6NOgYWRN7?=
 =?us-ascii?Q?R+Swu9cI95wicc1FabAalCoZWrVkUC2m2AYLmo2Z4Evk5MkJB7PfVkg+6Sot?=
 =?us-ascii?Q?txzUOBXXTHbxaRvzUeGtCw6H29a1EPL00gn8cuCTQU5W7gvNJASZWmbg7omK?=
 =?us-ascii?Q?20VLYG4Utp3um3JQCmwRE2Z1b6fRof83Qg4L9snL3vNXNOz4F8KDr40z6wj4?=
 =?us-ascii?Q?+o/y9hMGhbYQb1pqcz0KxTvOogL0SEUrzyANc/emrJs+kI6+FKciLtkAiJ/s?=
 =?us-ascii?Q?YP53cMSZ5Fc28WdZ1BnGaOhoxJzHduzEQ8Au1avoPnMqx3/2kF62Gy8CN+9Y?=
 =?us-ascii?Q?WgLW6iC7iAiSMPLc0ptZ4CrDNuLpvkzd8vPURCMYXD90yl2eyRAbfbzut5xR?=
 =?us-ascii?Q?clcGAfUCWRgudz8yKteZxr316vT33uw2RQO5pgr7TiB6xEcq0CTnMqImXnI2?=
 =?us-ascii?Q?+WoTZUQnsjphxPi31DV+5I/KY7Qfnz4i5Ptso5m34j7Y9XOCyPtvfu6ybrA5?=
 =?us-ascii?Q?ICLwixzV0yRGr3jMefsLQg9PZNwz1NtRHDqaZx95OI23jtIWHis2uOxCPaKA?=
 =?us-ascii?Q?Q8OryHKe8/QnmZJ7TU9P1wwHFPjTQ6uG8es34FSKGR+Piu/tef51vFuYuG3M?=
 =?us-ascii?Q?NSS4z4j5mHXPeD2H7gHYYz61jmRdbhpG/DDGi1Ujdjs6GPGmgvsMz6erRtHA?=
 =?us-ascii?Q?hz++2oWhka2qVYfyZduv+IMD3cEcm7bd0s39xBa398FwpfEzTukSKMot2zjL?=
 =?us-ascii?Q?9tMDW8tDygFWXfvvtmlSz8jKN4tE+QEzsUGrGGvkX/8PtgLJV8inHiptuUa0?=
 =?us-ascii?Q?UtnuxPdQuCfI6AQedpJLJjhtc66IaE84V8cAuXLsB0UbQEXulMxfY1cBuy9h?=
 =?us-ascii?Q?t+L786aKj4K5UkMBME1l0IoLm+1RwKZcryQycKwe9Y5mwDZxNwr05ArUpWH1?=
 =?us-ascii?Q?W7pF/fAgcOOmvSx/tTmE6eusnBszEHnNz3Y05aOjUNmFZEmZ0Bui9qExgBRF?=
 =?us-ascii?Q?N/D9tS4Dd0YtGzskK29dDPYId7Q8u3MRldsQor7c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47de02f0-a8a9-435c-8c49-08db5ad90114
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:27:07.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy8zueKwbIhTpqdX7ViEXdLzfIYn/vxiVmON/vc3pWAI0rgGINRZQ5syXd82lPeL4Phrajg3Ph0Ed54+fNA7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:31:28PM +0200, Thomas Gleixner wrote:
> On Mon, May 22 2023 at 21:00, Feng Tang wrote:
> > On Mon, May 22, 2023 at 01:49:53PM +0200, Thomas Gleixner wrote:
> >> > Paul and Rui can provide more info. AFAIK, those problems were raised
> >> > by external customers, so the platform were already shipped from
> >> > Intel. But I'm not sure they are commercial versions or early
> >> > engineering drops. 
> >> 
> >> So its at a company which knows how to update firmware, right?
> >
> > Yes. And the recalibration may help to exposed the bug quickly.
> 
> That should be exposed _before_ crappy firmware is shipped and
> validation can use the command line parameter. I'm tired of this
> constant source of embarrassing stupidity. It's not rocket science to
> catch this before shipping.
> 
> And guess what. Making this easy to recover from is just not making the
> situation any better because firmware people will even care less.

I can't argue with that :)

> >> and five lines further down:
> >> 
> >> 	/*
> >> 	 * For Atom SoCs TSC is the only reliable clocksource.
> >> 	 * Mark TSC reliable so no watchdog on it.
> >> 	 */
> >> 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
> >> 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> >> 
> >> So its reliable and needs recalibration against hardware which does not
> >> exist.
> >
> > I misunderstood it. When you said 'SOCs which lack legacy hardware',
> > I thought you were referring those old Merrifield/Medfield things,
> > which may have no HPET/ACPI PM_Timer but an APB timer, and mainly go
> > through MSR way (tsc_msr.c) for TSC frequency.
> >
> > In this native_calibrate_tsc(), which touches the INTEL_FAM6_ATOM_GOLDMONT
> > and INTEL_FAM6_ATOM_GOLDMONT_D, I dug out one Apollo Lake and one
> > Denverton platform (which comply to those GOLDMNOT model), and they
> > both have 'hpet' and 'acpi_pm' clocksource registered. 
> 
> So that comment is wrong and that commit log is from fantasy land?
> 
>   http://lkml.kernel.org/r/1479241644-234277-4-git-send-email-bin.gao@linux.intel.com
> 
> Clearly the left hand is not knowing what the right hand is doing.

I started working on Atom (Moorestown) in about 2008, and moved to
other platforms before the time of the patch.

And I don't understand the commit log: "On Intel GOLDMONT Atom SoC
TSC is the only reliable clocksource. We mark TSC reliable to avoid
watchdog on it."

Clearly the Denventon I found today has both HPET and ACPI_PM timer:

  [root@dnv0 ~]# grep .  /sys/devices/system/clocksource/clocksource0/*
  /sys/devices/system/clocksource/clocksource0/available_clocksource:tsc hpet acpi_pm
  /sys/devices/system/clocksource/clocksource0/current_clocksource:tsc
  
The lscpu info is:
  
  Architecture:                    x86_64
  CPU op-mode(s):                  32-bit, 64-bit
  Address sizes:                   39 bits physical, 48 bits virtual
  Byte Order:                      Little Endian
  CPU(s):                          12
  On-line CPU(s) list:             0-11
  Vendor ID:                       GenuineIntel
  BIOS Vendor ID:                  Intel(R) Corporation
  Model name:                      Intel(R) Atom(TM) CPU C3850 @ 2.10GHz
  BIOS Model name:                 Intel(R) Atom(TM) CPU C3850 @ 2.10GHz  CPU @ 2.1GHz
  BIOS CPU family:                 43
  CPU family:                      6
  Model:                           95
  Thread(s) per core:              1
  Core(s) per socket:              12
  Socket(s):                       1
  Stepping:                        1

Maybe this cpu model (0x5F) has been used by some type of platforms
which has met the false alarm watchdog issue.

Thanks,
Feng

> Thanks,
> 
>         tglx
