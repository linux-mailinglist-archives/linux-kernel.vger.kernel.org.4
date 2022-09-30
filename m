Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8A5F1516
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiI3Vli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiI3Vlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505F1A6E8F;
        Fri, 30 Sep 2022 14:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2D162516;
        Fri, 30 Sep 2022 21:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD021C433C1;
        Fri, 30 Sep 2022 21:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664574090;
        bh=EWwElnoQ3zIq+7TaGrma83diIit5m496+HZGkaC/q44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoNAyXvQ6XZUKlvHJdQTgOYhYGSHuu/exBYucbS88m47QiHG6E0E0z2THsu2YvMb2
         Ya/kB5pgAeZpJtOsAdSsn6JWCV0Qhw/unu3XJMp/GpfxNi3EneQcZ9gcf8vLFak67w
         NMa072xAK0FZVg6MvUsWXAcwrGkNa0Bdgvm5kyeY7Ag7jmKMzIlw1EFiqZq5qQ+ZT1
         ibzZa3Ex+6bYE6LwxtNDofRa3aS8Ma49ouf3WVS7qJbU+adqHmrYWgVLMT0M8CXn26
         Hd69niFIk3XXUhyTQUPaFsNNnBYgy6SJTSYbKJ62F16xFXHaAqRJ4imrNpA/HpYT/W
         //xEpCHEwTJlA==
Date:   Fri, 30 Sep 2022 22:41:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 29/30] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
Message-ID: <Yzdig6GepDx34u1j@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930090653.7449-1-hal.feng@linux.starfivetech.com>
 <01c658ad-7f73-20fc-03c0-c82dcd820aa4@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c658ad-7f73-20fc-03c0-c82dcd820aa4@codethink.co.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:54:14PM +0100, Ben Dooks wrote:
> On 30/09/2022 10:06, Hal Feng wrote:
> > Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
> > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> > 
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> 
> That might be useful for other users at some point an I don't
> think it adds much code.

Honestly I think this should be applied for 6.1, for parity with the
other SoCs that have their serial console enabled by default.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> 
> > ---
> >   arch/riscv/configs/defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index aed332a9d4ea..0c44484cd3a4 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -122,6 +122,7 @@ CONFIG_MICROSEMI_PHY=y
> >   CONFIG_INPUT_MOUSEDEV=y
> >   CONFIG_SERIAL_8250=y
> >   CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_SERIAL_8250_DW=y
> >   CONFIG_SERIAL_OF_PLATFORM=y
> >   CONFIG_VIRTIO_CONSOLE=y
> >   CONFIG_HW_RANDOM=y
> 
> -- 
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius
> 
> https://www.codethink.co.uk/privacy.html
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
