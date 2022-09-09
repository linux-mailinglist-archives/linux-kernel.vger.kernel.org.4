Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8674A5B3BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIIP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiIIPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:25:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DEE72EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:25:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fs14so1829294pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KQ7mx//Yg3b2on5K+GcpEYxceEeGkrI8LOMH1KIOtyM=;
        b=apSZrIUd0edt1e799SLrlrQR3GXfeVcUUKtqogNKmO7yvEgyM+r5QdzvwENRWZsvi4
         wYUC4Llu/OW541iIwi2uuN+0LvpCKCnIhDLiy6LD7cXmeko44lBKFLIJb8g4o+1kv88j
         nIgBmeaeoiVlluHT3HvfbgN3Jvq1Kwr30az76zrtzPPlIanPcBoHZ8Yo4hLq2CIYXuUF
         ci9NkrxM6NVa26MZxzaG9luuGMzvyRho8O3DSuIPcsG2RhjNsfSQvettqeZ1qzVQIxO7
         8y0Oeoxh+F8E3Krunu/YzI+bMe8eyYVA498tjMRJ1WbOKZuo/KVMNLIYVq9CEyHuACp5
         0hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KQ7mx//Yg3b2on5K+GcpEYxceEeGkrI8LOMH1KIOtyM=;
        b=W21eDn8+2x6BD/F92RaiASoyGGQOn2zNaahgI6g/zNvMn6+FYxsH3aDS+tiTMxngDF
         SPvePPAFyI6YIXNetlM4hW/Db115egz2ZauDqxh/B3J656cYRq/F8TYzTIHPXwrND1Nw
         VeH+oM5kFQnl32NASXeRYWQShDpGoTC1Lv7Es5TmFWi2TAaD3N22uCgFP0Sg5mmmxgrZ
         +kC7HaElwXjf78ZlsjBQdIH0lzQF4SDlemnsvqG/lBlAeDru0LoD6RSWss+8Rwrv3tZk
         RotZfzYjlM3cKrSWUflkwrF+F7f5kYdawauoyORhAnpoD+q8miBMfU1JrdYneb9DwKFx
         TVjQ==
X-Gm-Message-State: ACgBeo2jJYU52Zqrt14zqYNIGV5kMO13w8E6dzFU/F0gcJM/AURnIcw4
        nAC7sdbuSXIceL/gCgmST2MIIQD04D6AJoaFvAzmJw==
X-Google-Smtp-Source: AA6agR70u57I14PlxIWQrF1g1H8PEpE9+18WBH6uHadtu50fnLZueSFTpB0VIM5c6Xnie3UVTtcGT/NvGN/j7P2b5Sg=
X-Received: by 2002:a17:903:41c6:b0:174:3acf:8294 with SMTP id
 u6-20020a17090341c600b001743acf8294mr14185533ple.118.1662737147158; Fri, 09
 Sep 2022 08:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220902230500.2624739-1-tharvey@gateworks.com>
 <20220908211916.GA3348959-robh@kernel.org> <CAJ+vNU1NEYWvev3s=1rPPNCRovBqa0p=JTXLHLpV7fOWf-dFLg@mail.gmail.com>
 <a24f920b-60e2-f32b-96e5-9bafee6be8e6@kernel.org>
In-Reply-To: <a24f920b-60e2-f32b-96e5-9bafee6be8e6@kernel.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 9 Sep 2022 08:25:35 -0700
Message-ID: <CAJ+vNU1a3CoCYWsVf52Nrta2Mb635j0zF54mwCHWdHw1U=2x3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904 board
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 1:03 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/09/2022 23:44, Tim Harvey wrote:
> > On Thu, Sep 8, 2022 at 2:19 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Fri, Sep 02, 2022 at 04:04:59PM -0700, Tim Harvey wrote:
> >>> Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
> >>>
> >>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >>> Cc: Shawn Guo <shawnguo@kernel.org>
> >>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> >>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> >>> Cc: Fabio Estevam <festevam@gmail.com>
> >>> Cc: NXP Linux Team <linux-imx@nxp.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> index 7431579ab0e8..ce89fac1898e 100644
> >>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> >>> @@ -831,6 +831,7 @@ properties:
> >>>                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
> >>>                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
> >>>                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> >>> +              - gateworks,imx8mm-gw7904   # i.MX8MM Gateworks Board
> >>
> >> A useful comment would be ones that distuiguish these boards. It's
> >> obvious from the compatible it's a i.MX8MM board from Gateworks.
> >
> > But isn't it clear that you need to go to the device-tree itself to
> > understand the details?
> >
> > As far as basic features go sometimes there is very little difference
> > in these board models. It would be a struggle to list all the board
> > details (which I do in the dts commit) in a way that doesn't take up
> > too much space in fsl.yaml.
> >
>
> But then the comment you added is useless. So either add useful comment
> or no comment. :)
>
>
> Best regards,
> Krzysztof

Krzysztof,

so are you saying that no comment is fine here as well? It seems to me
that most of the comments in that file look just like mine which I
agree are about just as descriptive as the compatible string.

For discussion purposes here is for example the commit log for the GW7904 dts:
    The GW7904 is based on the i.MX 8M Mini SoC featuring:
     - LPDDR4 DRAM
     - eMMC FLASH
     - microSD connector with UHS support
     - LIS2DE12 3-axis accelerometer
     - Gateworks System Controller
     - IMX8M FEC
     - 2x RS232 off-board connectors
     - PMIC
     - 10x bi-color LED's
     - 1x miniPCIe socket with PCIe and USB2.0
     - 802.3at Class 4 PoE
     - 10-30VDC input via barrel-jack

And the comit log for the very similar GW7903 dts:
    The GW7903 is based on the i.MX 8M Mini SoC featuring:
     - LPDDR4 DRAM
     - eMMC FLASH
     - microSD connector with UHS support
     - LIS2DE12 3-axis accelerometer
     - Gateworks System Controller
     - IMX8M FEC
     - software selectable RS232/RS485/RS422 serial transceiver
     - PMIC
     - 2x off-board bi-directional opto-isolated digital I/O
     - 1x M.2 A-E Key Socket and 1x MiniPCIe socket with USB2.0 and PCIe
       (resistor loading to route PCIe/USB2 between M.2 and MiniPCIe socket)

Best Regards,

Tim
