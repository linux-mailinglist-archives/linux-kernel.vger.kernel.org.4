Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5017633DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiKVNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiKVNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:44:02 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD95ADC9;
        Tue, 22 Nov 2022 05:43:44 -0800 (PST)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2AMDhMCE026379;
        Tue, 22 Nov 2022 22:43:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2AMDhMCE026379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669124603;
        bh=debR7Axr9vWzmGEzm6RKm0/7bq+bZwYlzS5EA+xN66M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bUlu+HyimqqSDVq6nFj7EWp9wBTWXMvIpMqWhrCkfImqMJrYebPtBAsgf4tiSkw01
         tCiiME9ocpfXhjpEBfvpasdcSAiFWpUd7lwYqvvMup7m99UWhaGCeUoAs8TWcEmHqY
         nyNc+Zb6teUuODyeKKaoiwAsaWLS7Am0J9Ji1Eu85pobvmZTDDkNSWIU2JDgh7YV/x
         FDyehDM/vRREOG6/cwgWKgMZmZmzojhMnvkSM+/TDQeFw0wnDTsTPXbRer8BwNERO1
         3cpSjyZ2N12Q6Q78367PCGoJv5m04QEtd1heocU4GaIbSFtyQsTVCx821nX6po1Yo+
         z+Cw+PoxI/Nxw==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-142306beb9aso17220389fac.11;
        Tue, 22 Nov 2022 05:43:22 -0800 (PST)
X-Gm-Message-State: ANoB5pkRS85Nz0TMTtGHD6/nPn24lnKkKX0BYke5NWmiJS6CJ65UGs4+
        mMts9+JNydsSGKCPT0TnRLmRwMydDLXI25Qv7C4=
X-Google-Smtp-Source: AA0mqf5G7XS07KWcTncFAOXKKft/Z+UfTElbwysGn6sMGNdL6nva2laIZJrm2jUDk5VCLVoUt8XZ9LLDasP5d3Q/ERE=
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id
 gh6-20020a0568703b0600b0013b5d72d2c6mr1940035oab.287.1669124601696; Tue, 22
 Nov 2022 05:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20221115110158.2207117-1-alexandre.belloni@bootlin.com> <Y3vSErWtH6L6GmMn@google.com>
In-Reply-To: <Y3vSErWtH6L6GmMn@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Nov 2022 22:42:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZzPVQtCfQFkBbieNVWSmxgCjkAKegw=1MizZVft0b7g@mail.gmail.com>
Message-ID: <CAK7LNATZzPVQtCfQFkBbieNVWSmxgCjkAKegw=1MizZVft0b7g@mail.gmail.com>
Subject: Re: [PATCH v2] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test
 with dash
To:     Sean Christopherson <seanjc@google.com>
Cc:     alexandre.belloni@bootlin.com, Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 4:31 AM Sean Christopherson <seanjc@google.com> wro=
te:
>
> +Masahiro and build, as I don't think this should go through the KVM tree=
 (which
> is also partly why no one has responded).


Presumably this was sent to the author and the commiter of
1aa0e8b144b6474c4914439d232d15bfe883636b

If Paolo does not pick this up, I can.


Now applied to linux-kbuild/fixes. Thanks.



> On a related topic, should init/Kconfig be added to the KCONFIG MAINTAINE=
RS entry?


No, I do not think so.

init/Kconfig contains a lot, which I am not responsible for.







> Or is there a better owner for this?
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 046ff06ff97f..ffff36e16b88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11040,6 +11040,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/masahiroy/linux-kbuild.git
>  F:     Documentation/kbuild/kconfig*
>  F:     scripts/Kconfig.include
>  F:     scripts/kconfig/
> +F:     init/Kconfig
>
>  KCOV
>  R:     Dmitry Vyukov <dvyukov@google.com>
>
> On Tue, Nov 15, 2022, alexandre.belloni@bootlin.com wrote:
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> > with a syntax error which is not the one we are looking for:
> >
> > <stdin>: In function =E2=80=98foo=E2=80=99:
> > <stdin>:1:29: warning: missing terminating " character
> > <stdin>:1:29: error: missing terminating " character
> > <stdin>:2:5: error: expected =E2=80=98:=E2=80=99 before =E2=80=98+=E2=
=80=99 token
> > <stdin>:2:7: warning: missing terminating " character
> > <stdin>:2:7: error: missing terminating " character
> > <stdin>:2:5: error: expected declaration or statement at end of input
> >
> > Removing '\n' solves this.
> >
> > Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs =
to workaround clang-13 bug")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  init/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 694f7c160c9c..13e93bcbc807 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -87,7 +87,7 @@ config CC_HAS_ASM_GOTO_OUTPUT
> >  config CC_HAS_ASM_GOTO_TIED_OUTPUT
> >       depends on CC_HAS_ASM_GOTO_OUTPUT
> >       # Detect buggy gcc and clang, fixed in gcc-11 clang-14.
> > -     def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[b=
ar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -=
c -o /dev/null)
> > +     def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[b=
ar]) - .": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c =
-o /dev/null)
>
> Tested a variety of compiler versions via godbolt, and the results are th=
e same
> for all cases, so with the caveat that I am far from a shell expert:
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>



--=20
Best Regards
Masahiro Yamada
