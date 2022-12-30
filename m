Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89406659455
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 04:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiL3DJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 22:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3DJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 22:09:37 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0D11A1F;
        Thu, 29 Dec 2022 19:09:35 -0800 (PST)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2BU398UJ023536;
        Fri, 30 Dec 2022 12:09:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2BU398UJ023536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672369749;
        bh=TwSK/YTGRNFZNCD09DtAb/IuCcZC4pESJUPfPCOaUdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kj7eUvcz07L1cJqBezGR2dI6IqEV+qQG37TwgQAcQF9iGn1giQvHZLbth7hj7x9+0
         8CnbIxONbgylsq1aQ9ltDHbWYHd3r4+RA9PmVPdxAncNn1xZZ6IkGn+k/OfpY1c+tT
         QbCBHDWqie4kZxO98fo7qXz8OrjE+Pzsp9H54nMpRjAH0SsJEp5f+SHHJdybyk/WZm
         iz5NUsVaP4OnOkodXHewF66vDiaHhS6ned+Fc4NJ7QCgp5A5ERVAsN7iYII3v7r//i
         5jz/fCzHz8aDfRXCBgHlcJy3s5RWCneZaYnIXHU2L1HV+FqLwiZ5DaOQuY8TsMH9ol
         SCx0ZkoqdRB5Q==
X-Nifty-SrcIP: [209.85.160.48]
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1447c7aa004so23588478fac.11;
        Thu, 29 Dec 2022 19:09:09 -0800 (PST)
X-Gm-Message-State: AFqh2koaXiqD/Eblq0V7ephpFdFPagxT9ze/+WKq1zwRJZpPv3TXOSKa
        2LyGy6PLZY2EDKfa+lsWAhgTMVmfA0Xi0o6hnGM=
X-Google-Smtp-Source: AMrXdXtm0xaZNHSAhj1QT6ARzFlNHOO/JMitfouFijNPedUgQ2TcsLJ4ExlYxUh2YldSdXEjwB36vLLkGQgk7xB6Yxo=
X-Received: by 2002:a05:6870:cc89:b0:150:39e2:c688 with SMTP id
 ot9-20020a056870cc8900b0015039e2c688mr476912oab.287.1672369747959; Thu, 29
 Dec 2022 19:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20221229184650.1107463-1-masahiroy@kernel.org> <Y63uw1HGiL5ZxJkk@fjasle.eu>
In-Reply-To: <Y63uw1HGiL5ZxJkk@fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Dec 2022 12:08:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLBQu=0rMhH2iOwoNpUMA-4BH4-XeiedZSccRU9hxFCg@mail.gmail.com>
Message-ID: <CAK7LNATLBQu=0rMhH2iOwoNpUMA-4BH4-XeiedZSccRU9hxFCg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: unify cmd_dt_S_dtb and cmd_dt_S_dtbo
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 4:47 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Fri, Dec 30, 2022 at 03:46:50AM +0900 Masahiro Yamada wrote:
> > cmd_dt_S_dtb and cmd_dt_S_dtbo are almost the same; the only differnce
> > is the prefix of the bein/end symbols. (__dtb vs __dtbo)
>
> Two letters got lost: differ_e_nce, be_g_in.

Ah, thanks. I will fix it.


>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/Makefile.lib | 45 +++++++++++++++-----------------------------
> >  1 file changed, 15 insertions(+), 30 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 4a4a5f67c1a6..100a386fcd71 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -368,40 +368,25 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
> >  DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
> >
> >  # Generate an assembly file to wrap the output of the device tree compiler
> > -quiet_cmd_dt_S_dtb= DTBS    $@
> > -cmd_dt_S_dtb=                                                \
> > -{                                                    \
> > -     echo '\#include <asm-generic/vmlinux.lds.h>';   \
> > -     echo '.section .dtb.init.rodata,"a"';           \
> > -     echo '.balign STRUCT_ALIGNMENT';                \
> > -     echo '.global __dtb_$(subst -,_,$(*F))_begin';  \
> > -     echo '__dtb_$(subst -,_,$(*F))_begin:';         \
> > -     echo '.incbin "$<" ';                           \
> > -     echo '__dtb_$(subst -,_,$(*F))_end:';           \
> > -     echo '.global __dtb_$(subst -,_,$(*F))_end';    \
> > -     echo '.balign STRUCT_ALIGNMENT';                \
> > -} > $@
> > +quiet_cmd_wrap_S_dtb = WRAP    $@
> > +      cmd_wrap_S_dtb = {                                                             \
> > +             symbase=__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));      \
>
> As long as I know, '$(notdir $*)' should be equivalent to '$(*F)'.  Is it just
> personal preference or is there some other reason for choosing one or the
> other?

Your understanding is correct.
Automatic variables can have 'D' / 'F', as explained in the manual.
https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html


Yes, it is just my personal preference.
Perhaps, I did not need to change it, though.






> Nevertheless, with the typos fixed, it looks good to me:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>


-- 
Best Regards
Masahiro Yamada
