Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F0E6128B3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ3Hcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJ3Hcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:32:46 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C72D9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 00:32:44 -0700 (PDT)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6A6751F91E;
        Sun, 30 Oct 2022 08:32:41 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] arm64: dts: qcom: sm6350: SD Card fixes, pm6350 keys and touchscreen for PDX213
Date:   Sun, 30 Oct 2022 08:32:22 +0100
Message-Id: <20221030073232.22726-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SD Card for Sony Lena PDX213 on the sm6350 SoC by providing it
the necessary IOMMU stream ID(s) and pinctrl in SoC dtsi, and setting up
the regulators in device/board DT.  Together with regulator support,
power up the touchscreen and import pm6350 dtsi to enable the power and
volume up/down keys.

Marijn Suijten (10):
  arm64: dts: qcom: sm6350: Add resets for SDHCI 1/2
  arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
  arm64: dts: qcom: sm6350-lena: Add SD Card Detect to sdc2 on/off
    pinctrl
  arm64: dts: qcom: pm6350: Include header for KEY_POWER
  arm64: dts: qcom: sm6350-lena: Include pm6350 and configure buttons
  arm64: dts: qcom: sm6350-lena: Define pm6350 and pm6150l regulators
  arm64: dts: qcom: sm6350-lena: Provide power to SDHCI 2 (SDCard slot)
  arm64: dts: qcom: sm6350-lena: Enable QUP and GPI DMA
  arm64: dts: qcom: sm6350-lena: Configure Samsung touchscreen
  arm64: dts: qcom: sm6350: Add apps_smmu with streamID to SDHCI 1/2
    nodes

 arch/arm64/boot/dts/qcom/pm6350.dtsi          |   1 +
 .../qcom/sm6350-sony-xperia-lena-pdx213.dts   | 337 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  48 +++
 3 files changed, 386 insertions(+)

--
2.38.1

