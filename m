Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4533D707A26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjERGOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjERGON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:14:13 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17045E7D;
        Wed, 17 May 2023 23:14:12 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QMKS068Hfz9sjD;
        Thu, 18 May 2023 08:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684390448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9j5G4gKyrwFGbE/WdOFHjE3lA3m+LfSpd+C5Pcu9YkM=;
        b=GqEoeAJDs1nKJE8po+66gsojnRDTVrt1VsDFKnHW4fZ1Yyv1tuWtj4LA9YHY3O92ZfitcR
        lMOv3Mx0e73PWmxtbxqLXm+gKlYc7DWfkj68frM1c5wwY96MYTgg7kCFznYB5XFtgPTy3+
        AQK8vDC9WvntTm6E5k5Vu/gNJZT4uOyxV/9sMLps/gsFgGOi30u7O0PfUoycqm/qrEWvSi
        Il/an35BVL0bsWIord1rscgiqDGQqe1PF4+Ns1LQpnneGFVAPmS9vgUhgpsU/QoXIjlYZz
        oKaaeiOX2bUhagTSptuHEUu5ssgomdpY0Ke4zrzwDRGb+XYhm1u9Gs1RFzPpbw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 2/3] arm64: dts: qcom: pmi8998: add flash LED controller
Date:   Thu, 18 May 2023 08:13:27 +0200
Message-Id: <20230518061328.146847-3-me@dylanvanassche.be>
In-Reply-To: <20230518061328.146847-1-me@dylanvanassche.be>
References: <20230518061328.146847-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QMKS068Hfz9sjD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PMIC PMI8998 has a 3 channel flash LED driver which is used
by many phones for 1 or 2 flash LEDs. Each LED can be used in flash mode
or torch mode. Add the flash LED controller node to PMI8998 DTS.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index ffe587f281d8..08e00819b39d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -60,6 +60,12 @@ pmi8998_lpg: pwm {
 			status = "disabled";
 		};
 
+		pmi8998_flash: led-controller@d300 {
+			compatible = "qcom,pmi8998-flash-led", "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
 		pmi8998_wled: leds@d800 {
 			compatible = "qcom,pmi8998-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.40.1

