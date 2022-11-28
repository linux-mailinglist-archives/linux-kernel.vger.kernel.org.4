Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679BE63AA46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiK1N7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiK1N7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:59:17 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C80DA4;
        Mon, 28 Nov 2022 05:59:17 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id x18so7222787qki.4;
        Mon, 28 Nov 2022 05:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0zTEKDX0VhiLo8/RmLm+g9EPehQ6o7qAmHvISgsBhk=;
        b=3g9tIFns9Xal9zSYy0Hwqq9MNhkVOLMVSBHRfsQnZgvcG6ZrqTINNzCxguMw9hQCbV
         jF9Xx1H4Y4SdESsGwURRVj8Y2FZEDX2S9ly3K1+mfB2GNy/+gC7KJC6K1/yU9QN7kJcV
         xbCSSGIphOkyDXjCm2fFECno+3Bh1u3UoKBiyZi1hmJLHCx6F8Nsp8HMdSWKM1rNGoN3
         VWH01R9CV0JhiGlo8fqxsnMfkED9JYyARacqR9KHatDE8FrUZyQjGK/5+OKK56cFmgIE
         YFFgwTumzqX7GPEa6O4uvycFX/kGeCCG2ohO96bMWOt8cfeKB3eaReQhYRCORyMO/qdi
         MsJA==
X-Gm-Message-State: ANoB5pnbjsmMpX7n67Kl/ifzEhqoelzUUZcK4JEYSXmFqhpjhAWIo+c0
        ITsCKNd3eaTP9lHLyWQuPpCW6VK909+Epg==
X-Google-Smtp-Source: AA0mqf6dAsA9jUzYnaab/Kda7py9bNU4Ib+8VCRZ5gesrrDLbn3NuGoq1JVFWReIW0XJG47ao7+Wqg==
X-Received: by 2002:a05:620a:51d0:b0:6ee:909e:ed6c with SMTP id cx16-20020a05620a51d000b006ee909eed6cmr30379259qkb.264.1669643955986;
        Mon, 28 Nov 2022 05:59:15 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t8-20020ac865c8000000b003a5d7b54894sm6939579qto.31.2022.11.28.05.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:59:15 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3bfd998fa53so53406317b3.5;
        Mon, 28 Nov 2022 05:59:15 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr46504823ywm.283.1669643955136; Mon, 28
 Nov 2022 05:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
In-Reply-To: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Nov 2022 14:59:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUbSdJWqgd6+=FbWRyB+YcgCtbfLk-zgrozwecOGn9JNg@mail.gmail.com>
Message-ID: <CAMuHMdUbSdJWqgd6+=FbWRyB+YcgCtbfLk-zgrozwecOGn9JNg@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for v6.1
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Nov 16, 2022 at 3:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> What took time for me was to figure out how to get the
> GPG password entry for signing the tag come up in
> curses on a remote machine instead of giving up when
> trying to open the secure little signing widget that locks
> the desktop UI which it doesn't have. Comes down to
> export PINENTRY_USER_DATA=USE_TTY=1
> then creating .gnupg/gpg-agent.conf setting up
> pinentry-program /usr/bin/pinentry-curses.
> Well that was not intuitive, especially not an
> environment variable containing an environment
> variable. GPG might need some UX polish (or maybe
> it's the distros that do this to us). Anyway here it is!

I don't remember the exact commands I used when preparing for last
ELC-E, but some Googling suggests:

    sudo apt install pinentry-tty
    sudo update-alternatives --config pinentry

At least I do have
/etc/alternatives/pinentry -> /usr/bin/pinentry-curses

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
