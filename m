Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009DD6C8CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjCYIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCYIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:33:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17819A3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:33:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7104355pjc.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ruC/xMC7tL0m+Bw7Ok6wqKxtgof/3SmFbXbg58scA=;
        b=o639WNsLIKilsuSbOUQwSfrRBEy0Ll5v6ntkkD2bVaCkuUpwN37cLOeUhsSmI2yWPg
         2oHDK5veQ/gPP4Y6VOOAviErv5ZSsRk9Az81n0plcXMtoUtcAH727Zv2lzW5+8z6dWCd
         IZzlWtDLt/aIg213mx6VZnAHEGyB9FniS0Z5N6XYiQXNamw5/HjamXl1joGd3zIAstgk
         ieHPgx+zOgiTjL+QDQ+3ogDtcgbWlpb/+lYwHN1ln0Q+lT+wCObrY9aQVDSCGReZrFj1
         dim4Xafs5mOQwBH66ZX6FKC4rDEBow9Wwz9bu15AuYjsFHO0YGHb3J87NkpFi5PDOw9s
         7XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ruC/xMC7tL0m+Bw7Ok6wqKxtgof/3SmFbXbg58scA=;
        b=gdcuUcwuMsivjPMYz1i8pEiCPlZAC2Fxyl6znDEdl2Sq/SHPea2UEcXXcztpGbzX5f
         vmHs6xWGhK69DOU71elLPNNjUkzVfO7cYLQ+cpfrUGCITz7l3WFLSo3p+E7NYJjEWKmd
         pxPdCR57KFRKQiDD75Sd5ZtyySGq9INfrKybigkWDePAbLo5T04cj57oHC0DSDHfwC7h
         xEZktvmKsY31e+KryHUHg6ebGLL+S86bmJiBq0ePYZtmLWgObv6iT8wTHVUojOPa1XYa
         3n+mvyncOl2ZCgMCPTMgph6dZumo49xKMzeL65bRyav4TizHSWuVlV1PzuvJeWTRBEOh
         L0wQ==
X-Gm-Message-State: AAQBX9cSBPgv/ma266bKsc5PLmmi26hCLNMEDpdfAOhNhOlukKxckcqa
        0CDX2kY8hOAX9Vu+Ncgg3vT/kzx8ccPMbYRH
X-Google-Smtp-Source: AKy350ZlnfYWnaB6Q+DvHqgRzooKnDj0lpmUsKqxSDWIpYnsovqRM9QW9zeSWnZKKLZ4RDDGa9YD+A==
X-Received: by 2002:a17:90b:4c86:b0:237:c565:7bc6 with SMTP id my6-20020a17090b4c8600b00237c5657bc6mr5802024pjb.10.1679733196934;
        Sat, 25 Mar 2023 01:33:16 -0700 (PDT)
Received: from ubuntu.localdomain ([117.245.251.101])
        by smtp.gmail.com with ESMTPSA id m33-20020a635821000000b0050927cb606asm14290224pgb.13.2023.03.25.01.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:33:16 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v3 3/3] staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
Date:   Sat, 25 Mar 2023 01:31:10 -0700
Message-Id: <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679732179.git.sumitraartsy@gmail.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
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

