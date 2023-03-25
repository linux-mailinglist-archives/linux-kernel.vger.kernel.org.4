Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB256C8E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjCYMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCYMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E964814483;
        Sat, 25 Mar 2023 05:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51D72B8075F;
        Sat, 25 Mar 2023 12:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6E2C433EF;
        Sat, 25 Mar 2023 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747108;
        bh=RdzOelXYvx3QrBd1xcpOZg6N+igw7RzYV0uefoNp8LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrEMnFWibBjZAzygarjfI5m4nhovuoNGCDAOMHa8TvroO2KulDMjLGt5B0a3Ayr+j
         3TurMLBJsqcgepxGy1/VK1a/HCjNf/J4RY1s2SeCipqGiqmY/DVgWUrKCpSph2UPQJ
         iELpBDWh9Kiq1R+F2JJmcgTR4eC9Kj3B5JBB+uyRkML6DlkW72Lops4VfW3S71xS4g
         NeyvIlNeg11F55qUgE30rCpimWet+1h+A9I4O3qxVCPw9846RJbYbjW3Mb/07TWojx
         Z497qZ5y4j6wzwBQ0I0LMtvO9pSoxpQq7fm9i20QV9MRjYm8EERnu5IvS6Vk1BrO46
         KzA1XwSQ2c/qQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] dt-bindings: phy: qcom,qmp-pcie: fix the sc8180x regs
Date:   Sat, 25 Mar 2023 17:54:35 +0530
Message-Id: <20230325122444.249507-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc8180x pcie phy requires to describe six reg areas for the phy to work,
so move the description to the correct place documenting tx, rx lane 1,
2 and pcs and pcs misc.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 62045dcfb20c..3d42ee3901a1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -203,6 +203,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc8180x-qmp-pcie-phy
               - qcom,sm8250-qmp-gen3x2-pcie-phy
               - qcom,sm8250-qmp-modem-pcie-phy
               - qcom,sm8450-qmp-gen4x2-pcie-phy
@@ -224,7 +225,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,sc8180x-qmp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy
               - qcom,sdx55-qmp-pcie-phy
               - qcom,sm8250-qmp-gen3x1-pcie-phy
-- 
2.39.2

