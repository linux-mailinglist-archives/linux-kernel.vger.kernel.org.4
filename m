Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8527962C168
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiKPOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiKPOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:40 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF83FBBE;
        Wed, 16 Nov 2022 06:49:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id i9so11719332qki.10;
        Wed, 16 Nov 2022 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD7MdS5vDL9626kuFaCs08bkmWREVcZginG5UxkUB7M=;
        b=pH88cF+6+fCCO8t2vnymPV45Mzm/I5WpC0TiRTmOrXy6ff5gi3fXdgDC00/f1djz04
         4dPmABNZYkvNQeXWUYlliMOAjk2McGALqtk4OoGencURYqCgybr9OEYHlzHrYDsfQuSe
         ZVaO8K06t5cmk58K3RFmwSIS8ZX6G7arXO5QIMRBo9kt83YVOPkgca63u72Yxwg7T49e
         6vGzaTkxp9CAUnDFA930tf/U8YRbbWXK1pLikdt7XzpfgSLbxBlEVYS2g6zAD9wbuZUE
         rObMeo1H0R5ttDPPKkiTVPHjWlZT1gSfpz++BT+e/UW3UMMbjKE/pjn8gQoNYwRhEFpm
         ejuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD7MdS5vDL9626kuFaCs08bkmWREVcZginG5UxkUB7M=;
        b=tS1hllbGLbuynRYs3mDlUxLfcra6QlZYoSS0XDRZnRjFC2+fqXwh7C/jATLXrhuKZ6
         IbTbHOlsJgO+ts+LYQpkz/1bzcqU8QatsoJZgfur/JXnMsAXsoecfSk1DC3sIO8Cj+mo
         OQD4rRwHvpauveVpTquVnfy8LqWtixpglRHJJnmg7cKG1q5tGG7OBMuUQ/b5EcnUAzan
         Xbg66NGkYoTPVazOv1CxsKq2tR/VB9mgpJQqeBzYCIDCNDbuR/9ogH/vHX+8bRlAfmKv
         HCselrj4t0alFfIf1vHGB9Xv8Ks2ZywuzdAmnQqIyltpyKw8v+iD3bwRuiurCuBjWsWq
         YPqA==
X-Gm-Message-State: ANoB5pmQa3K1MFRODqw/ztjM4ZzBCt6CT0khw8qKYNU+HvGkB43HHYYB
        yTq+Q2XO19F3jP6OnpX03mUk6kxwbX7vfQ==
X-Google-Smtp-Source: AA0mqf46bEGiaBCY5KTx158m40sy8VkOnE7ZMH1L7L75HcN6X7Js2CH1vv07o952Q+UegHfvzXLaOw==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr12498013qki.324.1668610169549;
        Wed, 16 Nov 2022 06:49:29 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:29 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 13/14] serial: liteuart: add IRQ support for the TX path
Date:   Wed, 16 Nov 2022 09:49:07 -0500
Message-Id: <20221116144908.234154-14-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Switch the TX path to IRQ-driven operation, while maintaining support
for polling mode via the poll timer.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

Changes from v3:
  - remove superfluous curly braces from liteuart_interrupt()
  - simplified [start|stop]_tx() by using shadow irq register from
    patch 12/14
  - simplified liteuart_tx_chars() by rebasing on top of tty-next tree

 drivers/tty/serial/liteuart.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index fad778578986..977fc4349b47 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -93,27 +93,12 @@ static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
 
 static void liteuart_stop_tx(struct uart_port *port)
 {
+	liteuart_update_irq_reg(port, false, EV_TX);
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
-			uart_xmit_advance(port, 1);
-			liteuart_putchar(port, ch);
-		}
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	liteuart_update_irq_reg(port, true, EV_TX);
 }
 
 static void liteuart_stop_rx(struct uart_port *port)
@@ -144,6 +129,15 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static void liteuart_tx_chars(struct uart_port *port)
+{
+	u8 ch;
+
+	uart_port_tx(port, ch,
+		!litex_read8(port->membase + OFF_TXFULL),
+		litex_write8(port->membase + OFF_RXTX, ch));
+}
+
 static irqreturn_t liteuart_interrupt(int irq, void *data)
 {
 	struct liteuart_port *uart = data;
@@ -154,6 +148,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
+	if (isr & EV_TX)
+		liteuart_tx_chars(port);
 	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(isr);
-- 
2.38.1

