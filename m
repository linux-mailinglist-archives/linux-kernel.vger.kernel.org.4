Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50876FB163
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjEHNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjEHNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:21:33 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200737025
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:21:17 -0700 (PDT)
X-ASG-Debug-ID: 1683552059-086e237e536e4c0004-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id EFJRcdrH2v7v4A03 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 08 May 2023 21:21:01 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 21:20:59 +0800
Received: from L440.zhaoxin.com (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 8 May
 2023 21:20:58 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   Weitao Wang <WeitaoWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <WeitaoWang@zhaoxin.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v4 3/4] xhci: Show ZHAOXIN xHCI root hub speed correctly
Date:   Tue, 9 May 2023 05:20:57 +0800
X-ASG-Orig-Subj: [PATCH v4 3/4] xhci: Show ZHAOXIN xHCI root hub speed correctly
Message-ID: <20230508212058.6307-4-WeitaoWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
References: <20230508212058.6307-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.8.21]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1683552060
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 4438
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.108487
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
        3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ZHAOXIN xHCI controllers follow usb3.1 spec,
but only support gen1 speed 5Gbps. While in Linux kernel,
if xHCI suspport usb3.1, root hub speed will show on 10Gbps.
To fix this issue of ZHAOXIN xHCI platforms, read usb speed ID
supported by xHCI to determine root hub speed. And add a quirk
XHCI_ZHAOXIN_HOST for this issue.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
 drivers/usb/host/xhci-mem.c | 30 +++++++++++++++++++++++-------
 drivers/usb/host/xhci-pci.c |  2 ++
 drivers/usb/host/xhci.h     |  1 +
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 1532414c8c40..0634fba01ac8 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1968,7 +1968,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -1988,6 +1988,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		 */
 		if (minor_revision > 0x00 && minor_revision < 0x10)
 			minor_revision <<= 4;
+		/*
+		 * Some zhaoxin's xHCI controller that follow usb3.1 spec
+		 * but only support Gen1.
+		 */
+		if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+			tmp_minor_revision = minor_revision;
+			minor_revision = 0;
+		}
+
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
@@ -1996,10 +2005,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2017,8 +2022,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2039,6 +2042,10 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
 				port_cap->psi_uid_count++;
 
+			if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
+					XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
+				minor_revision = tmp_minor_revision;
+
 			xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
 				  XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
@@ -2048,6 +2055,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
 		}
 	}
+
+	rhub->maj_rev = major_revision;
+
+	if (rhub->min_rev < minor_revision)
+		rhub->min_rev = minor_revision;
+
+	port_cap->maj_rev = major_revision;
+	port_cap->min_rev = minor_revision;
+
 	/* cache usb2 port capabilities */
 	if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
 		xhci->ext_caps[xhci->num_ext_caps++] = temp;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3dfb3e0c910b..4a025ed50686 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -528,6 +528,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 41c38bfd7348..3737510b5981 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1906,6 +1906,7 @@ struct xhci_hcd {
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.32.0

