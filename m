Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6BE744283
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjF3Srw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjF3Sr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:47:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13B3C34
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:47:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b1238a024so1653976a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688150842; x=1690742842;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDeUgk8u4frArpfMVDM55aE/xcXSay9wQzPSdheHYEA=;
        b=g9IPKSF0UQ1vFNaIem07DEhkl4m0lUJjPbUrP2177eRfDGX/u8dPqYnTmHDYMckCWC
         8s5+YawaKSJTH7qJ3J7hXEJbCi5FVCg+KukwrqfYJmPbUK4qLe6n6YUe8105hL48buA6
         MBZNIEGl0V25BtMZTeDYFHXOfoQFrJc2RcKkGd3sSri53zeq5KbHpbkjlsSJTczCbHi9
         vV6uKnR3jJFo14jMSpje8B7pWTu58VlbZeIR5UL90xDqFZT8IPQ5FxxEl7RC0/MX/aac
         BwjB2QS1DLXyMYvvkiOWZlWxOJj/d6TJkcRkPm5RLPA1EpHiEpL3JX2f8Mk8vVtBwCGb
         lIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150842; x=1690742842;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDeUgk8u4frArpfMVDM55aE/xcXSay9wQzPSdheHYEA=;
        b=ayV9l85W1tyHlZe1pOVJFpR/P9hjhC7ySnkpKU92PyApg17ig4WnKSvzIwl/Pv0/Cn
         55k0fWKw1TmmLHzy/XZBB06FMBQ8rY+8Mr25vuj1ocAbmuKlF8e86re6Llwa5ogP+LE9
         wmTZrTsmGiHvoctG+4QGgHBCoLAQ0lrVZ3T4qT4F54ZmbvHL9GfqXkUvc3qC7sARpWia
         /ukgpBbdZbAFB9nTnmHF/LmW5S96LG0JjUOTUi2Uq4p5eWsPZi4PXL6w7QELpQJJRgz+
         LZP9C+zfIsVBrvm14wg2sAWvZsy+mVwBR0gVXOV1v2zI4Uh14tUm0YUmOKlygUu1lh9q
         BNWw==
X-Gm-Message-State: AC+VfDzIKAY/LUq+8iLS66mRyEispgfXBA/WFbpWoFrEzIDPgBQDpeWg
        VAkBMuRlju3lWHpTZfnm6JchG0ReAFDk3glAzcM=
X-Google-Smtp-Source: ACHHUZ4xPTrBqSmUI0B2MxLjDx5UgVEfQBqv0zte5PY3szQ4Oagy9fKcFzSILPmAALNHi1CYib6bQA==
X-Received: by 2002:a05:6a20:3d89:b0:12c:9100:362f with SMTP id s9-20020a056a203d8900b0012c9100362fmr4200760pzi.4.1688150841660;
        Fri, 30 Jun 2023 11:47:21 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b00634dde2992bsm4165174pfh.132.2023.06.30.11.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:47:20 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:47:20 -0700 (PDT)
X-Google-Original-Date: Fri, 30 Jun 2023 11:46:35 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
In-Reply-To: <CAHk-=wgqQCAtA4cVev0g3A6RCD16s1p-_TAUeVkGE0_yS2ehyA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-784b868b-bc5c-44b4-ae82-3929f67ac5dc@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 09:46:39 PDT (-0700), Linus Torvalds wrote:
> On Fri, 30 Jun 2023 at 08:40, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> There's one merge conflict in MAINTAINERS
>
> Yes, but your suggested resolution is wrong. That "ACPI SERIAL ..."
> entry was moved downwards to be in the right place alphabetically, so
> the entry next to your new RISC-V entry actually needs to be removed.
>
> You seem to just have kept it, so your resolution caused a dup.

Ah, sorry -- I didn't look all that closely because it was just a 
MAINTAINERS update and I knew you just take these all as hints...

>
> The hint from git is the '++' at the beginning of the line:
>
>> ++ACPI SERIAL MULTI INSTANTIATE DRIVER
>> ++M:    Hans de Goede <hdegoede@redhat.com>
>> ++L:    platform-driver-x86@vger.kernel.org
>> ++S:    Maintained
>> ++F:    drivers/platform/x86/serial-multi-instantiate.c
>> ++
>
> which means that git thinks that your merge added those lines from
> thin air (ie they didn't exist in either parent).
>
> NOTE! A '++' line is not a sign of a mis-merge in general. It is
> *purely* a hint. It happens for perfectly fine merges when you either
> end up moving lines around enough that git doesn't see where they came
> from.
>
> Or, perhaps more commonly, when the merge conflict was due to both
> sides changing the same exact same code, and the merge resolution
> comes from neither one directly, but is new code that has combinations
> of both changes.
>
> Anyway, don't worry about it, I appreciate the heads-up regardless and
> I always do my own merge resolutions. I just decided to try to use

... and ya, I figured it was better to just send it anyway.

> this as a "this is how git works" moment.

Awesome, thanks.  I poke around the git merge resolution stuff, but I'm 
never 100% sure so I usually just look at the resulting output files and 
then just paste in whatever git says as a heads up ;)

> Basically, trivial merges where things were just added or removed next
> to each other will normally not result in "++" or "--" lines, so it
> can be a hint that something went wrong if you *thought* your merge
> was trivial, but git gives that kind of output for the end result.
>
> But don't think that "++" means "wrong". It really is just a sign that
> maybe the merge resolution needed a lot of care. And sometimes it's
> entirely a false positive - if git *really* understood merges 100%
> correctly all the time, we'd never need any manual conflict resolution
> at all ;)

OK, I think that makes sense.  Hopefully I can remember next time one 
comes up.

>
>                   Linus
