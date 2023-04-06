Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD26D9484
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjDFK4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjDFK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:56:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5706EAF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:56:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1748422197;
        Thu,  6 Apr 2023 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680778609;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l39RzXUPYBvUMgcSliCoPts40Hr46+yafquZHjh6CtI=;
        b=yAEcOpJuwDaecpdPURI4+qnGAXI4WanzlilG/o7Q77m3ChS/698aNXBRV0E/96LEFUgbgr
        tQVTtwQrAkBRXV7yMd2d3yRVYQ9el6Vb/aEuBxxRhLdG/I9Bo90fVLucmZNAw2A7CvhvIh
        w2/iOay2t5sWJgoaq2x7UfmKS5ApM1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680778609;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l39RzXUPYBvUMgcSliCoPts40Hr46+yafquZHjh6CtI=;
        b=av/SU98Y5OG1yVXry8pgJV5VBfn5d5eJurS7m1kK1aziDVsHbPYVr6ROwJezCdjV/HUMiV
        XqOUjlGQKkN5nrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A39F133E5;
        Thu,  6 Apr 2023 10:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9vOLF3ClLmQ4NQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 10:56:48 +0000
Date:   Thu, 6 Apr 2023 12:56:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
Message-ID: <20230406105646.GB1545779@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > Following LTP syscalls failed on the i386 and arm environments with
> > Linux next / mainline kernels. The userspace is coming from Open
> > Embedded kirkstone.

> Thanks for the report and summary! I went through the list and found
> that most if not all of the bugs looks like incompatibilities
> with musl, not with 32-bit. It's probably not well tested with
> musl.

> Can you try again with glibc and see if there are any remaining
> issues then? LTP should probably be fixed to work with both, but
> if nobody has done that so far, it's likely that this has come
> up in the past but ran into problems upstreaming the fixes.

> > Anyone seeing this problem on 32-bit i386 or arm ?
> > You get to see "segfault" in the following logs that have been noticed
> > on i386 only.

> > This is not a new problem. We have been noticing these failures for a
> > really long time.
> > Would it be worth investigating the reason for failures on 32bit architectures ?

> > Test logs,
> > -----
> > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


> > Test environment: i386
> > Suite: ltp-syscalls
> > Toolchain: gcc-11


> > fstatfs02
> > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > received (pid = 17841).
> > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
This is IMHO using the old LTP API.
testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
released in 20220930. There is already newer release 20230127.
Generally it's safer to test mainline kernel with LTP master,
but this fix has already been in the latest LTP release 20230127.
And this error has been later fixed with
492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")

