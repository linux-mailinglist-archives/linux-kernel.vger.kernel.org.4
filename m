Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67BC64DE53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLOQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiLOQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:13:27 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375831EFF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:13:26 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXy2X73Rqz1S5Cw
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:13:24 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1671120804;
         x=1671984805; bh=BwIstb6Vcy6GBr5AVEBX3Pw+BjQB82y3dXmIkGVFlBQ=; b=
        XM1Ac4MXHpRcYEnqddQAp2OqLCc5nPQQcBveHYsJBFUzihrX1PEGQJnAttjH5L0i
        NGVjG8+1qo509I45Uhot7cTPadJMQzyIXZG1Qo3gJ8FphOt+PvCIn5FvwcYsMx2h
        8PTBPvS5PTT11b3KijqBe3EKvrYlrSmy7q0Z55LM5QpgXq2X5ngJ+SGTxsthhmVD
        SM5DWTNUoOMIhYrju3ylXb2NYWGn6d54dzV8NhPNii8V3FqxE6e2H67h6HSj+eIG
        aO4xbKAz26DSbp2ysdUG2aYj8rr+Qbz4K2PO6cLqIhSOTM3jD61FgWb37RAvvogx
        2sA739iNu2RGnQG/p/f0sA==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2e6ogI_6-DTx for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 11:13:24 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXy2T01NYz1S4tN;
        Thu, 15 Dec 2022 11:13:20 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm: qcom: Document xiaomi,laurel-sprout board
Date:   Thu, 15 Dec 2022 13:12:56 -0300
Message-Id: <20221215161258.355962-3-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215161258.355962-1-they@mint.lgbt>
References: <20221215161258.355962-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Xiaomi Mi A3 (xiaomi-laurel-sprout) smartphone which is
based on the Snapdragon 665 SoC.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..4923dafb5d7a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -793,6 +793,7 @@ properties:
       - items:
           - enum:
               - sony,pdx201
+              - xiaomi,laurel-sprout
           - const: qcom,sm6125
=20
       - items:
--=20
2.38.1

