Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33197729568
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbjFIJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbjFIJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:35:42 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 02:30:40 PDT
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A87D6E97;
        Fri,  9 Jun 2023 02:30:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3599OwuM031088;
        Fri, 9 Jun 2023 11:24:58 +0200
Date:   Fri, 9 Jun 2023 11:24:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, paulmck@kernel.org
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <ZILv6qiLIVJO8+MK@1wt.eu>
References: <20230609082858.5e1b4424@canb.auug.org.au>
 <20230609040804.164292-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609040804.164292-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:08:04PM +0800, Zhangjin Wu wrote:
> Hi, Stephen, Willy, Thomas, Paul
> 
> > Hi all,
> > 
> > Sorry, the subject should have been "linux-next: fixes tag needs work
> > in rcu tree".
> > 
> > On Fri, 9 Jun 2023 08:27:22 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
> > rote:
> > >
> > > In commit
> > >=20
> > >   df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
> > >=20
> > > Fixes tag
> > >=20
> > >   Fixes: 8e3ab529bef9 ("tools/nolibc/unistd: add syscall()")
> > >=20
> > > has these problem(s):
> > >=20
> > >   - Target SHA1 does not exist
> > >=20
> > > Maybe you meant
> > >=20
> > > Fixes: 6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
> 
> Thanks, just checked the rcu/next branch of Paul, the commit is really the one
> you corrected:
> 
>     Fixes: 6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
> 
> Willy, this happened may be because of the 'int' to 'long' fixup merged to the
> old "tools/nolibc/unistd: add syscall()" commit, I forgot the check of this
> change in my patch.

I was very careful about squashing the patches that mentioned commit IDs
that were not merged yet (since we don't want to merge incomplete patches),
but apparently missed this one :-/

> Btw, perhaps it is possible to merge this typo fixup (tools/nolibc: fix up typo
> _sycall_narg -> _syscall_narg) [1] to this commit too:
> 
>     6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
> 
> And then update the new 'Fixes' tag in this patch:
> 
>     df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
> 
> Or even merge both of them to the first one, and eventually, no Fixes lines
> required.
> 
> As a summary, the following two fixes:
> 
>     df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
> 
>     not merged   ("tools/nolibc: fix up typo _sycall_narg -> _syscall_narg"), see [1]
> 
> are for this one:
> 
>     6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
> 
> Merging both of them to the above one may be a choice ;-)

Agreed. I'll see off-line with Paul how to best proceed.

Thanks,
Willy
