Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029B70D4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjEWHQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEWHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:16:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49718F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d20548adso4447514f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684826153; x=1687418153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZqtlkV+Cju8XAdwHQXr1lV9ldw4S+o5QEvBPqukNFc=;
        b=ExpUK7jvNy/kpHAI1pWXOIR3B7J/PB+4lv4Et9KU18l5GKtWC8swEiUSNZfig6v9E0
         xRq15ZRpv31OctcvBsZiEHcPyrK6Lb33qgiafUk+xPfLSjKMrSHUfVT1rmI94DG8YNxm
         oHEpP3uaWc2PH91xjpPR3awFWy7ufFMyPEwpuTZkLY62eC8+9Ivrz6lBOf7LXMGaKoxl
         TPcjrq7zaFmr5xOLqqsASHmkYtpirJxewlpgL+4PHPyc+LYOSDf6wUvdVwVDpjbgKHhM
         XrRmwDoqukLD1SgFPCQ9ROY7UPWAbWPn6GK/gUfwfAwqPoZSnd+HXr+SBAETpUvesDRd
         +BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826153; x=1687418153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZqtlkV+Cju8XAdwHQXr1lV9ldw4S+o5QEvBPqukNFc=;
        b=AKFjkkFydMZLXU+Wyfc8QucwydRsEKl2c+IO1n62j4HvdW+46+wf4jhU8a8Zp2QWeC
         ByMKTXgZPXG0hY+f5ThtTOQfpPpC1tDcSe7U0HYpInKycjbFBHApZ+pkd5wCZRnQDc6b
         vy4TwcZjpnBm2ylp4/3zqkmUgggb1+2+7Yl7h1Xtf3HBzxG2sbt3Ic9aULWE/VI428Xs
         CM81nPYHnG07zX9ZgIpB+AoKiW7QXu7N8vGvAggm8UnLv3pWpp6Bt1ZGc+fhh+KQHLzE
         EpBi200rtoOjB8DyfyBR9trm7kl24qHQiU8qqycKGjJ5n4ojO9eqPjMSLE80iw+r++RY
         oCWQ==
X-Gm-Message-State: AC+VfDzvLXpjVFljb2p7m35COyb4wUxWRyH5spgyvqlxST3yuFadC+rm
        QOJe/K1zzTpsTwXQu7w2sAHwSg==
X-Google-Smtp-Source: ACHHUZ69UPWwwcY+bOGTSjaUsEaYhmdrvcagNcOaa/svAq7tWdx4PpzCjqqddTgeCu0cAeVqTSV9qQ==
X-Received: by 2002:a5d:4ac5:0:b0:30a:782a:7f97 with SMTP id y5-20020a5d4ac5000000b0030a782a7f97mr6354677wrs.12.1684826152863;
        Tue, 23 May 2023 00:15:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00306299be5a2sm10096239wrq.72.2023.05.23.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:15:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 23 May 2023 09:15:45 +0200
Subject: [PATCH v3 1/6] arm64: dts: qcom: sm8350: add ports subnodes in
 usb1 qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v3-1-6c43d293995f@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jZm0vsXGjRa2kcJQp5G+00wat7FMpiWkkm/hrxk+Jho=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkbGgkvCqA08RLk7mgPvMVqAMhPZw9fRci6lSyUWUV
 69qATw2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGxoJAAKCRB33NvayMhJ0RnmD/
 9Z8OHvGpLKVsYmGfo4PxFhE9BNYB5p8ZxC/hR9tCdk8JLfzBMyxqlvYTWmKxDqJQEpZvuw/ypRBgTg
 TI0PO4/XBNPYLOeZP4RdALsoEj+qd0tN9DDRHjw2REjxXPCAt6iaZkNU0CWELgDPtSunU7oudcamN0
 gVa3FYZ3rpFdkVld63BEPFl5pzoWUUExF8m1orpweL/hLtwDChnr4qvBjcqy/ccsAaZo1qXZti9KFK
 ePFX+au6lRsSO7esTs8a3rVQcM8vP0I/2w2Bp71RhksWGuzunsX1ynRpE+qS3DIe6HS4cc0miB8X+K
 s5ldQw4OXNKeQa4gYpgZg+G6JvcBWLjgB9Cur9jUvxiag7/plSz9QT5Alazydg5zbmc1GK5uHVeVt7
 t8WQyo0N/fFMoOdrt65TxDrbrR6uPwGpvkpEioqjiqA5ktB7He50f20wqimSuWmhyj7TaW1W7gu7oz
 FCyNsjmVHnWD7Xj+EN7uz3fzVgT3Ph2n8w1rOYekXvuQ+cRQjcUEMx8g+1Kqt6qd+gtIe1xm6mnrGI
 4CSO28DGVGLh9g6Eztb2+kMbMSBYzDicw8cV+UuW0QppPcSypY6dw+eR432IVm2HTBDYUOdiDxCl3/
 VZNQhQK8bHzy0vUKVn9Fx+mFJ6brekCiDILmupEIAG/OYOpQRq85Dp9yyAYg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes in the SM8350 SoC DTSI
to avoid duplication in the devices DTs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 3efdc03ed0f1..d9aa591dccf8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2158,6 +2158,32 @@ usb_1_qmpphy: phy@88e9000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_2_qmpphy: phy-wrapper@88eb000 {

-- 
2.34.1

