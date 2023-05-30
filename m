Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85266715666
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjE3HP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjE3HPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:48 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7EA7;
        Tue, 30 May 2023 00:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O2ZrUNMExofJCyp+xb8soTNB/qruZ7SnbETh2ANKqpdEm4kWxjzMLx+Lm1m1v/eo/J
    e1mFA0gyr5FrGSVCJm6/k7L9OKMACNlEngvNubX+abcdF7iXvIAPYh189guLauM0ykie
    Rai49u/6kN3E29eBf7wn5L1Gg5wNnarExcEtCpLjTU4bvPiRlTIobWUIAtgxWovcSTLb
    LPItxkkmay+fbYp2fgA2ZgyN9QaPyUStVbAGpcZu/EupwjWb0FYcYygqfP8eJsYet/30
    OjntaDE/AJhPWEIfwi8Oce5wugRsa8jEYAxCva0PAkvTcGOSFxWM4Ef64J0aWEPWoORQ
    tl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2KRaEElXAD4S0mIyP/gn/tG9uVH/rIP31zJlYfxpitE=;
    b=GaKdTLULBLjkwqSj7zUYnIxuvABjmToNHa/2oZVNNJedSConUj3dQCcEYXy16r+lxU
    NmumMZR3iPL/MkqOTbf6Gs1otxKpxmN5cSUIlvTpEgQs6lMLw6z965CwIIneHnrD/T9W
    zwjDcyrZo7VZjshZKfZIjQNBYJichyszTrPfkisclAeOrLHEQxp//ngV8QaOkX3Jdqd0
    v+5Zji59PrDzzeuaplSTYmcf4Rq8bUd1ZVeG8YakT0XaMgbdfJh+KQ2oupmamLTx5ZlR
    U/lra705ZH103kPCXpOwSl+DnqfUYf447jaDoPwz1eJL7QaIwxYqHhIBKo5kn3NVzGYj
    jsQA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2KRaEElXAD4S0mIyP/gn/tG9uVH/rIP31zJlYfxpitE=;
    b=nRKgfUZ5kn7J/6uGJRr+SpuCfarOEWdSBNaI8AFVzLt0Q+8ewNiHyu/J6koUtkWUie
    fVXiqRNXuLDpcp5OvFWttTzzzWQNDWrsN/pktcdPX24O/PhCxZPI8i069INrTyMzIsnE
    qkrnJM3coCPE4ChGQ+VkW0EC74VFaE9IonW6dPYsoJz4WCjntdH2fdr5KNBZT9m0sISw
    25IL7nW1uPqW/cY4yfmfGOtokvAq8CfPS5NWT2J29guxFtk7xV0UgDd2nKE8KnMB/4fC
    HvAYtiJm4qsK7vMWuFLj0ex/kXi3SdTXcAVP7vl9UdCy7S4jW/wN2tQ3QYgFUavg8djl
    uidg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2KRaEElXAD4S0mIyP/gn/tG9uVH/rIP31zJlYfxpitE=;
    b=itcXXULje12DSW3IqyQ8nsRpZFXp4dw0hnZ+nO3nMC74GkUlQCsohle67OGHE8zvGo
    bYPO4/ddeOfmX2m16gBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FZgY1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:24 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: apq8016-sbc: Drop unneeded MCLK
 pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-3-11f540b51c93@gerhold.net>
References: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
In-Reply-To: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO116 is not connected (NC) on DB410c so there is no need to route
MCLK there. The MSM8916 digital codec receives the MCLK internally
without leaving the SoC through a GPIO.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 23e3b86186ac..dad7586712da 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -385,8 +385,8 @@ &sdhc_2 {
 &sound {
 	status = "okay";
 
-	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act &ext_mclk_tlmm_lines_act>;
-	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus &ext_mclk_tlmm_lines_sus>;
+	pinctrl-0 = <&cdc_pdm_lines_act &ext_sec_tlmm_lines_act>;
+	pinctrl-1 = <&cdc_pdm_lines_sus &ext_sec_tlmm_lines_sus>;
 	pinctrl-names = "default", "sleep";
 	model = "DB410c";
 	audio-routing =

-- 
2.40.1

