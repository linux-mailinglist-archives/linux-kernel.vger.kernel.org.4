Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387E6F4F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjECDTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECDTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:19:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC7AD;
        Tue,  2 May 2023 20:19:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso1099069a12.3;
        Tue, 02 May 2023 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683083984; x=1685675984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvdbKE2Dtsq8U1gEyTyqa6w0OBoKW/W9/QwTfH31tG8=;
        b=lR1n8LVn7cbEUHS0RkbnFkMML7LFiYXr+rd0ZDQ4CF++Z2ENHMMnSazaD7yIky39/y
         gGdltxDz2oecFDPSOS84N8vqQM4jHO8FIdGWvvRPr071t4tnbegSPl98LpAY4eERWY0+
         TsHPMdCH2LFJItSc/LsuFGxhr33Jwb9bU3RFQZDD7m1ACJCIzOdUjMrC6bhkBC0FeGl3
         C/YeLk+6Lp/IhN0jgBcDgbEpSM0FKQJfjwI8bcDF/o775NhOjNUIkFJi+QlUekEH6tIB
         ip316TjsBUicdIpx8z7f5jjj49i95Mp02WWu9hg/CR6LDpgH0FdBLzRVzNFpcnGTTU55
         8Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683083984; x=1685675984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvdbKE2Dtsq8U1gEyTyqa6w0OBoKW/W9/QwTfH31tG8=;
        b=XMp8a0bFr4RCYw1b790nastBC/m27XoN3mvnTmK5OhwoFcUw8oF8F89I3wW8ZbHDkp
         059n/ekcE9vCXpox2ugPOgvZaKsAyShhCBB9dt+qG+dlj1f5mR7r6TGUyY4SXUS4OxHj
         DqmuhG+EIlyKgmtMBginnisxgZrvHsNQIHDUXFl3dXKQpt7KsnodSXFFy5cdD2UqNtqI
         wfw8+PgOsHMxvFQxOtRALqB6Lp24H4SsDlwzP0pJkev5R2nYqcLEL0fRQiwg2B4jHU9g
         M3KnS40b3d65udEpjki0qjg5ZrnE++1SSOzxWthPDoUr7g3jl4F2FpOQv5zaKmS8+zX5
         WpSQ==
X-Gm-Message-State: AC+VfDw8YptkQTLtKOg7QKqLUAW+8MspTUYkXR2ukoHJiKWjWhqUn+82
        Zoest6CMWU8hDm6u4lzC40uAza1L9MxPPoITeio=
X-Google-Smtp-Source: ACHHUZ5lJAQu0znDrqojW97LLqgoHhayF3QoCCbg3NBoJzKPAqZCsZxuNLNiVUPisbgVkXRc0R9b4NytCHdTwy4CQIs=
X-Received: by 2002:a17:907:7b8f:b0:965:5d54:496d with SMTP id
 ne15-20020a1709077b8f00b009655d54496dmr762960ejc.45.1683083983880; Tue, 02
 May 2023 20:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230419043652.1773413-1-airlied@gmail.com> <ck2dzxvllhhh74oa3vjlacutc7rdmgl7cfrfq7vgx4w3jcufrz@7jbgxcat42yn>
 <CAPM=9tw0Y2A4DvuTHT_yd58Eit+tUmo63pbEOHwRJ66LeqznEQ@mail.gmail.com>
 <fsleccud43leoioli6bj4xoydwbdcjb5qr4denuf6morhgtqki@t6xya2mygon5>
 <ZEcJNcz+ArLfUSJ1@bombadil.infradead.org> <n6gwizwt26ucpuva2kt35rprth6iqeibi3inq2qrn5qhs3aa3b@4hjbhgnskutq>
