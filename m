Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10E69A770
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBQIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBQIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:50:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6E60A75;
        Fri, 17 Feb 2023 00:50:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mj16so644950pjb.3;
        Fri, 17 Feb 2023 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4jnTqGI73DRMgZJI4c2qvwAhYDDTU4nAsJXbLQC4qg=;
        b=qHVJRzxX3+FniAKFwLtFv+ZcIyyQ71cT18uqlvaHn4HZVcPHBmTVhPvDXLTkPbU8eg
         oUIjB2EQG9GdmIsSlX9IdqUTvikfZGR4RBLWsxz43Wh3RaGPgaZzwZ92/CIdh7CA9NL8
         7dugJTmSLjgku9NauA+GaHlAzRNCPdTFnY2iDW/XIy2mxoP5y3KdeLR/qV4NB1typUSp
         0+j3AiBmzt0yEpSHg/PGIcUot+Khc4tuI5oUVr1nlwusMOZouFgmkyqqTaJ5q+ISRkJ3
         0jbzw5RrC7BpNYAO5wcKoJddQYdFv002kCyg68wMig+kge2o+l9SQQvZbNlU5IxX3Yf5
         9ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4jnTqGI73DRMgZJI4c2qvwAhYDDTU4nAsJXbLQC4qg=;
        b=GJCCbamPbH3bIm2sTR3R31+AEm9DDbtosoduSEqqKKiRIsjhsp6jStMFXSlIqLObmI
         QLbyi/0FT8RcY0+cVfDngolw1IOpNbqGSlm3XSuEbvaK/gXkBQhL0RNAt7ZLi6qyZ1g9
         jv/6rID3KntumBOE4tzsuwi7ufaZw/xcyLpcJYsfK7jqV9u7TiT92mHpoGnNfRI1Rh4l
         Fex6aWEYsVynrDFQVs5JIPTACgPJnUaCOHuK3bcWII0Dg8+ExJFPGJI6Kz+MrrYKu64m
         dczVGyxhWGZF7B0xatT5Gzzi9LHn150syjFEeDz0Z7cG6WMZLzkt9isrbGovxkoqILsk
         W5AA==
X-Gm-Message-State: AO0yUKXF4YT3murhph/B/AjvjCP/9woDFyMuHFmTqC2mqzRQbSdn7/Km
        74ILCpmucByp6ZSIL4q1hO0LgYlHwPo=
X-Google-Smtp-Source: AK7set9ImvZAnZ/1M19kdSG0/nduNYs90YCLLq6YazqHc1qgadexAA0SrQwvbfDncyMZ672bgEHoPA==
X-Received: by 2002:a17:902:dac6:b0:19c:13d2:44c1 with SMTP id q6-20020a170902dac600b0019c13d244c1mr2058697plx.15.1676623797404;
        Fri, 17 Feb 2023 00:49:57 -0800 (PST)
Received: from localhost (59-120-186-245.hinet-ip.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id v13-20020a63464d000000b004fb4489969bsm2362949pgk.49.2023.02.17.00.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2023 00:49:57 -0800 (PST)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, l.sanfilippo@kunbus.com,
        andy.shevchenko@gmail.com, peter_hong@fintek.com.tw,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH] serial: 8250_fintek: Add using BIOS IRQ default setting
Date:   Fri, 17 Feb 2023 16:49:53 +0800
Message-Id: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 8250_fintek.c probe_setup_port(), we'll detect the IRQ trigger mode by
irq_get_irq_data() and pass it to fintek_8250_set_irq_mode(). If detected
Edge mode, we'll set the UART with Edge/High mode, otherwise Level/Low.

But in some motherboard, The APIC maybe setting to Level/High. In this case
the driver will setting wrong configuration into UART. So we add a option
to kernel parameter to control the driver as following:

	fintek_uart_irq_mode_override= [SERIAL]
		{default, bios}
		If the parameter is "default", the driver will using
		former IRQ override methed(By IRQ trigger type).
		otherwise, we'll don't change the UART IRQ setting.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index dba5950b8d0e..c5fea0a7c79b 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -92,6 +92,9 @@
 #define F81866_UART_CLK_18_432MHZ BIT(0)
 #define F81866_UART_CLK_24MHZ BIT(1)

+#define FINTEK_IRQ_MODE_BY_DETECT	0
+#define FINTEK_IRQ_MODE_BY_BIOS		1
+
 struct fintek_8250 {
 	u16 pid;
 	u16 base_port;
@@ -99,6 +102,24 @@ struct fintek_8250 {
 	u8 key;
 };

+static int not_override_irq_mode = FINTEK_IRQ_MODE_BY_DETECT;
+
+static int __init parse_uart_irq_mode_override(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "bios") == 0)
+		not_override_irq_mode = FINTEK_IRQ_MODE_BY_BIOS;
+	else if (strcmp(arg, "default") == 0)
+		not_override_irq_mode = FINTEK_IRQ_MODE_BY_DETECT;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("fintek_uart_irq_mode_override", parse_uart_irq_mode_override);
+
 static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
 {
 	outb(reg, pdata->base_port + ADDR_PORT);
@@ -248,6 +269,12 @@ static int fintek_8250_rs485_config(struct uart_port *port,

 static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 {
+	if (not_override_irq_mode == FINTEK_IRQ_MODE_BY_BIOS) {
+		pr_info("Fintek UART(%04x) irq mode is using BIOS default",
+				pdata->pid);
+		return;
+	}
+
 	sio_write_reg(pdata, LDN, pdata->index);

 	switch (pdata->pid) {
--
2.17.1
