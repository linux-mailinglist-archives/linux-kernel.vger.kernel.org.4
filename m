Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC76BD21A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCPOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCPONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAA9DC084
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l22so1824185ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678976004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1o/g/RY/F8tw5gI99MfNC1MgutCzKG48oc2MA5z/Ao=;
        b=Qrr803nV2RNxyMhr4k1CujiqeMiu6xeEfZDomigDzlgOJ2+LAoow9y4SpnULqM533W
         JGYU4zjecXMNVzRMcYjhYBo9bJKzgh9fndduUqthz5eV7m0AegygBhQ+m1SwDg1hCTN/
         rnHE2vUTqT5qun7CkRIHPNhcCN2biGs4H9UjkIKTUfCCMvjN4tOS2/1osalKAkFcJB+S
         9GXXMgz+BHuHgPrKWIluWCd1qhoHJ6ZiQCleccrZYMrDoQe116QM7kTG4KQKrlbgq3Q3
         hlL4xAJbs94Mc1ULnoRauUdmiuxvn0lHeBTU3GqdlA7B+wCkZXGaFUvQPY+eoSYTGGD1
         b6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1o/g/RY/F8tw5gI99MfNC1MgutCzKG48oc2MA5z/Ao=;
        b=W08HXgi0+cA4FBxbz546SyPXWtuSWE9IOrEWvfMZ8DhvXGIu6vEnfb3tNCyDICOYlZ
         Vjtw/7vf8kAh7MwFmgjdw0dBS4oXd+OS76zCWUl7kyCPNvH30s1A1Ch74SvjDlzpD6D1
         XErQ+cNNRPt1BSkWm3xdNyk1qnBVx0CZzQZYbIS7Cl4eTWbBACfJe6QrKYvz9XcAV3dD
         4Dh4e8xc4Nrf19dRfNqdRACk2B8fLxANyBIYIeG4YRFTHST9qtBVgGGvZfVTVSTY3rtH
         Kq8Hx8XT7ViIop1yi+TTrt0ex7u+hdQHEgAHb9yfBi+77by3g+FTaqemFgbfD6G+ztTB
         AMHA==
X-Gm-Message-State: AO0yUKXYqTwdi00zHDeILEYd2EY+UlHpI6sifuC0uokCCdc7pWko7daM
        r/OUcQL8DkIgyCbOnGj6CkNxMQ==
X-Google-Smtp-Source: AK7set/UGvfpSQFBo90NawVNe6QbJ7gg6a+/gN9CBL5rHc7OuxYMSwd/oOp6n4BYEocyNvy2n8HwXA==
X-Received: by 2002:a2e:be12:0:b0:298:a841:4d0f with SMTP id z18-20020a2ebe12000000b00298a8414d0fmr3091124ljq.52.1678976003979;
        Thu, 16 Mar 2023 07:13:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:13:03 +0100
Subject: [PATCH v2 14/14] arm64: dts: qcom: sm6375-pdx225: Add volume down
 GPIO key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-14-708b8191f7eb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=1409;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lUoSxwe6wDxHMv1iTDzFHuYZxKLyt1OMfELUkCo9Rp0=;
 b=6DAUo0XuzRtK0oppQWVoexEKvP1e3HUzo7m6yHp02zNfdQCZy++x2swjD+iPpuCPGEqXhadgLXw1
 vUFy4zVZC4oEvOr9UIOEQQso+Cesl5GsmGvY9LDCbFthxOsz9AIm
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

Add the required nodes to enable the volume down key on the Sony
Xperia 10 IV.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b691c3834b6b..8220e6f44117 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -46,6 +46,23 @@ framebuffer: framebuffer@85200000 {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&vol_down_n>;
+		pinctrl-names = "default";
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pmr735a_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	reserved-memory {
 		cont_splash_mem: memory@85200000 {
 			reg = <0 0x85200000 0 0xc00000>;
@@ -133,6 +150,16 @@ &pmk8350_rtc {
 	status = "okay";
 };
 
+&pmr735a_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.39.2

