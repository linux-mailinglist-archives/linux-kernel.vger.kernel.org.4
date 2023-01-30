Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B1680385
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjA3BgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3BgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:36:16 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4419F1E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:36:15 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id t190so5037112vkb.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 17:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Mic7GKL4N/y1hjzEZDBJNa8o16mwGG4oqZUjeMQmI=;
        b=wuVVSA88CSh8e96SliMukxAUr6oxB+MqD2LlifFN1inXZs1DEfoZXi395gt9ilcC7g
         jBu8o0EJWRHeOk/08pEwogP/4drNsDFveEmunoeT92pO/DzYNGrZUXGBgSB5IMHjHoOE
         h0G55/xmMAxDph7Z3zAJ1yGvG6DS0n/6YLplShyaOVEV9mgn9EQhQ+CnwPXKnVtWdHF3
         7BcjIDbg8JXeYik/NpcU19Us02aLdqyoZ+PZSHcf69stOqlHB5EL/A1QlEATCCl4GpwY
         UT0SDkL1iG9Z/uM3gSI4Z6s5qcn879Z+wyyerYcNdpEV4EEPEnCk/rC7NakZhO06eQPB
         ya3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0Mic7GKL4N/y1hjzEZDBJNa8o16mwGG4oqZUjeMQmI=;
        b=Ot4S9qxAHOyNYYYV0hos289k2a2zuQDI/PedRnrphY7+LUGp/2eY6976SdyMQRHRky
         xIYFOF+azS/vSllzNV32F/dsM7Z4+Ed286QdQ07o02EVB6oRvMbsQ/fEwxwfZOXv0orT
         NVTP+aZ2CUncsUoxeBDu3xLXer0fA+fpkpJ4OHTqv1+qCxLT5Yq+yO1GPIACiqKIhh/s
         V0fi673BF51Ulwx5unp0fw3jUdwK/a0KROvPdGRvjRXGW1eAxfioBwBeuznvtidyZhBM
         APnCNtueAbewRByd/hOO0QWvPZ7lHzpYZ5nqkhEKCywxIEIghyVIJ6sK9jZba0ieaobO
         A1MA==
X-Gm-Message-State: AFqh2koV+MjLJGoX6QvmtRDbUDGkd+AuoeRNWWKtgWDRBpoffm98Qk9L
        WBuZMoyHfN+ApdZqq8buKwj/cI21bMpQeb7Y8uMGHVKnGnShgcDO
X-Google-Smtp-Source: AMrXdXs8NqbH4wKmN5lqGURkFNYAQ0NbT8FgOm3q4ilQ60x0Cd/mmexe1pWPP28IFEW+oKNIlHu1328DzLkC+F2LvvI=
X-Received: by 2002:a1f:9d58:0:b0:3e1:9f39:5c46 with SMTP id
 g85-20020a1f9d58000000b003e19f395c46mr6037580vke.20.1675042572859; Sun, 29
 Jan 2023 17:36:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:1015:b0:559:9619:d862 with HTTP; Sun, 29 Jan 2023
 17:36:12 -0800 (PST)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <Y9bvwz4FIOQ+D8c4@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Sun, 29 Jan 2023 20:36:12 -0500
Message-ID: <CADyTPEzvCLoMWJwfTMQZOkNXUgao5ZydUkD_bLewi9K5fCf2vg@mail.gmail.com>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1 (regression)
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> There's a similar report previously but interestingly it was exactly
> reported against commit 0ccf7f168e17, which was the one you reported all
> good:
>
> https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
>
> It's probably because for some reason the thp split didn't really happen in
> your system (maybe thp disabled?) or it should break too.

This seems an accurate assessment: CONFIG_TRANSPARENT_HUGEPAGE is not set

> It also means 624a2c94f5b7a didn't really fix all the issues.  So I assumed
> that's the only issue we had after verified with 624a2c94f5b7a on two
> existing reproducers and we assumed all issues fixed.
>
> However then with this report I looked into the whole set and I did notice
> the page migration code actually has similar problem.  Sorry I should have
> noticed this even earlier.  So very likely the previous two reports came
> from environment where page migration is either rare or not enabled.  And
> now I suspect your system has page migration enabled.

I'd say that sounds correct too: I have CONFIG_COMPACTION=y which sets
CONFIG_MIGRATION=y

> Could you try below patch to see whether it fixes your problem?  It should
> cover the last piece of possible issue with dirty bit on sparc after that
> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).

I applied this on top of 6.2-rc6 and will give this a spin now.

Thanks,
  Nick
