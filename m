Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A41638AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKYNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKYNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:05:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6262A95A;
        Fri, 25 Nov 2022 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669381528; x=1700917528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0HfKkgykKh/w7L9JZtBdMwCI7ryGACxBBLi2kGimSAk=;
  b=C2VP7sqw9puitksVBdsz1CMT3lpGmx6frpeROSbUDcfTgvRE+cuCLC7G
   3V0w7+FRqgHm1iVEnWgmYZFLBLihxipep/hRs7swN8z/s972lkzeKT4L8
   h2jFJS6+EG9q0GVQUMPRf69afqDt5YXEC66kB00sB1I6a62a6J4uY6csB
   jR/vGj7Epx1lO2IV4d06C8zyMmVmKl4p3g1ZRNaDueE4X3qWLjvL/Fxut
   1RuSS6qEdzt8SRpBdQKiVsofQBf06Mc7r8ldm+v1I5dV25F+HfW9lQ7jK
   vjsPi33bGnaSjFxY6vFirTjss+zZrMYmScgneIKTMw83zMUG/0RVwWkwd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316300781"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="316300781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="706064030"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="706064030"
Received: from dpotapen-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.50.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 05:05:26 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/6] serial: 8250: Cleanup MCR literals
Date:   Fri, 25 Nov 2022 15:05:06 +0200
Message-Id: <20221125130509.8482-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221125130509.8482-1-ilpo.jarvinen@linux.intel.com>
References: <20221125130509.8482-1-ilpo.jarvinen@linux.intel.com>
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

