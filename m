Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44CF660F7C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjAGOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjAGOTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:19:31 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3E4F11D;
        Sat,  7 Jan 2023 06:19:25 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 1E8F641902;
        Sat,  7 Jan 2023 19:19:18 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673101159; bh=J1rwNSTAV2Z74KvS/GNeSzwAwO8X99k4o12JpwgbUAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwOfTqQCLZ9QZZut31r5ouSn0v93/IZ9hj9KaD7oWBS2khY5tdKSBXRws9azJAQhB
         KUb2zvtFsNgDMTs4zFXxj1PDLWM7+oyGfGtEyM1ioQNS+YGlBUCUG3Gs8z1M+DUAex
         74lZ4xPyWhVg+GSv+H/e80rPM0V0Dn8eikfhOL4f0OGEL7fT5Odeksl7nV6wRL8Gtp
         yQIozSPHrIM/lojFGLxiFEvN+xlct7Th8W+KEvdyKCwgcTK0FYtLWgQp8mvT26yFZo
         +Kfnv4SAK5+YF+QmT7uboT66YebRSMmwb4Ld8NEI2zwYtxnGHTNUNEciEeauThYmmQ
         87lvAI2o6x2rg==
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
Subject: [PATCH v3 1/3] dt-bindings: qcom: Document samsung,gt58 and gt510
Date:   Sat,  7 Jan 2023 19:19:09 +0500
Message-Id: <20230107141911.47229-2-nikita@trvn.ru>
In-Reply-To: <20230107141911.47229-1-nikita@trvn.ru>
References: <20230107141911.47229-1-nikita@trvn.ru>
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

