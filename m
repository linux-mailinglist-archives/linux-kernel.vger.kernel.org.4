Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2526B5B17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCKLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCKLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:20:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7713B2A2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so30742668edy.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnXXbrZ1m/d5DpPQBCbe1TZx6euaIHskwO/PhFzeRw8=;
        b=itFcxN1RXJw+Vgo3FOat6P2tXXHSzteZYZdmj4Xq9x+ypr2kubPFeBORB1illSdPq1
         xQGjHRfDUH35+YGoBftfsr+Ax/1FB5jVZreMKyff0xTBuurE1CrmXvlz4nUs38cE1QEB
         3yjZePgNxpV+lnoicO6GSTKvPd5l6XLm/AwFMY93a7ctu1mjFwwjUU8me2Y1HCgSbT9q
         Y0BGhLkByvHa8I+9rABiyfqJVo+fVMh2VVMItTUIJnKY09EHC9CSvym3BRnKWqC5Dx9h
         zLOrsHhj4GLgIB1KoobqtQO7slistAKr0Y7MHXYOVfR0/sElpZpaBlKHrLQTnAQALPSD
         G6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnXXbrZ1m/d5DpPQBCbe1TZx6euaIHskwO/PhFzeRw8=;
        b=pBHQILxBLd/+WLFHhEeKYn0CW2m/wun3dJ3ZideAQtwNEUs3Aqk982qwvRzgJD9vZb
         34RCospGuJ8JnJIuZkMBh+bDb2E+ZLjdVzE4gZXpxqKV9PVi8nw8bVG5vRbYRTny87Nj
         PshwuD62FGoLiza5Z9jpQKF2v870uxmdki7+wDRK4r+Kh7OLKspgIW82/IccrggfZSgc
         HIOybhHpaGFEMebz96JYdc41plbDq5NlKCNIyp5U1xaqJY3x7UgSwhDcxGQawbz+2ohU
         GhnEy37GcnmJjLLi3PA/u3l71r53NW/1kam2AjfSMIkjOn60MzkBnVZx/QdiOMXmARnX
         Ld5Q==
X-Gm-Message-State: AO0yUKUGtxQEPG3VJRF/hfxJM1sAERuZBk3BU2S9r/gy8+ZzBX3dfVY6
        K1oABQxOH4UnYHkdidb7tFbWgA==
X-Google-Smtp-Source: AK7set8SMkJrLHOHbw1lDrz0YJwGpsOhByZ/nyN8OcI2csWF+13ra8n0Xdeit2JttJq5jhbB6lAfiA==
X-Received: by 2002:a17:907:a406:b0:909:385:da4a with SMTP id sg6-20020a170907a40600b009090385da4amr33312507ejc.54.1678533439217;
        Sat, 11 Mar 2023 03:17:19 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id y25-20020a170906519900b008eb5b085075sm987937ejk.122.2023.03.11.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:17:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] leds: tlc591xx: Mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:17:17 +0100
Message-Id: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/leds/leds-tlc591xx.c:138:34: error: ‘of_tlc591xx_leds_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-tlc591xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
index ec25e0c16bea..7e31db50036f 100644
--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -135,7 +135,7 @@ static const struct regmap_config tlc591xx_regmap = {
 	.max_register = 0x1e,
 };
 
-static const struct of_device_id of_tlc591xx_leds_match[] = {
+static const struct of_device_id of_tlc591xx_leds_match[] __maybe_unused = {
 	{ .compatible = "ti,tlc59116",
 	  .data = &tlc59116 },
 	{ .compatible = "ti,tlc59108",
-- 
2.34.1

