Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7E6B5B05
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCKLSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCKLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46E23843
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cn21so541316edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1ivl38YE2I2SDvE1TdE0gIwBk6FF3/hABoULacrRYE=;
        b=wMYxFquxhp0t9lKQAOER1JX7CmKUNsOOctHhvaGDOuKSS46NJgvw9/nQzmwmqLlIWo
         KzP+wNeYjC5LgKCaIagU78wTTmhYCiXXtXgNTSix29J0trMc8t05ipD/aDur7lNZji5F
         /z2il8ImOTmCHbGl0eKxd1Qpb+Cxthsaz2tIn0EI65oS7o43nYH8NK3NcesV6hDoTvL1
         Me1nBTww+cvBNBSEsVyzakbj01KNMV2i1bVi7fyInug8LBrsAkqtsa2H8tcvf40mopiC
         IWrcfWY8QGrcEpt6hjBCEDPuHrTu2csOUlzU/30u5Nryl7nqy5HmZRXtDi5yfewoOrww
         RoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1ivl38YE2I2SDvE1TdE0gIwBk6FF3/hABoULacrRYE=;
        b=XFR9mYgOQurBdCDWHV88x0FTpPI9T+8cWyhs/MqUDly7c6reu2u4c1fhD2EZb5CDD+
         Dp8CXxRj6cQv+DUeXRIlwdLW0DKdwCL246EOmzPE/5sj/Zy8YeBHvICGwcJryVJ5EK5y
         apb8UEhluhjn0YsW3I2Du/DHQJGQ0gMCQNMi3IWiKm8QAq0gOtfkFqRBp7tCrLZV7cWV
         ZTIiv9zc2BcNvveWwuc8aku3WdzE9ZbXuKuaWUnI7yItAL+PYyY1CH5/ljBbx34jL43b
         tPtDyHKKGsllMOmYqFvr0/fpILDZznLg+bvoH8SgVb66xb2JCgUsUbDvJ7PZ8u9aEtJs
         bOzw==
X-Gm-Message-State: AO0yUKVpsLkTf7PP2npZ9cD63iQMBOXfLRzRML8WfgpRr9mfXJjmSbJT
        z98nZkt2FPWch4jufRww3yyhjmoXoReCFbmNbpo=
X-Google-Smtp-Source: AK7set+UBH/7lfNgSQ5TQ9eY5JIS3egl5tRPqIzcjIcnGzntH5Tf2EsKSNfoJvDIl5VjTTfL2z0d+A==
X-Received: by 2002:a05:6402:1352:b0:4fa:3b3:c86c with SMTP id y18-20020a056402135200b004fa03b3c86cmr2059703edw.12.1678533339401;
        Sat, 11 Mar 2023 03:15:39 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id w15-20020a50c44f000000b004bf28bfc9absm1064150edf.11.2023.03.11.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:15:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] power: supply: bq25890_charger: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:15:32 +0100
Message-Id: <20230311111532.251604-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
References: <20230311111532.251604-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/power/supply/bq25890_charger.c:1625:34: error: ‘bq25890_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index bfe08d7bfaf3..22cde35eb144 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1622,7 +1622,7 @@ static const struct i2c_device_id bq25890_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
 
-static const struct of_device_id bq25890_of_match[] = {
+static const struct of_device_id bq25890_of_match[] __maybe_unused = {
 	{ .compatible = "ti,bq25890", },
 	{ .compatible = "ti,bq25892", },
 	{ .compatible = "ti,bq25895", },
-- 
2.34.1

