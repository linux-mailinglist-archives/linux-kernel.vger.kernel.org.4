Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39CC600B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJQJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJQJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40EA19C32
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so12304990wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCCT8tgaqG5OldHtlkklSVmkDx8WUdXNiCaVQRja2yA=;
        b=UT+eHDzPRg/gPL3sOs/KSOLlRn7wvLL2EsK2hI/IuSZG9NH/DkLNsbwTJ3NhIuBgDL
         GkbnIQxAeFy0wvWjQ68cSaTNchn3zeg3kpZCym2GOOh7vuy4UUx7ysDPxS7/NMO8YLMr
         kpuvNiphi+BT4Oi01wh2oGpvqtPpWPUHBV3b8kJYzJXCcTTQwtoBVeLdjSbb+cHoDuTl
         GLj71VqjfXCCiUT+cpRQHVucTu4jfa2GPk3Mc1deN83+gMFTtluGwx/RIjEO4eahIuu3
         fDu11WRwPkcHNv2QqDTYZYC7sRY4CtwTwsIXqUXYlEnja84qoqKn5dP7gA1GIg5K23y0
         hMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCCT8tgaqG5OldHtlkklSVmkDx8WUdXNiCaVQRja2yA=;
        b=H8i4D2l+1iYLeWlULC7cAqqVpxBHfiRegbd5LbDu6pcOLT4ntjZ/FcmuizeV99FXlr
         XOWOcTbFMHmhebwXIwmth1nW2FqEL/eByy0RkfBROZmKZloeFdfoh8ISF5ai79p0eyCj
         2gI8Tm84vMnZb/50x7mSxnPfNrRSf/YWnIVC36u121cnmaulZxyvnbHfu12QdrcjRhdW
         aB0Ci4FcOm4D1nh/R0P4922OmPB99YvF4VxwgriG9U0/Ks47bFGLBWRzL2w0gKkrZ+vi
         oKRvhCR5+urlV6Hey242ep09YGITYDi2Cn8c3D1Pmi2bLr1A1DvTG5kftfhMzEtc5q05
         1x4g==
X-Gm-Message-State: ACrzQf075OAJ1FLj2FZCL+q8oZslg7V/4a2D2pYoH7/rfFqrQ0t5YsJF
        E1PuzLAHSkSa/ZJX9Gxe/w4BNA==
X-Google-Smtp-Source: AMsMyM5QS5AkbmdeCTDi98Gtsg2jqLCS1MPgbpF4AtAYHwvKG0qgRQ3LSMCcnICTheRII2p9ih3FKg==
X-Received: by 2002:a05:600c:3b99:b0:3c6:8b8e:a624 with SMTP id n25-20020a05600c3b9900b003c68b8ea624mr6749713wms.113.1665999935689;
        Mon, 17 Oct 2022 02:45:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:32 +0200
Subject: [PATCH v3 07/11] dt-bindings: rtc: qcom-pm8xxx: document qcom,pm8921-rtc as
 fallback of qcom,pm8018-rtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-7-531da552c354@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8018 RTC is used as compatible with PM8921 RTC on the MDM9615,
document this situation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml         | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 23ab5bb4f395..0a7aa29563c1 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -11,12 +11,16 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8058-rtc
-      - qcom,pm8921-rtc
-      - qcom,pm8941-rtc
-      - qcom,pm8018-rtc
-      - qcom,pmk8350-rtc
+    oneOf:
+      - enum:
+          - qcom,pm8058-rtc
+          - qcom,pm8921-rtc
+          - qcom,pm8941-rtc
+          - qcom,pmk8350-rtc
+      - items:
+          - enum:
+              - qcom,pm8018-rtc
+          - const: qcom,pm8921-rtc
 
   reg:
     minItems: 1

-- 
b4 0.10.1
