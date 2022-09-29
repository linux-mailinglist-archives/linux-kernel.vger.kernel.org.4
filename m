Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418765EF21E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiI2JdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiI2Jcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB37FFA4;
        Thu, 29 Sep 2022 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443931; x=1695979931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rEYYlDIJLI+0frdDQYe75a4u653dFCn6f4t9c6SSqPc=;
  b=ndRbH1m8dP7CZ0tW4/MrPU23wdCufbSliDq4vR7RNFKiutMoZFWWZb74
   tO/r4l1kwTfP1YmP5pkyT2KdoVdvUPA8iMtnThDzPHLq+tZYufu/qQrNU
   3+BbRelweqDeg2IkXrO0YVOLa0AuWPg0DGf3TW9IJN+6OaeCznbbegRf5
   9lbaBIUbdkO3A5N38HTtnu58XHXtrlPhNheAauCr9WCPpwt4pzJbWZoPI
   xAv4sC1TlvzA6SdmVUeuY4GTna7z8h1GmavfH8eSOXUrxBuBRpAt9so7W
   KNA8CkSuc1gw3YiMpQSp8Ajpj81qbE0NANGVXURFEMzUhdudZNQeTrNHo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299444141"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="299444141"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867320101"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867320101"
Received: from pramona-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.60.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/4] Documentation: rs485: Mention uart_get_rs485_mode()
Date:   Thu, 29 Sep 2022 12:31:47 +0300
Message-Id: <20220929093148.9468-4-ilpo.jarvinen@linux.intel.com>
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

