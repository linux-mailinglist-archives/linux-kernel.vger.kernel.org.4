Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56D67CDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjAZOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjAZOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:23:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1E1D91B;
        Thu, 26 Jan 2023 06:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EFB61877;
        Thu, 26 Jan 2023 14:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30AEC4339B;
        Thu, 26 Jan 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674742979;
        bh=q2Bbjj15dQE3xFdW3ZNa040Zv7U1rr2wKNg7FOHt9Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV1d9Unocn1wapAKWF+DKxSVHJgr3xEEW0vCjObhVaN5P8c2rAMovOJ0/T4zuatC9
         9pnGTsUYl5LM8i0gt39olhyDNqUjUyw9fJQBgE85HVuC+Wkrpnk7nhjzKw2W9opoiU
         BrZy1dolgpdc+9WZ27Gkbb/oDWSSc49J1pM7VrELTEAyKfsw/edNneTOZu8VTW1pek
         Jt/F+CRKA058MJDz0zdpLVVBBRC52363GSzEXINFe3l0XgvSBr+ggJw0Ig6vGkmst9
         id+S6fxlcY7ozBLDWRZug/NrGV17bEz5fpa2jdsC1gJCM1992irOrWuo8F9djUDaIP
         z2ZO8227AlHRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL39d-0006jD-TT; Thu, 26 Jan 2023 15:23:05 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 22/24] arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram
Date:   Thu, 26 Jan 2023 15:20:55 +0100
Message-Id: <20230126142057.25715-23-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126142057.25715-1-johan+linaro@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one of the PMK8280 SDAM blocks which can be used to store an RTC
offset.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index c62262b88810..7220d5b5ab7b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -104,6 +104,15 @@ pmk8280_rtc: rtc@6100 {
 			wakeup-source;
 			status = "disabled";
 		};
+
+		pmk8280_sdam_6: nvram@8500 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x8500 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x8500 0x100>;
+			status = "disabled";
+		};
 	};
 
 	pmc8280_1: pmic@1 {
-- 
2.39.1

