Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF85BEAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiITQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiITQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:00:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE695A803
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:00:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e68so3186465pfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/XA5rkoouGgX9DCK7SjCAV6orQoM99AmvM4Gl/XVcZc=;
        b=UbdCnls33atG4xWvWkmByU/a6tf+VDySm1kndblgUXjNNzsdPPmowbUFA11ocrRWSh
         BDGKgRXo1Tyg27YE89N4hwD27d5JT7U64+hgjWoag4+AgFhsV8J3naLUCmgu8SJ5HTEc
         ZNgYAhlLVTYexBs5rA9it8sXkQvHoKzIjWUWCk+UIDWupY8B6v/xyp95mmGvWHh3IseX
         l8AQ7TDBzS8r0EQfO7RWzP0BLAbLPjoyKs50cCbjv8zaumDgF35xr35MisOarryf1kg3
         Y0RCKoGEmn3ig3ip85mGIeU4uswZ86MQG886MXYoldVfo3qKXUAR6fXVQj71ExGqEptp
         BcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/XA5rkoouGgX9DCK7SjCAV6orQoM99AmvM4Gl/XVcZc=;
        b=K2d1ApO2dx1xZLOwcYcW0TfwW5+pmprstfRmFCJSZTHSF0zChRRH5A4+i4nqF7e1xr
         wqnnPu2DF7Ad7SUAcKi/7LM/4m50jSedo6LMryP0GjytdjftWuHtPiOnK/EeY+TaPkhz
         NjJRL39nNAvW0uY3LJNZG6OV8YBW5D5TXovMhjQlRsT8QzK09DGVgx+/Pyu9u070UC/Z
         8z+TSb48hiQihqgdsTTTUSl9qBiXmH61mYBaI5wX4wC49tnBdsXtLtdWP+oCbhZXjMuQ
         E2Ek9YtNV4yGGGOQBco/oovroVrIvJzrgJkO3PtkIxREvFG+YEcIrhbBHywnlNDkpW9e
         GVNA==
X-Gm-Message-State: ACrzQf3wfrygxA1LEIdP4yOrjjU6h/1kknuBuxHu1+vqJfktm/BU3ikC
        lX8sHOfEgCf0ZA4BOzWtHvw2AQ==
X-Google-Smtp-Source: AMsMyM7Bspny5wJ7RTUvQPBMhUFUW4mhUnaRJBnTUiH0bjIFvW70GdXwxuc6WhIqJ42e15MlO4qMzQ==
X-Received: by 2002:a63:b4a:0:b0:438:c97c:994d with SMTP id a10-20020a630b4a000000b00438c97c994dmr21373081pgl.597.1663689650624;
        Tue, 20 Sep 2022 09:00:50 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id bf10-20020a170902b90a00b0017849a2b56asm89488plb.46.2022.09.20.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:00:48 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2] serial: sifive: enable clocks for UART when probed
Date:   Tue, 20 Sep 2022 09:00:18 -0700
Message-Id: <20220920160017.7315-1-olof@lixom.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the PWM driver was changed to disable clocks if no PWMs are enabled,
it ended up also disabling the shared parent with the UART, since the
UART doesn't do any clock enablement on its own.

To avoid these surprises, switch to clk_get_enabled().

Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly once per running PWM")
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

---

v2: Switch to devm_clk_enabled() per Uwe's suggestion.

---
 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5c3a07546a58..4b1d4fe8458e 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -945,7 +945,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to find controller clock\n");
 		return PTR_ERR(clk);
-- 
2.30.2

