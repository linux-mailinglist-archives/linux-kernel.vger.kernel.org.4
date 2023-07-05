Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97027748A05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjGERSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGERSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:18:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB66C9F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:18:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c2743325e2dso1442157276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577484; x=1691169484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7jIf9i3ksWGvPsicxdNnPgtrbo3MzQISW/C0qv0Qbw=;
        b=XaolOQWQ4jnES3E/8iNwVuZyh2DV6FVlo/omaa4EKlgqNljBwOJdMKU8RPHwO8Vl9V
         lI/dO6+1/B50grN6xvSluk0s8yvAKU2usA2Qq9fla+PAUdftTcmU4qSWnXuZygaTyzfo
         4e4D8uqf9vxe5DiA3sfIYLuM8uzo3qC+kYpEwv6XrtK0BBJUIllmBcQl9iQyHmFrs7Iv
         vm/OelYF9SLZCXvTdLOb/kNYOZ1tZ1mmSOL0oqBnRd3QVCZbSoSJyFSWHXQTPNRqUUCe
         6jkyRy/x3z8naQL6QTG813D/HfD/Nhw/vIw1oFjsNIAAz5cz4Xbe8KFPfVcGaTMG80rK
         n1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577484; x=1691169484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7jIf9i3ksWGvPsicxdNnPgtrbo3MzQISW/C0qv0Qbw=;
        b=b5xEhmN+NkqatnCzuV9ILTVZ8c3mC6mtazUwQVPSLKW16TpizEvfIIQ72y5TDVzZTx
         sIeOyvHvDNw46Wgtzny+jr6QuU2ONhPoBKgW3EKPROy/LuOsinpPXVSAqAGJkyCqMPYS
         G5GBMyPnJA1bndPuFMol+s07CDfTgMu5uN/GWyYmqAaLSc0w8iIiQIsFrk1lmnUvsFpq
         y0+E6guwxuzZx/P2RukhzV26ItviVMyZMhW2yEX1ArzJiKJhJm+kJy1dXz/bVzSTrGSJ
         xfza1mVZoDz6iYE6BJc16IHQTx7ga3WLtt8+3+LM44MNaN84JqlGivy9csHlCWTu6c30
         3+Ww==
X-Gm-Message-State: ABy/qLY/vXIBmf8pUHh2p8it8M/GjIAVoV0d5ap2fNXVc6e9/4bPl20O
        BSl/HRR4SkCeLwXcd4pGydRa7ZxQy12uRAw1uo+7sA==
X-Google-Smtp-Source: APBJJlF5Lu4LTcBLFU5Z+wtDAT4LAHiYQvjgJVRmySjeBhhbtcDJ5fU6Lnob/EjgPne994hRcVi0JgDWA1h6Lpg+q6I=
X-Received: by 2002:a25:ef47:0:b0:c42:2b05:17a5 with SMTP id
 w7-20020a25ef47000000b00c422b0517a5mr1942870ybm.11.1688577483813; Wed, 05 Jul
 2023 10:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com>
 <5c7455db-4ed8-b54f-e2d5-d2811908123d@leemhuis.info> <CAJuCfpH7BOBYGEG=op09bZrh1x3WA8HMcGBXXRhe6M5RJaen5A@mail.gmail.com>
 <CAJuCfpH7t7gCV2FkctzG2eWTUVTFZD7CtD14-WuHqBqOYBo1jA@mail.gmail.com>
 <2023070359-evasive-regroup-f3b8@gregkh> <CAJuCfpF=XPpPYqp2Y1Vu-GUL=RBj4fyhXoXzjBY4EKtBnYE_eQ@mail.gmail.com>
 <2023070453-plod-swipe-cfbf@gregkh> <20230704091808.aa2ed3c11a5351d9bf217ac9@linux-foundation.org>
 <CAJuCfpE_WjRQoDT1XnvBghCH-kpqk+pfcBJGyDnK7DZLMVG5Mw@mail.gmail.com>
 <2023070509-undertow-pulverize-5adc@gregkh> <7668c45a-70b1-dc2f-d0f5-c0e76ec17145@leemhuis.info>
 <20230705084906.22eee41e6e72da588fce5a48@linux-foundation.org> <CAJuCfpGQK+Z0WPoRjBbSgD5m9wXyP7NJpu9fjGALmGu=6AGYaw@mail.gmail.com>
In-Reply-To: <CAJuCfpGQK+Z0WPoRjBbSgD5m9wXyP7NJpu9fjGALmGu=6AGYaw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 10:17:52 -0700
Message-ID: <CAJuCfpGwE+ZvBVjp__9aQcbmq8MpBbeS4xUjFkjJUQY+fwyryg@mail.gmail.com>
Subject: Re: Fwd: Memory corruption in multithreaded user space program while
 calling fork
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jacob Young <jacobly.alt@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:14=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 5, 2023 at 8:49=E2=80=AFAM Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> >
> > On Wed, 5 Jul 2023 10:51:57 +0200 "Linux regression tracking (Thorsten =
Leemhuis)" <regressions@leemhuis.info> wrote:
> >
> > > >>> I'm in wait-a-few-days-mode on this.  To see if we have a backpor=
table
> > > >>> fix rather than disabling the feature in -stable.
> > >
> > > Andrew, how long will you remain in "wait-a-few-days-mode"? Given wha=
t
> > > Greg said below and that we already had three reports I know of I'd
> > > prefer if we could fix this rather sooner than later in mainline --
> > > especially as Arch Linux and openSUSE Tumbleweed likely have switched=
 to
> > > 6.4.y already or will do so soon.
> >
> > I'll send today's 2-patch series to Linus today or tomorrow.
>
> I need to make a correction to the patch fixing the issue (the first
> one in the series) and will post it within an hour. Thanks!

Corrected patch is posted at
https://lore.kernel.org/all/20230705171213.2843068-2-surenb@google.com/.
The other patch is unchanged but I posted v3 of the entire patchset
anyway.
Andrew, could you please replace the old version with this one before
sending it to Linus?
Thanks,
Suren.
