Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6264F4D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLPXPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiLPXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:14:38 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCE248CC;
        Fri, 16 Dec 2022 15:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671232440; x=1702768440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GG3y9hqpWkjOzOhPgzeUiZRZR0VGzftL8K9tkA1WxWU=;
  b=thKmNv2u/uSSfjhSE3++oDjBK4qT7ChUO5NjrQLmj2JRlMJUOUgl4INv
   iU46T+wlLsddiou7AAh6K2cDYhKzyM9RMV5YwOOQREwNCJ76cPYxz1QQU
   8X11bg/f0H8EHBmxqoFScT/TlrGIKydy9xtc1XlKQssN/BwGVwps5ihvC
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Dec 2022 15:13:59 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:13:59 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:13:59 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for generic nodes
Date:   Fri, 16 Dec 2022 15:13:49 -0800
Message-ID: <20221216231349.22835-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings to allow for generic regulator nodes instead of
device-specific node names.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---

Changes from v4:
* updated regulator pattern to accommodate more regulators

This patch comes from discussions on [1] and is separated out. It also
has updated pattern matching to match the comments left from [1].

[1] https://lore.kernel.org/all/20221026200429.162212-2-quic_molvera@quicinc.com/

---
 Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
index b246500d3d5d..5bb624f62edc 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -112,8 +112,9 @@ properties:
     $ref: /schemas/power/qcom,rpmpd.yaml#
 
 patternProperties:
-  '-regulators$':
+  '^regulators(-[09])?$':
     $ref: /schemas/regulator/qcom,rpmh-regulator.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible

base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
-- 
2.38.1

