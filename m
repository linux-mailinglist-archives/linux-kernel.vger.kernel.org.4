Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C546D9052
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjDFHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDFHSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:18:14 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A7A18F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:18:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7006642463;
        Thu,  6 Apr 2023 07:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680765489; bh=e70UwBute4HAoZJh+nxQBtfBPLvA9NDh9kwubSF5MIY=;
        h=Date:To:Cc:From:Subject;
        b=SGZHa/ng2HRa2VBLu8w/J/QKi0mDuTL0458I1X/lX/UA91ME/izT/mZ5mJNefiJZQ
         sAFmE6e7XH245Rayty/3/jShvtsNtt0frKxAgahWLZm4zz8R+Z9uIQhWzrtZ/wagWN
         kre+SRKOs0f8/4ercrfkn78R8r4W0e9o6ys48evrBL4JuP0LDAzluutvl263OureHQ
         8qHM4PGfqgrgi2ocV5OZo92ySkmwuzkz1/g/X2Obtxx+Vt7daP7SlvZOWejhchHSW2
         sg+EU/bPS3ZFmRkb49nv0U0TywDCzlmjZ3ilwtCK1BMqBpYljLAELmSIPMdIm/LJ7Z
         XAnDDkLnl07Jw==
Message-ID: <7263df01-aebc-2db5-f074-4805e0ae9fbc@marcan.st>
Date:   Thu, 6 Apr 2023 16:18:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     SoC Team <soc@kernel.org>
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC DT updates for 6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these DT changes for 6.4.

For this cycle we have the M2 DT series (which didn't make 6.3) as well as
minor PCIe disable fixes on the older platforms.

-Hector

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.4

for you to fetch changes up to 8d59efc33fdaa2c82072b4d3ba5f67d7dd9270d0:

  arm64: dts: apple: t600x: Disable unused PCIe ports (2023-03-28 20:07:02 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 6.4.

This time we have the M2 (t8112) device trees and compatible updates,
as well as a minor fix for PCIe ports on the prior models.

----------------------------------------------------------------
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
      dt-bindings: arm: apple: Add t8112 j413/j473/j493 compatibles
      arm64: dts: apple: t8103: Disable unused PCIe ports
      arm64: dts: apple: t600x: Disable unused PCIe ports

 Documentation/devicetree/bindings/arm/apple.yaml   |   15 +
 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    1 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/clock/apple,nco.yaml       |    1 +
 .../devicetree/bindings/i2c/apple,i2c.yaml         |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   22 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |   10 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    2 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |    5 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |    1 +
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    1 +
 .../bindings/power/apple,pmgr-pwrstate.yaml        |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |    1 +
 arch/arm64/boot/dts/apple/Makefile                 |    3 +
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |    4 +
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |   11 -
 arch/arm64/boot/dts/apple/t600x-j375.dtsi          |   11 +
 arch/arm64/boot/dts/apple/t8103-j274.dts           |   10 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |   15 -
 arch/arm64/boot/dts/apple/t8103-j313.dts           |   15 -
 arch/arm64/boot/dts/apple/t8103-j456.dts           |   10 +
 arch/arm64/boot/dts/apple/t8103-j457.dts           |   11 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |    4 +
 arch/arm64/boot/dts/apple/t8112-j413.dts           |   63 ++
 arch/arm64/boot/dts/apple/t8112-j473.dts           |   54 +
 arch/arm64/boot/dts/apple/t8112-j493.dts           |   52 +
 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi          |   81 ++
 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi          | 1140 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi               |  912 ++++++++++++++++
 29 files changed, 2403 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8112-j413.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8112-j473.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8112-j493.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8112-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8112.dtsi
