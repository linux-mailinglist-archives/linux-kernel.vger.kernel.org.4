Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B965EDB54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiI1LI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI1LH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309A1056E;
        Wed, 28 Sep 2022 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363136; x=1695899136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kx0xx0yaAJao4xf0ctQT3/HbaRIhy4fWhiLbvdNtdpU=;
  b=ELCs55gTEAdJmpb/DIiJqS4GYa63GlGt5QEbWyXSlBXpbOK1AN/gUy86
   OxNZ3jgMW6XLtjcoGuMAykt9epU56r31+L+wyC/ScGyOnEBE71FAxkFE6
   cIAZrZNYtG+43Q6tniTcdVBAWQWoLlx/3W043Zjk1zz6bvCRVFztJgAlG
   ioYTe0y7U0AKRdHnYnajpjEemKbfFFNQ/fBpPwDURqK0KVLmd10z5sb6f
   723l6SE+bGXLTnOkWtmLew60ciKLMZQNpl5cR3mzSU2v3rXkDWm9shFhD
   ei5JnYaUjzK/oDe9hID7J7P5D6b+kqmZ07CCfRIrrHZQafYrsXoiB++q3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301548729"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="301548729"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="624110600"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="624110600"
Received: from kjurkiew-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 4/4] Documentation: rs485: Fix struct referencing
Date:   Wed, 28 Sep 2022 14:05:09 +0300
Message-Id: <20220928110509.13544-5-ilpo.jarvinen@linux.intel.com>
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

Use "struct serial_rs485" to get the references properly recognized.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../driver-api/serial/serial-rs485.rst        | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 2951dacfb9eb..d902f9de0b0f 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -29,7 +29,7 @@ RS485 Serial Communications
 3. Data Structures Already Available in the Kernel
 ==================================================
 
-   The Linux kernel provides the serial_rs485 structure to handle RS485
+   The Linux kernel provides the struct serial_rs485 to handle RS485
    communications. This data structure is used to set and configure RS485
    parameters in the platform data and in ioctls.
 
@@ -39,13 +39,14 @@ RS485 Serial Communications
 
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
@@ -107,8 +108,8 @@ RS485 Serial Communications
 
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

