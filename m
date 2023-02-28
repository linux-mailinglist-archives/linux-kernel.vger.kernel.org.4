Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0D6A5DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjB1QuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjB1QuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:50:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F285234F6C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:49:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ky4so11107517plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rPNL7OOm49xO0wH+mNw58JIW/pmslpKxDJsE0yTDiI=;
        b=yVYy3gqMzYa8QWcJUQJu0il8VlRwpPnXqY8B8yo+nG3koa7pl84gSPtl11GPgHPJh0
         BsG+G3BUQyENKP9EymRy4xJOKKL1tb1o+0YpFariumLXvUWG8ECrroTlnqxRm7kfXVCD
         ODfguzCvSu6JWuD3mbeX6ajDSqllFmWLYwob7ICD80gWz4Jl951nvaFlS01IFpDpIB88
         wmXNQA0mnylok6x00kSmk09iIg3yZrsWsQW81EVJq3VEvDEolT13kTtCLRzqVWc/kPAX
         nVDkBMHyK6RlGlHfk29V8rlbY/vWk+clppFMiqh5yT+AZB0JrbTualNqQQ2uZmOo3KYT
         RmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rPNL7OOm49xO0wH+mNw58JIW/pmslpKxDJsE0yTDiI=;
        b=Pbtuk2xNbthoHrw+RrLDRPUS4wl/tQoT3U/83NjNR/LBhI83PtqBA2drDWkTPh+2JE
         cGverVpizG7XT1Ry/8S9TCtM/RGbTqveOq+O8IYWgmN9GYrRqgpJqfLdFmb+dNuvPru6
         D8zg5ehH9zgCLcDa7GXnZIFOBMnYP2sEXCbEIxtWS6+QnWxpV0EhDy7hvpPG0ibB8Iar
         WT0comVLka7AcRdck5R4j12yKNJ7Jaad6f9UHqyywgVGkP/783RIBQniD2Vlxff+r4Xd
         akmSJXyYKHL2NhVbw86ruff70j/yNnx0Wj7C/cbDSPL0ZKh+T+qjFhUpH38JLgTXe+Bt
         d8XA==
X-Gm-Message-State: AO0yUKWlcRh+RH0Mcnu1rTMUwxCHxLPml+AbQq5VYctZkNc5t/JtYkr3
        DzQ9ARoxl+IC4L2GOg3vO/nb
X-Google-Smtp-Source: AK7set9gzknrsbZmUorBTBisjOuHHwHobtO6UGHqglFK6C2biqfkcx3wRl0jUwTzayqrO7WMzPjNCw==
X-Received: by 2002:a17:90b:3510:b0:234:157:a264 with SMTP id ls16-20020a17090b351000b002340157a264mr3808978pjb.43.1677602940166;
        Tue, 28 Feb 2023 08:49:00 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/16] ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:51 +0530
Message-Id: <20230228164752.55682-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
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

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI address
(0x40200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 187519403273 ("ARM: dts: ipq4019: Add a few peripheral nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 02e9ea78405d..1159268f06d7 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -426,8 +426,8 @@ pcie0: pci@40000000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
-				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
+			ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.25.1

