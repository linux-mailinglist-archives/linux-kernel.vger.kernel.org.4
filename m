Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0D68E282
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBGVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:00:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E353EC4E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:00:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso15470wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RUVaoheynYuPBZIl2P8uumz3FtGDoBwSbFJg7uXrdag=;
        b=zBTflR7+KqJgouh69ORKmJpVf519ralGzIclUlw+jTtpQBOoyQ/9eGPyaUAisKWy7v
         O+YodHBS7tazSc19se3qlW/lF7x5fllSJ6zsLJizyxLxsgKcA6ReBKL7H7G/Iv2lbXWK
         KVAn6Bw8euZJX53zGnjbWhkHhVZrobGdklEgZmoIi2zztMVwi9vvTIVxewnfzQQqBoC1
         FAXPjlGOB8rQoaD0K4mPXOdQzY4OBthLmN/QZge/AQ7/LoAfMl6npJ1lVsA28Rg0dNRn
         K1aCTsDZ03rKYh5D92ofPlfhzdoaRoTMxj+DX4L48pwum4xEIBSEo2q/oHE1QfXWX/8J
         BjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUVaoheynYuPBZIl2P8uumz3FtGDoBwSbFJg7uXrdag=;
        b=szfNBv0FBQYirEe7TaXi3U0EricSRWl6KXZwZuL+OJU3FCp8aUlF0BL/i9GwYka3FA
         +ZXTTw10gjyBVv2vENoqn7vVjwUS1B4KwjCIW+njUCB79FhVpl+Kt5ITA6RZaxOqnV6m
         CPr9Q1UjkZ2SfvJilorI1NPBcidaffLlsDrB882a5WupegpesQkV6yECcTdKbz5e+rxI
         iOGsyjJoSXbGvL88rQK6A/aixoSUZBiW8Lz9EV/EUaeZ+V8Iy7Tx6m9wPbSSu3mVPtup
         Yc5JdMmjg6CBwseI1kmlfo268Hm3MUJLSfVm/Ogbz4aV/DvQOveCculx6D/U3MrMxr8n
         +sOA==
X-Gm-Message-State: AO0yUKXTgEdFAerh89xxHsYi/G9ifljMbBmkbp6ppKXm3cylTBSWbVwG
        ymUW8cGZVabvh5oCxHbcKlFQhg==
X-Google-Smtp-Source: AK7set9jhJY/IWTXUEu5ibMOFtpXEGJQcwmxoVDLHyxllonp0xaHZrVElLOan6ooaFS5oyk44Dh07g==
X-Received: by 2002:a05:600c:18a6:b0:3d3:4f56:62e1 with SMTP id x38-20020a05600c18a600b003d34f5662e1mr4240915wmp.27.1675803624580;
        Tue, 07 Feb 2023 13:00:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm8041631wmo.19.2023.02.07.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:00:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Trats
Date:   Tue,  7 Feb 2023 22:00:14 +0100
Message-Id: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warning:

  arch/arm/boot/dts/exynos4210-trats.dt.yaml: camera: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resend old patch after fixing FIMC driver. Depends on:
---
 arch/arm/boot/dts/exynos4210-trats.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index b8e9dd23fc51..9a9a744a88da 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -144,8 +144,6 @@ pmic_ap_clk: pmic-ap-clk {
 };
 
 &camera {
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 	status = "okay";
 };
 
-- 
2.34.1

