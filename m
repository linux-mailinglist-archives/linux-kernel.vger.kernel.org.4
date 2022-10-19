Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2D6043BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJSLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiJSLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E456619C233;
        Wed, 19 Oct 2022 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178770; x=1697714770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rEYYlDIJLI+0frdDQYe75a4u653dFCn6f4t9c6SSqPc=;
  b=Dq1UtW5uNhpB82TnSJe0Wwbpi8PiKriBxhl6dylpvrwiLXtoVYdIjjH8
   0gPfSBhkV6l7JrE/crBNQtxF6wrLD2WwdLOCXzzNcwiaooHpUYeNqgW93
   jfO9MwFIrXmdOhqXebFVzebhcdMhkmIBtFr/7XjsaGvIN579jqfS2gkvr
   9DQfAvTttXztfUEC6IWzovYzcQinIodcz9IaLhHdEjOiVNRTdNIzW5GNN
   7WkLH8drFR20h9ax0M3z8BUBzsOwkQ7AXNN43Snf4ZT3gk6RqXJB/R0Ip
   jeUIJPAk8bLyjnR8PuEvjY16sMlSSEWcqAsqP4fHvICcowdhOaz8jatja
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392661891"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392661891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734127924"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734127924"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 3/5] Documentation: rs485: Mention uart_get_rs485_mode()
Date:   Wed, 19 Oct 2022 12:33:41 +0300
Message-Id: <20221019093343.9546-4-ilpo.jarvinen@linux.intel.com>
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

Add to rs485 documentation that serial core prepares the struct
serial_rs485 when uart_get_rs485_mode() is called. Remove the wrong
claim that the driver must fill it by itself.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/driver-api/serial/serial-rs485.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 513758a702a6..ee34c8e1e56e 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -34,8 +34,9 @@ RS485 Serial Communications
    parameters in the platform data and in ioctls.
 
    The device tree can also provide RS485 boot time parameters
-   [#DT-bindings]_. The driver is in charge of filling this data structure
-   from the values given by the device tree.
+   [#DT-bindings]_. The serial core fills the struct serial_rs485 from the
+   values given by the device tree when the driver calls
+   uart_get_rs485_mode().
 
    Any driver for devices capable of working both as RS232 and RS485 should
    implement the rs485_config callback and provide rs485_supported in the
@@ -48,7 +49,7 @@ RS485 Serial Communications
    serial_rs485 structure matching to the current configuration.
 
 .. kernel-doc:: include/uapi/linux/serial.h
-   :identifiers: serial_rs485
+   :identifiers: serial_rs485 uart_get_rs485_mode
 
 4. Usage from user-level
 ========================
-- 
2.30.2

