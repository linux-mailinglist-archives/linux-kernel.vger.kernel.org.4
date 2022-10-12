Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159305FCAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJLSqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJLSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:46:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49108C356E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:46:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so17040453plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=75lE3MQ+v3TpC3K4sXTfGNJ5NnNFfNVvP3YI5pGXEVU=;
        b=HUeilyR00oucNmQSC0rjmXSy5KIz/Cy0dwoPGzJznuOx1THF2WvJNm4L7aj7+z9d+t
         NCTMs0rKdshk9lSHVbjy2fHQ1W12Tsw8AXLxNRodyD1+hy5MWPhA7caOYB7Nvaxz+u4A
         2j/U5K7dh7Qz2DJOvH1rBrD0Wp0jXyq8mC89zbq2g8lw88SXGJwkm5iWvrLi4zXDjdkV
         o8vONNCiVFGmzWvEc9LFY5zF/ABFh+9glXk9fq4J5pw0XqlpMx4bkIQaaEyveoWE+Juj
         CCrtrqADmX0zVCxCxWVT/E8bM/0J66mDKDFA+TR+JpBR7rx1zoovXHQ0hgijLLAK0i3a
         /w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75lE3MQ+v3TpC3K4sXTfGNJ5NnNFfNVvP3YI5pGXEVU=;
        b=c2oJ4o1iu+7R2IByehsUi9vP2+MbcvuQyyeoW7b1e2qqqcpszrhAnYKRd9n6pGW4jR
         1vaF/SGv8b01WUSB8sBm9PtJwKxK4FBwUpHeJA9j42F/Z6HgO65ioCmkStvokqLU2T0t
         w2BOOZW8FOGjIbDxnB35zTfRk4r90nfp8aHd+aW5G7r5GZu4XRc9I2SWCMuRHIIBdoMW
         OMpFVTmannVWaR0tXXWuM9Eu1V27N3sTTW/tpGfHvefibHWQM+8MHEr/9AKYTseTQlU/
         RXPYo114TGKwtrknJxQwDT1G8CdkrlDb8IJYf76uBxwdBfw4ypaLi6aVXSmGKCpH4Q8x
         O7Dg==
X-Gm-Message-State: ACrzQf1GVaowHsgfDftOmc/tDtscbQhL2/Y8wI+KR0lesBFduDKSn+Zu
        6N8ZZ3Q2qofq4RTOv7b8KAGyxH6WOFaP53P6rElgoA==
X-Google-Smtp-Source: AMsMyM4eymRmMKqsp4GlWkBDptFD85r6fn9TvEGIfTpWoX1nXWYaXAgwq1AioXEPcu8mKsYIZY7sOZQeSxcQeN9Hwa4=
X-Received: by 2002:a17:902:eb8e:b0:17f:637b:9548 with SMTP id
 q14-20020a170902eb8e00b0017f637b9548mr30848877plg.158.1665600390666; Wed, 12
 Oct 2022 11:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
 <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com> <ec599991-44da-7b83-9374-d0043b32f053@denx.de>
In-Reply-To: <ec599991-44da-7b83-9374-d0043b32f053@denx.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 12 Oct 2022 11:46:18 -0700
Message-ID: <CAJ+vNU2g+e8_PBq0SJYOXsB6PKpMb3dmzDRA5Gyj=NJS3Ckc1g@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
To:     Marek Vasut <marex@denx.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        Markus.Niebel@ew.tq-group.com, aford173@gmail.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 4:13 PM Marek Vasut <marex@denx.de> wrote:
>
> On 10/11/22 22:10, Tim Harvey wrote:
> > On Fri, Jul 8, 2022 at 1:57 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >>
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> V4:
> >>   Because the header is not included when adding NoC node, the fsl,imx8mp.h
> >>   needs be included in this patchset. So include it in patch 6
> >>
> >> V3:
> >>   Move adding NoC node patch to i.MX8MP ICC driver patchset
> >>   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> >>
> >> V2:
> >>   Use a low bandwidth value instead INT_MAX
> >>   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
> >>   Add A-b tag from DT maintainer
> >>
> >> i.MX8MP NoC settings is invalid after related power domain up. So
> >> need to set valid values after power domain up.
> >>
> >> This patchset is to bind interconnect for each entry in blk ctrl.
> >>
> >> This patchset is not include DVFS DDRC feature.
> >>
> >> Peng Fan (7):
> >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
> >>      ctrl
> >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
> >>      ctrl
> >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
> >>      ctrl
> >>    soc: imx: add icc paths for i.MX8MP media blk ctrl
> >>    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
> >>    arm64: dts: imx8mp: add interconnects for media blk ctrl
> >>    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
> >>
> >>   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
> >>   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
> >>   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
> >>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
> >>   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
> >>   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
> >>   6 files changed, 125 insertions(+)
> >>
> >> --
> >> 2.25.1
> >>
> >
> > Hi Peng,
> >
> > I built origin/master from commit 041bc24d867a today for an imx8mp
> > board and am running into errors that appear to be introduced by this
> > series:
> > [   15.177372] platform 381f0040.usb-phy: deferred probe pending
> > [   15.183155] platform 382f0040.usb-phy: deferred probe pending
> > [   15.188928] platform 33800000.pcie: deferred probe pending
> > [   15.194439] platform 32ec0000.blk-ctrl: deferred probe pending
> > [   15.200287] platform 38330000.blk-ctrl: deferred probe pending
> > [   15.206129] platform 32f10000.blk-ctrl: deferred probe pending
> > [   15.211974] platform 32f10100.usb: deferred probe pending
> > [   15.217382] platform 32f10108.usb: deferred probe pending
> > [   15.222791] platform cpufreq-dt: deferred probe pending
> > # cat /sys/kernel/debug/devices_deferred
> > 381f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > 382f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > 33800000.pcie   platform: supplier 32f10000.blk-ctrl not ready
> > 32ec0000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > 38330000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > 32f10000.blk-ctrl       imx8mp-blk-ctrl: failed to get noc entries
> > 32f10100.usb    platform: supplier 32f10000.blk-ctrl not ready
> > 32f10108.usb    platform: supplier 32f10000.blk-ctrl not ready
> > cpufreq-dt
> >
> > Is there a driver I'm perhaps missing that is needed now or are there
> > some patches that come from a different unmerged tree needed?
>
> Do you have these enabled ?
>
> CONFIG_INTERCONNECT_IMX8MM=y
> CONFIG_INTERCONNECT_IMX8MN=y
> CONFIG_INTERCONNECT_IMX8MQ=y
> CONFIG_INTERCONNECT_IMX8MP=y

Marek,

Yes, I have those as well as CONFIG_ARCH_NXP which appears new for 6.1 enabled.

Best Regards,

Tim
