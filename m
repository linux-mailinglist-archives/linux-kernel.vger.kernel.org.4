Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895A5BEEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiITUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:43:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395AD76956;
        Tue, 20 Sep 2022 13:43:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lh5so9022709ejb.10;
        Tue, 20 Sep 2022 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jBYi/prDHJ/YGLg3ZKqzYTis+OjXr+YK/sv9ncXaUME=;
        b=f/j4uuGL/tiflOwbHSPnTfIVpPgul7i097N3hMDMg4++9IX/1bDaTHNvhOBfyAkZEN
         jKIcyIOZMs4Kh/yrkIPYLZR6IO8fC6C+GrfWs6Sx0FPUg7Jj2+skO6lRjCzZLMnOWzG1
         8Qtcf4zKz/H1K2M3LmtxkN5dcrBh26fSP3P6mP4cJeSfVCBGNDJGq3Yd5E04/8YcSwCh
         ByyD+vJokLDEs2sjcMtyD9ctOSMd7EfxeYwkqxWfAHG6jDWJflhQRkY1SFhCTkfUZOF5
         xQNC9teg/8VczSx+4nekCCX9QOLGtLm9oRXR8HKXiB0Pt6gjk4IvvSEXOETQ08GcVgq3
         nKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jBYi/prDHJ/YGLg3ZKqzYTis+OjXr+YK/sv9ncXaUME=;
        b=cfmqvignVkCxIB+Wwg0wLbFdbcNdj6w0vT8PNzUTjg3BEgdOhREs1EZ5tV4OeYtMmZ
         kBLiQTy7D4RhZylk2wACGvnNby/pyPzd4/Y39S/aDDp0MYFXliRMpu/CW/pjVRqvVODG
         GaCLs5zCNrUIMSR0HV9byizLnewhSjvenZofds4b1x/pXjaKxmwoh7P3MwhxBNoXbjPW
         qcuBaG/28824xxf8HI7ctJ2ZR/ATZ4U26M9lCacjlrIpyQqGTq7mXePI5Sudg4CrmXBh
         kdc/Fdsz+O2/zRYrRuDvKc+R3KPDdSuxaTvnkks/wXjX6Nv4SMNDHzPlGR1x3mR0cvTJ
         24AA==
X-Gm-Message-State: ACrzQf1uK4HsbtrGWIb8PKYz2ESVFEwXp/OtOR8IcL5Cbbg76kQ4YUEO
        APhjS3s7pjYS0q5VLBENLqNHSGQfl1Ne57ZKR3Q=
X-Google-Smtp-Source: AMsMyM6FV3L2vQq/kixJuKIe7/X+wQ6X2iewUO6IInLUgnMmhdJnYUKGmuB5aDLmUdLhuC3e/QjxVBFENBPqjleSzlk=
X-Received: by 2002:a17:907:3f93:b0:780:1b17:1160 with SMTP id
 hr19-20020a1709073f9300b007801b171160mr18182563ejc.196.1663706621629; Tue, 20
 Sep 2022 13:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyoSgGlkIB8GMog8@spud> <CAMuHMdXfkX-AOusfOn-6fmaJavWWoD1mW8QNqUCUdkHuz=3FsA@mail.gmail.com>
 <YyoWlSQPWVnkaU+T@spud>
In-Reply-To: <YyoWlSQPWVnkaU+T@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 20 Sep 2022 21:43:14 +0100
Message-ID: <CA+V-a8uLD4zbxuN0GJ+Augwiu=oH_FnQ7+muQU30zdoxMxrBAw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
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

Thank you for the review.

On Tue, Sep 20, 2022 at 8:38 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 09:24:05PM +0200, Geert Uytterhoeven wrote:
> > Hi Conor,
> >
> > On Tue, Sep 20, 2022 at 9:20 PM Conor Dooley <conor@kernel.org> wrote:
> > > On Tue, Sep 20, 2022 at 07:48:54PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > > entry-class social infrastructure gateway control and industrial gateway
> > > > control.
> > > >
> > > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > > (R9A07G043) SoC and updates the bindings for the same. Below is the list
> > > > of IP blocks added in the initial SoC DTSI which can be used to boot via
> > > > initramfs on RZ/Five SMARC EVK:
> > > > - AX45MP CPU
> > > > - CPG
> > > > - PINCTRL
> > > > - PLIC
> > > > - SCIF0
> > > > - SYSC
> > >
> > > Ran into one complaint from dtbs_check:
> > > arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c50200: '#phy-cells' is a required property
> > >         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
> > > arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c70200: '#phy-cells' is a required property
> > >         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
> > >
> > > Other than that which should be a trivial fix the whole lot looks good
> > > to me...
> >
> > That's due to the placeholders...
>
> Right, but #phy-cells will be added into the usb-phys once you (plural)
> figure out how to integrate with the existing CMO stuff?
>
Yes indeed.

> > Currently it is not yet a requirement that "make dtbs_check" is warning-free.
>
> I was really hoping that it could be a requirement for 6.1 onwards. I've
> managed to clear all of the other ones from arch/riscv.
>
Maybe i'll fix it and respin the series (along with the Kconfig.socs sorted).

Cheers,
Prabhakar
