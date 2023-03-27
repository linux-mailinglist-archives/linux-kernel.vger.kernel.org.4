Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6346CAD22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjC0SiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjC0Sh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:37:56 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B048E;
        Mon, 27 Mar 2023 11:37:55 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PlhQ76bdvz9sTQ;
        Mon, 27 Mar 2023 20:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIvrfq7nPBrhOHJF/rCo/28hLbusgGnVy+v+bHtkkN4=;
        b=A3bRQUWQbemZgduxd1HMFw9MyHqgdbfGJvA6qN1aoX/inj48X5WF+3y4cIyI5/CSYM4gqG
        BrrVVIuCyG5kLYsAkkT8OJvutnFGvPrx2SLoI+GjTpwEY3H7FIAOI64Vz6+fLnVp3xSjMS
        GzpuGmck2Fspx/XZD04XbLEwc1opX2OgGLjjBEFx0E+cri/OK6c1fl0+q6bee4nQRc500P
        dXI5HwgwI7UbZSnKiBznoWgRtYnrKyS1vopb3XjQaImHkma6kgd6B289HzMxHd0RdCMhXj
        W3uC5shL1VxHywClv6Esx1si+NJJjngfiG2w7/hJcWIgBB7SjIwrulQ+w2Ymkg==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas compatible
Date:   Mon, 27 Mar 2023 20:37:34 +0200
Message-Id: <20230327183736.496170-2-me@dylanvanassche.be>
In-Reply-To: <20230327183736.496170-1-me@dylanvanassche.be>
References: <20230327183736.496170-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLPI DSP remoteproc on DSP is defined by the 'qcom,sdm845-slpi-pas'
compatible in the qcom_q6v5_pas driver. Add this compatible to the
devicetree bindings.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 .../bindings/remoteproc/qcom,adsp.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 643ee787a81f..eb4a440a661a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -26,6 +26,7 @@ properties:
       - qcom,sdm660-adsp-pas
       - qcom,sdm845-adsp-pas
       - qcom,sdm845-cdsp-pas
+      - qcom,sdm845-slpi-pas
 
   reg:
     maxItems: 1
@@ -63,6 +64,7 @@ allOf:
               - qcom,msm8998-adsp-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
+              - qcom,sdm845-slpi-pas
     then:
       properties:
         clocks:
@@ -104,6 +106,7 @@ allOf:
               - qcom,msm8998-slpi-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
+              - qcom,sdm845-slpi-pas
     then:
       properties:
         interrupts:
@@ -157,6 +160,22 @@ allOf:
       required:
         - px-supply
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sdm845-slpi-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
   - if:
       properties:
         compatible:
-- 
2.39.2

