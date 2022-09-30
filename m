Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C85F122A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiI3TLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiI3TLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:02 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C03163B6E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:11:00 -0700 (PDT)
Received: from localhost.localdomain (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 6D19E200F8;
        Fri, 30 Sep 2022 21:10:58 +0200 (CEST)
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
Subject: [PATCH 3/8] arm64: dts: qcom: sdm845-tama: Add regulator-system-load to l14a/l28a
Date:   Fri, 30 Sep 2022 21:10:44 +0200
Message-Id: <20220930191049.123256-4-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930191049.123256-1-konrad.dybcio@somainline.org>
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the properties to ensure the ever so delicate touchscreen setup
matches downstream.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 809a6d7e739b..1c9cb1c3d8aa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -198,6 +198,7 @@ vreg_l14a_1p8: ldo14 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-system-load = <62000>;
 		};
 
 		vreg_l15a_1p8: ldo15 {
@@ -284,6 +285,7 @@ vreg_l28a_2p8: ldo28 {
 			regulator-min-microvolt = <2856000>;
 			regulator-max-microvolt = <3008000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-system-load = <100000>;
 		};
 
 		vreg_lvs1a_1p8: lvs1 {
-- 
2.37.3

