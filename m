Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F7626A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiKLQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiKLQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC79193C6;
        Sat, 12 Nov 2022 08:04:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w14so10154966wru.8;
        Sat, 12 Nov 2022 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijKNfiunV63AFU9RzYinLsQfMGW1tKqr0LKOgrxroKY=;
        b=HH+eoyr8wWz+PKf3eTxeIrPtgd+VdxvgSfFjHy3RdnzKHzXvFhUscCZ8oBFmTOtyOV
         +itCm1tI1JznZHo0CX+0nf+J8urzmatqkiF+mF9rKFLNYMjTbheGHW4U/E+CqtFePiWE
         tqfkb/yWDzao3xg0A+DgJ93jGHsSEiW8dc0Ha1YfwQpTQ+osNVt59Wj53xotk3VATra8
         6okQ4A1FUnSULA/EW9Inh5ff24nvOqJ8Xw4kbB/b5f1N8lIImEVt3bB9B1BjyZG5a6dA
         Z+QvMK8IB132LL6pQTOrVLfZBlGmz3MTsmfbWMn7n7ZvgnyasPC5WIgr8IyP7SMX3hbZ
         6UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijKNfiunV63AFU9RzYinLsQfMGW1tKqr0LKOgrxroKY=;
        b=uLSJ1GE9SchN11n/44k+1Baos+timqilacM9Spa25M5v3aVsmM4BJwm/s30H5aTWsP
         waUoqqsWaTahr4B56UjTxLXaSpsFyHgOH4wuQjEYpsh/YJJQR0pc2E0vhKr/KtKlpLYp
         +EfWxHwLiB7EzLudy8X6ASoz3JzBNoGsHfVL7v6vekPJBCMqvMuNW3MA6V3YF2dxsXVF
         yEm/enhSPQcC7NqP1Fa8Bp0G5e0otvOcI9ijHESUppneJ6El8sZFco7ddpegf+6poGwa
         f+g+j+p2WF7PRaD80Nla3jKUcJ/7VJS5+sUFlc7CnbpkVZ/2jdQPtNtKoc+RHI3PeJ4R
         588A==
X-Gm-Message-State: ANoB5pn+OtWjpuXbRZ8VoP+W9BwoD0nB4JMcqJVF/n1GyQLrChPAVtE/
        iL/ilpCcrqw4w9MsExYqqvw=
X-Google-Smtp-Source: AA0mqf5rGZgCxdHJ6sUSJMm0IUngegN+ozLvYpNtMPG23JIot08oGXa88eYC1GzUoEmMHusXvXgh2Q==
X-Received: by 2002:adf:fbc6:0:b0:22e:3392:fb46 with SMTP id d6-20020adffbc6000000b0022e3392fb46mr3627992wrs.706.1668269070882;
        Sat, 12 Nov 2022 08:04:30 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:30 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: rockchip: Enable HDMI sound on SOQuartz
Date:   Sat, 12 Nov 2022 17:04:00 +0100
Message-Id: <20221112160404.70868-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
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

This patch enables the i2s0 node on SOQuartz, which is responsible
for hdmi audio, and adds an hdmi-sound node to enable said audio.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 0bfb0cea7d6b..1b975822effa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -178,6 +178,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -446,6 +450,10 @@ &i2c4 {
 	status = "disabled";
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 /*
  * i2s1_8ch is exposed on CM1 / Module1A
  * pin 24 - i2s1_sdi1_m1
-- 
2.38.1

