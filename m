Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D66016B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJQSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:54:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCBE753B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:54:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fw14so11794375pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f7KtqTi95dNlIXBr82ROSzqQ+Z/5nBJP58a9h9OcrM0=;
        b=hiyWR3nUPzIV5bihSaJrxR1rLnl0DRUH52mCa5Um/+8xzubwi2DVxR1iVp4HndF50V
         0wvOKua0xzJKVX9FnztaP8Sd91naX/1IEukunIwk1+/hbUqk92w9KIvQTaBp69wLpUaJ
         oFt7R4/oXFrwJmoPjn4JDMb7aLlvgD1rG7j3XzIBFW4bzZADs6aQxFbVKrbv08IoW/+y
         qLgrcAQC+og/q2dT/+Mr+M6FWhRXTuShQ3sq1mDICg8jrQfHRejsPI9vB5xKSfIQPpza
         ozqvY8GfB1x2m09xjZ1lFYLlblJ2aIs4UyxBQC6J3gvV3ZAa9HG5HlbK/8uSI1zPvqMB
         m4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7KtqTi95dNlIXBr82ROSzqQ+Z/5nBJP58a9h9OcrM0=;
        b=3zlA0gwHR+FDaLk6+HFCX1nOspOptmSjLUJ0iLldQbq/H+FxG55FgcbNb7KHNb2ttz
         EN3IRga9SLTOCyd9nQ+drLUowbo9lir6nbtzlcWCAKG/Yc8xjoAV6Fzfmt9QEoHqWT27
         S3MK0UtdBWxOWhreSmXdHVF66XGY3Orw1EJcu3lmIh+htzyALzOgEJw5ftv0INJgabow
         htqYJGSUh/2LBBBwmD2eTHTT9SSQ3gLrIKlI9pu2bqMX1gGM/Pu7IiLXZgxLEOdp/Tod
         mappM4ZLq3KGryi9meFeNR1bur784xyuTH7PDs5n/S4FVaSKlwR9MG1d6yA7ZgXjeY+0
         HnHQ==
X-Gm-Message-State: ACrzQf3JZkoftmk0ZR1cyVZ5Yu+0rBKi/vsxU4FCaSEkHDql5aOlfOem
        FbDrvaA6HHBemHmiwwXrLYiJyauhGJbLXUtfjnAkEw==
X-Google-Smtp-Source: AMsMyM4WQylpxJsFlIZQZXNKa5wl+6qXhM6FMcTbRpDpx+uy4tmk7Xvb1T1Hnz+5Au/+YsUU2bToehmhkFI30Hkz+zo=
X-Received: by 2002:a17:90b:1d8a:b0:20c:a6db:5713 with SMTP id
 pf10-20020a17090b1d8a00b0020ca6db5713mr35182725pjb.135.1666032847603; Mon, 17
 Oct 2022 11:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
 <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com>
 <ec599991-44da-7b83-9374-d0043b32f053@denx.de> <CAJ+vNU2g+e8_PBq0SJYOXsB6PKpMb3dmzDRA5Gyj=NJS3Ckc1g@mail.gmail.com>
 <CAJ+vNU0mPt27PgheodNLcOk97OdD6TK+1us58jc=4DMHndQpvQ@mail.gmail.com> <849213369ce9ed3364ba0beb2744bfbcb3740b0c.camel@pengutronix.de>
In-Reply-To: <849213369ce9ed3364ba0beb2744bfbcb3740b0c.camel@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 17 Oct 2022 11:53:54 -0700
Message-ID: <CAJ+vNU0r_4mEJk0aNHE0c-81KDvdhV6aTBa6R-BgHa+zeB_u=g@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abailon@baylibre.com,
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

