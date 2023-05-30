Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91F716C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjE3SZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjE3SZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:25:23 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417110D;
        Tue, 30 May 2023 11:24:59 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1F1D3CFBF2;
        Tue, 30 May 2023 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685471067; bh=5WHPkyvk4StYMkcwb4dHhrbj0F9n7jmIYVJjvJu7XrI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ibA0Cwh1dTtwIXvr2o1xaAvku3ZEakYf3FqNhiwuE/DFvSpr8WitaWmExslWb+0ne
         EH0ZE95jOhe06dOf8vZ3+Ww3C1X5CN5pACDdz7rFpmjn0B9+3WktBVCX2tBsvh8QrZ
         8hARVNYsCsefntE27OwI1+J7XmuNIDINjqAspXRo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 30 May 2023 20:24:12 +0200
Subject: [PATCH v2 2/7] dt-bindings: display/msm: dsi-controller-main: Add
 msm8226 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-msm8226-mdp-v2-2-e005b769ee28@z3ntu.xyz>
References: <20230308-msm8226-mdp-v2-0-e005b769ee28@z3ntu.xyz>
In-Reply-To: <20230308-msm8226-mdp-v2-0-e005b769ee28@z3ntu.xyz>
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
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkdj9TYBvnTqvgbEX/YXXAlij7BFGXyExCWMwTQ
 JTc617h9dmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHY/UwAKCRBy2EO4nU3X
 VoHIEACeZU7fs1lCpPlpSR9/aSFiJhg1w/X99j/GCw/jhQSkgElPxA1zd04pBGKBonJATBnZUHQ
 +s3yj4AhqafGZKvA/F6IoMvwX9CScMGWGYyC/E9soTtC8T4X5Y/E5Po0u7mFGk1z9XNI0AdrVvQ
 CYSUVPImCSxHdkDQBjgCiINtJ3FRBJnOUcTJ0cdFGJn2eZ7NFrwEQ++pRhF7c1w1/9Kg1H2D+Cf
 FyNyyQwr3VeBKhkF8GkO8lDxC5Pj09nJGDSRZSzXtWSNSehkbwIkmxH8CwBq6z92sA8/3wURWXh
 JLsSdapKEJ+9ujycXgDmh/Qy6hWycNPHCdFHxvcaK0ma8APXs0qJ7n7O/KofEnFDMxNTPvQeN8D
 DCBHzAECOt5Tk04LHcRNW9DCrHOULnvvBRrET9LHkLxijLbddMcNLI7vzPjKXiiw+KeIScV06Nl
 5OumZN7+1U11aIMSxg2BW5YRQHgVwsnAPm5IT5CFZbD8/yx0nxmRWLHwaaJrS5a5krq21EwVXF/
 sgJmCtKnRlQd/H6Dp/IXPigtEsh3qlzG9VTUByaEQqArp4KbzDhJuXa9cAPdGEzVB5/xp66i8K9
 J3LE+LeK2v85wIWbm04TEqq8YQsLH9OtxYpTq7r6oGldG5bJ+sRpWXndD6ve32hDpCCYCluJXFN
 z+vb8Gmee0yRq3g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

