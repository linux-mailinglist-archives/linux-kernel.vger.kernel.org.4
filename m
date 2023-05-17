Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ACE7070AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjEQSV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEQSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:21:53 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781475BB3;
        Wed, 17 May 2023 11:21:51 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QM1f22KRRz9sps;
        Wed, 17 May 2023 20:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684347706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKhFIBENbm+x57efQqNUL+MpkzQuf72J2Na/e8+68Qg=;
        b=Z7rv4tlUYbSR+QiMIboqSZR9DXWdS9bGMZA/lPo1VhoWF4IjKB0I9OJqrPrIQ2xEb8gwIU
        fLodr9NjkGsGNcaz/GoTl9AaM2uN2QWIo+HMPp/8szQvA+4xozP6J1P2/i/IMTDDFwWDSp
        eZ/x/PPcjbmDL2NUhWWA44067Q9kmKQV20iIU6jlqSy9FWHKAfjNuOBMLtd5AW+WcEwhs1
        SrL5dVKNrsV3Q/rmZC8d9Ee6c0ngt6xcSLKq8ZWpsiHhqqvcPKSXq7ibCi9wAOaDjlB6On
        TsRYVT2SRXUU66g2nC0DeJRRGCMw3rUDoWR5mHqmbDeR13JD8goEo9vlTeWx2g==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 1/2] arm64: dts: qcom: pmi8998: add flash LED
Date:   Wed, 17 May 2023 20:21:32 +0200
Message-Id: <20230517182133.72590-2-me@dylanvanassche.be>
In-Reply-To: <20230517182133.72590-1-me@dylanvanassche.be>
References: <20230517182133.72590-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PMIC PMI8998 has a 3 channel flash LED driver which is used
by many phones for 1 or 2 flash LEDs. Each LED can be used in flash mode
or torch mode. Add the flash LED node to PMI8998 DTS.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index ffe587f281d8..89f959353ad5 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -60,6 +60,12 @@ pmi8998_lpg: pwm {
 			status = "disabled";
 		};
 
+		pmi8998_flash: led-controller@d300 {
+			compatible = "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
 		pmi8998_wled: leds@d800 {
 			compatible = "qcom,pmi8998-wled";
 			reg = <0xd800>, <0xd900>;
-- 
2.40.1

