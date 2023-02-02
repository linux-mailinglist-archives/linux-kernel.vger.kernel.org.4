Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431C868848D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBBQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBBQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:36:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3F69B0B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675355764; x=1706891764;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v6hjlHPfh6SuUJZY+KWPPFF9zUeNVkeEnLThpvZbkKA=;
  b=XQMdOLUhLnhL5C73oiEh8VLFQRZypaOGuMSvLDHnQ4BaPl0NVEed67fB
   yzmexdRLk5wtXmqwDelJoAqJOAXYunVW8ygC6Vsbzy4XIHGVJHn6kC8Mc
   OwMi+QQKCccAOJIiqhglGzU06umeBYvP6bnUl5uEtgYSVLWWP3aDjQby0
   g53QOprvpp/bye8oUTLFBwYvNdsAz2/hpyPCw++Id5oilcnVlHfNUb4BO
   +ZK3DV6Qrq9hF8rj8ncYHR6TzOZzDZff3snQIoOPtzf7U5dfxRyOkhrEL
   EVI4YQfIgc8ZS0bZzEPpCAQuBxuXdVfleHAv/D5uyvt4bsiYLm/Upo4X2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="390882386"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="390882386"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 08:34:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665358725"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="665358725"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 08:34:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 08:34:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 08:34:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 08:34:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmYvDwBNSO8EAdUZLzTHka8yi7FnuoPZvWTFMsRpDqxMLZjvWLh1tRpigohiSbsHPenxt9RUMXUUxdlRCR1a6WdUUna0XiIpqCPWRmrDs3zHMcisSEiOE1A5E0y/C/2i6JGNw9PbBiOZNil9GqViaocbu8qS8l/HrSj5hFfiXC7iCwbik+kIVx7+SzMDpHFPuFkE1y8SX/QXhdkrtOgVb7g4wXR/WctqRra1VmxN2o+wBRC1ll2Ii+tafM8IAnlanZ/hDozf1q0x7q0JPL1NWGLT7LJvCwwS8xHod/Ieo7abplXXWCms4ncW0NWLy1B+9IS5xDctdjvrnGFU7aIlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9npMCdBCcWiSyOZB4a05CmsIRJaJU5KgGTidBHca9Eo=;
 b=BsiZLf4ZJMHu1hM8lAAbvwPpmUWrzu0jDiAxFdeQCoxnBdM0F0Bin1ojnvVu4u/yypOEd+OSelcGX5LyjsKwmEfx2QZweojlOEs9OarF/nLF0LHQfrwPc+i6/NSGVrrh9LLOfLiFlQ4EJybCU0MhyVujmY5ec0gD01yLoKoEAWqaG/lODxbNeE1/hnbLaNkdNmTFJFuo4Yp7gvsQzm/7btbZJRdVDaKCTQdTH6VLCQngxLRzxbgkBjHu1INhcDJ3gMPgsn0dWRRVwFa5rAxmginulOhpacUjvEv94Jk6n8g0A4bnJEx2UHGQMeEGwb0nhtIEE4j9Vwg3THL/HQph5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH8PR11MB7047.namprd11.prod.outlook.com (2603:10b6:510:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 16:34:55 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 16:34:55 +0000
Date:   Thu, 2 Feb 2023 08:34:20 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 4/9] x86/microcode: Do not call
 apply_microcode() on sibling threads
