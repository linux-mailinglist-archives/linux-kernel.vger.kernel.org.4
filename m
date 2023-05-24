Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D372E70EE53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbjEXGnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjEXGnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:43:22 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8EE42
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:42:01 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-56204ac465fso8010267b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910521; x=1687502521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYRrGQIdD9R0OEtw6J3W9P2qoBkYq4rnHkcLat3It4U=;
        b=JBdm+AAv0FNefVP2UbWjdl+8yeL1uz499BlzEm4Mj9rFvaxPfkafAh1FVUXrE2WOoh
         n47f7mJeGY+MIE6lndLri4LrlNnNdvofYQq7R4SkAjERbE6bgTUzEcpmNVsXcRnpV0H2
         yqpZxhPlE0D4fZYwWkdWN2NO0omFwpCWJa1rVNqacRbf85jqxSvqBJmb8Frlbe/bKdvS
         E2wRl3kCCEoycFgewTYMutd0O6BkR+/rZrqnBAWakmyfrA2f8nOmHgGlrP/SEyPsFDrG
         FPM0PXJSkvCFWmMQY+yDSk2prmprAEfQ87j0PSVtsweKiOopXFKwPOObFnBL1a7wp1te
         63RQ==
X-Gm-Message-State: AC+VfDw4mbRVqVEPpoRyISnSWUT/yG3+FNVUEGb1Rg1UUrj1dqhtJyjV
        +y7UqzbTSvU4/CoujfoJFjhwIsYAOAT9ng==
X-Google-Smtp-Source: ACHHUZ6o55E2lQdqJZpxJBu36mO1dJK5FFc6YD51Q+KvkOUXkYrJ5Yepm1o4oetcdanc3/cQqgYlbg==
X-Received: by 2002:a81:4f57:0:b0:55a:98ff:f075 with SMTP id d84-20020a814f57000000b0055a98fff075mr18077463ywb.3.1684910520683;
        Tue, 23 May 2023 23:42:00 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x21-20020a0dd515000000b00561608bc0dfsm3494301ywd.56.2023.05.23.23.41.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 23:42:00 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ba71af5f164so907575276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:41:59 -0700 (PDT)
X-Received: by 2002:a0d:f404:0:b0:561:8c55:738e with SMTP id
 d4-20020a0df404000000b005618c55738emr18881468ywf.12.1684910519595; Tue, 23
 May 2023 23:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
 <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk> <CAK6rUAOfNT6EovuBse+C8uvgNOybmjx=cu8o5mzvhYn=2ytHRQ@mail.gmail.com>
In-Reply-To: <CAK6rUAOfNT6EovuBse+C8uvgNOybmjx=cu8o5mzvhYn=2ytHRQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 08:41:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWyhc9TcLtH2NUYGhn4eOhLsfik5oLJQKm1CNhc3sUMQ@mail.gmail.com>
Message-ID: <CAMuHMdUWyhc9TcLtH2NUYGhn4eOhLsfik5oLJQKm1CNhc3sUMQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Streamline debugfs operations
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Osama,

On Tue, May 23, 2023 at 6:48 PM Osama Muhammad <osmtendev@gmail.com> wrote:
> The patch to Fix error checking for debugfs_create_dir has already
> been submitted.
> Here is the link to the patch :-
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?id=2bf1c45be3b8f3a3f898d0756c1282f09719debd

Your patch fixed two cases, but missed the third.

> On Tue, 23 May 2023 at 20:17, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:
> >
> > > Fix the error check on the return value of debugfs_create_dir() in
> > > create_regulator(), which was missed before.
> > >
> > > Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_create_dir")
> >
> > Also: this should be a separate patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
