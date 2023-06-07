Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19F72691C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjFGSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFGSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:44:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB7C1725;
        Wed,  7 Jun 2023 11:44:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-516a0546230so1166250a12.3;
        Wed, 07 Jun 2023 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686163492; x=1688755492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9ETnFKWquG8HyfAcx0wHtEZ8uLP0iUgTJAX7JIWHGA=;
        b=NfqxpGOQuz8zZ/Ox4ng+8dHzr/MnISrbbetMVtAUKwWoR425bIwYJPO/oXTFliIKyD
         PFOGWS+7gs+9DCLCJVGauYnoDlngCCr54mECDjq7ksn93RnWD5GtCRx9aqU4U037Br/5
         /ltW8bvlRNg57xFeWfCGxdnfKoqYWFXM1fXVgTP3xW9sqNuZi5bPQ+NkZy6MzDWxjeDv
         b/JCFajcHWH+ACZqXey73J/LrS195F8YFHhdZYNW0fh+YYRjJOgyvIxljYgPbftuO2ne
         NiVOwQq211Duw9nheE7Nvmo+/MDtdkjD7nYqjosqcGgExhyoQKjeuuf7AlPvJkzFXflb
         lIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163492; x=1688755492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9ETnFKWquG8HyfAcx0wHtEZ8uLP0iUgTJAX7JIWHGA=;
        b=jciZw1aC62oz6Un2xhp4p5eXPH9a1y4KMakINLYX7R0cU72pGS0ON8QVlM834dKbHo
         9gyI+7vm2cYH6PRkafRn6aIytZX658jRyZQ1NSRrprZ37B1e09kWcGCtq1WnIXw09Jt7
         KhvbgeLWXaKZCyxUqfftWmqxrIT4FLmSfruBX20Deb3Wah600hD2UEtmHDqV0obzBEYQ
         J8FtC4a8DpyoxF66UF76i+fcIi1IPbSKan7hn22QlRVGSFBc1jHzPYyjK6SLfyvhN1hr
         E0E7plmOGxKPo/tVrpABrbR3LX3c+JtvDGUGPEcNu7fl0915r7rnnLFBrkx5wtJm6QIV
         WoQQ==
X-Gm-Message-State: AC+VfDw3Kc8KPeddt1mQxEzvlsFXBSXWSSd3y7Dzak4Y4YxVbb9J1ehN
        QEydwS/BwC0UkZiWz6x8iyQ=
X-Google-Smtp-Source: ACHHUZ4OvlV9qMWuC3ZXvf89FEx8QvOzLH/lpRHt8OEpU4QoZXJ3k2amLQnFuzQlJgV8i/Bw8Xpikw==
X-Received: by 2002:a17:907:94c6:b0:966:5c04:2c61 with SMTP id dn6-20020a17090794c600b009665c042c61mr6910055ejc.8.1686163491486;
        Wed, 07 Jun 2023 11:44:51 -0700 (PDT)
Received: from fedora.. ([213.149.38.186])
        by smtp.googlemail.com with ESMTPSA id d12-20020a1709063ecc00b0096f03770be2sm7154447ejj.52.2023.06.07.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:44:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq8074: add critical thermal trips
Date:   Wed,  7 Jun 2023 20:44:48 +0200
Message-Id: <20230607184448.2512179-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings, thermal zones must have associated trips as well.
Since we currently dont have CPUFreq support and thus no passive cooling
lets start by defining critical trips to protect the devices against
severe overheating.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 996a9b9ff8bb..74551f51f097 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -1318,6 +1318,14 @@ nss-top-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 4>;
+
+			trips {
+				nss-top-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		nss0-thermal {
@@ -1325,6 +1333,14 @@ nss0-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 5>;
+
+			trips {
+				nss-0-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		nss1-thermal {
@@ -1332,6 +1348,14 @@ nss1-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 6>;
+
+			trips {
+				nss-1-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		wcss-phya0-thermal {
@@ -1339,6 +1363,14 @@ wcss-phya0-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 7>;
+
+			trips {
+				wcss-phya0-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		wcss-phya1-thermal {
@@ -1346,6 +1378,14 @@ wcss-phya1-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 8>;
+
+			trips {
+				wcss-phya1-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		cpu0_thermal: cpu0-thermal {
@@ -1353,6 +1393,14 @@ cpu0_thermal: cpu0-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 9>;
+
+			trips {
+				cpu0-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		cpu1_thermal: cpu1-thermal {
@@ -1360,6 +1408,14 @@ cpu1_thermal: cpu1-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 10>;
+
+			trips {
+				cpu1-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		cpu2_thermal: cpu2-thermal {
@@ -1367,6 +1423,14 @@ cpu2_thermal: cpu2-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 11>;
+
+			trips {
+				cpu2-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		cpu3_thermal: cpu3-thermal {
@@ -1374,6 +1438,14 @@ cpu3_thermal: cpu3-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 12>;
+
+			trips {
+				cpu3-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		cluster_thermal: cluster-thermal {
@@ -1381,6 +1453,14 @@ cluster_thermal: cluster-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 13>;
+
+			trips {
+				cluster-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		wcss-phyb0-thermal {
@@ -1388,6 +1468,14 @@ wcss-phyb0-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 14>;
+
+			trips {
+				wcss-phyb0-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		wcss-phyb1-thermal {
@@ -1395,6 +1483,14 @@ wcss-phyb1-thermal {
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 15>;
+
+			trips {
+				wcss-phyb1-crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 };
-- 
2.40.1

