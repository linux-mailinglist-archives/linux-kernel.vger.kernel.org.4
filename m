Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61166739F78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFVLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:33:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29CB51BE4;
        Thu, 22 Jun 2023 04:33:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.00,263,1681138800"; 
   d="scan'208";a="168532768"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2023 20:33:51 +0900
Received: from mulinux.example.org (unknown [10.226.93.117])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id DDA1141D4839;
        Thu, 22 Jun 2023 20:33:43 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2 0/5] spi: Add CSI support for Renesas RZ/V2M
Date:   Thu, 22 Jun 2023 12:33:36 +0100
Message-Id: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

This series is to add support for the Clocked Serial Interface (CSI)
IP found in the Renesas RZ/V2M SoC.

Thanks,
Fab

v2: edited list of include files in drivers/spi/spi-rzv2m-csi.c

Fabrizio Castro (5):
  spi: dt-bindings: Add bindings for RZ/V2M CSI
  clk: renesas: r9a09g011: Add CSI related clocks
  spi: Add support for Renesas CSI
  arm64: dts: renesas: r9a09g011: Add CSI nodes
  arm64: defconfig: Enable Renesas RZ/V2M CSI driver

 .../bindings/spi/renesas,rzv2m-csi.yaml       |  70 ++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  28 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g011-cpg.c           |  15 +
 drivers/spi/Kconfig                           |   6 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rzv2m-csi.c                   | 667 ++++++++++++++++++
 7 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
 create mode 100644 drivers/spi/spi-rzv2m-csi.c

-- 
2.34.1

