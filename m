Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68916DE15C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDKQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:46:08 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB659C9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:45:50 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id v1so8024069vsg.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681231548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mIEqJhThfqATO21A0l51GhFD/DStlepMrZco0lBVm3U=;
        b=yEtKIw265e9dv4kG8hejwXCrbyznibtKsKao/0UNThOgZuUUnt6NhuCa/uW+RGqEje
         aJG7rMVy13g9viI7SxgQfYBLge2Z+E92wji+Vc3/YxDz9/qrvipKSSSf+1VfTaSBKwOF
         Yc/zNxWbXKZafzdRUoplPgwXMkXYBytalT8tWG/wd3J61Bc+nJFeXbbexQWHeHatg1g6
         a5GEeg6GZ3/wFdP/8BXJQwfgGsfPFXRMCzMTwDwzbBak/573a7iVbneqC9JaiNW+1Pay
         0L1PvCVZoELluw1y4otr+Md7DDTpG+dZknXPjg42EhKfAnOGw/2zDZovbG6Fgkz6QV5a
         cniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIEqJhThfqATO21A0l51GhFD/DStlepMrZco0lBVm3U=;
        b=O3V0wOpbDSbY1cXqeo76bccnpoGxKdznwMkC4dNuxOg2xF1b4opHbpaOXWvi4ZQQAN
         PkIi9byoi8zh+02Hen0IEf2YSXzFrgUIj6xxFxP9EJaVJL5jY3iEX7I6xU5TjGS/iPtJ
         A/yBImOMjqvRn4bO9/RkCSduCGHbhnN6Zg8dmxl5Fj55R3myrRT7VKT7rPzuFwpF2IHE
         ZbnMIEhCWv434ZyxTTy1S2wsA4DOnHxWI5HsKQp0WxnwscCm2k/31K4dvmVcQUkLMHay
         TXLfr6NIQcdeSvfklZEJqyz1UkkrXrnuLnX8/7FQclKHr8TTinqSwez7G6yKnV0t0iVT
         VIVA==
X-Gm-Message-State: AAQBX9fWCXsrFLWXO7OpAtI6tJpeZ41gUI4UWiEDFTe078x/eh7AO/8z
        oeoE+Oj+LJmmwqzL4mCSvvj6ix5CykKBp6w1Lph6UQ==
X-Google-Smtp-Source: AKy350aLiSIIUedc5/zLhlcykg263K0pGsG2J/2ArbvRP2ytHgzyUKMhyd6G8oT/XuNuItumcNW/oWkCNdWpfB6sNwE=
X-Received: by 2002:a67:d492:0:b0:42c:6fe9:bcee with SMTP id
 g18-20020a67d492000000b0042c6fe9bceemr4138329vsj.1.1681231548148; Tue, 11 Apr
 2023 09:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com> <20230406105646.GB1545779@pevik>
In-Reply-To: <20230406105646.GB1545779@pevik>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Apr 2023 22:15:36 +0530
Message-ID: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > Following LTP syscalls failed on the i386 and arm environments with
> > > Linux next / mainline kernels. The userspace is coming from Open
> > > Embedded kirkstone.
>
> > Thanks for the report and summary! I went through the list and found
> > that most if not all of the bugs looks like incompatibilities
> > with musl, not with 32-bit. It's probably not well tested with
> > musl.
>
> > Can you try again with glibc and see if there are any remaining
> > issues then? LTP should probably be fixed to work with both, but
> > if nobody has done that so far, it's likely that this has come
> > up in the past but ran into problems upstreaming the fixes.
>
> > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > You get to see "segfault" in the following logs that have been noticed
> > > on i386 only.
>
> > > This is not a new problem. We have been noticing these failures for a
> > > really long time.
> > > Would it be worth investigating the reason for failures on 32bit architectures ?
>
> > > Test logs,
> > > -----
> > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389
>
>
> > > Test environment: i386
> > > Suite: ltp-syscalls
> > > Toolchain: gcc-11
>
>
> > > fstatfs02
> > > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > > received (pid = 17841).
> > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> This is IMHO using the old LTP API.
> testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> released in 20220930. There is already newer release 20230127.
> Generally it's safer to test mainline kernel with LTP master,
> but this fix has already been in the latest LTP release 20230127.
> And this error has been later fixed with
> 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")

Thanks for insite about the failed test investigations.

>
> @Naresh which LTP do you use for testing? It must be some older LTP :(.

Our build system started running LTP version 20230127.
I will keep you posted with the latest findings.

- Naresh
