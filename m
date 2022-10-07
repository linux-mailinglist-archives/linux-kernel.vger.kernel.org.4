Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6855F77DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJGMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJGMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C703C897C;
        Fri,  7 Oct 2022 05:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC86C61CCE;
        Fri,  7 Oct 2022 12:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C402C433D6;
        Fri,  7 Oct 2022 12:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665144704;
        bh=0pN/KKvgXNTMlPUD7QSUeOpqyBrffihcXMWu6MhPQiM=;
        h=From:To:Cc:Subject:Date:From;
        b=nmmFoPjEDUzOUP9DBzwSLDZ3gLvz7kL0F8cxCuFSgCO7Ms3JHwkykpi5JLsE9hZJA
         0+chcMkQ4IbSFmoWstQJOCHX0DTCG+jnLCUt/MxL/l0Gp/vRWyEh8u2kY9c2EDL1E/
         5/fXBSjJI9CjzRWjdUUfly77v98lyGMNieg6Ju+53Qf0QRAYw48skLPuhRACJkg2C5
         A5o2q24H3d9EsgbwBsp8IS7i6o+22OJzNqSKrlXq/IB5WeNBDniQAKQZbg0CB4h8LT
         LRWDPyvpG2Fdv+94bL83+h54f3wKmRj4kPC/8rWYhhRKBYM1VuF4EJ9uyjI03c1Qmf
         q2YgrSNS//GWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ogmCZ-0001Q0-Vh; Fri, 07 Oct 2022 14:11:40 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Date:   Fri,  7 Oct 2022 14:11:10 +0200
Message-Id: <20221007121110.5432-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Add a binding for the SC8280XP TCSR.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index d3c25daa995e..914d4ff6d3d7 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,qcs404-tcsr
               - qcom,sc7180-tcsr
               - qcom,sc7280-tcsr
+              - qcom,sc8280xp-tcsr
               - qcom,sdm630-tcsr
               - qcom,sdm845-tcsr
               - qcom,sm8150-tcsr
-- 
2.35.1

