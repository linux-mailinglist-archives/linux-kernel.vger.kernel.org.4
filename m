Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46276F7ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjEECK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEECKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A76E67;
        Thu,  4 May 2023 19:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A6C631E1;
        Fri,  5 May 2023 02:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E69C433EF;
        Fri,  5 May 2023 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683252623;
        bh=EIw62uznO9A9WrrdZplsIA/A7yQGp6YadAiMUSL2JI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LYjcLpq/pJdJEr31StWIX2U7D/vpXU3UBeq+WmaImT670SQfcC1Fcq2tpnHPT0foy
         FG2+T64hB2mkEJsuPxOLeskJbrAwPi7EyEHzK3T0CbojhHMlgvPDkYsa9Q4fBSCnSa
         XxK608DtubUJrG4gIk9FrQWWdPQN9wX0ayitS9G4=
Date:   Thu, 4 May 2023 19:10:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
Message-Id: <20230504191022.bc06f36a432dea7df74cc554@linux-foundation.org>
In-Reply-To: <ZFOLdr2CssE4O7+L@x1-carbon>
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
        <ZFOLdr2CssE4O7+L@x1-carbon>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 10:39:51 +0000 Niklas Cassel <Niklas.Cassel@wdc.com> wrote:

> On Thu, Apr 27, 2023 at 03:33:45PM -0700, Andrew Morton wrote:
> > 
> > Linus, please merge this cycles's batch of MM changes.  This is almost
> > everything - I'll have another 5-10 patches next week.
> 
> (cut)
> 
> > The following changes since commit ef832747a82dfbc22a3702219cc716f449b24e4a:
> > 
> >   nilfs2: initialize unused bytes in segment summary blocks (2023-04-18 14:22:14 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-04-27-15-30
> > 
> > for you to fetch changes up to 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1:
> > 
> >   mm,unmap: avoid flushing TLB in batch if PTE is inaccessible (2023-04-27 13:42:16 -0700)
> > 
> > ----------------------------------------------------------------
> 
> Hello Andrew,
> 
> It seems like the changes in mm/dmapool.c somehow got omitted in this PR.
> 
> $ git log --oneline 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1 --not v6.3 mm/dmapool.c
> 2d55c16c0c54 dmapool: create/destroy cleanup
> a4de12a032fa dmapool: link blocks across pages
> 9d062a8a4c6d dmapool: don't memset on free twice
> 887aef615818 dmapool: simplify freeing
> 2591b516533b dmapool: consolidate page initialization
> 36d1a28921a4 dmapool: rearrange page alloc failure handling
> 52e7d5653979 dmapool: move debug code to own functions
> 19f504584038 dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
> 347e4e44c0a9 dmapool: cleanup integer types
> 65216545436b dmapool: use sysfs_emit() instead of scnprintf()
> 7f796d141c07 dmapool: remove checks for dev == NULL
> 
> $ git diff 4d4b6d66db63ceed399f1fb1a4b24081d2590eb1 v6.3 mm/dmapool.c
> <empty>
> 
> It seems like the final commit, 2d55c16c0c54 ("dmapool: create/destroy
> cleanup") somehow reverted all the previous changes to this file.
> 
> 
> Looking at how that patch looked like on the list:
> https://patchwork.kernel.org/project/linux-mm/patch/20230126215125.4069751-13-kbusch@meta.com/
> the diff is way smaller than what can be seen in 2d55c16c0c54.

Well I don't know how I did this, sorry.

The patch "dmapool: create/destroy cleanup" was OK in mm-unstable (and
linux-next) from Jan 26 to Feb 26, so the series has had decent
linux-next testing.  It became messed up on Feb 26.

I've reconstituted

dmapool: remove checks for dev == NULL
dmapool: use sysfs_emit() instead of scnprintf()
dmapool: cleanup integer types
dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
dmapool: move debug code to own functions
dmapool: rearrange page alloc failure handling
dmapool: consolidate page initialization
dmapool: simplify freeing
dmapool: don't memset on free twice
dmapool: link blocks across pages
dmapool: create/destroy cleanup

and pushed the result out to the mm-unstable branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.

3a64f2e22553 dmapool: create/destroy cleanup
1d1e67d45a37 dmapool: link blocks across pages
7e54c3f0e123 dmapool: don't memset on free twice
cb569a63de3b dmapool: simplify freeing
874938254ae7 dmapool: consolidate page initialization
b97304656ad5 dmapool: rearrange page alloc failure handling
c31e8ec45299 dmapool: move debug code to own functions
1e05e5bdce74 dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
7ea3ff961459 dmapool: cleanup integer types
adf388b29d25 dmapool: use sysfs_emit() instead of scnprintf()
8491f7f301ad dmapool: remove checks for dev == NULL

Please check that all is as expected.

> Additionally, you might want to pick up:
> https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.1595247-1-kbusch@meta.com/
> as it has a Fixes tag that references one of the commits above.

That fix has been folded into "dmapool: link blocks across pages".
