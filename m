Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BD71EFFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjFARA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjFARAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:00:24 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C3197;
        Thu,  1 Jun 2023 10:00:23 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5E65ECFC90;
        Thu,  1 Jun 2023 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685638821; bh=5WHPkyvk4StYMkcwb4dHhrbj0F9n7jmIYVJjvJu7XrI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=g1h4SGg6jLrQKsf7dBGdwKpSaOjiCWrLK9MF6xRZ2UY0dYHaROEG28MxYDrW9+P4t
         TsYf4FUF24cYLNMcKXFMXb4UQ/3wEOJ4YtlQnV5w2rObAPFn2PA0hG3a3cPtX/tncr
         6ACOA/0ZnGPltI1K2QQlIYyIDD+cEAYlEo+7x+L4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 01 Jun 2023 19:00:09 +0200
Subject: [PATCH v3 2/7] dt-bindings: display/msm: dsi-controller-main: Add
 msm8226 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v3-2-b6284145d67a@z3ntu.xyz>
References: <20230308-msm8226-mdp-v3-0-b6284145d67a@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v3-0-b6284145d67a@z3ntu.xyz>
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
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=5WHPkyvk4StYMkcwb4dHhrbj0F9n7jmIYVJjvJu7XrI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkeM6d88QPY84BJrJS1MOopM6cc6EnFLuxfLGMs
 A1Mm2N7hg2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHjOnQAKCRBy2EO4nU3X
 Vj1uEADZ9MzzvOg6cssb2m+khXt/QvEhFRpqib9jb8iBlt08Oyb4O8UWIoJNKDCR+HIyoFFc+i7
 o3NdEGVflpzzeGCTU8sJZeFB/x7qd5lmT0v/qvzgTgRiqK8DeOs/EtgzjkE8i+oa4cu/0yo/+oB
 QdW68MO/B4ZeXxQZAArHMmBnPoidM7xL2rIb5DQg7ofAFjzIROgm5BTe1QmTZVxHGm5pDMF74+q
 ZIErHOKdC8xO7KhRnSerssRUA2o5VqHlZjkgbFL+RhgI3n3dsUkOOyb3cI6BfleSVz2seqhU1sH
 bUGXfV2K+Uv9Srrv7qhLkN5vdSMk8YWOJgBA175yAJILJkVHJXd17iK5eqoM2uYxYTYHV7Rh1Md
 HiEuZpyTWLgDZ06c1gaJRkyrzx0vXthZiTDH6skrrnEqr26f6uiDOT3ND0biyDg8WY8LDhWlUzq
 igouSEVcKFbZWItOjLsydZN2/AgAhwHq5165jRrQ6ai3R8y1NjhZAE2Vg35q/Vum3RhT+VmnA4c
 tjUOm90QPkelYm0jyrYme1eviJr+woscJqXEMS3jxp7VkxInsNWhlw79PXjjlcRpoGo1wQ1N868
 ZC5g0E+mtnGb7LgKR93PyU4GSlMLyPghOBYMSXQO3hK9Gox1nKWjb2mgHNpUZAtsQDIO9rbqK0R
 0p/YtXsXwo1DyvQ==
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

Add the compatible for the DSI found on MSM8226.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 130e16d025bc..660e0f496826 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8064-dsi-ctrl
+              - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
@@ -256,6 +257,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8226-dsi-ctrl
               - qcom,msm8974-dsi-ctrl
     then:
       properties:

-- 
2.40.1