In-Reply-To: <n6gwizwt26ucpuva2kt35rprth6iqeibi3inq2qrn5qhs3aa3b@4hjbhgnskutq>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 3 May 2023 13:19:31 +1000
Message-ID: <CAPM=9txLf2NbuZSM5CLYT4wA5mbQ=+ssm9tdzh6JJ=gtEBeqAA@mail.gmail.com>
Subject: Re: [PATCH] modules/firmware: add a new option to denote a firmware
 group to choose one.
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> >
> >> > the GROUP until after the FIRMWARE, so this can't work, as it already
> >> > will have included all the ones below, hence why I bracketed top and
> >> > bottom with a group.
> >>
> >> well... that is something that can be adapted easily by using a 2 pass
> >> approach, filtering out the list based on the groups.
> >>
> >> I agree that yours is simpler though.  If we can rely on the
> >> order produced by the compiler and we document the expectations of
> >> MODULE_FIRMWARE_GROUP_ONLY_ONE, then I believe we can stay with the
> >> simpler approach.
> >>
> >> Luis, any thoughts here?
> >
> >I see the Dracut code indicates that the order says now that you should
> >put the preferred firmware last, and that seems to match most coding
> >conventions, ie, new firmwares likely get added last, so it's a nice
>
> not all. i915 for example keeps it newest first so when attempting
> multiple firmware versions it starts from the preferred version.  It
> will be harder to convert since it also uses a x-macro to make sure the
> MODULE_FIRMWARE() and the the platform mapping are actually using the same
> firmware.
>
> >coincidence. Will this always work? I don't know. But if you like to
>
> short answer: it depends if your compiler is gcc *and* -O2 is used
> Longer debug ahead. Simple test with the expansion of MODULE_FIRMWARE
> baked in:
>
>         $ cat /tmp/a.c
>         static const __attribute__((section("__modinfo_manual"), used, aligned(1))) char foo[] = "modinfo_manual_foo";
>         static const __attribute__((section("__modinfo_manual"), used, aligned(1))) char bar[] = "modinfo_manual_bar";
>         $ gcc -c -o /tmp/a.o /tmp/a.c
>         $ objcopy -O binary --only-section=__modinfo_manual /tmp/a.o /tmp/modinfo_manual
>         $ strings /tmp/modinfo_manual
>         modinfo_manual_foo
>         modinfo_manual_bar
>
> However that doesn't match when building modules. In kmod:
>
> diff --git a/testsuite/module-playground/mod-simple.c b/testsuite/module-playground/mod-simple.c
> index 503e4d8..6dd5771 100644
> --- a/testsuite/module-playground/mod-simple.c
> +++ b/testsuite/module-playground/mod-simple.c
> @@ -30,3 +30,9 @@ module_exit(test_module_exit);
>
>   MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
>   MODULE_LICENSE("GPL");
> +
> +
> +static const char __UNIQUE_ID_firmware404[] __attribute__((__used__)) __attribute__((__section__("__modinfo_cpp"))) __attribute__((__aligned__(1))) = "modinfo_cpp_foo";
> +static const char __UNIQUE_ID_firmware405[] __attribute__((__used__)) __attribute__((__section__("__modinfo_cpp"))) __attribute__((__aligned__(1))) = "modinfo_cpp_bar";
>
>         $ make ....
>         $ objcopy -O binary --only-section=__modinfo_cpp testsuite/module-playground/mod-simple.ko /tmp/modinfo_cpp
>         $ strings /tmp/modinfo_cpp
>         modinfo_cpp_bar
>         modinfo_cpp_foo
>
> It doesn't seem to be ./scripts/Makefile.modfinal neither as it's also
> inverted in testsuite/module-playground/mod-simple.o
>
> After checking the options passed to gcc, here is the "culprit": -O2
>
>         $ gcc -c -o /tmp/a.o /tmp/a.c && objcopy -O binary --only-section=__modinfo_manual /tmp/a.o /tmp/modinfo_manual && strings /tmp/modinfo_manual
>         modinfo_manual_foo
>         modinfo_manual_bar
>         $ gcc -O2 -c -o /tmp/a.o /tmp/a.c && objcopy -O binary --only-section=__modinfo_manual /tmp/a.o /tmp/modinfo_manual && strings /tmp/modinfo_manual
>         modinfo_manual_bar
>         modinfo_manual_foo
>
> It seems anything but -O0 inverts the section.
>
>         $ gcc --version
>         gcc (GCC) 12.2.1 20230201
>
> It doesn't match the behavior described in its man page though. Manually
> specifying all the options that -O1 turns on doesn't invert it.
>
>         $ gcc -fauto-inc-dec -fbranch-count-reg -fcombine-stack-adjustments \
>                 -fcompare-elim -fcprop-registers -fdce -fdefer-pop -fdelayed-branch
>                 -fdse -fforward-propagate -fguess-branch-probability -fif-conversion \
>                 -fif-conversion2 -finline-functions-called-once -fipa-modref \
>                 -fipa-profile -fipa-pure-const -fipa-reference -fipa-reference-addressable \
>                 -fmerge-constants -fmove-loop-stores -fomit-frame-pointer -freorder-blocks \
>                 -fshrink-wrap -fshrink-wrap-separate -fsplit-wide-types -fssa-backprop \
>                 -fssa-phiopt -ftree-bit-ccp -ftree-ccp -ftree-ch -ftree-coalesce-vars \
>                 -ftree-copy-prop -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-forwprop \
>                 -ftree-fre -ftree-phiprop -ftree-pta -ftree-scev-cprop -ftree-sink -ftree-slsr \
>                 -ftree-sra -ftree-ter -funit-at-a-time -c -o /tmp/a.o /tmp/a.c \
>                 && objcopy -O binary --only-section=__modinfo_manual /tmp/a.o /tmp/modinfo_manual && strings /tmp/modinfo_manual
>         cc1: warning: this target machine does not have delayed branches
>         modinfo_manual_foo
>         modinfo_manual_bar
>

Thanks Lucas,

-ftoplevel-reorder is the one that does it, now that does mean how
I've done it isn't going to be robust.

I will reconsider but in order to keep backwards compat, it might be
easier to add firmware groups as an explicit list, but also spit out
the individual names, but not sure how clean this will end up on
dracut side.

I'll take a look at the other options, but it does seem like reworking
dracut is going to be the harder end of this, esp if I still want to
keep compat with older ones.

Dave.
