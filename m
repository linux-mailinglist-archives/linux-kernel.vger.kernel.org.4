Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17462C169
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKPOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiKPOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:41 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9E17A9E;
        Wed, 16 Nov 2022 06:49:31 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id u7so12003003qvn.13;
        Wed, 16 Nov 2022 06:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsRGGaIiBoJlwl/45zB6BAECaPWQUSVeGqaE9kAVQrI=;
        b=CqrrIl3uMqf9NCB5q4CLw/Pa8BCbWfgMrW1s9jDsDO0IemRCQGuS1bWJnczyJEz4yv
         sSzpnT2kKzIrTl4xHRy6MuaGNn4SYXg5fPxuSXtaZvP4CPLvgFmhMtqi5ouDKYYD1Kyl
         2QKrrtN/XU1QXctfCpfvsqxQxigLLro4miqSM0JVDHd5YDAlc5+DGPZUW96wJ1s85mE4
         VjHj/3V8++CJPw5A3x660GYei74pQ8yyorgP79WHClIW00NWC3RH0on+zHo/JrT3nN/o
         qaojdX1Rbi+azeYmSoA0e1fqTfQjq7Yd62hTSyTbb8yFapevogH9pQgQKjyXdK0NXWVA
         leLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsRGGaIiBoJlwl/45zB6BAECaPWQUSVeGqaE9kAVQrI=;
        b=tLrRNeCt9UajBy8AfNxCHY+kloSy50SQNXGINjpPnM1yyN0H9raTMATDkCAFgHSifQ
         awGBs/WVIBRz768Tbd7CpUPTLpa2Me17Q6C+3MWd62lQ9Gls55iNO9Vx2tEWv1Ft9JCx
         HrB19qufbgLyXLdhNTo9q+YWom1fdkjTNpGO9AqponmeQ1Kn1HbiOhz0xA32F7b/zH8m
         3p02kt3HYoQ5LPvvHlFyHajPJcWcmaX+XH8Us0zISm9vYvdlLFbFDkNoNIghePGn9Yvf
         vpocaDvxh3xOZdLj/Ij3BRevF+7E15xKD6p2aTKPigBKxRCBROJksRxK55k0XiTwakVV
         VbEg==
X-Gm-Message-State: ANoB5pk6zD7N1PLLHBaLnuegO/YRNDTBrx8dEFZZTbJI61tRi60MV4v8
        fdaJtaNEisBzah7o704uxrKN0N5LKOZXtA==
X-Google-Smtp-Source: AA0mqf7GNSwZZJNcB+oms94DY8nCWtNvbQUHc7BMFnPcrIxoh8m0VYjlpfke324iahugsfe/I0dNTQ==
X-Received: by 2002:a05:6214:370c:b0:4bb:64f7:dce5 with SMTP id np12-20020a056214370c00b004bb64f7dce5mr20740663qvb.15.1668610170609;
        Wed, 16 Nov 2022 06:49:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 14/14] serial: liteuart: move polling putchar() function
Date:   Wed, 16 Nov 2022 09:49:08 -0500
Message-Id: <20221116144908.234154-15-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

The polling liteuart_putchar() function is only called from methods
conditionally enabled by CONFIG_SERIAL_LITEUART_CONSOLE. Move its
definition closer to the console code where it is dependent on the
same config option.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 977fc4349b47..238f615cb80e 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -70,14 +70,6 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_putchar(struct uart_port *port, unsigned char ch)
-{
-	while (litex_read8(port->membase + OFF_TXFULL))
-		cpu_relax();
-
-	litex_write8(port->membase + OFF_RXTX, ch);
-}
-
 static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
@@ -372,6 +364,14 @@ static struct platform_driver liteuart_platform_driver = {
 
 #ifdef CONFIG_SERIAL_LITEUART_CONSOLE
 
+static void liteuart_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, ch);
+}
+
 static void liteuart_console_write(struct console *co, const char *s,
 	unsigned int count)
 {
-- 
2.38.1

