Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC915609686
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJWVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJWVaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:30:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692B52838
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:30:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id n130so9134828yba.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy2Bti+Ren8yISGe+WlfwGo/SlGsVh6kvbpKMjRS0yo=;
        b=CcPpKl5zs94F+SO+/G6XwCxWldTNzKG4UYaawBGpZukg7IBLNV7w/nOcJcJ5aI6FXq
         PIuMhio5c4kNnmZnx60GEfg+ZR7/0EC1lyjaGZI0XQoBtZk7E6yxTDj5NRpQ/crIqt/C
         FY9wKuSF/jU77c9yeQN3AbS/eTapMAK2wOzanXSGTzM9ajojmp0x+FYv598nn4iFS3Jc
         +lLsUq7dHaBEapNCxY5VDwn2qQQPYro0c3MCmp8I0eXGLy7MALrUXwhjEnp/1Hc1lv2H
         dn5uSIW/sPzWrZkwLAubtcbU5FMCzm8K2q2RIA85OnYhr5zGLB4ELx6dukWlcCOSjguO
         mo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy2Bti+Ren8yISGe+WlfwGo/SlGsVh6kvbpKMjRS0yo=;
        b=HSGOPvOz9CqGbCCC2MwNypCGBJ1PZIwjuVUKBIjzQchceA6e3Lhi+YCVRXhYb3lpDB
         8UG9y1s4Fe/QKdjBsOQ6s/nE0PdO9vQwovtii5nHeLkHWQ/UfuLMhZswldUDz30P0OXn
         R07zSfmcwkCnvrR92a7PJr+BgCyskcCdFkScxKRsrCJJHyUisaPh0TK1wu2wa6i4KslP
         oH6UsoFmmnn5AqpBbROi7V/VQtdKWCJlI54EIoLtj+y+UpjUszLDRNLOqSrUYISWF0I0
         hjpUICNjX1rjPtaCTMqxDUKhfsIm2s4rWOVL5VzuaVLvpw1TYVFPMFSc3Of6dMoP+ib0
         KDKw==
X-Gm-Message-State: ACrzQf3ZqkKo3MHz8n91fmsXD8XA14UU+qpR/eh3n1PhukU5N9YRRaEq
        tkSN/EKtyqarEwydp4O0B5wGrOgUixa359ukrhIrMQ==
X-Google-Smtp-Source: AMsMyM5b3P0cN/VXr/jzQZzIivEDK7htg5mAr1t3eU4CMC+was2H6diHd4OPeC8JsSUyAggnJqVrYi3XaYYEO1NVBpw=
X-Received: by 2002:a25:7b44:0:b0:6c1:e145:d660 with SMTP id
 w65-20020a257b44000000b006c1e145d660mr24998639ybc.46.1666560644206; Sun, 23
 Oct 2022 14:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221022234024.87475-1-mw@semihalf.com> <Y1VX4RtzKQZHe/oO@lunn.ch>
 <Y1Vp4BdC50o9roKe@shell.armlinux.org.uk>
In-Reply-To: <Y1Vp4BdC50o9roKe@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sun, 23 Oct 2022 23:30:34 +0200
Message-ID: <CAPv3WKdcQGqofEgV4w_iiQ7FFa0ZF=du8gK9eAD==10HhwEnUA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, hch@lst.de,
        kabel@kernel.org, jaz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 23 pa=C5=BA 2022 o 18:21 Russell King (Oracle)
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Sun, Oct 23, 2022 at 05:04:01PM +0200, Andrew Lunn wrote:
> > On Sun, Oct 23, 2022 at 01:40:24AM +0200, Marcin Wojtas wrote:
> > > Armada 38x platforms marks all devices as coherent via
> > > mvebu_hwcc_notifier(), whereas the standard way to determine
> > > this is by of_dma_is_coherent(). Reflect the hardware
> > > capabilities by adding 'dma-coherent' properties to the device tree.
> >
> > Hi Marcin
> >
> > Does this need to go to -rc for 6.0? The DMA issues being reported?
> > If so, please add a Fixed: tag.
>
> Are we absolutely sure this makes sense?
>
> Looking at atch/arm/mach-mvebu/coherency.c, there are dependencies
> on stuff such as whether the kernel is in SMP mode or not (because
> the page tables need to be appropriately marked as shared for
> coherency with IO to work). We only enable the shared bit if we're
> in SMP mode because (a) its difficult to do at runtime due to TLB
> conflicts (requires switching the MMU off, rewriting the page tables
> and switching the MMU back on), and (b) setting the shared bit for
> CPUs that don't need it _can_ result in the CPUs basically bypassing
> their caches and thus kill system performance.
>
> So, if we have Armada 38x platforms that are operated in uniprocessor
> mode, this patch can cause havoc on such a setup.
>
> I would suggest utmost caution with this approach.
>

Sure. In such a case the description of 380 variant (single core)
should remain untouched.

We need to decide what to do with dual-CPU, i.e. Armada 385/388. How about:
- Don't change current behavior, i.e. perform a necessary kernel
configuration in "arm,pl310-cache" driver,
arch/arm/mach-mvebu/coherency.c + &coherencyfab:node in DT
- Satisfy of_dma_is_coherent() by adding `dma-coherent;` in
armada-385.dtsi only (IMO this would describe HW properly)
?

Best regards,
Marcin
