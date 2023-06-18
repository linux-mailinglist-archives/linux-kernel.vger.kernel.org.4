Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43743734706
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFRQhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFRQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C01E49;
        Sun, 18 Jun 2023 09:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E2B160B78;
        Sun, 18 Jun 2023 16:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B690DC433C8;
        Sun, 18 Jun 2023 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687106238;
        bh=w5PergY9kTafyHYJcsbULa8KpRsHMRAQs38wpv8pc2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxtxqqZ1BylOXZ6vM0IDIbW89aCFhJu6iTrCaRqs3PoJZpmQE1b+ohIEKQ/G5asLz
         6UKGIk8oJ7jNzLWdTzXBUSy/cL+TAadIjJxsfrFwS2rYsNwZjgrrBvAfR5N+Lx/+Lg
         459laYz3dmVfL3mlLafjZ3yLAhaZZGY2C4vt1w4lw/b0DFn8jJ4Xcp6n4mlnLDv5rs
         Ja8ypN7xOhsxEJzUmjMxk1ldu7/dxkdoOhbMUQ1h4fqj4/+ev8kEnrJv4VbHb79/r+
         daNbkGHp9Ck0bfmt6Fs/AIYp3bxUKqax7uPgb3TZXxzZxiUg/kh1uS8W1JtqdzPGSW
         DtqA+qP7OlT4g==
Date:   Mon, 19 Jun 2023 00:25:54 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZI8wEp52bpqaCHAl@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <20230617-duress-phantom-3da79e33f204@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617-duress-phantom-3da79e33f204@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 07:20:43PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Sun, 18 Jun 2023 00:15:21 +0800, Jisheng Zhang wrote:
> > Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> > module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> > tree files for the core module and the development board.
> > 
> > Support basic uart/gpio/dmac drivers, so supports booting to a basic
> > shell.
> > 
> > [...]
> 
> Applied to riscv-dt-for-next, thanks!
> 
> [1/8] dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
>       https://git.kernel.org/conor/c/a04cc7391d88
> [2/8] dt-bindings: timer: Add T-HEAD TH1520 clint
>       https://git.kernel.org/conor/c/413c24b03f4e
> [3/8] dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
>       https://git.kernel.org/conor/c/89b0186ab532
> [4/8] riscv: Add the T-HEAD SoC family Kconfig option
>       https://git.kernel.org/conor/c/da47ce003963
> [5/8] riscv: dts: add initial T-HEAD TH1520 SoC device tree
>       https://git.kernel.org/conor/c/8e396880a864
> [6/8] riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
>       https://git.kernel.org/conor/c/5af4cb0c42c5
> [7/8] MAINTAINERS: add entry for T-HEAD RISC-V SoC
>       https://git.kernel.org/conor/c/1203f584fe66
> [8/8] riscv: defconfig: enable T-HEAD SoC
>       https://git.kernel.org/conor/c/318afa081204
> 
> I'll send it to Arnd as a "RISC-V Devicetrees for v6.5 Part 2" once it
> has been in linux-next for a day or two.

Thank you so much for helping the PR this time.

> 
> Going forward, who is going to pick up the patches and send the PRs to
> Arnd? I wrote a document that should be in v6.5 about SoC tree

Here is what I thought:
From next development window, 

If we see a heavy development window, IOW, the patches size is big, I
will take the job of picking up patches and sending out PRs.

Once the development calms down, the patches size is trivial, I will
explictly send request to you by repling the patches to ask your help
to directly take the patches and send PRs.

Any comments are appreciated.

Thanks

> submaintainer stuff that is worth reading:
> https://lore.kernel.org/all/20230606-escapable-stuffed-7ca5033e7741@wendy/

The handbook is a wonderful document, thank you!
> 
> I'll do it if nobody else is willing to, but I don't want to be
> responsible for applying patches for all the platforms that pop up,
> especially for ones that I don't even have the hardware for ;)
> 
> Thanks,
> Conor.