Message-ID: <Y9vmDOkDthPUx8vp@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-5-ashok.raj@intel.com>
 <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
 <Y9rqeqMjDOYJKmLZ@zn.tnic>
 <Y9skuAuxozZLDrGB@a4bf019067fa.jf.intel.com>
 <Y9uFD1PQoq0Ktaol@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9uFD1PQoq0Ktaol@zn.tnic>
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH8PR11MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 14607505-ce42-4369-bcb7-08db053b6a10
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1cZ3qqd9ZEeD7Qi51qCn8+P74BQAdt+rTtn2lJFMlMlaWS2V9Z6VX1FSfY5V31rIFtd0H7EbMyVSuqaVfoY4liAi9KPJwh2bWLohnUOEP79KhJzoxtsk4Ep0XsyxQTdplIy2m73zHEY3qJkM36OMzsPINKFf7qchZAfF9LLti/YDeLcOgu6SaVU67c5CF+VRUNL5UPhASbssjDh4Wp3xdcg9kAF9nL7gS3uGGLp7qmEgzfg6jD5cO01886C81fSjEwXSjqpJuFQ0O7dGLrHVJ/g/TPOiPqSF9raYQDPwp/arbb9jUH2FhwkotNAS7d6npa2RDCtts4Z6N2QCh2svBzW9RnmRaS9ZCS2ZezuSwg0Vr5ktSHDsE43Vbk8jYEnWZaPUV40C5QTnHLxjSt26ckPQAqyW7w6JI7b124LP5OfA30z85S6slTtUOxqQN12ONv256zfvJfYTGbSEms/HKP/8qoRHjepa1+4DxEQmtHO/Ylo32jJWqJ/v1kDEFL4h0fp5kqgnRlX5UfDGPMgdBzOIZfYxc+zuWpQ+ItTK6atyy/K1TA0DjykzU05iISZESJT+2QZT10/71chO0gaylbPI9ekEUnhvy1Iue6r/QOrUcZKMENeXIV/zqWlD+kc/jISTvhZw1s91/tJ0LzsPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(38100700002)(83380400001)(107886003)(8676002)(54906003)(6666004)(44832011)(6916009)(2906002)(316002)(82960400001)(66899018)(66476007)(6506007)(66946007)(26005)(6512007)(6486002)(478600001)(186003)(41300700001)(66556008)(4326008)(86362001)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4baAlqALFJL8VSBSr11fehWzM4esapMbFAZ86aj+pCb5bK7RPTReL5BSny2?=
 =?us-ascii?Q?nZogZXA4I7aAn7RybLEV+qdJVa3Vvqhn0ZJmWa3SwbxnN8t0Zc/ohhijLXJ7?=
 =?us-ascii?Q?ArUJFWPUWPQrhxXdCHdkHdKKSWOHRJDU1jrAjMyzoGX/ZiWCZXVfOhzEsREH?=
 =?us-ascii?Q?DLyOdamsBWEWN6MkG2iLvJTy8UGFo1bDJ1mdzjvysra9GsNToA8lIlsvXY3d?=
 =?us-ascii?Q?6lC8bDDu7+NGXt3CpbKedO9RBwCWbv345HWX8ObaIHjpm5RsyfE8rznKYAi3?=
 =?us-ascii?Q?6M1yD3zTAFIbfyPeYdhCZsP4TkNHv/jfSnFIKSgyDim/HTQf9Ds0jKSZdHEd?=
 =?us-ascii?Q?TtQRZhmUtfJ/6u+dfT9wk3CoJXEmXVtDEPBRBxAVsWPVf1WfXR/LJTby1VVI?=
 =?us-ascii?Q?hhFZFtoOrXmnFrh6o9Uw9D9u6VFRzH2La1nenk9x2Ch9gJSQ3gF59pfD2eOO?=
 =?us-ascii?Q?wpH3rCzI/9d8qpD8IzRTgbOs4dZ3/ZIhJgy06B5jnuzCyBNRDvD1e6y6sVfC?=
 =?us-ascii?Q?I9o3kyTEzaI6k87SyorhH848vLi0t9BJClvFCGqQ3CzXZ41HDs6+ChVq+5d0?=
 =?us-ascii?Q?grzGuFtgsMvdSn8mCwJretx2y9Vy2wUJYMGLOLS9uWqOkZsd6HHKD43VIJUk?=
 =?us-ascii?Q?vQJbDM3cg0A/pb9bzkxrNmyRtQnCb/2qh9PiCvyLyWBw/kk6QpVpTOvnggHM?=
 =?us-ascii?Q?eAlMcLi3JHL5TeaT7XR/WS1zKkeNPZIBPtTqIBbq+FQgapdQM1MLDLuYoEBN?=
 =?us-ascii?Q?+HwmQrk/V2ZJRVqBkTXv9HYw8TQ+2/NBc4fGFqaRGofFe55w5BaUYIenA0HD?=
 =?us-ascii?Q?/PNBl+Tmx7m9xhcXd5dHrNwxiz2LwVNlOLw5uaMy9Uh/ok5RnUSu6WJlhQ/1?=
 =?us-ascii?Q?15Aeo4jm87bQNP11pI6JW9azxVWtT+0Wz/4/hbVsyzH1KrKOgBGGt3eJ7XF/?=
 =?us-ascii?Q?eEj+p2svShGFYmghezGJXdz9d0iamXmK2d7pp6WagnYliyDn3wqV3ZWrUuy8?=
 =?us-ascii?Q?J0rYgKLcQfP6XNnaB6fUwMXlM7+JVFIq10oM4ZNJ8dORCb6Uxo6LjVWIkAnj?=
 =?us-ascii?Q?b6hSl3Lhmo9MqAalJOFeGQrlI0s99dchedyksa8L8HoqULw4e/llwHr3OLuE?=
 =?us-ascii?Q?An8JohWpAZSm5gTOhdv5dy8IoKmt9peB5Y6Lv+OkwvoFrd2267Cb5vIXXVTI?=
 =?us-ascii?Q?tS0qPAWngBgES3jGiOn5SxNc8s2/QoGel+OMCVfF0NIOxrDnJBoFbMzbkIZ3?=
 =?us-ascii?Q?tK2HB0VTs5Fb5tAnPUIrT6heIjalxymzSAAMo812Ghf005wLk6wDX0mti5om?=
 =?us-ascii?Q?6bjXhWGasHAh6T0t5lhfy6nkwPkRunu4aYHykNkZNaEuaxMeguJaAlCTRPdg?=
 =?us-ascii?Q?oEj1JzNLnnYWbolfmd+ADqXPGtI7NoMBbWxC+OhDbbEA5AJB7582yAz5MbwR?=
 =?us-ascii?Q?UnQSdZGMQKOaF9Rud8TDAF6RTdTQsijezwqOwfbF/4gGZwv5VCJ1DxkGmN3j?=
 =?us-ascii?Q?SrPVK6F4CyhfK5oyy/mfy8l7S+nikesMsjco/1ZFC+Q6TQj/iAxyh9G58KaF?=
 =?us-ascii?Q?/g+Juw6YbFi4Ab0Sh+a3sBRC3JgxQ6zJW+7YuYKpKQBAj3o4QTKYl0uuazw6?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14607505-ce42-4369-bcb7-08db053b6a10
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:34:55.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GktC3imZQrebvRZv7S0k/Hz3xjSzI6xUdsi8WjUxxk4KMeF64NRKk4gcBv0kcpliJRogG2JgJ2fUoQdPfcHYsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7047
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Boris,

