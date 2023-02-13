Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3908B69542A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBMWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:54:17 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9D83E6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:54:16 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 3C3C15F7C3;
        Mon, 13 Feb 2023 23:54:14 +0100 (CET)
Date:   Mon, 13 Feb 2023 23:54:14 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Juergen Gross <jgross@suse.com>
cc:     mikelley@microsoft.com,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
In-Reply-To: <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
Message-ID: <47d6d93f-defd-d18a-276a-417252e7ddce@nerdbynature.de>
References: <20230209072220.6836-1-jgross@suse.com> <20230209072220.6836-6-jgross@suse.com> <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info> <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com> <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
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
> Hmm, this would make Hyper-V SEV-SNP guests slow again.
> 
> I'm not completely against it, but OTOH I'm a little bit biased as the
> maintainer of the Xen code. :-)

Understood. I'm a bit puzzled why nobody else reports this, maybe Xen Dom0 
and external USB enclosures are not that common.

> Michael, would you see major problems with doing the revert before having
> the final patches for fixing your issue, too?

If that revert ends up in mainline, feel free to add:

 Tested-by: Christian Kujau <lists@nerdbynature.de> 

...if that makes any difference.

Thanks,
Christian.
-- 
BOFH excuse #199:

the curls in your keyboard cord are losing electricity.
