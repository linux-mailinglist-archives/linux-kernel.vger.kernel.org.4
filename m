Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A0612D93
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ3Whb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Wh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:37:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C722ABA5;
        Sun, 30 Oct 2022 15:37:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sc25so25348315ejc.12;
        Sun, 30 Oct 2022 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mvvzkff6DOL85U8amZ/DXhVJ4JENLNiq7XjnHhrGMvs=;
        b=f0QVCDZ5EVWlrUN1rKoSG+yS/A2K3M7mCkQ4bxP3jzMM/+mMruxSV5Usb/toSwsPBU
         RDjIqyagVzNRtdtTfqq7srhGfEWj70L+F0p1VlBdWpDl8A+1wpBB+MYo17QOF2lr8lJP
         wMqRerhgoRq7Tq3tubk2FH61N9zB1PNJ+PxSpdvet4Em/xVtxiMVpvrwzeqL1s6VuSOx
         oKCkeNTXo4vbJGuN9vW756plKb4qoj6zSoiJFGBUeYM28Ipm5ZD+PXrMsM5WL6zzRm02
         8zL2Zbh1DBl1tuiqY/oBA2wLMPJ6N0ihjW5UekqaI0m+sdIcVPDlpws3W+Dd6hhEJ9kf
         RhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvvzkff6DOL85U8amZ/DXhVJ4JENLNiq7XjnHhrGMvs=;
        b=Hk6t5kpx1T1VoejWInFFOcGA1HnNQJAqWlwVpW76xn4mdxaI2U7PVDZAouJZITkP0w
         yz1BpKaN9gsuAPLP1dD5BGpbBPpsHctEtuUqFQ8Xpw3vy7M51P994Y6rIjHYBv0JGdnN
         gaIby0lMrYyzH3EBtMZBz0U/Lvw1NHo/PS3oSCgzIz56YlZ09f9dNPfuxgCf94KvfBLT
         voA6zf+MLm99w7UhgLQpOwAxc0J7LntmE+Lzk7LylrkrCE7EL4cRs56RHFszObi7j3MA
         +ctzxiZHqF46QlWiLC62IX/vp2lCa9QEC8hD/lVtn3CgJpYCKd8zO1fDblWnNcKPUk71
         tXPg==
X-Gm-Message-State: ACrzQf2VAGPlQk+QMh+9aO89+f+SN2nEXiWpP4hANjNFj8G8Wz+XxaRr
        DDgwh7OqrQqHXpiB3RJRBgRi7uuMApmvxgV39Gg=
X-Google-Smtp-Source: AMsMyM4K4QK9yJsrNxEButWAcDD9G1p0AEwb26nEyCEdPv2RRCmrAW1IeJm/NMhanC2p48KjJY79xk+O5lrVh8jmUwA=
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id
 ww7-20020a170907084700b0077ff489cc25mr9809377ejb.80.1667169447405; Sun, 30
 Oct 2022 15:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y17BWPuEcmY7Bba3@spud>
In-Reply-To: <Y17BWPuEcmY7Bba3@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 30 Oct 2022 22:37:01 +0000
Message-ID: <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
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

On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi All,
> >
> > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > entry-class social infrastructure gateway control and industrial gateway
> > control.
> >
> > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - CPG
> > - PINCTRL
>
> Hey,
> Looks like you've got a pair of warnings here from dtbs_check. I tested
> this on top of 20221028's next, with the three branches below merged in,
> hopefully my merges aren't the source of them:
>
> linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
>         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
>         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
>
Thanks for the review and test. The warnings above are coming from [0]
as support for IRQC is missing, once that is added the warnings should
go away.

> With this sorted, whatever wasn't already is now:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Thanks for putting up with my messing around re: kconfig symbols and I
> am glad that we ended up being able to share the dts across archs in the
> end, so thanks to everyone involved in that :)
>
:-)

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r9a07g043.dtsi

Cheers,
Prabhakar
