Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6F6C62B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjCWJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCWJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:05:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8F1C5AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id le6so21671033plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ruC/xMC7tL0m+Bw7Ok6wqKxtgof/3SmFbXbg58scA=;
        b=VovKeNVYIntxSqSwNWdqBNoEkgHtZj1u9gRBjoOhUTw4PVGblIMga680+V+hAKcuu1
         9K53BgtPNgXP/RlEwIzsDqktSDJ2DYi1xD8BQ9MhFUeTZojlldhjBlqncCA7Lu5k3BrR
         1P5jKkrFeVpSxlwCTyCF2J5GHSzvdOIUN/J9oABTuTuITbiWrc2FWzi7JYmJNBcs46U+
         h/QQ+0qOQ9snZEY+MwqAynbRxoUHUKiBHe65wgenOlSKRBmztMNouKK8Vp6lqrrLcKPR
         Y6FjIRHpvs4T+BX03DM/Ah8ybGbzDZqDH+c9d+SdFIwF2lcN4HHvAEP8wgCNds7exe1P
         eqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ruC/xMC7tL0m+Bw7Ok6wqKxtgof/3SmFbXbg58scA=;
        b=WDpEJIx4NuhO5f8MhKO+OQAX83V4RQyu1CTgQisp6F5E3GfzoSVudJi2Mt+cL+95nq
         7pC8aP2xWJelvIl54EkJinWQSurgqDIe3qBvPPS+bf4dIsssnrGX9zG04J8USAk8npIA
         t5nlNLRbE/d6f5y4CkU8LmUIudBRgtQyz/FJfJpS9NO3BOUObtzcIOihymXYGg3xH0vY
         9ZcFTldxWkrMfR4dVZLgII6adS3pIa2KVcDDdSrHjvXqO1MyR6IBKyQMTU7mYLdrpUVK
         0coAoI1eN323ssyod2grsBw1T521pypthprglhwOh18BJTvBjwfx4uuLSVlimBRsbSC/
         NefA==
X-Gm-Message-State: AO0yUKXaQMpYMcfSiXARtTJ6P2O0FMpTlDkvGy8P0gvCm39nUK+mH2yK
        LcRHZ1KnKUy7GnDLRQjtOjk=
X-Google-Smtp-Source: AK7set9t/l3/U0AE9cUZeRhxD7T95vWcwj6YWiY0Q1zLdKmBzXfwVrm3upUYzVgfarO+slDO2qVrvw==
X-Received: by 2002:a05:6a20:66aa:b0:d0:212d:ead0 with SMTP id o42-20020a056a2066aa00b000d0212dead0mr2342077pzh.26.1679562288804;
        Thu, 23 Mar 2023 02:04:48 -0700 (PDT)
Received: from ubuntu.localdomain ([117.207.139.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a656848000000b005034a57b963sm11277116pgt.58.2023.03.23.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:04:48 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH 3/3] Staging: greybus: Convert macro struct pwm_chip_to_gb_pwm_chip to an inline function
Date:   Thu, 23 Mar 2023 02:03:41 -0700
Message-Id: <fa02078208917ce81ad3fb6d453e8487a5ba7505.1679558269.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679558269.git.sumitraartsy@gmail.com>
References: <cover.1679558269.git.sumitraartsy@gmail.com>
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

Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/greybus/pwm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 3fda172239d2..88da1d796f13 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -21,9 +21,11 @@ struct gb_pwm_chip {
 	struct pwm_chip		chip;
 	struct pwm_chip		*pwm;
 };
-#define pwm_chip_to_gb_pwm_chip(chip) \
-	container_of(chip, struct gb_pwm_chip, chip)
 
+static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct gb_pwm_chip, chip);
+}
 
 static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 {
-- 
2.25.1

