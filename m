Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB26DEC58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDLHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:14:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A62708
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:14:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 035761F896;
        Wed, 12 Apr 2023 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681283694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOFbCO2QvsRGjVIbkwUWdDTNOrQjcipph+4xXKb4nHk=;
        b=RZ1cmlbyoAjJj4zpJykutWBDVWn9Zw41LA20k0t+a8AgnE4Io5bbktzknBYil7x9gyZOUR
        zccfZo+BZAYKhRwX7iA1eQllvSYko4PAxc0/fpJd+6+6ltUtcPckrqazb2eXFYqJt3xG5H
        8bTDONsHNLhDPopjflc1tpKEduiQRGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681283694;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOFbCO2QvsRGjVIbkwUWdDTNOrQjcipph+4xXKb4nHk=;
        b=oqSDwr1faSiuosL2RxRJiWKMdQIFHI557svG+2LvjLS1A8WqRbh3qQoJhcNCCMAJZCZ98+
        7Pi2n+YSygIQMLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6D3413498;
        Wed, 12 Apr 2023 07:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Eod0K21aNmRbMgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 12 Apr 2023 07:14:53 +0000
Date:   Wed, 12 Apr 2023 09:14:52 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Message-ID: <20230412071452.GD1949572@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
 <20230411220811.GA1798729@pevik>
 <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!

> On Tue, 11 Apr 2023 at 16:08, Petr Vorel <pvorel@suse.cz> wrote:

> > > On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:

> > > > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > > > Following LTP syscalls failed on the i386 and arm environments with
> > > > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > > > Embedded kirkstone.

> > > > > Thanks for the report and summary! I went through the list and found
> > > > > that most if not all of the bugs looks like incompatibilities
> > > > > with musl, not with 32-bit. It's probably not well tested with
> > > > > musl.

> > > > > Can you try again with glibc and see if there are any remaining
> > > > > issues then? LTP should probably be fixed to work with both, but
> > > > > if nobody has done that so far, it's likely that this has come
> > > > > up in the past but ran into problems upstreaming the fixes.

> > > > > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > > > > You get to see "segfault" in the following logs that have been noticed
> > > > > > on i386 only.

> > > > > > This is not a new problem. We have been noticing these failures for a
> > > > > > really long time.
> > > > > > Would it be worth investigating the reason for failures on 32bit architectures ?

> > > > > > Test logs,
> > > > > > -----
> > > > > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > > > > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > > > > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


> > > > > > Test environment: i386
> > > > > > Suite: ltp-syscalls
> > > > > > Toolchain: gcc-11


> > > > > > fstatfs02
> > > > > > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > > > > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > > > > > received (pid = 17841).
> > > > > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> > > > This is IMHO using the old LTP API.
> > > > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> > > > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> > > > released in 20220930. There is already newer release 20230127.
> > > > Generally it's safer to test mainline kernel with LTP master,
> > > > but this fix has already been in the latest LTP release 20230127.
> > > > And this error has been later fixed with
> > > > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")
> > I'm sorry, I was wrong stating that unexpected signal SIGSEGV(11)
> > error was fixed by 492542072.

> > > Thanks for insite about the failed test investigations.


> > > > @Naresh which LTP do you use for testing? It must be some older LTP :(.

> > > Our build system started running LTP version 20230127.
> > I'm sorry, I obviously misinterpreted the test output as old LTP code.

> No, you were right! We were running an older version and because of
> this discussion we have now updated to 20230127 in Kirkstone. This
> update from Naresh and these findings are with 20230127.

Great, thank you! Using the latest release (or git master) really saves of all
of us.

Kind regards,
Petr

> Thanks for looking into this! Greetings!

> Daniel Díaz
> daniel.diaz@linaro.org
