Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403C6961C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjBNLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjBNLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:05 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0E25945;
        Tue, 14 Feb 2023 03:04:02 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id C7D4426F78D;
        Tue, 14 Feb 2023 12:04:00 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Subject: [PATCH v2 00/16] Device trees for Apple M2 (t8112) based devices
Date:   Tue, 14 Feb 2023 12:03:13 +0100
Message-Id: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJq62MC/3WOMQ7CMAxFr1JlxshJCwQm7oE6pI5LwpCiJFSgK
 ncn7cDGYulZfv5/EYmj5yQuzSIizz75KVRQu0aQM+HO4G1loVC1WAeYZJyHrKVUYDMcR9IaSZM
 9taJKg0kMQzSB3KohItj6ljhH5p+2Xj4jj/69Rd/6ys6nPMXP1mSW6/Zv6CwBgYZD1ykrSanz9
 WFCMK994Cz6UsoXPggRbtcAAAA=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4456; i=j@jannau.net;
 h=from:subject:message-id; bh=JvQSRkni/I9wvoKlv6yl/fsdgld1mwqtTj6v+TfDSSM=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfOWxcavS26rmn90Us2zCE7/X9XXcs9sKF2wXMDs/
 b+/Bn6vO0pZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkwi5GhgnsE300CzKOlPl3
 tzOZZ5jXnwz+vYft6IYVksmGKVcW/Wf4wxcQND9Brvcai5J9g3TeqkktTxOURKVPnZqibT7Xgzu
 OAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains dt-bindings updates and device trees for Apple
silicon devices based on the M2 SoC (t8112).

Device tree validation depends on the dart-t8110 bindings queued in
the iommu tree for 6.3 [1], PMU updates [2] and support for
"local-mac-address" for brcm,bcm4329-fmac based devices [3]. The latter
fixes validation errors for the existing M1 and M1 Pro/Max/Ultra device
trees.

The device trees are tested with the downstream Asahi Linux kernel and
on top of v6.2-rc5. The hardware is of limited use with the upstream
kernel. The notebooks miss keyboard/trackpad drivers and usb support.
The Mac mini does not yet have a boot framebuffer and lacks usb support
as well.

1: https://lore.kernel.org/linux-iommu/20230113105029.26654-1-marcan@marcan.st/
2: https://lore.kernel.org/linux-devicetree/20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net/
3: https://lore.kernel.org/linux-devicetree/20230203-dt-bindings-network-class-v2-2-499686795073@jannau.net/

The dt-binding changes in this series are documentation only. All
drivers are compatible with the HW on the M2 SoC and are probed based
on generic compatibles. The t8112 specific compatibles are added to
address t8112 specific quirks in the case they become required.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- collect acked/reviewed-by: tags
- disable unused PCIe ports instead of deleting them
- fixes based on review feedback for "apple,aic2" and "apple,sart" 
- dropped "arm-pmu: Add PMU compatible strings for Apple M2 cores"
  (submitted separately)
- Link to v1: https://lore.kernel.org/r/20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net

---
Hector Martin (2):
      dt-bindings: power: apple,pmgr-pwrstate: Add t8112 compatible
      arm64: dts: apple: t8112: Initial t8112 (M2) device trees

Janne Grunau (14):
      dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr compatible
      dt-bindings: watchdog: apple,wdt: Add t8112-wdt compatible
      dt-bindings: arm: cpus: Add apple,avalanche & blizzard compatibles
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8112-aic compatible
      dt-bindings: iommu: apple,sart: Add apple,t8112-sart compatible string
      dt-bindings: mailbox: apple,mailbox: Add t8112 compatibles
      dt-bindings: nvme: apple: Add apple,t8112-nvme-ans2 compatible string
      dt-bindings: pci: apple,pcie: Add t8112 support
      dt-bindings: pinctrl: apple,pinctrl: Add apple,t8112-pinctrl compatible
      dt-bindings: i2c: apple,i2c: Add apple,t8112-i2c compatible
      dt-bindings: clock: apple,nco: Add t8112-nco compatible
      dt-bindings: sound: apple,mca: Add t8112-mca compatible
      dt-bindings: dma: apple,admac: Add t8112-admac compatible
      dt-bindings: arm: apple: Add t8112 j413/j473/j493 compatibles

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/clock/apple,nco.yaml       |    1 +
 .../devicetree/bindings/dma/apple,admac.yaml       |    1 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   23 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |   10 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    2 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |    5 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/sound/apple,mca.yaml       |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   63 ++
 arch/arm64/boot/dts/apple/t8112-j473.dts           |   54 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   52 +
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi          |   81 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi          | 1141 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  912 ++++++++++++++++
 22 files changed, 2365 insertions(+), 7 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230202-asahi-t8112-dt-6fc880c8cd73

Best regards,
-- 
Janne Grunau <j@jannau.net>

