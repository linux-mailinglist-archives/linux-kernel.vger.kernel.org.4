Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16A70A7D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjETMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjETMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:19:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958A10D;
        Sat, 20 May 2023 05:19:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso749293e87.3;
        Sat, 20 May 2023 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684585187; x=1687177187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLWcNUEmD5KRuqZKbHywHfuAL7jMD5q/InsGM6uky1g=;
        b=KuUgk+3uq/s+fGH615FVDuePn2pvdC6U9gg2Ar4ap/HV9DERpvR5PT6e3EUTXkCZuc
         tTB3zYlefJranYbSY3qrYgFIQIYBqv5W6W21Iz+6aBGfka4/fmvyeBbT3ElrYT8z6NDN
         hkpuavg34iytIqRwTeIKEupyUyBRjCXvcS/Oqo6o6SSFZEikqY89q5vXCyg6GrZRc/mV
         xYCij35niKK6LMPUSi1Ij7vls+9JyLOdfK72Lzyopj97XsscBULyFSLAUysj+181S6Ge
         iqNxz64upDMJgwg13OrJIp9XeCJ5pFseYU2qOuapWiyjbXjTW3gpCLYjkU94/VjePVST
         tQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684585187; x=1687177187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLWcNUEmD5KRuqZKbHywHfuAL7jMD5q/InsGM6uky1g=;
        b=M/VianzjFrlYr8JctQTGsHAol8YKq1aqTThOao08YZJWrmZvKLm1rEBoECRnNptdpN
         XWjSgTKTS5bkklwNPJytdLP9XGdEAwRuL9wSwCkG5vo8h3tBQp0krzoepd+FZPYDHyP5
         KEC77N9o9sdLWniCbBD4RuSj2J78PAMH+RTxT0fcvfR8h/5qpLqxP9yC7ydSE1Jnxqdo
         t92xk90UuSKnl43L+kIMubCNwK78zygh63E3HAhQcxF3q1lbZ70mbARAMVnNkVOxcqEe
         7P1ByvxBMze8/hmj7YkaSZkX+iAL1pg40wKnvZAjsLulYiSIlgBx6R5R0JMvPyhMgWTm
         /Cnw==
X-Gm-Message-State: AC+VfDxSnDpClkai4jzgkz63QVvwxKX05tlO4Cz98k4W9/MDxcHUIy5j
        W2iG1ucNNjg0nkZYX4XJsYNs/eRdzHEiDQ==
X-Google-Smtp-Source: ACHHUZ4jJaXFZoeKpzHMDHyUmLZ3h+tZjQXJPRGPVTMfmH5Tvk9KK9JaxHYx9n4AcyvbcxLtZrsalA==
X-Received: by 2002:ac2:5509:0:b0:4f2:5e4b:3e3f with SMTP id j9-20020ac25509000000b004f25e4b3e3fmr1711450lfk.61.1684585186713;
        Sat, 20 May 2023 05:19:46 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a19ac4b000000b004edafe3f8dbsm260303lfc.11.2023.05.20.05.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 05:19:46 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: qcom: msm8226: Add PMU node
Date:   Sat, 20 May 2023 15:19:31 +0300
Message-Id: <20230520121933.15533-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable perf events on MSM8226 devices by adding the PMU node.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
Changes in v2:
  - Use constants instead of magic number
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index c373081bc21b..cb4b4a6d0447 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -46,6 +46,12 @@ scm {
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
+					 IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1

