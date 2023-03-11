Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4B6B5F49
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCKRmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCKRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:42:42 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75CDD1AE7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:42:20 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id er25so4909655edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcwlP/C06RxeVDsbVu82hAXbDbgdlPaZxHqgbrTaPqw=;
        b=Su/aYm+ZTxhdwla05jEevJ0f632jx/+dGtBRD+0Pb43ZuIKPJgecesaOqP19HlE0n/
         CbD0VYIm2qkEIWdET2R0C/xF3qwUigy4t+LM3J9Jcm3Mamykk8l0bFVkt043+mfvwm/8
         PbGjjwzlL6ZxlRLjMh0WPeYcdqWUykD+A6aj8fknMYz/IDGqQpeln8x7O/oPgMAx4F1T
         +ZJdJM1o5Ae8Ub6LGp6v+Q1L7gvYk8bLwj9YOfqeVD67jFGhzj9l4f/ESzIn8vfbvYBM
         e5C/vfyD6YZi5a1rIgjKtrkrhpVZJeUA2CmRyH1v8bEv60nj3Rc14DBVcxGxnQ//tDXV
         jKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcwlP/C06RxeVDsbVu82hAXbDbgdlPaZxHqgbrTaPqw=;
        b=Q2vSEnvoZOUvjw4GVYOOX6VoLgV12rRssAiviAa4d3WUOMvkqUc01rMv8aJ2iqtIVs
         aCC1RLcOIPbphPrNnpykPibyIxD+E/xv968Vf1LFyEYJY28BIn5JO7dCscGjnEf6NKis
         tJ40Yyj76nK0mse8V9mim82uUgMagzEnUoYWi5JILfIvSAxBvpo1ARNC9+GK3DdgF2AO
         rPalks8vv8iGaEFY//8r5OH66WC2GCjHOL41ckChUNjKF1Dlatf52YTxbwU8/nuIfUFb
         iXCL36uwM/VGMSOf3pqsZmzc4810zNjvkHHalqlCe2qCJ1WgtlmZaaNj8cFX9YoFrmVn
         rU1g==
X-Gm-Message-State: AO0yUKUgAOs0NsF2brO7uwfWSyxM2ovjYpM2GvvN0EtaKUgNnEuFLBE0
        DUXSBWewRP4Rjce1PE3m843b0Q==
X-Google-Smtp-Source: AK7set8m+DcbGrpKkaEu8cJcaWS/KDSEJAux+7j8RvWSGAfhO28fTqKPTee8W0ZBoQU26tCiqYNizA==
X-Received: by 2002:a05:6402:31e8:b0:4fb:31f1:425 with SMTP id dy8-20020a05640231e800b004fb31f10425mr654075edb.33.1678556160364;
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b009240a577b38sm245423ejg.14.2023.03.11.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] backlight: lp855x: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 18:35:55 +0100
Message-Id: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/video/backlight/lp855x_bl.c:551:34: error: ‘lp855x_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/lp855x_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 81012bf29baf..a57c9ef3b1cc 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -548,7 +548,7 @@ static void lp855x_remove(struct i2c_client *cl)
 	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
 }
 
-static const struct of_device_id lp855x_dt_ids[] = {
+static const struct of_device_id lp855x_dt_ids[] __maybe_unused = {
 	{ .compatible = "ti,lp8550", },
 	{ .compatible = "ti,lp8551", },
 	{ .compatible = "ti,lp8552", },
-- 
2.34.1

