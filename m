Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964B36C37F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCURNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCURNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:13:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB4DBF2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so62536655edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679418761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDQGY34v5yd3veLbGYP2fWFdtFLMuweQoEdgE2PrVcA=;
        b=MyB12+FMNsCsdjFvnKTER5OH38gJqe1NqBNKEHHySj+8226h6cS1PIFOy4RKSUYGb7
         KM3U/lMUOlRDFlS7J/JdiUC25ZK/8yFBCHqn6wy8a+jXZSBJ8O3Nm07f2mhFXq7NhQkg
         QkFhW9yRKxa5wqVkfR1moLvrxMZax2KbUafyu4992fqDdUY7qAHee4jzjrT0n+aJ8gFx
         ajhJJVoeV7WIIZpxNNLnxvH1Pv9IFM9Nmdj5Dc96Pe/awCPoGnAVpYhLw97NX5tsS5Dm
         ZmWyJWAhJ6ZR3xWBHGXpdtjNEADcoJs4yFqj/hwdR0i47kAAZjorFVOqE+lPKcL/VZtu
         aYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDQGY34v5yd3veLbGYP2fWFdtFLMuweQoEdgE2PrVcA=;
        b=BGTgp0b3YuisV4aCublz6rVLBhcoI0RL13LYG6/xgXFeBM2QtoAJ812Q9RgakFaDsu
         LuE0tXwbbev6+HvDsFLpaw3xUSAOmV/Izrcannux4dqSNyZ8jq5DzLMm5ABCwVj2JdWx
         9RYRkaR/OREXGnkGramTdYAYhgSped/s8GCJUiXM6LY1p3KR6bbX7DKMAKMVAmG5xF6P
         4kkDMIMYOmvtssptqao0jUZXkpIoWAfBp79pPGuLlSi5L45PV/maJEeeO4WsTyVjBxQL
         AG9uzkurB7mXJZUeNRWrKc1246xaiCsbTu1CcUyIxlDMyW4YDn263pS9WQ+tkhEyE/XZ
         c5/A==
X-Gm-Message-State: AO0yUKXafARNlZCFIp3JGt9m+Syril2JAdHHV5fxEzb6B9KSM9RSzgbv
        ahKCB5ZsDKezQaBbGzBsHXkvkAveYGo=
X-Google-Smtp-Source: AK7set9hBgmphPshIttQT1y1BW3L9H1aYEHrvY3x1BVqrUmeqG75DeBoDxX0hJDyrCWo2TPZsdTX/A==
X-Received: by 2002:a17:906:68cb:b0:8b1:fc:b06d with SMTP id y11-20020a17090668cb00b008b100fcb06dmr3204927ejr.77.1679418760866;
        Tue, 21 Mar 2023 10:12:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bc57-1c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bc57:1c00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm6474959edf.63.2023.03.21.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:12:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/3] ARM: dts: meson8: add the xtal_32k_out pin
Date:   Tue, 21 Mar 2023 18:12:11 +0100
Message-Id: <20230321171213.2808460-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOX_10 can generate a 32768Hz signal when enabling the "xtal_32k_out"
group with the xtal function. This is typically used as LPO clock for
the SDIO wifi chips.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 21eb59041a7d..4d18bb4e3c33 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -568,6 +568,14 @@ mux {
 				bias-disable;
 			};
 		};
+
+		xtal_32k_out_pins: xtal-32k-out {
+			mux {
+				groups = "xtal_32k_out";
+				function = "xtal";
+				bias-disable;
+			};
+		};
 	};
 };
 
-- 
2.40.0

