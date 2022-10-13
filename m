Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D768F5FDC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJMOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJMOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:10:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF830F66
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KEwtTNoIToUdUfF6/oXUiGd+VnSke3sdM9NHlpv8Zow=; b=YKpW+ja9mkN22VZm65mZ6s4qmz
        gxBdAELTMQks/xPhRqSnEuYT83NreEA8gcpwCjfPZWXe3PeXpONB+XlUsxDCjGlfVKnMAWTMTfTxB
        SvcJHqKIcDsS8gqLg7chsV0QX9PZYafuEJ5wZm++q+232kTfBxcpuKvRXTRWyUJqnh4UCmEvmMhqF
        mYJ29ExOYLJCYE/UNV5U0gYoOTYsDtdehr6PInS69njMNS359ThonffNIxhjiShG+l0CVsYYmp21k
        Q80N60B3e3yfxrBTXk0Hqxl2VsM9IL5ZdDoR9XVeFhA0bALRnv7gnMIIkls2QZ7E84gmLx4gCAoaa
        1cl2F3rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiyuI-006lXQ-V0; Thu, 13 Oct 2022 14:09:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 050863000E3;
        Thu, 13 Oct 2022 16:09:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D94A429DE0740; Thu, 13 Oct 2022 16:09:49 +0200 (CEST)
Date:   Thu, 13 Oct 2022 16:09:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [peterz-queue:perf/core 5/6]
 arch/s390/kernel/perf_pai_ext.c:533:25: error: initialization of 'void
 (*)(struct perf_event_pmu_context *, bool)' {aka 'void (*)(struct
 perf_event_pmu_context *, _Bool)'} from incompatible pointer type 'void
 (*)(struct perf_event_context *, bool)' {aka '...
Message-ID: <Y0gcLRmJ4n5hUZW6@hirez.programming.kicks-ass.net>
References: <202210132113.0weoXZP0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210132113.0weoXZP0-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:49:06PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> head:   a7560340a5a83514ad5117aec2c770956e1813f3
> commit: aab8cdf010eb30b0214da37cb770b4f965637a97 [5/6] perf: Rewrite core context handling
> config: s390-allmodconfig
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=aab8cdf010eb30b0214da37cb770b4f965637a97
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue perf/core
>         git checkout aab8cdf010eb30b0214da37cb770b4f965637a97
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/s390/kernel/perf_pai_ext.c:533:25: error: initialization of 'void (*)(struct perf_event_pmu_context *, bool)' {aka 'void (*)(struct perf_event_pmu_context *, _Bool)'} from incompatible pointer type 'void (*)(struct perf_event_context *, bool)' {aka 'void (*)(struct perf_event_context *, _Bool)'} [-Werror=incompatible-pointer-types]
>      533 |         .sched_task   = paiext_sched_task,
>          |                         ^~~~~~~~~~~~~~~~~

Simple matter of changing the function signature seems to cure things.
I'll shortly push a new version.
