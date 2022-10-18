Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A536034DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJRV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJRV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:26:32 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9D07FFAC;
        Tue, 18 Oct 2022 14:26:30 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 29ILPrgQ026111;
        Wed, 19 Oct 2022 06:25:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29ILPrgQ026111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666128354;
        bh=jwdFvUbmk3sXW78e0UcxZUeeQXON1eb/7xWdpvyqIA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WkZa6H6gWirZV5mik9OhX88ta9TTfgsVUNeV88kHoARkfVdA30Kyhz2I1aR9MJmDE
         EcI9RRcxxPqr0GyglvY2fgT0pjk4gMgHp9B7xZHvwIodkg8aOHagQe+CUgxQ3bmClU
         gEAYVQAVuhfxDdsejvUmEgdwrusvgNRlfVTPS7b0Ai9NlxBg+C+RGNc35vkFUQBSmA
         Sl5BaepmuURUg+yb/eEnZSaef7VOZNRFRg864eZFQBYwKn9RTLdrybNDAxqWFq0PRj
         3WIc2p0zNQ5zY7OML35/hAo95P/c06VxFjQuJY9RLW3OQO1EcRHhmwSrsIauAJa8j4
         y/fRhVDuuum6Q==
X-Nifty-SrcIP: [209.85.210.47]
Received: by mail-ot1-f47.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so8393031otu.7;
        Tue, 18 Oct 2022 14:25:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf2W/MxAt4MT980Vh1f/rgZEvY6B0JeiFsVbzZyuoHeRV7qqRdLb
        sBdYohR0HVrfFPJEPmJPrRjBgiBH9j88zTGaJY4=
X-Google-Smtp-Source: AMsMyM54UKAw/KvcMCpPIbPn/TMWGGQGyjE7BcP4xpHJvcQh3q+IKRKjAqO6+/osr0f4tp6m28P6c33rGHpukpWXauk=
X-Received: by 2002:a05:6830:6384:b0:661:bee5:73ce with SMTP id
 ch4-20020a056830638400b00661bee573cemr2315210otb.343.1666128353141; Tue, 18
 Oct 2022 14:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221017150113.334571-1-newbie13xd@gmail.com> <CAK7LNARsUE4j7LNYsushQaXFBEcnhhXoNg9THh2wLrYoi2jp9Q@mail.gmail.com>
 <7509e3c2-b3be-1330-bfa4-3ae16d049d70@gmail.com>
In-Reply-To: <7509e3c2-b3be-1330-bfa4-3ae16d049d70@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 19 Oct 2022 06:25:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjJ52hmGx2=hTFN0NJpcCFyY3aLAMjBChbRaRRVmxEsQ@mail.gmail.com>
Message-ID: <CAK7LNASjJ52hmGx2=hTFN0NJpcCFyY3aLAMjBChbRaRRVmxEsQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use POSIX-compatible grep option
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 4:23 PM Stefan Hansson <newbie13xd@gmail.com> wrote:
>
> Hi Masahiro,
>
> On 2022-10-17 23:31, Masahiro Yamada wrote:
> > On Tue, Oct 18, 2022 at 12:02 AM Stefan Hansson <newbie13xd@gmail.com> wrote:
> >>
> >> --file is a GNU extension to grep which is not available in all
> >> implementations (such as BusyBox). Use the -f option instead which is
> >> eqvuialent according to the GNU grep manpage[1] and is present in
> >> POSIX[2].
> >>
> >>   [1] https://www.gnu.org/software/grep/manual/grep.html
> >>   [2] https://pubs.opengroup.org/onlinepubs/9699919799/
> >
> >
> > This link does not show the spec of grep.
> >
> >
> > Did you mean this?
> >
> > https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
> >
> >
>
> Yes, sorry, that's a better link. I'm new to this. Do you want me to
> send a v2 with the commit message updated?

No worries.
I applied the patch with the link replaced.


Thanks.





> >
> >
> > Thanks.
> >
> >
> >
> >
> >
> >>
> >> Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
> >> ---
> >>   Makefile | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index c690361b393f..3513a6db66a2 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
> >>         cmd_ar_vmlinux.a = \
> >>          rm -f $@; \
> >>          $(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
> >> -       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
> >> +       $(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -Ff $(srctree)/scripts/head-object-list.txt)
> >>
> >>   targets += vmlinux.a
> >>   vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
> >> --
> >> 2.37.3
> >>
> >
> >



-- 
Best Regards
Masahiro Yamada