On Thu, Oct 13, 2022 at 2:49 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Tim,
>
> Am Donnerstag, dem 13.10.2022 um 11:23 -0700 schrieb Tim Harvey:
> > On Wed, Oct 12, 2022 at 11:46 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Tue, Oct 11, 2022 at 4:13 PM Marek Vasut <marex@denx.de> wrote:
> > > >
> > > > On 10/11/22 22:10, Tim Harvey wrote:
> > > > > On Fri, Jul 8, 2022 at 1:57 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > > > > >
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > V4:
> > > > > >   Because the header is not included when adding NoC node, the fsl,imx8mp.h
> > > > > >   needs be included in this patchset. So include it in patch 6
> > > > > >
> > > > > > V3:
> > > > > >   Move adding NoC node patch to i.MX8MP ICC driver patchset
> > > > > >   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> > > > > >
> > > > > > V2:
> > > > > >   Use a low bandwidth value instead INT_MAX
> > > > > >   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
> > > > > >   Add A-b tag from DT maintainer
> > > > > >
> > > > > > i.MX8MP NoC settings is invalid after related power domain up. So
> > > > > > need to set valid values after power domain up.
> > > > > >
> > > > > > This patchset is to bind interconnect for each entry in blk ctrl.
> > > > > >
> > > > > > This patchset is not include DVFS DDRC feature.
> > > > > >
> > > > > > Peng Fan (7):
> > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
> > > > > >      ctrl
> > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
> > > > > >      ctrl
> > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
> > > > > >      ctrl
> > > > > >    soc: imx: add icc paths for i.MX8MP media blk ctrl
> > > > > >    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
> > > > > >    arm64: dts: imx8mp: add interconnects for media blk ctrl
> > > > > >    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
> > > > > >
> > > > > >   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
> > > > > >   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
> > > > > >   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
> > > > > >   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
> > > > > >   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
> > > > > >   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
> > > > > >   6 files changed, 125 insertions(+)
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > > > Hi Peng,
> > > > >
> > > > > I built origin/master from commit 041bc24d867a today for an imx8mp
> > > > > board and am running into errors that appear to be introduced by this
> > > > > series:
> > > > > [   15.177372] platform 381f0040.usb-phy: deferred probe pending
> > > > > [   15.183155] platform 382f0040.usb-phy: deferred probe pending
> > > > > [   15.188928] platform 33800000.pcie: deferred probe pending
> > > > > [   15.194439] platform 32ec0000.blk-ctrl: deferred probe pending
> > > > > [   15.200287] platform 38330000.blk-ctrl: deferred probe pending
> > > > > [   15.206129] platform 32f10000.blk-ctrl: deferred probe pending
> > > > > [   15.211974] platform 32f10100.usb: deferred probe pending
> > > > > [   15.217382] platform 32f10108.usb: deferred probe pending
> > > > > [   15.222791] platform cpufreq-dt: deferred probe pending
> > > > > # cat /sys/kernel/debug/devices_deferred
> > > > > 381f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > > > 382f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > > > 33800000.pcie   platform: supplier 32f10000.blk-ctrl not ready
> > > > > 32ec0000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > > > 38330000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > > > 32f10000.blk-ctrl       imx8mp-blk-ctrl: failed to get noc entries
> > > > > 32f10100.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > > > 32f10108.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > > > cpufreq-dt
> > > > >
> > > > > Is there a driver I'm perhaps missing that is needed now or are there
> > > > > some patches that come from a different unmerged tree needed?
> > > >
> > > > Do you have these enabled ?
> > > >
> > > > CONFIG_INTERCONNECT_IMX8MM=y
> > > > CONFIG_INTERCONNECT_IMX8MN=y
> > > > CONFIG_INTERCONNECT_IMX8MQ=y
> > > > CONFIG_INTERCONNECT_IMX8MP=y
> > >
> > > Marek,
> > >
> > > Yes, I have those as well as CONFIG_ARCH_NXP which appears new for 6.1 enabled.
> > >
> > > Best Regards,
> > >
> > > Tim
> >
> > I see this issue on origin/master 1440f5760228 using
> > arch/arm64/configs/defconfig.
> >
> > It seems to me that the imx8m*_blk_ctrl_probe will all defer now until
> > perhaps all the drivers using interconnects can probe, such as
> > g1/lcdif etc?
> >
> > Some added debugging shows me:
> > [   14.951371] of_icc_bulk_get path lcdif-rd err=-517
> > [   14.956205] devm_of_icc_bulk_get ret=-517
> > [   14.960562] imx8m_blk_ctrl_probe failed -517
> > [   14.967191] of_icc_bulk_get path g1 err=-517
> > [   14.971487] devm_of_icc_bulk_get ret=-517
> > [   14.975614] imx8m_blk_ctrl_probe failed -517
> > [   14.982200] of_icc_bulk_get path usb1 err=-517
> > [   14.986680] devm_of_icc_bulk_get ret=-517
> > [   14.990709] imx8mp_blk_ctrl_probe 0:usb1
> > [   14.994641] imx8mp_blk_ctrl_probe 1:usb2
> > [   15.002086] platform 381f0040.usb-phy: deferred probe pending
> > [   15.007875] platform 382f0040.usb-phy: deferred probe pending
> > [   15.013636] platform 32f00000.pcie-phy: deferred probe pending
> > [   15.019480] platform 33800000.pcie: deferred probe pending
> > [   15.024975] platform 32ec0000.blk-ctrl: deferred probe pending
> > [   15.030819] platform 38330000.blk-ctrl: deferred probe pending
> > [   15.036662] platform 32f10000.blk-ctrl: deferred probe pending
> > [   15.042503] platform 32f10100.usb: deferred probe pending
> > [   15.047912] platform 32f10108.usb: deferred probe pending
> >
> Do you have CONFIG_ARM_IMX_BUS_DEVFREQ enabled? This one will actually
> instantiate the interconnect devices for the interconnect drivers to
> hang onto. Once the interconnect is probed the blk-ctrl drivers should
> probe. There is no dependency into leaf peripheral devices.
>
> Regards,
> Lucas
>

Lucas,

That's configured as a module in arch/arm64/configs/defconfig - making
it static still does not help. I am booting a static kernel with no
modules here so there must be something else required that is
configured as a module that wasn't needed before this series?

I haven't had much time to look into this. I'm simply using
arch/arm64/configs/defconfig and CONFIG_INITRAMFS_SOURCE set to a
rootfs I use for quick testing. If there is indeed now one or more
modules required before USB and PCIe are available I wonder if they
should be made static in arch/arm64/configs/defconfig? If not then I
don't know what the point in having the PCI and USB drivers static is.

Best Regards,

Tim
