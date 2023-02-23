Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6346A0A10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjBWNMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjBWNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:12:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F15652D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:12:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i11so4478426wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb59OZw0P/9NeiLo7j0/pIIcP5QkKD4A9oJDDcL4MAg=;
        b=hrlRDOKwOAsNkn63EV7n3EEAQ4B9IaQtA8AIfHsOiB4TORHkWY2kK38L935i7RoAkO
         olQa3vClBYmwI8KwEFJB6OPacgNRv5x0BN4vdHf3XCEpriaGT+omA4tS0gMZiZxKcc3F
         KYWPSwsUHx/frhqkq7A+J1wZizAG8ePYV7KvjhBPsnTPCUograCrVBFqcg6srDhRwA+g
         U3yCkqCB9uB9VtPc5hwrVaCL1hVrTXMesQpZ4o6rR2fhIdFruEUpbstEzITPCLTBBZC5
         KBWMT1Y873RFeL8aM322RZ3QoSZitsWNIn2ZjY4a1FDfQORGN+A8UZHYx1nVnn/nmc6t
         CSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tb59OZw0P/9NeiLo7j0/pIIcP5QkKD4A9oJDDcL4MAg=;
        b=IGzcVqkH1zIjjPVZmakKcFgz6nCmv4jrIx0Mfe65t2EDN5Bn+daflXfNqYfQlgs5wM
         KK/xt278HrABhhVb3nKpHqcbnibEfkUQWcJg47G3u81cXmUD3gx0E+ctHQOu9Polk8zG
         Tg/4c+Ok81CONocSoPkP5rYUOkB46ogw1SNkLyl9WikT3oVmgQI3BZbkaq4tYMxkwEcr
         wjFmv1H71qN3b8bboOu/qxMVpEXHlQTfN820aClw/1SPM1Wh0OqwJ3HIS1X1RMV6P12C
         rIpGRTepZJmVwxhc2HlkbpVta9npdbYToSyW35qhrI0a7FBzW5fqjkTKbtg2t6sN/8Oq
         rWHw==
X-Gm-Message-State: AO0yUKWey3UYN9hCH+r3rzfXsumz3u32r4x3whHgdEEQTQC3r3eBcJRC
        DGYX9F772YJ37UJSzMKbyEgbfBWuZ1ayfGGHfNLI2Q==
X-Google-Smtp-Source: AK7set94r7NGT29eIpH72O39BJhvhcK+eRKfihpjHL0Bl53RKHrn48B3FXlJGKNmfO3t+QnjF/nB7RwGXZWsm1mLo5s=
X-Received: by 2002:a5d:4d0b:0:b0:2c5:532b:cd20 with SMTP id
 z11-20020a5d4d0b000000b002c5532bcd20mr663712wrt.11.1677157925879; Thu, 23 Feb
 2023 05:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com> <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
 <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com> <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
 <874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com>
In-Reply-To: <874b8076-b0d1-4aaa-bcd8-05d523060152@app.fastmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 23 Feb 2023 14:11:55 +0100
Message-ID: <CAHVXubidtBHNi8iFrFAWqRtkxiUBbmzzXFn+=R1DjEd5X0SpQw@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 2:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 23, 2023, at 10:54, Alexandre Ghiti wrote:
> > On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
> >> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
> >> >> From: Palmer Dabbelt <palmer@rivosinc.com>
> >> >>
> >> >> As far as I can tell this is not used by userspace and thus should not
> >> >> be part of the user-visible API.
> >> >>
> >> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> >
> >> > Looks good to me. What's the merge plan for this?
> >>
> >> The easiest way is probably if I merge it through the whole
> >> series through the asm-generic tree. The timing is a bit
> >> unfortunate as we're just ahead of the merge window, so unless
> >> we really need this in 6.3, I'd suggest that Alexandre resend
> >> the series to me in two weeks with the Acks added in and I'll
> >> pick it up for 6.4.
> >
> > Sorry for the response delay, I was waiting to see if Palmer would
> > merge my KASAN patchset in 6.3 (which he does): I have to admit that
> > fixing the command line size + the KASAN patchset would allow 6.3 to
> > run on syzkaller, which would be nice.
> >
> > If I don't see this merged in 6.3, I'll send another round as you
> > suggested in 1 week now :)
>
> Hi Alexandre,
>
> I have no plans to still pick up the series for 6.3. The patches
> all look fine to me, but it's clearly too late now. What is the
> actual dependency for KASAN, do you just need a longer command
> line or something else? If it's just the command line size,
> I would suggest that Palmer can still pick up a oneline change
> to increase it and refer to this thread in the changelog as a
> reference for why it is not an actual UAPI break.

Indeed, we only need a longer command line size. I'll ask Palmer to do
that then, thanks!

Alex

>
>      Arnd
