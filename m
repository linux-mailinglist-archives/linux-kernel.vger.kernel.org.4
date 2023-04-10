Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F146DCD74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDJWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDJWaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:30:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38198212C;
        Mon, 10 Apr 2023 15:30:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso160841wmo.0;
        Mon, 10 Apr 2023 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681165809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSuCwbIwfLs2/iUgH6G/BDQzxqJSHFvErHVugSGn4o8=;
        b=EScTxSckbRySVyQdilsthivV6BP3f9S0LmbHIasUgmL79U42sI4MeifgavFrDQ2wKE
         TFYIS+AfAlzkKBcpgPKaKHyzW5pLkdXyPlbsalsuMSoNcZTVgIHZxvgYr1SEf+y5VyUn
         bFWQKapEuTkeIGWL81oYOm7d9UlwAmS+PiwEYyMo0ZChXt/4SKTw75kZQMofACQT3RGm
         2xpHZqvqTRiE63Lr3fGGgecPmDSRKs0VChw5PQhOesYqFgQrAEfr3dFSi/pu090IrO4u
         ZrFDd+SGwwd4yADBOZcZpb7V9i7hasKnOpKaSBPYEuROmdbo/f2KsOhMDa4ap6xb3AM2
         sQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSuCwbIwfLs2/iUgH6G/BDQzxqJSHFvErHVugSGn4o8=;
        b=lGQVJ8pNikSrP4dcz0N58c0Pmu9ix5nK2Prv0FGK3475Q7p/O6UdoP71WjJglf7Tzj
         l+4NI6rDbbnwvstRlwQ1591Q4gyAxHLErZMYjvpeDRdSEgoiaiFcGPRSh3rZcQTojl7/
         33UqaZxHzyZ8VtX63A0q7sNPEiHteG2aMJ5c19Gh+lvxQkpR0zQorH900r8QLarOd8Yv
         uF4bGb7HSoX6b4H4n0fW543yD8fQX14aqb8QZWNpglwTd1SoEnRxr2HLjz7AQYen0+Zl
         KxUp1xupMO9WfulqeCmeRxzf8A3gzZLJv1ez38MQnsthL3VE/UivoMRXaR09SvqodFvQ
         G7DA==
X-Gm-Message-State: AAQBX9d2YDBNnICQ/HzvCI/Dekh9fchA/hIxsvsBKoOR0bBkIviEs5ek
        YeRW2SjKM6LRffSZwIrY53hOlnoGrAr6/Q==
X-Google-Smtp-Source: AKy350Z016EGi9CDP0UtwmTGdxGL4aSvQsfYbXdUKaajPcaWcPbE2WfptOfvqBTDvC3en6ccEazvjw==
X-Received: by 2002:a1c:4b18:0:b0:3ee:5147:3acc with SMTP id y24-20020a1c4b18000000b003ee51473accmr5647813wma.36.1681165809338;
        Mon, 10 Apr 2023 15:30:09 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id r7-20020a05600c458700b003f0548d00f1sm96445wmo.1.2023.04.10.15.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:30:09 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v2 2/2] ASoC: ep93xx: Add OF support
Date:   Tue, 11 Apr 2023 00:29:58 +0200
Message-Id: <20230410222958.2321398-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
References: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new cirrus,ep9301-ac97 and cirrus,ep9301-i2s compatibles.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v2:
 - Dropped AC97 (deleted from the tree)

 sound/soc/cirrus/ep93xx-i2s.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 0e396bff147b..bbbb1065b2f1 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
@@ -515,11 +516,18 @@ static int ep93xx_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_i2s_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-i2s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ep93xx_i2s_of_ids);
+
 static struct platform_driver ep93xx_i2s_driver = {
 	.probe	= ep93xx_i2s_probe,
 	.remove	= ep93xx_i2s_remove,
 	.driver	= {
 		.name	= "ep93xx-i2s",
+		.of_match_table = ep93xx_i2s_of_ids,
 	},
 };
 
-- 
2.40.0
