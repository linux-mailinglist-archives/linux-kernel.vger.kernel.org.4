Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4CC656E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiL0T7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0T7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:59:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A870BEA6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672171176; x=1703707176;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P9OAup9Nk4N79eYejsY+gr14Gv51Mur6RbmKGRBrLPM=;
  b=WURsR1w40QqzgkuoKuRWJ4x/Sgj/SAGBiJxaPSCU5GDIGxeP50y0cYW4
   HdeUi0jsP3hUBKFfJ/QVMvazGFqtxbHez5TDqHf1Y58sCa6fRghA1gnMf
   ZIKvTwG8NlTxmE5zh7Y1Vde4gX53VUQhjPbMPMPVE6meVOr7WGn6t/guA
   G2BZx2/i9reGuljK5ahTx+wq9cjntUXwM+kSDwM8awMK45UXl9NNhDgVE
   6f+Q/RQNWjEoCGMDd0KTpXNktfWBD4ZjFgEA+eUKq3V1Qkcces5IVe2fv
   arwwy6uDBJ97I9XiAVOl5zsVApDL0O6dzgu+R2zTI6OlTBi7WpdB5ftRg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="308504026"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="308504026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="683711017"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="683711017"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2022 11:59:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 27 Dec 2022 11:59:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 27 Dec 2022 11:59:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 27 Dec 2022 11:59:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnfM2bYbL47bdkrnhoZvVBu4PHsWefWEfkefhORYCh/8/NRiNZd/DfXzlw+w0exXoz/FmMqCcWn7FNWRk0Hd9opZ31O2wxHy5nac/sCd/icxm3it8fsOToY9QIxC9FsX6+hpYELGr8K4ychT1kANalbLHyB2AZgtFUi06d08TU08K6YtzWxX13RhOJgIVc0RPw1hrnOqB9kxaBVtkdpbKO2kFRMP/NYW8OM43cMRHoJuJ5aHQUbswFyI1enC9Fi9aDqqX5doKZuT3RbiSmu1I+lYWIytzEt3iG8/oOvnKFjPx5DRPt6PjPTkzLtUdonCWq1o0DtRxG0Gc47DqU/KtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIAzgZql+P+8Xk77A7Ua3lMORJQ2TjDMPhTCydKj/3Q=;
 b=FyJjrYd9RvFQVQiqSpD8vdXJlLm9K9vzKUc4MBKwjtiXjB6Q3r91AiUhyN9ttE61MPH68wOpnbB0iGn39vzLnwmpSzMfWSE5+JixlqkOCNJ5prVoayZS+rvZCg75UjC9aFb8yLFYX1FV1uKVt7Vm26l34lOVoxHpAURdlBCzyKOZMF3m3tDypqeOf7qqkyXyX3RQO6yXrZLwV7C9F6DAKSg3PSQ7tAIhCXCBw1S1xpR5UMK9s5baTBdpfgFl28XEijv2D1NUxCU/RsIeFM4VZMuCFy1j4vo37yWD8o0781m7RgZ0x0Yh6XAwxZj1bantwaPAnxktnutLYgixrHsK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5536.namprd11.prod.outlook.com (2603:10b6:5:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 19:59:31 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%7]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 19:59:31 +0000
