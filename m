Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215BB635F67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiKWNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiKWNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A88B97F3;
        Wed, 23 Nov 2022 05:05:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z17so12305501qki.11;
        Wed, 23 Nov 2022 05:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuQh98BScLRl+hXuzBmCggACRaMdE/rFjTb3x6luZmQ=;
        b=oJh2o/nVDuGM724o1HdMD2bxnZHPNOVzeR1cbXZY8oD+rzPrb2sVNnd5HlHUEKlYSY
         GSbjTHufYXZDQImUGaQzH3LGylae9P1VRIczJKxDRvXV4rBQM4NRk6mpQ0vU3Cix2pwD
         +dnbn1HYYqKgQo/VQtjvb5k7XScswhdG9ny0Rdc3ezL2/Tw7hIdUW2zzoTw+b74rzejC
         G98YnXD1iktshDyP/FS95s2UjNzMp85oG1cZuzIY5F3C1bj99fXzkje/WU8VkQcCcPcG
         xATXsuo6qSxayZTW9tb7Nt4fhx2++lQIxiBOGOnULP+AQwHe8lbzbYYAGw9orpmN13sV
         NEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuQh98BScLRl+hXuzBmCggACRaMdE/rFjTb3x6luZmQ=;
        b=lBLL11K1uFcrP7QpkJZTOa+rb9+P5nNsc+xAZwoCEKwXOEYLK23b/kNKI8/saIxJLa
         ew4itAkem+yLdXFzzBEUXftHbe6LiNtAvRyDJ1yyJgyTfmcdo7/K55peWSpL7I7Xn/2t
         5ShwGFNuuwZREdSTAV9KL8X9KVY8amfjUfh/FQhhp6bxQExc5ZxZDDqIqkbvjN+NPYyb
         icTy0qfkj3VZBoOF3ih8pIhO7ixwAn22y5Hd+i6DWkj0CvTQO0Uxi8gMzG+8gScyuKxc
         pory+Yw0ssm92gSgg3YIhAvJfWEfMn/jTZf5t5otSzic6lXGW31Cp4qL1XoRhrzZlt+P
         C39A==
X-Gm-Message-State: ANoB5plEsNgL5ZnMGvtKFXhwbGsdPmxZ8tqUNEw4i9eTtRrfGlOqfLhQ
        nCjhiCYjK/q2r1WacO6fTM/WO4hnTWXcJQ==
X-Google-Smtp-Source: AA0mqf7/sh4CNVjh5kFJr7hLPNC/7ZHlJuf29ATTgwBRW0deVApmo10Qpb6UZp6Wb3jKyP199T8+sA==
X-Received: by 2002:a05:620a:2f2:b0:6f9:9833:1e21 with SMTP id a18-20020a05620a02f200b006f998331e21mr24586422qko.715.1669208713354;
        Wed, 23 Nov 2022 05:05:13 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 05/14] serial: liteuart: minor style fix in liteuart_init()
Date:   Wed, 23 Nov 2022 08:04:51 -0500
Message-Id: <20221123130500.1030189-6-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index c6eb7eba5af8..1e3429bcc2ad 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -397,12 +397,10 @@ static int __init liteuart_init(void)
 		return res;
 
 	res = platform_driver_register(&liteuart_platform_driver);
-	if (res) {
+	if (res)
 		uart_unregister_driver(&liteuart_driver);
-		return res;
-	}
 
-	return 0;
+	return res;
 }
 
 static void __exit liteuart_exit(void)
-- 
2.38.1

