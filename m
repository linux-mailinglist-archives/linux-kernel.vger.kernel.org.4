Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758695BD787
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiISWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiISWjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:39:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D9CE66
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:39:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so709410pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fFcLaIdKXlgDGkA95O0lHl/2ZQsYb6rituY3HQNR/Cw=;
        b=KYcfCDEi4vF8hV/a+u7f57iqAAJ4vl/lQfGYkx27RywtgANIRwbfXfN5pAkDZs2F6N
         o1or1G779iRYXIfEL+QSHX9L9DzHSjh8QQv1wptf1THJA09U3hqVpHWBsh9GcY0PizSN
         zRXb8gMxH3ECXOPMRLdYAUL/7BbMtDyv8b8T1CgqRKOpGjnStB9MUUQfUeQ45Q75P9Vb
         eFxOkF3sns5d29ooDP09ItoyeViXWsIdfLM48+AzcIX5KoxOFXYur8/Jv6ZgoR2UceN4
         FQXK3bKK0+CfigkDXfsNUo6Z+pUguhpB5a9Jzf+8aC0SkDSoh0zwyjc8sfEgqMhDCxId
         52fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fFcLaIdKXlgDGkA95O0lHl/2ZQsYb6rituY3HQNR/Cw=;
        b=4rWMgsZj3STUw5BS8lEsB3udfzM69OTn685H6EIVIf66C6BziDkKWxTB+9GyT7EPBO
         ogXeKg6U86oMSVOZu4m+8Z4TW/oDml8QyaRW7u9TDG74sClCHM5McEE0NykgMLC/GDHH
         hHG/J20HZeVterptXuhP6awenrbd2lmEBYNlVHKlcc+GBKbPJTz2wzAKAjYiM/mpHkJx
         MXT2hn2QX1jwWkA+nmD/4rS0oB9Xa+7pDzfq7NYD8HEUoKi6w3Rtensho8Xpj1a9oc9J
         nKnYyAVzeiyYxah9511opiXjeG/lZkPkxaj1j+sX5pUam3TmK3UXogqjJf8xHmjqgqSP
         MQyg==
X-Gm-Message-State: ACrzQf12XNtzO1oFTzBSiFMNG4EvUwz1Y361plP7Ljeka65sZAuO3UvN
        vP2hpVQOHbFFD2Ey5gZF7SIobg==
X-Google-Smtp-Source: AMsMyM7DR/q1kUqDv3ej5C4oQEc0xUujKbwn4sZlKKHP//4c/iOs4jcquF4XZadj+kHrp9ciHVQrhw==
X-Received: by 2002:a63:4243:0:b0:439:2031:be87 with SMTP id p64-20020a634243000000b004392031be87mr17659366pga.592.1663627170148;
        Mon, 19 Sep 2022 15:39:30 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00177f32b1a32sm21074410pls.271.2022.09.19.15.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:39:29 -0700 (PDT)
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
Subject: [PATCH] serial: sifive: enable clocks for UART when probed
Date:   Mon, 19 Sep 2022 15:39:15 -0700
Message-Id: <20220919223915.5146-1-olof@lixom.net>
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

To avoid these surprises, add clk_prepare_enable/clk_disable_unprepare
calls.

Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly once per running PWM")
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/tty/serial/sifive.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5c3a07546a58..751f98068806 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -950,23 +950,28 @@ static int sifive_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to find controller clock\n");
 		return PTR_ERR(clk);
 	}
+	clk_prepare_enable(clk);
 
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (id < 0) {
 		dev_err(&pdev->dev, "missing aliases entry\n");
-		return id;
+		r = id;
+		goto probe_out1;
 	}
 
 #ifdef CONFIG_SERIAL_SIFIVE_CONSOLE
 	if (id > SIFIVE_SERIAL_MAX_PORTS) {
 		dev_err(&pdev->dev, "too many UARTs (%d)\n", id);
-		return -EINVAL;
+		r = -EINVAL;
+		goto probe_out1;
 	}
 #endif
 
 	ssp = devm_kzalloc(&pdev->dev, sizeof(*ssp), GFP_KERNEL);
-	if (!ssp)
-		return -ENOMEM;
+	if (!ssp) {
+		r = -ENOMEM;
+		goto probe_out1;
+	}
 
 	ssp->port.dev = &pdev->dev;
 	ssp->port.type = PORT_SIFIVE_V0;
@@ -1028,6 +1033,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 probe_out2:
 	clk_notifier_unregister(ssp->clk, &ssp->clk_notifier);
 probe_out1:
+	clk_disable_unprepare(clk);
 	return r;
 }
 
-- 
2.30.2

