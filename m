Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908460EF37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiJ0EwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiJ0EwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:52:01 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2AB74CFB;
        Wed, 26 Oct 2022 21:52:00 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Oct 2022 13:51:59 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CD5FC2059027;
        Thu, 27 Oct 2022 13:51:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 27 Oct 2022 13:51:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 689A9B62A4;
        Thu, 27 Oct 2022 13:51:59 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/4] Add UniPhier boards support
Date:   Thu, 27 Oct 2022 13:51:53 +0900
Message-Id: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
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

This series adds support for NX1 SoC, and the boards for Pro5 and NX1 SoCs.
Some of these boards have PCI endpoint.

NX1 SoC follows the same architecture as the other UniPhier SoCs, except
for the memory map.

Kunihiko Hayashi (4):
  dt-bindings: arm: uniphier: Add Pro5 boards
  ARM: dts: uniphier: Add Pro5 board support
  dt-bindings: arm: uniphier: Add NX1 boards
  arm64: dts: uniphier: Add NX1 SoC and boards support

 .../bindings/arm/socionext/uniphier.yaml      |  13 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/uniphier-pro5-epcore.dts    |  76 ++
 arch/arm/boot/dts/uniphier-pro5-proex.dts     |  59 ++
 arch/arm64/boot/dts/socionext/Makefile        |   3 +
 .../boot/dts/socionext/uniphier-nx1-evb.dts   |  83 +++
 .../boot/dts/socionext/uniphier-nx1-ref.dts   | 109 +++
 .../boot/dts/socionext/uniphier-nx1-som.dts   |  50 ++
 .../boot/dts/socionext/uniphier-nx1.dtsi      | 704 ++++++++++++++++++
 9 files changed, 1099 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-epcore.dts
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-proex.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-evb.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1-som.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi

-- 
2.25.1

