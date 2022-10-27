Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905F0610474
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbiJ0VcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiJ0VcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:32:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679696BCC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:32:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v28so2822255pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cSS8gP6uM2BHTQd+E6Wpq++4pxQTR5ohD5mdT7fX9c=;
        b=IxvqSgKyoq6dD3mRq9aFPS2INWDpRWA0AU8StUDweXJyKjMMIrnY5jETCOzsAtqSp1
         hSStnKV/hAVlZlWoHwHmIRs9iHT5hi+9/N8Goh6KfCYRM8HAtdlCUXmJFDeg3Qu3IJL/
         dGZGY6VWBB67SPg1SDPDzzyVUeiHuBzIvAHjtrVQr0mTCCbEZja+hb60MY22kZPjhzVF
         JO8h/74L/DbhuERoYyDCV9zagdymapxa/YHwrok7/cKIOwnOnPNiw2N5eq+JEXf2/TGU
         kzp5OTkUdpQbZmGl4lZi7FTWyAyMq6EvBJM+pqVOOckFukkua8U75oXK2msNTcVWW9Jv
         JPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cSS8gP6uM2BHTQd+E6Wpq++4pxQTR5ohD5mdT7fX9c=;
        b=ZCqjWJg0PdOuU0ZvJ6ecBIZ9gNjzMOPsDscz4sd/F/jckPKKuvVQkXl1z6QZa6ZkZ5
         XGMLnxYcgezeJwElC+aFhPRfOkmq1YpWHr+o+eLRStgYnmDAs9gd2kqWsV28QdsLz3HX
         wfnDqlBXqYaz/Q2HA+QGZs4Fzt0CXc5ndR86e+hNPpMM5P1YRZk7ahCvwgBmZjjxNdaP
         wKuvJD1PO2DyarVIZHSi6nzTiDy+OHQBqnRfBXrWj+5jKe27Mp0kehWS59vME6Ydx0AK
         4iRY2IphcQgk3LEFPrKY+HTMwm5vob1XjCdYINEivnvJjaqNqQc5yaKONI3+6r298u1F
         ArvQ==
X-Gm-Message-State: ACrzQf1h4BFA3Mx07jz1P8hKZtLOWCkeZrTwZa42txyNzEb0uVpidaN8
        hcJ/I8r4QwOfNpVUCb0ElBoNYA==
X-Google-Smtp-Source: AMsMyM6qkIqeQw6icEGLNhZe4KuMLbtlL0hMknarOJjeKdNboSXu04/O4T6OGEnmbuAVEe4QFEP1DA==
X-Received: by 2002:a63:1326:0:b0:439:40b5:77cc with SMTP id i38-20020a631326000000b0043940b577ccmr44759708pgl.473.1666906337634;
        Thu, 27 Oct 2022 14:32:17 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b0017f49b41c12sm1662577plh.173.2022.10.27.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:32:16 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:32:16 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Oct 2022 14:32:20 PDT (-0700)
Subject:     Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support detection
In-Reply-To: <Y1k9W6+EXgiL60uq@spud>
CC:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        Conor Dooley <conor.dooley@microchip.com>, daolu@rivosinc.com,
        heiko@sntech.de, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-99b62de8-5b5c-48f7-bd01-bca2a5a26064@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 06:59:55 PDT (-0700), Conor Dooley wrote:
