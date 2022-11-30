Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB9663E1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiK3UYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3UYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:24:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A12AFA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:24:10 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z17so13078755pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwIJM8t3rDu4EdnqkCy1u4N3uOvpgT7lYcnoQOxoBxE=;
        b=K93k2mvjpeJmh7SUsLe6tYcwRq+hH6itdOWtDK/qup3vkBSoXOAabgZOUyQOF6nNlZ
         iF9fzK6JZK8196XZ/rLoxF1OhHJpv0yw9gUW1g1484ZWcMJS7LJRu6+n2DGqfVg/JADG
         dqYopca9+Nd/tpLzPlDmBA3WmifFAMlwuriRY9rUJ5j7Mc1P2vFHxocNdGJxZqzKnq57
         v/c/aoT3oHrY8TzoHtDAOy/OUomBsJ/JIUnr52noH6rS+iDuddG8BXSGa7siRmXaVEOz
         kcUotKwSUv09OMzLP5Vrov9bH2nMrtpfZtQ/PJVAQmVeKVVLODI0SP9G/aEK19XmgRRQ
         /j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwIJM8t3rDu4EdnqkCy1u4N3uOvpgT7lYcnoQOxoBxE=;
        b=yaah+2yrm+KqkI77onTI0YaO5x60YntYzxR+ZZYe3CKEEnwTSSEm6rUXuDAJ4wBch1
         3l5M3y7x7I55gQ3oQhJEIRRKgDr8LdrqLR6cxu3B5J3SchG217fXwuAnis8jB5zi+wha
         nBFJcsBCDZt8W6krwKt7yPKdqJ0uainJYVyowjUEJyJ8jG3r1GLM6cOvfhj55VWQnheV
         b/PnVrw5PBALDGk/PZwFOg8MV+D8UDG1WcdDV3MpXS6d/woECmBUkxU5JwzQdgN20vU/
         7BdbfqRe2+uHoGUVMdGcWa4lDvE0/WNsGMAtQu7X6pV/HKtC24dBGZV+I1T32l8/htNb
         XMag==
X-Gm-Message-State: ANoB5pllJAx0NYuyz4T+eKKAmvu177Z5gtTI0Hked0s+HVUTXeLaMYlY
        xVBUtQ+1T6onqb7g+Sw8yATZ7Q==
X-Google-Smtp-Source: AA0mqf7tSFcxtMxKDfiy+UvOsM0wZq+I6jJp/XfbS2vu+XRn8HfqshC0r1AVmiaoBTapt2hLTUT4+g==
X-Received: by 2002:a63:5c23:0:b0:46f:b6e1:1966 with SMTP id q35-20020a635c23000000b0046fb6e11966mr46862935pgb.625.1669839849429;
        Wed, 30 Nov 2022 12:24:09 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00186cf82717fsm1917646plg.165.2022.11.30.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:24:08 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:24:08 -0800 (PST)
X-Google-Original-Date: Wed, 30 Nov 2022 12:23:48 PST (-0800)
Subject:     Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1 platform and drivers
In-Reply-To: <BBF52D3D-B8D3-4895-B316-33555E22C56B@kernel.org>
CC:     ajones@ventanamicro.com, heiko@sntech.de, samuel@sholland.org,
        wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        christianshewitt@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        heinrich.schuchardt@canonical.com, linus.walleij@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        stano.jakubek@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-f034544d-5b0a-47c5-8e45-3dbcefc0aaaa@palmer-ri-x1c9a>
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

On Mon, 28 Nov 2022 22:54:18 PST (-0800), Conor Dooley wrote:
>
>
> On 29 November 2022 06:49:25 GMT, Andrew Jones <ajones@ventanamicro.com> wrote:
>>On Mon, Nov 28, 2022 at 09:17:38PM +0000, Conor Dooley wrote:
>>> On 28/11/2022 21:11, Heiko Stübner wrote:
>>> > Am Samstag, 26. November 2022, 17:40:11 CET schrieb Conor Dooley:
>>> >> On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
>>> >>> Now that several D1-based boards are supported, enable the platform in
>>> >>> our defconfig. Build in the drivers which are necessary to boot, such as
>>> >>> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
>>> >>> and watchdog (which may be left enabled by the bootloader).
>>> >>
>>> >> All of that looks good.
>>> >>
>>> >>> Other common
>>> >>> onboard peripherals are enabled as modules.
>>> >>
>>> >> This I am not sure about though. I'll leave that to Palmer since I'm
>>> >> pretty sure it was him that said it, but I thought the plan was only
>>> >> turning on stuff required to boot to a console & things that are
>>> >> generally useful rather than enabling modules for everyone's "random"
>>> >> drivers. Palmer?
>>> > 
>>> > Isn't the defconfig meant as a starting point to get working systems
>>> > with minimal config effort? At least that was always the way to go on arm
>>> > so far :-) .
>>> > 
>>> > So having boot-required drivers built-in with the rest enabled as modules
>>> > for supported boards will allow people to boot theirs without headaches.
>>> > 
>>> > Disabling unneeded drivers if you're starved for storage space in a special
>>> > project is always easier than hunting down all the drivers to enable for a
>>> > specific board. 
>>> 
>>> I wouldn't mind being able to turn on all the PolarFire SoC stuff and
>>> yeah, that would be the way that arm64 does it. But I do recall hearing
>>> that I should not turn stuff on this way, when I initially tried to
>>> turn stuff on via selects, got a nack and asked if I could do this instead.
>>> 
>>> But it may be that I misremember, which is why I appealed to the Higher
>>> Powers for clarification :)
>>
>>FWIW, I don't worry too much about modules in defconfig because I always
>>immediately apply a 'LSMOD=$PWD/L localmodconfig' to it, where the L
>>file is an lsmod output which only includes modules I need.
>
> idk, defconfig to me is not about you or I, it's about A Developer that gets an SBC or a devkit and their experience.
> Or alternatively, someone's CI ;)
> I'd like to put everything in, but I recall that being shot down, that's all.

The whole "who is defconfig for" discussion always ends up kind of 
vague, but IIUC it's generally aimed at kernel hackers as opposed to end 
users -- so it's not meant to be a disto config, that's why we have 
things like the debug options turned on.  I tend to think of it as a "if 
a patch submitter is going to test only one config, then what do I want 
in it?" and let that determine what goes in defconfig.

IMO having defconfig contain the drivers necessary to boot every common 
dev board as =y, and having =m for anything else on those boards also 
seem reasonable.  That will make the transition from vendor/distro 
kernels to upstream a bit smoother, which is always good.  I guess 
there's some slight build time and image size issues, but aside from 
some very small systems that shouldn't be too bad for kernel developers 
-- and if we really end up with another popular system with 6MiB of RAM 
we can just stick another tiny defconfig in there for it.

I actually don't use modules when doing kernel development because I 
find it easier to track things when they're packed into a single binary, 
but I don't think it's necessary to steer everyone that way.

Adding some of the Arm folks here, in case they have thoughts.  The best 
bet is probably to try and do something similar, though my worry is that 
the answer is something like "target standard platforms" and we don't 
have any.
