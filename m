Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4766DEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjAQNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAQNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:35:06 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120B22790;
        Tue, 17 Jan 2023 05:35:04 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HDYrwu042245;
        Tue, 17 Jan 2023 07:34:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673962493;
        bh=ynGhFVhdaPLvyTDiHJ27FR6uHXJ2S5L9pfgCVodPE54=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cL6KqpTp/aLCnYo6FJUZSBm+hpT7U74yXp5DtTGCofxazqFk7Z/boVAH4O9kc0yJI
         ETXWaBZjOKjEwwt0Uus+xYPzh4mWmT5i5jVQDiy8nkNbzALue0ov2m6VwfHcaqoG3x
         XG/5hMxLZiYbP7+/XY2RI3VsFahrgIiWehhSxax0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HDYqTf108952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 07:34:53 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 07:34:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 07:34:52 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HDYmmG083033;
        Tue, 17 Jan 2023 07:34:49 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <martyn.welch@collabora.com>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nitin Yadav <n-yadav@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>
Subject: Re: [PATCH v4 0/3] Improve K3-am625-sk support (USB, MMC)
Date:   Tue, 17 Jan 2023 19:04:43 +0530
Message-ID: <167395338059.410173.2860390217539466023.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112162847.973869-1-sjoerd@collabora.com>
References: <20230112162847.973869-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sjoerd Simons,

On Thu, 12 Jan 2023 17:28:43 +0100, Sjoerd Simons wrote:
> This series picks up a few patches from the TI BSP tree that
> unfortunately didn't make it upstream thusfar.
> 
> The first patch improve SD card compatibility (allowing U1 class cards
> to be used), the remaining ones add USB support.
> 
> The type-c connector isn't entirely modelled with these changes as
> it goes through a TPS6598 PD controller. Unfortunately the dtb bindings
> for that currently require an irq line, which is not connected on E1 and
> E2 version boards. The patchese to support this setup unfortunately didn't land
> yet[0].. As such the last patch ignored the PD controller and simply
> configures usb0 as periphal only rather then mode switch capable, which
> at least gives some basic usability of that USB port.
> 
> [...]

I have applied the following to branch ti-k3-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select
      commit: bd2912f400934d71ecb040f625685b886ccdcc20
[2/3] arm64: dts: ti: k3-am62-main: Add support for USB
      commit: 2240f96cf3cd0f74f5c349fb212c4176627f69b0
[3/3] arm64: dts: ti: k3-am625-sk: Add support for USB
      commit: 2d94dfc438853dca9b390a3f32fe5331c336fd28

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

