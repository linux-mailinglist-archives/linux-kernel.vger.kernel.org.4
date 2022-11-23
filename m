Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994D635F76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiKWN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiKWNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8028EB972B;
        Wed, 23 Nov 2022 05:05:22 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id cz18so5738931qvb.13;
        Wed, 23 Nov 2022 05:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeLqQhbAqImPFUjNyp0HTT203vje4doUIz/ij4dp/k4=;
        b=BmcMyxX1XsZJVgbAiyoUS45DFQunc48rd4w7X7n4tVK88XpUVG2SdboR9qvUepv3xP
         mJHxGqqbwIbgYNcuS7JgrJU/RkPRUrQ+yof/YmTsN5OQ6OkXMJ7nXZLQDs3Bo6opEjiC
         ZRKxgkg35llv2PbS2/zVpo9LKwL+3xNBC+FIbF6fGuI4atSMcSWxEDcaYrYpNppuJxM9
         QV6vqf6ENM/MOtmb4C+FFlsMD1qj5rl6ZJMRQdwoPMLXTXDBkWEs0zk092HDTBrLh/gi
         AQ8vOrmLITXOGZUL8xai5vUn1MgRNME+n5DjqS5TUj9NhZtG5kLuMZaOIPHR1T6gJr8b
         m+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeLqQhbAqImPFUjNyp0HTT203vje4doUIz/ij4dp/k4=;
        b=BlFUQkKeQSDJwTjR47SyU3C2CiNJj+7Q9dFGEAcCUqasKi86laiebnXCf8I+W594bP
         mAfDkOYomcopAkRcrYIBi/dTBOPDKuemJirJvb1T3SuVd6639cuVhmNppZeHJG18ogIQ
         HDXDO+CowsuiNTYcKnpSmsNfBK5ExbrUVPOrfchI2NgNeI5zqNyQlJQR0d05OhPpTWmu
         8of4jhH3jynizPr4geh+rEqX5lNwl+AvzcI2mTnc4bCdzo1H9T88O/9R6xDMpPnUQn2t
         YKsFFExgZnjJN9crSBi6KQLrcsykwHEe0/ESu4tY2l1amoVGf5dK0xCbLNU4rzA26joo
         HQ9Q==
X-Gm-Message-State: ANoB5pngChtrDKDjyLZl/kWnynMwq+tKHg5/CV8LUs4ZywbXnIGmpU+n
        iXoqFAav4zKJyTt2oDGyQw7J8lSmS1RLdw==
X-Google-Smtp-Source: AA0mqf7nBKdWEEYOVL6qOw9Mx16GKX7N/lz6EUDOJR2C4sW1Q7s0uQBCXVs8KoXAHlcaxY8cui+ueg==
X-Received: by 2002:a05:6214:3d85:b0:4c6:b19a:10f8 with SMTP id om5-20020a0562143d8500b004c6b19a10f8mr8770988qvb.45.1669208720841;
        Wed, 23 Nov 2022 05:05:20 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:20 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 12/14] serial: liteuart: add IRQ support for the RX path
Date:   Wed, 23 Nov 2022 08:04:58 -0500
Message-Id: <20221123130500.1030189-13-gsomlo@gmail.com>
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

Add support for IRQ-driven RX. Support for the TX path will be added
in a separate commit.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Changes from v5:
  - s/dev_err/dev_warn/ when falling back to polling in `liteuart_startup()`
  - use `spin_[lock_irqsave|unlock_irqrestore]()` in the interrupt handler,
    since the same code may also be called in "serving_softirq" context when
    using a poll timer instead of hardware interrupts

> Changes from v4:
>   - using dev_err() instead of a combo of pr_err() and pr_fmt()
>   - dropped "get irq" comment in probe()
>
> Changes from v3:
>   - add shadow irq register to support polling mode and avoid reading
>     hardware mmio irq register to learn which irq flags are enabled
>     - this also simplifies both liteuart_interrupt() and liteuart_startup()

 drivers/tty/serial/liteuart.c | 81 ++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 0b9d96e5efcf..8685c97d391e 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -46,6 +47,7 @@ struct liteuart_port {
 	struct uart_port port;
 	struct timer_list timer;
 	u32 id;
+	u8 irq_reg;
 };
 
 #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
@@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
 	litex_write8(port->membase + OFF_RXTX, ch);
 }
 
+static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	if (set)
+		uart->irq_reg |= mask;
+	else
+		uart->irq_reg &= ~mask;
+
+	if (port->irq)
+		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
+}
+
 static void liteuart_stop_tx(struct uart_port *port)
 {
 }
@@ -129,13 +144,32 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static irqreturn_t liteuart_interrupt(int irq, void *data)
+{
+	struct liteuart_port *uart = data;
+	struct uart_port *port = &uart->port;
+	unsigned long flags;
+	u8 isr;
+
+	/*
+	 * if polling, the context would be "in_serving_softirq", so use
+	 * irq[save|restore] spin_lock variants to cover all possibilities
+	 */
+	spin_lock_irqsave(&port->lock, flags);
+	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
+	if (isr & EV_RX)
+		liteuart_rx_chars(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_RETVAL(isr);
+}
+
 static void liteuart_timer(struct timer_list *t)
 {
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 
-	liteuart_rx_chars(port);
-
+	liteuart_interrupt(0, port);
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
@@ -161,19 +195,46 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+	int ret;
 
-	/* disable events */
-	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	if (port->irq) {
+		ret = request_irq(port->irq, liteuart_interrupt, 0,
+				  KBUILD_MODNAME, uart);
+		if (ret) {
+			dev_warn(port->dev,
+				"line %d irq %d failed: switch to polling\n",
+				port->line, port->irq);
+			port->irq = 0;
+		}
+	}
 
-	/* prepare timer for polling */
-	timer_setup(&uart->timer, liteuart_timer, 0);
-	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	spin_lock_irqsave(&port->lock, flags);
+	/* only enabling rx irqs during startup */
+	liteuart_update_irq_reg(port, true, EV_RX);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (!port->irq) {
+		timer_setup(&uart->timer, liteuart_timer, 0);
+		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	}
 
 	return 0;
 }
 
 static void liteuart_shutdown(struct uart_port *port)
 {
+	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (port->irq)
+		free_irq(port->irq, port);
+	else
+		del_timer_sync(&uart->timer);
 }
 
 static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
@@ -262,6 +323,12 @@ static int liteuart_probe(struct platform_device *pdev)
 		goto err_erase_id;
 	}
 
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		port->irq = ret;
+
 	/* values not from device tree */
 	port->dev = &pdev->dev;
 	port->iotype = UPIO_MEM;
-- 
2.38.1

