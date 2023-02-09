Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D442868FE07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjBIDiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBIDiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:38:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32F83CD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C4D61880
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEB5C433A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675913894;
        bh=sZcmT4YoOyHE793lXhE8rjx0Hewi5P86fQfY62bVLso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQf8hfJbaMiqC2vIng9fLIXn6mykWu4ad/Kgd3UYoVjq4NTLZ92PHRuVghczfB7j8
         7pM88HdKPtc551iIGa+geAIhCvO6sCzr50u1+YLlGDYR88OVMszfC6gPUsXhWxDQON
         iLm1vS/N8kY0kTpASkjSx6vp1n1zrMi2BOplTyUiKmaL3FMmxlZzNiClzQ/XIY1zCT
         xzP0VWXsneZcAbRiIqMAKYxREj4qaBPBqOsH2zLeY0Bueo9rof7ZEDcEZfkEONgLYF
         2zikBjpRXRhf2ip/4iUSlXXBH4B5Ld5X8+MDOYn02Mr9/ktVvdP1YD0vci3/y8nXPN
         KMtSqDCM9dhSA==
Received: by mail-ed1-f52.google.com with SMTP id l12so1052992edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:38:14 -0800 (PST)
X-Gm-Message-State: AO0yUKWUfRgSCriyce6aQRCaDlqYUDu17Di77qg3bF4I1X7aRofqfr6p
        yWHGhp32auRu6Z+Zi82xEnD1jMyCMtDmqqT5PpY=
X-Google-Smtp-Source: AK7set/t/PG5JVGZ9S+WrIC6bd3qWz1Du+f1kFd6B/WwzNipsMFDSucgFV9nWYU8xpd3NigI61q/9/FkQqn4VveljWY=
X-Received: by 2002:a50:f60b:0:b0:4ab:15bf:4b9e with SMTP id
 c11-20020a50f60b000000b004ab15bf4b9emr839361edn.7.1675913893061; Wed, 08 Feb
 2023 19:38:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675907639.git.chenfeiyang@loongson.cn> <Y+RqCcaS6pJ+W9+N@1wt.eu>
In-Reply-To: <Y+RqCcaS6pJ+W9+N@1wt.eu>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 9 Feb 2023 11:38:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4-m3AaS4-w-+yyUwBMt8Fm30SkS7ZnfSL5zA1OzJsLTA@mail.gmail.com>
Message-ID: <CAAhV-H4-m3AaS4-w-+yyUwBMt8Fm30SkS7ZnfSL5zA1OzJsLTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add LoongArch support to nolibc
To:     Willy Tarreau <w@1wt.eu>
Cc:     chris.chenfeiyang@gmail.com, paulmck@kernel.org,
        Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        jiaxun.yang@flygoat.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Feb 9, 2023 at 11:35 AM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Feiyang,
>
> On Thu, Feb 09, 2023 at 11:24:11AM +0800, chris.chenfeiyang@gmail.com wrote:
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > Add statx() and make stat() rely on statx() if necessary.
> > Add support for LoongArch (32 and 64 bit) to nolibc.
> > It was tested on LoongArch64 only.
> >
> > The latest QEMU support full-system emulation of a LoongArch64
> > machine, but for the moment we need to specify the firmware manually.
> > https://github.com/loongson/Firmware/tree/main/LoongArchVirtMachine
> >
> > QEMU_ARGS_loongarch  = -M virt -bios edk2-loongarch64-code.fd ...
> >
> > v2:
> > - Mention that statx() will also benefit other architectures.
> > - Make stat() rely on statx() when available.
> > - Put the whitespace changes into one commit.
> >
> > v3:
> > - Add #if defined(__NR_statx) guard.
> > - Keep the check for statx() from the first version.
> > - Mention that we may use statx() everywhere in the future.
> > - struct statx stat -> struct statx statx.
>
> I'm personally fine with this one. I'll give it a try with all supported
> archs to make sure we don't have any unexpected side effect, and unless
> anyone has any other comment, we'll queue this series.
>
> Thank you!
> Willy
