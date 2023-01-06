Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08F65FE95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjAFKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjAFKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:14:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D79C68C80;
        Fri,  6 Jan 2023 02:14:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z16so856931wrw.1;
        Fri, 06 Jan 2023 02:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7mYIP03w+F2ym4rlVKOB3fADp0pcypDEHQWu+C41v0=;
        b=d7bNkHhLBeuAUO6E2jn3Ja1ZzqIjAmQCiuXDmcLtnUv+3EcQQvTVJKLCht2qMV51vk
         EM4XBNBKMobVt7M13fdIqMcxl4Yv61Bl1tE9wjOwx3zR92eURZyweQ/Nc1e9ITu7zThY
         FntPU/oQDrFBIF268lOz4JnW0+eZ9gHi+sy4ln1w0jOG3UutROSrnd5DXP+euk3eHlra
         pNxvI7CV//zUdM2eQEBtP/SV/gT5bPdnMSj11spnvzmoRn8IHTo9eJFC40HtMwFgne/D
         DKCitKunAWo10BbzZmBp27v3JuIk7iRWju5PhvGfu++i+57lCdMX4XSL+XnkFIzTZPno
         eSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7mYIP03w+F2ym4rlVKOB3fADp0pcypDEHQWu+C41v0=;
        b=BYyBvgiaSNbkeebQzitpMMD8rC7RyU8ZPB6oYQjuWnL05Q28rzY0SprWv2/ZMdwMB5
         4kdp/f4qLJqp5S4GfCKG5mSEPDt7Rc9Zb70QovsmA6d5SPFsECJL1w2p9VJ5f8/trIjr
         VcoOSgPovsST996dxRGjlbg8UCXCrSGWabb5h6zo5F4EYmppYLjASNjbuLSAF/0dzDX+
         BYs32r2sgiSa2CYZ5aCOohV/H/i14c4cRp//TVDYJtRUZyguM87JIZdPU9VmxcyfmkPc
         fo1Yl+++gRjumD8EItBs20n3kHO5W3+BiwQ9koj8JADZqbpjUnfCjtb+KXC+JCWLbvYZ
         kPJg==
X-Gm-Message-State: AFqh2koU1rwok1OzqF9hdeFGWykonITJNFTYG+sckMxo/oTry1h02T6k
        VOKGU59yT2yiTYNBRmRkM2I=
X-Google-Smtp-Source: AMrXdXsSRUapvvCp99lwuaxUfeciu0N2k25Evk47TDaand3MgLRI15JqCWu/tqua6DPhjWpSGqR5eQ==
X-Received: by 2002:adf:fc01:0:b0:297:dd4a:9207 with SMTP id i1-20020adffc01000000b00297dd4a9207mr13724373wrr.10.1673000062773;
        Fri, 06 Jan 2023 02:14:22 -0800 (PST)
Received: from gmail.com ([31.46.243.128])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003d96b8e9bcasm6334403wmq.32.2023.01.06.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:14:21 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 11:14:17 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Message-ID: <Y7f0eRI++oXvWlrM@gmail.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang, Rui <rui.zhang@intel.com> wrote:

> On Thu, 2023-01-05 at 10:55 +0100, Borislav Petkov wrote:
> > On Thu, Jan 05, 2023 at 06:54:31AM +0000, Zhang, Rui wrote:
> > > I thought of this before and got some ideas related.
> > > Say, instead of maintaining the model list in a series of drivers,
> > > can
> > > we have something similar to "cpu_feature" instead?
> > 
> > Yes, you can define a synthetic X86_FEATURE flag and set it for each 
> > CPU model which supports the feature in arch/x86/kernel/cpu/intel.c so 
> > that at least all the model matching gunk is kept where it belongs, in 
> > the CPU init code and the other code simply tests that flag.
> 
> Great, thanks for this info.
> 
> But I still have a question.
>
> Take RAPL feature for example, the feature is not architectural, although 
> 80% of the platforms may follow the same behavior, but there are still 
> cases that behave differently. And so far, there are 8 different 
> behaviors based on different models.
> 
> In this case, can we have several different flags for the RAPL feature 
> and make the RAPL driver probe on different RAPL flags? Or else, a model 
> list is still needed.

Introducing a synthethic CPU flag only makes sense for behavior that is 
near-100% identical among models - ie. if the only thing missing is the 
CPUID enumeration.

If RAPL details are continuously changing among CPU models, with no real 
architected compatibility guarantees, then it probably only makes sense to 
introduce the flag once it's enumerated at the CPUID level as well.

Thanks,

	Ingo
