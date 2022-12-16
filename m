Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC8C64F522
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiLPXei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLPXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:34:24 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBF13E87
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:34:22 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E08393F32D;
        Sat, 17 Dec 2022 00:34:20 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: qcom: sm6125: QUPs, SPI and Seine I2C buses
Date:   Sat, 17 Dec 2022 00:34:05 +0100
Message-Id: <20221216233408.1283581-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Qualcomm Universal Peripheral support on SM6125 and define all
known SPI and I2C Serial Engines.  On Sony Seine PDX201 all I2C buses
with known-connected hardware are enabled for future hardware mapping,
together with the respective GPI DMA 0 and QUP 0.

Changes since v1:
- Un-downstream pinctrl mapping:
  - Remove nested mux {} / config {};
  - Remove useless comments;
  - Remove unreferenced pinctrl states;
- Use qup14 pinctrl function name instead of unknown qup_14;
- Reword commit message;
- Add iommus to QUP nodes now that this series depends on apps_smmu to
  be available;
- Reorder all properties to match other SoCs;
- Reorder/intersperse QUP nodes with GPI DMA nodes to maintain sorting
  by address;
- Reorder SPI nodes to fit in with I2C nodes, restoring sorting by
  address too;
- Use QCOM_GPI_* constants;
- Adhere to 3 instead of 5 dma cells for gpi_dma.

v1: https://lore.kernel.org/all/20221001185628.494884-1-martin.botka@somainline.org/T/#u

Depends on:
- SM6125 APPS SMMU: https://lore.kernel.org/linux-arm-msm/20221216215819.1164973-1-marijn.suijten@somainline.org/T/#u
- SM6125 GPI DMA: https://lore.kernel.org/linux-arm-msm/20221216231528.1268447-1-marijn.suijten@somainline.org/T/#u

Marijn Suijten (2):
  arm64: dts: qcom: sm6125: Add QUPs with SPI and I2C Serial Engines
  arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0, QUP 0 and I2C SEs

Martin Botka (1):
  arm64: dts: qcom: sm6125: Add pin configs for QUP SPI/I2C Serial
    Engines

 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |  29 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          | 522 ++++++++++++++++++
 2 files changed, 551 insertions(+)

--
2.39.0

