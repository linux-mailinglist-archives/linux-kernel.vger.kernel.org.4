Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050355EC012
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiI0Kr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiI0KrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:47:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EAAF499;
        Tue, 27 Sep 2022 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664275643; x=1695811643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hN5Bp4Ggb6Ex76+LvlvoDPaQw1VAn4H/N7W96oY8WEA=;
  b=KRNWqNv2rufnl21ulUVfpmBTsxOlF9UY+jCy9wYit13EeNaA1Xr4Q3ia
   5ce7X3wge6A8pUHrcUTG/0TuKklbH0HZYWZs/+YJ/PYk/gjZ65/QVorlm
   z9uzfmCkwmrE7SKlrWi+8+/vC7W0aNvA20gUaluPLcInOsz62jR8PnUsp
   mBUsLeCPizE4Kn+M3T1kxcMh8Z7rbpjK9RQvsGfKPDfMxdOtpFr9tCn2P
   s1Pf3sWWD7t68z3yoCLmOSjKQaCIT2AIa/SfHLAPOdrJIjDuDFKSg/Ju9
   1Qv3/U9DaEqJBT4J4HB9LIQw03ewpD7TEmlsGeiTUcewu3n9IlGqbEJJs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298880282"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="298880282"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 03:47:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572607712"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="572607712"
Received: from aksaxena-mobl2.ger.corp.intel.com ([10.252.60.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 03:47:13 -0700
Date:   Tue, 27 Sep 2022 13:47:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] serial: Convert serial_rs485 to kernel doc
Message-ID: <1c401476-8f4d-827c-f8e1-b4853988e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-422374268-1664275636=:2334"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-422374268-1664275636=:2334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Convert struct serial_rs485 comments to kernel doc format and include
it into documentation.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
v2:
- Include serial_rs485 into documentation
- Add * to multi-line flag descriptions

For reasons unknown to me, the formatting in the flags doesn't produce the
effect promised by kerneldoc's documentation:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#return-values


 Documentation/driver-api/serial/serial-rs485.rst | 13 ++---
 include/uapi/linux/serial.h                      | 61 ++++++++++++++++--------
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 6ebad75c74ed..3b3492a60ecc 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -29,11 +29,11 @@ RS485 Serial Communications
 3. Data Structures Already Available in the Kernel
 ==================================================
 
-   The Linux kernel provides the serial_rs485 structure (see [1]) to handle
-   RS485 communications. This data structure is used to set and configure RS485
+   The Linux kernel provides the serial_rs485 structure to handle RS485
+   communications.  This data structure is used to set and configure RS485
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
index cea06924b295..47b09d8c2fe7 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -107,37 +107,56 @@ struct serial_icounter_struct {
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
+ * * %SER_RS485_ENABLED		- RS485 enabled.
+ * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
+ * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
+ * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
+ * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
+ * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
+ * * %SER_RS485_ADDR_RECV	- Receive address filter (enables @addr_recv).
+ * *				  Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_ADDR_DEST	- Destination address (enables @addr_dest).
+ * *				  Requires %SER_RS485_ADDRB.
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
tg: (2eb6f6da8b51..) rs485/kdoc (depends on: supported-fix/intro-kernel_serial_rs485_to_user_rs485)
--8323329-422374268-1664275636=:2334--
