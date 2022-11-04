Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7414A6196BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKDNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:00:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E0252BF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NZcAnqvDjSNkq2gCiAOT480bUX9fIe4Gq8EsgSqTn1s=; b=TQQdin8PPtPt5FHlN0+RzjwONL
        9NsCTgPD2cGlvHptFNU4iSHzqrADXyBJ3KrC6DK1Q8sULNREMSuVmt5dKVs7GltKH2u/eISEvFsLd
        PJQDk9WJN7e7GuMz8JK3EIeciL7dnk6gKYOSDX4vDeYo600wTXYxVVP28ain6CeA0sOCGZzJQVWWl
        RCjn7I/CPWAy8Rr11oMbViG1FnhOlF1vSSGeTmsKwdfnQq20xoKM5U0HM5cZ9fWt2XjdbnuJoMIq1
        qQ/89tusedFCCvwEmUJYLb1oZP2yCUKGWtUcZBIeHRl2OXGLb2BNkzS5rmgBowfblbrt8HvS1PMzq
        EotR/0xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqwIh-008ya5-4g; Fri, 04 Nov 2022 12:59:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBE9C300137;
        Fri,  4 Nov 2022 13:59:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EF58201E232E; Fri,  4 Nov 2022 13:59:57 +0100 (CET)
Date:   Fri, 4 Nov 2022 13:59:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [tip:perf/core 1/2] kernel/events/core.c:181:48: error:
 redefinition of 'cpu_context' as different kind of symbol
Message-ID: <Y2UMzdf9EDN1z5Ym@hirez.programming.kicks-ass.net>
References: <202210272227.jWuKg5y6-lkp@intel.com>
 <Y1q8DcG09Z0PYXEf@hirez.programming.kicks-ass.net>
 <cafa4dbc-0801-9675-a508-6c6c1073cc5d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafa4dbc-0801-9675-a508-6c6c1073cc5d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 02:08:48PM +0800, Chen, Rong A wrote:
> 
> 
> On 10/28/2022 1:12 AM, Peter Zijlstra wrote:
> > On Thu, Oct 27, 2022 at 10:03:53PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> > > head:   dc39beffcfc19a8dd2a09c5818dcd1a4e9099033
> > > commit: 983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c [1/2] perf: Rewrite core context handling
> > > config: mips-randconfig-r024-20221026
> > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install mips cross compiling tool for clang build
> > >          # apt-get install binutils-mips64el-linux-gnuabi64
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c
> > >          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > >          git fetch --no-tags tip perf/core
> > >          git checkout 983bd8543b5ab8e9a2870ae258bccd4ce7a22c7c
> > >          # save the config file
> > >          mkdir build_dir && cp config build_dir/.config
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > kernel/events/core.c:181:48: error: redefinition of 'cpu_context' as different kind of symbol
> > >     static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
> > >                                                    ^
> > >     arch/mips/include/asm/mmu_context.h:106:19: note: previous definition is here
> > >     static inline u64 cpu_context(unsigned int cpu, const struct mm_struct *mm)
> > 
> > *sigh*.. robot people.. this patch has sat in my queue.git for weeks now
> > :/
> 
> Hi Peter,
> 
> Sorry about that, I checked the internal reports, the error was first
> found on Oct 14, but it's blocked due to commit id changed in the same
> branch, we'll enhance the check logic to avoid blocking such cases.

Ah, since I maintain my patches in quilt series and I re-generate my git
trees from that, I very frequently force-push stuff -- even when nothing
changes for a particular tree.

Basically my script wipes the entire git repository, takes a new tip
clone and applies my quilt series to appropriate branchs and pushes the
whole thing out.

So yeah, please don't let that block reports.
