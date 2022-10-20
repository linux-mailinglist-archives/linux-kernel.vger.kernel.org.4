Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0196067E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJTSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJTSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:06:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1356189C37;
        Thu, 20 Oct 2022 11:06:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n83so472740oif.11;
        Thu, 20 Oct 2022 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mi+Kve2Sq/QUlJWw8rhVBGBmF/oTbCKRhhXKM9X1Rzc=;
        b=EuJfTN8Ldh4nDUxx5bj0nfhX0T8xZXHBdJQy7bkhtBePrWSzYrezsiB+eqh2yzc7V2
         TaDgH/8BAUJ962/8ieEURlCRNtoJFeksroGVsljjbR9DfOCSLLGK0vq57wysmc0D4vJc
         hd9Fd4xkWZMq6113Jj3pB6N1OTPGApbyVVnXh1EJGqBsOEfr6KGBRxREHN19/FVbyM2u
         nLCwWkKVLBtC5kZN8zI2fVNYGVwqx/QMF5KEv8NrdcaNRlugnCtU0AuHgNZyd0hG/DLt
         iAQueZSVBi5ALshrVPCsejYqqk0N+bseBNbHsz/703FnIYN9eKSFFFAjNvxVPdvN1r9o
         jstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mi+Kve2Sq/QUlJWw8rhVBGBmF/oTbCKRhhXKM9X1Rzc=;
        b=PUxggWizBsotx/M8bKQR3g1WJrExgy4vN2BYZSfEqctURLngcuHjN7ueOXfX1CLEEl
         eEv0LX4USvaT3J70KMcOTTyHYr+CUzj+8akks5A4DF3GsBMLMFYEhNZdbJ9YPJHSdAHI
         GVfFitig93jGStYsrMDjSEECns7wR3kiR98XblybmX7EpBG/S9vaN0YxQ6Lvu+z50WqU
         eJqEaIVpvbb7iG3JilwSQBcp8Y9jwoRLjF4QNvcLc1yWeMIZor2wIWcO/G6IXzXwSv5f
         Ctv5S3Z7imWHbT4bERMplr6ab7hbVrXBGmi+TlQXFrEHwjc0OkdRnpqZAeQ6iljcUR/w
         VPnA==
X-Gm-Message-State: ACrzQf3liN0G+Loz3tsAiIXuOyhciOImICCZXrRSkpJ4wzDpLP7wWylC
        se0JwuPQVF5EeICQECL5Dy1wCVgIgVCH8bIPWQeRjZGxU+A=
X-Google-Smtp-Source: AMsMyM7GWcj2MaKJNwbCfkLPk2M2UmNGDecLnLjOnw7HDgY4oKZ8BjHgCu/lrJ81LJoirzuN/JK+5yjb7tHd40fr9eU=
X-Received: by 2002:a05:6808:e8e:b0:34d:7829:135 with SMTP id
 k14-20020a0568080e8e00b0034d78290135mr7890773oil.252.1666289213169; Thu, 20
 Oct 2022 11:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR03MB8319B83F92372CA86A42C089F3289@DU0PR03MB8319.eurprd03.prod.outlook.com>
 <CABCJKue6M4cXyTP9wgaBx0oZ+5K7sQna9UQF88Pxcknv-kzcMg@mail.gmail.com>
 <DU0PR03MB83196C180979F74ABEEB0562F32A9@DU0PR03MB8319.eurprd03.prod.outlook.com>
 <CAKwvOdncRqrTNqmiDhtkj74V4eU03FBgDr25H4+npwHYgrYQRw@mail.gmail.com>
 <CAKwvOd=7GZfdmtAG2W3Tjo1sPUA0eGnXFpUPWHp-3WJOgVpDEg@mail.gmail.com>
 <CA+icZUWKnw=eKZghzADQRse242dsx1WwGpF0hcSCUby_Wz7=QA@mail.gmail.com> <CAKwvOdnZhtWCExXvTtEB05444CBCXoR1Mo=dq43Qvb8B-pJo=w@mail.gmail.com>
