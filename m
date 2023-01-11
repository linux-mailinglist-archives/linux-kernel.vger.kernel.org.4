Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C8665D13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjAKNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbjAKNxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:53:08 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978F10EC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:39 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d16so795230qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAUo9g+pZ7MGFpWgfp8Hgfry4Aku45YtfI7WJ19iP2c=;
        b=bqeMXJc6OFBQasYaspezdnuV1BKaiuIAcUwaydUY8k1lED/bzBhKijVLU+dF9HuoZ7
         gkEOCd/SI4Er9laG5V92aFG/vPF/1P0yLWH+QFXrT67uK7OX+6OoDZ0Xr9NdF44McUCI
         IoqpSL6isiP3gpJT9XkkYjNHCSDM//3ueCjmNwuAiRbRuQZqp6J5R8CRJRl+sqeC3CsC
         HXpQQoPw2vd3hqDqgvb/D9PE4O55fNYLLy255vhrml8XRg6sPU0qqGU8eyt2HH4y3doT
         MqsH9yz/v44JKBKQBNkxSBvgjJXmkTtGvhY5h66hhb9aMTqM23vuxCFP7/L7bs/zCpi6
         5M5A==
X-Gm-Message-State: AFqh2kovsqtNYM1U8onJSzH2J/u1iL8gMGOR47+0ch9Mpqb6uBEJGaIG
        2fF9E57TTz3ClIheyZ62xr/Up+NZuoPOBw==
X-Google-Smtp-Source: AMrXdXtvxHVDp4g1uhDpj6VMwhWm9PqR885FSwZqZD6lAZ4GNfKrfFgcCimS4SACHN493lT386YCqg==
X-Received: by 2002:ac8:4e04:0:b0:3ab:5dc7:6bf0 with SMTP id c4-20020ac84e04000000b003ab5dc76bf0mr98351490qtw.36.1673445158551;
        Wed, 11 Jan 2023 05:52:38 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b003a4f435e381sm7546377qtp.18.2023.01.11.05.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:52:37 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4a2f8ad29d5so195227647b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:52:37 -0800 (PST)
X-Received: by 2002:a0d:fb81:0:b0:480:fa10:459e with SMTP id
 l123-20020a0dfb81000000b00480fa10459emr333518ywf.283.1673445157171; Wed, 11
 Jan 2023 05:52:37 -0800 (PST)
MIME-Version: 1.0
References: <Y7nyd4hPeXsdiibH@duo.ucw.cz> <Y7pRw47hidw+s6+g@mit.edu>
 <Y7pzbnlXgv+asekg@amd.ucw.cz> <CAMuHMdVvVoEs8yjNLmK=_shmGkyz1zYc8ZMi-vmP4aee0yKoPQ@mail.gmail.com>
 <Y7sPq3Tmm6vI/RAJ@duo.ucw.cz> <Y7tjnhs77o4TL5ey@mit.edu> <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
In-Reply-To: <614os9n2-2sq1-2qnr-56q6-1qq628271175@vanv.qr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 14:52:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJh24d3u_RHm_Sa7YsAdbk_5yDVEbk-huRFSDxbgBkFA@mail.gmail.com>
Message-ID: <CAMuHMdXJh24d3u_RHm_Sa7YsAdbk_5yDVEbk-huRFSDxbgBkFA@mail.gmail.com>
Subject: Re: Dhrystone -- userland version
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Wed, Jan 11, 2023 at 2:32 PM Jan Engelhardt <jengelh@inai.de> wrote:
> On Monday 2023-01-09 01:45, Theodore Ts'o wrote:
> >On Sun, Jan 08, 2023 at 07:47:07PM +0100, Pavel Machek wrote:
> >> > However, as this is not Linux-specific, how hard can it be to convince
> >> > your distro to include https://github.com/qris/dhrystone-deb.git?
> >> > Usually, when I have a full userspace available, I just clone the above,
> >> > and debuild it myself.
> >>
> >> Dunno. I'd not solve it if package was in Debian, but it is not.
> >
> >I would suspect the better long-term solution would be to get the
> >package into Debian, since that will be easier for people to use.  I
> >suspect the reason why most distros don't include it is because it
> >really is a **terrible** benchmark for most use cases.
>
> (All of) you could install boinc-client and just exercise
> --run_cpu_benchmarks without (I think) attaching to any particular
> computing project. The package should be in distros and you get
> both Dhrystone and Whetstone.

Thanks, but I really want an in-kernel benchmark, as a full userland
may not be available during early development.

BTW, boinc doesn't seem to work under Wayland, spewing lots of
"Invalid MIT-MAGIC-COOKIE-1 key", before printing Dhrystone and
Whetstone numbers...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
