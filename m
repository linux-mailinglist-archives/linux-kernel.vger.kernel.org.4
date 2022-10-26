Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06F60E664
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiJZRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiJZRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:22:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABAA9AFFB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:22:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3264122pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=quHF11bisNBche9+VnC8BLjKYyYleEVda0+BIKXMuLE=;
        b=cc+zseFHMVC95ncVRpvbvWJ0frPHxIprtbNYVnAfezAsSiHiBRVT+ILOylUO758TxU
         k95bfYWuNLTkg0Cj4IQWeFSFPpk0L8P/yU+X1jOce8vxNp6WHkOeBfBFogw7DZEMcqBp
         tm8erm1rx2lhNL9Wg96QX4J9JRsbFxTsYIK5xZM70K9YoCF7kaKOlkH0JKOT6/Q0llkc
         SgBuwIBg6yTDvHnmThG3O2rhaO1DPVfN2ruK3bkfzrSZtFekj5R6rfpg7zs5HAbFX/Ln
         DF+yTDzp8Lzmn+3e6VzpgFQtd5Q4fNfHJDZIjFPnJVKZyk8QeCjNSKq/Hv+/1cvwyQ6i
         XI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quHF11bisNBche9+VnC8BLjKYyYleEVda0+BIKXMuLE=;
        b=lYa4JUT60ucc0sVoREzXuY88+2CCyZz1SV6SOiy6YvzGUFn8HpuY4PSS6dQJ4Y/SF6
         Z1DhIjxE5z/ZcLwY6Hbr/c3oo+8GUkgp9CxJHmxzZIFKXdCHnCbti6Mw1kU+mAg+Pacr
         gom9HIUxmM+eG8QirxV72+V3io17BzCjdcHvnGeSMCs+XMC+EIWKA73gFB39yqYQ6M9z
         e3cMCzxe7Otz2j42dvoqg2yhHTRWJM1eNX7cub6mv+l+2gQQIwxXQ93h/mTsujJflUeF
         oT4VK7EBr3yGAnqpfwqSX6gn5N427epaCnwWrgZgrGQ+8WYsfwk4g40mGq/6CgoTLFut
         TJOA==
X-Gm-Message-State: ACrzQf0ij3gu7gLIDeD6k/OjjkJSvGrRND3v5sdCRfKPoa1LfjhM0HeS
        tADt/CBrW0c9fOy3U/1sdSPAfHd/NvSq5yXgMe5fjafhJzR/TL/b
X-Google-Smtp-Source: AMsMyM558UTbwtNu3DoELIB0y+tfRhgP734rMthquZje+JjLbW7CN3/n9bYbdNCN6wABvYemtjxp3gREVqE1VHyxSYY=
X-Received: by 2002:a17:902:768c:b0:186:b136:187a with SMTP id
 m12-20020a170902768c00b00186b136187amr14281399pll.94.1666804957189; Wed, 26
 Oct 2022 10:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
 <CAJ+vNU3uYtDGMd6fPi7skWKL8UNXntfAEODARF0NVz9k7DCT7w@mail.gmail.com>
 <ec599991-44da-7b83-9374-d0043b32f053@denx.de> <CAJ+vNU2g+e8_PBq0SJYOXsB6PKpMb3dmzDRA5Gyj=NJS3Ckc1g@mail.gmail.com>
 <CAJ+vNU0mPt27PgheodNLcOk97OdD6TK+1us58jc=4DMHndQpvQ@mail.gmail.com>
 <849213369ce9ed3364ba0beb2744bfbcb3740b0c.camel@pengutronix.de> <CAJ+vNU0r_4mEJk0aNHE0c-81KDvdhV6aTBa6R-BgHa+zeB_u=g@mail.gmail.com>
In-Reply-To: <CAJ+vNU0r_4mEJk0aNHE0c-81KDvdhV6aTBa6R-BgHa+zeB_u=g@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 26 Oct 2022 10:22:23 -0700
Message-ID: <CAJ+vNU23qCrXqULTMMHVSxiRSg2F2GE2v=mTn7stV7nEp6DMmQ@mail.gmail.com>
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

