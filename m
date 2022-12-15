Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7164DE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLOQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLOQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:13:20 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BD31EE1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:13:19 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NXy2P6w0xz1S5D0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:13:17 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1671120797; x=1671984798; bh=We5xjhG
        qrFdJQxR93Npt09VH/7a6fXPhQTRN9HYr93I=; b=MRpzEE+Z7zP8IwDwvLo5Gf0
        O0JrPZxOnieXnJjS2Ntj/BMqdVROkik02wrU7SLH83iBh6fC0KBB2y5PRdgGwzdq
        QqLsJSk2IWWDxJ0ev2kZxO/xzCu+E75dp8m/ZGo4MhOPPdtrtuawGdoK8YjeG9UU
        nYY+uW/NH9AhuOyBEbaK9R1Y7MFvut1mEmHb+veTNyLU1/5tgn5vFe5jUqlK/tlN
        w6GOFqVo5lhC4ulaIWbkWoP77PUNMIU+5jizpcUKr7t67YE9THqBVV0u0ESqyjsi
        LxvFmPJR1q4gWfCOlRYOC0UapZwqv9fQCmBRe9acQ07NVX89ERy4vLyrI+ymQoQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Iq-8lLolGfQs for <linux-kernel@vger.kernel.org>;
        Thu, 15 Dec 2022 11:13:17 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NXy2H493zz1S4t9;
        Thu, 15 Dec 2022 11:13:11 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lux Aliaga <they@mint.lgbt>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: ufs: qcom: Add SM6125 compatible string
Date:   Thu, 15 Dec 2022 13:12:54 -0300
Message-Id: <20221215161258.355962-1-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
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

Document the compatible for UFS found on the SM6125.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docume=
ntation/devicetree/bindings/ufs/qcom,ufs.yaml
index b517d76215e3..42422f3471b3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
+          - qcom,sm6125-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -185,6 +186,7 @@ allOf:
           contains:
             enum:
               - qcom,sm6115-ufshc
+              - qcom,sm6125-ufshc
     then:
       properties:
         clocks:
--=20
2.38.1

