Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE289732728
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbjFPGMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjFPGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:12:14 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED115B5;
        Thu, 15 Jun 2023 23:12:12 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b29c972e00so360897a34.1;
        Thu, 15 Jun 2023 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686895932; x=1689487932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CSaXs0eFLJ36oQsTTT9AFk9l+dE317zySSzaD6qHgs=;
        b=cnVWKBe5LJv1ezLSjmN7drpWFhndVUocnLO8oo/0xO0wPy/iJWsvfq+xliFdkIzMWr
         mt4jCQZwHxinDisi0v1FD7WIhyU2rc6r3J40QFZB4UYbAHvJKVCamXePyrtqrpCoUa+I
         fnmM4/oM/b7guUok0tTofDsQkJGrw9fXwL9TpcAtTB1y7U4rnmGabB47KXXJDPVxuC1U
         Nn/1fIpPZ9gVw1BaM/Vi11YXlZxvYeItCY+lIOnjLQTWB/5Ci8ywKcVCBBzzG74vxrcI
         ZjaWcD39mpWHKLQ6nVvKjNeS5pTpEK3BPkFcXRlbqr9+cMyvwLW5JZilFCqr2ldKz7Mk
         yn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686895932; x=1689487932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CSaXs0eFLJ36oQsTTT9AFk9l+dE317zySSzaD6qHgs=;
        b=LkmNXds280XCewznCbSPGxp8rHfh9tT231XgDJ0pRipBvwLI/uHKwwk1RhBJB4UMRn
         +B/WHkNvR2lTCzaX0B78cPFNrolawlbKAAAf7J9TvjFhl9lm9w97uepYhZOggv46dQTs
         n3BRZp9JVPDtl9hCCyLYXWeHpm4yGyk03nyJQ/gPWwruOFhvn9vnlvJlgpi1f0jemL+m
         GnL27Tu36SVwuSDxxxJ8CjYU8R8LAYzwf7HHBuxOvHahIIZsx7GGFR3eScAnfOAJR32Y
         Mt83D68bm5o/zcAqqWOr2l0L6RVZuCC6x40/tVUmMN+03RlrzqCvAGosNRYSXgJlp04A
         2JFg==
X-Gm-Message-State: AC+VfDyuHTGBTrc45peFgDq9rI/CJAJm9cYiWbACxYuwZqcPvpTUSuDi
        vvtgdI6Rnyc6m6iwf+OSVp9AFb8lUbbx0uX3FqIaCydF
X-Google-Smtp-Source: ACHHUZ5hWP4DO7juzhR2qpohpE+ro+/WLkTS5zWNFX/FHZn5K4YovziUWdH7oW9MRDWHS6n7AUele8zeDqj/jH22z1M=
X-Received: by 2002:a05:6870:d8b1:b0:1a9:a12d:f7b8 with SMTP id
 dv49-20020a056870d8b100b001a9a12df7b8mr985454oab.41.1686895931804; Thu, 15
 Jun 2023 23:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
 <CAMhs-H_yn_76RAFNk4ux_-rn9FdKna9Vsu0raFQXfr3ykkRWPw@mail.gmail.com> <CAMhs-H_NxauVCL7Sc7SWBk4dTQ8CyqLbPnTZO66VAqycPoOyTw@mail.gmail.com>
In-Reply-To: <CAMhs-H_NxauVCL7Sc7SWBk4dTQ8CyqLbPnTZO66VAqycPoOyTw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 16 Jun 2023 08:12:00 +0200
Message-ID: <CAMhs-H8R4oz=Hs8y=3-R15hkySPEO4scookZ_shPzEbQoAyTKA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] mips: ralink: add complete clock and reset driver
 for mtmips SoCs
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:47=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Thu, May 4, 2023 at 4:48=E2=80=AFPM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > On Tue, Apr 18, 2023 at 11:03=E2=80=AFAM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > Hi all!
> > >
> > > This patchset is a big effort to properly implement a clock and reset
> > > driver for old ralink SoCs. This allow to properly define clocks in
> > > device tree and avoid to use fixed-clocks directly from 'arch/mips/ra=
link'
> > > architecture directory code.
> > >
> > > Device tree 'sysc' node will be both clock and reset provider using
> > > 'clock-cells' and 'reset-cells' properties.
> > >
> > > The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT335=
0,
> > > RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
> > > this new driver has been extracted from 'arch/mips/ralink' and cleanl=
y
> > > put using kernel clock and reset driver APIs. The clock plans for thi=
s
> > > SoCs only talks about relation between CPU frequency and BUS frequenc=
y.
> > > This relation is different depending on the particular SoC. CPU clock=
 is
