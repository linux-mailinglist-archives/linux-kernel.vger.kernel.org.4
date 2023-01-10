Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C6664C94
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjAJTes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjAJTem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:34:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871B155857
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:34:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so12893359wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQFwvZLb3JKcBMwC1kA+HNwWIggAXnvVftqTF3gT/sk=;
        b=jWv6LNzEqD8dL3dqbiODzZSTw1Q9LP7SQf2YbtGfdTDv6M1pzPRUdBC2HyxURoOXk9
         Hpa7gaf9qNDHMU0lt6WBVBfEVN2YBIBHOmOWsrwgM/GAR+xklslRG9lEXb1a+zn8U2/l
         Jkw4eOiO1HsbpBnA8bLjvEjQZFqP6HLBJVlndlZjF2koCwERfOjLc/D6J75oatQWqN5u
         QtgJrXdhGR9YznH/LKZGJEaop/Bq649BM04n2fsP09Wqbv5B5p7QYbPG95C53NVu/o7I
         Yr1zu3fvoyJSNT5BKWgn48/GqLIhV1KVf0jB+eQ0I6gNYDfXcs7PbFK5qay+/qQxgYQW
         lMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQFwvZLb3JKcBMwC1kA+HNwWIggAXnvVftqTF3gT/sk=;
        b=18YsAvRy0LlEVG5cr9CR2EJkn9PQnSpgwnesMwzRsS6Mdn8QlmJ76hv5bX8utPlW2Q
         iMVpm3Bau0MeTBz/nLCsrWtn9OBe1K+642GAhIer/H8vV8xzzbafdiF9I5qVHlccaeee
         XkrOMW2+//5tne3Zgy4wqQxha6GJvg61+iSKPqS4w+bGxMcvA07J+WodvV+qKUI/L1nQ
         qHNiPyxP560re0U0DOFR9rd7MfVe9V7nqAeySoOL8ri++VX3p2IZaoMVAmIc5FfYXEtm
         jxWMUFjZc9sXBkitoevTCmeNHl1Fw8o4WJ3g2AtghFlkZp0hXr/PwU8ASPTVG9DfRY8/
         ChIg==
X-Gm-Message-State: AFqh2kqSVDNLh/+zFbYZ7EWX18VIaB5rj4s3O5ttzm5gWPem1nZuJOCe
        VQ7fa4Zq5x68/Ruk/a5Ek49KkyQAKsysvQLq
X-Google-Smtp-Source: AMrXdXudo2op9o2PQ0tPW7qQ/24be1foK2g8YUuiqO7i5c1+L/Fa+cXdA+sYCunBnPZJA3ocDVxhxg==
X-Received: by 2002:a5d:514c:0:b0:2bc:7ec3:8b2 with SMTP id u12-20020a5d514c000000b002bc7ec308b2mr4627175wrt.68.1673379280006;
        Tue, 10 Jan 2023 11:34:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b00236883f2f5csm12222271wrj.94.2023.01.10.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:34:39 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 10 Jan 2023 20:34:34 +0100
Subject: [PATCH 2/2] arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-topic-sm8550-upstream-display-defconfig-v1-2-9941c8083f10@linaro.org>
References: =?utf-8?q?=3C20230110-topic-sm8550-upstream-display-defconfig-v1?=
 =?utf-8?q?-0-9941c8083f10=40linaro=2Eorg=3E?=
In-Reply-To: =?utf-8?q?=3C20230110-topic-sm8550-upstream-display-defconfig-v?=
 =?utf-8?q?1-0-9941c8083f10=40linaro=2Eorg=3E?=
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the Visionox VTDR6130 DSI Panel driver as module

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 004c379eced7..a538a0ebb0f6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -765,6 +765,7 @@ CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
+CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.34.1
