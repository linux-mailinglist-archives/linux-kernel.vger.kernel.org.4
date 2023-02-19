Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF569BEB9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 06:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBSF55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 00:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBSF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 00:57:55 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00B3C09;
        Sat, 18 Feb 2023 21:57:52 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id t2so774055ilf.1;
        Sat, 18 Feb 2023 21:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVRPpzSypX40rTpdqwPh6zh2FTOMHkGQku87OydX7WE=;
        b=oCNIOKw3KbuDBik7S9WPy+9DkwwNBFq1dRQkjoQof221UefNSluQ3WGuPWlN9fBtSv
         MLyslu93RvuMtrJ/FCzMkgRdtqsm8R3ZMImCalsdtxnGnoSMWl0qBZux7wCrC2ktmFFN
         AneraCQ2qt+iHBhN5tBFWO/0OCYLMkaTVFp0rJW8DFMUQXPeAPsoE2hU/2JpcgQ9IgRD
         PWexWQUHYT2YtdbcpgNZx1aenQ2DhkBD2Vl5j792ZHCe8Zdp3GTcOjd4xOfyVGA9OMXC
         1VquM7PtgsHDGX8VvUMBuxm1VAGpzNAf14hO6uYLDU0oIdMWwZ5V1G12kJEkvjyvx94v
         wHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVRPpzSypX40rTpdqwPh6zh2FTOMHkGQku87OydX7WE=;
        b=xw+IBej04F4DLBQSwkoVD2DsJVSWkpFC3hkVnp5PNssUJDNSXzWfPOzNgxvSmr2poA
         ZqVtBRWfEfwOo8362+rl/gVtzv35aKSBBSmYeJuaiyyhy+8wwHYjmI7sHo3uotmylRqq
         tUp1VEs3vNY8kDpFDcm4QMdr5htWyMU8dhDManyvAedG3G2+IvDi0Ny7Z4UqxfzhweUL
         BDSQyYTARzdlvy+mRF19Q2Dn9A+S1LdLYmV3/aa1Fav9XX7Ebdq9VD73aTzgS/igtPPd
         zo4JJJHkFfBx2rukvPBLg2D3IIAVIoy/NW1MuRm0EseKmq2rSdRdGbaH6AOSj0u4x2Bi
         UnGQ==
X-Gm-Message-State: AO0yUKWEDWHgh5f6ILxss0ST8rSMOgpFHgLHb1tgalZuE8Hha/rpuPck
        L937AFxrdmrDk0IuAccYWzWX61xOHw66Ng==
X-Google-Smtp-Source: AK7set/u+ywZnXrWcm9NCYf21MfncQ6V+kkYQPDtwAy0Xh8ueBKhvaMaKnSYu9Dihvliw3i2VBfV/w==
X-Received: by 2002:a92:7602:0:b0:315:29ff:da7f with SMTP id r2-20020a927602000000b0031529ffda7fmr1514180ilc.11.1676786271633;
        Sat, 18 Feb 2023 21:57:51 -0800 (PST)
Received: from localhost.localdomain (bras-base-toroon4321w-grc-52-76-71-25-91.dsl.bell.ca. [76.71.25.91])
        by smtp.gmail.com with ESMTPSA id g6-20020a02b706000000b003a068d00373sm2849757jam.138.2023.02.18.21.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 21:57:51 -0800 (PST)
From:   Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: jsm: fix style issues
Date:   Sun, 19 Feb 2023 00:57:44 -0500
Message-Id: <20230219055746.15298-1-mohammadmahfoozpersonal@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use min_t instead of min to improve type safety.

While at it, replace neo_parse_modem (hard-coded function name) with __func__.

Also fix minor styling issues, like removing redundant return statement in void function.

Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 0c78f66276cd..d4451fe06d99 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -29,7 +29,7 @@ static u32 jsm_offset_table[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x8
  */
 static inline void neo_pci_posting_flush(struct jsm_board *bd)
 {
-      readb(bd->re_map_membase + 0x8D);
+     readb(bd->re_map_membase + 0x8D);
 }
 
 static void neo_set_cts_flow_control(struct jsm_channel *ch)
@@ -350,7 +350,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 * IBM pSeries platform.
 		 * 15 bytes max appears to be the magic number.
 		 */
-		n = min((u32) n, (u32) 12);
+		n = min_t(u32, n, 12);
 
 		/*
 		 * Since we are grabbing the linestatus register, which
@@ -433,7 +433,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		/*
 		 * If our queue is full, we have no choice but to drop some data.
 		 * The assumption is that HWFLOW or SWFLOW should have stopped
-		 * things way way before we got to this point.
+		 * things way before we got to this point.
 		 *
 		 * I decided that I wanted to ditch the oldest data first,
 		 * I hope thats okay with everyone? Yes? Good.
@@ -560,8 +560,8 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 	u8 msignals = signals;
 
 	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
-		"neo_parse_modem: port: %d msignals: %x\n",
-		ch->ch_portnum, msignals);
+	"%s: port: %d msignals: %x\n",
+	__func__, ch->ch_portnum, msignals);
 
 	/* Scrub off lower bits. They signify delta's, which I don't care about */
 	/* Keep DDCD and DDSR though */
@@ -592,7 +592,7 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
 		ch->ch_mistat &= ~UART_MSR_CTS;
 
 	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
-		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d " "RI: %d CD: %d\n",
+		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d RI: %d CD: %d\n",
 		ch->ch_portnum,
 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_DTR),
 		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_RTS),
@@ -770,9 +770,9 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 			spin_lock_irqsave(&ch->ch_lock, lock_flags);
 			if (cause == UART_17158_XON_DETECT) {
 				/* Is output stopped right now, if so, resume it */
-				if (brd->channels[port]->ch_flags & CH_STOP) {
+				if (brd->channels[port]->ch_flags & CH_STOP)
 					ch->ch_flags &= ~(CH_STOP);
-				}
+
 				jsm_dbg(INTR, &ch->ch_bd->pci_dev,
 					"Port %d. XON detected in incoming data\n",
 					port);
@@ -1067,7 +1067,6 @@ static void neo_param(struct jsm_channel *ch)
 
 	/* Get current status of the modem signals now */
 	neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
-	return;
 }
 
 /*
@@ -1147,7 +1146,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 		case UART_17158_RXRDY_TIMEOUT:
 			/*
 			 * RXRDY Time-out is cleared by reading data in the
-			* RX FIFO until it falls below the trigger level.
+			 * RX FIFO until it falls below the trigger level.
 			 */
 
 			/* Verify the port is in range. */
-- 
2.34.1

