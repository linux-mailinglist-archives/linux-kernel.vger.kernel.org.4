Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA96043BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiJSLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJSLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3619B67B;
        Wed, 19 Oct 2022 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178770; x=1697714770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDkxUdt2JahFUf77AGEqjEY+CeposhXLpl0kIeK4m2o=;
  b=huGddRKGBlIobxOltBsBk0I4fA+/mfdPkpENu+1+oaqAlzBzsEa2l9WN
   RThC+67lxIbsTmBay7JfhxQFDPOQWIab09zG9q+sgN+kaf6bgMzYLEXKV
   OviYbu+MvnFRMOUwAcrOMj14CK5UbU2Bl/Y+vmn7P13hAsVwvhx98e+NC
   7FPCQdP9+zTl/+YEtJ4rJRBpclp9F97NK8CzV/f0jY4K0H1HkuMDjcSD/
   cBhJ09PtX4ylOozBpEKMwhRLsZsTHGqH/hnOu3Ki2+0MWZ1cSwu+M6jVh
   7M+eJI111Kc6946uoUhkm4Mv4keb42VW9khBPBYBqKUAoFdAYsaZ2KUQC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392661926"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392661926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734127975"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734127975"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 5/5] Documentation: Make formatting consistent for rs485 docs
Date:   Wed, 19 Oct 2022 12:33:43 +0300
Message-Id: <20221019093343.9546-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
References: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak styling of names that come directly from the code.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 37 ++++++++++---------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index e53aa291bcd7..dce061ef7647 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -39,15 +39,15 @@ RS485 Serial Communications
    uart_get_rs485_mode().
 
    Any driver for devices capable of working both as RS232 and RS485 should
-   implement the rs485_config callback and provide rs485_supported in the
-   struct uart_port. The serial core calls rs485_config to do the device
-   specific part in response to TIOCSRS485 ioctl (see below). The
-   rs485_config callback receives a pointer to a sanitizated struct
+   implement the ``rs485_config`` callback and provide ``rs485_supported``
+   in the ``struct uart_port``. The serial core calls ``rs485_config`` to do
+   the device specific part in response to TIOCSRS485 ioctl (see below). The
+   ``rs485_config`` callback receives a pointer to a sanitizated struct
    serial_rs485. The struct serial_rs485 userspace provides is sanitized
-   before calling rs485_config using rs485_supported that indicates what
-   RS485 features the driver supports for the struct uart_port. TIOCGRS485
-   ioctl can be used to read back the struct serial_rs485 matching to the
-   current configuration.
+   before calling ``rs485_config`` using ``rs485_supported`` that indicates
+   what RS485 features the driver supports for the ``struct uart_port``.
+   TIOCGRS485 ioctl can be used to read back the struct serial_rs485
+   matching to the current configuration.
 
 .. kernel-doc:: include/uapi/linux/serial.h
    :identifiers: serial_rs485 uart_get_rs485_mode
@@ -108,23 +108,24 @@ RS485 Serial Communications
 ========================
 
    The Linux kernel provides addressing mode for multipoint RS-485 serial
-   communications line. The addressing mode is enabled with SER_RS485_ADDRB
-   flag in struct serial_rs485. The struct serial_rs485 has two additional
-   flags and fields for enabling receive and destination addresses.
+   communications line. The addressing mode is enabled with
+   ``SER_RS485_ADDRB`` flag in struct serial_rs485. The struct serial_rs485
+   has two additional flags and fields for enabling receive and destination
+   addresses.
 
    Address mode flags:
-	- SER_RS485_ADDRB: Enabled addressing mode (sets also ADDRB in termios).
-	- SER_RS485_ADDR_RECV: Receive (filter) address enabled.
-	- SER_RS485_ADDR_DEST: Set destination address.
+	- ``SER_RS485_ADDRB``: Enabled addressing mode (sets also ADDRB in termios).
+	- ``SER_RS485_ADDR_RECV``: Receive (filter) address enabled.
+	- ``SER_RS485_ADDR_DEST``: Set destination address.
 
-   Address fields (enabled with corresponding SER_RS485_ADDR_* flag):
-	- addr_recv: Receive address.
-	- addr_dest: Destination address.
+   Address fields (enabled with corresponding ``SER_RS485_ADDR_*`` flag):
+	- ``addr_recv``: Receive address.
+	- ``addr_dest``: Destination address.
 
    Once a receive address is set, the communication can occur only with the
    particular device and other peers are filtered out. It is left up to the
    receiver side to enforce the filtering. Receive address will be cleared
-   if SER_RS485_ADDR_RECV is not set.
+   if ``SER_RS485_ADDR_RECV`` is not set.
 
    Note: not all devices supporting RS485 support multipoint addressing.
 
-- 
2.30.2

