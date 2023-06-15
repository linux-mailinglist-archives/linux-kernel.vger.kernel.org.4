Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028E731E75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbjFOQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbjFOQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8372D45;
        Thu, 15 Jun 2023 09:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847856; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OYnkWFMUf+7i2X4XQ2dNmwIMlqLRCnQqtCxCYNxczyBOJic2pfhdkqNjgMtgocUGsB
    Yp8FXznppIaVfWoxLsGAvdRe+w60i5k+LIOt+l7CK/4S2bnyA8mE3ucvLGi+07TPQWdv
    GAgf0y4C5AbcqP2tDP2Vj+vIaNvx6tm+xVADb2s6CvcKq4NklHKxZVRJNd66aDvELZyg
    qq+IkKwBsnbV2jYn4Ee2H9B05d5pdVK/eEh8LXn1/LHousgt1AA71YRHHt5YGplLLBmt
    Q3y5kkH7cI9bgFb7TyzYik9QRX084FG9RG3eki+ExNf2kxdisA42sOJvgnqyz8ISMlyE
    9B0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=e3uST5fLGOUnGwSt4p0Biiiiiw75/Lg6PSk0roxV6pQ=;
    b=XIf9zo/ePoqBILUcV8XMOz/WoXR+UnojFBBvyeHVEjcjx0njR2UR1RhJsor86h80cc
    JcpJHHa73MemtwYQbjtBXf1ji0/9Td7jf3HRxE5MNfLrKN9Y27UohAVRP2pGI6QfRBp6
    brCWhLJAe/xUixEcdhNLqz9k01czvbuMBXakCk+zbYJD0D9TmH7pXXTZqOWiW0ID/dEF
    4j9I1LyD1XDfUUqX9365SnJFMnHfK7B66Za6055M74eN27QP9WM3g2W6cCCqDL3zLEdY
    jOUSwbbzwTMoYGVNZurAlTQrsOidtMHuXvs0eg9sDt/iN1oh0oCtpGaz/LtcyikLrHCB
    xPiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=e3uST5fLGOUnGwSt4p0Biiiiiw75/Lg6PSk0roxV6pQ=;
    b=g2oGJXqqpjdrZyL44VtX3CKm8zLZoxvP0pXbyCMZcoeLW/K4ExYIGwkj9TLcgw2x5G
    t6L95uLX9XEHdvdfG6VNhTTMgVdd2YlMgcKWDH2MVTQgfxkxDZXbhMAI5it5d/8sR4ji
    eG0Zwv1+jKbZpkdr/RlgN2xAkmED+3HFEnujFAvJ/ma1MnF64BUwCE928B9pczPpd3fo
    bcn2ArIjvOp/OhIiqjuwzf1lDzdQaFv4QnztqC2nIUIO4YD09LoFy4DiPGFVUn5hUmJ7
    SybG5tUXuk9HmT18NUTayBg9/E56UJX9Jg0VlbuYE02yyvBN8j6lJbz+aNDjcLZxMrk+
    zu+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847856;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=e3uST5fLGOUnGwSt4p0Biiiiiw75/Lg6PSk0roxV6pQ=;
    b=BMwdx7q/33kCd/fAH+bctrNNpccJHiC5IHiANOMjqH0E+a/7tc0SsmOvyR/gAFLBbF
    UpJhxqlapbDZ+qB5lhAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGou42g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:56 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:38 +0200
Subject: [PATCH v3 05/13] dt-bindings: remoteproc: glink-rpm-edge: Use
 "glink-edge" as node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-5-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
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

Semantically glink-edge and glink-rpm-edge are similar: Both describe
the communication channels to a remote processor. The RPM glink-edge is
a special case that needs slightly different properties but otherwise
it is used exactly the same.

To improve consistency use the same "glink-edge" node name also for
glink-rpm-edge. Drop the $nodename from qcom,glink-edge.yaml to avoid
matching the wrong schema. qcom,glink-edge.yaml is always referenced
explicitly from other schemas. This will already ensure that the nodes
are being checked, so it's not necessary to bind to all nodes named
"glink-edge".

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml     | 3 ---
 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
index 7b43ad3daa56..e78a89c9ec41 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -14,9 +14,6 @@ description:
   related to the remote processor.
 
 properties:
-  $nodename:
-    const: glink-edge
-
   apr:
     $ref: /schemas/soc/qcom/qcom,apr.yaml#
     required:
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
index f5a044e20c4e..884158bccd50 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
@@ -84,7 +84,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    rpm-glink {
+    glink-edge {
         compatible = "qcom,glink-rpm";
         interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
         mboxes = <&apcs_glb 0>;

-- 
2.40.1

