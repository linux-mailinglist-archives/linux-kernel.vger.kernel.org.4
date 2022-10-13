Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C35FE152
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiJMSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiJMSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:33:28 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FE3686F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:29:51 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id h185so2245930pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BTHaUgYO9jMl/xNji3tXYK1xSdk1QlEpno0FrqGDuU=;
        b=wDSSH+4FY0VpIbgiubC+64Ugh9mhNbjE9Cg9Bp/N8tGJTTJ6V8mvcqXc3CyPlmRCCj
         LFDFS2a9w47KoDRWWSQYU6FJIRAy/Z9S6lVfTOhDQ9eEb8olV/1vYHXR5s01g6+eCLgW
         HISdz4uUlbGkaZgYJqVyFzxGkgM/P9WtBoAbdlkUApj6MkvXK6Wb3UTytIReooPKnCr+
         DLI5raWn+zRH49nxXIvUIm944qaMgAnJUr5mmylp+KraSaKHHL2EZGzZvN4Pdtuvj4wz
         fNXv0wL0IkjcsVdal513BLNcaDO5fKovL3lp3PKaNUAV9fAgC/Wl2+sDjAdVAGQi/hHC
         v/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BTHaUgYO9jMl/xNji3tXYK1xSdk1QlEpno0FrqGDuU=;
        b=K3OXuwwYcsc1qpwE5dgLc30ytDjybFs1yqhES6OgNKEd9pqWaA0auCq+cxOcKasRM4
         X31uYtKca7ZKf4+8BEb7vTYw0PvfEXtVXRtPVCxOzwZlcAjYUroJmVRHrkqdJI/Xkw7Z
         HDfrTPnQhJkMZatrOiKkBTV0N9Uhs1zXJXmwC5ifrN7Q6Q16uKECVXJMUZVGmofWlzks
         /8WupBR3RIqQpPRknLyVe7HInoTFiGkFIyC4HK+HbVjSEnQyr6B1W9QSZ6F/d9HVPJM9
         dK9gmMKzsaR2i9QLoTQYMMSMHCzdWmK5l7R7Ctnv89qxF/HO0f+GjKG5uD5F15KYT7pT
         q2Sg==
X-Gm-Message-State: ACrzQf1pg1CnDChcMD6kJ8uABAs3zdSzQ6UaktukxeeJGSd9pIHZvAg8
        TBvPqASoRL9Q3AeiuvLyURQY9/pBAHAToFi4sRmgCQ==
X-Google-Smtp-Source: AMsMyM6vwqMcF79SgQmU96lUIhoknsg5lP1hG79RoUNhba0APdmzSzyBg6VnUlzHAK1CSgzO0HTJ4WoKCZ/dw6IcAmw=
X-Received: by 2002:a63:f512:0:b0:460:35b5:14ed with SMTP id
 w18-20020a63f512000000b0046035b514edmr952445pgh.389.1665685415620; Thu, 13
 Oct 2022 11:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
 <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com>
 <ec599991-44da-7b83-9374-d0043b32f053@denx.de> <CAJ+vNU2g+e8_PBq0SJYOXsB6PKpMb3dmzDRA5Gyj=NJS3Ckc1g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2g+e8_PBq0SJYOXsB6PKpMb3dmzDRA5Gyj=NJS3Ckc1g@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 13 Oct 2022 11:23:22 -0700
