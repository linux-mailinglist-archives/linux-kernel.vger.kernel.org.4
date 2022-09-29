Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51D5EF212
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiI2Jc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiI2Jci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A84DF17;
        Thu, 29 Sep 2022 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443924; x=1695979924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxrq9tExIp5OkzCPWNojrKCj7VrFvPntRogxQtAKOvA=;
  b=M9aGAcuB6curjJfz9oTtlHE/zS9IKIx6yX2Fj2cfqjqs4WfoaWGTY2e6
   W/7e+MeLdjBl6QskgVbB3XM2myQw4KylKCzL5BZJHV4qV+QnLTiyFRioz
   0+mtg45L35BCLtC1yrGaeQpgDYwO1nD4il2Mrlm+WyL1nmi1r1JHb5nBE
   mGjtS+CqRZddT9VvKHsM5/YIEHlTn7FEDlBbg/aiBhs2UA9WK26Zxn6Uu
   U2Y2lM4CGJ6LNLOfkMl7wMCSSO2z3Cvzwf4syiE3OmEpB+pbfAr00+PB3
   oKXeMJFNGmQb6HsWQ7Kdv+Y2YldQcYIAQ9BmoYD4mNW9cjgw3rM2a+xct
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299444108"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="299444108"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867319914"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867319914"
Received: from pramona-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.60.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/4] serial: Convert serial_rs485 to kernel doc
Date:   Thu, 29 Sep 2022 12:31:45 +0300
Message-Id: <20220929093148.9468-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
References: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert struct serial_rs485 comments to kernel doc format and include
it into documentation.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 13 +++--
 include/uapi/linux/serial.h                   | 55 ++++++++++++-------
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 6ebad75c74ed..264e4b753713 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -29,11 +29,11 @@ RS485 Serial Communications
 3. Data Structures Already Available in the Kernel
 ==================================================
 
-   The Linux kernel provides the serial_rs485 structure (see [1]) to handle
-   RS485 communications. This data structure is used to set and configure RS485
+   The Linux kernel provides the serial_rs485 structure to handle RS485
+   communications. This data structure is used to set and configure RS485
    parameters in the platform data and in ioctls.
 
-   The device tree can also provide RS485 boot time parameters (see [2]
+   The device tree can also provide RS485 boot time parameters (see [1]
    for bindings). The driver is in charge of filling this data structure from
    the values given by the device tree.
 
@@ -47,6 +47,9 @@ RS485 Serial Communications
    for the uart_port. TIOCGRS485 ioctl can be used to read back the
    serial_rs485 structure matching to the current configuration.
 
+.. kernel-doc:: include/uapi/linux/serial.h
+   :identifiers: serial_rs485
+
 4. Usage from user-level
 ========================
 
@@ -126,6 +129,4 @@ RS485 Serial Communications
 6. References
 =============
 
- [1]	include/uapi/linux/serial.h
-
- [2]	Documentation/devicetree/bindings/serial/rs485.txt
+ [1]	Documentation/devicetree/bindings/serial/rs485.txt
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index cea06924b295..4634c913f16a 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -107,33 +107,50 @@ struct serial_icounter_struct {
 	int reserved[9];
 };
 
-/*
+/**
+ * struct serial_rs485 - serial interface for controlling RS485 settings.
+ * @flags:			RS485 feature flags.
+ * @delay_rts_before_send:	Delay before send (milliseconds).
+ * @delay_rts_after_send:	Delay after send (milliseconds).
+ * @addr_recv:			Receive filter for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_RECV is set).
+ * @addr_dest:			Destination address for RS485 addressing mode
+ *				(used only when %SER_RS485_ADDR_DEST is set).
+ * @padding0:			Padding (set to zero).
+ * @padding1:			Padding (set to zero).
+ * @padding:			Deprecated, use @padding0 and @padding1 instead.
+ *				Do not use with @addr_recv and @addr_dest (due to
+ *				overlap).
+ *
  * Serial interface for controlling RS485 settings on chips with suitable
  * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by your
  * platform. The set function returns the new state, with any unsupported bits
  * reverted appropriately.
+ *
+ * serial_rs485::flags bits are:
+ *
+ * * %SER_RS485_ENABLED		- RS485 enabled.
+ * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
+ * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
+ * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
+ * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
+ * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
+ * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
  */
-
 struct serial_rs485 {
-	__u32	flags;			/* RS485 feature flags */
-#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
-#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Logical level for
-							   RTS pin when
-							   sending */
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
-							   RTS pin after sent*/
+	__u32	flags;
+#define SER_RS485_ENABLED		(1 << 0)
+#define SER_RS485_RTS_ON_SEND		(1 << 1)
+#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
 #define SER_RS485_RX_DURING_TX		(1 << 4)
-#define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
-							   termination
-							   (if supported) */
-
-/* RS-485 addressing mode */
-#define SER_RS485_ADDRB			(1 << 6)	/* Enable addressing mode */
-#define SER_RS485_ADDR_RECV		(1 << 7)	/* Receive address filter */
-#define SER_RS485_ADDR_DEST		(1 << 8)	/* Destination address */
+#define SER_RS485_TERMINATE_BUS		(1 << 5)
+#define SER_RS485_ADDRB			(1 << 6)
+#define SER_RS485_ADDR_RECV		(1 << 7)
+#define SER_RS485_ADDR_DEST		(1 << 8)
 
-	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
-	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
+	__u32	delay_rts_before_send;
+	__u32	delay_rts_after_send;
 
 	/* The fields below are defined by flags */
 	union {
-- 
2.30.2

