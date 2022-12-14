Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189B64C607
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiLNJdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:33:04 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F2A1275D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:33:01 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NX9C01WLxz1S5Cr
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:33:00 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1671010379; x=1671874380; bh=gKWL8aO
        LSs/dj4UkVPePb06jnEQR7vS1rnbVl04CgWg=; b=cQF82uuXyz0tXuqcpNBxjL1
        td+BjFfb/6ZdFmIMFuj2pzioXwDtBwmvOcKv+tuLGIwnHfcquIorcNyOLj7cqwGn
        OvUg+YUzFZMyqYC5bQPJFdsmQbVNjEFwEck1eM8GBDjE+fCpbn664jwMpxT3dkiH
        ZTD28QhaP+OvcdUGUdXIixDvOAVApCfh4xHdSfT2kbX32UN5/V+gVnkwZJLOxheV
        Z2U3jkFG13lIs1Ob/t0gY36TU96mE2tE912fJZn9VljdHzfqdum59kpQrLFB/EWI
        +f5I9PQ/VsIMJ58PpMd1bmZgv+7S+s09X6ylbLZedG24RFIp+G56yN6gbdbhQTg=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hVcbteJKZlCn for <linux-kernel@vger.kernel.org>;
        Wed, 14 Dec 2022 04:32:59 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NX9Bw1VwPz1S52g;
        Wed, 14 Dec 2022 04:32:55 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
Cc:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: qcom: Document xiaomi,laurel_sprout board
Date:   Wed, 14 Dec 2022 06:32:48 -0300
Message-Id: <20221214093248.153245-1-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Xiaomi Mi A3 (xiaomi-laurel_sprout) smartphone which is
based on the Snapdragon 665 SoC.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..a72fbb6b4b2c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -693,6 +693,7 @@ properties:
       - items:
           - enum:
               - sony,pdx201
+              - xiaomi,laurel_sprout
           - const: qcom,sm6125
=20
       - items:
--=20
2.38.1

