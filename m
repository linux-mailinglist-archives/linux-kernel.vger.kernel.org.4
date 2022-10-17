Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD3600CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJQKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJQKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:41:57 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560CD11473;
        Mon, 17 Oct 2022 03:41:56 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 448863FC7E;
        Mon, 17 Oct 2022 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666003314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RqJ9M+vBiRIQTW4bKSTUxpGTbeg6wh3ICQI1R6i0GdU=;
        b=jzvRgAUYn7yrV189wQL6kxur+Iz26HEgIh0B+NKnNwMaSp2aQr3pRHjXiLlDyYDIZ6wGni
        UzOin78/Fv8XJ3yo0eyYw71wsWZ1E0u2azu05p71bZzn016CJXUgRki50T+fNFxlGzqLwP
        itb77151ZVYO9IleLryWtUGc15pyx2s=
Received: from frank-G5.. (fttx-pool-217.61.154.127.bambit.de [217.61.154.127])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 6150B403ED;
        Mon, 17 Oct 2022 10:41:53 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v1 00/12] Add BananaPi R3
Date:   Mon, 17 Oct 2022 12:41:29 +0200
Message-Id: <20221017104141.7338-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 0d90a5ee-935f-4cb3-851d-912040432dc3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds some Nodes to mt7986 devicetree and the BananaPi R3

i included sams series for mt7986 DTS with small changes
https://patchwork.kernel.org/project/linux-mediatek/cover/20220427124741.18245-1-sam.shih@mediatek.com/

this series need these Patches:

- Add mt7986 i2c support
  https://patchwork.kernel.org/project/linux-mediatek/cover/20221009101631.82380-1-linux@fw-web.de/
- Add mmc-support for mt7986
  https://patchwork.kernel.org/project/linux-mediatek/cover/20221008165627.114782-1-linux@fw-web.de/
- hwrng: mediatek: add mt7986 support
  https://patchwork.kernel.org/project/linux-mediatek/patch/20221008164553.113260-1-linux@fw-web.de/
- pinctrl: mediatek: allow configuring uart rx/tx and rts/cts separately
  https://patchwork.kernel.org/project/linux-mediatek/patch/20221008164807.113590-1-linux@fw-web.de/

Frank Wunderlich (6):
  dt-bindings: phy: mediatek,tphy: add support for mt7986
  dt-bindings: PCI: mediatek-gen3: add support for mt7986
  dt-bindings: usb: mtk-xhci: add support for mt7986
  dt-bindings: arm64: dts: mediatek: add compatible for bananapi r3
  arm64: dts: mt7986: add i2c node
  arm64: dts: mt7986: add Bananapi R3

Sam Shih (6):
  arm64: dts: mt7986: harmonize device node order
  arm64: dts: mt7986: add spi related device nodes
  arm64: dts: mt7986: add pcie related device nodes
  arm64: dts: mt7986: add usb related device nodes
  arm64: dts: mt7986: add crypto related device nodes
  arm64: dts: mt7986: add mmc related device nodes

 .../devicetree/bindings/arm/mediatek.yaml     |   1 +
 .../bindings/pci/mediatek-pcie-gen3.yaml      |   1 +
 .../bindings/phy/mediatek,tphy.yaml           |   1 +
 .../bindings/usb/mediatek,mtk-xhci.yaml       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt7986a-bananapi-bpi-r3-emmc.dts |  34 +
 .../mediatek/mt7986a-bananapi-bpi-r3-sd.dts   |  29 +
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi | 609 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts  | 263 ++++++--
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi     | 183 ++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts  |  83 ++-
 11 files changed, 1152 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-emmc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi

-- 
2.34.1

