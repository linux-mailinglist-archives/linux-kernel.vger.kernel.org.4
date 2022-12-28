Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5175C6587C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiL1XFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiL1XE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:04:59 -0500
Received: from out-165.mta0.migadu.com (out-165.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B36FB483;
        Wed, 28 Dec 2022 15:04:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1672268696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX12PPrpVaQ0okjZ3v8ED+SmTV830cTNmWMddh4n+Lo=;
        b=QLNE5vt8ljE1dRTI8h1E118N/nN3feZym7Ma+9Qih+dnAkHUHutHetU7TXhbZ9vXAl7nri
        EcsMhLnqM01hsu78E7088xdWo1OkpVIjxZMCMlWPDCFORhB14u+DNtj7cSCVsFPEFjouI7
        31+FaDg68lOhNdqEgHpmjhcYfgE3+88=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: iio/adc: qcom,spmi-iadc: document PM8226 compatible
Date:   Wed, 28 Dec 2022 23:04:19 +0000
Message-Id: <20221228230421.56250-5-rayyan@ansari.sh>
In-Reply-To: <20221228230421.56250-1-rayyan@ansari.sh>
References: <20221228230421.56250-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for the IADC used on PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index fa855baa368c..18aaf6df179d 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,pm8226-iadc
           - qcom,pm8941-iadc
       - const: qcom,spmi-iadc
 
-- 
2.39.0

