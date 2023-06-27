Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895547403EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF0TOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjF0TOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:14:40 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D126A3;
        Tue, 27 Jun 2023 12:14:36 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so5945039f.1;
        Tue, 27 Jun 2023 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893276; x=1690485276;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZFWyaRT0Zxyt+RNHstpVEYRlwbNXbNNQSJ897mqbXM=;
        b=CIwMdOvK3XhROp8QFmdRXfPUQZUmhtRBBcCDeIlRr4mVvOSpebPH5BFxUytJpvhxVA
         DG/ZC/EZrU3miJ09xCAsZVp9Gjt8Exy4+hTK4mU9ZehKJdqmIE4Q3Y+4sz6CiJuEVJLx
         DCNA9i2HeR7+jzu73OLc681AcOL+0IzCTmc9rjFl+o80ZwSSpwmiW0Efkl5qxm4d14z4
         +L2KlEbEgMWUQGOBliUvWvNdyobPxv+weXwoXmDSC3XOasyTLzbTEnsn4TTkBbPf38cb
         yGopDq9ocQiWQaZ1KtLRLhtR35dNLvqiOfrUi2zAr0WYIh7dmycgE2EOiBMHEdMpgOIn
         tOaA==
X-Gm-Message-State: AC+VfDy6HBRpOUqIZMIjXLAFp+jTd5Hp0nAwtRk3NqVXxbWem0rqYXtk
        FF8XEWn8HUwbaMWEggMGN3Vh3treCw==
X-Google-Smtp-Source: ACHHUZ7auQ0HtR2HBfk76eh853LhmdXPb6r6b9hm0c6Mjq+zzkWiN3uiw0kWJB+kf4f3hpKowNj9ig==
X-Received: by 2002:a6b:1449:0:b0:780:cc8f:aa8c with SMTP id 70-20020a6b1449000000b00780cc8faa8cmr10260369iou.10.1687893275800;
        Tue, 27 Jun 2023 12:14:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eh4-20020a056638298400b00426eea9f398sm816899jab.134.2023.06.27.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 12:14:35 -0700 (PDT)
Received: (nullmailer pid 2621250 invoked by uid 1000);
        Tue, 27 Jun 2023 19:14:33 -0000
Date:   Tue, 27 Jun 2023 13:14:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.5
Message-ID: <20230627191433.GA2599784-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v6.5.

Rob


The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5

for you to fetch changes up to ecdb004843ed91222be38ed838e7ce7167018222:

  dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller (2023-06-27 08:14:38 -0600)

----------------------------------------------------------------
Devicetree updates for v6.5:

Bindings:
- Add some missing type definitions to properties

- Drop unneeded quotes and use absolute paths in bindings

- Remove redundant "binding" or "schema" in binding titles

- Add bindings for Ralink SoCs interrupt controller, QCA2066 Bluetooth,
  infineon,irps5401, new NXP i.MX GPT variants, shineworld lh133k MIPI
  SPI panel, Socionext Synquacer platforms, RK3588 PCIe, ST M95640
  EEPROM, and FSL DCP crypto variants, and Arm Cortex-R52

DT core:
- Improve the reserved-memory range allocation to maximize contiguous
  space

- Use device_set_node() helper in place of open coding

----------------------------------------------------------------
Andy Shevchenko (1):
      of/platform: Propagate firmware node by calling device_set_node()

Ayan Kumar Halder (1):
      dt-bindings: arm: Add Cortex-R52 to the list of enum

Claudiu Beznea (2):
      dt-bindings: interrupt-controller: microchip,sama7g5-eic: use proper naming syntax
      MAINTAINERS: add documentation file for Microchip EIC section

Fabrice Gasnier (1):
      dt-bindings: connector: usb: allow a single HS port

Jassi Brar (1):
      dt-bindings: arm: socionext: add Synquacer platforms

Krzysztof Kozlowski (12):
      dt-bindings: misc: qcom,fastrpc: drop unneeded quotes
      dt-bindings: vendor-prefixes: document TeeJet
      dt-bindings: example-schema: don't use enum as fallback, explain clock-names
      dt-bindings: spmi: mtk,spmi-mtk-pmif: drop unneeded quotes
      dt-bindings: rockchip: grf: drop unneeded quotes
      dt-bindings: i3c: silvaco,i3c-master: drop unneeded quotes
      dt-bindings: gpu: drop unneeded quotes
      dt-bindings: dvfs: drop unneeded quotes
      dt-bindings: firmware: arm,scmi: drop unneeded quotes and use absolute /schemas path
      dt-bindings: arm: drop unneeded quotes and use absolute /schemas path
      dt-bindings: crypto: drop unneeded quotes
      dt-bindings: pwm: drop unneeded quotes

