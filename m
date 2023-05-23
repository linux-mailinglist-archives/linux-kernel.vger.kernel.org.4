Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311770D97E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjEWJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbjEWJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:48:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA685E4B;
        Tue, 23 May 2023 02:47:58 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39212bf4ff0so3948172b6e.1;
        Tue, 23 May 2023 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684835278; x=1687427278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq7CNPaF4NbXPimNw4H7TDkWjTz2SdZxq4zob7zuH7s=;
        b=FPIzkfBl6Z4fOQadR+ItT5mRFzrpgGP30SMMNKl21h6elyzGRKew/4yIP2FBL0GzHh
         /3YfyDePzf6Sn3TQOi+FnFerc2tvGJuyuCjXBYAPmfukGy1h4Mp48yTVwcvN3mfcDN2x
         EsKEry9bUgctWJ5RqDJ0UZVrND1hUF7VFNjovcv1j7X6UxVt28k4iHL/2gTLGwWjeXF1
         Rxjr93lT+rGQZ9HKBMGfHyD3QDi6Ya/f9jJRgKy/qdJvJ5Q4hpZqsyd7GKTz32WERg7x
         6hA6bQod6AcZeFX4s0H2mvT5TwAINR36WEg0fPy3ncBTWlj2jifXkReTg3aZorgYwFJv
         6OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835278; x=1687427278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq7CNPaF4NbXPimNw4H7TDkWjTz2SdZxq4zob7zuH7s=;
        b=QDZc6pGqmzlOG5St+bO1VR+UVXUk2WUIveCL0O05GWMZaG+giwFSHXeg7zx8mJx2qy
         tRgk/O3WPI+IRUiN2fyi5UxoModJxHwqLNO81HIQKudPQaP8oqgB2i7lzbsWkcLgkkdZ
         TN1hM3qLklofqr/dEdX8YqUgpM0ZZlI0ivhecnzVzEaHIxBo8A5nZ3Zvt8TFzxf20Hxj
         Dz+U98eqZE31KZYyVEhs6xnEOYexEObfXtVJyzMtH9a2QJz2gG1p4S1ktmzfGxLQJQEm
         sd4ZjcIGWFokpnlqmaap4al/74pEdraSx61qcatfkuEbtkeRp/pw8oew4cVjIen5Y1a2
         l30w==
X-Gm-Message-State: AC+VfDz1tbwnXOk6jwIwBskroNaFCod7aET7bclUj0qkd5iINd4pLC2/
        znVfIpYhE4amR4Qs0mIvJ5na97dXLb6QB4Dd1APWpjod
X-Google-Smtp-Source: ACHHUZ4zBGa6aopRQ69KB08F4/g/QRlURihGVyQ02JlWgdGnUnrxk5nRaquQO17MWhgOsTmD0PFDkNIPZNvYviDfjAw=
X-Received: by 2002:a05:6808:3ce:b0:395:dd8c:f833 with SMTP id
 o14-20020a05680803ce00b00395dd8cf833mr7348653oie.27.1684835277778; Tue, 23
 May 2023 02:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com> <CAMhs-H_yn_76RAFNk4ux_-rn9FdKna9Vsu0raFQXfr3ykkRWPw@mail.gmail.com>
In-Reply-To: <CAMhs-H_yn_76RAFNk4ux_-rn9FdKna9Vsu0raFQXfr3ykkRWPw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 23 May 2023 11:47:46 +0200
Message-ID: <CAMhs-H_NxauVCL7Sc7SWBk4dTQ8CyqLbPnTZO66VAqycPoOyTw@mail.gmail.com>
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

On Thu, May 4, 2023 at 4:48=E2=80=AFPM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Tue, Apr 18, 2023 at 11:03=E2=80=AFAM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi all!
> >
> > This patchset is a big effort to properly implement a clock and reset
> > driver for old ralink SoCs. This allow to properly define clocks in
> > device tree and avoid to use fixed-clocks directly from 'arch/mips/rali=
nk'
> > architecture directory code.
> >
> > Device tree 'sysc' node will be both clock and reset provider using
> > 'clock-cells' and 'reset-cells' properties.
> >
> > The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT3350,
> > RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
> > this new driver has been extracted from 'arch/mips/ralink' and cleanly
> > put using kernel clock and reset driver APIs. The clock plans for this
> > SoCs only talks about relation between CPU frequency and BUS frequency.
> > This relation is different depending on the particular SoC. CPU clock i=
s
> > derived from XTAL frequencies.
> >
> >  Depending on the SoC we have the following frequencies:
> >  * RT2880 SoC:
> >      - XTAL: 40 MHz.
> >      - CPU: 250, 266, 280 or 300 MHz.
> >      - BUS: CPU / 2 MHz.
> >   * RT3050, RT3052, RT3350:
> >      - XTAL: 40 MHz.
> >      - CPU: 320 or 384 MHz.
> >      - BUS: CPU / 3 MHz.
> >   * RT3352:
> >      - XTAL: 40 MHz.
> >      - CPU: 384 or 400 MHz.
> >      - BUS: CPU / 3 MHz.
> >      - PERIPH: 40 MHz.
> >   * RT3383:
> >      - XTAL: 40 MHz.
> >      - CPU: 250, 384, 480 or 500 MHz.
> >      - BUS: Depends on RAM Type and CPU:
> >        + RAM DDR2: 125. ELSE 83 MHz.
> >        + RAM DDR2: 128. ELSE 96 MHz.
> >        + RAM DDR2: 160. ELSE 120 MHz.
> >        + RAM DDR2: 166. ELSE 125 MHz.
> >   * RT5350:
> >       - XTAL: 40 MHz.
> >       - CPU: 300, 320 or 360 MHz.
> >       - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
> >       - PERIPH: 40 MHz.
> >   * MT7628 and MT7688:
> >      - XTAL: 20 MHz or 40 MHz.
> >      - CPU: 575 or 580 MHz.
> >      - BUS: CPU / 3.
> >      - PCMI2S: 480 MHz.
> >      - PERIPH: 40 MHz.
> >   * MT7620:
> >      - XTAL: 20 MHz or 40 MHz.
> >      - PLL: XTAL, 480, 600 MHz.
> >      - CPU: depends on PLL and some mult and dividers.
> >      - BUS: depends on PLL and some mult and dividers.
> >      - PERIPH: 40 or XTAL MHz.
> >
> > MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch=
 of
