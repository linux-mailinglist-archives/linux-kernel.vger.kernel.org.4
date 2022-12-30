Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B46597DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiL3Lqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiL3LqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:46:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB6162DC;
        Fri, 30 Dec 2022 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672400780; x=1703936780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pRn7tKtyQDsfv1krVYAXZzmvcjDEgr9X9ccC6JVXzQ=;
  b=I03CfHpTsNts1Ihq4pJxv3TnsTKYZMyH7CR/5bR2vJJJHEgAVxKmAlHJ
   d+fKbK1KEB9UfQlwLo44oeqJPWDvbpqpjzZWMYNSaeNlPJyg4ssJWawNB
   IenkEmBPOu3EQz5b854XWxIotDSgMTRoNtelQgNoJgt5N0Uuh4VRuJPQS
   wZy8DYrHC2vTwtlGbUV3hAIw/W7MEzsuPfX2kQ1e/jae9wLdnXYNbbslS
   ru+1qtVsc10DauYw7hKsQIFv7gDOVc4TyEXSO4D5XIRxIULMYgEc9ilfH
   dmEwkv9Xss6onN9GxfBLS0b69uQ0/SGQaZCAeFmPNgOJ59P1qqcXc8mNa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="301568009"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="301568009"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="653865358"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="653865358"
Received: from vsemouch-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:17 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] serial: 8250_rt288x: Name non-standard divisor latch reg
Date:   Fri, 30 Dec 2022 13:46:02 +0200
Message-Id: <20221230114603.16946-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
References: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index cb9a86bd3a07..3015afb99722 100644
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
 static int au_serial_dl_read(struct uart_8250_port *up)
 {
-	return __raw_readl(up->port.membase + 0x28);
+	return __raw_readl(up->port.membase + RT288X_DL);
 }
 
 static void au_serial_dl_write(struct uart_8250_port *up, int value)
 {
-	__raw_writel(value, up->port.membase + 0x28);
+	__raw_writel(value, up->port.membase + RT288X_DL);
 }
 
 int au_platform_setup(struct plat_serial8250_port *p)
-- 
2.30.2

