Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221425F1239
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiI3TLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiI3TLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:22 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2641739C8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:11:04 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 9A7C620172;
        Fri, 30 Sep 2022 21:11:02 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arm64: dts: qcom: sdm845-tama: Enable GPI_DMA0/1
Date:   Fri, 30 Sep 2022 21:10:47 +0200
Message-Id: <20220930191049.123256-7-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191049.123256-1-konrad.dybcio@somainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable both GPI DMAs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index ba949b0466dc..c7607d008b1c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -390,6 +390,14 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
-- 
2.37.3

