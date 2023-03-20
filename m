Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08826C1422
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjCTN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjCTN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA613501;
        Mon, 20 Mar 2023 06:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1824E6151C;
        Mon, 20 Mar 2023 13:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD45C433EF;
        Mon, 20 Mar 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320556;
        bh=wc3FoLvFgLDkOgN7gxHKEwm4JJ7/VP0SV4GEWDLU+TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kp1rXR92DwaNGamGVlJ5BA0l4VTVEUJo5h8XtXWuNyt1UjKof2mnkfEFScjfMRHl5
         nd9UbqNHsGuJGIBalp3Yr6AGzsdKUnF8VGRjSYA4JDOVdQMuI6sx/6cme6EEbHQf7t
         qWEK51be3jcK5BMorqyaYtG856SOhkXNz4AZnWHvr8S0dwnQfu6TOp1RL1DM0neXOF
         RFSDlrjVAzSzYPbXiTykloQkH3auezR6iGrDQ0WRpGe+L+GQMfJ0+NBmsWwWWZAu9l
         BQHvqnmq5zfW+22mrsG3vHx1Q3ukNqoiRoWeh4Lcqd5GeKf99wT0muiIzvREbcCRMM
         GdBZyRmlbUfyQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1peG0j-0000WT-R5; Mon, 20 Mar 2023 14:57:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg' property
Date:   Mon, 20 Mar 2023 14:57:09 +0100
Message-Id: <20230320135710.1989-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320135710.1989-1-johan+linaro@kernel.org>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
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

The SPMI PMIC register region width is fixed and should not be encoded
in the devicetree.

Fixes: 42f45cc655d0 ("arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 1411edd42b25..c35e7f6bd657 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -107,7 +107,7 @@ pmk8280_rtc: rtc@6100 {
 
 		pmk8280_sdam_6: nvram@8500 {
 			compatible = "qcom,spmi-sdam";
-			reg = <0x8500 0x100>;
+			reg = <0x8500>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x8500 0x100>;
-- 
2.39.2

