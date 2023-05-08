Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6606F9F04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjEHF06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEHF04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBD525B;
        Sun,  7 May 2023 22:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC3761E82;
        Mon,  8 May 2023 05:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ADFC4339B;
        Mon,  8 May 2023 05:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683523614;
        bh=I8Vtnbk71cpCQ1gWhDeCHyHdySfH1lmtP1KJyo1/G7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=afVxbwRKkQ0sZechYGOL41fsmBU8wlYoN1AoaWQmC63GyYX9ICJ2SZauW29GtqVEs
         FdPOTgjH2dp6H39eM+zwVjUCHBTy37mlEErMqVaDqDM7rV83Uo8tseoqO6j4/E/5mp
         Pp4dQvlFHoBBKGoKMLvpMAuoJuTiq1iOaOuizzxVPq5f3Na/y+0sS3u68W33y4Ybhb
         WDMnbHiyRKWET5JXMmUzWksqxJH4jolU5lcJISnqElOUUjTxuboAlqN/Cx01aTwT4n
         aESIevhAWAwdHy89qiwkC+rHFhFdS5AQqT8K5CnfpR1jjrbRqXPfURb4LEleXLK6eE
         YM99nd3RMjzTw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38e3228d120so1955055b6e.3;
        Sun, 07 May 2023 22:26:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDyyoyeX4SDEl4fgIq8+9acgpwLktkTVGDctOPX3nSf/bfvsx9Ae
        j59brw7XN3VuVyhfnQGZDiVoK4SBzbN9deHT9lU=
X-Google-Smtp-Source: ACHHUZ7y9DMSkYJuu3hlNaPuR++o+sR9Vrm0YlPJQFhUKVggSaC4rMTF2WMvdAw+FRmxda0gnWmFqHiflbi4yCBSSA0=
X-Received: by 2002:a54:408e:0:b0:38d:ec3f:311a with SMTP id
 i14-20020a54408e000000b0038dec3f311amr4388206oii.2.1683523613719; Sun, 07 May
 2023 22:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <db732251-b6fe-c2c5-a0db-bac77dc84314@gmail.com>
In-Reply-To: <db732251-b6fe-c2c5-a0db-bac77dc84314@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 8 May 2023 14:26:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5VsFxvJ+Ac1TgraBrFK53N2qsZ4Jd88GMx4oTNWid9g@mail.gmail.com>
Message-ID: <CAK7LNAQ5VsFxvJ+Ac1TgraBrFK53N2qsZ4Jd88GMx4oTNWid9g@mail.gmail.com>
Subject: Re: syntax error in prepare target of main Makefile
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 10:29=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Hi,
>
> I notice a year old bug in bugzilla [1]. As many developers don't
> take a look on it, I decided to forward the bug by mail. And
> to reach the reporter, you must log in to bugzilla.

I believe it was already fixed.

See the bug tracker in the ELRepo.

https://elrepo.org/bugs/view.php?id=3D1215

It was a bug in ELRepo (and Fedora as well).



Masahiro









>
> Quoting from the bug report:
>
> >  Christian 2022-04-08 10:44:17 UTC
> >
> > Symptom:
> >
> > make[2]: Entering directory '/usr/src/kernels/5.17.1-1.el8.elrepo.x86_6=
4'
> > Makefile:729: target 'include/config/auto.conf' does not exist
> > test -e include/generated/autoconf.h -a -e include/config/auto.conf || =
(                \
> > echo >&2;                                                       \
> > echo >&2 "  ERROR: Kernel configuration is invalid.";           \
> > echo >&2 "         include/generated/autoconf.h or include/config/auto.=
conf are missing.";\
> > echo >&2 "         Run 'make oldconfig && make prepare' on kernel src t=
o fix it.";      \
> > echo >&2 ;                                                      \
> > /bin/false)
> > Makefile:1717: target 'prepare' does not exist
> > if [ "gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)" !=3D ""gcc (GCC) 8.5.=
0 20210514 (Red Hat 8.5.0-4)"" ]; then \
> >         echo >&2 "warning: the compiler differs from the one used to bu=
ild the kernel"; \
> >         echo >&2 "  The kernel was built by: "gcc (GCC) 8.5.0 20210514 =
(Red Hat 8.5.0-4)""; \
> >         echo >&2 "  You are using:           gcc (GCC) 8.5.0 20210514 (=
Red Hat 8.5.0-4)"; \
> > fi
> > /bin/sh: -c: line 0: syntax error near unexpected token `('
> > /bin/sh: -c: line 0: `if [ "gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)"=
 !=3D ""gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)"" ]; then \'
> > make[2]: *** [Makefile:1717: prepare] Error 1
> > make[2]: Leaving directory '/usr/src/kernels/5.17.1-1.el8.elrepo.x86_64=
'
> >
> >
> > Note the double double-quotes in the GCC Version comparison !
> >
> > This happens to me when I try to compile vmware kernel modules with mai=
nline kernel from elrepo on AlamLinux8.
> >
> > Since it is coming from the Makefile of the Kernel, I suppose this is t=
he proper upstream tracker to be used. Please advise if not.
> >
> >
> > This is the potion of the Makefile that fails (line 1717..) :
> > prepare:
> >       @if [ "$(CC_VERSION_TEXT)" !=3D "$(CONFIG_CC_VERSION_TEXT)" ]; th=
en \
> >               echo >&2 "warning: the compiler differs from the one used=
 to build the kernel"; \
> >               echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_=
TEXT)"; \
> >               echo >&2 "  You are using:           $(CC_VERSION_TEXT)";=
 \
> >       fi
> >
> >
> >
> > I don't know where CONFIG_CC_VERSION_TEXT is defined. Which apparently =
contains "...", but shouldn't.
> >
> >
>
> To the reporter: It is helpful to try compiling your third-party modules
> against latest mainline kernel.
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D215820
>
> --
> An old man doll... just what I always wanted! - Clara



--=20
Best Regards
Masahiro Yamada
