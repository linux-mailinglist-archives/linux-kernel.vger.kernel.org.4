Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C9612DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ3XCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ3XCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 19:02:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D75BC38;
        Sun, 30 Oct 2022 16:02:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so25532034ejr.2;
        Sun, 30 Oct 2022 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaZUGhF8KbynRhDhu/p6JSGKUF6OSpMhoT/g9ZSUcOw=;
        b=iTeijkDcEXUW6ozKNbAJYPxQlGhsrIS0iBQ35RDsGVc96Nazhijx6tq5zNN9OIL3qN
         rXwqAUS+F4C4HfTI+/1D4wW6bzwCzJWUZSyjWUHY6UkvW+NzLvcHMimU6u1H15nAYoyI
         sguHeEmuFmpsn8ErecjlMjbYqGivQqeC96YHpiWlLsBoWFrhuQMR8ofxPex2y8F2p7/Q
         OApPUiS2lcYU3FwuzSurmiOL1aOjgBLba5CIP5CgP3SPFKvJDZZ+xjKUbrk4MvZjjHq0
         mUWS+0jNHr2mrVa9rzIcIbtqzg5JR4dvti7LX5HQN5fUvFXK6n7UW3gD516SF/uqHuLt
         zPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaZUGhF8KbynRhDhu/p6JSGKUF6OSpMhoT/g9ZSUcOw=;
        b=cmOqVyE2tsVLoSXIApDbfgMnDd2+c5mninNgSBc/1skyeMfn1HH2bncfzZIwtX8bAw
         iZv/x1iHjE5plsSGObEwqxNbN0GOyc+LZl4PElFE25YWoeFR376VmuPevHh+xwLMrEZi
         V0BIrjc06rnBiIlw0jX55kGe5m/u73ZYgxxeeJUG9SAWf696KokyP/x1BEwiVEp45Im1
         O/TxeSlH+rZxMt9HazHHsttXo0o+lDYbo4Wv2BQb06M4uuawbEdgn4EPIJ5X2hL+FJhF
         8pOpmcQyD9ushiJs11ogulFXtnhwFJtTP/M7PgyM8ypTGz1o9GsR891/OpydhLy1pojr
         RndA==
X-Gm-Message-State: ACrzQf2AvKeLANbY25KMEwZXlxus/oo9NIdDP3QIYvA7EbBaGyQMsjmQ
        R0o4VJp9rkVp8YHAWwhbis69JFmC1n6uUvYJnVA=
X-Google-Smtp-Source: AMsMyM4Le9JGA4FBUg/iu17NYcoAoHjLMPQLet9oDZjaa/2K6RoqdC2Rp8KM7AQQXP3i3RT27yhw/78TcUXP7Cm1xqI=
X-Received: by 2002:a17:907:270b:b0:7ad:ae01:e0d9 with SMTP id
 w11-20020a170907270b00b007adae01e0d9mr9161259ejk.196.1667170926812; Sun, 30
 Oct 2022 16:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud> <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
 <Y17+pHAg/SBJAEXq@spud>
In-Reply-To: <Y17+pHAg/SBJAEXq@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 30 Oct 2022 23:01:40 +0000
Message-ID: <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Sun, Oct 30, 2022 at 10:46 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Oct 30, 2022 at 10:37:01PM +0000, Lad, Prabhakar wrote:
> > Hi Conor,
> >
> > On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Hi All,
> > > >
> > > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > > entry-class social infrastructure gateway control and industrial gateway
> > > > control.
> > > >
> > > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > > > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > - AX45MP CPU
> > > > - CPG
> > > > - PINCTRL
> > >
> > > Hey,
> > > Looks like you've got a pair of warnings here from dtbs_check. I tested
> > > this on top of 20221028's next, with the three branches below merged in,
> > > hopefully my merges aren't the source of them:
> > >
> > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
> > >         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
> > >         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > >
> > Thanks for the review and test. The warnings above are coming from [0]
> > as support for IRQC is missing, once that is added the warnings should
> > go away.
>
> Right. I merged in the stuff in Geert's trees & I don't think I saw any
> pending patches in the cover that I missed. Is there something else that
> adds the support that's not going to make v6.2? I got rid of all the
> dtbs_check warnings for v6.1 and I'd really like to keep things that
> way!
>
Sorry that pacth wasn't posted yet so I hadn't mentioned it in the
cover letter. I'll make sure I get it posted asap and merged for v6.2.

Cheers,
Prabhakar
