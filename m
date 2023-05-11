Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD94E6FF13D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjEKMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbjEKMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:12:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06593EB;
        Thu, 11 May 2023 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807102; x=1715343102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwhV8nJQahvCRqX3BBXXU6mZDO9OAAZ3tyuB/BORaYY=;
  b=TGbfwpxO9/EBJZCX7lMjgxM5ncAMiVw+da+yfj3cwVUhrnVBA5s6BR05
   saxhmkod4oMNVUludAd4VBs/1krmxfcQsfzvcEbQwq4WMJzishc2wBczh
   boB9prh/znIjEPsYWvwl5oq3oENVqE9/wsLTHuC3DRSn4ozCRkTQ7CLOL
   lNzHuJm4/kHINzJlL0rpx3KndOymMLWXY2bvpQ/hocxlJi+BBdkgRsFN+
   Vv88S4p4l7K20sjrSKqKrNPQXLxXGYDE9DP9Dzs5EUoNQoNAv9302Niwy
   l6wzDP9flx2h2s87PpUyQFNIYCgDsb9reYQl2zR862jNoL3FxknMVyZGx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839372"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921370"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921370"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/6] serial: 8250_rt288x: Name non-standard divisor latch reg
Date:   Thu, 11 May 2023 15:10:28 +0300
Message-Id: <20230511121029.13128-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
References: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of a literal, add proper name for the non-standard divisor
latch register.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_rt288x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index 51b1cf5476dd..b091a1269bfa 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -12,6 +12,8 @@
 
 #include "8250.h"
 
+#define RT288X_DL	0x28
+
 #define UART_REG_UNMAPPED	-1
 
 /* Au1x00/RT288x UART hardware has a weird register layout */
@@ -60,12 +62,12 @@ static void au_serial_out(struct uart_port *p, int offset, int value)
 /* Au1x00 haven't got a standard divisor latch */
 static u32 au_serial_dl_read(struct uart_8250_port *up)
 {
-	return __raw_readl(up->port.membase + 0x28);
+	return __raw_readl(up->port.membase + RT288X_DL);
 }
 
 static void au_serial_dl_write(struct uart_8250_port *up, u32 value)
 {
-	__raw_writel(value, up->port.membase + 0x28);
+	__raw_writel(value, up->port.membase + RT288X_DL);
 }
 
 int au_platform_setup(struct plat_serial8250_port *p)
-- 
2.30.2