@Naresh which LTP do you use for testing? It must be some older LTP :(.

> I think this is the same thing that Tudor reported last year,
> looks like valid behavior of the libc implementation that should
> be handled by ltp:

> https://lore.kernel.org/all/20220822113919.196953-5-tudor.cretu@arm.com/

> Are you building the 32-bit x86 userspace with musl or glibc?

> > ---
> > ioctl03
> > ioctl03.c:85: TFAIL: (UNKNOWN 0x40)

> 0x40 was added by kernel commit 195624d9c26b ("tun: support not
> enabling carrier in TUNSETIFF"), this needs to be fixed in ltp
> as well. Should not be specific to 32-bit though.

Again, this error has been fixed in LTP master in
538a44741 ("syscalls/ioctl03: add IFF_NO_CARRIER flag")

> > ----
> > mq_timedreceive01

> > [  283.875014] mq_timedreceive[2354]: segfault at b7f5a004 ip b7dc1b0f
> > sp bfc4dde0 error 4 in libc.so.6[b7d52000+175000] likely on CPU 2
> > (core 2, socket 0)
> > [  283.894804] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
> > ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
> > c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> > c1 f8
> > [  283.913703] audit: type=1701 audit(1680761716.789:31):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=2354
> > comm=\"mq_timedreceive\"
> > exe=\"/opt/ltp/testcases/bin/mq_timedreceive01\" sig=11 res=1
> >    0

I suppose none of the issues can be related to audit log.

> > mq_timedreceive01
> > mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR (4)
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> I think this is the same problem as fstatfs02, where ltp passes
> an invalid pointer and expects EFAULT, but musl touches the data
> first in order to do the time64 conversion. Needs the same fix.

FYI mq_timedreceive01 is broken on 32bit systems with glibc
(in current LTP master):

tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
mq_timedreceive01.c:140: TINFO: Testing variant: vDSO or syscall with libc spec
mq_timedreceive01.c:223: TPASS: mq_timedreceive() returned 0, priority 0, length: 8192
mq_timedreceive01.c:223: TPASS: mq_timedreceive() returned 1, priority 0, length: 8192
mq_timedreceive01.c:223: TPASS: mq_timedreceive() returned 8192, priority 0, length: 8192
mq_timedreceive01.c:223: TPASS: mq_timedreceive() returned 1, priority 32767, length: 8192
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedreceive/../utils/mq.h:70: TINFO: receive 1/1 message
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EMSGSIZE (90)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF (9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF (9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EBADF (9)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EAGAIN/EWOULDBLOCK (11)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINVAL (22)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: ETIMEDOUT (110)
mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR (4)
tst_test.c:1618: TBROK: Test killed by SIGSEGV!

> > ----
> > mq_timedsend01

> > [  283.982220] mq_timedsend01[2357]: segfault at b7f06004 ip b7d6dd6f
> > sp bfb58fe0 error 4 in libc.so.6[b7cfe000+175000] likely on CPU 0
> > (core 0, socket 0)
> > [  283.996745] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
> > ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
> > c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> > c1 f8
> > lls/mq_notify/..[  284.015564] audit: type=1701
> > audit(1680761716.891:32): auid=4294967295 uid=0 gid=0 ses=4294967295
> > subj=kernel pid=2357 comm=\"mq_timedsend01\"
> > exe=\"/opt/ltp/testcases/bin/mq_timedsend01\" sig=11 res=1
> > /utils/mq.h:70: TINFO: receive 1/1 message

> > mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EFAULT (14)
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> same here

Also broken on glibc:

tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
mq_timedsend01.c:153: TINFO: Testing variant: vDSO or syscall with libc spec
mq_timedsend01.c:259: TPASS: mq_timedreceive() returned 0, priority 0, length: 8192
mq_timedsend01.c:259: TPASS: mq_timedreceive() returned 1, priority 0, length: 8192
mq_timedsend01.c:259: TPASS: mq_timedreceive() returned 8192, priority 0, length: 8192
mq_timedsend01.c:259: TPASS: mq_timedreceive() returned 1, priority 32767, length: 8192
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EMSGSIZE (90)
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EBADF (9)
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EBADF (9)
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EBADF (9)
mq_timedsend01.c:259: TPASS: mq_timedreceive() returned 16, priority 0, length: 8192
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EINVAL (22)
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EINVAL (22)
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 1/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 2/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 3/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 4/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 5/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 6/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 7/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 8/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 9/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 10/10 message
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EINVAL (22)
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 1/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 2/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 3/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 4/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 5/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 6/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 7/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 8/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 9/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 10/10 message
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EINVAL (22)
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 1/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 2/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 3/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 4/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 5/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 6/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 7/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 8/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 9/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 10/10 message
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: ETIMEDOUT (110)
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 1/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 2/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 3/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 4/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 5/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 6/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 7/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 8/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 9/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 10/10 message
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EINTR (4)
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 1/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 2/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 3/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 4/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 5/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 6/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 7/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 8/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 9/10 message
/home/abuild/rpmbuild/BUILD/ltp-20230403.906cbd90/testcases/kernel/syscalls/mq_timedsend/../utils/mq.h:70: TINFO: receive 10/10 message
mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EFAULT (14)
tst_test.c:1618: TBROK: Test killed by SIGSEGV!

> > ---

> > pread02_64

> > tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> > pread02.[  319.705083] /dev/zero: Can't open blockdev
> > c:44: TPASS: pread(3, 1024, 0) (null) : ESPIPE (29)
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> This looks like LTP is calling the wrong function here
> for musl: it passes D_FILE_OFFSET_BITS=64 for some tests
> but not others, but on musl you always get the 64-bit
> behavior.

I don't see this error on current master on glibc.
But I see different problem (permission on non-root) on musl chroot even on 64bit:
tst_test.c:112: TBROK: open(/dev/shm/ltp_pread02_64_1577218): EACCES (13)

When running as root it works:
pread02.c:44: TPASS: pread(3, 1024, 0) file descriptor is a PIPE or FIFO : ESPIPE (29)
pread02.c:44: TPASS: pread(5, 1024, -1) specified offset is negative : EINVAL (22)
pread02.c:44: TPASS: pread(6, 1024, 0) file descriptor is a directory : EISDIR (21)

I haven't figured out which packages are needed for 32bit toolchain on Alpine to
test 32 bit.

> > ---
> > recvmmsg01

> > [  369.451748] recvmmsg01[3821]: segfault at b7cb1004 ip b7dd7413 sp
> > bf992430 error 4 in libc.so.6[b7cda000+175000] likely on CPU 3 (core
> > 3, socket 0)
> > [  369.466232] Code: 26 00 00 00 00 66 90 f3 0f 1e fb 55 57 56 53 83
> > ec 2c 8b 5c 24 50 8b 44 24 40 8b 54 24 44 8b 4c 24 48 8b 74 24 4c 85
> > db 74 55 <8b> 7b 04 c7 44 24 1c 00 00 00 00 83 ec 08 8b 2b 89 7c 24 14
> > 8b 7c
> > [  369.485043] audit: type=1701 audit(1680761802.360:44):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=3821
> > comm=\"recvmmsg01\" exe=\"/opt/ltp/testcases/bin/recvmmsg01\" sig=11
> > res=1
> > [  369.496491] mmap: remap_file_page (3822) uses deprecated
> > remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.


> > recvmmsg01.c:92: TPASS: recvmmsg() overflow in nanoseconds in timeout
> > : EINVAL (22)
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> Same time64 conversion issue as above.

Besides the same problem with shm permissions on musl I see SIGSEGV also on
64bit musl on current LTP master.

> > ---
> > semctl03

> > [  441.271399] semctl03[6093]: segfault at 0 ip b7e53fc0 sp bf93c0a0
> > error 4 in libc.so.6[b7d56000+175000] likely on CPU 1 (core 1, socket
> > 0)
> > [  441.284432] Code: 24 5c ff 74 24 5c e8 cf fd ff ff 83 c4 10 85 c0
> > 78 0e ba 04 00 14 00 0f a3 fa 0f 82 ba 00 00 00 83 c4 40 5b 5e 5f c3
> > 8d 76 00 <8b> 03 31 d2 89 e6 66 0f 6e ca 89 04 24 8b 43 04 89 44 24 04
> > 8b 43
> > [  441.303267] audit: type=1701 audit(1680761874.178:46):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6093
> > comm=\"semctl03\" exe=\"/opt/ltp/testcases/bin/semctl03\" sig=11 res=1

> > semctl03.c:73: TPASS: semctl() with invalid IPC command : EINVAL (22)
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> time64 again
Works on glibc (32 and 64 bit), works on 64bit musl (under root, again shm
permission problem when testing with non-root).

FYI there are some fixes in master (one glibc specific).

> > semctl04
> > semctl04.c:69: TBROK: semget(1628514830, 10, 600) failed: EEXIST (17)

> > semctl05
> > semctl05.c:54: TBROK: semget(1628514830, 10, 780) failed: EEXIST (17)

> These are probably broken by semctl03 having failed first, and
> they should be fine if you clear out the semaphore first, or
> skip the semctl03 test.

Yes, most likely.

> > ----
> > sigtimedwait01


> > [  486.624973] sigtimedwait01[6644]: segfault at 5 ip b7d9758f sp
> > bfda7290 error 4 in libc.so.6[b7d80000+175000] likely on CPU 1 (core
> > 1, socket 0)
> > [  486.639052] Code: c7 03 4b 00 00 00 b8 ff ff ff ff e9 3b fe ff ff
> > 8d b4 26 00 00 00 00 8d 74 26 00 f3 0f 1e fb 83 ec 1c 8b 44 24 28 85
> > c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> > c1 f8
> > [  486.659213] audit: type=1701 audit(1680761919.535:49):
> > auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6644
> > comm=\"sigtimedwait01\" exe=\"/opt/ltp/testcases/bin/sigtimedwait01\"
> > sig=11 res=1

Broken also on 32bit glibc:
tst_test.c:1618: TBROK: Test killed by SIGSEGV!

> > sigwait.c:344: TPASS: Child exited with expected code
> > tst_test.c:1581: TBROK: Test killed by SIGSEGV!

> sigwait calls sigtimedwait and copies the signal number into
> the provided pointer, so apparently a similar problem. I couldn't
> find the testcase in the ltp sources, only see a sigwait01.c
> not sigwait.c, but that doesn't trigger the bug.

> > ---


> > statfs02

> > statfs02    4  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
> > statfs02    5  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > received (pid = 6728).
> > statfs02    6  TBROK  :  tst_sig.c:232: Remaining cases broken

> I don't know why musl copes statfs, but this is yet another instance.
> Not time64

Again, converted to the new API, EFAULT fixed.

Kind regards,
Petr

> > statx01

> > statx01.c:138: TPASS: stx_nlink(1) is c[  833.666410] /dev/zero: Can't
> > open blockdev
> > orrect
> > statx01.c:82: TFAIL: statx.stx_mnt_id(421) is different from
> > mount_id(34280324422697381)[  833.678950] /dev/zero: Can't open
> > blockdev
> >  in /proc/self/mountinfo
> > statx01.c:88: TPASS: /proc/12304/fdinfo/3 mnt_id: = 421

> No idea, possibly some type mismatch between definitions in musl
> and ltp.

> > ---
> > ustat01

> > tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> > ustat01.c:39: TBROK: stat(/,0xbfb96278) failed: EOVERFLOW (75)

> > tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> > ustat02.c:57: TBROK: stat(/,0xbfa11098) failed: EOVERFLOW (75)

> I think the definition of 'struct ustat' in  ltp/include/lapi/ustat.h
> is wrong and does not match the kernel. This uses a libc-provided
> 'ino_t', which is probably different from what the kernel expects
> here.

>     Arnd
