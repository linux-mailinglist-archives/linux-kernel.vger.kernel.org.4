Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949485EDB50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiI1LIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiI1LH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C782101949;
        Wed, 28 Sep 2022 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363126; x=1695899126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isd3ei59WMQmjlcSDG6iO7P5tb/X0qBSvWzx1VebDe0=;
  b=WVL9bqjtNRmwhwx1xGLRjmCDsEZ93Qo4iU90aFgvEXruPD+3hHOxvLqC
   yPbIih2ebzlTjcuKL5/7D9tAUQtOBeNmVXehps9NVkpQgLuuW9/EdN/To
   BwHIef3asvcWB+Cc4AW9cJS5VJWAhMFi4SGTvoqjpxxO4X5ehF3PNgp40
   1/WOTBDdibL6fVfg3ppXPIydyuHmF3BIrmJLVXTQCFyAav2gZYgqEO5KT
   x7Lsjk+x25nNuzgDAA3GCOnr22J498THR5eNcDwpm3FIs6MF4j4cRtMtD
   +TC9NQGnceN9lmEqVQM4ihlxWbDdvfJXi2qYkE+aReIAEqM8QdhpdbLzk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301548700"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="301548700"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="624110537"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="624110537"
Received: from kjurkiew-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/4] serial: Convert serial_rs485 to kernel doc
Date:   Wed, 28 Sep 2022 14:05:06 +0300
Message-Id: <20220928110509.13544-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
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
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 13 ++--
 include/uapi/linux/serial.h                   | 62 ++++++++++++-------
 2 files changed, 48 insertions(+), 27 deletions(-)

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
index cea06924b295..6e347eb10b1f 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -107,37 +107,57 @@ struct serial_icounter_struct {
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
+ * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
+ *				  Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
+ *				  Requires %SER_RS485_ADDRB.
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
 
-	/* The fields below are defined by flags */
+	/* private: The fields below are defined by flags */
 	union {
-		__u32	padding[5];		/* Memory is cheap, new structs are a pain */
+		/* private: Memory is cheap, new structs are a pain. */
+		__u32	padding[5];
 
 		struct {
 			__u8	addr_recv;
-- 
2.30.2

