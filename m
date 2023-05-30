Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6ED71695B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjE3Q0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjE3Q0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:26:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA934116;
        Tue, 30 May 2023 09:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9B162CB9;
        Tue, 30 May 2023 16:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DABC433A1;
        Tue, 30 May 2023 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463922;
        bh=wAHJlb8lYNyT1QOpxqJtmj6hMsX6F/ImtjxHDEegDEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6wS7xB3wV8wHza/+EHAOo3RJG214r/zbD6xlSY2KXV3UbA/UmkscwD3fgTK1AOIO
         QPf78LE3zdx3TLniryNFY1vcEdjAM2MfvR1OItcQmFEyqbR2FevXI6Ml8DhaE+AYB1
         A4BDvqWV1qQmVm/c6WRSKZLid4Jc8f6vaDrGuGfc6lqQpRRNDvxoHiibieCO/lxQaO
         dB+KC3XxfmQ5C4Hsrlrd96G+RC9EOQx9RQVhphPi+FUZ/Ne7ALKm4Vx7PN2YDSk9LT
         Odggk9a2p0GFRrh5Gh/zdQm/hoRBAOMX5UPuao+6aNMcZN+x1wm+zH5OXTm1wGBQyE
         12TWY1wkhyqvA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 05/15] dt-bindings: qcom,pdc: Add SC8180x compatible
Date:   Tue, 30 May 2023 21:54:44 +0530
Message-Id: <20230530162454.51708-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for pdc in SC8180X SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index a106ba6e810b..bed79a0ceac5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -30,6 +30,7 @@ properties:
           - qcom,sa8775p-pdc
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
+          - qcom,sc8180x-pdc
           - qcom,sc8280xp-pdc
           - qcom,sdm845-pdc
           - qcom,sdx55-pdc
-- 
2.40.1

