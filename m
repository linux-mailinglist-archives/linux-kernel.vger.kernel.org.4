Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA36663FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjAJMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjAJMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:05:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F96A0D1;
        Tue, 10 Jan 2023 04:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352244; x=1704888244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YHJ7XJYN+KUzOObvnegnst5iBg+A0Jwn7PeQ7igs6pM=;
  b=EMgG4pPIOUOFG3bPBud++4wbxtE4nbQ8UD5673w9kXZr2jr2NEhgRdzp
   GPcL/cHr6JXRPNfzb7hJL0hkM4aCwHHjd+oG0j0fUwdOSOqzOyqCiQxja
   9PxMED5h8FpDiShPSBP6mG2dAVrIz7Lj8vrv/co7LyTMtLoNzIEnuXQjF
   +v0HhleKl96xz5tVEiBUOhhBFdq7dPzAeM4YgcnEd5pnOcS9vygSirxM7
   oiD99m2gP/nVkqj6VYIsuVjuw8sp43r9SdjHhciB11XnOybYogo1rP3o4
   PWlh+8klr9YSihUM6gNq4PlclbyNHecsEx2OHctXv0pzTvYARQHQD52Ue
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350307"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:04:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799407072"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799407072"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:04:00 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 12/13] tty: moxa: Rename dtr/rts parameters/variables to active
Date:   Tue, 10 Jan 2023 14:02:25 +0200
Message-Id: <20230110120226.14972-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
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

Use active consistently for naming parameters and variables.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/moxa.c | 52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 98e180f3a4ec..c2d717e64557 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1443,10 +1443,10 @@ static bool moxa_carrier_raised(struct tty_port *port)
 	return dcd;
 }
 
-static void moxa_dtr_rts(struct tty_port *port, bool onoff)
+static void moxa_dtr_rts(struct tty_port *port, bool active)
 {
 	struct moxa_port *ch = container_of(port, struct moxa_port, port);
-	MoxaPortLineCtrl(ch, onoff, onoff);
+	MoxaPortLineCtrl(ch, active, active);
 }
 
 
@@ -1557,14 +1557,14 @@ static unsigned int moxa_chars_in_buffer(struct tty_struct *tty)
 static int moxa_tiocmget(struct tty_struct *tty)
 {
 	struct moxa_port *ch = tty->driver_data;
-	bool dtr, rts;
+	bool dtr_active, rts_active;
 	int flag = 0;
 	int status;
 
-	MoxaPortGetLineOut(ch, &dtr, &rts);
-	if (dtr)
+	MoxaPortGetLineOut(ch, &dtr_active, &rts_active);
+	if (dtr_active)
 		flag |= TIOCM_DTR;
-	if (rts)
+	if (rts_active)
 		flag |= TIOCM_RTS;
 	status = MoxaPortLineStatus(ch);
 	if (status & 1)
@@ -1579,8 +1579,8 @@ static int moxa_tiocmget(struct tty_struct *tty)
 static int moxa_tiocmset(struct tty_struct *tty,
 			 unsigned int set, unsigned int clear)
 {
+	bool dtr_active, rts_active;
 	struct moxa_port *ch;
-	bool dtr, rts;
 
 	mutex_lock(&moxa_openlock);
 	ch = tty->driver_data;
@@ -1589,16 +1589,16 @@ static int moxa_tiocmset(struct tty_struct *tty,
 		return -EINVAL;
 	}
 
-	MoxaPortGetLineOut(ch, &dtr, &rts);
+	MoxaPortGetLineOut(ch, &dtr_active, &rts_active);
 	if (set & TIOCM_RTS)
-		rts = true;
+		rts_active = true;
 	if (set & TIOCM_DTR)
-		dtr = true;
+		dtr_active = true;
 	if (clear & TIOCM_RTS)
-		rts = false;
+		rts_active = false;
 	if (clear & TIOCM_DTR)
-		dtr = false;
-	MoxaPortLineCtrl(ch, dtr, rts);
+		dtr_active = false;
+	MoxaPortLineCtrl(ch, dtr_active, rts_active);
 	mutex_unlock(&moxa_openlock);
 	return 0;
 }
@@ -1881,10 +1881,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *      Syntax:
  *      int  MoxaPortGetLineOut(int port, int *dtrState, int *rtsState);
  *           int port           : port number (0 - 127)
- *           bool * dtrState    : pointer to bool to receive the current DTR
+ *           bool * dtr_active  : pointer to bool to receive the current DTR
  *                                state. (if NULL, this function will not
  *                                write to this address)
- *           bool * rtsState    : pointer to bool to receive the current RTS
+ *           bool * rts_active  : pointer to bool to receive the current RTS
  *                                state. (if NULL, this function will not
  *                                write to this address)
  *
@@ -1896,8 +1896,8 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *      Syntax:
  *      void MoxaPortLineCtrl(int port, bool dtrState, bool rtsState);
  *           int port           : port number (0 - 127)
- *           bool dtrState      : DTR output state (0: off, 1: on)
- *           bool rtsState      : RTS output state (0: off, 1: on)
+ *           bool dtr_active    : DTR output state
+ *           bool rts_active    : RTS output state
  *
  *
  *      Function 15:    Setting the flow control of this port.
@@ -2105,24 +2105,24 @@ static int MoxaPortSetTermio(struct moxa_port *port, struct ktermios *termio,
 	return baud;
 }
 
-static int MoxaPortGetLineOut(struct moxa_port *port, bool *dtrState,
-		bool *rtsState)
+static int MoxaPortGetLineOut(struct moxa_port *port, bool *dtr_active,
+		bool *rts_active)
 {
-	if (dtrState)
-		*dtrState = port->lineCtrl & DTR_ON;
-	if (rtsState)
-		*rtsState = port->lineCtrl & RTS_ON;
+	if (dtr_active)
+		*dtr_active = port->lineCtrl & DTR_ON;
+	if (rts_active)
+		*rts_active = port->lineCtrl & RTS_ON;
 
 	return 0;
 }
 
-static void MoxaPortLineCtrl(struct moxa_port *port, bool dtr, bool rts)
+static void MoxaPortLineCtrl(struct moxa_port *port, bool dtr_active, bool rts_active)
 {
 	u8 mode = 0;
 
-	if (dtr)
+	if (dtr_active)
 		mode |= DTR_ON;
-	if (rts)
+	if (rts_active)
 		mode |= RTS_ON;
 	port->lineCtrl = mode;
 	moxafunc(port->tableAddr, FC_LineControl, mode);
-- 
2.30.2

