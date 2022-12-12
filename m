Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFA64A9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiLLV7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:59:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EFF00C;
        Mon, 12 Dec 2022 13:59:38 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w26so888673pfj.6;
        Mon, 12 Dec 2022 13:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK4SV6NkB34Nd0jY+lQbTZ0YENS79sF0MPE5gSY6Nxc=;
        b=PpzQBpEIFUT2yuN3ykZw0JuYT/0Y4nFUtXhikD8qJ2NG9H9Wa0h3NqMCt/gpVpw5XO
         v89g51e3u2rDMJOGrvIFjRZC2xnlOX6RPP4YC06y1ezAz4f4E6NX1vfrdPm9U1BPjoGv
         70aHTSmspquNulhco5CT5UwcegBP2frGD7l0cdlEjQRm2vWUO6JqDIXaCK6yeSLTICTv
         Mke59sbsBVIHAiN/5cAfgvbSfUdPX17nKhC2lirCOReKsbeJFNywyrqA/JL5jSm1lW+z
         h88/lqltCBUVBK/M13QCQlFpfs/mgTQYx99HBneeX3F2tx5wj/SiSBu2pJAGYR3Xrc9X
         KwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK4SV6NkB34Nd0jY+lQbTZ0YENS79sF0MPE5gSY6Nxc=;
        b=uggh9/edFi+xutlFbSwJvmoulofMdBTuCPcGS7JDAg4CxhFuNBNwAEQGoEZiO57aPh
         /m2CjMy3ysn3ZVnYbkzT1cO5tNKl+tfjfSLdwSykzEq4+ut07thl9TfrhLFp+bAjGAZY
         0+gdOIWure5F5HGmdci46RfGSV05/fCHxqdVyS+CbVTW6yOrHMo+z4hGD8gHL2Emshvf
         jObT0miqYEn8dqKkujePQlYsPXh8fJ+b7zRQKNRdHLLo+bIh7YD40HcG+VXxxrNbdxri
         1+ggIcfXP486Nu7YDFr5SWGWQBi+GqNpWwhm4yPu9/HkYSN635amr759SN4a3OVEZPQC
         LErA==
X-Gm-Message-State: ANoB5pncdvC+0iTePfwoWuebj4FU5IV2ePRxTdDGVcHJWTxR5iZjAuXX
        cKPDmz6Xickhi10zBaM9nhY=
X-Google-Smtp-Source: AA0mqf4EqnUK1aJNjod0NjMJrF+DR5VLozBbXSEOUvqLhaWdRO6cuXVIXwiZU+D2WSRaYZh19Boa5A==
X-Received: by 2002:a62:6586:0:b0:56d:a2bf:891e with SMTP id z128-20020a626586000000b0056da2bf891emr4049714pfb.3.1670882377780;
        Mon, 12 Dec 2022 13:59:37 -0800 (PST)
Received: from mail.google.com ([103.229.249.253])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79acc000000b0057725613627sm6457112pfp.142.2022.12.12.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:59:37 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:59:29 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tags.sh: choose which directories to exclude
 from being indexed
Message-ID: <Y5ekQcJeoHd1i+Um@mail.google.com>
References: <Y5T66yWNVAZNIaJ0@mail.google.com>
 <Y5UP+tnnxNgoi6A2@mail.google.com>
 <CAHVum0eOzd8MgP0FGObHWvqG_oPVoTmk_5gkEB0sAJK9JgCsFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0eOzd8MgP0FGObHWvqG_oPVoTmk_5gkEB0sAJK9JgCsFg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 01:27:37PM -0800, Vipin Sharma wrote:
> On Sat, Dec 10, 2022 at 3:02 PM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >  # find sources in rest of tree
> > -# we could benefit from a list of dirs to search in here
> >  find_other_sources()
> >  {
> > -       find ${tree}* $ignore \
> > +       local loc_ignore=${ignore}
> > +       if [ -n "${IGNOREDIRS}" ]; then
> > +               exp_ignored_dirs=$(sed 's/,/ /g' <<< ${IGNOREDIRS})
> > +               for i in ${exp_ignored_dirs}; do
> > +                       loc_ignore="${loc_ignore} ( -path $i ) -prune -o"
> > +               done
> > +       fi
> > +
> 
> This should be global overwrite instead of just in this function.
> Before find_other_sources() is executed, this script finds files in
> arch directories. So, if you keep it local then those files cannot be
> excluded which makes execution of the command incorrect:
> 
> make IGNOREDIRS=arch/x86 cscope
> 

Hi Vipin, thanks for taking the time to review this patch.

I see where you are coming from. I was aware of the 'loophole' that the
current approach could have but, to be honest, I thought that there
would be very little use in being able to exclude arch/.*?/ files.

The reason for that being that I thought the most common usage for this
feature would be to ignore folders within subsystems like drivers and
tools to ensure code navigation would be less 'messy'.

Additionally, if we go with the global IGNOREDIRS approach you just
described, we could have some conflicting options too such as:

make ALLSOURCE_ARCHS="x86 arm" IGNOREDIRS=arch/x86 cscope

My 2 cents is that ALLSOURCE_ARCHS is already the mechanism for
excluding archs so it's 'okay' to keep IGNOREDIRS as is.

Let me know your thoughts.

Thanks!

- Paulo A.

> Above command will still index all of the code in arch/x86. Something
> like this will be better.
> 
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -17,6 +17,13 @@ ignore="$(echo "$RCS_FIND_IGNORE" | sed 's|\\||g' )"
>  # tags and cscope files should also ignore MODVERSION *.mod.c files
>  ignore="$ignore ( -name *.mod.c ) -prune -o"
> 
> +if [ -n "${IGNOREDIRS}" ]; then
> +       exp_ignored_dirs=$(sed 's/,/ /g' <<< ${IGNOREDIRS})
> +       for i in ${exp_ignored_dirs}; do
> +               ignore="${ignore} ( -path $i ) -prune -o"
> +       done
> +fi
> +
>  # Use make KBUILD_ABS_SRCTREE=1 {tags|cscope}
>  # to force full paths for a non-O= build
>  if [ "${srctree}" = "." -o -z "${srctree}" ]; then
> @@ -62,9 +69,9 @@ find_include_sources()
>  # we could benefit from a list of dirs to search in here
>  find_other_sources()
>  {
> -       find ${tree}* $ignore \
> -            \( -path ${tree}include -o -path ${tree}arch -o -name
> '.tmp_*' \) -prune -o \
> -              -name "$1" -not -type l -print;
> +       find ${tree}* ${ignore} \
> +               \( -path ${tree}include -o -path ${tree}arch -o -name
> '.tmp_*' \) -prune -o \
> +               -name "$1" -not -type l -print;
>  }
> 
> We will still have to specify arch/x86 and arch/x86/include but this
> works and keeps the definition of IGNOREDIRS relatively correct.
> 
> 
> > +       find ${tree}* ${loc_ignore} \
> >              \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
> >                -name "$1" -not -type l -print;
> >  }
> > --
> > 2.38.1
> >
