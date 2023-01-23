Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0235A677F45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjAWPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAWPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76845298E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q5so6469507wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6M5yjSip5+lyc9JyC/BNtyk7E1XKULAsOhJf6nJSZaQ=;
        b=hciE2g9bHVxJkp55/0nd529QrN5mGQYxmf8CoEeinb94/YV10QcNF0vz5gMM9/vWSw
         1DxpONycpkRtlm8fDswXh46gf3qqAHar/tC5kcqPZBrvuwLdUgDQ7oAT7dVXUF7bVHID
         2ytj7OSJqWotyu5fMx3AVtd6S1EnOGiUmM5xlrCjHmalC4Nf3kQ8KdrDWykuFNAlI2EJ
         y1+T40Q8ac8rihQaXstdTqTtgo68PXFofQY8LbKGw2/1uTDWXBBn4VccZGRGL+pg8olF
         7vA+DrssKh9EkpWUaP9Y/ckdVyhdv9O+c3YwMIo/Lrf7ryQF1/fNUeQpvBp/JhVFa4qj
         g3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M5yjSip5+lyc9JyC/BNtyk7E1XKULAsOhJf6nJSZaQ=;
        b=TYuVDEv/yHo9luA0mgIin4ICydm2lcxnRVnsNi9G61CeXAKWTSRuGGGdF3y1xxrzO/
         u2UDyjngVV+7nOdVQ5Dr/lb8FLNQjone/0yU6gQA28+etg4AIagIeZojtU/3Gtaj+wo8
         uEQqkrO0nbcDPWLudc/SDaY7Hx3r+WtGl0Qn+9oXgNK03zeF+HEhUz8lUeHFyA66gKNl
         hJaWgUKD4EDdQ+s2UOfo1Ddyax78OxQZCVCp5tr+TOhlJlKwTUvACmuiHhbeQDQwrFtY
         2mCcMKBIzD95wTjUnV22CwQVyX1Jj6OFZGpAMwoeE8vcYIdQxaHsmZvr0uCexRNBDZbO
         GOvQ==
X-Gm-Message-State: AFqh2kqFu2qRO6J+GOCc4Ol6ykysGUTSQO7MS+TvaNRAgMzCx695hvg8
        POCQnc91jglhyRb91P5AdQYgYA==
X-Google-Smtp-Source: AMrXdXstFmsuhEYFjXSmISJfw7fea55GMjAKfuuayWphh+AyB2FJHv/xDY4A2sW49hh3MVwSnDHVYA==
X-Received: by 2002:adf:f605:0:b0:2bd:be31:cd77 with SMTP id t5-20020adff605000000b002bdbe31cd77mr20147674wrp.30.1674486931346;
        Mon, 23 Jan 2023 07:15:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm18137132wri.96.2023.01.23.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: axm55xx: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:29 +0100
Message-Id: <20230123151529.369313-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/axm55xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 7676a65059a4..5277890cfad2 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -108,7 +108,7 @@ amba {
 			#size-cells = <2>;
 			ranges;
 
-			serial0: uart@2010080000 {
+			serial0: serial@2010080000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x20 0x10080000 0 0x1000>;
 				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
@@ -117,7 +117,7 @@ serial0: uart@2010080000 {
 				status = "disabled";
 			};
 
-			serial1: uart@2010081000 {
+			serial1: serial@2010081000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x20 0x10081000 0 0x1000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -126,7 +126,7 @@ serial1: uart@2010081000 {
 				status = "disabled";
 			};
 
-			serial2: uart@2010082000 {
+			serial2: serial@2010082000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x20 0x10082000 0 0x1000>;
 				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
@@ -135,7 +135,7 @@ serial2: uart@2010082000 {
 				status = "disabled";
 			};
 
-			serial3: uart@2010083000 {
+			serial3: serial@2010083000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x20 0x10083000 0 0x1000>;
 				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

