Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD58070BE80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjEVMig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEVMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:38:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC266C5;
        Mon, 22 May 2023 05:38:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FC511FB;
        Mon, 22 May 2023 05:31:12 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C47A3F59C;
        Mon, 22 May 2023 05:30:26 -0700 (PDT)
Date:   Mon, 22 May 2023 13:30:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 19/19] docs: Add atomic operations to the
 driver basic API documentation
Message-ID: <ZGtgUGSmlWk+5Pow@FVFF77S0Q05N>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-19-paulmck@kernel.org>
 <202305161433.C015F9E@keescook>
 <d9dc191c-1b65-47a7-a4f7-b89aad08ad7a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9dc191c-1b65-47a7-a4f7-b89aad08ad7a@paulmck-laptop>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:10:44AM -0700, Paul E. McKenney wrote:
> On Tue, May 16, 2023 at 02:33:29PM -0700, Kees Cook wrote:
> > On Wed, May 10, 2023 at 11:17:17AM -0700, Paul E. McKenney wrote:
> > > Add the include/linux/atomic/atomic-arch-fallback.h file to the
> > > driver-api/basics.rst in order to provide documentation for the Linux
> > > kernel's atomic operations.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thank you, Kees, I will apply on my next rebase.
> 
> Given Mark's ongoing atomics rework, a later version of this patch is
> likely to remove ".. kernel-doc:: arch/x86/include/asm/atomic.h" from
> that same file.  (One of the benefits of Mark's rework is that all the
> kernel-doc headers can be in the same file.)

FWIW, I retained that in the series I just posted at:

  https://lore.kernel.org/lkml/20230522122429.1915021-1-mark.rutland@arm.com/

... which drops ".. kernel-doc:: arch/x86/include/asm/atomic.h" as mentioned
above.

Please let me know if you'd like that R-b dropped.

Thanks,
Mark.
