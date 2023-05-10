Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E76FE3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEJSPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441715FCB;
        Wed, 10 May 2023 11:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C771F61449;
        Wed, 10 May 2023 18:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA4AC433D2;
        Wed, 10 May 2023 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683742544;
        bh=Sy4bwWWd/gL/Qjqb3nuXSSY4H4QLw53LaqzgoAJHcJo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=EfRoNH8RWG5DwMxgFVHDaIUajH/PahHWbeAwhrhU0sV3V4CevMK3xIctTks5AIFJ2
         7ks+5WAUN/+UOHs3ZSgrWQUaO11JKSmv2grBK0nuLzEXmViowXXE2pkotnR0olSZqb
         pNZs7tpqQdBERO+uqUDoCwpVCyOfSFf3nwdBj65MPKe5wCKpUKEZx03fDxJDes4sSu
         WQ/9wB80dpAR+CcxRqmfYcLn8g5UFkVTLZb04tyV2ISjklSaWiPc1C5W8/4A+Ou0Wm
         H6G5peyDaNRwfYZAvK8MY7Ez2m8ZLJlT3VgMMntUgMnh4pWfvLItJhCEF40xCxJ/ZN
         4U5zNn1rfY4Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0033CE120B; Wed, 10 May 2023 11:15:43 -0700 (PDT)
Date:   Wed, 10 May 2023 11:15:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     corbet@lwn.net, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mark.rutland@arm.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH locking/atomics 0/19] Add kernel-doc for more atomic
 operations
Message-ID: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds kernel-doc for additional atomic operations by adding
them to the gen-atomics.sh-based scripting.  This ends up duplicating
a few entries currently in x86, which this series removes in order to
avoid duplicate-entry warnings from "make htmldocs".

1.	locking/atomic: Fix fetch_add_unless missing-period typo.

2.	locking/atomic: Add "@" before "true" and "false" for fallback
	templates.

3.	locking/atomic: Add kernel-doc and docbook_oldnew variables
	for headers.

4.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}inc${sfx}${order}.

5.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}dec${sfx}${order}.

6.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}andnot${sfx}${order}.

7.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_try_cmpxchg${order}.

8.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_dec_if_positive.

9.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_dec_unless_positive.

10.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_inc_unless_negative.

11.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_set_release.

12.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_read_acquire.

13.	locking/atomic: Script to auto-generate acquire, fence, and
	release headers.

14.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}${name}${sfx}_acquire.

15.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}${name}${sfx}_release.

16.	locking/atomic: Add kernel-doc header for
	arch_${atomic}_${pfx}${name}${sfx}.

17.	x86/atomic.h: Remove duplicate kernel-doc headers.

18.	locking/atomic: Refrain from generating duplicate fallback
	kernel-doc.

19.	Add atomic operations to the driver basic API documentation.

Aside:  There was much much less drama and pain involved in installing
and running "make htmldocs" than last time around.  A big "thank you!"
to whoever made this happen.  Here is hoping for a similar degree of
improvement for the next required upgrade!  ;-)

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/driver-api/basics.rst          |    3 
 b/arch/x86/include/asm/atomic.h                |   60 
 b/include/linux/atomic/atomic-arch-fallback.h  |    6 
 b/scripts/atomic/acqrel.sh                     |   67 
 b/scripts/atomic/chkdup.sh                     |   27 
 b/scripts/atomic/fallbacks/acquire             |    4 
 b/scripts/atomic/fallbacks/add_negative        |    4 
 b/scripts/atomic/fallbacks/add_unless          |    2 
 b/scripts/atomic/fallbacks/andnot              |    8 
 b/scripts/atomic/fallbacks/dec                 |    7 
 b/scripts/atomic/fallbacks/dec_and_test        |    2 
 b/scripts/atomic/fallbacks/dec_if_positive     |   10 
 b/scripts/atomic/fallbacks/dec_unless_positive |    8 
 b/scripts/atomic/fallbacks/fence               |    2 
 b/scripts/atomic/fallbacks/fetch_add_unless    |    2 
 b/scripts/atomic/fallbacks/inc                 |    7 
 b/scripts/atomic/fallbacks/inc_and_test        |    2 
 b/scripts/atomic/fallbacks/inc_not_zero        |    2 
 b/scripts/atomic/fallbacks/inc_unless_negative |    8 
 b/scripts/atomic/fallbacks/read_acquire        |    7 
 b/scripts/atomic/fallbacks/release             |    2 
 b/scripts/atomic/fallbacks/set_release         |    7 
 b/scripts/atomic/fallbacks/sub_and_test        |    2 
 b/scripts/atomic/fallbacks/try_cmpxchg         |   10 
 b/scripts/atomic/gen-atomic-fallback.sh        |   17 
 b/scripts/atomic/gen-atomic-instrumented.sh    |   17 
 b/scripts/atomic/gen-atomics.sh                |    4 
 include/linux/atomic/atomic-arch-fallback.h    | 1754 +++++++++++++++++++------
 scripts/atomic/fallbacks/acquire               |    3 
 scripts/atomic/fallbacks/add_negative          |    5 
 scripts/atomic/fallbacks/add_unless            |    5 
 scripts/atomic/fallbacks/andnot                |    5 
 scripts/atomic/fallbacks/dec                   |    5 
 scripts/atomic/fallbacks/dec_and_test          |    5 
 scripts/atomic/fallbacks/dec_if_positive       |    5 
 scripts/atomic/fallbacks/dec_unless_positive   |    5 
 scripts/atomic/fallbacks/fence                 |    3 
 scripts/atomic/fallbacks/fetch_add_unless      |    5 
 scripts/atomic/fallbacks/inc                   |    5 
 scripts/atomic/fallbacks/inc_and_test          |    5 
 scripts/atomic/fallbacks/inc_not_zero          |    5 
 scripts/atomic/fallbacks/inc_unless_negative   |    5 
 scripts/atomic/fallbacks/read_acquire          |    5 
 scripts/atomic/fallbacks/release               |    3 
 scripts/atomic/fallbacks/set_release           |    5 
 scripts/atomic/fallbacks/sub_and_test          |    5 
 scripts/atomic/fallbacks/try_cmpxchg           |    5 
 47 files changed, 1686 insertions(+), 454 deletions(-)