Date:   Tue, 27 Dec 2022 11:59:28 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 1/6] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y6tOoF8HBOkFR97C@a4bf019067fa.jf.intel.com>
References: <20221227192340.8358-1-ashok.raj@intel.com>
 <20221227192340.8358-2-ashok.raj@intel.com>
 <Y6tMgcU2aGbx/6yt@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y6tMgcU2aGbx/6yt@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e3c73-319b-45b3-901a-08dae844de26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7kWN3raxjEuCCQE1shDlG4ZWvxtaN3l4luEsUZ/jWgH9nlqe3ctiqTk0rHghkc0f8v1Fj2395IuyiDICMhFLkwX+rPCEwv9g3/4zT2RpjlIzyNWNQURRmDS8s5qZ0EIyDSn+lNBvRPXIJeuOW5PEITON1itzoy2X9kUj7N0LaESORCaiOZ2T96sN/h2tUCjPnV00H6Hwf+0/pJXgFuSGdqmySU1wCdpvVvOzBLFyL3rWeJtPgl6PWe+crLuglHpmim5w4wze9FPWu0DuyPj4Y8vVrXptmJucB77wcA1k+OI0iR47G3CnFgllD9BeB764Lhzn3yI6tzfTFjJzwiGIHcrIYl+xvsG4qqoQqb9UzM9c/0RAaXnnwFJuIgdk60uCSv1xaIKzC9Catvgt60qxedUycQX/fD/do6u8YczbyBNr46q0QPu5kWTsKAvB07Onm4u5Zy+5+AVHS/gPTktsfDGmSMTO2H3kEHcgwPMXGZa49B/1XorwARJvRijZDjKyM1MsZEz5I5sXdu87WzLVldx3xehJ1iGCEy6En5ceBrbpkpQqHSdXkjJYMIYfOuFMoEr+cZjH5jzLEU4nbbq0VV6ccqVESEnuAaFGnQ0h91A9RAFi63AX2Jg+YhDrauvKIz8sJt77jW5EbWiF23OULFKXxFiJ71sim5e8GsYhUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(38100700002)(82960400001)(83380400001)(4326008)(86362001)(8676002)(66556008)(6916009)(66476007)(41300700001)(66946007)(316002)(54906003)(2906002)(8936002)(5660300002)(4744005)(186003)(44832011)(26005)(6512007)(966005)(478600001)(6486002)(6666004)(107886003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5xC1LIVa3AC4xvMf9/HCUCYk1g3883mJ0PqkGzlGiWGJvFCQD1saF/nqTyk?=
 =?us-ascii?Q?7FDYRO60johfwNtfL9SZeaiWEc6w1q52IgcbRjDw9wT5u0A2uycaPHZ/SHrs?=
 =?us-ascii?Q?kPezWW3s/azVTCsa5wWnoZVMG1v2EY8cBijdF5FMrnYlbBAi5qVCpwVFTSut?=
 =?us-ascii?Q?7fsB4/8ce36/9FKEn+u1NmYLBHphOQkblBsoJHfS6AL6pCBjnfh+UMCP8Nda?=
 =?us-ascii?Q?RRErrszEwd0xwJLK8gi88jT3YaYJ/rG0XKTuwy7h7vFnpO8Lrpzae2VUP/wq?=
 =?us-ascii?Q?zj7y4qUzI56fCMXbocLfR4A0Z1C7oFfFYkzHUR/wBkGyVnP0YDA1iiPJ3tuY?=
 =?us-ascii?Q?IXyUb947PlI4tEE1PVBYBVEAvj04iKU1/etF3d/Uu5naXhZKkhN9eGE3hRx7?=
 =?us-ascii?Q?7J80yizAXon7bAyXhs8b/jGMHVqux1RejToC4Lyx5PwhvDGrVLwUF7uNUSeS?=
 =?us-ascii?Q?Ry96f0vWg46mBU+968x+sJobs90lMts76yhexDjtaeh6vtq5Qj74hD8zvKY/?=
 =?us-ascii?Q?xy5UOdY/wZonH0oib2X+tzaPX/tqx3YxKtAhcJq4dBqYmFVDWHwCRoa40yCj?=
 =?us-ascii?Q?8FRyAf4aUIKDssLektjMW+GqO4Ig2MWX7SKoG3ySNlpGztu4MxwHupH2CPzh?=
 =?us-ascii?Q?8axMIQDlb2AkXfXA15vKau+mbncrXbouRRzFUuwfKgXWDM1quv14MAOfKXRT?=
 =?us-ascii?Q?mDaVNDAvbmFfXwTFXnDtgeJaL9AB6m44lcxZKuEaF6aPLs9HwZc1LgvlCRtb?=
 =?us-ascii?Q?m0H942ETFSjbhDEsyNFknqT5nS2xANKrhMvh3oVcbjwsbM1kLC1AFV6ahHDo?=
 =?us-ascii?Q?QD8UryKW/jXONgMIxb/rhdyqeBx8Dry+l80htprnBXp1xSz697R2X9J2FFVw?=
 =?us-ascii?Q?0V8KB4ROTNdIghoGoADF8HH/fX5YHOtCK6qhpRBwyiAhHVHKYtd5NOp1iAIW?=
 =?us-ascii?Q?34mTnpv5D9MebixQz5ADE0g+Kpc5t0w9tpSmvAxm6QF6TcABX4d+Cg52/LV3?=
 =?us-ascii?Q?97uA20Abhq0dqm5b4RVUQ6qvSnrkionPyUpcGZumjX8xSIzZIAoFO3P7CMbx?=
 =?us-ascii?Q?tDyq9GZl/jmu59+6cAm+L3w9zxQJqMOubxRC9ggjd7yb4gY0/GtE/jAQUEH8?=
 =?us-ascii?Q?v7o8jnzfCUlgxgxOe/LvJtuzh3x0Hj8xDPjeJA9SawUZWr63yyzwXQjMbsLf?=
 =?us-ascii?Q?wHxL8VdsRbjqEOrQytxOFppVOfrjIp4PYokeyuYeETv8RNhYvC17axgssirQ?=
 =?us-ascii?Q?3LExNH9FTY+gItdFk5XpArcM4n+3tZz+OpwUn5G/BylBXAa7gAZLm6zZiX6Y?=
 =?us-ascii?Q?1PutP+Q8Ns3nsvTgQywnQ5c3tCTUES0V7VscY9APSi9HcizlrDwcggncdaD/?=
 =?us-ascii?Q?c3P5KN6O3s5RLMb80fbttkBIAKKXb74+UzMeT5RrenbgIhz9rBUEV2d+3tDr?=
 =?us-ascii?Q?cgXTXdQqd3t+NCo6WV2wgmutcNnBG4fhgdcEFoXOehix9dkKUMUdaqVjToCf?=
 =?us-ascii?Q?aJ5OrDp/NN/i6w5D1hfdEID0xYOm+dyhETN4pBhGc6LuuEQM0UpSNdB6OMM9?=
 =?us-ascii?Q?SkxmlTbO/LbRfHrWdbrcx6ZxJBefLIAwlbgL5QaBlpBYDiQn0AUnMIHoY/p2?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e3c73-319b-45b3-901a-08dae844de26
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 19:59:31.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5A5/tRDP1WXxb9Xu8cw3cUOnqsiVhANfryt4vsc4tI752zzDMyLSpL1ohz+4QsGv4GdVfV03r3ESeSnhSLSsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5536
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 08:50:25PM +0100, Borislav Petkov wrote:
> On Tue, Dec 27, 2022 at 11:23:35AM -0800, Ashok Raj wrote:
> > microcode_check() is only called from microcode/core.c. Move it and make
> > it static to prepare for upcoming fix for false negative when checking CPU
> > features after a microcode update. Also move get_cpu_cap() to processor.h
> > for general use outside of arch/x86/kernel/cpu/cpu.h
> 
> I thought we agreed not to do this:
> 
> https://lore.kernel.org/r/Y44bbZMMf8I6Lzl/@zn.tnic
> 
> Or was this a misunderstanding?

Bah... you are correct, I should drop this one.

I'll fix it up

Cheers,
Ashok
