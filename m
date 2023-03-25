Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3196C8E24
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCYM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjCYMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B978214EB7;
        Sat, 25 Mar 2023 05:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9B8DB8075B;
        Sat, 25 Mar 2023 12:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E2C433D2;
        Sat, 25 Mar 2023 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747129;
        bh=EDrZUd5VTYszqqdzd5PDKppPRduhbvlPUOvZCEnxzn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QY4HhpBYOtYOnY4qJAaMPpnURwzRgnP6EzSH8wH4k73ilOn3gj82VQpvWq/YBAz0X
         Shwf14oH3vEDSgCRVI2v0nGfkIFHh0QUwZS2s+yOXYXO/Qu5RlAt4KOYA15RkhLU56
         9563qHn3kJ0Wy3/jjm09zKr2GY0S7uoFd+OVtRAMrRz2eshJoydP/ZyO64olPxMQzt
         QNx4iKonSMGMdeQjO53/HuJXxFLwnnfM41A25tHKupUVQt/d7jnuyHQO3DDSKqz4vE
         XaonPZw6fMn2wxteaSqhQ5gMuDrP6BKTz/S6VGFT15BUpRAc6DUhuqSuHYQvaCPjhL
         ufNM5ohSORWaA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 09/12] dt-bindings: qcom,pdc: Add SC8180x compatible
Date:   Sat, 25 Mar 2023 17:54:41 +0530
Message-Id: <20230325122444.249507-10-vkoul@kernel.org>
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

Document the compatible for pdc in SC8180X SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 94791e261c42..65fa4463cdb6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
+          - qcom,sc8180x-pdc
           - qcom,sc8280xp-pdc
           - qcom,sdm845-pdc
           - qcom,sdx55-pdc
-- 
2.39.2

