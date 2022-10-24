Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E43609A74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJXGV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJXGVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:21:20 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C660B5D729
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:21:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0888B42137;
        Mon, 24 Oct 2022 06:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666592466; bh=MWOe8I8q+lsn3KC3yEyEeeUlPMaoDKA+SDB384axbew=;
        h=Date:From:Subject:To:Cc;
        b=s13njybK5vMlyqvnEPoWt+yMX/7eumgrt53TjX/5GdEHIR/7gdB5eltPb4M01UZzf
         qRvG9zsxFkzPpu0O19aUBXL2wKJoqD4jZfV7kHQgrGaWAlywshLoDgz1OUu8OjUXAm
         XuzKwN/g7wCx4ML3OBhJidAN4kaVoUNWwR/68MaO6AqI4F5JgoOoXjJvCOOSLS4TG6
         PeIeiL1pXcm/4y3ZFK9bya3OiHMguYP9eo/HwBXpt4T3mK2Uum8I1pHAQ0KojfrpZ7
         Vo6uoea5V2FDxTAehF9mG+sq1+RZVsDbuas4c9zJrGHNeHvnplDa8PTEbVJNc+AjMK
         En6O3F8p85QPQ==
Message-ID: <dea10860-2870-3a9e-fa51-21e493b1573a@marcan.st>
Date:   Mon, 24 Oct 2022 15:21:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC DT updates for 6.2
To:     SoC Team <soc@kernel.org>
Content-Language: en-US
Cc:     Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these DT changes for 6.2.

These are the t6000 device tree changes that got punted last cycle, and
some audio stuff.

-Hector

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.2

for you to fetch changes up to 56fed763f6b2dc2578ea8c3e7d317722d8581cba:

  arm64: dts: apple: Add ADMAC resets on t8103/t600x (2022-10-24 13:44:22 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 6.2.

This includes new device trees for Apple M1 Pro/Max/Ultra SoCs and the
devices that contain them, as well as some audio-related changes.

----------------------------------------------------------------
Hector Martin (3):
      arm64: dts: apple: Fix j45x model years
      arm64: dts: apple: Add initial t6000/t6001/t6002 DTs
      arm64: dts: apple: Add J314 and J316 devicetrees

Janne Grunau (4):
      dt-bindings: apple,aic2: Add CPU PMU per-cpu pseudo-interrupts
      dt-bindings: arm: apple: Add t6001/t6002 Mac Studio compatibles
      arm64: dts: apple: Add J375 devicetrees
      arm64: dts: apple: t600x: Add MCA and its support

Martin Povišer (4):
      arm64: dts: apple: t8103: Add AUDIO_P parent to the SIO_ADMA power domain
      arm64: dts: apple: t8103: Add MCA and its support
      dt-bindings: dma: apple,admac: Add reset
      arm64: dts: apple: Add ADMAC resets on t8103/t600x

Sven Peter (1):
      dt-bindings: iommu: dart: add t6000 compatible

 Documentation/devicetree/bindings/arm/apple.yaml   |   14 +-
 .../devicetree/bindings/dma/apple,admac.yaml       |    3 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |   29 +
 .../devicetree/bindings/iommu/apple,dart.yaml      |    4 +-
 arch/arm64/boot/dts/apple/Makefile                 |    6 +
 arch/arm64/boot/dts/apple/multi-die-cpp.h          |   22 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts          |   18 +
 arch/arm64/boot/dts/apple/t6000-j316s.dts          |   18 +
 arch/arm64/boot/dts/apple/t6000.dtsi               |   18 +
 arch/arm64/boot/dts/apple/t6001-j314c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6001-j316c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6001-j375c.dts          |   18 +
 arch/arm64/boot/dts/apple/t6001.dtsi               |   63 +
 arch/arm64/boot/dts/apple/t6002-j375d.dts          |   50 +
 arch/arm64/boot/dts/apple/t6002.dtsi               |  175 ++
 arch/arm64/boot/dts/apple/t600x-common.dtsi        |  137 ++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi          |  361 ++++
 arch/arm64/boot/dts/apple/t600x-dieX.dtsi          |  103 +
 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi     |   45 +
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi     |  114 ++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi          |  117 ++
 arch/arm64/boot/dts/apple/t600x-nvme.dtsi          |   42 +
 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi          | 2012 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts           |    2 +-
 arch/arm64/boot/dts/apple/t8103-j457.dts           |    2 +-
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi          |    4 +
 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          |    2 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |   74 +
 28 files changed, 3484 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/multi-die-cpp.h
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j314s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6000-j316s.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j314c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j316c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001-j375c.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t6002-j375d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t6002.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-die0.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-dieX.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-j375.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-nvme.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t600x-pmgr.dtsi

