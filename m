Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F2698805
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBOWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBOWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:42:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B991284E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:42:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D0E1CE25C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374DAC433D2;
        Wed, 15 Feb 2023 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676500940;
        bh=FZ+vJUnpiBy150adY2/Snz6rzRsvYvVw+/XhB7D6DsM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HNwd9NX0rRF50euktiNXQ0u72rb9iQwYZxJJpBpkd6BrNSVmF0rqjCrcy3/9Ba21D
         fOWeD1Tt1E9qeukg2CYP27VUHTKRtEsD82OtPzZeI/9R5WegOLVKWHYj9OJdo91M2g
         llzoFqhY6aL61YD+A6CITtZ4iyVSm71nlI6DVyxz8dvMyNF0bUDwTZpDqYac26NOt/
         C+5FHM1FSJNidFm0sOrlJsTCY5ka3LMaHOcMUvOFDOhkvo5hE5lzAHXRPTlPvK49mN
         i+ZlFkgE/JGFUdORFiPtwVvAlaugmY/IKppplcOuRgS3lVdlIBt6w4xUbORRPa9UPZ
         zKz2/ft5roaug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EFE65C0F9D; Wed, 15 Feb 2023 14:42:18 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:42:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
Message-ID: <20230215224218.GN2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230215091503.1490152-1-arnd@kernel.org>
 <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
 <78b2ed7d-2585-479f-98b1-ed2574a64cb8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b2ed7d-2585-479f-98b1-ed2574a64cb8@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:48:11AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 15, 2023, at 10:25, Marco Elver wrote:
> > On Wed, 15 Feb 2023 at 10:15, Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > Looks like KASAN does select CONSTRUCTORS already, so KCSAN should as well.
> >
> > Do you have a tree to take this through, or should it go through -rcu
> > as usual for KCSAN patches?
> 
> I don't have a tree for taking these build fixes, so it would be good if you could forward it as appropriate.

Queued and pushed, thank you both!

Is this ready for the upcoming merge window, or would you rather that
I hold off until the v6.4 merge window?  (I am tempted to treat this
as a bug fix, thus sending it earlier rather than later, but figured I
should ask.)

							Thanx, Paul
