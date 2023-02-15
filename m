Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CCB69770C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjBOHFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjBOHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:05:10 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20728205
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id jk14so777553plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hWzwrq3hV8TOIaiR9k+5O0t1qbVTCRxBbpH8HHjlnE=;
        b=TXxVBnOl2SIR4Z+zNTzp6FqHB53+Ro8Go7PuEp2MxkqRwcIxvh5bMwnmHSSKMpLilf
         1Y8OZQuBrGEsJ3NfgbwuUeS7Ll+HNzDmvtfRFsaW6b2USxa4Ay8mc054jZl0cg71lm8x
         8Smdib4ujb59JRqQJAlzeO2le2ZBpJXGSCb8WKJ0Uv+isQVhvHMsSqH6e+s7eliCN4Vv
         j+N6v3E9sfXGX34XhdgaAk2bJ0O389NX5JC+M+E9Tp5BhdDTb6VaqKyIB7dawYXzTUQ/
         cV9rPjHlfBzY0kiMMkbUWkoM5KXCzoxBmc/HEk7PFhuyJc6JnS1rJS1I28RYa2NTl41r
         59pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hWzwrq3hV8TOIaiR9k+5O0t1qbVTCRxBbpH8HHjlnE=;
        b=hJlw8N2s1fNa79T77oohu6Ceyp4E+t9wp59s8Rr06akniMJ9q5Z0WXp1R4K7KKpDD2
         dNujhHh8nhKAef8eZYW1IyGPWm4QYu4Dqy53FMXsZF2brpqAMgz5b2jjWibr0Y/PBDb5
         WLoFZKWPMcb4DW7XtXPLC95XWJih4GaNIzynCU6wCLI0dt+j+2Dok/W28mjT1hso58gt
         qGxoykvrVwZzNWYNqICdDEi9uabjK5CQa8fZ+LQpqdCFzqk0xqtzzW685ZH9ZRelidq0
         Pk6d0SGWi9DXc/i7WKW8AdazVlPfca+UvhwyHL3j691NtsQGv1nFUlu4AUeLtqhgtDBc
         KXHw==
X-Gm-Message-State: AO0yUKU4gkvpur4RPgvasoia2msS8C9wQsh4HOk7O+lVMYLKCRODNJyZ
        xeGTP1TWLuIlheJdQcfZojbu
X-Google-Smtp-Source: AK7set/dvRUR4GZQ9t+4QoWWw1umfYbQXveA2+ox4t3Z1D+kxLGtdPXh57GFTCY3HU70nL6cqfvoPw==
X-Received: by 2002:a05:6a20:a1a5:b0:bc:ccea:a969 with SMTP id r37-20020a056a20a1a500b000bccceaa969mr758477pzk.26.1676444683578;
        Tue, 14 Feb 2023 23:04:43 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e23-20020a63db17000000b004fb26a80875sm9953795pgg.22.2023.02.14.23.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:04:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 08/12] arm64: dts: qcom: sm8150: Supply clock from cpufreq node to CPUs
Date:   Wed, 15 Feb 2023 12:33:56 +0530
Message-Id: <20230215070400.5901-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fd20096cfc6e..693d023d2629 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -48,6 +48,7 @@ CPU0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -74,6 +75,7 @@ CPU1: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x100>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -97,6 +99,7 @@ CPU2: cpu@200 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x200>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -119,6 +122,7 @@ CPU3: cpu@300 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x300>;
+			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
@@ -141,6 +145,7 @@ CPU4: cpu@400 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x400>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -163,6 +168,7 @@ CPU5: cpu@500 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x500>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -185,6 +191,7 @@ CPU6: cpu@600 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x600>;
+			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
@@ -207,6 +214,7 @@ CPU7: cpu@700 {
 			device_type = "cpu";
 			compatible = "qcom,kryo485";
 			reg = <0x0 0x700>;
+			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <421>;
@@ -4273,6 +4281,7 @@ cpufreq_hw: cpufreq@18323000 {
 			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
 		};
 
 		lmh_cluster1: lmh@18350800 {
-- 
2.25.1

