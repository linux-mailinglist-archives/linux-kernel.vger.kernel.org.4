Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC47414E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1P0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjF1PZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:25:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9A2682;
        Wed, 28 Jun 2023 08:25:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55adfa61199so2612641a12.2;
        Wed, 28 Jun 2023 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687965952; x=1690557952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4lOJqlO+m1XcCVJDoqo4LYW2FoCv0dKe3840PVKsVg=;
        b=U/BcOhqvS44SFeqphSYAucZs9BXpwPTfqIe4vYZescTcIzohXH6nnk9w/g5bI60fJq
         B853T6sPl0XjxnvVYa/YPXCmN9sUg5Zy5/6quOLEQnTzmIuzXBqnRpRMD4hnCXtWAecQ
         RCQgLqh04na0Q9Drxbyos7O2fZUq2TNwpmto5FAjCO7W343PUgsNRg9rsdTQtobJx8ot
         mHT+Cxs2WWnnpxLmeKjOTFny7X9UPM09KSOb0vpwCs9KozefZm+u8EV3XjzkGFn+R3Zh
         q6CiTTTcrEVuxjnJ7u+9ZN5ABS7Zqxh4HXaSVkFoBZPcAybs2ZLgGWMsUa0HrK9mL+rT
         lKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965952; x=1690557952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4lOJqlO+m1XcCVJDoqo4LYW2FoCv0dKe3840PVKsVg=;
        b=CtP6HyZY/ktbqDw/3FzfnddnvUmeLjBfJwKsIkTnD/GJJyRVxh7ktbEWcIKsjDsv6s
         ufV1NF5aaZTf+fOCgsS01LKYQk59/pi4xO0cT12zNZLnTtfMn8TvnP9pXIn3HPQtgYDe
         iOYjunU6PpZP2vm2DOg4yQjyxTOOpBuJAWCsRwAySIPcQ0bxdn2S0Rb3b8NWZO7wRpkk
         KMbGP2EuMQdiuLeJ1ZalhysOq3t+6nygvy5xKJLRE1E/+p/A6FJv3oDD8TxXpZA710ly
         8bHdTfcHYvVw/XbOJ8LLc1kdEcmlKeAXsFxBvIKimCpSYv3hLMHQ72/ASTS0IUplKiy9
         5Zpw==
X-Gm-Message-State: AC+VfDxw0nv5nQxlyVxlge6vz3VqMFSXed4m9upFjXbSVTd+YIeeQaLv
        j3t1Vn/ILNXMLfEe6I6KuYg=
X-Google-Smtp-Source: ACHHUZ5HsB9Dk/4b5zEZUH2EtL7M7ADWTPlPwL0H4tceTmfa40sAM0eGuokuYZhWoNNFRZ53u1yeOw==
X-Received: by 2002:a17:90b:3b41:b0:262:f872:fa77 with SMTP id ot1-20020a17090b3b4100b00262f872fa77mr7793984pjb.31.1687965951831;
        Wed, 28 Jun 2023 08:25:51 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id r2-20020a635142000000b004ff6b744248sm7539337pgl.48.2023.06.28.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:25:51 -0700 (PDT)
From:   ruihongluo <colorsu1922@gmail.com>
X-Google-Original-From: ruihongluo <luoruihong@xiaomi.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        ruihongluo <luoruihong@xiaomi.com>
Subject: [PATCH v1 1/1] serial: 8250: Preserve original value of DLF register
Date:   Wed, 28 Jun 2023 23:21:37 +0800
Message-Id: <20230628152135.56286-1-luoruihong@xiaomi.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is aimed at preserving the original value of the
DLF(Divisor Latch Fraction Register). When the DLF register is
modified without preservation, it can disrupt the baudrate settings
established by firmware or bootloader , leading to data corruption
and the generation of unreadable or distorted characters.

Signed-off-by: ruihongluo <luoruihong@xiaomi.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..d30957722da8 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, orig;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	orig = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, orig);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-- 
2.39.2

