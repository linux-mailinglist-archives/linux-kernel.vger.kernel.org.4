Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E291665DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjAKOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbjAKOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:25:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4921E5F44;
        Wed, 11 Jan 2023 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447099; x=1704983099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azs8MhAXaT8ciQ/+X9QDrSPGZ0tpeX4mV+5vi33IK0c=;
  b=a+oRc5VazYi5a98TMWzjIneynLMgh7eJdRPstXuW4i3hvdb88RLqlLS6
   WUjXwWgCV0tA/wDwzMRICIvUosMNh4dBzE1SXSjFYMdDKzCmnGYakTOAl
   3m7r2ZmfATG8EE7wqAFs0BXs8PXnM1Mcl7p06Fle510B6HaLtB3wJ9pPY
   oclbgqqhq3fon1JRMDeO4QvSSC14X1CocZwT9jveLT1jcaOlz6SSwJCpS
   CHkaJ6QSZYb7yFzFTAA/Z7oZtdg8Gck7/2pyAcs606aPZwlCeHD3bttWw
   erwgA6jDUm9zy+CS/zIltqFK/Qxkm36wTwiXQK2ou+VokhywjjwccFe2x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793796"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793796"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607382106"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607382106"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:55 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 12/13] tty: moxa: Rename dtr/rts parameters/variables to active
Date:   Wed, 11 Jan 2023 16:23:30 +0200
Message-Id: <20230111142331.34518-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
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

Use active consistently for naming parameters and variables.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/moxa.c | 52 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 9be3d585d5a9..42fa4c878b2e 100644
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
  *      int  MoxaPortGetLineOut(int port, bool *dtrState, bool *rtsState);
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
- *           bool dtrState      : DTR output state
- *           bool rtsState      : RTS output state
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

