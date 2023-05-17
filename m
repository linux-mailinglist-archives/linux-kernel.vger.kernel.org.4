Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1152A7064E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjEQKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEQKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3655246;
        Wed, 17 May 2023 03:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58CBE60CE8;
        Wed, 17 May 2023 10:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A56C433D2;
        Wed, 17 May 2023 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684318244;
        bh=o6VIhx8iMtwgSRKQqdnujwxMu+YX3Kt7QhJryZGPBX4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oa2TK7sGeuUsRYdmfb4Q9rMN+nlumMG10zmivP26ZYbgdqWXVo1UGOoZftuVRbJr+
         F7+hBg3tiMMMTiwxDeR84jq+mbw/ItGi65dGoM+EaT66jNIQzSbmxcsyzbamzrbpIF
         RJRVewxaeYSBU/02npD3Y0HP+kobLX1nFMDkLcIX8mHVljZnd2bo/qWvrke+ODagVl
         uIC7FdEJWcLtm35PxD4hDQKdafSvwhKGOkqObrhjyqTMAYihXnJA3CIotEZXzvMLfy
         LYYmwYGEqrf+bewFGMGiUzJg70a6ktyNqL0Pal1E81bwBGNtAyPA8M28Dm2h9dRZW8
         jZQdZFNXwO1lw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4AC79CE127F; Wed, 17 May 2023 03:10:44 -0700 (PDT)
Date:   Wed, 17 May 2023 03:10:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH locking/atomic 19/19] docs: Add atomic operations to the
 driver basic API documentation
Message-ID: <d9dc191c-1b65-47a7-a4f7-b89aad08ad7a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-19-paulmck@kernel.org>
 <202305161433.C015F9E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305161433.C015F9E@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:33:29PM -0700, Kees Cook wrote:
> On Wed, May 10, 2023 at 11:17:17AM -0700, Paul E. McKenney wrote:
> > Add the include/linux/atomic/atomic-arch-fallback.h file to the
> > driver-api/basics.rst in order to provide documentation for the Linux
> > kernel's atomic operations.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you, Kees, I will apply on my next rebase.

Given Mark's ongoing atomics rework, a later version of this patch is
likely to remove ".. kernel-doc:: arch/x86/include/asm/atomic.h" from
that same file.  (One of the benefits of Mark's rework is that all the
kernel-doc headers can be in the same file.)

Unless you tell me otherwise, I will retain your Reviewed-by across that
change.

							Thanx, Paul
