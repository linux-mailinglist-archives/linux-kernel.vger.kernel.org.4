Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221566E7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjAQUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjAQUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:15:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA30F769
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673982676; x=1705518676;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0zv+PMlUX/sycUvCFaiz0H4Koa6iaJnycl5cieNYbx0=;
  b=BAxEKgqg6g61cRFD/TURI9WULkXRwFmgKkOddG2yh7uF1mcdI6HFxHaL
   7+7S7Meq3C+OHePdz22PQoI/t0GyOmMzFzjv4briupvZY2M0VbcnzDmq4
   Zu4C4ZNrqnIHwlBjqjlOVmvTh9ZqoxwExoTL038K9L9DgLTmz+fi0UbSg
   bWRb6xGl+7rS8OvpN8T/ppf1wX72Tjl85tCRo8+XwtVlTYqikgAHI3nX3
   eA4n5fJ3sdB9NSU3zsUaaoRZ8x2Wx/gBi2tmMo0/zmoJ4L88zhndAwvxt
   eLhzFEeH4M3nAE1T9heGF6tr8tCP6A1Q9cDv40t4Z9MCGg98zq4aBVhe0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326064666"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326064666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 11:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="609346963"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="609346963"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2023 11:11:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 11:11:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 11:11:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 11:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUNskAa4Od18PJ7d4G8ZM7G7NzU+CzgmN+cB/47ao+yNKlrI2P28TstFhWHACkNauR8pYudL+O/vKLEuXZc6ADxG+MIk3Lu14BkeOpZjpIu/py2A3POAU7mFD/F6xaz8+VMFYNNuWk+uNkD7TPQ+9r8tlo7MX3TKx3BVU2vs22ebG+n3wFT2DUd8iiPuF9I9UwMH6DnNN+Rpvhk5jg017ioKpvyGCbZNeHca9yY7G+k3JcpdPOsggxP8EMAhkqoS0kwiErEoI36LkQl1jTtW0uw5Of6mQNr2Kh9GbVqPVR3AQsXOtZaE8cganz7HR41uvRrBGIyOD9m4oevkAM2Aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1vNkNLOaBovuN+GH+06HEk6m3k3ZpDQxAJpQl15drQ=;
 b=a73DiHqdZ5JmL2fG0MFngPqtAN20kNypKN5wd5Zp4kYZIA9ddiavpFXJa/7UemX5Y2e13jPXxH7bHZ5G3IFYd6BTq82xFMnUYSvmO38oe+wFr7QxOQ1wXPYZzM11+wceBunvRYV1Cc7/B9krZ7L/LEUIOK52z8lEPJy9XLnOOYDj/dFQN/Eid/apgwG/TSUcnYRNnkP9gSA83hxsO1KRGSUlOnNLU0A3osZPyYociwE4QGtQTd7XeXSt2nl/M0+EdpgxCucZA27kgQQCMj+3E3fHGmk9mgRq/UiJEXksD+Zgkn24AO5EGk458Rz45GIhaAmNTEWdZPy3TcLBmZed/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) by
 LV2PR11MB6047.namprd11.prod.outlook.com (2603:10b6:408:179::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 19:11:01 +0000
Received: from DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775]) by DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775%9]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 19:11:01 +0000
Date:   Tue, 17 Jan 2023 11:10:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8byvq/cAbSltKbx@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To DS7PR11MB6198.namprd11.prod.outlook.com
 (2603:10b6:8:9a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6198:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be74c9e-3ebf-4a0b-cb27-08daf8be926e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3x+XsIimYxEOiQuizL710WB8qjApKAJsztMuL28GP4YGdbE8CPt6rf9CQJhI6dX/y7aWlc3KLp420hRW+ra4DT3ebOPWh7Ptg94dGydabqggODctjjmEu6n9hduwSATjdcUexSu+Cz6V/WH2lvYre43KMbxZQekbPJ9TosRYrwZVJfa8wKLLv53M0rkqwWah7UuIirX/LmVkem+v+p7kkLtIz9f8Jj8fjvtQgO0KXwx8lupRBNzRnjBG95MDMEzlmU91NkZHPF7Bt/1AqeeOaigFrPOs5Btr/WtyN6Cqy9D/P4RYkqSegAFVCpxVlJK/HOXV3YPvwtE1666h+rRy6GZ7v2hdCvYBVolOQ08AVizGDgsedfBfEgI5kgCm/I4u/KSe6c83jN314dhT76J0pRXwRI2tmK15q2opqnBSJ5EQt9Quy3tv33PjqXFtqukPbi3fboy1Zri4so+y+v4ROA9OBKaKbzFDnGRf87WKHFmrcBNdWQOCXArIl4SIwdWQqumOWw5Hk9FC74kmOYdSZogULwPFpyTjwmzfaVlX8T4HZ28EyFXwqzXnA4Q1MlVOXRKXlzx1U3MO2Hkce9iYB83b1vOd7eaISX4Wdu+PCbjqyVsazY2oEl8wVnrnOmCQiRMgcoyc0S7s3gyXzGQSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(83380400001)(82960400001)(86362001)(38100700002)(4326008)(2906002)(8676002)(5660300002)(6862004)(8936002)(44832011)(66946007)(66556008)(66476007)(41300700001)(26005)(186003)(6506007)(6512007)(53546011)(107886003)(6636002)(6486002)(54906003)(316002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtuvaW2u18apkEXlVMw3wiUB4+H0J5m7DyuD6UvoJww0aW6IKaQeHQXkKied?=
 =?us-ascii?Q?MdRAgmi4HuLBTZuyu1tl7NL007JuP+vHfG4g3v/1VS33DmtIlGBio6yrOixq?=
 =?us-ascii?Q?0R6iY9unKGDp61IBjwuPxseZierVOCYjlO7JEYS165ID43ZyzUDK8NJIL5Zr?=
 =?us-ascii?Q?QoKGh2PHfZxPBPgLJoya5kiPrkdJwJAhhO9X8bGzxOGgIaZ46J/sx9ZpaEF7?=
 =?us-ascii?Q?ViQHupVItQ9ZSZrR3ky3ObHOhqXUyPA/36m28YLhNtbSvucuU8PCIlWfVhcX?=
 =?us-ascii?Q?86O81HgLZ9q4pXoRQGnkwKhgzcK2AgIurlnQmnCFOS0UXk9kjIG1gu4Ncawy?=
 =?us-ascii?Q?iyJN8SWoXuOmszCqTsSF0wnvRUhvsA/yzJFtP477tAaA0B28aebuZhghqpKH?=
 =?us-ascii?Q?0uSHq3aDiIeY/khx3jQSbmiXMQwmGJATSdvVScCuY/wjXS1arD6XHV3z5894?=
 =?us-ascii?Q?3tLskeuf66U4Wpqd7Q/+HsgbN4jkxDCaSsyNi5A+ZjCDF1rY+Bog37A8GFwH?=
 =?us-ascii?Q?AiNQjZecHa3sZ/O85v1QcvQMyY1nnDt9Q0WpyIcG8NNdtY0XdWMQuTFktEdt?=
 =?us-ascii?Q?13Xk/5Cf3kibhDMoDzBGWAk4AgelNmAei+UtXvD3Ux+RXOdXrJIY7n1ZO2Vl?=
 =?us-ascii?Q?Nw2ow3tQ6xwDf1GoEhefRjnnDWd3urb4wpqfof9tNG4ClFqm/trBMyRssgaf?=
 =?us-ascii?Q?8Wenq/HowPQAUNJ/KMgd5sPz+R2B6GqQmcwUbJgbzykE9msXaxGlF83o8mud?=
 =?us-ascii?Q?m2NB6WvlhKzqdqy/2s5Qd5R9aOWj59VAWnZq09jLX7fkSbkNFq2kjVUDhYSv?=
 =?us-ascii?Q?HX7m17EaglvaDeIzuEi/k4CdXWdCN2DqqNDceynkvlYaVssTzmEWrX/xXKWh?=
 =?us-ascii?Q?1GZDRDBmeFRHs+JjS7RyhTZZPqgl4iz2L3m7PajpGTqOmlFzz6nrFC1xVIqW?=
 =?us-ascii?Q?AobVWR+AN9u5QAJuUptMMUGrC+OPcHu7bnbVzkvN248XbAKixNgD9Gv+x2fn?=
 =?us-ascii?Q?bESOfy1wvqn9H+x+DSK1OOLpnMiDh4o0DGVn7z2/RRMiRrACBTChWb5V0vpr?=
 =?us-ascii?Q?OKvMfX8JA6XPPVCs/hQ0EmqmGqNEztYSsiW3Oa0zvjGjyQ3II22HJatgTGZh?=
 =?us-ascii?Q?VvbnLGhZ9rfhiNWwANdMdtYNS5QAHkNqH9fvZS4clGMNWiAbZaEd4FvO7liT?=
 =?us-ascii?Q?KB+ti1f15oSNgNEsBuYVMwai0mdioViTrQ2awDCUhNYba/ZHKIhR8bmzx288?=
 =?us-ascii?Q?wE4aG1mJO6/KjOcEfV+1ZOP5/MiHrGzWY093ocv3e+oXqy3Hc+LhWT7Afv0I?=
 =?us-ascii?Q?hLIq8GN2aqRQpqdVn0QnELh7TN1BqUFLY8U2QpdBGLHpTYNNUZ+rgVxR5TK1?=
 =?us-ascii?Q?X1tb2wVLubQqR2Pae+vGPetqhcV1P1Mv3pApyoFXl1aPscJCv700ahzr0+oQ?=
 =?us-ascii?Q?M2LpmBUVg053vHm4qPR7UV37lRBTXehXcFaSC83mnN9jB3dRjFvhUMYzGq+o?=
 =?us-ascii?Q?Xmv4pOZAusP3U6ER37C9MShvK00Kh+zs3OMNMC0dx4KWpGnqGPZeu9TEHySD?=
 =?us-ascii?Q?9o+xSuqBUgWcgc++WZQipFdqjzU7O9uSJjq3nca6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be74c9e-3ebf-4a0b-cb27-08daf8be926e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 19:11:01.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMz6WVQqTr5QmH71RkLREFUVF9mdiGtyrWuuZObiexwa37zvU5hMukGNoO5RWwbwpTvRCAUEcvVRrWTNLd/gWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
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

On Tue, Jan 17, 2023 at 10:32:50AM -0800, Dave Hansen wrote:
> On 1/17/23 10:21, Borislav Petkov wrote:
> > On Tue, Jan 17, 2023 at 08:29:28AM -0800, Dave Hansen wrote:
> >> This ensures that a message of some kind is printed on all early loads:
> >> successes *and* failures.  This should make it easier for our hapless
> >> users to figure out when a failure occurred.
> > I'm still not convinced. When something doesn't happen in the kernel, we don't
> > always say "It didn't happen". We don't say anything.
> 
> Well, we have an awful lot of pr_warn()'s in the kernel that talk about
> something that was tried and failed.
> 
> > So I don't like all those talkative drivers for no good reason. If there wasn't
> > an update message, then no update happened. That's it.
> 
> I actually kinda like the inverse.
> 
> The common (boring) case where an update was needed and was successful.
> It's the one we don't need to tell users about at all.  It barely

I think its useful to know what microcode was loaded at FIT from BIOS and
what its updated to from initrd. We have been telling about successful
updates, no good reason to nuke that. 

We added successful and failures on late-loads, so its better to be
consistent for both early and late.


> deserves a message.  Users expect that if there's an early update
> available, it'll get attempted, it will be successful and the kernel
> won't say much.
> 
> The time we need to spam dmesg is when something upends user
> expectations and they might need to go do something.  An early loading
> failure is exactly the place where they want to know.  They want to know
> if they're running with known CPU bugs that would have been fixed by the
> early update, or if they somehow have a botched early loading image.
> 
> So, if I had to pick either:
> 
>  * Print on failure
> or
>  * Print on success
> 
> I'd pick failure.  But, considering that we're already printing on
> success, I'm OK doing both.

That sounds good, lets do on both.
