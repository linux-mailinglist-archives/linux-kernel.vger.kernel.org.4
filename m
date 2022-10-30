Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442A612DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ3WqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ3WqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F75AE65;
        Sun, 30 Oct 2022 15:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87A75B810A6;
        Sun, 30 Oct 2022 22:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ADDC433D7;
        Sun, 30 Oct 2022 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667169963;
        bh=tGWr42AUVp1Ags+b6ewPYgwnBAY+EKl2aVQqVQP6HrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NydTDwnaSNUY74JE8GCIv+/KkUwQBuV6fMeTeU7Wiq2riesVlmOXm2Ye2dKGqRyqK
         4qqIh256Ivme4ZrNMb33Dxm3EIm6OOX6mRi2jJJnfw2WnCF7PjBv97qCeitpkGD3HC
         9ouMGOK23O9m2D27WXt6KfdyR1yiWZOkz8jx8azWxDwT8mjreRYeRZyIiSXDoiXJWG
         uvNHDTOhclFUfxC7jwUS+PuCSAmEyQlvoIAKytQQFgKc0/nocKq0mm+vJ+ghgDQ8VH
         O2pym4airGUh8gaTL8xiMxwfdHcWcTXo0+8V2meC1RemV2QepJ8Gy4eDaDqQWi4xSq
         bICEB+hpMs6wA==
Date:   Sun, 30 Oct 2022 22:45:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
Message-ID: <Y17+pHAg/SBJAEXq@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud>
 <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 10:37:01PM +0000, Lad, Prabhakar wrote:
> Hi Conor,
> 
> On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Hi All,
> > >
> > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > entry-class social infrastructure gateway control and industrial gateway
> > > control.
> > >
> > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > - AX45MP CPU
> > > - CPG
> > > - PINCTRL
> >
> > Hey,
> > Looks like you've got a pair of warnings here from dtbs_check. I tested
> > this on top of 20221028's next, with the three branches below merged in,
> > hopefully my merges aren't the source of them:
> >
> > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
> >         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
> >         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> >
> Thanks for the review and test. The warnings above are coming from [0]
> as support for IRQC is missing, once that is added the warnings should
> go away.

Right. I merged in the stuff in Geert's trees & I don't think I saw any
pending patches in the cover that I missed. Is there something else that
adds the support that's not going to make v6.2? I got rid of all the
dtbs_check warnings for v6.1 and I'd really like to keep things that
way!

> > With this sorted, whatever wasn't already is now:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Thanks for putting up with my messing around re: kconfig symbols and I
> > am glad that we ended up being able to share the dts across archs in the
> > end, so thanks to everyone involved in that :)
> >
> :-)
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> 
> Cheers,
> Prabhakar
