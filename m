Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF46C8E03
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjCYMZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCYMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45017FF2F;
        Sat, 25 Mar 2023 05:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1AB7B8075B;
        Sat, 25 Mar 2023 12:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F74C4339B;
        Sat, 25 Mar 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747100;
        bh=Cr31zPC/LCsN6rN5/Wspat2aJTwHQQPwRBWW8b2i37I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpPTfzO1PpMlSDXQwaNIOv6pUKQyrAyICRh8ejxRsl2IiX0Q9JXCgFGi+wDCYYUtq
         qnjG+7erZpXDXHvfLAhjvVfwjhwXZmH5jPi7Jtso4hCnUpx2ZJFGo0FK7EfMKlxkpN
         0iPodyrZz9pzYnT9y1nk+fo3X8sAae3h3CLkyBUZcfF7D9fMGD00sbiwYFKYoAoRnC
         2nZophfUyXWezGuYJ4R4NO8E6I8UXKd7sFxqLp3QPhyP5v2Mi2/DJYBvwokT7fjbem
         9IQuM92XjXyIvJ9JltFzeE4qV7YGgEePmJ92crdZO9840bxkmOeE+R4PMhuDH2QSzI
         ynWZckWzfaLPQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/12] dt-bindings: firmware: document Qualcomm SC8180X SCM
Date:   Sat, 25 Mar 2023 17:54:33 +0530
Message-Id: <20230325122444.249507-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for Qualcomm sc8180x SCM.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index a66e99812b1f..d5b7d6d38445 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -42,6 +42,7 @@ properties:
           - qcom,scm-sa8775p
           - qcom,scm-sc7180
           - qcom,scm-sc7280
+          - qcom,scm-sc8180x
           - qcom,scm-sc8280xp
           - qcom,scm-sdm670
           - qcom,scm-sdm845
-- 
2.39.2

