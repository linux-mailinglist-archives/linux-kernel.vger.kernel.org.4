Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2273051F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjFNQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjFNQgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:36:49 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2EC2706;
        Wed, 14 Jun 2023 09:36:45 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C2F5CCFDC7;
        Wed, 14 Jun 2023 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686760571; bh=oKwU2II8v2XK8a5QmHSSegoJ8EFPKKaePlMwwzSDrTY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Q9ArM7LxEyzLlI6D18nPSodcAj9LXBXXZNOI/4O2Z4Wl7rTenlkiESYkIMAuSQ7Vn
         GjiETPqZfVVQIdoz9iw1iY50jrLtTMdy+OwsVa85/5hX71/O3Ko2RfipVkeSSJGV1x
         quiCSl5mSQ4LmE/C444hovcxW4/LDSe8/nKVYGXY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 14 Jun 2023 18:35:52 +0200
Subject: [PATCH v3 6/6] ARM: dts: qcom: msm8226: Add ocmem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v3-6-79da95a2581f@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v3-0-79da95a2581f@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=oKwU2II8v2XK8a5QmHSSegoJ8EFPKKaePlMwwzSDrTY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkiex5kC8GI+n/EiN2TV8rbfsk0eiX9NWiTft/v
 BnpTCZQViCJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZInseQAKCRBy2EO4nU3X
 ViOLEACe+HKRU7BVYV6CsoWpGLfV0wkDgbbUlJlpZxdirMOXR4qlxfTDbHd2x0C/8UisepVvCmy
 0uuOHwqcFOst6lVwqDJOxp2psVqV+6WufYs7k4xx8lGe5JccjygYg6a0VXkkMKRuFBc1lbN155f
 bOLzOMyrUP/DCarZwnPyt/HtxMbem/dxUwUJJqjoGgXDU1Wvn0zJu0UHRubuVybsQIlCLcSyT7l
 5UfpvRYkUsZLk8GZ6SrmjrtyM7Jc3uWPFfAtwZc/byQWA1sVdemdAnhbV8ttGYGizXH6eX7KzD9
 oSSsTSKvkxIwg/I9FeODOJIZS13Ahk+FC/oJoMjj1paOvdABkGHqsCUBeuIEO3VXNu6mqjulRIH
 EeHsIJVmAsVjR25OgRTY0CG5GJigBYKVd85o+b4G8TpBiHcxUC1fUQ+3E9blDj2rIU+02iqBAR6
 HnkmGF0JdFKcFEN/vEDQcPhttGgVzlQ0go+APOodhgxgdQzH1dN9BTjnO/eVoOez4kvJ4hRPxwy
 BtVIkMkgwRDFxFx++07q0Vu1MhBpUR1OtmyfkvBsoUvEzO97B1GM3+4BPeHQ5bXvOqcV8jsCG/y
 sXle+fQPhrY9tWiWAjopoEZ2q/O7XPNQ8DDrN/V14yHu3aaPustWFKNuFIkR0iHSRyCQJ1CHn8K
 xO2QBs8iZlTXWrA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the ocmem found on msm8226. It contains one region, used
as gmu_ram.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index ec1b72af80aa..7670ea93d76a 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -664,6 +664,23 @@ smd-edge {
 			};
 		};
 
+		sram@fdd00000 {
+			compatible = "qcom,msm8226-ocmem";
+			reg = <0xfdd00000 0x2000>,
+			      <0xfec00000 0x20000>;
+			reg-names = "ctrl", "mem";
+			ranges = <0 0xfec00000 0x20000>;
+			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>;
+			clock-names = "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gmu_sram: gmu-sram@0 {
+				reg = <0x0 0x20000>;
+			};
+		};
+
 		sram@fe805000 {
 			compatible = "qcom,msm8226-imem", "syscon", "simple-mfd";
 			reg = <0xfe805000 0x1000>;

-- 
2.41.0

