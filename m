Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914BE6043AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJSLqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiJSLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDC166980;
        Wed, 19 Oct 2022 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178770; x=1697714770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTfXyABtrWPDgEHj2asTRfYPY8Q87jgv7IqP5hzhfFw=;
  b=Nsg/V9pQPRvMfW49rVnizPChvP0qw3RJxDDmM6POdjiqzRtAkLK3ehsR
   kCsirhN+YNNvSm2YmcoDe6sx2VrpRbIWBpmY8ZbXYyw35RkLFsQIstzif
   JTbhbAHxAf4wLl33y98cz0Fn2VYRCw2ulmMO0ZJLPVuNzGDz15r0EAaTf
   QCoQo7LZDkuZDytQgBs3nxX9+Pq/rQOAuU3BSvR9np7p3cnnHHTezel+M
   cM6yDNGZStXxb38zS/privpPtRvB/SR5FH5NNnpku3CJ+wZKQ8AZafKJg
   XHbKDXop1GklnY3pMHM7fXYNAOc3P7cpeKhbdyg3OkIwTxxepeGl1hEM5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392661911"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392661911"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734127951"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734127951"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 4/5] Documentation: rs485: Fix struct referencing
Date:   Wed, 19 Oct 2022 12:33:42 +0300
Message-Id: <20221019093343.9546-5-ilpo.jarvinen@linux.intel.com>
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