On Thu, Feb 02, 2023 at 10:40:31AM +0100, Borislav Petkov wrote:
> On Wed, Feb 01, 2023 at 06:51:44PM -0800, Ashok Raj wrote:
> > T1 shouldn't be sent down the apply_microcode() path, but instead
> > just gather and update the per-cpu info reflecting the current revision.
> 
> As I said previously, it doesn't apply the microcode but simply updates
> the cached info. The assumption was that T0 would not fail.

That is super clear. But the conclusion was, in the case T0 fails there are
some side effect that are hard to manage with the current algorighm.  

That was the motivation for the  change. Sending T1 to just collect and
report the revision, but not via apply_microcode() but via some alternate
function that doesn't have any bad interaction in the possible case if T0
failed.

> 
> > At wait_for_siblings: Each thread can check their rev against the BSP (yes
> > BSP can be removed, but we can elect a core leader) and if they are
> 
> A core leader?
> 
> The one who succeeded in doing the update?

My bad, core leader is the wrong term,  I meant something like how MCE
selects a rendezvous leader today. IRC, what we call as the monarch in
MCE land when it handles broadcast MCE's.

> 
> > different we can either warn/taint or pull the plug and panic.
> 
> What about SMT=off? How are you gonna handle that? Who's the core leader
> there?

This is broken today, IRC, we started to check cpu_present_mask and
cpu_online_mask counts are equal. This change to allow was a late change.

07d981ad4cf1 ("x86/microcode: Allow late microcode loading with SMT disabled")

Since those threads are in mwait(), I'm thinking for correctness we need to
revert that change.

Reverting the patch and borking late-load if ht=off was used, seems the
mitigation to prevent that.

Most BIOS's should have a similar ht_off, and that is the best way to turn
off HT. Its probably better that way to get all execution core resources
reserved for that one active thread.

> 
> What about the other vendor? That hackery of yours needs to be verified
> there too.

You mean updating the revision only outside of the path to
apply_microcode()? 

Its only AMD/Intel today for microcode updates. Yes we should test and
validate if this assumption is correct. But that's the *assumption* today
correct?

> 
> So this whole deal needs to be analyzed properly. What would happen in
> any potential outcome, how should the kernel behave in each case, etc,
> etc.

Complete aggreement. The one case we overlooked in the current algorithm
was "what if any core is in disaggreement with each other"

If there are other cases that come to mind, I can invest in looking into
that.

> 
> In thinking about the minrev, I can just as well imagine that such
> microcode patches which could cause such a failure should be marked and
> not loaded late either. But I'm sure you don't want that.

Once there is minrev enforcement,  default action, this is automatic,
since we refuse to load anything with minrev=0. 

They automatically become eligible for early load only. 

> 
> In any case, without a proper analysis and writeup how that new
> algorithm is going to look like and behave, this is not going anywhere.
> No ad-hoc patches, no let's fix that aspect first.

I'm happy to add more into Documentation/x86/microcode.rst. I can work with
Dave Hansen on closing or enumerating the algorithm and why we made the
choices. 

Cheers,
Ashok
