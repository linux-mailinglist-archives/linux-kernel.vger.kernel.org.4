Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF164E18D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiLOTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiLOTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:04:29 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113204AF18
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:04:27 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NY1qs4f48z1S5Cx
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:04:25 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1671131064;
         x=1671995065; bh=BwIstb6Vcy6GBr5AVEBX3Pw+BjQB82y3dXmIkGVFlBQ=; b=
        4IPt2m4Fh3CzgUCN4eTp9zYtK7oT1Dl0zvRx0NVTKeoOnF2te31qSE8tQVIRnPtf
        Y4CVN+fK8t7iR2Yc9oXxtTfNW/4t3iq6DW3qMbDImx9tzIKfRUw4cWrPOPbuIFub
        GhX59f/HgUKV+lL63epbihDaJDbJJABRRRSOz88gJqxIrz5QfaOEGMahLPXeU28N
        rR6rvyRZBypJzwKGrx+HfpNu4eIjae90jGELgd7XaQTsR5EoWOoLChCN+FEHomkS
        y8ZV962lx4cKiRqjcxt/nVOdpgGpTSnS8LQ1RQc0Nsb7/CzLlTqYhwXVRIFPnd2X
        35IqAgpP1QvCNO8JHeyz2g==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ddzT5EEpFaNz for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 14:04:24 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NY1qn2yszz1S5Cm;
        Thu, 15 Dec 2022 14:04:21 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: arm: qcom: Document xiaomi,laurel-sprout board
Date:   Thu, 15 Dec 2022 16:04:03 -0300
Message-Id: <20221215190404.398788-3-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215190404.398788-1-they@mint.lgbt>
References: <20221215190404.398788-1-they@mint.lgbt>
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

