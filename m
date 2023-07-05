Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3357B747AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGEAmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:42:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C48E47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:42:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3650fUuV007960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 20:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688517693; bh=dIqH9KwZXsDINXSA+0iOtOKUIywtLJD+yWXCKNypG4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qBXSj4Qf4/EWDKiGXcQ8BxArEsvXQ4sVN1XqAq55CqbvzoNGt/bUcQldMrJj8KCPZ
         geDsYh6Zqm9KH18lR8kfHwzCjUNOyYEAiboQn6mRmBxaPdJQVxQ41+vxFsEiXTqH6p
         G1UlABFFIFJSk8nP/iwGmV8KjjTQCcltBBP9/7EtbqXGGcxxMjrrgS2wjeaZoC6Vec
         eQwx+E4JFgwPX5ppz+VVCU4hMD0+WnRjGS1kjKcIdPdoImVhQeTyzuBux28mueP1sj
         CgUvJhTBsg5kpTvjYNl8CxX5XY49/ZXFKKDTFIsA7VZzNtu/t9oTR/RsrCG//d2JJb
         wc8v+AWEd1b+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CDDFE15C0280; Tue,  4 Jul 2023 20:41:29 -0400 (EDT)
Date:   Tue, 4 Jul 2023 20:41:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230705004129.GI1178919@mit.edu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
 <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu>
 <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
 <20230704222758.GB22271@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704222758.GB22271@1wt.eu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For whatever it's worth, I always run "b4 am -o /tmp/m ...", so all of
the .mbox files end up in /tmp/m.  Similarly, I'll always run "git ty
-o /tmp/e ..." so all of the thanks file end up in /tmp/e.  And that
way I inspect the b4 output files before I run "git am -s /tmp/m/..."
or "git send-mail /tmp/e/...".

So I never end up with the problem of stale b4 turds in the kernel
tree.  My one wish is that b4 would automatically create the arguments
to the -o otpion if they don't exist, so I'm not having to type "rm -r
/tmp/m ; mkdir /tmp/m" before I run b4, but as far as I'm concerned,
it's much better than having the turds in my kernel tree.

The other thing I got a bit confused about is the "autocomplete not
working".  At least for me, if there are two files that have the same
prefix, say, 2023, when type "2023<TAB>", the terminal bell goes
"fweep", which makes me understand that the prefix was not ambiguous,
and then the second time when I hit <TAB> I'll see the possible
autocomplete options, so I know what unique characters I might need to
type in order for autocomplete to make forward progress.  Now, it
might be that you've turned off the terminal bell, so you don't get
the hint about why autocomplete didn't fully complete the filename, so
it appears as it was "autocomplete not working", as opposed to your
not getting the feedback about why it didn't do more autocompletion.

> Sure but apparently the point of that commit was precisely to avoid
> *risking* to commit them for other users, or maybe just not seeing
> too many of them when running git status to make sure the rest that
> they consider more important is actually committed.

Well, if you use directories in /tmp for the b4 output, there's no
risk of them accidentally getting committed into the tree.  And unless
you do something like "git add .", there's no chance they would
accidentally get committed anyway, so I'm not sure I see the point.
I'm always manually using "git add <filename>" precisely because I
don't *trust* "git add ." not accidentally including stuff I don't
want....

						- Ted
