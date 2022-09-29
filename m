Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8A5EF221
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiI2Jdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiI2Jcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCC80BDA;
        Thu, 29 Sep 2022 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443944; x=1695979944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTfXyABtrWPDgEHj2asTRfYPY8Q87jgv7IqP5hzhfFw=;
  b=MmiBQt/LXwkK4g8QekUQnwxYcxaDxNNUgLQryDiA4K3PrDeCioM7Z3xv
   J2Tb12cZrFIQusi/Fy68IhKikPqe1L8IJ9WQnTwIkIZCiemOYygw8+1uh
   3oKe6mYSmduCI0fPj0vOwkZO+7fCic1jZIp8avWIH+wUOhaNobFUq33Ud
   FBh54o+T04aQOYE5ycm1s6LhO4BqT0UULQqUXyMnC+a+UR61xWhGh2MIL
   U351HA++aVNXp6DoEjWpobYwEbKs3DvXPpuJazPESUjBkpNnLLjsdjUO+
   VRYFDe3iFIehtCrfnTYv9nFjuOEOCjIZjPjYJGeIxhw1R6jcf8eRfQ1Lv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="388126037"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="388126037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867320179"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867320179"
Received: from pramona-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.60.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 4/4] Documentation: rs485: Fix struct referencing
Date:   Thu, 29 Sep 2022 12:31:48 +0300
Message-Id: <20220929093148.9468-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
References: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "struct serial_rs485" to get the references properly recognized.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index ee34c8e1e56e..e53aa291bcd7 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -29,7 +29,7 @@ RS485 Serial Communications
 3. Data Structures Already Available in the Kernel
 ==================================================
 
-   The Linux kernel provides the serial_rs485 structure to handle RS485
+   The Linux kernel provides the struct serial_rs485 to handle RS485
    communications. This data structure is used to set and configure RS485
    parameters in the platform data and in ioctls.
 
@@ -40,13 +40,14 @@ RS485 Serial Communications
 
    Any driver for devices capable of working both as RS232 and RS485 should
    implement the rs485_config callback and provide rs485_supported in the
-   uart_port structure. The serial core calls rs485_config to do the device
-   specific part in response to TIOCSRS485 ioctl (see below). The rs485_config
-   callback receives a pointer to a sanitizated serial_rs485 structure. The
-   serial_rs485 userspace provides is sanitized before calling rs485_config
-   using rs485_supported that indicates what RS485 features the driver supports
-   for the uart_port. TIOCGRS485 ioctl can be used to read back the
-   serial_rs485 structure matching to the current configuration.
+   struct uart_port. The serial core calls rs485_config to do the device
+   specific part in response to TIOCSRS485 ioctl (see below). The
+   rs485_config callback receives a pointer to a sanitizated struct
+   serial_rs485. The struct serial_rs485 userspace provides is sanitized
+   before calling rs485_config using rs485_supported that indicates what
+   RS485 features the driver supports for the struct uart_port. TIOCGRS485
+   ioctl can be used to read back the struct serial_rs485 matching to the
+   current configuration.
 
 .. kernel-doc:: include/uapi/linux/serial.h
    :identifiers: serial_rs485 uart_get_rs485_mode
@@ -108,8 +109,8 @@ RS485 Serial Communications
 
    The Linux kernel provides addressing mode for multipoint RS-485 serial
    communications line. The addressing mode is enabled with SER_RS485_ADDRB
-   flag in serial_rs485. Struct serial_rs485 has two additional flags and
-   fields for enabling receive and destination addresses.
+   flag in struct serial_rs485. The struct serial_rs485 has two additional
+   flags and fields for enabling receive and destination addresses.
 
    Address mode flags:
 	- SER_RS485_ADDRB: Enabled addressing mode (sets also ADDRB in termios).
-- 
2.30.2

