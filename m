Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303AE604EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJSRbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJSRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:31:35 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035D1A20AC;
        Wed, 19 Oct 2022 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1666199431; bh=YA0BOkdiz79MH4TeYdCWc3K+k18k+lPhrqSBn3FcEP4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=JL7hCR89MUtFpd5Z+MHPdLV/5j4ihmusu2mjgcRbqp3kZtm/c5PzyqE+BWP1oGtfQ
         24weX/ucrxYNtW4yKjl9sf7kUEgIFr1CpWRAtHT+XWC+G8ORikR2pJ+ZhkG+P/cSkS
         qItt8UZgypnFljVH+V8Bf7w3uOFVAaUWNT9e8GzQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.207]
        Wed, 19 Oct 2022 19:10:31 +0200 (CEST)
X-EA-Auth: pqrCBYabG3dWmpjf45ktDvkr0IckO/bnqpsV44HUeQQRkdEgoNO8NUMhjPIpAoNKEjgxkCqIkm2lkHD2MuYOgMOcO9odgIpr6Uo639adV9g=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 1/2] dt-bindings: soc: qcom: spm: Add MSM8939 CPU compatible
Date:   Wed, 19 Oct 2022 19:10:02 +0200
Message-Id: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "qcom,msm8939-saw2-v3.0-cpu" compatible for the CPU
Subsystem Power Manager (SPM) on the MSM8939 SoC.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
index f433e6e0a19f..8791f8ad2c84 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,msm8998-silver-saw2-v4.1-l2
           - qcom,msm8909-saw2-v3.0-cpu
           - qcom,msm8916-saw2-v3.0-cpu
+          - qcom,msm8939-saw2-v3.0-cpu
           - qcom,msm8226-saw2-v2.1-cpu
           - qcom,msm8974-saw2-v2.1-cpu
           - qcom,apq8084-saw2-v2.1-cpu
-- 
2.37.3



