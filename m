Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81284626BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiKLVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiKLVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:58 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441418E3F;
        Sat, 12 Nov 2022 13:21:45 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z1so5323835qkl.9;
        Sat, 12 Nov 2022 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnlgHyHxWkwP8NBkj8ItqSrcSz+jgPdiCkwmRSzVrD8=;
        b=N/5v4fSSSIAGk863cGwJ2LOZwHTkOlTFVZw5GBTZwG0fYggDGLhFLWEbS3SyaPoxGu
         bybG+F5QBHDGxXXIBEQAVFBTapHVzBwoE4+bix/ZqF+Zv6THz+qlPHG6LJAXOI2ieBi9
         y5clfWPmRUsCgTSXm8Xg7XCFeWCHRRKfjZT+cayXiy7b1OKRMJRFOWcsHJT78V5laOI6
         5qwdJVRt70KJt8CWEzCWWv+obmTrj2EFiRAv2FXVZVC6IIpvboeCwA5r5c+Vk+9cqf7B
         1Z9snQ+4S8f6LCk7FilZj32bZUGhtTrESff7AGqGj5kEUoXJGOquWGl7iqr9XP8cz+jm
         +5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnlgHyHxWkwP8NBkj8ItqSrcSz+jgPdiCkwmRSzVrD8=;
        b=PubWIGmneq80zX3VUf/ZugHI7xLOwb8sIXb0z7V5TBK96Vl24nMMMSqrwQWu/grMYi
         DfTyyXtHbphLfNKdGLsBUcgvgRoZjQ9RAtmlHNkWZBge3YnxIWZnoVs4RFie1gP1zL5o
         S/q6VRJapN68YWxXUgjpcP8PyOgicjzrpWQUqqMUaQXTCVTGuN7XKwYGTz5hQPBxARcS
         mOsTmXyTpb4gcspuHaQo7HKdP1AWhLdirgXJ0ppntgy9sWtscx3RksycQx9WOrWQpbjb
         7TalEiBOOvzvVlvJeYD1l0TksD1jW2R1aAmvCnaW39+ZDw2EtonSbFcOP5IMK5P06F/m
         f9eg==
X-Gm-Message-State: ANoB5pnJKyVZNxAVUJvGgQOvE+Ol8Yc63VEmmsTpXkKSwpzX9Hwo7xxR
        pkWOakNUrobqo4dw7LZff8P0SFXn3QfwsA==
X-Google-Smtp-Source: AA0mqf43wYR7w8wXm1JYc0EdjmCyTS+k0PyPOi4hh0jDhhXV/dw+Qdm1ofeA0z0DScZZuFPDEw0Hig==
X-Received: by 2002:a05:620a:1202:b0:6fa:5f94:8b16 with SMTP id u2-20020a05620a120200b006fa5f948b16mr5871509qkj.215.1668288103983;
        Sat, 12 Nov 2022 13:21:43 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:43 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX path
Date:   Sat, 12 Nov 2022 16:21:24 -0500
Message-Id: <20221112212125.448824-14-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
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

Modify the TX path to operate in an IRQ-compatible way, while
maintaining support for polling mode via the poll timer.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index e30adb30277f..307c27398e30 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -46,6 +46,7 @@ struct liteuart_port {
 	struct uart_port port;
 	struct timer_list timer;
 	u32 id;
+	bool poll_tx_started;
 };
 
 #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
@@ -78,29 +79,24 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
 
 static void liteuart_stop_tx(struct uart_port *port)
 {
-	/* not used in LiteUART, but called unconditionally from serial_core */
+	if (port->irq) {
+		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
+		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
+	} else {
+		struct liteuart_port *uart = to_liteuart_port(port);
+		uart->poll_tx_started = false;
+	}
 }
 
 static void liteuart_start_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned char ch;
-
-	if (unlikely(port->x_char)) {
-		litex_write8(port->membase + OFF_RXTX, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-	} else if (!uart_circ_empty(xmit)) {
-		while (xmit->head != xmit->tail) {
-			ch = xmit->buf[xmit->tail];
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-			port->icount.tx++;
-			liteuart_putchar(port, ch);
-		}
+	if (port->irq) {
+		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
+		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);
+	} else {
+		struct liteuart_port *uart = to_liteuart_port(port);
+		uart->poll_tx_started = true;
 	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
 }
 
 static void liteuart_stop_rx(struct uart_port *port)
@@ -131,18 +127,47 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static void liteuart_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+
+	if (unlikely(port->x_char)) {
+		litex_write8(port->membase + OFF_RXTX, port->x_char);
+		port->x_char = 0;
+		port->icount.tx++;
+		return;
+	}
+
+	while (!litex_read8(port->membase + OFF_TXFULL)) {
+		if (xmit->head == xmit->tail)
+			break;
+		litex_write8(port->membase + OFF_RXTX, xmit->buf[xmit->tail]);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		liteuart_stop_tx(port);
+}
+
 static irqreturn_t liteuart_interrupt(int irq, void *data)
 {
 	struct liteuart_port *uart = data;
 	struct uart_port *port = &uart->port;
 	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
 
-	/* for now, only rx path triggers interrupts */
-	isr &= EV_RX;
+	if (!(port->irq || uart->poll_tx_started))
+		isr &= ~EV_TX;	/* polling mode with tx stopped */
 
 	spin_lock(&port->lock);
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
+	if (isr & EV_TX) {
+		liteuart_tx_chars(port);
+	}
 	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(isr);
@@ -196,6 +221,7 @@ static int liteuart_startup(struct uart_port *port)
 	}
 
 	if (!port->irq) {
+		uart->poll_tx_started = false;
 		timer_setup(&uart->timer, liteuart_timer, 0);
 		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 	}
@@ -210,6 +236,7 @@ static void liteuart_shutdown(struct uart_port *port)
 	struct liteuart_port *uart = to_liteuart_port(port);
 
 	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	uart->poll_tx_started = false;
 
 	if (port->irq)
 		free_irq(port->irq, port);
-- 
2.37.3

