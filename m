Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DD620019
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiKGVC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiKGVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:02:24 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A51659F;
        Mon,  7 Nov 2022 13:02:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so33530531ejc.4;
        Mon, 07 Nov 2022 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kQ9K8tYlbXLaQPRJ2lGK3SnOUicxnm8zJwkw6C7xPA=;
        b=T4l4qgQUH3GTNKB0fGSJMBZxv9l9NemWSa11NwVIsMKKcDAfAbxu3mJUmAxy1gUSda
         1mp5UEvokCOi0lBjTyYWcWZhl/u5LX06VpwEzGtZHtY7oyLnemUJKm5NRwdkAMAoL71k
         3tBjrAsydBFubbI5ExzbZWEAIO4RvUWdoMtxwT1HQk5/n91r98p5oclFJpNwv2pKvhse
         m4eK0r7wChA0v17elVgndJuhIWJI8jD1qrvqQul8iXl7qgnSF9itPqEhXvbLUtDSlplz
         LiqEFMYrsmwqKsi5z+jlBUFLNTCqnr8disjSaOORNRRU/vySgltEvzjm0kelSmgo2xOe
         SQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kQ9K8tYlbXLaQPRJ2lGK3SnOUicxnm8zJwkw6C7xPA=;
        b=x/ekKgrBvwwhLq6QBeBWRYX72FNO7uoOjeOQEaFOYuAz4RyX8VoAaCJt+z59j0IjqK
         9D2zW6Y93Qxe173rFteTCoyWgFde3m7P/XUrMrcM5XGpVza5GZI0gjKsNYHayZ39qOYJ
         BNAu4VCSacZoldCQborH/OxucKguegbz83kAwAkCmcxF+Ubj2Wn6zPQ8xRyJUKFovlkP
         mk3s+RVIsIVugJ50Mgh0RbiDVCapcr5yfT3/CE9dipC3Tq/mA8BNpnjqmpBKexjqwxkj
         /Zn2epzqyQUw7dj4WbUfo7DLbUbSpuNkGhfuYRIAgArNmMizXSi29tLG5Km5wAsoxagr
         6yOA==
X-Gm-Message-State: ACrzQf2tlYXh2BAQstLse9estioHwW2P4XsQPEe+k59eOQGfRE5lFuxm
        jJbPCrAhEI0+6jXkXGueFug=
X-Google-Smtp-Source: AMsMyM7LkvQGlGdAvT+O+T4AMciwWycd+BOpn2+3FhLN1jujd/qM/c4Ppj12xvqbMUxh9pW5/zkF1A==
X-Received: by 2002:a17:906:ae48:b0:7ae:1723:e8c3 with SMTP id lf8-20020a170906ae4800b007ae1723e8c3mr22584712ejb.603.1667854941832;
        Mon, 07 Nov 2022 13:02:21 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b0044ef2ac2650sm4638472edx.90.2022.11.07.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:02:21 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h6: Add deinterlace node
Date:   Mon,  7 Nov 2022 22:02:08 +0100
Message-Id: <20221107210208.284261-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107210208.284261-1-jernej.skrabec@gmail.com>
References: <20221107210208.284261-1-jernej.skrabec@gmail.com>
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

H6 has deinterlace core. Add a node for it.

Reviewed-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0aa6dfafc197..badc6afd6941 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -154,6 +154,18 @@ mixer0_out_tcon_top_mixer0: endpoint {
 			};
 		};
 
+		deinterlace@1420000 {
+			compatible = "allwinner,sun50i-h6-deinterlace";
+			reg = <0x01420000 0x2000>;
+			clocks = <&ccu CLK_BUS_DEINTERLACE>,
+				 <&ccu CLK_DEINTERLACE>,
+				 <&ccu CLK_MBUS_DEINTERLACE>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_DEINTERLACE>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&iommu 2>;
+		};
+
 		video-codec-g2@1c00000 {
 			compatible = "allwinner,sun50i-h6-vpu-g2";
 			reg = <0x01c00000 0x1000>;
-- 
2.38.1

