Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3806512D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiLSTWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiLSTVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:21:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7F2167FB;
        Mon, 19 Dec 2022 11:20:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so9811922pjo.3;
        Mon, 19 Dec 2022 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skKyH0pCplF51paW1vc+b7xrSLxnYuoxKxvIMnik6dQ=;
        b=KNcvtCjac7s9MpKpUwUH3y3B/MIoefQP1vQM/RIQsRIV6qwnNwRujTdsiEoiHnLO9/
         NXY93MVJeHNqhWZLqHFW+zAreM14iThMtUayTVKSRP1Cx2F8gh88JOhUvOmoeI+DN1AO
         aAQxHHHjqT9aJC9G0UN4ubtUsZQUDqh7qfpW/9nRBX92fenN9Tnx0HityOcdK7eBOXqD
         jcOLzUd7iZxa6xnYRhq96dIJtUektstfd335NJ6Zw007wEu+LBRxv7YY5EO/SpmnteWo
         WqBp3g4U7Wem7HmeWwLz/80cekxtn9FDRpMjukRP27LznrfLlf1BswdRRXig22Lt2rDl
         soyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skKyH0pCplF51paW1vc+b7xrSLxnYuoxKxvIMnik6dQ=;
        b=n/n2oqbCscdIOp4qi5YFTYYz9ChajYa95Y3bny+4zMEwNSBse0S1ssQeDmkgQKaYd0
         RdL7mVNuiCCnnBtopicdRWzfNA0xPtwmO6xHeHMuTjIeZ7u4XuUYnIAw15/z6TjAzdS9
         x2VrCyiBG0+0N6FP5OnP1lHjzLHGPY9AWeFWfP51UxVNgNkExFzOBh+nRzenXYZarHeu
         lTxBUCY/tlY/yM5dnVcCX3lBuBLkFbgGeZ5Pd0yck111togyeOhx0CXR1zHcDjVx/hP3
         A5a7B8HN61RYyPH/BvSOfvmDfa9oI8ZNPom+4vahFNtd5XIFUfZRptIVm6ZjWJ41foaj
         NcoA==
X-Gm-Message-State: ANoB5plqc+EQc4RBFrjAnqqZbHEbOxi1jXvpdbTgEJ49PUtbCSKUqUZp
        hU/zqnuRDnSCI8ZbfDtpJUmz1pwuB3E=
X-Google-Smtp-Source: AA0mqf5Nfd1ZEOeAUhIAScWhBp46k0DNVoT/9fISCH6Uff1TuQgri7hPAQ4b4OXun5v/ML30HuriHQ==
X-Received: by 2002:a05:6a20:4d92:b0:ac:16ae:f46 with SMTP id gj18-20020a056a204d9200b000ac16ae0f46mr50366952pzb.15.1671477624048;
        Mon, 19 Dec 2022 11:20:24 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:4c62:79e:b4cd:2cbb])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b001869f2120absm7488342plm.294.2022.12.19.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:20:23 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/5] gpiolib: of: remove obsolete comment for of_gpio_get_count()
Date:   Mon, 19 Dec 2022 11:20:14 -0800
Message-Id: <20221219192016.1396950-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is only being called form the main gpiolib module, so
remove comment saying that it is also used by external callers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 6724e375678d..6114c5b3d2ce 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -76,12 +76,6 @@ static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 	return of_gpio_named_count(np, "gpios");
 }
 
-/*
- * This is used by external users of of_gpio_count() from <linux/of_gpio.h>
- *
- * FIXME: get rid of those external users by converting them to GPIO
- * descriptors and let them all use gpiod_count()
- */
 int of_gpio_get_count(struct device *dev, const char *con_id)
 {
 	int ret;
-- 
2.39.0.314.g84b9a713c41-goog

