Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE0631ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiKUHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKUHyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:54:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177AF6DFD5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:54:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt23so26529262ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAIMFWpyCS26qPo1fEgHYg5opLL+wXLHc8vpABFIMWY=;
        b=xSbsOIPs3i8vIUS2Q1UQIpUCLDafdjCCjHUxxCeaeGTc1bgzJzLTzm+Ad8p+opMgm2
         ZyiKAm8p3o6zcnUyV3iHcTaKgoylRJ6Weqh1WNRGgyn3E0vJ5I9hL9JsW9/eYZ/hGwIs
         qEnEpgZxMi21oYvso8W8mtqKYb6dmS2Vpa07PlRiFZ9OhrRcJaAp+1B//4/zOUuwEd+/
         N/LonyscqEvtiQssql+SBnjknoKJk/7PktYSpHkk1M96dsjLPXCun+2PUV7jZ4yy51rs
         c+tDPSPz/vQDW+RE2gXqKfk+0+LL7L2oYYeZyxDdjyZ5sNXqMFscuAd8Y8KIXLPEWrXk
         98dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAIMFWpyCS26qPo1fEgHYg5opLL+wXLHc8vpABFIMWY=;
        b=4D3j4wDSF4CGM2gHps+ASZWgieDF3jIwRk4YErUAHP1YWrotw2Gu1eZxem48NiRpp1
         eHCqzVZ7twpeI2eOHNB2SxgqmGZBRdRUPnlObCVV3r5VmGU4Rszz/he0SP9Py8PKfxd/
         44PbCHZPc5BEZv1yUTxfALoKR5NSsx5L3gx9c1QycYL1L10voV9zcD81YvI/8TbblW4j
         /EYo964gWRYT94SKb3vrCvfPLgdaMsgobwfdJyUVL0lkWWFF6T6rbCvK/FpDEl1qOC1Q
         xWZx0FJgFZlY/kT+gS9OFGPA1OHspDSuYD96mUHSfEB1mashaFYTp8LwNpjT11IwFrZ3
         BKkg==
X-Gm-Message-State: ANoB5pkZ9XO5k55bYHZ/rzpW+4tyNe6yIkYk4NUPfR8dTNECLzVaZW6w
        ZxsRMfYAEBt+gMRl0qsQtrOhtw==
X-Google-Smtp-Source: AA0mqf7EgU+nZDVYt62b91ntMx6QZu9f1BiIrY2dYKx7uQx7HbmIVBxCv6JLW0MVMrtBdr4/WZfHwg==
X-Received: by 2002:a17:906:8a4d:b0:7b5:73aa:9988 with SMTP id gx13-20020a1709068a4d00b007b573aa9988mr4432061ejc.597.1669017248619;
        Sun, 20 Nov 2022 23:54:08 -0800 (PST)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906860b00b007ad4a555499sm4700805ejx.204.2022.11.20.23.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:54:08 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm6350: Use specific qmpphy compatible
Date:   Mon, 21 Nov 2022 08:53:57 +0100
Message-Id: <20221121075358.76582-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121075358.76582-1-luca.weiss@fairphone.com>
References: <20221121075358.76582-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180 phy compatible works fine for some cases, but it turns out
sm6350 does need proper phy configuration in the driver, so use the
newly added sm6350 compatible.

This fixes qmpphy init when no USB cable is plugged in during bootloader
stage.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 7ccbb8f437fa..1cbc73e5f10e 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1342,7 +1342,7 @@ usb_1_hsphy: phy@88e3000 {
 		};
 
 		usb_1_qmpphy: phy@88e9000 {
-			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
+			compatible = "qcom,sm6350-qmp-usb3-dp-phy";
 			reg = <0 0x088e9000 0 0x200>,
 			      <0 0x088e8000 0 0x40>,
 			      <0 0x088ea000 0 0x200>;
-- 
2.38.1

