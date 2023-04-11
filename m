Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC926DE705
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDKWIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKWIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:08:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE593C24
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:08:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD5831F74C;
        Tue, 11 Apr 2023 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681250892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/XjSc44gwG+nuE0NrNWNRHKpYqRY6i/VDLJHWflJa0=;
        b=nopzy3baTfU9VDTbbEVM85Fa105wcPZ5uvMV5OmwvqnxLv3cnT80UFP7EyYuEjyT3Vzy5/
        kQR3iNlCgf3Ex54h+kZK6WtxpEnelOc4KTGDIwI6k+mnGREbg6XAiRr2NvI7djuCOF9Wv5
        xcdEK++37tZuWWWqi7/zxyFnfXnd4bA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681250892;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/XjSc44gwG+nuE0NrNWNRHKpYqRY6i/VDLJHWflJa0=;
        b=uF5k3OzYwEkJqEKMm/E/E5LbQ8NCt9CBWVvDN9l1zf5FrFaBnANjYsmswK2/pjLOP4Tn94
        eiHYut3yEcLDeTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9472013638;
        Tue, 11 Apr 2023 22:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jV4kI0zaNWQ3OAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 22:08:12 +0000
Date:   Wed, 12 Apr 2023 00:08:11 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Message-ID: <20230411220811.GA1798729@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:

> > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > Following LTP syscalls failed on the i386 and arm environments with
> > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > Embedded kirkstone.

> > > Thanks for the report and summary! I went through the list and found
> > > that most if not all of the bugs looks like incompatibilities
> > > with musl, not with 32-bit. It's probably not well tested with
> > > musl.

> > > Can you try again with glibc and see if there are any remaining
> > > issues then? LTP should probably be fixed to work with both, but
> > > if nobody has done that so far, it's likely that this has come
> > > up in the past but ran into problems upstreaming the fixes.

> > > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > > You get to see "segfault" in the following logs that have been noticed
> > > > on i386 only.

> > > > This is not a new problem. We have been noticing these failures for a
> > > > really long time.
> > > > Would it be worth investigating the reason for failures on 32bit architectures ?

> > > > Test logs,
> > > > -----
> > > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


> > > > Test environment: i386
> > > > Suite: ltp-syscalls
> > > > Toolchain: gcc-11


> > > > fstatfs02
> > > > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > > > received (pid = 17841).
> > > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> > This is IMHO using the old LTP API.
> > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> > released in 20220930. There is already newer release 20230127.
> > Generally it's safer to test mainline kernel with LTP master,
> > but this fix has already been in the latest LTP release 20230127.
> > And this error has been later fixed with
> > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")
I'm sorry, I was wrong stating that unexpected signal SIGSEGV(11)
error was fixed by 492542072.

> Thanks for insite about the failed test investigations.


> > @Naresh which LTP do you use for testing? It must be some older LTP :(.

> Our build system started running LTP version 20230127.
I'm sorry, I obviously misinterpreted the test output as old LTP code.

> I will keep you posted with the latest findings.
Thanks!

Kind regards,
Petr

> - Naresh
