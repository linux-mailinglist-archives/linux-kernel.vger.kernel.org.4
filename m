Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9730468C297
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBFQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBFQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019B125B6;
        Mon,  6 Feb 2023 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699819; x=1707235819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJFH/WlOhkFgGSBJXUCYwVXj90asZQUB6q0OWxQtULM=;
  b=K/lX8rOrXlC6p4LlBFDVXzGvCduIiCbMpMvwLjJBsGqR/1Ai/e6CvhIW
   LYKjDR4k1rstAQPE2IMiPkEOmy+coqmOpEKlHW/b5ZazX8X8ecn6eXe3F
   t+YvD4au37FjnqbaXi0Cm/wvR9g+muacrOKB7KiasdWwzKD68+bQ9v/wk
   C9Hb5fe4WewVFiVFFjm764W5NXlEcRzc0xu5DICR4Ewesp/xu2577hKpk
   KcLVFy5HXs6UARWNktt4U6b0UUulHxjk9IffeNdDqSus2x/LJxAlKouZV
   essv32YoVBRwuYJUSNOTLxYWi1mExWBfXUD/ugpmNWJpkuqSyQNbD3C7u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327877020"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327877020"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644084675"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644084675"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 08:10:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 910C937D; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/7] xhci: mem: Join string literals back
Date:   Mon,  6 Feb 2023 18:10:49 +0200
Message-Id: <20230206161049.13972-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
References: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
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

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-mem.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fef74e7c20fc..9bdf2ed85772 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -609,8 +609,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 	int ret;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
-	xhci_dbg(xhci, "Allocating %u streams and %u "
-			"stream context array entries.\n",
+	xhci_dbg(xhci, "Allocating %u streams and %u stream context array entries.\n",
 			num_streams, num_stream_ctxs);
 	if (xhci->cmd_ring_reserved_trbs == MAX_RSVD_CMD_TRBS) {
 		xhci_dbg(xhci, "Command ring has no reserved TRBs available\n");
@@ -1952,8 +1951,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci, struct xhci_interrupter
 	deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
 			ir->event_ring->dequeue);
 	if (!deq)
-		xhci_warn(xhci, "WARN something wrong with SW event ring "
-				"dequeue ptr.\n");
+		xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr.\n");
 	/* Update HC event ring dequeue pointer */
 	temp = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
 	temp &= ERST_PTR_MASK;
@@ -1962,8 +1960,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci, struct xhci_interrupter
 	 */
 	temp &= ~ERST_EHB;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Write event ring dequeue pointer, "
-			"preserving EHB bit");
+		       "// Write event ring dequeue pointer, preserving EHB bit");
 	xhci_write_64(xhci, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
 			&ir->ir_set->erst_dequeue);
 }
@@ -1996,8 +1993,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
-		xhci_warn(xhci, "Ignoring unknown port speed, "
-				"Ext Cap %p, revision = 0x%x\n",
+		xhci_warn(xhci, "Ignoring unknown port speed, Ext Cap %p, revision = 0x%x\n",
 				addr, major_revision);
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
@@ -2012,9 +2008,8 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
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
@@ -2071,10 +2066,8 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
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
@@ -2413,8 +2406,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
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

