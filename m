Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECA66F35F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEASm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 May 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjEASmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:42:25 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F9170B
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:42:21 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b99f374179bso4480742276.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 11:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966540; x=1685558540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zraZFbeyk6zdRmZ1quvA8xnbddG+EZLJ1kU8tZ6Byqw=;
        b=h7oFHoGCJ3fZSwlUsxmiLbBKTufPECIsarzLx99MbpHJVASPoEGktV4z4lTKB58WLs
         GcUqubhlfR1Sf0Z4Hv/mtW8h32uPprJARv7fQ8tdTh44K8U7NPGD+jvxke10iQB4Q5Ak
         QEOU05jQj0bvbO2A7p9CQSzEFvsD4glQbbWt2QaC0KIquLCN1q3/WqpvohsOThcvt+qU
         geFz3JagwpH1hf/sBnKOGNKYajs62qMh8Aab6XsPxK+AoAYSL3dBTanjGfX3x3w4UVuO
         4yhkly5t+mS0/PyIsnhMx8uyFWidjZqaHvlu/QIqDQkCbnio0bPJ47QRD+Ed6PORz6DY
         Kq1A==
X-Gm-Message-State: AC+VfDzU0hQFElG82q52SnTKpW8pTOQZeS7/4T8WnDFNz2XlNZ6YwVYQ
        nsAekq7dZ5ckWRHQqRDyKL5YIkpDJnl3Wg==
X-Google-Smtp-Source: ACHHUZ6CjTxS6mQHkHymAPsL05jC+AGE4Z4afQf8Q7w0i04DeQm7j4yjq6f3ZNrc7dUUlV8ud3JTQg==
X-Received: by 2002:a0d:d885:0:b0:55a:6430:e8fb with SMTP id a127-20020a0dd885000000b0055a6430e8fbmr3293725ywe.8.1682966539837;
        Mon, 01 May 2023 11:42:19 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u189-20020a0dd2c6000000b0054f50f71834sm2069210ywd.124.2023.05.01.11.42.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 11:42:18 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b983027d0faso4521260276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 11:42:18 -0700 (PDT)
X-Received: by 2002:a0d:f881:0:b0:556:c98d:121e with SMTP id
 i123-20020a0df881000000b00556c98d121emr15162643ywf.7.1682966538370; Mon, 01
 May 2023 11:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV> <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV> <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <20230428162718.GA1099174@dev-arch.thelio-3990X> <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
 <2023042859-kosher-specimen-9a0f@gregkh> <58974d54-9e02-4800-814f-9206c3cfcc95@roeck-us.net>
In-Reply-To: <58974d54-9e02-4800-814f-9206c3cfcc95@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 May 2023 20:42:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgjf-cTHkg9ZmPwJa=Cc2s9mCX66t6Q0u4Ld5ysYJ07w@mail.gmail.com>
Message-ID: <CAMuHMdWgjf-cTHkg9ZmPwJa=Cc2s9mCX66t6Q0u4Ld5ysYJ07w@mail.gmail.com>
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

On Sat, Apr 29, 2023 at 5:56 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Apr 28, 2023 at 07:31:35PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 29, 2023 at 01:41:02AM +0900, Tetsuo Handa wrote:
> > > On 2023/04/29 1:27, Nathan Chancellor wrote:
> > > > I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
> > > > tty_io: remove hung_up_tty_fops"), where it causes the following warning
> > > > for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):
> > > >
> > > >   drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
> > > >     446 | static long hung_up_tty_compat_ioctl(struct file *file,
> > > >         |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > I am not sure if you just added that patch for additional test coverage
> > > > or for final acceptance but the following diff resolves this warning for
> > > > me, perhaps it can be folded in for a v2?
> > >
> > > Thank you for reporting. Yes, moving the definition will solve the warning.
> > >
> > > I'm testing this patch using my volatile tree before getting merged to a
> > > permanent tree.
> >
> > How are you adding new stuff to linux-next right now when the tree
> > should be "closed"?  And I haven't reviewed this yet, what tree has
>
> That happens all the time, and quite often the "late" additions are applied
> to mainline immediately afterwards and end up causing problems there.
> I can only hope that this won't happen with this one.

And it might be picked up by stable ;-(

> > picked it up?
> >
> > Please wait until after -rc1 is out for new stuff, you know this...
>
> This patch is supposed to fix a data race, so maybe it wasn't considered
> "new". Just guessing, of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
