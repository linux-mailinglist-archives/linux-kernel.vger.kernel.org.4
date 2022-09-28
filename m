Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24F5EDA55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiI1Kqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiI1Kqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:46:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1903ABD43
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:46:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3897D143D;
        Wed, 28 Sep 2022 03:46:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F85C3F792;
        Wed, 28 Sep 2022 03:46:31 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:46:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [GIT PULL] arm64 fixes for -rc7
Message-ID: <YzQmAa+ni68jMPGK@FVFF77S0Q05N>
References: <20220923182800.GA14450@willie-the-truck>
 <CAHk-=wjRtRUm4fkqTed+MKgDanxbAH_eePR_gh6iWXJvAXSdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRtRUm4fkqTed+MKgDanxbAH_eePR_gh6iWXJvAXSdNw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 03:43:05PM -0700, Linus Torvalds wrote:
> On Fri, Sep 23, 2022 at 11:28 AM Will Deacon <will@kernel.org> wrote:
> >
> > Please pull these arm64 fixes for -rc7. They're all very simple and
> > self-contained, although the CFI jump-table fix touches the generic
> > linker script as that's where the problematic macro lives.
> 
> The commit message is a bit confusing. It talks about "hysterical
> raisins on x86", but CONFIG_CFI_CLANG has always been arm64-only. No?
> 
> So I'm not seeing what the x86 comment is about?

It was a an accidental inclusion inthe ARM64 CFI series while x86 CFI support
was being developed; in the thread in the LINK tage, Sami says:

| This was a leftover from an old x86 series, which was included here by
| mistake. Will also asked me about this a couple of weeks ago, I think, and
| said he'd send a patch to remove it.

The relevant message being:

  https://lore.kernel.org/all/CABCJKufrRCb84fafhsR8_fftBLv0_pvufL_ZZieUSTJfhdT+fw@mail.gmail.com/

Thanks,
Mark.
