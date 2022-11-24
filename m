Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9D637994
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiKXNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKXNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35DBE852;
        Thu, 24 Nov 2022 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294817; x=1700830817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xoDJ24ls7xPY5orIQfBql47gNQpE19TZHADmQ5loEY=;
  b=L8aF/+CskeiJXn+vtG4SarKq/GIC0uST8E8YhW8Dm4OMvrH/1tWMt8d7
   yhGg1npnt+Mk6DOUVaKHeFM0A0sL25D7hZCFwGXqM497dLkFU72WIw2Uj
   KOUcqMJW4epFbQS0o7sp1MbSbjpdofImfDtNcuptzEoVFbmc75130Xa+N
   zMF6lk2Pjmi7cw7LHp3FR1vFUy9/VwO9n0KjwfK+Ou4FBxHe4PUw/mTMz
   LtCOt2ZOl4dmOXZj7Se4EPgmBD+Jh6wFqKif44+YMCWzh7xo3Slew1W0g
   Z1mH9sS0LSCG7iifEab+kPpYIImuI3+Kr83hVfcgfaKaMx96zDQANJbav
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932121"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932121"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367724"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367724"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:16 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/6] serial: 8250_early: Convert literals to use defines
Date:   Thu, 24 Nov 2022 14:59:48 +0200
Message-Id: <20221124125948.23432-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
References: <20221124125948.23432-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use existing defines for the serial register values in 8250_early.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_early.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index f271becfc46c..0ebde0ab8167 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -136,11 +136,11 @@ static void __init init_port(struct earlycon_device *device)
 	unsigned char c;
 	unsigned int ier;
 
-	serial8250_early_out(port, UART_LCR, 0x3);	/* 8n1 */
+	serial8250_early_out(port, UART_LCR, UART_LCR_WLEN8);		/* 8n1 */
 	ier = serial8250_early_in(port, UART_IER);
 	serial8250_early_out(port, UART_IER, ier & UART_IER_UUE); /* no interrupt */
 	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
-	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
+	serial8250_early_out(port, UART_MCR, UART_MCR_DTR | UART_MCR_RTS);
 
 	if (port->uartclk) {
 		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
-- 
2.30.2