On Mon, Oct 17, 2022 at 11:53 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Oct 13, 2022 at 2:49 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Hi Tim,
> >
> > Am Donnerstag, dem 13.10.2022 um 11:23 -0700 schrieb Tim Harvey:
> > > On Wed, Oct 12, 2022 at 11:46 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > > >
> > > > On Tue, Oct 11, 2022 at 4:13 PM Marek Vasut <marex@denx.de> wrote:
> > > > >
> > > > > On 10/11/22 22:10, Tim Harvey wrote:
> > > > > > On Fri, Jul 8, 2022 at 1:57 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > > > > > >
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > V4:
> > > > > > >   Because the header is not included when adding NoC node, the fsl,imx8mp.h
> > > > > > >   needs be included in this patchset. So include it in patch 6
> > > > > > >
> > > > > > > V3:
> > > > > > >   Move adding NoC node patch to i.MX8MP ICC driver patchset
> > > > > > >   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> > > > > > >
> > > > > > > V2:
> > > > > > >   Use a low bandwidth value instead INT_MAX
> > > > > > >   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
> > > > > > >   Add A-b tag from DT maintainer
> > > > > > >
> > > > > > > i.MX8MP NoC settings is invalid after related power domain up. So
> > > > > > > need to set valid values after power domain up.
> > > > > > >
> > > > > > > This patchset is to bind interconnect for each entry in blk ctrl.
> > > > > > >
> > > > > > > This patchset is not include DVFS DDRC feature.
> > > > > > >
> > > > > > > Peng Fan (7):
> > > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
> > > > > > >      ctrl
> > > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
> > > > > > >      ctrl
> > > > > > >    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
> > > > > > >      ctrl
> > > > > > >    soc: imx: add icc paths for i.MX8MP media blk ctrl
> > > > > > >    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
> > > > > > >    arm64: dts: imx8mp: add interconnects for media blk ctrl
> > > > > > >    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
> > > > > > >
> > > > > > >   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
> > > > > > >   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
> > > > > > >   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
> > > > > > >   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
> > > > > > >   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
> > > > > > >   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
> > > > > > >   6 files changed, 125 insertions(+)
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > >
> > > > > > Hi Peng,
> > > > > >
> > > > > > I built origin/master from commit 041bc24d867a today for an imx8mp
> > > > > > board and am running into errors that appear to be introduced by this
> > > > > > series:
> > > > > > [   15.177372] platform 381f0040.usb-phy: deferred probe pending
> > > > > > [   15.183155] platform 382f0040.usb-phy: deferred probe pending
> > > > > > [   15.188928] platform 33800000.pcie: deferred probe pending
> > > > > > [   15.194439] platform 32ec0000.blk-ctrl: deferred probe pending
> > > > > > [   15.200287] platform 38330000.blk-ctrl: deferred probe pending
> > > > > > [   15.206129] platform 32f10000.blk-ctrl: deferred probe pending
> > > > > > [   15.211974] platform 32f10100.usb: deferred probe pending
> > > > > > [   15.217382] platform 32f10108.usb: deferred probe pending
> > > > > > [   15.222791] platform cpufreq-dt: deferred probe pending
> > > > > > # cat /sys/kernel/debug/devices_deferred
> > > > > > 381f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > > > > 382f0040.usb-phy        platform: supplier 32f10000.blk-ctrl not ready
> > > > > > 33800000.pcie   platform: supplier 32f10000.blk-ctrl not ready
> > > > > > 32ec0000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > > > > 38330000.blk-ctrl       imx8m-blk-ctrl: failed to get noc entries
> > > > > > 32f10000.blk-ctrl       imx8mp-blk-ctrl: failed to get noc entries
> > > > > > 32f10100.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > > > > 32f10108.usb    platform: supplier 32f10000.blk-ctrl not ready
> > > > > > cpufreq-dt
> > > > > >
> > > > > > Is there a driver I'm perhaps missing that is needed now or are there
> > > > > > some patches that come from a different unmerged tree needed?
> > > > >
> > > > > Do you have these enabled ?
> > > > >
> > > > > CONFIG_INTERCONNECT_IMX8MM=y
> > > > > CONFIG_INTERCONNECT_IMX8MN=y
> > > > > CONFIG_INTERCONNECT_IMX8MQ=y
> > > > > CONFIG_INTERCONNECT_IMX8MP=y
> > > >
> > > > Marek,
> > > >
> > > > Yes, I have those as well as CONFIG_ARCH_NXP which appears new for 6.1 enabled.
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
> > >
> > > I see this issue on origin/master 1440f5760228 using
> > > arch/arm64/configs/defconfig.
> > >
> > > It seems to me that the imx8m*_blk_ctrl_probe will all defer now until
> > > perhaps all the drivers using interconnects can probe, such as
> > > g1/lcdif etc?
> > >
> > > Some added debugging shows me:
> > > [   14.951371] of_icc_bulk_get path lcdif-rd err=-517
> > > [   14.956205] devm_of_icc_bulk_get ret=-517
> > > [   14.960562] imx8m_blk_ctrl_probe failed -517
> > > [   14.967191] of_icc_bulk_get path g1 err=-517
> > > [   14.971487] devm_of_icc_bulk_get ret=-517
> > > [   14.975614] imx8m_blk_ctrl_probe failed -517
> > > [   14.982200] of_icc_bulk_get path usb1 err=-517
> > > [   14.986680] devm_of_icc_bulk_get ret=-517
> > > [   14.990709] imx8mp_blk_ctrl_probe 0:usb1
> > > [   14.994641] imx8mp_blk_ctrl_probe 1:usb2
> > > [   15.002086] platform 381f0040.usb-phy: deferred probe pending
> > > [   15.007875] platform 382f0040.usb-phy: deferred probe pending
> > > [   15.013636] platform 32f00000.pcie-phy: deferred probe pending
> > > [   15.019480] platform 33800000.pcie: deferred probe pending
> > > [   15.024975] platform 32ec0000.blk-ctrl: deferred probe pending
> > > [   15.030819] platform 38330000.blk-ctrl: deferred probe pending
> > > [   15.036662] platform 32f10000.blk-ctrl: deferred probe pending
> > > [   15.042503] platform 32f10100.usb: deferred probe pending
> > > [   15.047912] platform 32f10108.usb: deferred probe pending
> > >
> > Do you have CONFIG_ARM_IMX_BUS_DEVFREQ enabled? This one will actually
> > instantiate the interconnect devices for the interconnect drivers to
> > hang onto. Once the interconnect is probed the blk-ctrl drivers should
> > probe. There is no dependency into leaf peripheral devices.
> >
> > Regards,
> > Lucas
> >
>
> Lucas,
>
> That's configured as a module in arch/arm64/configs/defconfig - making
> it static still does not help. I am booting a static kernel with no
> modules here so there must be something else required that is
> configured as a module that wasn't needed before this series?
>
> I haven't had much time to look into this. I'm simply using
> arch/arm64/configs/defconfig and CONFIG_INITRAMFS_SOURCE set to a
> rootfs I use for quick testing. If there is indeed now one or more
> modules required before USB and PCIe are available I wonder if they
> should be made static in arch/arm64/configs/defconfig? If not then I
> don't know what the point in having the PCI and USB drivers static is.
>

Lucas,

Sorry, I misspoke - I did not have CONFIG_ARM_IMX_BUS_DEVFREQ and that
was indeed my issue.

Question: Should the intention of arch/arm64/configs/defconfig be to
provide static bus support for PCIe/USB which can be boot devices?

Prior to the interconnect drivers (and even following those drivers
for imx8mm/imx8mn) PCIe/USB are available without module support with
arch/arm64/configs/defconfig but now the following would need to be
changed to make PCIe/USB available with defconfig and no modules:
CONFIG_INTERCONNECT_IMX8MM=y
CONFIG_INTERCONNECT_IMX8MN=y
CONFIG_INTERCONNECT_IMX8MQ=y
CONFIG_INTERCONNECT_IMX8MP=y
CONFIG_ARM_IMX_BUS_DEVFREQ=y

Without this change one would need an initrd to boot off PCIe/NVMe or
USB boot devices. I'm simply not clear what the intended use case is
for the defconfig with regards to modules vs static drivers.

Best Regards,

Tim