In-Reply-To: <CAKwvOdnZhtWCExXvTtEB05444CBCXoR1Mo=dq43Qvb8B-pJo=w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 20 Oct 2022 20:06:16 +0200
Message-ID: <CA+icZUVhr45pdXQxZox9Rr0mR01fFQwgj8X4LRgj4dGE7tw1OA@mail.gmail.com>
Subject: Re: Update15.x/kcfi to LLVM 15.0.3 (ZSTD + DWARFv5)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 7:59 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Oct 20, 2022 at 10:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> >
> > On Thu, Oct 20, 2022 at 7:18 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 9:56 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Wed, Oct 19, 2022 at 10:44 PM Sedat Dilek (DHL Supply Chain)
> > > > <sedat.dilek@dhl.com> wrote:
> > > > >
> > > > > -----Urspr=C3=BCngliche Nachricht-----
> > > > > Von: Sami Tolvanen <samitolvanen@google.com>
> > > > > Gesendet: Dienstag, 18. Oktober 2022 18:00
> > > > > An: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> > > > > Betreff: Re: Update15.x/kcfi to LLVM 15.0.3
> > > > >
> > > > > On Tue, Oct 18, 2022 at 4:54 AM Sedat Dilek (DHL Supply Chain) <s=
edat.dilek@dhl.com> wrote:
> > > > > >
> > > > > [ CC Nick + Fangrui ]
> > > > >
> > > > > You happen to know or use the ZSTD cmake-option (see [1] and [2])=
 - came in with changes post-15.0.2?
> > > > >
> > > > > AFAICS Fangrui Song had some patches to use ZSTD debug-compressio=
n with DWARFv5.
> > > > >
> > > > > Unsure, if that combination is now possible in v15.0.3 or is a fe=
ature of LLVM-16.
> > > > >
> > > > > [3] says:
> > > > >
> > > > > [ lib/Kconfig.debug ]
> > > > >
> > > > > config DEBUG_INFO_COMPRESSED
> > > > >         bool "Compressed debugging information"
> > > > >         depends on $(cc-option,-gz=3Dzlib)
> > > > >         depends on $(ld-option,--compress-debug-sections=3Dzlib)
> > > > >         help
> > > > >           Compress the debug information using zlib.  Requires GC=
C 5.0+ or Clang
> > > > >           5.0+, binutils 2.26+, and zlib.
> > > > >
> > > > >           Users of dpkg-deb via scripts/package/builddeb may find=
 an increase in
> > > > >           size of their debug .deb packages with this config set,=
 due to the
> > > > >           debug info being compressed with zlib, then the object =
files being
> > > > >           recompressed with a different compression scheme. But t=
his is still
> > > > >           preferable to setting $KDEB_COMPRESS to "none" which wo=
uld be even
> > > > >           larger.
> > > > >
> > > > > I am interested in the equivalent changes to cc-option/ld-option =
with ZSTD (usable with DWARFv5).
> > > >
> > > > Good idea.  It looks like there's still a blocker to using -gz=3Dzs=
td with clang:
> > > > $ clang -gz=3Dzstd -x c - < /dev/null
> > > > clang-16: warning: cannot compress debug sections (zstd not enabled=
)
> > > > [-Wdebug-compression-unavailable]
> > >
> > > PEBKAC
> > > $ sudo apt install libzstd-dev
> > > <rebuild clang>
> > >
> >
> > Hi Nick,
> >
> > Hehe, yes you need the ZSTD *-dev package on Debian.
> >
> > Interesting:
> >
> > "libzstd-dev: cmake file is unavailable"
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1020403
> >
> > Looks like Clang-16+ is needed as well.
> >
> > The WIP kernel patch looks promising.
> >
> > Please, let me know after your rebuild of clang if it works OK not
> > only compile-tested but also debug-info is OK.
>
> https://lore.kernel.org/lkml/20221020175655.1660864-1-ndesaulniers@google=
.com/
>

Thanks for the numbers and link to Fangrui Song's blog from September
(my chromium had that link saved).

-Sedat-

> >
> > -Sedat-
> >
> > > >
> > > > https://github.com/facebook/zstd/issues/3271
> > > >
> > > > Attaching a WIP patch.
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > Best regards,
> > > > > -Sedat-
> > > > >
> > > > > [1] https://github.com/llvm/llvm-project/commit/6fba7854a2f0b6b38=
99bb156c1a0c4ae35c96e24
> > > > > [2] https://github.com/llvm/llvm-project/commit/b4840279846e1eea4=
4c3dca575395a90c9d77ca0
> > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/lib/Kconfig.debug#n315
> > > > > [4] https://metadata.ftp-master.debian.org/changelogs//main/l/llv=
m-toolchain-15/llvm-toolchain-15_15.0.3-1~exp1_changelog
> > > > >
> > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
