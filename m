Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088856DEAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDLFWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLFWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:22:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83259C5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:22:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so15735864pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681276939; x=1683868939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr0icSpVKCPnLZQ+tFOCmycAfMELwVjpmQ0R9TC0vwk=;
        b=ZSDqFJzAkHdOHaJpK/c++c7+MNJKFrMWsazHnM6d16yiNovPw2IMnBruK2tQMOI+Ls
         wKToLOB/nKT3MeFKkM/SnbJ8RPUOJGiy/EVamGm+xSjJqWl+SsnMIet9sv9FcLHiZ0+V
         nLRhSsjOlM5YoiUXi8Q3kfBHRx+g8wx6BrtmXcviRwfY2z8f0oESNZsO+R3zI124XV2G
         5p1kHDL/78u1bcHOjoQ3VGb6+6wbeNwqnzxuiiyfZhWo6XYL71NXX8n03tTo5QtbBwjb
         w0kRxVe8+/LI/I1+yEBuzJycrzB+2b/Kv/1vhyizFJ8Az7cXNDN+vdl9qbv3to3wdjyV
         3eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276939; x=1683868939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr0icSpVKCPnLZQ+tFOCmycAfMELwVjpmQ0R9TC0vwk=;
        b=EZ/r7HL4efCYjfh78cgplCGe6SMMVV5Z76obYF2kxZeUvrejO+Z8WyQ/7t4jKnH/Cx
         w7lD9S30xYBRWBs5Ft6QEz1Wu5mRyNwSMgw2o6zngPTbeBdMrbhb5k8D0fsDSnd3zQ7O
         BGMwnOXLJ1PMN8Ldb9Bz7kv4M/3pcu43cpoXVtTD8aH0C+HH8Cec8E0yGMqzWvvqsM+h
         VF/cuAw/KTtCFmH25TorcHIjv+iIUFAr4FdhO6XyMGQzECoRumKnBcX3JvFqxdXshPGw
         mqn3qwJKB6Y1vFpNdFcMxO82YWeXi0jsUemB/VaNGnk30b8EEmG1eoPxqLDKxqB2MAHb
         zR7w==
X-Gm-Message-State: AAQBX9cwVAFEzAanGDvylVypGsumP6wvEBdgVfEsOMh9ZJh8DmhNP2/S
        pYPhunvtVlrkAnCGbG1Txxp8OSpmhkHIhrUIaaEfCw==
X-Google-Smtp-Source: AKy350bkRZs1ZX6Oh5+Gsg2Qibg56wnyWJGpkgLYAS/bhRh/XSkX6czFQ0/G3I4jW1R5shP7dCprZCMFrO3y07axuZQ=
X-Received: by 2002:a17:902:db0e:b0:1a2:73b3:b398 with SMTP id
 m14-20020a170902db0e00b001a273b3b398mr4642252plx.6.1681276939148; Tue, 11 Apr
 2023 22:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com> <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com> <20230411220811.GA1798729@pevik>
In-Reply-To: <20230411220811.GA1798729@pevik>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 11 Apr 2023 23:22:07 -0600
Message-ID: <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 11 Apr 2023 at 16:08, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:
>
> > > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > > Following LTP syscalls failed on the i386 and arm environments wi=
th
> > > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > > Embedded kirkstone.
>
> > > > Thanks for the report and summary! I went through the list and foun=
d
> > > > that most if not all of the bugs looks like incompatibilities
> > > > with musl, not with 32-bit. It's probably not well tested with
> > > > musl.
>
> > > > Can you try again with glibc and see if there are any remaining
> > > > issues then? LTP should probably be fixed to work with both, but
> > > > if nobody has done that so far, it's likely that this has come
> > > > up in the past but ran into problems upstreaming the fixes.
>
> > > > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > > > You get to see "segfault" in the following logs that have been no=
ticed
> > > > > on i386 only.
>
> > > > > This is not a new problem. We have been noticing these failures f=
or a
> > > > > really long time.
> > > > > Would it be worth investigating the reason for failures on 32bit =
architectures ?
>
> > > > > Test logs,
> > > > > -----
> > > > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tux=
make)
> > > > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binuti=
ls
> > > > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389
>
>
> > > > > Test environment: i386
> > > > > Suite: ltp-syscalls
> > > > > Toolchain: gcc-11
>
>
> > > > > fstatfs02
> > > > > fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad fi=
le descriptor
> > > > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEG=
V(11)
> > > > > received (pid =3D 17841).
> > > > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> > > This is IMHO using the old LTP API.
> > > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LT=
P API in
> > > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which=
 was
> > > released in 20220930. There is already newer release 20230127.
> > > Generally it's safer to test mainline kernel with LTP master,
> > > but this fix has already been in the latest LTP release 20230127.
> > > And this error has been later fixed with
> > > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of =
EFAULT")
> I'm sorry, I was wrong stating that unexpected signal SIGSEGV(11)
> error was fixed by 492542072.
>
> > Thanks for insite about the failed test investigations.
>
>
> > > @Naresh which LTP do you use for testing? It must be some older LTP :=
(.
>
> > Our build system started running LTP version 20230127.
> I'm sorry, I obviously misinterpreted the test output as old LTP code.

No, you were right! We were running an older version and because of
this discussion we have now updated to 20230127 in Kirkstone. This
update from Naresh and these findings are with 20230127.

Thanks for looking into this! Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
