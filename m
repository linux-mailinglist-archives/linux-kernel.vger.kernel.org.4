Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8306BD204
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCPONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCPON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C2F6188D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y14so1844591ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIy97MlLq0rj6R7WBk66We2Y8cheU7mrKCO9U6h0C2I=;
        b=U9duvqHP4d118qYcAjR/gHLHSQQY+fOi656e4DiULyOL+dhHy0Nw/740k+nVBCQkfc
         4jztyTTm8UX0QlzCzlwVao8P4X9cPzg09u/7QUOx1QXafigZgNrNQS8hjvJR9KIo3uTC
         XpcFpQtWtZcHVeFZFw0HfJ7uA3WDoziySN0w5MUphMhG1f0CKFKVf8agzkKKsRfK8CNO
         NxD4KautTtP8thrtjrWu4o8Fjy0qfbUOV8aRbF5lZbA/nCvlJY92V9TftlOHv8iT8vPY
         NybxZD3HX86K40qDLffx7lzACiTmoHqYpohGgkkroGL/kpAsmuB+yrHULmwYz0bL17SD
         Co+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIy97MlLq0rj6R7WBk66We2Y8cheU7mrKCO9U6h0C2I=;
        b=7Xk9CjLYWBA+sqGhQsJD+BTAyCPFZMy0z/t2uefMfmxpgkJd1IKIy0H6Uufybszo1G
         aAG9dSF7SP7xMD8qHrr5AuZwxKUqxA7wFKXw3esKpufNHPvHoQMo1Vn/OayNRH/+VAt5
         8LKo4GIjwX/IfAx6dJmYMjCGSiYcPTKMLofwAAOgD1DkOrP7QgqafuCqHFjWKKFKSzjl
         tfjCp3wHKfmdQt7S6XK+i24qN5Q9rAz43PSaBRwdBP6T2s2Dp3HC3RYQgPXmOaT30Zi0
         Chnf8XlfgJDURLt/aqM+v3mOlH+OqyxYdPGr0oZhvnrCyWk1LmxvJqe+dsvHkbEykK3r
         34/A==
X-Gm-Message-State: AO0yUKW6Y80CtiP6he2I2mMLZ8MiHSifgJhFKHhEkv39U5WzqVVZrAlJ
        z9FxSoxmGVU4KbjOR55q9KF/kA==
X-Google-Smtp-Source: AK7set/kyXO3IAF0eXuduGJai87C2LzkIA+X031QqVpei8nt79rOvTjLfyU30jCpX+Dmwg4pUylUQg==
X-Received: by 2002:a2e:bea2:0:b0:295:b29f:5b15 with SMTP id a34-20020a2ebea2000000b00295b29f5b15mr2836992ljr.24.1678975993468;
        Thu, 16 Mar 2023 07:13:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:57 +0100
Subject: [PATCH v2 08/14] arm64: dts: qcom: sm6375: Add modem nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-8-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=2988;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=93tjFAm3KE3wlOIxpjBJdVGBzNUVK9fKZaM4nNn4KS8=;
 b=lzVlr47a4qQd80ZxoDeP9xhQJbC1xXeWFKVB0ClK0k5H0xYuxqLGE8yJj+Ytu1J3ZgCT4DjUbE1g
 ybS9jNAjDgYEIyN1/i9XxzDeecVRlMFWzwv0cRA1Q+wCb0mnj5VQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required nodes to make the embedded 5G modem boot up on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e473a90f3dea..90f18754a63b 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -565,6 +565,47 @@ smp2p_cdsp_in: slave-kernel {
 		};
 	};
 
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_MPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wlan_smp2p_in: wlan-wpss-to-ap {
+			qcom,entry-name = "wlan";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -1170,6 +1211,47 @@ usb_1_dwc3: usb@4e00000 {
 			};
 		};
 
+		remoteproc_mss: remoteproc@6000000 {
+			compatible = "qcom,sm6375-mpss-pas";
+			reg = <0 0x06000000 0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			power-domains = <&rpmpd SM6375_VDDCX>;
+			power-domain-names = "cx";
+
+			memory-region = <&pil_mpss_wlan_mem>;
+
+			qcom,smem-states = <&smp2p_modem_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_MPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+			};
+		};
+
 		remoteproc_adsp: remoteproc@a400000 {
 			compatible = "qcom,sm6375-adsp-pas";
 			reg = <0 0x0a400000 0 0x100>;

-- 
2.39.2