> > > derived from XTAL frequencies.
> > >
> > >  Depending on the SoC we have the following frequencies:
> > >  * RT2880 SoC:
> > >      - XTAL: 40 MHz.
> > >      - CPU: 250, 266, 280 or 300 MHz.
> > >      - BUS: CPU / 2 MHz.
> > >   * RT3050, RT3052, RT3350:
> > >      - XTAL: 40 MHz.
> > >      - CPU: 320 or 384 MHz.
> > >      - BUS: CPU / 3 MHz.
> > >   * RT3352:
> > >      - XTAL: 40 MHz.
> > >      - CPU: 384 or 400 MHz.
> > >      - BUS: CPU / 3 MHz.
> > >      - PERIPH: 40 MHz.
> > >   * RT3383:
> > >      - XTAL: 40 MHz.
> > >      - CPU: 250, 384, 480 or 500 MHz.
> > >      - BUS: Depends on RAM Type and CPU:
> > >        + RAM DDR2: 125. ELSE 83 MHz.
> > >        + RAM DDR2: 128. ELSE 96 MHz.
> > >        + RAM DDR2: 160. ELSE 120 MHz.
> > >        + RAM DDR2: 166. ELSE 125 MHz.
> > >   * RT5350:
> > >       - XTAL: 40 MHz.
> > >       - CPU: 300, 320 or 360 MHz.
> > >       - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
> > >       - PERIPH: 40 MHz.
> > >   * MT7628 and MT7688:
> > >      - XTAL: 20 MHz or 40 MHz.
> > >      - CPU: 575 or 580 MHz.
> > >      - BUS: CPU / 3.
> > >      - PCMI2S: 480 MHz.
> > >      - PERIPH: 40 MHz.
> > >   * MT7620:
> > >      - XTAL: 20 MHz or 40 MHz.
> > >      - PLL: XTAL, 480, 600 MHz.
> > >      - CPU: depends on PLL and some mult and dividers.
> > >      - BUS: depends on PLL and some mult and dividers.
> > >      - PERIPH: 40 or XTAL MHz.
> > >
> > > MT7620 is a bit more complex deriving CPU clock from a PLL and an bun=
ch of
> > > register reads and predividers. To derive CPU and BUS frequencies in =
the
> > > MT7620 SoC 'mt7620_calc_rate()' helper is used.
> > > In the case XTAL can have different frequencies and we need a differe=
nt
> > > clock frequency for peripherals 'periph' clock in introduced.
> > > The rest of the peripherals present in the SoC just follow their pare=
nt
> > > frequencies.
> > >
> > > I am using 'mtmips' inside for ralink clock driver. This is aligned w=
ith
> > > pinctrl series recently merged through pinctrl git tree [0].
> > >
> > > I am maintaining ralink as prefix for compatible strings after discus=
sions
> > > between Rob and Arinc in v2 of this series [1].
> > >
> > > Changes have been compile tested for:
> > > - RT2880
> > > - RT3883
> > > - MT7620
> > >
> > > Changes have been properly tested in RT5350 SoC based board (ALL5003 =
board)
> > > resulting in a working platform.
> > >
> > > Dts files for these SoCs in-tree except MT7621 are incomplete. We are
> > > planning to align with openWRT files at some point and add extra need=
ed
> > > changes. Hence I am not touching them at all in these series. If this=
 is
