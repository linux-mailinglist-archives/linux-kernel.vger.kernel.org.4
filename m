Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5C68160C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjA3QL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjA3QL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:11:56 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573A301B2;
        Mon, 30 Jan 2023 08:11:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7C31E0006;
        Mon, 30 Jan 2023 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675095112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcGSRz6yN0YvpPxM18cpcT5yuDciHrp+by6J8Z2HzPE=;
        b=fIHDEFlerl/8KMHwFWRVo5CKdbzBAOQCYrA3KdnXDHCfNYGJuNFd99PVt4nzl7eFv+eBa3
        IKyJnI6OQxAgrGls7DOs1ulfBQijUOU9YIATKPmq4pxufMyY3fnPi6tKLczdWg46ltBL6V
        7q1vGEghO57UcHuXti6woJd1zHgy5TMAqmd4I/x6ByVb13ulTwDgdVWg4yrRcJmLhBFs4l
        2xFvQE4KH0/3Iy2eiUEmPGtZFgxKgnQtcniNCnqkH8pQ51AA9zoB0yw5YMSHz8UNWOwUXA
        HzZH+rJ7sNEmjcEWvHMY+m4D1TttwKjzWhWdMNC/wufQ+dQRdHQ8bd3zJF2BZw==
Date:   Mon, 30 Jan 2023 17:11:45 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: Re: [RESEND PATCH v5 00/10] Add MediaTek MT7986 SPI NAND and ECC
 support
Message-ID: <20230130171145.2c844d34@xps-13>
In-Reply-To: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
References: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiangsheng,

xiangsheng.hou@mediatek.com wrote on Mon, 30 Jan 2023 11:06:46 +0800:

> This patch series add MediaTek MT7986 SPI NAND and ECC controller
> support, split ECC engine with rawnand controller in bindings and
> change to YAML schema.

I would like to pick-up patches 3, 7 and 10 and apply them in the mtd
tree as they look completely orthogonal with all the other (spi/DT)
changes, am I right?

Mark, is it okay for you?

Thanks,
Miqu=C3=A8l

>=20
> Changes since V4:
>  - Split arm and arm64 dts patch for fix existing NAND controller node na=
me.
>=20
> Changes since V3:
>  - Correct mediatek,mtk-nfc.yaml dt-bindings.
>=20
> Changes since V2:
>  - Change ECC err_mask value with GENMASK macro.
>  - Change snfi mediatek,rx-latch-latency to mediatek,rx-latch-latency-ns.
>  - Add a separate patch for DTS change.
>  - Move common description to top-level pattern properties.
>  - Drop redundant parts in dt-bindings.
>=20
> Changes since V1:
>  - Use existing sample delay property.
>  - Add restricting for optional nfi_hclk.
>  - Improve and perfect dt-bindings documentation.
>  - Change existing node name to match NAND controller DT bingings.
>  - Fix issues reported by dt_binding_check.
>  - Fix issues reported by dtbs_check.
>=20
> Xiangsheng Hou (10):
>   spi: mtk-snfi: Change default page format to setup default setting
>   spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
>   mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
>   dt-bindings: spi: mtk-snfi: Add compatible for MT7986
>   spi: mtk-snfi: Add snfi sample delay and read latency adjustment
>   dt-bindings: spi: mtk-snfi: Add read latch latency property
>   dt-bindings: mtd: Split ECC engine with rawnand controller
>   arm64: dts: mediatek: Fix existing NAND controller node name
>   arm: dts: mediatek: Fix existing NAND controller node name
>   dt-bindings: mtd: mediatek,nand-ecc-engine: Add compatible for MT7986
>=20
>  .../bindings/mtd/mediatek,mtk-nfc.yaml        | 155 +++++++++++++++
>  .../mtd/mediatek,nand-ecc-engine.yaml         |  63 +++++++
>  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml   |  54 +++++-
>  arch/arm/boot/dts/mt2701.dtsi                 |   2 +-
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |   2 +-
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   2 +-
>  drivers/mtd/nand/ecc-mtk.c                    |  28 ++-
>  drivers/spi/spi-mtk-snfi.c                    |  41 +++-
>  9 files changed, 330 insertions(+), 193 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-nf=
c.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand-e=
cc-engine.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
>=20
