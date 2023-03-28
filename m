Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E326CB585
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC1Etz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjC1Etv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:49:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276A210D;
        Mon, 27 Mar 2023 21:49:40 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s20so11223621ljp.1;
        Mon, 27 Mar 2023 21:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679978978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pe8W/RK+hOyOkq9FFLRy1d0qcCv204a0d5Y+9iBByJM=;
        b=koBzlt9RwyHbY0OVDn07ocQF7z6Bht4ov6UxZYuxX7FdNlS9/tW6Go9GvM3WKN3PBW
         NaT0xbsxhV9XrrTcDPk7BQ+DrJDK+Sr4IFhLCLLyRkWK4U7ECBBpgC+01F0NXagInzAk
         rHLOUpihTefdiVEMvx/SdC+PdsO1bGbPXXAxcq4xPRiSHcrW1AXLnj8YJY4iFbsjpcbx
         eIkRAKuzJ9ydYLpZ3UypRzVIgiutx29maPuLogxfEBUjofigwYEf8PH3wgffRBruTRTU
         TdL4CMQ4h1+drLLDwZl4qDqkqSMmcrCIMSL+ztPrC8nst34aKNLVGb534EENCIEHSHLl
         pJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679978978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pe8W/RK+hOyOkq9FFLRy1d0qcCv204a0d5Y+9iBByJM=;
        b=qPFY1Wsdc8XryP4pjZJxJDq7CLspyvkudhnn1HLrVqGouHJSxv0gbQL4efZBAXhLmJ
         GwCCqhPehvSaxUTINTi0uzS7q7THiiikYQJEEqZUNmyyD2Pb4gVmYZxgxhnpqPcimUUP
         YYeW2EMJzikCIHBNGcwgu+vi6+F5jVAOz11INKUuMkWBUsqjGWTE7ZbcgOnlUFdwT4ja
         eBW9iI3jHc5s0kvm6cCuN8wItGn7EGfiNOi9UgyBUmRv7Z7V0O52PdiXRdaHgJGjukdM
         0ilfZgBTn7HzFHy3EoorwuOgtj3NPfe5AOIYiBCP6T8hXax4MpOh10sCcvEIo6vuNyB9
         7mVQ==
X-Gm-Message-State: AAQBX9fU3zibB2Pq8ayqyfTPVQ4vxiaT9yVGeoTKn41Dm5QEgqrQQWQ4
        M+cpuqLCICfcyk2m6d50LFqbWiSHSWKmVjaDQRuX6W4TMHpZbg==
X-Google-Smtp-Source: AKy350YQln6FRBHlZfiMVjcqK3xmShm08tV8rciTcVkcJ0o1S4Xu3ckIZiMn1ZpIb7pg1jvz1dhdi+sKmZz4jp8/f+g=
X-Received: by 2002:a05:651c:104d:b0:298:b32c:e4f0 with SMTP id
 x13-20020a05651c104d00b00298b32ce4f0mr4347140ljm.8.1679978977938; Mon, 27 Mar
 2023 21:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
 <642d6944-4488-4dc6-99e9-209849b9771c@infradead.org> <5946f189-c564-e196-a375-cb03edcacaa0@infradead.org>
In-Reply-To: <5946f189-c564-e196-a375-cb03edcacaa0@infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 28 Mar 2023 06:49:00 +0200
Message-ID: <CA+icZUXt2Q6k6b6tHVA_F6rjeUTPmMb9uCCz+rbDJ9UW2kq3=A@mail.gmail.com>
Subject: Re: Bug in recent changes to builddeb
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ron Economos <re@w6rz.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:52=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 3/27/23 15:41, Randy Dunlap wrote:
> > at least Cc linux-kbuild.
> >
>
> or just see https://patchwork.kernel.org/project/linux-kbuild/patch/3351f=
907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name/
>
> and use a later git tree.
>
> I.e., it's fixed now.
>
> > On 3/27/23 13:55, Ron Economos wrote:
> >> Looks like there's a bug in /scripts/package/builddeb. On lines 188, 1=
97 and 198, the variable $version is used. However, it's not defined (remov=
ed with recent changes).
> >>
> >> This causes the headers to be put into /usr/src/linux-headers-. When t=
he next version is attempted to be installed, the following error occurs.
> >>
> >> $ sudo dpkg -i linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
> >> Selecting previously unselected package linux-headers-6.3.0-rc4.
> >> (Reading database ... 376925 files and directories currently installed=
.)
> >> Preparing to unpack linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb ..=
.
> >> Unpacking linux-headers-6.3.0-rc4 (6.3.0-rc4-2) ...
> >> dpkg: error processing archive linux-headers-6.3.0-rc4_6.3.0-rc4-2_ris=
cv64.deb (--install):
> >>  trying to overwrite '/usr/src/linux-headers-/.config', which is also =
in package linux-headers-6.3.0-rc3 6.3.0-rc3-4
> >> dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
> >> Errors were encountered while processing:
> >>  linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
> >>
> >

Hi Masahiro,

when do you plan the next git-pull request to Linus?

For people using Debian and builddeb this is really annoying.

Thanks.

Regards,
-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.=
git/log/?h=3Dfixes
