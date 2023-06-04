Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63172150F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjFDGQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:16:33 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EBC0DE;
        Sat,  3 Jun 2023 23:16:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id A6B66140760;
        Sun,  4 Jun 2023 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1685859390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FP2gB0fKqHSs01B3FaMvtRymVwZ6icFMWCiGtpOYCwY=;
        b=jn4lexKq14Ovc4PGc+RAT08+m3ll/F6TyQcs0VvAibSpL9QIp0V5slunkQNFLS8XiBUSBa
        AhuzcbR9nGFW34X/oGCIKkqpxQouFt5L7pEma+VTWCYwoEHofjgF12LKz8f0P3xevx5eqy
        1Vin7B9qrVnIWm0YB9JssgX1xQ12brA=
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH 1/3] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Add SDM660 compatible
Date:   Sun,  4 Jun 2023 09:14:19 +0300
Message-Id: <20230604061421.3787649-1-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention sdm660-mss-pil in compatibles list.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 .../devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index c1ac6ca1e759d..09da5616e1e5a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,msm8996-mss-pil
       - qcom,msm8998-mss-pil
+      - qcom,sdm660-mss-pil
       - qcom,sdm845-mss-pil
 
   reg:
@@ -245,7 +246,9 @@ allOf:
   - if:
       properties:
         compatible:
-          const: qcom,msm8998-mss-pil
+          enum:
+            - qcom,msm8998-mss-pil
+            - qcom,sdm660-mss-pil
     then:
       properties:
         clocks:
-- 
2.39.3

