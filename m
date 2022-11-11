Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E594D625704
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiKKJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiKKJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:40:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3D6CA04;
        Fri, 11 Nov 2022 01:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EB6ACE2608;
        Fri, 11 Nov 2022 09:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F69C433D6;
        Fri, 11 Nov 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159611;
        bh=VAAWEKuCo1e53QmgMf0yNFFYiMrUPT/oqX01uL3eBHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYOMf9mBwZBbhzoMGhd/IP5+2FhdEyP88CEu1obynBoQyyOKBbQXgyxjkFgPgrIRw
         QiADi82aeD1qQW4NTIWVAs1f3Foft+0UQGES3SK3+l3x2SyDXd0GtQtNQIGBNGNP7m
         HforyS5UYvJld+GOz0Jvu5PFYXLbXrbaItQV0KY1f7ni7cjgsVJnc1a7Gd5MJ9bhKy
         WBQBebVFHWhhRxfNQRTQGT8Lq4gDqdt1f7/XkDN0CtH+DQ06L6IjAqfgI2sWXjsEzd
         uiUBKu2ynyv4+WR2zF2xED05NYlimf4sr64ll7gSZaFG2MmzBg4SZ/beIi1/xKVFmZ
         LvODC0yfkwmQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQVj-0002xh-7c; Fri, 11 Nov 2022 10:39:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: drop reference-clock source
Date:   Fri, 11 Nov 2022 10:38:55 +0100
Message-Id: <20221111093857.11360-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111093857.11360-1-johan+linaro@kernel.org>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The source clock for the reference clock is not used by the PHY directly
and should not be included in the devicetree binding.

Fixes: e8e58e29a0c9 ("dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index ef080509747a..16fce1038285 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -22,12 +22,11 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 5
+    maxItems: 4
 
   clock-names:
     items:
       - const: aux
-      - const: ref_clk_src
       - const: ref
       - const: com_aux
       - const: pipe
@@ -82,12 +81,10 @@ examples:
       reg = <0x088ef000 0x2000>;
 
       clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
-               <&rpmhcc RPMH_CXO_CLK>,
                <&gcc GCC_USB3_MP0_CLKREF_CLK>,
                <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
                <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
-      clock-names = "aux", "ref_clk_src", "ref", "com_aux",
-                    "pipe";
+      clock-names = "aux", "ref", "com_aux", "pipe";
 
       power-domains = <&gcc USB30_MP_GDSC>;
 
-- 
2.37.4

