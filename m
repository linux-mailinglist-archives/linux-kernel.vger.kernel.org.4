Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890C6C8E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjCYMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCYMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736E15556;
        Sat, 25 Mar 2023 05:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5534F60C41;
        Sat, 25 Mar 2023 12:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F22C4339B;
        Sat, 25 Mar 2023 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747111;
        bh=SryCOVy2qqD4ikeG2FgEm6EuqRJ4SDjfKoA3e8HOxH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXPvx7P2hfpxZP5d4aOizy5Nq7xYLEs0Ip7eHQJbsnSO2m1izxWqmbuyTkbGZvcK4
         1pg9/bVqT9GJZtDxosyNB3FPIsbUeONteFUfaDnkuWYi1xV4zrtAo76MwXGP8eW9XX
         xmxR0hGHVz1Bv8VyFJBBNL1oi4lTl/RhpCyhH0r3xdMUxAj6tQBreKpajkrGwKZBLU
         nzcvLhPxPGC1Nk3hNajdxBz1aOq3dJ9jUY5IhLlxggx7PoSslnsmj5lCX9YGdq2KLq
         s7GizEXi55hytJ4Fjr02UhyVxYnkRBXqav389ZurDdV5vNBc3S6Rbs8rklo4xg6Bk0
         Ej2EKRlItD44w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Date:   Sat, 25 Mar 2023 17:54:36 +0530
Message-Id: <20230325122444.249507-5-vkoul@kernel.org>
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

Document the USB dwc3 controller for SC8180x SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 4875c5b7d5b5..54e24c3abd29 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
+          - qcom,sc8180x-dwc3
           - qcom,sc8280xp-dwc3
           - qcom,sdm660-dwc3
           - qcom,sdm670-dwc3
@@ -324,6 +325,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc8180x-dwc3
               - qcom,sm8350-dwc3
     then:
       properties:
-- 
2.39.2

