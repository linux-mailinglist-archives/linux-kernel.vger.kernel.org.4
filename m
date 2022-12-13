Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9338E64C01E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiLMXBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiLMXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:01:41 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0330F254;
        Tue, 13 Dec 2022 15:01:38 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146061654"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 08:01:38 +0900
Received: from mulinux.home (unknown [10.226.93.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 062D1400D4DC;
        Wed, 14 Dec 2022 08:01:32 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 0/4] SDHI/MMC SoC support for the RZ/V2M
Date:   Tue, 13 Dec 2022 23:01:25 +0000
Message-Id: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds SDHI/MMC support for the RZ/V2M SoC.

Thanks,
Fab

Fabrizio Castro (3):
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
  mmc: renesas_sdhi: Add RZ/V2M compatible string
  arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support

Phil Edworthy (1):
  clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |  1 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    | 48 +++++++++++++++++++
 drivers/clk/renesas/r9a09g011-cpg.c           | 34 +++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++
 4 files changed, 94 insertions(+)

-- 
2.34.1