Leonard Göhrs (3):
      dt-bindings: vendor-prefixes: Add prefix for ShineWorld Innovations
      dt-bindings: display: panel: mipi-dbi-spi: add shineworld lh133k compatible
      dt-bindings: display: panel: mipi-dbi-spi: add spi-3wire property

Mans Rullgard (1):
      dt-bindings: bus: ti-sysc: fix typo

Michal Simek (1):
      dt-bindings: trivial-devices: Add infineon,irps5401

Rasmus Villemoes (1):
      dt-bindings: eeprom: at25: add st,m95640 compatible

Rob Herring (7):
      dt-bindings: net: bluetooth: nxp: Add missing type for "fw-init-baudrate"
      dt-bindings: display: Add missing property types
      dt-bindings: crypto: fsl,sec-v4.0-mon: Add missing type for "linux,keycode"
      dt-bindings: crypto: fsl,sec-v4.0-mon: Add "linux,keycodes" and deprecate "linux,keycode"
      dt-bindings: Remove last usage of "binding" or "schema" in titles
      dt-bindings: input: mediatek,pmic-keys: Fix typo in "linux,keycodes" property name
      dt-bindings: auxdisplay: holtek: Add missing type for "linux,no-autorepeat"

Sebastian Reichel (1):
      dt-bindings: PCI: dwc: rockchip: Update for RK3588

Sergio Paracuellos (1):
      dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller

Stefan Wahren (2):
      dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
      dt-bindings: imxgpt: add imx6ul compatible

Stephan Gerhold (2):
      of: reserved_mem: Try to keep range allocations contiguous
      of: reserved_mem: Use stable allocation order

Tim Jiang (1):
      dt-bindings: net: Add QCA2066 Bluetooth

Uwe Kleine-König (2):
      of: unittest: Switch i2c driver back to use .probe()
      dt-bindings: timer: fsl,imxgpt: Add i.MX8MP variant

 .../devicetree/bindings/arm/arm,vexpress-juno.yaml | 10 ++--
 Documentation/devicetree/bindings/arm/cpus.yaml    | 19 +++----
 Documentation/devicetree/bindings/arm/psci.yaml    |  2 +-
 .../bindings/arm/socionext/synquacer.yaml          | 28 ++++++++++
 .../bindings/auxdisplay/holtek,ht16k33.yaml        |  1 +
 Documentation/devicetree/bindings/bus/ti-sysc.yaml |  2 +-
 .../bindings/clock/brcm,bcm63268-timer-clocks.yaml |  2 +-
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml |  2 +-
 .../bindings/connector/usb-connector.yaml          | 20 ++++++++
 .../bindings/crypto/amlogic,gxl-crypto.yaml        |  4 +-
 .../bindings/crypto/fsl,sec-v4.0-mon.yaml          |  6 +++
 .../devicetree/bindings/crypto/fsl-dcp.yaml        | 12 +++--
 .../bindings/crypto/intel,ixp4xx-crypto.yaml       |  6 +--
 .../bindings/display/bridge/analogix,dp.yaml       |  1 +
 .../bindings/display/bridge/nxp,tda998x.yaml       |  1 +
 .../bindings/display/panel/panel-mipi-dbi-spi.yaml |  3 ++
 .../bindings/dvfs/performance-domain.yaml          |  2 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml |  1 +
 .../devicetree/bindings/example-schema.yaml        |  6 ++-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  2 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |  2 +-
 .../bindings/i3c/silvaco,i3c-master.yaml           |  2 +-
 .../bindings/input/mediatek,pmic-keys.yaml         |  2 +-
 ...crochip,eic.yaml => microchip,sama7g5-eic.yaml} |  2 +-
 .../interrupt-controller/ralink,rt2880-intc.yaml   | 54 +++++++++++++++++++
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |  6 +--
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |  5 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  2 +
 .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 16 ++++--
 .../bindings/power/reset/restart-handler.yaml      |  2 +-
 .../devicetree/bindings/pwm/atmel,at91sam-pwm.yaml |  2 +-
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |  2 +-
 .../bindings/remoteproc/ti,pru-consumer.yaml       |  2 +-
 .../bindings/reserved-memory/framebuffer.yaml      |  2 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml      | 12 ++---
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           |  2 +-
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      |  4 ++
 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  4 ++
 MAINTAINERS                                        |  1 +
 drivers/of/of_reserved_mem.c                       | 60 +++++++++++++++++++++-
 drivers/of/platform.c                              |  7 ++-
 drivers/of/unittest.c                              |  4 +-
 44 files changed, 266 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
 rename Documentation/devicetree/bindings/interrupt-controller/{microchip,eic.yaml => microchip,sama7g5-eic.yaml} (98%)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ralink,rt2880-intc.yaml
