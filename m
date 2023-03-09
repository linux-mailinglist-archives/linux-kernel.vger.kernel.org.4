Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4263B6B1D80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCIILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCIIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:10:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F13DABBA;
        Thu,  9 Mar 2023 00:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349397; x=1709885397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XRfgPpxn85tLsP11RZ0ULRKBpwwTVjqUGvOxfTssIbI=;
  b=RSB1rN1wb/isOzoPegHlumSOcJarT846lTr6zQ8lkDs6Pi50pmbOrLxc
   9DiSmOhI0Fruz41DwGnhiylMJ3PNm8J+KCY2cWUUf/jE2CN+DfCpe6Z3V
   5KR1fAGgzN154d6kHNlSPX/DHahzTuy/TqyE8FlhALbO8FI+BIO2CfIXt
   BCx7vLy172GzlCjL2hRUZH/ThofzznTRdq6FAmcPQsOKxHL5U5UkFlWZK
   G0b5zILRT70FwPTpgsmUFkQnfC5hWaEGjuqrCS+KbF++AWrem4ptlHhzo
   fWlnfXkKeb5OD4T8r/3mM1xJCySVOUa5dehdPA6s0Q2E5xEOuzzA9xCL8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853575"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853575"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746227972"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746227972"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:39 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/8] serial: Remove extern from func prototypes in headers
Date:   Thu,  9 Mar 2023 10:09:18 +0200
Message-Id: <20230309080923.11778-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
References: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary externs from function prototypes in serial_8250.h
and serial_core.h.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/serial_8250.h | 41 ++++++++++++++++---------------------
 include/linux/serial_core.h | 13 ++++++------
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 19376bee9667..482ce4e66a6b 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -151,26 +151,22 @@ void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
 
-extern int early_serial_setup(struct uart_port *port);
-
-extern int early_serial8250_setup(struct earlycon_device *device,
-					 const char *options);
-extern void serial8250_update_uartclk(struct uart_port *port,
-				      unsigned int uartclk);
-extern void serial8250_do_set_termios(struct uart_port *port,
-		struct ktermios *termios, const struct ktermios *old);
-extern void serial8250_do_set_ldisc(struct uart_port *port,
-				    struct ktermios *termios);
-extern unsigned int serial8250_do_get_mctrl(struct uart_port *port);
-extern int serial8250_do_startup(struct uart_port *port);
-extern void serial8250_do_shutdown(struct uart_port *port);
-extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
-			     unsigned int oldstate);
-extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
-extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-				      unsigned int quot,
-				      unsigned int quot_frac);
-extern int fsl8250_handle_irq(struct uart_port *port);
+int early_serial_setup(struct uart_port *port);
+int early_serial8250_setup(struct earlycon_device *device, const char *options);
+
+void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk);
+void serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
+			       const struct ktermios *old);
+void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios);
+unsigned int serial8250_do_get_mctrl(struct uart_port *port);
+int serial8250_do_startup(struct uart_port *port);
+void serial8250_do_shutdown(struct uart_port *port);
+void serial8250_do_pm(struct uart_port *port, unsigned int state,
+		      unsigned int oldstate);
+void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac);
+int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
@@ -183,9 +179,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
-extern void serial8250_set_isa_configurator(void (*v)
-					(int port, struct uart_port *up,
-						u32 *capabilities));
+void serial8250_set_isa_configurator(void (*v)(int port, struct uart_port *up,
+					       u32 *capabilities));
 
 #ifdef CONFIG_SERIAL_8250_RT288X
 unsigned int au_serial_in(struct uart_port *p, int offset);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9e3e5e0d11b2..05d18a145b3a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -812,9 +812,8 @@ extern const struct earlycon_id __earlycon_table_end[];
 
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
-extern int of_setup_earlycon(const struct earlycon_id *match,
-			     unsigned long node,
-			     const char *options);
+int of_setup_earlycon(const struct earlycon_id *match, unsigned long node,
+		      const char *options);
 
 #ifdef CONFIG_SERIAL_EARLYCON
 extern bool earlycon_acpi_spcr_enable __initdata;
@@ -897,11 +896,11 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  * The following are helper functions for the low level drivers.
  */
 
-extern void uart_handle_dcd_change(struct uart_port *uport, bool active);
-extern void uart_handle_cts_change(struct uart_port *uport, bool active);
+void uart_handle_dcd_change(struct uart_port *uport, bool active);
+void uart_handle_cts_change(struct uart_port *uport, bool active);
 
-extern void uart_insert_char(struct uart_port *port, unsigned int status,
-		 unsigned int overrun, unsigned int ch, unsigned int flag);
+void uart_insert_char(struct uart_port *port, unsigned int status,
+		      unsigned int overrun, unsigned int ch, unsigned int flag);
 
 void uart_xchar_out(struct uart_port *uport, int offset);
 
-- 
2.30.2

