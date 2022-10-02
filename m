Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685065F2319
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJBM32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJBM3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:29:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC627CD4;
        Sun,  2 Oct 2022 05:29:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu25so13109936lfb.3;
        Sun, 02 Oct 2022 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BVVW1SJyGTEvQW/vtwe80ftTe+h1+8q3HzEC6fOqCmg=;
        b=VQTrcbeDazS9cD7BOvYipG18U3ieRRCaJPS9UaIHWoz9/cqNspgjz5drQCAFIdw2fv
         31DK9Ci//Io9QBjJ5s5k6d4euceBLf83I5mJPOraPvzRq3Ft6QvbHZnWpepjsxgxZJ5t
         vl8X/9y2J9vS/JSEgF3/QnFzGd3wBne2PeVg1UhH3t4OGdTY+f9WlKv+VyRw3HaC2pgE
         i2oWQvaS8szCbQJNRRCzExYBMEoi8fRfsHYTw0NcG16jMHqEH8jr2R/gXtk6lnLV9IBN
         5bt1171ZsBMnDz/zkSdRI+9nPRo44oO/mEcObI12VJ9FvLaRg4r/rNnjlRNwypbidFE0
         zImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BVVW1SJyGTEvQW/vtwe80ftTe+h1+8q3HzEC6fOqCmg=;
        b=RyVPcgl5xIFdCZiq64e7E9g8MsJKTzv+XbQxW+MAjx4Q54EP5DH1T3K0bP94qQ5gRE
         79dO+rpg6DPxYblHkEJzbqd/SURw+PDbBMI2cw4PHd7GaLcaDJ1NTo4ju2x5tNkeMo7M
         AVtRDknFdP017YFRQMgvc0Wzv9SSP30UOYKBu7/h8tBOs6dSske56J4XzNbpjc3jVMma
         N3TmI5aM1BaGtteNGvPe3mAqaZYY1MqgE4ZGqW3oMM7fdWoEUFMTTlaGrlYxSrsOR3rd
         I9YdTgSS4+zvsHNbT1Iu0BuJ5/0X3/eTBBW0auifDRvAnOXqJD4lGDO65hxGWBP2Ncfl
         h7Dw==
X-Gm-Message-State: ACrzQf1LXvWJ581e7akrgnk2d8ZPIiu6CSJzqS7TcipogEcafRSHe2QI
        vB5TxVfWc8qwuTSrEsn2Dauu1jbrg6CVxA==
X-Google-Smtp-Source: AMsMyM6JPck1xU+9Ipe5/tUNE9WAQtj+88GY9xlkSOdOYN5YbQw1K+C4/2t4WIK7BoRiL8y5iJ9g7w==
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id g9-20020a05651222c900b00499cb5dc138mr5799488lfu.490.1664713763168;
        Sun, 02 Oct 2022 05:29:23 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id v18-20020a197412000000b0049493c14b17sm1064948lfe.181.2022.10.02.05.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 05:29:22 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] ARM: dts: qcom: msm8226: Add MMCC node
Date:   Sun,  2 Oct 2022 15:28:53 +0300
Message-Id: <20221002122859.75525-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
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

From: Rayyan Ansari <rayyan@ansari.sh>

Add a node for the Multimedia Clock Controller found on MSM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index cf2d56929428..e039128028bc 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -344,6 +344,14 @@ gcc: clock-controller@fc400000 {
 			#power-domain-cells = <1>;
 		};
 
+		mmcc: clock-controller@fd8c0000 {
+			compatible = "qcom,mmcc-msm8226";
+			reg = <0xfd8c0000 0x6000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		tlmm: pinctrl@fd510000 {
 			compatible = "qcom,msm8226-pinctrl";
 			reg = <0xfd510000 0x4000>;
-- 
2.34.1

