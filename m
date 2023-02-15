Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597C6976ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjBOHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBOHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:04:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11A023655
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h4so11547768pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRK1e1bBAwexX53o+cDSJezWbQwruRqnE48E6Hj9hPo=;
        b=Cg5nG3Xo0das2yUN0/60+sqBa0ErSnWMlsNBowJN8BwoCQ3hjkgtgb42l5KXUc9goK
         lvRlKtlV90UCVrqlkBW8qW1BXJe70ZxoOwuEwjWeTqxKfzDNKOcAKUHY8/C5QCByF8zO
         +yYQxCKkeG+xOB9ij1AkKaX7hWXoKLJh6CgZ9QfQaBRB8T28wtjXkVf+IeERTKj4nzWA
         ilzaB8VwcuJYtx0CSxZc6LNDMmk3QJzfjjdIJVNJF8J+cEswIUhFaqeIo9n1Q4omXsM2
         aq+I2cOhi3RLweyjbgXvKVNfTbM3QDC46QQeKZQ6AcPT0GsOTDJDpJjnwQx5H/ZQXCua
         mTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRK1e1bBAwexX53o+cDSJezWbQwruRqnE48E6Hj9hPo=;
        b=gccAisoi5PGi5djkZwsOHZ48Eib1OP2fQhdqreiZmetp6jc63B3S+86RyW5Tcl649G
         nuN1FAPHRYtxOdtMSsIvDTaz7XkZHNUIl6yCjozTz5sDjh++TDMvtkp6fsLLTIwjJT5u
         w+vB2fkEvBkZwXWrPKtuvziGJkWARfGTWAnqbJHmEYm9tXYfIqeYPE4CiddePSRwmfTz
         iXchvw//HM59yUpXqzdoZi9IjBHjNBCaS+3vH7k2STCUN4waioHXasO6XAb3yhkniwtq
         wxGSpEXdNMrem5Jprzo73TxgtEhOvtCAyxN3yvVpeMLEGPuxoa60hP+9FtaHfvEtC9aC
         KaPQ==
X-Gm-Message-State: AO0yUKVUdXrD1/4fh4atQhrchXUmh0lv7HGZEceU0xgFTlJJpfriJkrq
        R6E0jz4k5dtDDReeqKIRYo6p
X-Google-Smtp-Source: AK7set/x50k0KHVgpZVN4+8fkPZYk+LGN6PimKcquMZ4EPV4hxfFhXWVWL0tUHgANuaHcoTpIV7z5Q==
X-Received: by 2002:a05:6a20:12d6:b0:c3:3ea7:e2f6 with SMTP id v22-20020a056a2012d600b000c33ea7e2f6mr953942pzg.59.1676444656280;
        Tue, 14 Feb 2023 23:04:16 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 01/12] arm64: dts: qcom: sdm845: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:49 +0530
Message-Id: <20230215070400.5901-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
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

Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
to the CPU cores. But this relationship is not represented in DTS so far.

So let's make cpufreq node as the clock provider and CPU nodes as the
consumers. The clock index for each CPU node is based on the frequency
domain index.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..1d5e6ade8ae7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -92,6 +92,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -118,6 +119,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -140,6 +142,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -162,6 +165,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
@@ -184,6 +188,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -206,6 +211,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -228,6 +234,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -250,6 +257,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <442>;
@@ -5232,6 +5240,7 @@ cpufreq_hw: cpufreq@17d43000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		wifi: wifi@18800000 {
-- 
2.25.1

