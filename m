Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A306067A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJTSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJTSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:00:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E719C26
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:59:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 67so239256pfz.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTR7G6011dwhjWQaPnL56oG6S49NC/B2/ptmWAs/NpM=;
        b=fhzqUKORHYc8XFughkDj1bO0IC+I9b/00GCSSkkV/VxoLLkVTz/+oDaObhZFRUNHSu
         /fU8nVLvb4VwM0XbWDU9lePtmve6szeDkU6hOc7s37bJObem2MmqkJ99m8mhGbBgY6Pg
         0SHP/2cbssbwDxqBsveG50CHOjRLgneU5+pBx3kTJCfhxOdYbhl3ay5ZtR5gTLE/NYbJ
         2cIxMJu/IeqfbTrNdwT6mT/L8enstH0tfUmkjNLp/MF1+R1dopqI6hOMCQmMzmKovjrU
         Of2rcyE3j9RGAoJ+oxxABBNvf+aDtiaXqGSj7NtofU6YZ9ttRxfjnT9MWs202Rhaeca2
         RmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTR7G6011dwhjWQaPnL56oG6S49NC/B2/ptmWAs/NpM=;
        b=6Lk9D1tAK6vCiVg9EF4rJEfuyZz0j1X5Qu170c6xM0O5sTPbP7yWQMQyLMR7jfTpn1
         qtRjmdRmiSJiUb1guhNVo5nchPZi+unhcB2kliieb7TOz0MPg+xDKy/gksu4pK3rwyqs
         k5CLzDwBAKzfpFerJuyQ5aNwQC3BZQ8Cud9T7WmO7lN69Ib2srbnwPgCGewkY0QeS5Tk
         66bbUaIi/winvtIJ6LqE5a/5FkMwiJIlFXJfKafHQyKWKodMdxIfd8CO0MBXsALzmUeK
         qr0LZG8wGTz4C6du38JuiUKzVEGj7u1sv3p58cMY0+v6yCj7BX8/FwtkuKLq46psEMFa
         JLPQ==
X-Gm-Message-State: ACrzQf34IfhvJTJObDy/YIWMUq6YCH7dehNa5ap0dUCebGwl8h51N6DG
        3kmLndw83jOaS+Rg10/z+WwjfV4RAuFzoB4ZcZEsWw==
X-Google-Smtp-Source: AMsMyM7b0sWoGd7Wa1yIDbYm1koqrSi0oPmuuazEG9jKa0oBvUk6dUMsPA71Z58yx6PJUmIzsmFa/Azckz/Fp2QHeMc=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr14909799pfa.37.1666288755097; Thu, 20
 Oct 2022 10:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR03MB8319B83F92372CA86A42C089F3289@DU0PR03MB8319.eurprd03.prod.outlook.com>
 <CABCJKue6M4cXyTP9wgaBx0oZ+5K7sQna9UQF88Pxcknv-kzcMg@mail.gmail.com>
 <DU0PR03MB83196C180979F74ABEEB0562F32A9@DU0PR03MB8319.eurprd03.prod.outlook.com>
 <CAKwvOdncRqrTNqmiDhtkj74V4eU03FBgDr25H4+npwHYgrYQRw@mail.gmail.com>
 <CAKwvOd=7GZfdmtAG2W3Tjo1sPUA0eGnXFpUPWHp-3WJOgVpDEg@mail.gmail.com> <CA+icZUWKnw=eKZghzADQRse242dsx1WwGpF0hcSCUby_Wz7=QA@mail.gmail.com>
