Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2E5FFE5C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJPJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJPJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:01:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063AC36BE8;
        Sun, 16 Oct 2022 02:01:22 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E58DECE593;
        Sun, 16 Oct 2022 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665910881; bh=L3F+vtL+QNVYRwcMeegYMGx92a1KgieslLPz6o1ucp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gQv6m/Q6VWaBwnq3WBwL04T5N+MtieGq5ocO3B3fNALl8nVI+ZJT8QwXXEpvkZNFB
         hXEIDbWknHbxvJA9wpTD+SzH7ec+jgzG+m3qEH7gwlky3fsZnp8PXzDysRBqT2s963
         fjIp50hKbv2BZ2C/tzwtcetqwTUKMOdXlLlg4DOg=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: mailbox: qcom-ipcc: Add sc8280xp compatible
Date:   Sun, 16 Oct 2022 11:00:32 +0200
Message-Id: <20221016090035.565350-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the sc8280xp compatible, and at the same time also make sure
the list is sorted alphabetically.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index baca4786ff94..bc599a864637 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -24,12 +24,13 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sc7280-ipcc
+          - qcom,sc8280xp-ipcc
           - qcom,sm6350-ipcc
           - qcom,sm6375-ipcc
           - qcom,sm8250-ipcc
           - qcom,sm8350-ipcc
           - qcom,sm8450-ipcc
-          - qcom,sc7280-ipcc
       - const: qcom,ipcc
 
   reg:
-- 
2.38.0

