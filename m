Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0168B930
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBFJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjBFJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:59:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E85B774
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:59:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a2so9520276wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaz5GNbnasZfy2Q6/rylECmgs8GsTdSUSl2LIwJLhJ0=;
        b=MLI0Ag1bzBf0dSos2kvp7aqLYAfZvtTDxbu9CvmmHJ5L1967+N1/ByQ04Lk7cFbs1U
         HGYTxBtkUuJJbitYSEml62yOdRumzh3RXGrmyUHOiFm9wp//jVmGaJxiyrblda1CZ5oc
         yrwut8sTQQZAa1Vnuvav+nvhuz+2vAAI4aRkxJr0mGxU6g72xMEml90o38D2sDMvJSZC
         AGtA0GSuM3KUVXjmKRpyTTm7IdIvavDpTFsTpXkHgIBWa88PSiM+A1cqdN+oxchJQVPU
         X3Ub+9ncQLJntsPhl4ghgHe9K3+qnIY4wK/g1NHC2HXww4hS2G6mPKHSEfjGSIr/KNc2
         JG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaz5GNbnasZfy2Q6/rylECmgs8GsTdSUSl2LIwJLhJ0=;
        b=kWehoIbDN3mhv4Jer1ybs18yLXog5+8gSX/liMS7+L5BSdVh4EBNW5XyxNAovBaCRe
         DYYIPxFvZ/2AcwhVaweMFmnwLS1YX1bYK/VMMiP4KmP5kQsqm74gbULdHRGzkxBWKEEW
         9oeNv0wQLTUAPisZjckBgRGRHzeiNhyx+4MjA6pSEAOT9lbzQHhleJv/pCXKdy6R9v9i
         KZiYsT1arirMZB12szUnMUK8G/PqJrvNGZh7VnHbjibZU+7Ma1VNVxjAA83tz/LP7l3M
         GUw6IBOxBVo6AIo4Ss/JcWgjEV1WRjp+8cG1V8JC8cgcsyXZwM/3ftj6zXaVNcDVObr1
         fgHQ==
X-Gm-Message-State: AO0yUKX8kzwWr/jKGi8ZxjiHawciK5FptAdAwBXm3XfWE6IepBn9PYW5
        OkB9LkBlDRBYnHVXSo+P67s6XsEG5pJWY66AI7g=
X-Google-Smtp-Source: AK7set8X3aT58X3nMw7mpf6ZoJc72P7PX9MBoaVjbih2rhd6t9j7hoZTRZao7tZbc/D3PCaBQLPrJQ==
X-Received: by 2002:a05:6000:8a:b0:2bf:f44b:7a1e with SMTP id m10-20020a056000008a00b002bff44b7a1emr15386186wrx.67.1675677540171;
        Mon, 06 Feb 2023 01:59:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b002bfb8f829eesm8839304wry.71.2023.02.06.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:58:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Feb 2023 10:58:56 +0100
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qmp-usb3-dp: document sm8350 &
 sm8450 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-1-ed849ae6b849@linaro.org>
References: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-0-ed849ae6b849@linaro.org>
In-Reply-To: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-0-ed849ae6b849@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the USB3/DP Combo PHY compatible found on the SM8350 & SM8450 SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 0764cd977e76..52ab7174df85 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -18,6 +18,8 @@ properties:
     enum:
       - qcom,sc8280xp-qmp-usb43dp-phy
       - qcom,sm6350-qmp-usb3-dp-phy
+      - qcom,sm8350-qmp-usb3-dp-phy
+      - qcom,sm8450-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1

-- 
2.34.1

