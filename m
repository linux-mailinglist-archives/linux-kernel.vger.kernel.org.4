Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD246944D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjBMLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBMLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:46:21 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E09EEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:46:19 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 4BE1B5F84C;
        Mon, 13 Feb 2023 12:46:17 +0100 (CET)
Date:   Mon, 13 Feb 2023 12:46:17 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Juergen Gross <jgross@suse.com>
cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
In-Reply-To: <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
Message-ID: <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
References: <20230209072220.6836-1-jgross@suse.com> <20230209072220.6836-6-jgross@suse.com> <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info> <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Juergen Gross wrote:
> On 10.02.23 19:59, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, this is your Linux kernel regression tracker.
> > 
> > On 09.02.23 08:22, Juergen Gross wrote:
> > > Commit 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled
> > > case") has introduced a regression with Xen.
> > > 
> > > Revert the patch.
> > 
> > That regression you refer to is afaics one I'm tracking[1] that was
> > introduced this cycle. That makes me wonder: could this patch be applied
> > directly to fix the issue quickly? Or are patches 1 to 4 needed as well
> > (or the whole series?) to avoid other problems?
> 
> Patches 1-4 are needed, too, as otherwise the issue claimed to be fixed
> with patch 5 would show up again.

The (last?) -rc8 version was released yesterday. Would it be possible to 
include at least (only) the revert in mainline so that 6.2 will be 
released with a working storage configuration under Xen?

Otherwise one would have to carry around that single revert manually until 
this patch series has landed in mainline, or convince all the 
distributions to do so :-\

Anyway, thanks for fixing this problem, I did not expect this to be such a 
complicated issue when I reported that thing :-)

Christian.
-- 
BOFH excuse #52:

Smell from unhygienic janitorial staff wrecked the tape heads
