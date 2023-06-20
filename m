Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4514473629F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFTETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjFTETl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E6E6C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 21:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24A060FAA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372EAC433C9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687234778;
        bh=NyGsLeW/FztEsf9dVsONe46AWBlbnmJSRV1nyDFVDmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SyYSgxyRvMQ8bpj+1tiIcMRWk9Q70jG/7TLqBfKKy3zECmTd3QV/+M7adHuWfbg5z
         HswzlZkElK3j8hqijaUg3Ant3XNG94VmIBvI7gEnLscldIiyESkU/2vW97lJfx6pW9
         SxSEI8ds3VW0pXcBTMlMC2jBZjnrZmPk+ONpMHyQCTyxE9PpzshdH+Y9yo0Knpkt9x
         +NlNo4ZmmOKQT4VUiAX6qfPMdu95kzDFiSRFMkvZlAytkmrkTpK1uxBNoyCiWllxUv
         E1N4G3G7CrmWVXbzHGP4rRuCm9CzTe/J4FboxWm9y+PwWvNDemNb8YVszXybGz+iwK
         ZP5I3S++JFuTw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-55e11f94817so2392466eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 21:19:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDyzuEtFVZ7UquRoxoCJgSuI8w/AFR8xSOtbOogBKAstqk9ZEzBn
        bzrJD28kLfPANYmfQlDk0WOSHUzwhF5ssTUo8Sw=
X-Google-Smtp-Source: ACHHUZ50dBIk80zRdS9T10z5yvKFkNOL2YvbT9WJB+0+jV9iiQvBtez20V9tVjAvd8EezQ0PGvBQj2XapoOMQguh5H0=
X-Received: by 2002:a4a:c607:0:b0:558:b793:f10c with SMTP id
 l7-20020a4ac607000000b00558b793f10cmr5116789ooq.3.1687234777440; Mon, 19 Jun
 2023 21:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=4hBcU4fAkddU0b-GOZc9FzTZoj3PFW6ZZrX0jS8x+bg@mail.gmail.com>
 <17c91d37-7d9c-0df4-2438-2b30ca0b5777@collabora.com> <CAKwvOdk4QO8x_bs64fFRCsMu__AjhXd4Ew2KfgzQOb9Q3FMqSA@mail.gmail.com>
 <b5d0cf82-0e42-f6a1-c9f5-c145fdc4c622@collabora.com> <CAKwvOdkFxu9hYSL_RCXadpR0dQd1+dZmAUVXdfFiLUfxg4D_Xw@mail.gmail.com>
 <878rdlk9bi.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOd=8LVU+iANkFx18Wm1jg7gYiAXovAmo9t5ZZaVdMULn-Q@mail.gmail.com>
 <875y8ok9b5.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdmJJibt6sHSp91v2s7BxUWBC6xG7F7+3C6gUxNMzZ2xRA@mail.gmail.com>
 <87353ok78h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <2023052247-bobtail-factsheet-d104@gregkh> <CAKwvOd=2zAV_mizvzLFdyHE_4OzBY5OVu6KLWuQPOMZK37vsmQ@mail.gmail.com>
 <cff33e12-3d80-7e62-1993-55411ccabc01@collabora.com> <CAKwvOd=F29-UkNO7FtUWpVV=POOZLb6QgD=mhLMWtRfkRSSi2A@mail.gmail.com>
 <a037a08c-44c4-24e8-1cba-7e4e8b21ffaa@collabora.com>
In-Reply-To: <a037a08c-44c4-24e8-1cba-7e4e8b21ffaa@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 13:19:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8Y9syCiHMO2r75D6hgCSsDDvJ_=VMKpYqjondnbSZjw@mail.gmail.com>
Message-ID: <CAK7LNAS8Y9syCiHMO2r75D6hgCSsDDvJ_=VMKpYqjondnbSZjw@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maksim Panchenko <maks@meta.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        denys.f@collabora.com, Nick Desaulniers <ndesaulniers@google.com>,
        kernelci@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 7:10=E2=80=AFPM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> Hi Masahiro,
