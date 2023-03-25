Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE106C8E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCYNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjCYNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:22:15 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8661422E;
        Sat, 25 Mar 2023 06:22:10 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PkKVh2vXdz9sTC;
        Sat, 25 Mar 2023 14:22:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679750524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bF9VsuGzSoYgIieRbDoIsSdRfKP285EwWx3I2yVBs9g=;
        b=0L+bubSxdsh+WXrb3qbDJIL4NHPHUjgiEPm6js2diONIt3HaZMa8TjOFa5klnbqe7qAqfP
        kkutaBubL8CY79ZyGYKpiwui4ExLraYNFdstSgiWsiVGlHFd2PqB5CWy25wCfgofi3YNCJ
        rpHcH6QVhL0xM061zJrY46dFjP2PgqwQ1gDBXBceKSYY0G8uB0F8+dd9CUI/akd6Ybm4Je
        KKSfkFmbT0G/PVsHALNdpsiXG51c1QCx+b4XrB58IfHp+eZoRbbNlg0P/vXWuMkzp1TJpJ
        mye0KDog8HqeYsxr5gvHsBhHGTwIY9Sb+cWpkjLagwS5neu9WszrUptU3LVpNg==
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
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas compatible
Date:   Sat, 25 Mar 2023 14:21:16 +0100
Message-Id: <20230325132117.19733-2-me@dylanvanassche.be>
In-Reply-To: <20230325132117.19733-1-me@dylanvanassche.be>
References: <20230325132117.19733-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PkKVh2vXdz9sTC
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
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 643ee787a81f..175be01ecd1c 100644
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
-- 
2.39.2

