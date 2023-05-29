Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A5714760
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjE2JqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjE2Jp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:45:57 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B3189;
        Mon, 29 May 2023 02:45:32 -0700 (PDT)
Received: from [192.168.122.1] (217-149-172-244.nat.highway.telekom.at [217.149.172.244])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0A12FCFC27;
        Mon, 29 May 2023 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685353500; bh=8sIn/Qz0l9jKCvWDS6LR4GIaadAQo/SQgllobL2+TqU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=gLvd+//fU8fm71mZT5VbhoBp3gOGZMq8gCEHZPqSbkZyTQ+xtFH29AR8vbs0rMxHr
         rQ9A8SM6a//+jRMIuyQBIlBABLEW5nvI90d8PCp7ioySfAvyvlxzXurLAtljYvJGRo
         dm99TjAQcRQEBpcZvsQcLMVcuNuaXj2kJCoFNjyo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 29 May 2023 11:44:00 +0200
Subject: [PATCH 3/7] dt-bindings: display/msm: qcom,mdp5: Add msm8226
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v1-3-679f335d3d5b@z3ntu.xyz>
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=8sIn/Qz0l9jKCvWDS6LR4GIaadAQo/SQgllobL2+TqU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkdHQVmzfdSUiOjj0rA8qZ4KUbvyyfYVN2HPCxI
 1qYANeRNJ+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHR0FQAKCRBy2EO4nU3X
 VqhmD/9SaQzg08+ttAZ4k0pCFP0Jq/ngScWc1jWT1NLy6R3BuZB59NpszqGWm1dUssVUYgq1Jev
 RHjBxmrc6X6I4jFGZb9i3XyQw8I5SKyD4XhDrhukDf5mBfKa0Dsfn7Kmx8z7ElyDAmvdZXi77te
 iTdwBq/Gyf5LGPGgWW8PdBmFW3ROwkZ8MyEMS39Plvjuy5KLI2frOMsfC763SIrAsmmyNXSvTXH
 bZpXZp+86mxERPf9BI/9c6g8EVF+ecY1UX3BPfeBqOafi+cSy7YXw3GsCG/Ck5kob6fhD2DH+/b
 qJ8IGe0D5L/He1wTF0TDJgk7xazyprwr2aRUFn7n+yP0wpvZN8lxZAvN8R/G1JdohexGeM6xz9m
 lvyiL473bvXUKqXlGfa9CiZ6GtUTcoR1LisW+UBQHCYh+gV0HMvp1aVHNUShXCkIDX689owKqsD
 tXLKnwhhMqsV1TimiYjrFt3xf4pjeREez+RQgzXBCVU8n//J29LPK8088CRRFf2NM8x0s5VgAZp
 bBZgOJdWKPqhvLjeCPNtS1mIE9gX/ePb/HB8krNqRjH4QnoBhYn3+H09B+0SPI2IDTtex9df9WL
 w6/T05Lp0Whk0XozrKyqqz9IpiTIjIoe1T3PWVcGXPi052Sq6NK78INkGLh3kzo5SjrQNwf4gcS
 5OlagslCJ67p+Yg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the MDP5 found on MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
index a763cf8da122..2fe032d0e8f8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
@@ -22,6 +22,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8084-mdp5
+              - qcom,msm8226-mdp5
               - qcom,msm8916-mdp5
               - qcom,msm8917-mdp5
               - qcom,msm8953-mdp5

-- 
2.40.1

