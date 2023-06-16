Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCF732D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjFPKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjFPKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D270AC;
        Fri, 16 Jun 2023 03:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F14A0634C5;
        Fri, 16 Jun 2023 10:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E2C433D9;
        Fri, 16 Jun 2023 10:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911127;
        bh=QOrQZst8tv3kUGiApkN9jYV5mSZ1qKp1Gc8Rvo4qTZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ846p1GuQnGqTLnNm8l+8XxG/vv/RCT/pn0Bh8A2xXhcKcscksgJCTrcot7NQR4I
         7+4b5sexVBWcQrjXWGGwxU26nVcJo+cMVXFBQB+hIEPQhFKTIn55bmaXtuYW4d+2Vh
         9Vgoepmtx9plSG1oxmI9d3/T9vVuIPZR6L+diujXnwvzk6nbSZF1X/xIrKrkxjhOwp
         0f4ytRIpmD3YRptlU2eLvlMqJoslSAnYfHBbxN9Qysx66//7SQkBysgLQw/xC7GZd/
         clPQWKxkvLIKJwt4CgrOM33Bl3VNdl+AKTbmUzO54lr399FpC8MIoNy7TVjJDEIzLl
         6qRIa49W0hNHA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/30] arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
Date:   Fri, 16 Jun 2023 06:24:51 -0400
Message-Id: <20230616102521.673087-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 16bd455d0897d1b8b7a9aee2ed51d75b14a34563 ]

The WCD938x audio codec Soundwire interface part is not a DAI and does
not allow sound-dai-cells:

  sc7280-herobrine-crd.dtb: codec@0,4: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230220095401.64196-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 88204f794ccb7..1080d701d45a2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -419,7 +419,6 @@ &swr0 {
 	wcd_rx: codec@0,4 {
 		compatible = "sdw20217010d00";
 		reg = <0 4>;
-		#sound-dai-cells = <1>;
 		qcom,rx-port-mapping = <1 2 3 4 5>;
 	};
 };
@@ -428,7 +427,6 @@ &swr1 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		#sound-dai-cells = <1>;
 		qcom,tx-port-mapping = <1 2 3 4>;
 	};
 };
-- 
2.39.2

