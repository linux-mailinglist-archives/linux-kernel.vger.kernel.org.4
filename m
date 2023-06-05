Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E6721F21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFEHLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFEHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:20 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34646E48;
        Mon,  5 Jun 2023 00:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MvAQmouYZaV32RP/zLih0sGesVxLzOCtmxv3oZtavq13O3nNFknFsjD+lSFo37wGk6
    laE+2FPx27T074mpOAgMkVJG4hlqI7Upi1uF4c3p7GhHTY6AGQeSLgnpAF2XaNEOEWMV
    ND/xI6OYP6MuqLKEr+cSnhdv976SqbvHugp/KWsUP02SRDqzLOA0fbJZ+oza75YugO1m
    9KZ/Qj7yK5bYqK4H3Z3Dpq1kkx31Wa2wxbEOIJQjFhqRfusS6PcJEgNH3mZhEOeHcmjh
    BLiskzyMsLW7YMByVCxlJyc1Q3CwEJczlH36h860REuS2N4sAZY+jsFnKBZzuxKCl71u
    GIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ebVTPJ/mwv+lw/N9dq4GWFiIbE1SohbZeEg+ZHHHEHQ=;
    b=byL6gkq6EM5ft7DT3EDtMTwYPta+gkMZ8qHVvqoeDjglvaZOx9ZNZlbBFQSPWFt4GK
    S3+HHeahMU95vuw/23ddkYIFPl5osc4mlVl7nEbaPlDbl6Zee/+vypuqBiGjdGOqIMCt
    a2HEYgYiwXXYSTclsrY2xWKO1aWHCBsE/aw7YE3YR5ctMENCagVWWcNwH+HtXiYdqc/0
    oeRdhjKXYtkKde3XTLMwfO26/aR4/qadfCyRGuDH/QKrKwiLBpwY2MfRW0kyqCvQlvJm
    eBcGkhYtnkJDwHz+LtT5sM4BBRo5Hpzjw6JVSX6GPMp23AA7w5hC4DfsNipUOziHgwDu
    xF5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ebVTPJ/mwv+lw/N9dq4GWFiIbE1SohbZeEg+ZHHHEHQ=;
    b=c3CYZ3pcif6LbFqaVa7umqU7JznrnC8M1TxTTJHlztS68FbhxAGZEbYW4/+8ie3Zyt
    /Ox0AAZ9g/HKj3zPNDLwqUOXefwTDa2uTBYQzrcDISPBI026EYl1VrcF0C/q0J9eSIbb
    0K42oGfrf6U2Rup+utp+ylSCD6sRajdpjMlCyyJDQ2IF4rz4QgmLQ3mnN/pmCf2d1LrP
    BYjLwnKXTj3VekXxSjdi4w2UAAjNE3hTPZ7lMp8xtypScFa+JWHCiQsYg1Me4ChYDVCs
    YkHQjOAYZDpjLS3gNakACuBm4IO6aJviU5zeRlbF1eAP77Rgw94bcBLr7fdKh0Oq7yNQ
    NMRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948954;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ebVTPJ/mwv+lw/N9dq4GWFiIbE1SohbZeEg+ZHHHEHQ=;
    b=ri2vM6ykg6PYM1zp1w93zKgqhWdLezZL9LQ3D3BkuiRZnKIqKAMtIVmjMI65FlyVtj
    lppL/thsnh9ZxuRkmnDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579E8a5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:22 +0200
Subject: [PATCH 06/14] dt-bindings: soc: qcom: smd-rpm: Use qcom,rpm-proc
 in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new top-level rpm-proc node instead of having a dummy top-level
/smd node that only contains the RPM but not other remote processors.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index c6930706bfa9..06e574239bd4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -120,10 +120,10 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
-    smd {
-        compatible = "qcom,smd";
+    remoteproc-rpm {
+        compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
 
-        rpm {
+        smd-edge {
             interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
             qcom,ipc = <&apcs 8 0>;
             qcom,smd-edge = <15>;

-- 
2.40.1

