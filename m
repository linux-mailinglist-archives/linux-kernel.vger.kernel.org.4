Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F617256E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbjFGIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFGIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AB5173B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so228566f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125113; x=1688717113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM0R8urzzNx7/U/EWs+VO9ol8E23jRS6ix/l2ppndlw=;
        b=iWeMW6Wi9Q+949S/SQPL21npohA06TPT8E2VTVspKj9rbAyOWZZ5no5jWhscUm64x2
         gqWkD2uyVGcX7Ff4aJqNNggPdaSqdMfd1/38MxT5BWdFNUppzcT0V/sLQC27X5OdLX/T
         u4E/q1AmgAObO+FYC2jM5jwCuExcQL/VCwLXf8TEeAvtom7JuTDHt0wm/xqcmF4egXRI
         /8MUoaIeRKMKLWV0Vuc8X1C/h2KK9Ksg4uMSoCN1TeWdPc0+vX6R1Ojz+3qM/uTLav1Y
         K8QSD6ygJaHrxiGQ/Z204cfmX7pwQho8M9+5NpwfgoUsKQWDMCplHq2zgstwS9JmBeGy
         5GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125113; x=1688717113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM0R8urzzNx7/U/EWs+VO9ol8E23jRS6ix/l2ppndlw=;
        b=RCMJc8GbgQQRkM2uWfQWOVdbKYm41vt2YRYl3XIyZpofXkTlZ48Usi/7DiCcTWL9bb
         hEnsnWURXlRSypUnwIBQvBZrLZtcsIrEgP3sQ8Ps6iU9zXbHLhYkuLlYRUYlfUXRiP+X
         RErUgz6N7tAso4ATLk0Sim/t9HODjpfcx+n5NwVI416avY4TBOGy3ZdK9N89AjEfvkLd
         dFJNPXnixi6QcOTbxK6ZYt3E7EP3qXNIuRiFVFQPlcKQmJpnNwTobnT0SzJTMsGD0AiX
         QvhWQaSTYl68dqfqgCbEhg+hbC5IWQB4D4q5PlDrPD4VzIipqpkdOTs4bDBeTZHKSQcR
         5P+g==
X-Gm-Message-State: AC+VfDwMJohWR5AL2nTJXTUXhqfabivkMxArdCFON9b5NuTLMp1Wy/uZ
        PkJ9lGHbLGx48+zj7BIl6gjpYA==
X-Google-Smtp-Source: ACHHUZ7CPwXdYITfhzf0Q8pbZLFS/Rz6/JNOHiK5RnEp/WNHa2JbqcVR6MGh2cITnjhqTvNsBpsJqw==
X-Received: by 2002:a5d:4943:0:b0:30a:e589:68a5 with SMTP id r3-20020a5d4943000000b0030ae58968a5mr3951361wrs.29.1686125112924;
        Wed, 07 Jun 2023 01:05:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:05 +0200
Subject: [PATCH v2 6/8] arm64: dts: qcom: sm8550: add ports subnodes in
 usb/dp qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-6-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BkC0Jwx2QyfHEOewEqYxvy0hZhtFX6P/om7OzNUurFk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDovIz3MyRZcSVOlZAM03jlffaCfwCFmDW+Zreid
 8l7qOWyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LwAKCRB33NvayMhJ0diREA
 CEqL1XZ2NSNj5yvbhcM04yJt1uFWVMeGSFTfy99qcllphGF2UCFLd+C93fdM8Fnj2Oyl9HQYLayJHU
 Gg7sJqb3UYzCuWQx0bzHm2gfRIXeOt8i6ya+WJmqOINq9Hjyt9a5I/poBXjqGTI5b/YD11g+W0DrTF
 8gvHWoSmv6jznD6D0jBdMkwqlCrww2MhbAzjwoG91f7GPAcePWv5TRW1cnKUjHBuwGE3DwkNwp/wr/
 583TdrUDKHU/EDk7dqyPkSoeDknOPFN3MasxomdzpBCqPr5De4pfumRNvT7ftMLsPzX/wbak3d3iAw
 wm6HBW7JUnNRqftOROQBSaeRcJl+aseeSvomsWuBZNEjdH/Wc55Ay6tOcN7yc4XK7QVxPd7N1hn4KM
 6nKVK3i8z2xlzriWbq/JY+X1yI3i+xau3WGSN1ngO6uNoelnhE9ziysUSdd88Oz/gZS/9CMYgrJ/Ng
 bhTcUQZsCEaDDaV9bAm3r1MxIMxb5v/z4Sj37LEypOkh8XopD/d1e0qJeKewUMEwqgUSpDwFG/E7s5
 n3slmLVZ5BHpNe8XXuisNPQgScBQa9Tr48TEuHK++hGHPsv2N2jZsSYoGXuinDboOgbu/GLIda30x8
 faXILuoq3Ok4gOcCSsslweGX/3ywog+9qfHPzWNzIwicXOWwwCA7SQyuCzFQ==
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

Add the USB3+DP Combo QMP PHY port subnodes in the SM8550 SoC DTSI
to avoid duplication in the devices DTs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index b41b3981b3ce..ca2280041f83 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2838,6 +2838,32 @@ usb_dp_qmpphy: phy@88e8000 {
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
+					usb_dp_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_dp_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_dp_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1: usb@a6f8800 {

-- 
2.34.1

