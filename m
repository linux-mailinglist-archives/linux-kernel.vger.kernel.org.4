Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003D6490A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLJUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:32:20 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27A13F42
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:32:18 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3b56782b3f6so95321947b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7drDR2C+s9EAbBhxqAEz7oVLjidWuTNPiPZLLtqWKJM=;
        b=art4fbcbZxiQPbvEneZhW+OaMPIyAwsjiQnpuf6DweGBa0gp4ien3MPaENuz9hxMRf
         LYmLrCH867vEo4BD2+B0NzUO32v5wVyKbTPa8wJhWe7wDeTwF/j8bedux7ft/LCrOP7W
         dZLyMTrjIUMJwwLWeKpR+6+QuTAfPr5klq8OvC4g28/t9UP3M5YsMEEDvj7KyR+9xrKr
         IhaS6hfGTWhbxh9Str/3mXKyqg4TokujWwYM5ObOjeZbt1Gtx6UJi71QcneBWvTN/7On
         Y8ZotjbKcG4cbVtaQOfwmW2Tt1asMZ3Ygcot//Fxf6SbDDeW0U0BEtaKRsids/ojMmEM
         xpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7drDR2C+s9EAbBhxqAEz7oVLjidWuTNPiPZLLtqWKJM=;
        b=uBjK7TIQVurdXczuTfc4EyMDq3sKtswgu0JS+yzoRuH+Mkuj+XHz/ZEjtQppsEWn9V
         N4wA//nk1rVF+s28CPT+NGuEvOc4e4lFlw3yW4et1GkLMX58D+mxSWHqrX7y/KXGOPyn
         hqVRFXB3htzNZmQoqrPsqQhJz01quJgoV6BPsTryPoEYES9aw5im9y2tc6AcMqtOVOat
         9fKyRQIyXZ/l+n4l1Zl+7AxplxV91yUQ02G0TapJjAzNhN+pu6x8VMj89LsztQpmE2e/
         HpZ27DnTMua809c9I3UFrKXBBA+Ihj0/j1Upo1qQDdPRCZwMdF8zyTLTei0gaAIfLqXi
         B0Ng==
X-Gm-Message-State: ANoB5plc64IEwdRThXgVbVfej8XYEpE5DUmSs5eG8xQFIRX0znRo5Cqo
        mQ7kliCoBhrVnLuhxI2P8TFohoe54GS6QGHGAGfDhKqSgYOo/CLu
X-Google-Smtp-Source: AA0mqf6qRWpxB2ID/9hVy0DAAVD40MEdkD8xFdqFKftaMvqPYWVG5UuOBOmCsyxmzFiAxnjEmBSFZKq+nBUxbVTDUKE=
X-Received: by 2002:a0d:dd8a:0:b0:391:c415:f872 with SMTP id
 g132-20020a0ddd8a000000b00391c415f872mr8270076ywe.318.1670704337607; Sat, 10
 Dec 2022 12:32:17 -0800 (PST)
MIME-Version: 1.0
References: <Y5OKDvbGk4Kro6MK@mail.google.com>
In-Reply-To: <Y5OKDvbGk4Kro6MK@mail.google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Sat, 10 Dec 2022 12:31:41 -0800
Message-ID: <CAHVum0ed2SSbxR_ayZw0D5x3KK7wzR8jr6DOqekBHv_noapcMw@mail.gmail.com>
Subject: Re: [PATCH] scripts/tags.sh: allow only selected directories to be indexed
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 9, 2022 at 11:18 AM Paulo Miguel Almeida
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
> they want to include as part of the find_other_sources function if a
> makefile variable OTHERSRCDIRS is present, otherwise the original
> behaviour is kept.
>
> Example:
>         make ARCH=x86 OTHERSRCDIRS=drivers/gpu/drm/radeon,tools cscope
>

It is better to make the opposite option i.e. ignore directories. By
default, cscope is all inclusive and it is more beneficial to have
more code indexed than less. Default indexed
directories will be different with and without OTHERSRCDIRS.

For example,

make ARCH=x86 cscope

# This includes all of the kernel code except non-x86 arch code.

make ARCH=x86 OTHERSRCSDIRS=drivers/gpu/drm/radeon/tools,tools cscope

# This includes only arch/x86, include/, tools/ and
driver/gpu/drm/radeon/tools. It removes kernel/, block/, lib/,
crypto/, virt/, etc. These are important kernel source code
directories.

My vote is to make something like:
make ARCH=x86 IGNOREDIRS=drivers/gpu/drm/amdgpu cscope

Parse IGNOREDIRS in the scripts/tags.sh and append to $ignore variable.

Also you should write this option in /Documentation/kbuild/kbuild.rst
similar to ALLSOURCE_ARCHS

Thanks


> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
>  scripts/tags.sh | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index e137cf15aae9..958c07c4ac4a 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -59,12 +59,17 @@ find_include_sources()
>  }
>
>  # find sources in rest of tree
> -# we could benefit from a list of dirs to search in here
>  find_other_sources()
>  {
> -       find ${tree}* $ignore \
> -            \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
> -              -name "$1" -not -type l -print;
> +       find_def_params="-name $1 -not -type l -print"
> +       if [ -n "${OTHERSRCDIRS}" ]; then
> +               exp_src_dirs=$(sed 's/,/ /g' <<< ${OTHERSRCDIRS})
> +               find ${exp_src_dirs} ${ignore} ${find_def_params};
> +       else
> +               find ${tree}* ${ignore} \
> +                    \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) \
> +                    -prune -o ${find_def_params};
> +       fi
>  }
>
>  find_sources()
> --
> 2.38.1
>