> > register reads and predividers. To derive CPU and BUS frequencies in th=
e
> > MT7620 SoC 'mt7620_calc_rate()' helper is used.
> > In the case XTAL can have different frequencies and we need a different
> > clock frequency for peripherals 'periph' clock in introduced.
> > The rest of the peripherals present in the SoC just follow their parent
> > frequencies.
> >
> > I am using 'mtmips' inside for ralink clock driver. This is aligned wit=
h
> > pinctrl series recently merged through pinctrl git tree [0].
> >
> > I am maintaining ralink as prefix for compatible strings after discussi=
ons
> > between Rob and Arinc in v2 of this series [1].
> >
> > Changes have been compile tested for:
> > - RT2880
> > - RT3883
> > - MT7620
> >
> > Changes have been properly tested in RT5350 SoC based board (ALL5003 bo=
ard)
> > resulting in a working platform.
> >
> > Dts files for these SoCs in-tree except MT7621 are incomplete. We are
> > planning to align with openWRT files at some point and add extra needed
> > changes. Hence I am not touching them at all in these series. If this i=
s
> > a problem, please let me know and I will update them.
> >
> > Talking about merging this series I'd like all of the patches going thr=
ough
> > the MIPS tree if possible.
> >
> > Thanks in advance for your time.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > Changes in v3:
> > - Address Stephen comments in v2:
> >     + Drop unsused include '<linux/clk.h>'.
> >     + Add fixed and factor clocks when it makes sense.
> >     + Make 'mtmips_periph_clk_ops' named variable.
> >     + WARN_ON -> WARN_ON_ONCE.
> >     + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs_i=
nit'.
> >     + Don't validate the bindings in the driver.
> >     + Make const 'struct clk_init_data' used inside macros.
> >     + do_div -> div_u64.
> >     + Make use of dev_err_probe.
>
> Hi Stephen,
>
> Does anything else need to be addressed to have all of these added?
>
> Philipp, can you please review the reset related code in PATCH 2/9 of
> these series?
>
> Thanks in advance for your time!
>
> Best regards,
>     Sergio Paracuellos

Gentle ping for this series :-)

Thanks,
    Sergio Paracuellos
>
> >
> > Changes in v2:
> > - Address bindings documentation changes pointed out by Krzysztof:
> >     + Rename the file into 'mediatek,mtmips-sysc.yaml'.
> >     + Redo commit subject and log message.
> >     + Order compatibles alphabetically.
> >     + Redo bindings description taking into account this is a system
> >       controller node which provides both clocks and resets to the worl=
d.
> >     + Drop label from example.
> >     + Use 'syscon' as node name in example.
> >     + Drop no sense 'ralink,rt2880-reset' compatible string
> > - Squash patches 6 and 7 together as pointed out by Stephen Boyd.
> >
> > Previoous series:
> > v2: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22uibQ1=
DnaZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#t
> > v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.p=
aracuellos@gmail.com/T/#t
> >
> > [0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b=
06185@arinc9.com/T/#t
> > [1]: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22uibQ=
1DnaZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#mfe725b6e3382c6fb09736472a846cbbc=
84f264dc
> >
> > Sergio Paracuellos (9):
> >   dt-bindings: clock: add mtmips SoCs system controller
> >   clk: ralink: add clock and reset driver for MTMIPS SoCs
> >   mips: ralink: rt288x: remove clock related code
> >   mips: ralink: rt305x: remove clock related code
> >   mips: ralink: rt3883: remove clock related code
> >   mips: ralink: mt7620: remove clock related code
> >   mips: ralink: remove reset related code
> >   mips: ralink: get cpu rate from new driver code
> >   MAINTAINERS: add Mediatek MTMIPS Clock maintainer
> >
> >  .../bindings/clock/mediatek,mtmips-sysc.yaml  |   65 +
> >  MAINTAINERS                                   |    6 +
> >  arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
> >  arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
> >  arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
> >  arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
> >  arch/mips/ralink/clk.c                        |   26 +-
> >  arch/mips/ralink/common.h                     |    5 -
> >  arch/mips/ralink/mt7620.c                     |  226 ----
> >  arch/mips/ralink/of.c                         |    4 -
> >  arch/mips/ralink/reset.c                      |   61 -
> >  arch/mips/ralink/rt288x.c                     |   31 -
> >  arch/mips/ralink/rt305x.c                     |   78 --
> >  arch/mips/ralink/rt3883.c                     |   44 -
> >  drivers/clk/ralink/Kconfig                    |    7 +
> >  drivers/clk/ralink/Makefile                   |    1 +
> >  drivers/clk/ralink/clk-mtmips.c               | 1134 +++++++++++++++++
> >  17 files changed, 1232 insertions(+), 530 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt=
mips-sysc.yaml
> >  create mode 100644 drivers/clk/ralink/clk-mtmips.c
> >
> > --
> > 2.25.1
> >
