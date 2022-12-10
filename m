Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6D6490D5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLJVch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 16:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 16:32:34 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5812AA9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:32:34 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jl24so8345068plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGPBSLAGBZBCVP34sPJd/8XZ4Ii7E2ChnSUHQld2rmM=;
        b=Sjue+JI9oLXZZPW/MIIMZIxDtT8iTmIf8ZfhxXuuXVezz5v524Uk4JdjaninOzTN9R
         8nqC4v2gAB92xl0bDpdGv8ElghM4Iv/gEXKTIo3zQIwGQQVhRmnXnP0HgQOudEP8CYNo
         TZ4mjFjB83xqoY9csEHxnYWDum4LIXKCzHtG17Ib0UwUtuUGCmmdaNONermO2ob6TV06
         fAYtktMHp5hSHIgXG8tIBHRacdFize9ILwB0IiZWVLobr7f5jfLk568mgjsSipbc7zwQ
         BwG2ON94/rKbGaVDUYnaLmGWDqtnOTVWjgyncFhoZ8DasYUFyaGq8T1I5TwpfY9UMaPT
         0KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGPBSLAGBZBCVP34sPJd/8XZ4Ii7E2ChnSUHQld2rmM=;
        b=jeVa+N6iYuFCFsUbmuHIQhwkv+ez9boNMzsGmiYThEl6a7ogFAHh4+goGaApFAtMzx
         /jTHOTvVLMf6xn+lXYTyTyXiuTdem2HzZTSr5n5KL8ex+V04vJWY+pJxFXPB3O0jgKGb
         O8JK0gayC0PEo2xXegENEXc7Ad78wH96yIjdIFhtEWnkul0DpNKp9dCbrPgycEUiwWlS
         DJlr50rm69+p+CTi18fe54jZSAu0bV2CGRR9NOC2Y80mczYL2xPSaVsRKwOAQuRncnR7
         uW6p0Ca0DAjc4UEiAVLyXR2VWeq057p3yFfiSM+ekS9i8vNgZVanFD+W/FnrLuEoI9Yg
         yG4w==
X-Gm-Message-State: ANoB5pnptp6FOnaiIFHRTG48dBRCPWCtAv7FSzWP0+0pHFJP0YQkUE4l
        kt3GJHhAyAxVZ5elCIr0+dq524uFWr30/A==
X-Google-Smtp-Source: AA0mqf4n16pB6ygS9gg5ByXjlO/PsSGFS3+HEHm6ZrGDRCnxDKBJLtTrWZ0rGdiRe6nvSRTBSzo2+g==
X-Received: by 2002:a17:902:ef93:b0:189:9031:6750 with SMTP id iz19-20020a170902ef9300b0018990316750mr2721701plb.5.1670707953514;
        Sat, 10 Dec 2022 13:32:33 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001837b19ebb8sm3381910plx.244.2022.12.10.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 13:32:32 -0800 (PST)
Date:   Sun, 11 Dec 2022 10:32:27 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/tags.sh: allow only selected directories to be
 indexed
Message-ID: <Y5T66yWNVAZNIaJ0@mail.google.com>
References: <Y5OKDvbGk4Kro6MK@mail.google.com>
 <CAHVum0ed2SSbxR_ayZw0D5x3KK7wzR8jr6DOqekBHv_noapcMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0ed2SSbxR_ayZw0D5x3KK7wzR8jr6DOqekBHv_noapcMw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 12:31:41PM -0800, Vipin Sharma wrote:
> On Fri, Dec 9, 2022 at 11:18 AM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > It's common for drivers that share same physical components to also
> > duplicate source code (or at least portions of it). A good example is
> > both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
> > file called atombios.h.
> >
> > While their contents aren't the same, a lot of their structs have
> > the exact same names which makes navigating through the code base a bit
> > messy as cscope will show up 'references' across drivers which aren't
> > exactly correct.
> >
> > This patch makes it possible for the devs to specify which folders
> > they want to include as part of the find_other_sources function if a
> > makefile variable OTHERSRCDIRS is present, otherwise the original
> > behaviour is kept.
> >
> > Example:
> >         make ARCH=x86 OTHERSRCDIRS=drivers/gpu/drm/radeon,tools cscope
> >
> 
> It is better to make the opposite option i.e. ignore directories. By
> default, cscope is all inclusive and it is more beneficial to have
> more code indexed than less. Default indexed
> directories will be different with and without OTHERSRCDIRS.
> 
> For example,
> 
> make ARCH=x86 cscope
> 
> # This includes all of the kernel code except non-x86 arch code.
> 
> make ARCH=x86 OTHERSRCSDIRS=drivers/gpu/drm/radeon/tools,tools cscope
> 
> # This includes only arch/x86, include/, tools/ and
> driver/gpu/drm/radeon/tools. It removes kernel/, block/, lib/,
> crypto/, virt/, etc. These are important kernel source code
> directories.
> 
> My vote is to make something like:
> make ARCH=x86 IGNOREDIRS=drivers/gpu/drm/amdgpu cscope
> 
> Parse IGNOREDIRS in the scripts/tags.sh and append to $ignore variable.
> 
> Also you should write this option in /Documentation/kbuild/kbuild.rst
> similar to ALLSOURCE_ARCHS
> 
> Thanks

Hi Vipin,

Thanks for taking the time to review this patch. I agree with you that
keeping cscope in its all inclusive approach is a better move. I will
make the requested changes and send a new patch.

Thanks!

- Paulo A.

> 
> 
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> >  scripts/tags.sh | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/tags.sh b/scripts/tags.sh
> > index e137cf15aae9..958c07c4ac4a 100755
> > --- a/scripts/tags.sh
> > +++ b/scripts/tags.sh
> > @@ -59,12 +59,17 @@ find_include_sources()
> >  }
> >
> >  # find sources in rest of tree
> > -# we could benefit from a list of dirs to search in here
> >  find_other_sources()
> >  {
> > -       find ${tree}* $ignore \
> > -            \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
> > -              -name "$1" -not -type l -print;
> > +       find_def_params="-name $1 -not -type l -print"
> > +       if [ -n "${OTHERSRCDIRS}" ]; then
> > +               exp_src_dirs=$(sed 's/,/ /g' <<< ${OTHERSRCDIRS})
> > +               find ${exp_src_dirs} ${ignore} ${find_def_params};
> > +       else
> > +               find ${tree}* ${ignore} \
> > +                    \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) \
> > +                    -prune -o ${find_def_params};
> > +       fi
> >  }
> >
> >  find_sources()
> > --
> > 2.38.1
> >
