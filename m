Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22076EA7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDUJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDUJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:58:45 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC056BBBB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:58:14 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id nMy72900H1C8whw01My7h8; Fri, 21 Apr 2023 11:58:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ppnVv-00HQwh-Ha;
        Fri, 21 Apr 2023 11:58:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ppnWp-00GXP1-Lf;
        Fri, 21 Apr 2023 11:58:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: 8250: Document termios parameter of serial8250_em485_config()
Date:   Fri, 21 Apr 2023 11:58:06 +0200
Message-Id: <2bd1e62be1d5d33333002910372feecc6d52e78f.1682071013.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With W=1:

    drivers/tty/serial/8250/8250_port.c:679: warning: Function parameter or member 'termios' not described in 'serial8250_em485_config'

Fix this by documenting the parameter.

Fixes: ae50bb2752836277 ("serial: take termios_rwsem for ->rs485_config() & pass termios as param")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index dfbc501cf9d1561e..a0fd5ecc07ac66f3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -668,6 +668,7 @@ EXPORT_SYMBOL_GPL(serial8250_em485_supported);
 /**
  * serial8250_em485_config() - generic ->rs485_config() callback
  * @port: uart port
+ * @termios: termios structure
  * @rs485: rs485 settings
  *
  * Generic callback usable by 8250 uart drivers to activate rs485 settings
-- 
2.34.1

