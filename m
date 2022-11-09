Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C766562359A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKIVRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKIVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:17:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8523134D;
        Wed,  9 Nov 2022 13:17:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p21so18273186plr.7;
        Wed, 09 Nov 2022 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o0JaodUdCinHCuijBKMPPDh4qNhM3W4CwZTMs5pShU=;
        b=b7JdsqL98tFczElrzx45zPQRQqT+FLWQdW7GQ21VMf1VWbVkWvdPT7fPQVW9/YYGhj
         fsJmZVTrJHZqpF5nrGm5JKasB3diwCu2Hs5yNW2C9n/rEZiCH7R7PnAEwZ/MGa/qzyIG
         zfiOnumXidobU0/zuy474imLQWsj+TNcT1BwOR4wCZrc7nj9wEle1ahDUDnwTkt6UQJ1
         bZGNJ9fqbFCNFUTDQDZYUF5tjtiVt+POwV9J5xnlurRxP4GFYN8l+xbrN6OKbV0N8j6j
         kPz632gUkLxrLhg+OI3WB7b7hny2T7RaIKSOWnHn8CvNieatf9SjrSo7u+FU7dyzH4Jo
         RWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o0JaodUdCinHCuijBKMPPDh4qNhM3W4CwZTMs5pShU=;
        b=b3PLisN7Ncx58rTaBNLUZpurK7Peo+EAojgr7iioQ2yIi6iizKS3V22O63r4gOy4kb
         o4CfwbvlQhkpMutY7JA9f7+paUGVPlSSVnSsK1mib/FVf/ojjqLqh2MfYRUP9xk/ylWW
         CiS56JEg/zNqT5FKe7HNF+wcTuOCuLHfGs9cNia2P52wqsRHAjySRHMTYfX6Bt5MVITu
         W2/72nLb+cT5EBJ5uuZ/YZKudNtbfejQNK8UI3p9hMVbog6gaMvUkj1OsyCmxJgrbFuR
         RYUTP2km9yaJR2ivSvJ3VgpVX1O0t1JLoWgH+OBwTYEcek8NnGKcFTxJJCOgME983Rp9
         daWQ==
X-Gm-Message-State: ACrzQf0K+DeZsk1e++GTBesJ4+5GYDzHBL3XncL5yFdA5ge0zPOjJg/c
        R11ujVEZewBDVJNQT1mSPe5tfQhfcJwZGIdqGig=
X-Google-Smtp-Source: AMsMyM5vTjPHFhQ2vYKc1ap+Gnz9Xnoi5f6pFtOuhyEULsih6osIQH75MdocdJksgvBY7Bht8TwzxWn0ElldlUKBtUU=
X-Received: by 2002:a17:902:da82:b0:186:ee5a:47c7 with SMTP id
 j2-20020a170902da8200b00186ee5a47c7mr63072929plx.82.1668028625070; Wed, 09
 Nov 2022 13:17:05 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz> <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz> <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
In-Reply-To: <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Wed, 9 Nov 2022 22:16:53 +0100
Message-ID: <CAGfqbt50b9rFEjbFPCZoQnNyBN+CAgBf6bxwpbr4z=tL_A97MQ@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To:     Vlastimil Babka <vbabka@suse.cz>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 9 November 2022 16:50:08 CET Aaro Koskinen wrote:
> Hi,
>
> On Wed, Nov 09, 2022 at 10:00:25AM +0100, Vlastimil Babka wrote:
> > > On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> I believe SLOB can be removed because:
> > >>
> > >> - AFAIK nobody really uses it? It strives for minimal memory footprint
> > >> by putting all objects together, which has its CPU performance costs
> > >> (locking, lack of percpu caching, searching for free space...). I'm not
> > >> aware of any "tiny linux" deployment that opts for this. For example,
> > >> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> > >> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> > >> SLOB impact is too much for those who tried. Googling for
> > >> "CONFIG_SLOB=y" yielded nothing useful.
> > >
> > > I am all for removing SLOB.
> > >
> > > There are some devices with configs where SLOB is enabled by default.
> > > Perhaps, the owners/maintainers of those devices/configs should be
> > > included into this thread:
>
> [...]
>
> > > arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
>
> I have been using SLUB on my OMAP1 boards with 32 MB RAM, because of
> better debugging features and the memory footprint difference doesn't
> really matter for my use cases. Looking at history why SLOB was added
> there, it seems it came from 6cfce27c14aa ("omap1: Add omap1_defconfig")
> when separate boards configs were merged, and SX1 board happened to have
> SLOB in there. This board is nowadays only used in QEMU anyway.
>
> There are OMAP1 boards with only 16 MB, but support for those boards
> will be removed. So from OMAP1 side, I don't think there is any real
> need for SLOB anymore.

Moreover, I always had issues with availability of socket buffers during USB
device setup when trying to use SLOB on Amstrad Delta based on OMAP1510,
the least powerful OMAP1.  Then, +1 for SLOB removal.

Thanks,
Janusz
