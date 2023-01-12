Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5113D668493
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjALUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0FC1408D;
        Thu, 12 Jan 2023 12:26:47 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bx6so20600840ljb.3;
        Thu, 12 Jan 2023 12:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgeT+DkgAp8TG2Y1FM1obnRPpUWpBsbiJPWZXySEs1g=;
        b=bezJ6UITF4l5mYqMgQwtY8uNW/EOY8257ObGxT5Z9edIADULrufu6izwHgU92bL/g7
         bmIm9fFqPDbiwoDPJFSevvpVTpLU2Klsh6MOe0ULyVi7LcRSxMrpcl7uaIZ9JcfhZVDE
         Ko/hiqSbAtt1rdopyTZklw7CZRQoR1sJ4M/nxafiid2LCZJE9I+i3Adhe97a7iU8/gmn
         EVomElrtju9822Ffv86nIqIqxIGoH9ACf0VBEPRwUZawTFvcSiUiBxNXNGOfFLTvIQ05
         cjkVGv8g+6Wi/c9cyPB2w+CLbjcp7yml3bSR0gMWY5w4SqS0Rq1+EFclD9wf29gh5Mri
         ZNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgeT+DkgAp8TG2Y1FM1obnRPpUWpBsbiJPWZXySEs1g=;
        b=FEj9st6jLk2vGWPp7W35pudrt+FuTff4CTxRV4WGtSiITPkKMAEbjg/zaPA4N3s5pJ
         VEvsx1AuHgvz8Ifii4uEevyJxIsC7U2hTeekdUWzbGKW5QFq2YIJlLSLMvVtPXpgO6rm
         0nh6xOLC21Gnxp2rPPJbxe52O3zb8esF4iaGw55hYewMPVGirov1ix7uL9D5eQGRqN9u
         Fgdf3Cu+j4NznKzUT6hgl6aUxjB2oRC5yP2YJQNJuQ3feBDcMpRV1ZqJntb8IYf0dTgE
         C+KBdN4VYqexIdGNTdVq0Yq3kltP8FBOV1WZ9evQ3dGg/T9nWeJYHBEU3gKfEf57MpRk
         U6UA==
X-Gm-Message-State: AFqh2kq/o/6PvzjKnf7KNyKJEGnAY87AgjbIhq57VA9SJ+QOWbygXEUn
        biKN/v6Ka5wKelNOEfiqipPdLBIP80RGCQ==
X-Google-Smtp-Source: AMrXdXvGVPpxVMDcLZCTCl0jgFj1EVjFyaxzpK0RenKjKw4PucOPtDhIZjx80DBErxcaWwSnSw5qKg==
X-Received: by 2002:a2e:aa25:0:b0:27f:c535:9044 with SMTP id bf37-20020a2eaa25000000b0027fc5359044mr14723499ljb.16.1673555205918;
        Thu, 12 Jan 2023 12:26:45 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:45 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] ARM: dts: qcom: msm8226: Add modem remoteproc node
Date:   Thu, 12 Jan 2023 22:26:10 +0200
Message-Id: <20230112202612.791455-8-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Add a node for the modem remoteproc found on MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Co-developed-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 86 +++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 2639167c8976..34ea9cf46ae0 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -56,6 +56,16 @@ smem_region: smem@3000000 {
 			no-map;
 		};
 
+		mpss_region: mpss@8000000 {
+			reg = <0x08000000 0x5100000>;
+			no-map;
+		};
+
+		mba_region: mba@d100000 {
+			reg = <0x0d100000 0x100000>;
+			no-map;
+		};
+
 		adsp_region: adsp@dc00000 {
 			reg = <0x0dc00000 0x1900000>;
 			no-map;
@@ -140,6 +150,31 @@ adsp_smp2p_in: slave-kernel {
 		};
 	};
 
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smsm {
 		compatible = "qcom,smsm";
 		#address-cells = <1>;
@@ -620,6 +655,57 @@ rpm_msg_ram: sram@fc428000 {
 			reg = <0xfc428000 0x4000>;
 		};
 
+		modem: remoteproc@fc880000 {
+			compatible = "qcom,msm8226-mss-pil";
+			reg = <0xfc880000 0x100>,
+			      <0xfc820000 0x020>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "bus", "mem", "xo";
+
+			resets = <&gcc GCC_MSS_RESTART>;
+			reset-names = "mss_restart";
+
+			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domain-names = "cx";
+
+			qcom,ext-bhs-reg = <&tcsr_regs_1 0x194>;
+			qcom,halt-regs = <&tcsr_regs_1 0x180 0x200 0x280>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_region>;
+			};
+
+			mpss {
+				memory-region = <&mpss_region>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 12>;
+				qcom,smd-edge = <0>;
+
+				label = "modem";
+			};
+		};
+
 		tcsr_mutex: hwlock@fd484000 {
 			compatible = "qcom,msm8226-tcsr-mutex", "qcom,tcsr-mutex";
 			reg = <0xfd484000 0x1000>;
-- 
2.34.1

