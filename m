Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026471694E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjE3QZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjE3QZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E82191;
        Tue, 30 May 2023 09:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179C162CD8;
        Tue, 30 May 2023 16:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526A7C433D2;
        Tue, 30 May 2023 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463911;
        bh=d2gVDzwIPPxSbXqTOHtlQQd0CoMF5uyR1gVHER/mfK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMdpKafSbsFXE+scK3rRVyGdM90l6vnp7coIh/A1oIrRbxd0DqTcUxrJpwr5qCmaU
         u2QF+xZoAKNhG0fem4gF56JhYQQVwbqV3sa6a15oOUGeVHu6k4hrPzTdpFS2FytBMV
         tAl+UoXml5Y7dzcQw4h7AzyHhXfx1u2HadTVvfjaeWqMSKjKGVi35V/sgHOg43DARv
         W1BG93B+O7t8vtBXD/Bce6JX0ct+r2aQ7suP4HPW4DoFIrzLDi3HPSUsrzkasvnitQ
         E2C9W/20ZvqA4hZQF0nJsBITaniyw5wYOtRS3ufFEWdj4/D4ZsXRwb4atyp2XJDTgX
         cdrP3Y0qNg+sg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 02/15] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Date:   Tue, 30 May 2023 21:54:41 +0530
Message-Id: <20230530162454.51708-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the USB dwc3 controller for SC8180x SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index d84281926f10..49037e6e386f 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -25,6 +25,7 @@ properties:
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
+          - qcom,sc8180x-dwc3
           - qcom,sc8280xp-dwc3
           - qcom,sdm660-dwc3
           - qcom,sdm670-dwc3
@@ -327,6 +328,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc8180x-dwc3
               - qcom,sm8350-dwc3
     then:
       properties:
@@ -355,6 +357,7 @@ allOf:
               - qcom,msm8994-dwc3
               - qcom,qcs404-dwc3
               - qcom,sc7180-dwc3
+              - qcom,sc8180x-dwc3
               - qcom,sdm670-dwc3
               - qcom,sdm845-dwc3
               - qcom,sdx55-dwc3
-- 
2.40.1

