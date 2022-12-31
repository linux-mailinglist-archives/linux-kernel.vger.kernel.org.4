Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB565A76C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiLaWYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiLaWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:24:49 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3476396
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:24:47 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NkxWf1qVzz1S5Dm
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:24:46 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672525485;
         x=1673389486; bh=n/SJk/pinTpxZTv2ojGtArZAwokciPTwlvYARNi8gEw=; b=
        BeTTFMgxg8mRvFRjVEulgVvHQ3Ge24Op3I63R5f77pYcWcrzmxmUJFk+kUh6MG7o
        sK2pvxRSkahNpSZ/u8lka6UE8AaRKPdzR4tQr+OcQleO0x5G9g6MzDogMjzDSSVy
        jgC3uthrI4oGjCQNqbNoABNMWywwq80rgYQOtNnG9CiyU6kyY6o20sFX3WRUQz4q
        7+RiY0bXd1nOzmv/WbTuJ8bCeUCrwOYn5n7oBkXQWQcLRP8qvTBDc7Su75gW8d6H
        8JdHWHyLYjT+ZEZxI90kYaQRN2WjVabtNWpZBgxsYqwwHHYkgUv1JFhWCa1x5M8i
        H6iqozqQ0icgsGR3qV0uew==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sIVlvCoBilQK for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:24:45 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NkxWX3Qw2z1S5Dq;
        Sat, 31 Dec 2022 17:24:40 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] dt-bindings: phy: Add QMP UFS PHY compatible for SM6125
Date:   Sat, 31 Dec 2022 19:24:16 -0300
Message-Id: <20221231222420.75233-3-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231222420.75233-1-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP UFS PHY compatible for SM6125.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-=
phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-ph=
y.yaml
index dde86a19f792..a7af57931f32 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yam=
l
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yam=
l
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,sc8280xp-qmp-ufs-phy
+      - qcom,sm6125-qmp-ufs-phy
=20
   reg:
     maxItems: 1
--=20
2.38.1