Message-ID: <CAJ+vNU0mPt27PgheodNLcOk97OdD6TK+1us58jc=4DMHndQpvQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 11:46 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, Oct 11, 2022 at 4:13 PM Marek Vasut <marex@denx.de> wrote:
> >
> > On 10/11/22 22:10, Tim Harvey wrote:
> > > On Fri, Jul 8, 2022 at 1:57 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > >>
> > >> From: Peng Fan <peng.fan@nxp.com>
> > >>
> > >> V4:
> > >>   Because the header is not included when adding NoC node, the fsl,imx8mp.h
> > >>   needs be included in this patchset. So include it in patch 6
> > >>
> > >> V3:
> > >>   Move adding NoC node patch to i.MX8MP ICC driver patchset
> > >>   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> > >>
> > >> V2:
> > >>   Use a low bandwidth value instead INT_MAX
> > >>   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
> > >>   Add A-b tag from DT maintainer
> > >>
> > >> i.MX8MP NoC settings is invalid after related power domain up. So
> > >> need to set valid values after power domain up.
> > >>
> > >> This patchset is to bind interconnect for each entry in blk ctrl.
> > >>
> > >> This patchset is not include DVFS DDRC feature.
> > >>
> > >> Peng Fan (7):
> > >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
> > >>      ctrl
> > >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
> > >>      ctrl
> > >>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
> > >>      ctrl
> > >>    soc: imx: add icc paths for i.MX8MP media blk ctrl
> > >>    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
> > >>    arm64: dts: imx8mp: add interconnects for media blk ctrl
> > >>    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
> > >>
> > >>   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
> > >>   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
> > >>   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
> > >>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
> > >>   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
> > >>   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
> > >>   6 files changed, 125 insertions(+)
> > >>
> > >> --
> > >> 2.25.1
> > >>
> > >
> > > Hi Peng,
> > >
> > > I built origin/master from commit 041bc24d867a today for an imx8mp
> > > board and am running into errors that appear to be introduced by this
> > > series:
> > > [   15.177372] platform 381f0040.usb-phy: deferred probe pending
> > > [   15.183155] platform 382f0040.usb-phy: deferred probe pending
> > > [   15.188928] platform 33800000.pcie: deferred probe pending
> > > [   15.194439] platform 32ec0000.blk-ctrl: deferred probe pending
> > > [   15.200287] platform 38330000.blk-ctrl: deferred probe pending
> > > [   15.206129] platform 32f10000.blk-ctrl: deferred probe pending
> > > [   15.211974] platform 32f10100.usb: deferred probe pending
> > > [   15.217382] platform 32f10108.usb: deferred probe pending
> > > [   15.222791] platform cpufreq-dt: deferred probe pending
> > > # cat /sys/kernel/debug/devices_deferred
> > > 381f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > 382f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > 33800000.pcie   platform: supplier 32f10000.blk-ctrl not ready
> > > 32ec0000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > 38330000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > 32f10000.blk-ctrl       imx8mp-blk-ctrl: failed to get noc entries
> > > 32f10100.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > 32f10108.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > cpufreq-dt
> > >
> > > Is there a driver I'm perhaps missing that is needed now or are there
> > > some patches that come from a different unmerged tree needed?
> >
> > Do you have these enabled ?
> >
> > CONFIG_INTERCONNECT_IMX8MM=y
> > CONFIG_INTERCONNECT_IMX8MN=y
> > CONFIG_INTERCONNECT_IMX8MQ=y
> > CONFIG_INTERCONNECT_IMX8MP=y
>
> Marek,
>
> Yes, I have those as well as CONFIG_ARCH_NXP which appears new for 6.1 enabled.
>
> Best Regards,
>
> Tim

I see this issue on origin/master 1440f5760228 using
arch/arm64/configs/defconfig.

It seems to me that the imx8m*_blk_ctrl_probe will all defer now until
perhaps all the drivers using interconnects can probe, such as
g1/lcdif etc?

Some added debugging shows me:
[   14.951371] of_icc_bulk_get path lcdif-rd err=-517
[   14.956205] devm_of_icc_bulk_get ret=-517
[   14.960562] imx8m_blk_ctrl_probe failed -517
[   14.967191] of_icc_bulk_get path g1 err=-517
[   14.971487] devm_of_icc_bulk_get ret=-517
[   14.975614] imx8m_blk_ctrl_probe failed -517
[   14.982200] of_icc_bulk_get path usb1 err=-517
[   14.986680] devm_of_icc_bulk_get ret=-517
[   14.990709] imx8mp_blk_ctrl_probe 0:usb1
[   14.994641] imx8mp_blk_ctrl_probe 1:usb2
[   15.002086] platform 381f0040.usb-phy: deferred probe pending
[   15.007875] platform 382f0040.usb-phy: deferred probe pending
[   15.013636] platform 32f00000.pcie-phy: deferred probe pending
[   15.019480] platform 33800000.pcie: deferred probe pending
[   15.024975] platform 32ec0000.blk-ctrl: deferred probe pending
[   15.030819] platform 38330000.blk-ctrl: deferred probe pending
[   15.036662] platform 32f10000.blk-ctrl: deferred probe pending
[   15.042503] platform 32f10100.usb: deferred probe pending
[   15.047912] platform 32f10108.usb: deferred probe pending

Best Regards,

Tim
