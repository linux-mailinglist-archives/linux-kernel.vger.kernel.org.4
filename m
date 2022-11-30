Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E672163D488
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiK3L3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiK3L3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:29:20 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B515FCE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id fy37so40510365ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsddZjuiwpi1hxeQr5oczCe9bOg87MCuu+iWR7ARxxg=;
        b=rBQ+HyzyCSGvEl6xTCGbLmibKHPwSei+RSdPq21JQsAe3XJrMk+9ilplTyuSnqaZmQ
         wJu/XUcHb8xEOOLuz7vnmapHpSWCn90gFnpqLp7z0KYJLpjZlqIFhOENylCxtz23Aczs
         0FLj0pdTJM7UwEK6ZD9/635Q9g4a42u2BmVzNBwsKLK9vbt4/YGdkHZ8o9ND5/+frIIU
         wym+8Zsna8maYBR2GiHqHcba3nrejV9qNX7vc6LhTU6ee02IcexSCd+EFr/2W92ueeRY
         /HkwrDuaJx2b0GSgD3gcwI4MMGHuicsp3nmRfhrQbBgLyYldKXMigRS4rjcZGB154yg6
         W2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsddZjuiwpi1hxeQr5oczCe9bOg87MCuu+iWR7ARxxg=;
        b=b/Ui7AUVVhi57hXLDZgEajPkrnOVkHfASMYK2YW4J3FYQxu2xUEBXWgG7+nGEG+aut
         n8+V478mF7xvvvBqHL0tVks6XH/zNxAQxsfaaew2+w/Pq9y0d6J1i1+QQmhLqMe1ca82
         2vpUYwrxCSDOe/O6lcPLmwM9vQqmiOg5WY0QtfWVitLMzNRiAeLPQMhofzkhEnQ4Zk55
         bnjqWffJsanjkMQYoOmfPRnfdesCy0c+lVdEZKIjwXRQPhwPO9nFFWdVPpP9HEgmt0Dl
         52tazPKZS+B+hxF+WToj+SjlFVmHBHOLutigSyHB1txXJPYjVPToFa7GDAEM7v5fMemd
         OPeg==
X-Gm-Message-State: ANoB5pnyqMI2yw4FEZLrC0BtAaSJtxlvC56+8wG5F8ZzIx/9H/2SH/N3
        /1NwjIv3Qwk5b57oZY2bS2D4zQ==
X-Google-Smtp-Source: AA0mqf4ItKock4qVNORxWKgDIle6+W3fLS/PJW8LzTulaFBDxYi9za6Suolp65zlgpuz8AbD/hfb9A==
X-Received: by 2002:a17:906:3109:b0:7a0:b505:cae5 with SMTP id 9-20020a170906310900b007a0b505cae5mr52521283ejx.648.1669807759070;
        Wed, 30 Nov 2022 03:29:19 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm521593ejf.202.2022.11.30.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:29:18 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 3/9] clk: qcom: gdsc: Increase status poll timeout
Date:   Wed, 30 Nov 2022 13:28:46 +0200
Message-Id: <20221130112852.2977816-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130112852.2977816-1-abel.vesa@linaro.org>
References: <20221130112852.2977816-1-abel.vesa@linaro.org>
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

The SM8550 GCC GDSCs need a higher timeout value when polling for status,
so increase it to 1500us, while leaving the delay between disable-enable
sequence for votable gdscs to stay the same.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 0f21a8a767ac..9e4d6ce891aa 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -46,6 +46,7 @@
 #define RETAIN_MEM		BIT(14)
 #define RETAIN_PERIPH		BIT(13)
 
+#define STATUS_POLL_TIMEOUT_US	1500
 #define TIMEOUT_US		500
 
 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
@@ -107,7 +108,7 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 	do {
 		if (gdsc_check_status(sc, status))
 			return 0;
-	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
+	} while (ktime_us_delta(ktime_get(), start) < STATUS_POLL_TIMEOUT_US);
 
 	if (gdsc_check_status(sc, status))
 		return 0;
-- 
2.34.1

