Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F465745C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1I4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1I4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:56:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954025FB;
        Wed, 28 Dec 2022 00:56:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AF61B8109E;
        Wed, 28 Dec 2022 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE75C433EF;
        Wed, 28 Dec 2022 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672217788;
        bh=8kKUNMcrrr0Y1Xedt+qZwO8rQtcXcgKODbZvvAQe4s4=;
        h=From:To:Cc:Subject:Date:From;
        b=aoXKtyVbdTegZBUNjqHSM7SCk+/d0e4FILbzyhIIyO7lLNdPSFWTDUWOB9kfmv7jx
         Iv8mzbwlViYooCyKok8B06eQCMt3UdUcJfHfwpCtqsy/XwoB6U48ONP01yj9Cq06h2
         pORUpHfTzwjgWv3l5v6ndnSg1SV9WvPLmASN22KFwtKvQLOfrZYFBdXgJ0ISYmGzks
         fZP18ADire1ZG+VJuR4CyZXV5bWSbn42brQAi0OzgFALwBJ8dhQTf2axoxUHtYQa6q
         W5jfPiGOEo5zux8uNnZPEYc0Y3FqvA0CWWmFoq7Xx+/YPwqvbjemeuGM9pFiQxVq51
         0dzLZ6yySmsqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pASEg-0003vQ-G3; Wed, 28 Dec 2022 09:56:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: move 'regulator-vph-pwr' node
Date:   Wed, 28 Dec 2022 09:56:14 +0100
Message-Id: <20221228085614.15080-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
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

Move the new 'regulator-vph-pwr' node before the wlan regulator node to
restore the root-node sort order (alphabetically by node name).

While at it, add a couple of newlines to separate the properties for
consistency with the other regulator nodes.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index aeb9e1800f71..0201c6776746 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -95,6 +95,16 @@ vreg_nvme: regulator-nvme {
 		regulator-boot-on;
 	};
 
+	vreg_vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VPH_VCC3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		regulator-always-on;
+	};
+
 	vreg_wlan: regulator-wlan {
 		compatible = "regulator-fixed";
 
@@ -127,14 +137,6 @@ vreg_wwan: regulator-wwan {
 		regulator-boot-on;
 	};
 
-	vreg_vph_pwr: regulator-vph-pwr {
-		compatible = "regulator-fixed";
-		regulator-name = "VPH_VCC3R9";
-		regulator-min-microvolt = <3900000>;
-		regulator-max-microvolt = <3900000>;
-		regulator-always-on;
-	};
-
 	thermal-zones {
 		skin-temp-thermal {
 			polling-delay-passive = <250>;
-- 
2.37.4