In-Reply-To: <CA+icZUWKnw=eKZghzADQRse242dsx1WwGpF0hcSCUby_Wz7=QA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Oct 2022 10:59:03 -0700
Message-ID: <CAKwvOdnZhtWCExXvTtEB05444CBCXoR1Mo=dq43Qvb8B-pJo=w@mail.gmail.com>
Subject: Re: Update15.x/kcfi to LLVM 15.0.3 (ZSTD + DWARFv5)
To:     sedat.dilek@gmail.com
Cc:     "Sedat Dilek (DHL Supply Chain)" <sedat.dilek@dhl.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Oct 20, 2022 at 7:18 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 9:56 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 10:44 PM Sedat Dilek (DHL Supply Chain)
> > > <sedat.dilek@dhl.com> wrote:
> > > >
> > > > -----Urspr=C3=BCngliche Nachricht-----
> > > > Von: Sami Tolvanen <samitolvanen@google.com>
> > > > Gesendet: Dienstag, 18. Oktober 2022 18:00
> > > > An: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> > > > Betreff: Re: Update15.x/kcfi to LLVM 15.0.3
> > > >
> > > > On Tue, Oct 18, 2022 at 4:54 AM Sedat Dilek (DHL Supply Chain) <sed=
at.dilek@dhl.com> wrote:
> > > > >
> > > > [ CC Nick + Fangrui ]
> > > >
> > > > You happen to know or use the ZSTD cmake-option (see [1] and [2]) -=
 came in with changes post-15.0.2?
> > > >
> > > > AFAICS Fangrui Song had some patches to use ZSTD debug-compression =
with DWARFv5.
> > > >
> > > > Unsure, if that combination is now possible in v15.0.3 or is a feat=
ure of LLVM-16.
> > > >
> > > > [3] says:
> > > >
> > > > [ lib/Kconfig.debug ]
> > > >
> > > > config DEBUG_INFO_COMPRESSED
> > > >         bool "Compressed debugging information"
> > > >         depends on $(cc-option,-gz=3Dzlib)
> > > >         depends on $(ld-option,--compress-debug-sections=3Dzlib)
> > > >         help
> > > >           Compress the debug information using zlib.  Requires GCC =
5.0+ or Clang
> > > >           5.0+, binutils 2.26+, and zlib.
> > > >
> > > >           Users of dpkg-deb via scripts/package/builddeb may find a=
n increase in
> > > >           size of their debug .deb packages with this config set, d=
ue to the
> > > >           debug info being compressed with zlib, then the object fi=
les being
> > > >           recompressed with a different compression scheme. But thi=
s is still
> > > >           preferable to setting $KDEB_COMPRESS to "none" which woul=
d be even
> > > >           larger.
> > > >
> > > > I am interested in the equivalent changes to cc-option/ld-option wi=
th ZSTD (usable with DWARFv5).
> > >
> > > Good idea.  It looks like there's still a blocker to using -gz=3Dzstd=
 with clang:
> > > $ clang -gz=3Dzstd -x c - < /dev/null
> > > clang-16: warning: cannot compress debug sections (zstd not enabled)
> > > [-Wdebug-compression-unavailable]
> >
> > PEBKAC
> > $ sudo apt install libzstd-dev
> > <rebuild clang>
> >
>
> Hi Nick,
>
> Hehe, yes you need the ZSTD *-dev package on Debian.
>
> Interesting:
>
> "libzstd-dev: cmake file is unavailable"
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1020403
>
> Looks like Clang-16+ is needed as well.
>
> The WIP kernel patch looks promising.
>
> Please, let me know after your rebuild of clang if it works OK not
> only compile-tested but also debug-info is OK.

https://lore.kernel.org/lkml/20221020175655.1660864-1-ndesaulniers@google.c=
om/

>
> -Sedat-
>
> > >
> > > https://github.com/facebook/zstd/issues/3271
> > >
> > > Attaching a WIP patch.
> > >
> > > >
> > > > Thanks.
> > > >
> > > > Best regards,
> > > > -Sedat-
> > > >
> > > > [1] https://github.com/llvm/llvm-project/commit/6fba7854a2f0b6b3899=
bb156c1a0c4ae35c96e24
> > > > [2] https://github.com/llvm/llvm-project/commit/b4840279846e1eea44c=
3dca575395a90c9d77ca0
> > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/lib/Kconfig.debug#n315
> > > > [4] https://metadata.ftp-master.debian.org/changelogs//main/l/llvm-=
toolchain-15/llvm-toolchain-15_15.0.3-1~exp1_changelog
> > > >
> > > >
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
