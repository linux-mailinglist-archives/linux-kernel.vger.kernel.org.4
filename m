Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C865D632ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKUVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiKUVbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:31:05 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0094A6868B;
        Mon, 21 Nov 2022 13:31:04 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 600FFD04E7;
        Mon, 21 Nov 2022 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669066263; bh=jg5oyu8gY/50Q9Yv1hRE4YDXD+cCDTKGLga91rXuzeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vDgisO3zkDVBVUKSv8Axc4Szh27NT+RY4zJm5Rh5u3hSXbd7gRXRWVr5T3yURGDX0
         MCvg5BqL+RSzJ6QW0POa3PIpYstUbQjuOl1b5I+yDJs+2qAn8gBsJC2AENgm05Or1u
         dHjQgMw1oNpbe13q7lMMCVtFyxBqIXLeTNUlbWds=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Julian Weigt <juw@posteo.de>, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974-castor: Enable charging over USB
Date:   Mon, 21 Nov 2022 22:30:20 +0100
Message-Id: <20221121213019.324558-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121213019.324558-1-luca@z3ntu.xyz>
References: <20221121213019.324558-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Weigt <juw@posteo.de>

Set usb-charge-current-limit to higher value so that the device can be
charged over USB.

Signed-off-by: Julian Weigt <juw@posteo.de>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 2725bd343f3a..0f2154a57a59 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -575,6 +575,7 @@ &smbb {
 	qcom,fast-charge-safe-current = <1500000>;
 	qcom,fast-charge-current-limit = <1500000>;
 	qcom,dc-current-limit = <1800000>;
+	usb-charge-current-limit = <1800000>;
 	qcom,fast-charge-safe-voltage = <4400000>;
 	qcom,fast-charge-high-threshold-voltage = <4350000>;
 	qcom,fast-charge-low-threshold-voltage = <3400000>;
-- 
2.38.1