>
>
> On 24/05/23 02:57, Nick Desaulniers wrote:
> > On Tue, May 23, 2023 at 3:27=E2=80=AFAM Shreeya Patel
> > <shreeya.patel@collabora.com> wrote:
> >> Hi Nick and Masahiro,
> >>
> >> On 23/05/23 01:22, Nick Desaulniers wrote:
> >>> On Mon, May 22, 2023 at 9:52=E2=80=AFAM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> >>>> On Mon, May 22, 2023 at 12:09:34PM +0200, Ricardo Ca=C3=B1uelo wrote=
:
> >>>>> On vie, may 19 2023 at 08:57:24, Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> >>>>>> It could be; if the link order was changed, it's possible that thi=
s
> >>>>>> target may be hitting something along the lines of:
> >>>>>> https://isocpp.org/wiki/faq/ctors#static-init-order i.e. the "stat=
ic
> >>>>>> initialization order fiasco"
> >>>>>>
> >>>>>> I'm struggling to think of how this appears in C codebases, but I
> >>>>>> swear years ago I had a discussion with GKH (maybe?) about this. I
> >>>>>> think I was playing with converting Kbuild to use Ninja rather tha=
n
> >>>>>> Make; the resulting kernel image wouldn't boot because I had modif=
ied
> >>>>>> the order the object files were linked in.  If you were to randoml=
y
> >>>>>> shuffle the object files in the kernel, I recall some hazard that =
may
> >>>>>> prevent boot.
> >>>>> I thought that was specifically a C++ problem? But then again, the
> >>>>> kernel docs explicitly say that the ordering of obj-y goals in kbui=
ld is
> >>>>> significant in some instances [1]:
> >>>> Yes, it matters, you can not change it.  If you do, systems will bre=
ak.
> >>>> It is the only way we have of properly ordering our init calls withi=
n
> >>>> the same "level".
> >>> Ah, right it was the initcall ordering. Thanks for the reminder.
> >>>
> >>> (There's a joke in there similar to the use of regexes to solve a
> >>> problem resulting in two new problems; initcalls have levels for
> >>> ordering, but we still have (unexpressed) dependencies between calls
> >>> of the same level; brittle!).
> >>>
> >>> +Maksim, since that might be relevant info for the BOLT+Kernel work.
> >>>
> >>> Ricardo,
> >>> https://elinux.org/images/e/e8/2020_ELCE_initcalls_myjosserand.pdf
> >>> mentions that there's a kernel command line param `initcall_debug`.
> >>> Perhaps that can be used to see if
> >>> 5750121ae7382ebac8d47ce6d68012d6cd1d7926 somehow changed initcall
> >>> ordering, resulting in a config that cannot boot?
> >>
> >> Here are the links to Lava jobs ran with initcall_debug added to the
> >> kernel command line.
> >>
> >> 1. Where regression happens (5750121ae7382ebac8d47ce6d68012d6cd1d7926)
> >> https://lava.collabora.dev/scheduler/job/10417706
> >> <https://lava.collabora.dev/scheduler/job/10417706>
> >>
> >> 2. With a revert of the commit 5750121ae7382ebac8d47ce6d68012d6cd1d792=
6
> >> https://lava.collabora.dev/scheduler/job/10418012
> >> <https://lava.collabora.dev/scheduler/job/10418012>
> > Thanks!
> >
> > Yeah, I can see a diff in the initcall ordering as a result of
> > commit 5750121ae738 ("kbuild: list sub-directories in ./Kbuild")
> >
> > https://gist.github.com/nickdesaulniers/c09db256e42ad06b90842a4bb85cc0f=
4
> >
> > Not just different orderings, but some initcalls seem unique to the
> > before vs. after, which is troubling. (example init_events and
> > init_fs_sysctls respectively)
> >
> > That isn't conclusive evidence that changes to initcall ordering are
> > to blame, but I suspect confirming that precisely to be very very time
> > consuming.
> >
> > Masahiro, what are your thoughts on reverting 5750121ae738? There are
> > conflicts in Kbuild and Makefile when reverting 5750121ae738 on
> > mainline.
>
> I'm not sure if you followed the conversation but we are still seeing
> this regression with the latest kernel builds and would like to know if
> you plan to revert 5750121ae738?


Reverting 5750121ae738 does not solve the issue
because the issue happens even before 5750121ae738.
multi_v7_defconfig + debug.config + CONFIG_MODULES=3Dn
fails to boot in the same way.

The revert would hide the issue on a particular build setup.


I submitted a patch to more pin-point the issue.
Let's see how it goes.
https://lore.kernel.org/lkml/ZJEni98knMMkU%2Fcl@buildd.core.avm.de/T/#t


(BTW, the initcall order is unrelated)





>
>
> Thanks,
> Shreeya Patel
>
> >>
> >> Thanks,
> >> Shreeya Patel
> >>
> >

--
Best Regards
Masahiro Yamada
