Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF355E82A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiIWTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiIWTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364F12E421;
        Fri, 23 Sep 2022 12:47:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d11so1077824pll.8;
        Fri, 23 Sep 2022 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Umtw5U+2C1YvRCtVCzaHAYVNPeE1SBV++NXDObHk7W4=;
        b=QDjFo+Bs5GB5tFbtgNnlluw+UEyIr8ul5dkQpIExW3Tx0+cPjncIhqP9oZCwl4qwjg
         RmFqeF3fsDllVE6tlouu2xNYFbW2lCSD5VO/hGzVSRsYdUktqyKCus6hvVuq5HPw1+MF
         /rmC569kXE96BXBtXC3TQSJc5aSxPJ3rkJWWZEH9k+PEWvkM749QGKur1mqpJSypImVA
         vwPP7kn669d++MToBQfJCnCa4xidqtQm158sYE1zfxGejhwMe9UVQnvyk0Woi8dIL08q
         wjogWOBvt/lYtlF1PIYuiKmbiMKXXwV/VClWVZrV+Fap/SEmtMcd4qMhefFkHNKn3Z4X
         PXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Umtw5U+2C1YvRCtVCzaHAYVNPeE1SBV++NXDObHk7W4=;
        b=1S1dy1RIal2jbndWCYSQXb718nKZFZuPLa+63sUQzgJ+/6hNZAtMxKVGJyy0lod8U7
         78Vb8vJaiFRYHwD2hE5LAAvCmtAHOT4NufC2WZl3IPcMFfnoF/BYvWpv3C7LtT1pqApu
         PX0NmeK+JrfQbFbDe0a0zsoI7pY5OY9ypsvtXcZAtnYt+9xljF1Iz5LwIIlsI8FYp63M
         cNA0ZqgQNCEHfOisgyrJnHNBo4leNIVWVz6RxkjrEkKTx3p87AIBkWwIUcHD+eoM6YQ6
         DRUFLsbCTa2wShPx4m1MSBhHU+tJ2bdJ8SMRnDE0dOSCJPPZHKkUhn79sJ/yhu8nWSZ0
         KxnQ==
X-Gm-Message-State: ACrzQf2fHB25ljikE2MleEyxkI3TfatB5XetlWepcYIhYjPEzKEM5LmW
        set0hMiLwN7h167HAouIZKc=
X-Google-Smtp-Source: AMsMyM6BnL/3/RhPpUBDt+cSJSkBqexnaPIk5Z9dyBi4JnKWc7R7yvTR78RJEqcuQZakgbaZ6UDjhg==
X-Received: by 2002:a17:903:4049:b0:178:3128:b57e with SMTP id n9-20020a170903404900b001783128b57emr10078308pla.75.1663962465719;
        Fri, 23 Sep 2022 12:47:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm6405187pln.187.2022.09.23.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:47:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: mt6779-keypad - add missing linux/input.h include
Date:   Fri, 23 Sep 2022 12:47:36 -0700
Message-Id: <20220923194738.927408-3-dmitry.torokhov@gmail.com>
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
 drivers/input/keyboard/mt6779-keypad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index a05e70af1fd0..19f69d167fbd 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -5,6 +5,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-- 
2.37.3.998.g577e59143f-goog

