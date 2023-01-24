Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C1679563
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjAXKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjAXKen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921673FF24
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so9722651wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tznsJFtlfJ79s/lJUdTAi2Xm2SaIWvhahisW5yxhsM=;
        b=zw1HzocInxkImdRCPnwIbeBO9bBEXqsAiJGcZt2+RhsuAiD6jusrdPj2ZDK/kKWuuJ
         nzEuWvbz/gnlkS3re3nlOYhle6ABLTaSpsk33dkRbyDs5tg9RkOYhs8HCn+nynyTnvTU
         7s+WGLIg5ggvOXua9p3kLha4PCv58TGgOFpIEdZr9qBLYmZ4hS90YyehA3r0pUprC2c+
         O1zU80yO53YUhVAV+quuT386YML2ti/syFz2sibQstfGH/I1lXYwP/tCuyuYw0vx1kGQ
         ayUsRNAwHpORvdrShw+gX5K2L2Q94urDLEWa0MKQO5jZVBCmJatLIoH5uV8sk7SuoxR3
         FmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tznsJFtlfJ79s/lJUdTAi2Xm2SaIWvhahisW5yxhsM=;
        b=ONdi/WnRQLgyFB89EaeKZo5beQQOXdvGdz8EUTMu1dn3AHUyK+UpMnmEMme9Orf2lw
         3HN1ojoWoPEmnpO77aGVuwrrMqAVR1jkTlDK81kQh8l9+JyOvP0HubheE62ALW2xH4QR
         zJTUAopoGTbBcfWQ8v7XV/nPz/dfZbd8HKOOA3ctiyTzb5viDEw8wEx2Y1SFwuX62ADw
         bmsVTlqH1URnlxuHEOM6/MQmXJ2RIlujruu9QwnrvVN59k0Qfhb4lNcRDSFTUG0w4AST
         JHkZZm1+pd722Ac9CaXaklYo9hx/EC/Hik+d61/RbhPvSKT/DdKNLmLawyeT/VvRUu71
         TO1A==
X-Gm-Message-State: AO0yUKVE81Mznaz5uOzDjVqTOFNEeSeFbvWoqyJvUaKoplllAX2Wir71
        AMrNTE4apl/juANogozcaBS1nBO1dx2o123GpTM=
X-Google-Smtp-Source: AK7set/EL4McQuD6+JHRhTNkBEKuYH8qZi7JbPE5x7dncc2cmWzP2OSE/DKwdwtwb2RVI6/+2fjxUQ==
X-Received: by 2002:adf:fa4b:0:b0:2bf:adb9:faa5 with SMTP id y11-20020adffa4b000000b002bfadb9faa5mr2390522wrr.30.1674556474994;
        Tue, 24 Jan 2023 02:34:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:34 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:33 +0100
Subject: [PATCH 12/14] arm64: dts: amlogic: meson-gxl-s905d-phicomm-n1: fix
 led node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-12-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
leds: status: {...} is not of type 'array'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
index 9ef210f17b4a..393d3cb33b9e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
@@ -18,7 +18,7 @@ cvbs-connector {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led {
 			label = "n1:white:status";
 			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
 			default-state = "on";

-- 
2.34.1

