Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13168F1BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjBHPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBHPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:14:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDC16ADD;
        Wed,  8 Feb 2023 07:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869297; x=1707405297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qdeP526/pU66HQlswFPVV6tWqeMSCXdda5mdSvOrkgw=;
  b=oFbrVtI8+JVq8BKRDV2YKFPjO2JtjdZsHqsjNw/LHhUZDZJ1zBGm8sYv
   zEKuuoeOzoXJIsBKYJBiWFu8qLeZelOoUMFBma+GEXklT+qnf3j6DZE9n
   ZZ/yR4xQQ7OA7Tum9NrJ9dk3TKs+diKMtiqr2Fww/L1LC15OA6+Phcn4U
   PqNjPI0bJwAyNEX5KTQa9IvsXR24eE0JxAscX55vQ9o7uj4gdBM0Fb4cs
   Eq/PwfYvkTTsEt6bpc0RX69f4L1SjqAtvKc1ijuBp/lG9T/GNxUdUdVBH
   xegJgOOEcwVnZfspSNP5tHOHi7zMBO/tJyLYC6aqdqzX1rfL9+LoaU7Zm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357218239"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357218239"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730898827"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730898827"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 07:10:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2878337D; Wed,  8 Feb 2023 17:11:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 7/7] xhci: mem: Join string literals back
Date:   Wed,  8 Feb 2023 17:11:29 +0200
Message-Id: <20230208151129.28987-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
References: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 67ac02d177b5..7e106bd804ca 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -607,8 +607,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 	int ret;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
-	xhci_dbg(xhci, "Allocating %u streams and %u "
-			"stream context array entries.\n",
+	xhci_dbg(xhci, "Allocating %u streams and %u stream context array entries.\n",
 			num_streams, num_stream_ctxs);
 	if (xhci->cmd_ring_reserved_trbs == MAX_RSVD_CMD_TRBS) {
 		xhci_dbg(xhci, "Command ring has no reserved TRBs available\n");
@@ -1950,8 +1949,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci, struct xhci_interrupter
 	deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
 			ir->event_ring->dequeue);
 	if (!deq)
-		xhci_warn(xhci, "WARN something wrong with SW event ring "
-				"dequeue ptr.\n");
+		xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr.\n");
 	/* Update HC event ring dequeue pointer */
 	temp = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
 	temp &= ERST_PTR_MASK;
@@ -1960,8 +1958,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci, struct xhci_interrupter
 	 */
 	temp &= ~ERST_EHB;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Write event ring dequeue pointer, "
-			"preserving EHB bit");
+		       "// Write event ring dequeue pointer, preserving EHB bit");
 	xhci_write_64(xhci, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
 			&ir->ir_set->erst_dequeue);
 }
@@ -1994,8 +1991,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
-		xhci_warn(xhci, "Ignoring unknown port speed, "
-				"Ext Cap %p, revision = 0x%x\n",
+		xhci_warn(xhci, "Ignoring unknown port speed, Ext Cap %p, revision = 0x%x\n",
 				addr, major_revision);
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
@@ -2010,9 +2006,8 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	port_offset = XHCI_EXT_PORT_OFF(temp);
 	port_count = XHCI_EXT_PORT_COUNT(temp);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"Ext Cap %p, port offset = %u, "
-			"count = %u, revision = 0x%x",
-			addr, port_offset, port_count, major_revision);
+		       "Ext Cap %p, port offset = %u, count = %u, revision = 0x%x",
+		       addr, port_offset, port_count, major_revision);
 	/* Port count includes the current port offset */
 	if (port_offset == 0 || (port_offset + port_count - 1) > num_ports)
 		/* WTF? "Valid values are ‘1’ to MaxPorts" */
@@ -2069,10 +2064,8 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		struct xhci_port *hw_port = &xhci->hw_ports[i];
 		/* Duplicate entry.  Ignore the port if the revisions differ. */
 		if (hw_port->rhub) {
-			xhci_warn(xhci, "Duplicate port entry, Ext Cap %p,"
-					" port %u\n", addr, i);
-			xhci_warn(xhci, "Port was marked as USB %u, "
-					"duplicated as USB %u\n",
+			xhci_warn(xhci, "Duplicate port entry, Ext Cap %p, port %u\n", addr, i);
+			xhci_warn(xhci, "Port was marked as USB %u, duplicated as USB %u\n",
 					hw_port->rhub->maj_rev, major_revision);
 			/* Only adjust the roothub port counts if we haven't
 			 * found a similar duplicate.
@@ -2411,8 +2404,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	val = readl(&xhci->cap_regs->db_off);
 	val &= DBOFF_MASK;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Doorbell array is located at offset 0x%x"
-			" from cap regs base addr", val);
+		       "// Doorbell array is located at offset 0x%x from cap regs base addr",
+		       val);
 	xhci->dba = (void __iomem *) xhci->cap_regs + val;
 	/* Set ir_set to interrupt register set 0 */
 
-- 
2.39.1

