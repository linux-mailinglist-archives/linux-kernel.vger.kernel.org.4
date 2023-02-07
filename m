Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2468D392
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjBGKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBGKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E1EC5B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d14so12972006wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMohM0qPljFMAwLEW7BFFLytcnDkig++xTWLolqratA=;
        b=pr5kqicwswyyoq+U+mfWV8zReIWb2wtvilF4WgyFavHapQFfwobqCKibx534VKCZYm
         qfrqbwM8MB0KZ1oSOCCiftFOC9zbXsv8PrkIzDlF7+BbROuwM7cA6Kxpr8krQI6UVwAm
         UNGwEJCWCN7ZslMC3gVz3DssgkODn/r28HfwcwuvirGKvyS0Fv0hqlfk1TLY0O2WpTh/
         De9ARI62uq5448Vk5UUaPTuz8bjMykRXuPp+rxX0Uj43dj3vvkdRZyOj4eM+Y1ULEhsh
         nCstHmZkX4g5mhu+2YvK3LkhgW875oxT+gmoBWR4fjBv1H5L0fhgQXaX3RSr6mWRRBbh
         KueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMohM0qPljFMAwLEW7BFFLytcnDkig++xTWLolqratA=;
        b=NiZoUfsimoGBspZ+/hgDUGyhbrfEwOS4jP83g9hrr3FdLSO/0vbbv/lhzhX/N0897s
         wQBKR0MRBE0RO3Gg392UwwC7iGo0GltQU8td2no7I27UrzsInBoGo/XM8JSwscjTEujE
         VENewa62sA4UH3lnWG3kl75bOWceC38uNRhDo0ZUbIOKI++OvXJA1ulV1762rW+etuc4
         S/u6Sr6XtpXoWAm6GaJomCxGU5U4EUK1QYujc4O4ZgA8PF5CSs3/2YqcB4j7u2s9nOik
         scl1ehkvzKWJiP33G3CXIsTr9jCW//dovNC7TS2XC8GB+fNnSleQBHZjIE81xay9Q1r1
         wizg==
X-Gm-Message-State: AO0yUKX0YcLYLakUNGwgg0tTQuzvfCvPACaBkOmm6i8BKqIl6rMA0p3d
        A/Rodaq9h6f4un7IFMGm7cFPOQ==
X-Google-Smtp-Source: AK7set/pdF60gEJ8eLCPcR5NCvqXjVEG+5i7wLgdYV8jA1MgSqqYWZ+JWyref5GHKF0trD+zFn+9Ug==
X-Received: by 2002:a5d:524b:0:b0:2c3:ea65:cc7d with SMTP id k11-20020a5d524b000000b002c3ea65cc7dmr2362744wrc.55.1675764419804;
        Tue, 07 Feb 2023 02:06:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600002ab00b002bfb5ebf8cfsm11428205wry.21.2023.02.07.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:06:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 11:06:57 +0100
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: fix DSI controller
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-1-698d132ab285@linaro.org>
References: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
In-Reply-To: <20230207-topic-sm8550-upstream-sm8550-dt-fix-v1-0-698d132ab285@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Add missing sm8550 soc specific compatible before fallback to
match the updated bindings.

Fixes: d7da51db5b81 ("arm64: dts: qcom: sm8550: add display hardware devices")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6ff135191ee0..43a8e46c6ab7 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2175,7 +2175,7 @@ opp-514000000 {
 			};
 
 			mdss_dsi0: dsi@ae94000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sm8550-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae94000 0 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -2269,7 +2269,7 @@ mdss_dsi0_phy: phy@ae95000 {
 			};
 
 			mdss_dsi1: dsi@ae96000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,sm8550-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0 0x0ae96000 0 0x400>;
 				reg-names = "dsi_ctrl";
 

-- 
2.34.1

