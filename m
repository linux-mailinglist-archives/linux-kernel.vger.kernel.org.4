Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B32677F48
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjAWPQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjAWPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4347F27D51
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q5so6469402wrv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=247W0z7EVjcoIvXF9MFKBtHP4NsoMxpTMHNu5CrTCnw=;
        b=dwIhNLKEVnN2vZGmvsVLZNwhLs6y7HGDlxWmUPVoqU52zA+l4xmxYzaO8GYCxKac3G
         vxNk/xkVX89PpNkC88Z5CXg99XGAKM/8X9YPf5U2Qafp4rwnOvN/xextptmcgxXdIQZF
         vvOgENdmRmZ4T0O/uNt2AFrDOxMKtzkSymUgv5QbjJkmi3gKiAzshTH260GR9H39fkrW
         1fcgAMu4g3W71/k2hKRW+wXlYFwwfprFhhAwJkdLhesfutnejGDvWQtvOEO9ILQ9fygG
         UZOQJu+XeIWkOMJsL5lTk+asfctMzwBAYHfZZ0sOEXjhuhX5ni1nbGD8GATOK59gsHtl
         9Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=247W0z7EVjcoIvXF9MFKBtHP4NsoMxpTMHNu5CrTCnw=;
        b=UmLSAxFN+xAD+T+BEPkk3aV2OzdJtPrTe9XjhS3J1c8mTCWV1phcrwW/WTMGMSgHXf
         3+9gr2xhJfMDsQR3spqYFQrWDO8yLjb0e4bbD4fRSJWGXWP8lSQiWNSaI1kS3NTogaE7
         vRZ6y9ZUmtffYcyMyNxVdx0N9VV+qNfj4OcE5uyFggg7AAMSn6AhH1h8aP8CZYnBEF+Q
         AWvutqXQkvtoTyyJdigt2a18pMIENgwTR9ne9WZiy8h3j2SNEvw+mnioSXRnDcaepQ4s
         uTLYYz77BNcYaRvxR1JOtIuFHvIgBnG8It4lKMXZs8RKlHkBG+N7guzoNjaXUi+3rLJ1
         Fgkg==
X-Gm-Message-State: AFqh2kr96qaaVi2v7TFmruQQbYtEY5zF/vFa96btfRZ5tk3qWDZAzBIx
        QAKQADjdyalh8vaICcH4iiWt7PNHDiUuH2mO
X-Google-Smtp-Source: AMrXdXtT4PHdnWlwwEO4Hcb/PYxUULSqgOTcyt+FOjsxEVAXfSPC2tsNl+RVCfLMVLco2lH0GTd69A==
X-Received: by 2002:a5d:6f03:0:b0:29a:c631:e761 with SMTP id ay3-20020a5d6f03000000b0029ac631e761mr24358886wrb.43.1674486928973;
        Mon, 23 Jan 2023 07:15:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4cc8000000b002bdeb0cf706sm23196690wrt.65.2023.01.23.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: cx92755: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:27 +0100
Message-Id: <20230123151527.369285-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/cx92755.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index d2e8f36f8c60..227675fbe820 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -107,7 +107,7 @@ uc_regs: syscon@f00003a0 {
 		reg = <0xf00003a0 0x10>;
 	};
 
-	uart0: uart@f0000740 {
+	uart0: serial@f0000740 {
 		compatible = "cnxt,cx92755-usart";
 		reg = <0xf0000740 0x20>;
 		clocks = <&main_clk>;
@@ -115,7 +115,7 @@ uart0: uart@f0000740 {
 		status = "disabled";
 	};
 
-	uart1: uart@f0000760 {
+	uart1: serial@f0000760 {
 		compatible = "cnxt,cx92755-usart";
 		reg = <0xf0000760 0x20>;
 		clocks = <&main_clk>;
@@ -123,7 +123,7 @@ uart1: uart@f0000760 {
 		status = "disabled";
 	};
 
-	uart2: uart@f0000780 {
+	uart2: serial@f0000780 {
 		compatible = "cnxt,cx92755-usart";
 		reg = <0xf0000780 0x20>;
 		clocks = <&main_clk>;
-- 
2.34.1

