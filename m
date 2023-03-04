Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA36AAAFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCDPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCDPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:55:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D41EFF1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:55:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f18so7363272lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677945348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUfSWCmSqctfdIKxSMclQIa/UdA2xHO3GVwbTIGP+Jw=;
        b=PL4hOCXwcQwhChwJLWuT40JgbydMXX1w1Ok3GV2HcRNUnf8zEduVQ/ZjNa2m8PJtTc
         ntvKxL1jXYvoPFEflMcaOIiVGGXo+Hy2uVPCFAmW0AMcGFv58IzOkAco1KipXGQg0mqv
         h5/bRKwQxiCdTPOb45qWWQm+iKloXx+qcLDPc9PYgbdRZUBWblZalBGwXxCLsI8V6pwB
         rlgh6ZsAeHIQGkmEnM9BR/mUateJU96S6iV1/PFQ2pbG6M99Is17JFnl6WC9a/PmNqc8
         6Wj2Xp6uCCpeU3xJajRTwbaOl3ZHTF03W2hBxVDxCtA15G4USoni4GXQa9GcUQc2crNG
         QG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677945348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUfSWCmSqctfdIKxSMclQIa/UdA2xHO3GVwbTIGP+Jw=;
        b=H/OULdz3yxO14aqr/2+9HuL8pqfFKSzkmrW7GQWzVDZv1Ko1XjjQcltmEM9D2Rhiis
         ndBmCY1b5O+2KJTijUJetiCBgLnQeHZoGQgq6RSl+wWWwcsRSoqjDKau9CHvt207soO8
         sh/L6eIREJ0S4CDOjZ3JF2NdWgZgZO64h5HCMw5sRqwiRqY4VvFp831qxKE6liOwa066
         Mbx1XPIFoRCOtmpN6jKH/ayYELN04phFFrg/O0rYWvea6ox0Q6/uMye98SAkVXB0NOR7
         XdRmnPMrUDdRgHgJ5eX8thDy0bQNYZcaQINbPFsGIp4xJlTswOyhhOqKMSgDlnAlX2y0
         rKoQ==
X-Gm-Message-State: AO0yUKUNA76nJIFyv1ibIYXYjkt0Vc974CnKCFGbI/8DavI1f5OaIc/r
        upXQRtmUQeeQMRlRhMIBBn63fQ==
X-Google-Smtp-Source: AK7set+voqdIxWURE/9hVlo/PHV3DGjojAixNk3U856OsXfzIgpki790/QTv3mY0chnqmCbFMMlI4Q==
X-Received: by 2002:ac2:44cb:0:b0:4b5:a207:8d70 with SMTP id d11-20020ac244cb000000b004b5a2078d70mr1400947lfm.5.1677945347847;
        Sat, 04 Mar 2023 07:55:47 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id n10-20020a19550a000000b004b40c2fccfdsm864128lfe.59.2023.03.04.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:55:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 16:55:35 +0100
Subject: [PATCH v3 2/2] dt-bindings: display: msm: sm6115-mdss: Fix DSI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-dsi_fixup-v3-2-b8565944d0e6@linaro.org>
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
In-Reply-To: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677945343; l=1143;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+hbEivqnmBNoExWXUNGA4lvz7CNdOA406GKFbpznxOI=;
 b=ydR3fv88VhonRdoeqjo/P/BmNkD3Hjtm9lvD2paCBN6qQhef8xWMXJHwtprfDhE1Ur8n9Atfsmr4
 +zHVz7G7CvQfmi+rtosB8Q9ZQLtAr9zDvdNU9gNF2m8p+ZO16iRF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the DSI autodetection is bound to work correctly on 6115 now,
switch to using the correct per-SoC + generic fallback compatible
combo.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index 2491cb100b33..605b1f654d78 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -40,7 +40,13 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,dsi-ctrl-6g-qcm2290
+        oneOf:
+          - items:
+              - const: qcom,sm6115-dsi-ctrl
+              - const: qcom,mdss-dsi-ctrl
+          - description: Old binding, please don't use
+            deprecated: true
+            const: qcom,dsi-ctrl-6g-qcm2290
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.39.2

