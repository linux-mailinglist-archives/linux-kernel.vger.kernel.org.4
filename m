Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507EE660038
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAFM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAFM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:26:17 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B506369;
        Fri,  6 Jan 2023 04:26:12 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C84CB41B60;
        Fri,  6 Jan 2023 17:26:08 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673007969; bh=J1rwNSTAV2Z74KvS/GNeSzwAwO8X99k4o12JpwgbUAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KboYuJtcukSbl85gOttHdBbM6DNjJB8YTakwn2q59mjrEEUCjvv/AeLyi0+kblZIn
         sr+TOZsJyKCqU4PUUbvCg+7wvZb/AXWEzwJXzd+dg7tNGTGA7TTNa/oRM14rhUlJO6
         wadBDCK8/mgA0m+Xyfrp8TBmiTq3VOb68zcf9pXXxE4cG0LPp98ZhdltbANTag5ARa
         3yUTXq01BcMl4IkEwdNo1kAoG4RDYzHEr+iPRxhFREmGAsPIrJq6+Wh98V8gFP2HZb
         Hb6/x/fi23kvKF9srR8XtScIwoqy91Jfz54RZ8Y6tEvyaF+WYf7antngRMZxgkaLl+
         6+T5cR1NU3YAA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: qcom: Document samsung,gt58 and gt510
Date:   Fri,  6 Jan 2023 17:25:30 +0500
Message-Id: <20230106122532.3310265-2-nikita@trvn.ru>
In-Reply-To: <20230106122532.3310265-1-nikita@trvn.ru>
References: <20230106122532.3310265-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gt58 and gt510 are Samsung Galaxy Tab A 8.0/9.7 (2015) tablets.
Document their compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 65ef7e442da0..6231df1cc14c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -207,6 +207,8 @@ properties:
               - samsung,e5
               - samsung,e7
               - samsung,grandmax
+              - samsung,gt510
+              - samsung,gt58
               - samsung,j5
               - samsung,serranove
               - wingtech,wt88047
-- 
2.38.1