> > > a problem, please let me know and I will update them.
> > >
> > > Talking about merging this series I'd like all of the patches going t=
hrough
> > > the MIPS tree if possible.
> > >
> > > Thanks in advance for your time.
> > >
> > > Best regards,
> > >     Sergio Paracuellos
> > >
> > > Changes in v3:
> > > - Address Stephen comments in v2:
> > >     + Drop unsused include '<linux/clk.h>'.
> > >     + Add fixed and factor clocks when it makes sense.
> > >     + Make 'mtmips_periph_clk_ops' named variable.
> > >     + WARN_ON -> WARN_ON_ONCE.
> > >     + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs=
_init'.
> > >     + Don't validate the bindings in the driver.
> > >     + Make const 'struct clk_init_data' used inside macros.
> > >     + do_div -> div_u64.
> > >     + Make use of dev_err_probe.
> >
> > Hi Stephen,
> >
> > Does anything else need to be addressed to have all of these added?
> >
> > Philipp, can you please review the reset related code in PATCH 2/9 of
> > these series?
> >
> > Thanks in advance for your time!
> >
> > Best regards,
> >     Sergio Paracuellos
>
> Gentle ping for this series :-)

Another gentle ping for this series :-)

Thanks,
    Sergio Paracuellos
>
> Thanks,
>     Sergio Paracuellos
> >
> > >
> > > Changes in v2:
> > > - Address bindings documentation changes pointed out by Krzysztof:
> > >     + Rename the file into 'mediatek,mtmips-sysc.yaml'.
> > >     + Redo commit subject and log message.
> > >     + Order compatibles alphabetically.
> > >     + Redo bindings description taking into account this is a system
> > >       controller node which provides both clocks and resets to the wo=
rld.
> > >     + Drop label from example.
> > >     + Use 'syscon' as node name in example.
> > >     + Drop no sense 'ralink,rt2880-reset' compatible string
> > > - Squash patches 6 and 7 together as pointed out by Stephen Boyd.
> > >
> > > Previoous series:
> > > v2: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22uib=
Q1DnaZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#t
> > > v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio=
.paracuellos@gmail.com/T/#t
> > >
> > > [0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a30=
2b06185@arinc9.com/T/#t
> > > [1]: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22ui=
bQ1DnaZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#mfe725b6e3382c6fb09736472a846cb=
bc84f264dc
> > >
> > > Sergio Paracuellos (9):
> > >   dt-bindings: clock: add mtmips SoCs system controller
> > >   clk: ralink: add clock and reset driver for MTMIPS SoCs
> > >   mips: ralink: rt288x: remove clock related code
> > >   mips: ralink: rt305x: remove clock related code
> > >   mips: ralink: rt3883: remove clock related code
> > >   mips: ralink: mt7620: remove clock related code
> > >   mips: ralink: remove reset related code
> > >   mips: ralink: get cpu rate from new driver code
> > >   MAINTAINERS: add Mediatek MTMIPS Clock maintainer
> > >
> > >  .../bindings/clock/mediatek,mtmips-sysc.yaml  |   65 +
> > >  MAINTAINERS                                   |    6 +
> > >  arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
> > >  arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
> > >  arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
> > >  arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
> > >  arch/mips/ralink/clk.c                        |   26 +-
> > >  arch/mips/ralink/common.h                     |    5 -
> > >  arch/mips/ralink/mt7620.c                     |  226 ----
> > >  arch/mips/ralink/of.c                         |    4 -
> > >  arch/mips/ralink/reset.c                      |   61 -
> > >  arch/mips/ralink/rt288x.c                     |   31 -
> > >  arch/mips/ralink/rt305x.c                     |   78 --
> > >  arch/mips/ralink/rt3883.c                     |   44 -
> > >  drivers/clk/ralink/Kconfig                    |    7 +
> > >  drivers/clk/ralink/Makefile                   |    1 +
> > >  drivers/clk/ralink/clk-mtmips.c               | 1134 +++++++++++++++=
++
> > >  17 files changed, 1232 insertions(+), 530 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,=
mtmips-sysc.yaml
> > >  create mode 100644 drivers/clk/ralink/clk-mtmips.c
> > >
> > > --
> > > 2.25.1
> > >
