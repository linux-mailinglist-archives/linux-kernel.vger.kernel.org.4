Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD87861F0C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKGKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKGKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:34:30 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21136A1A1;
        Mon,  7 Nov 2022 02:34:13 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2022 19:34:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2675420584CE;
        Mon,  7 Nov 2022 19:34:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 7 Nov 2022 19:34:13 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 86BA6B62A4;
        Mon,  7 Nov 2022 19:34:12 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/5] Add UniPhier boards support
Date:   Mon,  7 Nov 2022 19:34:05 +0900
Message-Id: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for NX1 SoC, and the boards for Pro5 and
NX1 SoCs. Some of these boards have PCI endpoint.

NX1 SoC follows the same architecture as the other UniPhier SoCs, except
for the memory map.

And this series also adds bindings to define compatible strings for the
system controllers implemented in the SoCs.

---
Changes since v1:
- Add system controller bindings patch
- Adjust some node names to recommended generic ones
- Remove undefined compatible strings 
- Describe background for NX1 SoC and restrictions in the DT patch
- Move clock-frequency of reference clock to the board's devicetree
- Move status to last in the node
- Fix aidet node to interrupt-controller
- Add Acked-by: lines

Kunihiko Hayashi (5):
  dt-bindings: arm: uniphier: Add system controller bindings
  dt-bindings: arm: uniphier: Add Pro5 boards
  ARM: dts: uniphier: Add Pro5 board support
  dt-bindings: arm: uniphier: Add NX1 boards
  arm64: dts: uniphier: Add NX1 SoC and boards support

 .../socionext/socionext,uniphier-sysctrl.yaml |  92 +++
 .../bindings/arm/socionext/uniphier.yaml      |  13 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/uniphier-pro5-epcore.dts    |  76 ++
 arch/arm/boot/dts/uniphier-pro5-proex.dts     |  59 ++
 arch/arm64/boot/dts/socionext/Makefile        |   3 +
 .../boot/dts/socionext/uniphier-nx1-evb.dts   |  87 +++
 .../boot/dts/socionext/uniphier-nx1-ref.dts   | 109 +++
 .../boot/dts/socionext/uniphier-nx1-som.dts   |  54 ++
 .../boot/dts/socionext/uniphier-nx1.dtsi      | 702 ++++++++++++++++++
 10 files changed, 1197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-epcore.dts
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-proex.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi

-- 
2.25.1

