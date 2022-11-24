Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A263798F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKXNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiKXNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:00:17 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983499E966;
        Thu, 24 Nov 2022 05:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669294809; x=1700830809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0HfKkgykKh/w7L9JZtBdMwCI7ryGACxBBLi2kGimSAk=;
  b=i01mvkmhRq0kSMs62yczCpLBXefEhY4MD446cCJv/mlOELiyNHVCNvej
   8Z3lvoNI0FP2f4UuL0tFb2B3lR87ASxe2sHTr8JB9ztYhV93F2+4cHXOi
   UVq25ydeL8yNRW4K7zrT0oSDUVihEvXQEq9Bv2pRqyTbE7j0l+USTs+2I
   Vm59LqGDeMJqqb1kYSpWa88OfDTj0aDTKTqMYZvJTSIEbe+kVSmmqnF5c
   nVPFWZBEj4GKNqIalwFCd9KE/KZ+pXFTt/eiV/h4wCIWAPw19HdhekxN5
   T4Nj5nLegNs5zJhPak4WCczneDkvZUe3gnS1sLoKHXhll+lGJcnAIqTq6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="311932073"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311932073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887367616"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="887367616"
Received: from msharawy-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:00:07 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/6] serial: 8250: Cleanup MCR literals
Date:   Thu, 24 Nov 2022 14:59:45 +0200
Message-Id: <20221124125948.23432-4-ilpo.jarvinen@linux.intel.com>
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

Use proper names from MCR bits.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c870ee8e80b6..e79bf2afd9be 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1267,7 +1267,7 @@ static void autoconfig(struct uart_8250_port *up)
 	 * that conflicts with COM 1-4 --- we hope!
 	 */
 	if (!(port->flags & UPF_SKIP_TEST)) {
-		serial8250_out_MCR(up, UART_MCR_LOOP | 0x0A);
+		serial8250_out_MCR(up, UART_MCR_LOOP | UART_MCR_OUT2 | UART_MCR_RTS);
 		status1 = serial_in(up, UART_MSR) & UART_MSR_STATUS_BITS;
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != (UART_MSR_DCD | UART_MSR_CTS)) {
-- 
2.30.2

