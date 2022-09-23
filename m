Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE625E82AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiIWTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiIWTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362E12F758;
        Fri, 23 Sep 2022 12:47:48 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso8297003pjq.1;
        Fri, 23 Sep 2022 12:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DfoxSGkoCPcsjyBQ6vXBa3Fl9VYJoc1EvFitWLZdJDQ=;
        b=ku6/tJ7jNx+YkwGb4fOY2bohNBMoW7drOBFx3VzG6AaSY3ccX4jrCl5PvIHwip4CTx
         0jfZsGKE6bJWoA+KJdCX79s3JWyZP4j6Nd97kH1C6EWXdBv3XUlQjHB+SGeFHItU5gru
         +R57BUUkNcJVN94Uv1hz7Z5oDxdiptDDM+rvtBO+3/L8cI9KIiKRANMmeNovCfWclD04
         2CLFBhbhlHDBsFmhRx+mEdMaB9izsRAi1iw9B6DWq4Zw6s+7xs3GpAYDyhshOGpdWciB
         T4Ez7tsMALggYk44jI0KMixv9JvZL+k5XGaC/pcFNPpJo9zjW6YBgddEm2yWaFsqYX17
         U2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DfoxSGkoCPcsjyBQ6vXBa3Fl9VYJoc1EvFitWLZdJDQ=;
        b=aU3751jqLz1wlSWmDw0A5L5Z0CagzbfhDv603Sj+/tupkflI7UoMH8q8z7nwTYsbKd
         j7z0byNKvLVXNY7ebGSoMH9dctEKFPexkO92+TN23l1KkMbtR1LXyxEZH/QNY2dHL0tk
         a+jDR6hxjtppzaEg2OsxFo1GEDET46KZA64O051nu1GdFhB4b/cMFUn6+FEnOPcNR2HL
         3QKHdhWRg6BFI9jy95F6gTZbADRZcN2KdAn6+VLKVqNtJ+n7LXJQP0oSAIwMY0qdDQjJ
         rcvExkmO+ZQtrFgFWGxnQtlqIKSdM7mXDE05FmEdgDkOY9WlVeXeLuC9gK/d1nfME+nk
         BmVA==
X-Gm-Message-State: ACrzQf1quOCYvgRimTZJw0klNmX9PYD+Yc33iCPRf/pfoOjjkwjA6/fh
        yUinLvJAd8LAG93fMgGkFhDHX21NqTw=
X-Google-Smtp-Source: AMsMyM4RxL4b8HkBhuIcqD0cIW+h4JwEbe2LiBKEY0rD6fTVUoBbLcb2athbrAblJSk1BnIZy2LvXw==
X-Received: by 2002:a17:902:c7d1:b0:178:54cf:d69e with SMTP id r17-20020a170902c7d100b0017854cfd69emr10218186pla.86.1663962468369;
        Fri, 23 Sep 2022 12:47:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm6405187pln.187.2022.09.23.12.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:47:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: ep93xx_keypad - add missing linux/input.h include
Date:   Fri, 23 Sep 2022 12:47:38 -0700
Message-Id: <20220923194738.927408-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
References: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
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

We are going to clean up matrix_keymap.h from unnecessary includes,
so the driver needs to include API that it uses directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/ep93xx_keypad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 7a3b0664ab4f..f5bf7524722a 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/soc/cirrus/ep93xx.h>
-- 
2.37.3.998.g577e59143f-goog