> On Wed, Oct 26, 2022 at 06:48:32AM -0700, Palmer Dabbelt wrote:
>> On Thu, 06 Oct 2022 10:35:19 PDT (-0700), Conor Dooley wrote:
>> > From: Conor Dooley <conor.dooley@microchip.com>
>> >
>> > Hey,
>> > This came up due to a report from Kevin @ kernel-ci, who had been
>> > running a mixed configuration of GNU binutils and clang. Their compiler
>> > was relatively recent & supports Zicbom but binutils @ 2.35.2 did not.
>> >
>> > Our current checks for extension support only cover the compiler, but it
>> > appears to me that we need to check both the compiler & linker support
>> > in case of "pot-luck" configurations that mix different versions of
>> > LD,AS,CC etc.
>> >
>> > Linker support does not seem possible to actually check, since the ISA
>> > string is emitted into the object files - so I put in version checks for
>> > that. The checks have gotten a bit ugly since 32 & 64 bit support need
>> > to be checked independently but ahh well.
>> >
>> > As I was going, I fell into the trap of there being duplicated checks
>> > for CC support in both the Makefile and Kconfig, so as part of renaming
>> > the Kconfig symbol to TOOLCHAIN_HAS_FOO, I dropped the extra checks in
>> > the Makefile. This has the added advantage of the TOOLCHAIN_HAS_FOO
>> > symbol for Zihintpause appearing in .config.
>> >
>> > I pushed out a version of this that specificly checked for assember
>> > support for LKP to test & it looked /okay/ - but I did some more testing
>> > today and realised that this is redudant & have since dropped the as
>> > check.
>> >
>> > I tested locally with a fair few different combinations, to try and
>> > cover each of AS, LD, CC missing support for the extension.
>> >
>> > The one that I am left wondering about is Zicsr/Zifencei. Our Makefile
>> > has:
>> >
>> > > # Newer binutils versions default to ISA spec version 20191213 which moves some
>> > > # instructions from the I extension to the Zicsr and Zifencei extensions.
>> > > toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>> > > riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>> >
>> > I'd like to also move that one to Kconfig rather than the Makefile so
>> > that, again, it shows up in .config etc. But as Zicsr/Zifencei do not
>> > appear to be emitted into the object files it's not a fix and can be a
>> > follow-on patch if my approach here is not entirely off-the-wall.
>>
>> This is actually a different case: for Zicbom and Zihintpause the
>> instructions were added to the toolchain at the same time the extensions
>> were, for Zifencei and Zicsr the toolchain had the instructions before the
>> extension was defined (as they were in previous base ISAs).  So the
>> assembler always supports "fence.i", it's just a question of whether it also
>> needs another extension in march.
>
> Yeah, that one isn't going to break the build. If the extra bit isn't
> emitted then the old linker doesn't care. Was more for whether we wanted
> it to be consistent with a symbol for everything that we can check
> easily after the fact.
>
>> I'm not opposed to adding a Kconfig for it, but it's a slightly different
>> thing and I'm not sure the Kconfig really helps any because none of the
>> kernel sources need to understand the "the assembler doesn't support the
>> 'fence.i' instruction" case.
>
> tbh beyond the OCD thing about being consistent I don't really care :)
>
>> > I am not 100% on the LD/LLD versions that I picked, I went off of a
>> > `git branch -a --contains` of the first commits I found that with
>> > mention of the extension. Please scream if I got it wrong, I'm not
>> > overly familar with where to find this sort of info for the toolchains.
>>
>> This LD version check is for the ISA string mismatches between objects?
>> IIRC we stopped failing on those in 2.38, from that point on we just guess
>> at a mix and allow linking anyway (largely because of that fence.i stuff).
>
> idk, I wouldn't say "mismatches between objects". The
> _zicbom_zihintpause ends up in the object files and the linker doesnt
> understand that and aborts. The version checks are so that we don't
> emitt that string into object files where our linker doesn't support
> them. It only really matters for people that've got some sort of heavily
> mixed setup of things - which includes some CIs like Kernel CI.

As of 87fdd7ac09b ("RISC-V: Stop reporting warnings for mismatched 
extension versions"), we should be just ignoring these at link time -- 
unless I mixed something up and we're still getting errors, in which 
case we should fix binutils (and then make the check for whatever 
version that is).

Do you have an example of a link that's failing?  I attempted to 
construct one in the test suite, but not sure if I'm just missing 
something...

>
>> > Conor Dooley (2):
>> >   riscv: fix detection of toolchain Zicbom support
>> >   riscv: fix detection of toolchain Zihintpause support
>> >
>> >  arch/riscv/Kconfig                      | 17 +++++++++++++----
>> >  arch/riscv/Makefile                     |  6 ++----
>> >  arch/riscv/include/asm/vdso/processor.h |  2 +-
>> >  3 files changed, 16 insertions(+), 9 deletions(-)
