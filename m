Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DAA64A984
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiLLV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiLLV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:28:18 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1729FC1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:28:15 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3b10392c064so166222487b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjozKbUPp2aSy7H80qOc83Wx7QmZ8foKl3aEy6/ZtSU=;
        b=aDrhhFmvvBTmdmJGxUnEwEWAgqlgRJDCfh6CqevYvMpXDuusmx6aHiHlYPYu1HbZEp
         RpqRY8H9t36pDH0XWMsNAvJNtF5Zt/F2MbbgR8B0bhxkE1rIcqrkw4chdpIWRJ7b9+Ri
         +c4ZVW0xU2W02AQ5hLxH2bzjOtmacPBXhvltfYX57LN8Z9goC+3U0Nhk5y0uGsMQxp7q
         eJwxz/A/3kNAXsVJqvX3MSy6XFrOQs6VyYspR2eqnQfvN3cG+av+FOUPqqyhIFR8QL29
         csITXurmbAfKEcE7gydokmNy9cuv349+7cJwfKxnm72quB2/fhmN/Bq00Ze9A55B3Zt9
         mHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjozKbUPp2aSy7H80qOc83Wx7QmZ8foKl3aEy6/ZtSU=;
        b=Ps90lLyqL5+1zWN07pABHsQr32yPGjCFPlHQOmuNAwEkAmfiUDgY7jg7Pwq1PfbvE7
         B1h93s1yV1HFCHEW/RbmsNQ9qzHMCJ93+smPWrmyBYzE+02lk0AAf2gD8dENzgnvrk5O
         3JRAIk9BTmaiyd34Wn4iruuw4oTOITwm+bfdzknJ2weWsuQiAhfSr4sZrxt8gisT/7dn
         bGiiDncL1QkQdASF8hSfkG5SH7Y5Tuj5X61RrZC+tyASTyJi4EtCs5kBvIG9he5uhJ5b
         wgEcS1vzazE7sKbJ9rrLYEj8RlltKN4xSKbmitob2ZLtHZ9Z9FzQz91ntzYTtMI4XmQK
         cy8w==
X-Gm-Message-State: ANoB5pmhJyecnzvvBcZ3mv2m342AjU6dye0obGuoBmE1nhwCA2Ru6A4H
        mdUznqFKcRJxhC8CVesT/Whi+J2xH5AFJUE4C39Qpw==
X-Google-Smtp-Source: AA0mqf6khbUWi9FVmzVgGsmHTliSQ/NEmQiq9QEXBSyOKr90cObsr0i+iRwcKQwf7gNtS6NCoVevpDkgAon+4KdANvk=
X-Received: by 2002:a0d:dd8a:0:b0:391:c415:f872 with SMTP id
 g132-20020a0ddd8a000000b00391c415f872mr9059013ywe.318.1670880493965; Mon, 12
 Dec 2022 13:28:13 -0800 (PST)
MIME-Version: 1.0
References: <Y5T66yWNVAZNIaJ0@mail.google.com> <Y5UP+tnnxNgoi6A2@mail.google.com>
In-Reply-To: <Y5UP+tnnxNgoi6A2@mail.google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 12 Dec 2022 13:27:37 -0800
Message-ID: <CAHVum0eOzd8MgP0FGObHWvqG_oPVoTmk_5gkEB0sAJK9JgCsFg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/tags.sh: choose which directories to exclude
 from being indexed
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 3:02 PM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> It's common for drivers that share same physical components to also
> duplicate source code (or at least portions of it). A good example is
> both drivers/gpu/drm/amdgpu/* and drivers/gpu/drm/radeon/* have a header
> file called atombios.h.
>
> While their contents aren't the same, a lot of their structs have
> the exact same names which makes navigating through the code base a bit
> messy as cscope will show up 'references' across drivers which aren't
> exactly correct.
>
> This patch makes it possible for the devs to specify which folders
> they don't want to include into database as part of the
> find_other_sources func if a makefile variable IGNOREDIRS is present,
> otherwise the original behaviour is kept.
>
> Example:
>         make ARCH=x86 IGNOREDIRS=drivers/gpu/drm/radeon,tools cscope
>
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> Changelog:
>
> - v2: change approach to include everything unless specified by the
>   IGNOREDIRS variable: (Req: Vipin Sharma)
> - v1: https://lore.kernel.org/lkml/Y5OKDvbGk4Kro6MK@mail.google.com/
> ---
>  Documentation/kbuild/kbuild.rst |  7 +++++++
>  scripts/tags.sh                 | 11 +++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 08f575e6236c..5f99f30e20d8 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -278,6 +278,13 @@ To get all available archs you can also specify all. E.g.::
>
>      $ make ALLSOURCE_ARCHS=all tags
>
> +IGNOREDIRS
> +---------------
> +For tags/TAGS/cscope targets, you can choose which directories won't
> +be included in the databases, separated by comma. E.g.:
> +
> +    $ make IGNOREDIRS=drivers/gpu/drm/radeon,tools cscope
> +
>  KBUILD_BUILD_TIMESTAMP
>  ----------------------
>  Setting this to a date string overrides the timestamp used in the
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index e137cf15aae9..554721e9cad2 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -59,10 +59,17 @@ find_include_sources()
>  }
>
>  # find sources in rest of tree
> -# we could benefit from a list of dirs to search in here
>  find_other_sources()
>  {
> -       find ${tree}* $ignore \
> +       local loc_ignore=${ignore}
> +       if [ -n "${IGNOREDIRS}" ]; then
> +               exp_ignored_dirs=$(sed 's/,/ /g' <<< ${IGNOREDIRS})
> +               for i in ${exp_ignored_dirs}; do
> +                       loc_ignore="${loc_ignore} ( -path $i ) -prune -o"
> +               done
> +       fi
> +

This should be global overwrite instead of just in this function.
Before find_other_sources() is executed, this script finds files in
arch directories. So, if you keep it local then those files cannot be
excluded which makes execution of the command incorrect:

make IGNOREDIRS=arch/x86 cscope

Above command will still index all of the code in arch/x86. Something
like this will be better.

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -17,6 +17,13 @@ ignore="$(echo "$RCS_FIND_IGNORE" | sed 's|\\||g' )"
 # tags and cscope files should also ignore MODVERSION *.mod.c files
 ignore="$ignore ( -name *.mod.c ) -prune -o"

+if [ -n "${IGNOREDIRS}" ]; then
+       exp_ignored_dirs=$(sed 's/,/ /g' <<< ${IGNOREDIRS})
+       for i in ${exp_ignored_dirs}; do
+               ignore="${ignore} ( -path $i ) -prune -o"
+       done
+fi
+
 # Use make KBUILD_ABS_SRCTREE=1 {tags|cscope}
 # to force full paths for a non-O= build
 if [ "${srctree}" = "." -o -z "${srctree}" ]; then
@@ -62,9 +69,9 @@ find_include_sources()
 # we could benefit from a list of dirs to search in here
 find_other_sources()
 {
-       find ${tree}* $ignore \
-            \( -path ${tree}include -o -path ${tree}arch -o -name
'.tmp_*' \) -prune -o \
-              -name "$1" -not -type l -print;
+       find ${tree}* ${ignore} \
+               \( -path ${tree}include -o -path ${tree}arch -o -name
'.tmp_*' \) -prune -o \
+               -name "$1" -not -type l -print;
 }

We will still have to specify arch/x86 and arch/x86/include but this
works and keeps the definition of IGNOREDIRS relatively correct.


> +       find ${tree}* ${loc_ignore} \
>              \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
>                -name "$1" -not -type l -print;
>  }
> --
> 2.38.1
>
