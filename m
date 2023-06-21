Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90D973865E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjFUOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjFUOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:10:15 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BD218C;
        Wed, 21 Jun 2023 07:09:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.00,260,1681138800"; 
   d="scan'208";a="164779177"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jun 2023 23:09:58 +0900
Received: from mulinux.example.org (unknown [10.226.93.96])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B92D4220BE7;
        Wed, 21 Jun 2023 23:09:50 +0900 (JST)
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
Subject: [PATCH 0/5] spi: Add CSI support for Renesas RZ/V2M
Date:   Wed, 21 Jun 2023 15:09:38 +0100
Message-Id: <20230621140944.257352-1-fabrizio.castro.jz@renesas.com>
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

