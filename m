Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C461F74C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiKGPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiKGPMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:12:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09731E3D7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fk3tuS9LSYa7Gjf7y5mQ+pbRf3RBMe1Eavpj3BGpcOE=; b=XmS3J4Mt/tjP1mIWns7bdJheVk
        9Rii8MMX5cdPJJvngi2yhMoYd70xpaGH0rdrBWWvOrZj3mJMsbAQEl8t+bxs0d8Niv+04FF3/qs0W
        raT1ghSmrRsDTqmsXec1QvQgzXV6Q9e5DDtTUUDAnth1XjAWc1R50CauOrMsnfHjXeXMOWkXQuGpa
        BfIVEgXC/J37SrxCOdFGK9n70vpRj4xdwoFy2rCHHornn0mI+cJesuBKuUW+HZ9HFuiv1nnZYk8eX
        wVKmXxuGglRl/TvDgs5kddvAcIIYW/2v/R0jvTzePgsDDx/B1XHpv3KpavJE727CmjDhlJwcuJUoN
        D+/eh6hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1os3nY-009S7H-FH; Mon, 07 Nov 2022 15:12:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E3FD30026A;
        Mon,  7 Nov 2022 16:12:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56DE420298A51; Mon,  7 Nov 2022 16:12:20 +0100 (CET)
Date:   Mon, 7 Nov 2022 16:12:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [tip:x86/mm] [x86/mm]  b389949485:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr
Message-ID: <Y2kgVE+etZ1+F2PW@hirez.programming.kicks-ass.net>
References: <202211061748.eb591682-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211061748.eb591682-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 08:38:27PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr due to commit (built with gcc-11):
> 
> commit: b38994948567e6d6b62947401c57f4ab2efe070c ("x86/mm: Implement native set_memory_rox()")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> 
> [test failed on linux-next/master 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8]
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202211061748.eb591682-oliver.sang@intel.com
> 
> 
> [   44.943065][   T11] ------------[ cut here ]------------
> [   44.943725][   T11] CPA detected W^X violation: 0000000000000060 -> 0000000000000063 range: 0xffff8881beca5000 - 0xffff8881beca5fff PFN 1beca5
> [ 44.944929][ T11] WARNING: CPU: 0 PID: 11 at arch/x86/mm/pat/set_memory.c:609 __change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 
> [   44.945824][   T11] Modules linked in:
> [   44.946229][   T11] CPU: 0 PID: 11 Comm: kworker/0:1 Tainted: G        W          6.1.0-rc3-00010-gb38994948567 #1 f37474c2082f37dd433f70907b94c2b0df8d70b8
> [   44.947518][   T11] Workqueue: events bpf_prog_free_deferred
> [ 44.948074][ T11] RIP: 0010:__change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 

Urgh, as spotted by dhansen, the code in change_page_attr_set_clr(),
specifically the checkalias thing, seems to rely on single bit flips for
NX.

Let me try to make sense of this stuff....
