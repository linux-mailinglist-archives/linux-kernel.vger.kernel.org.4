Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15D65A774
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiLaWZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiLaWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:25:06 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE350B864
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:25:02 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NkxWx1KWgz1S5Ds
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:25:01 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672525500;
         x=1673389501; bh=BwIstb6Vcy6GBr5AVEBX3Pw+BjQB82y3dXmIkGVFlBQ=; b=
        YI+T0opjupdPzxR7NCWsSSVLyikoAwPbfHiaKNQrdjnVNsv4ollplL4Vj/Ac72Do
        6QMywqk3pwilZjXGAuDOW2ikLmWm9xrbb+BJIRA+Zdkv7ohbzqxO1J6sLMybnQUl
        u7jQ+WKYmxjYhUxG06+Rc1/1U8EZl/Gt9B6XIj9EfwCVlP0znApLiT3XAz+NzT+C
        /GzBPLxXDizyefvF2dkLBD3Sl1hlwbxDRNzv9MFtuXiS3nf1xYcDfwYtHolEx4s/
        0cPAd/QczodTbtpdTMsLz/sD8yzgAwbGLMb5TvvEQGmQN7MSw9pEAeHzDRnSJOc7
        90CNdh6iXQ8WWq/iCceqJw==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dft645G5Sxox for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:25:00 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NkxWr2dftz1S5Ck;
        Sat, 31 Dec 2022 17:24:56 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] dt-bindings: arm: qcom: Document xiaomi,laurel-sprout board
Date:   Sat, 31 Dec 2022 19:24:19 -0300
Message-Id: <20221231222420.75233-6-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231222420.75233-1-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
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

