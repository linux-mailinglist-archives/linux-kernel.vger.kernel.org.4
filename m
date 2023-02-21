Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDC69D7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjBUBD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBUBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:03:58 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2E1D93B;
        Mon, 20 Feb 2023 17:03:57 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id u6so1069221ilk.12;
        Mon, 20 Feb 2023 17:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSoAw1HAKXRXOgJTEME+O4818u/LTQvYW/6HrMBUD+I=;
        b=XDEwTO+JGDej4hjSXoHQjZu2iP121FogSD2B1wPt2x9fOxRn/vSYiSHmYMVS+2MowE
         cEbXM4taPto8BKWrFvMRQNUcYu6Q+bYVmLmfULueZh5FyFgzGaqIiYSOd4iCM4YMemF4
         SqiNUyqzWJibIPUJb/Zbzkeiwk1PJb1rapYP6wzySxHuGgw0QzNWRZOTnuQSPsYr5OCT
         DqEG51/HSvnzbzUpDOBXi8+TCVoREEO8Ah5ymxv//tvLCsK2zWow7jSsVOwWzm9dKLTD
         Bbrf4CT/8G0GqFAzeJnZhCSPppbrZzkouuI70Ll4rMk885QgPW57p23vv5b4Rjq75UQX
         rNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSoAw1HAKXRXOgJTEME+O4818u/LTQvYW/6HrMBUD+I=;
        b=rHl4q9/vX380jrzL827y/edvazNPhGdLGONHlslgvBuHN0Bw+3uUBF3DgDPcHkNp3i
         g8sLsKMwxU4eqB4cuKTHCN7tv1s7zWDxnclbws25VzxI/kRMSxpAv1i4GGA8VTpwk9S2
         xQ5ck+3HggShl4YCJU68jmVSZfW6VXYiVs1D0FesnLCFyt61kCtaIddPV2Z2oHP6SHvO
         6U2BLGSqdOu32EYKlJ913T4FXl00CGaPdCEEFAOnY+IKSGbrQUC02sOhDg+0GYqFx2Gd
         wixnZMYV4dI+/JGgdlNdOuu5PsPMtJvcyBms9/LLbHtphGft4gg8Qrmk0vFjKMd4zOPn
         2rpQ==
X-Gm-Message-State: AO0yUKVZg0Z/4+wFk/Ro8xscjuYFD3LSYtP5UkwydjQY1D3IkfVbs7Ym
        /Lo1XM6qnZCS32arOJt90Xo=
X-Google-Smtp-Source: AK7set90a5jKbMQYwuP9wfiD3DNFkSxKJrZLqm5Ryud3NLvTwIBcg7MnYliVSvZV7aOBoSvVYJfnGQ==
X-Received: by 2002:a92:7b12:0:b0:315:8f82:4d4 with SMTP id w18-20020a927b12000000b003158f8204d4mr2431967ilc.0.1676941436453;
        Mon, 20 Feb 2023 17:03:56 -0800 (PST)
Received: from localhost.localdomain (bras-base-toroon4321w-grc-52-76-71-25-91.dsl.bell.ca. [76.71.25.91])
        by smtp.gmail.com with ESMTPSA id n13-20020a02cc0d000000b003bf35a3cc3bsm870882jap.85.2023.02.20.17.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 17:03:56 -0800 (PST)
From:   Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
To:     jirislaby@kernel.org
Cc:     alexander.vorwerk@stud.uni-goettingen.de,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, mohammadmahfoozpersonal@gmail.com
Subject: [PATCH] serial: jsm: Change n to unsigned int
Date:   Mon, 20 Feb 2023 20:03:39 -0500
Message-Id: <20230221010339.3032-1-mohammadmahfoozpersonal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
References: <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
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

Change n to an unsigned int and remove casts from min()s.

Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 4cce1e423b06..394121870436 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -277,7 +277,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 	int qleft = 0;
 	u8 linestatus = 0;
 	u8 error_mask = 0;
-	int n = 0;
+	u32 n = 0;
 	int total = 0;
 	u16 head;
 	u16 tail;
@@ -342,15 +342,15 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 			break;
 
 		/* Make sure we don't go over the end of our queue */
-		n = min(((u32) total), (RQUEUESIZE - (u32) head));
+		n = min(total, RQUEUESIZE - head);
 
 		/*
 		 * Cut down n even further if needed, this is to fix
 		 * a problem with memcpy_fromio() with the Neo on the
 		 * IBM pSeries platform.
-		 * 15 bytes max appears to be the magic number.
+		 * 12 bytes max appears to be the magic number.
 		 */
-		n = min_t(u32, n, 12);
+		n = min(n, 12U);
 
 		/*
 		 * Since we are grabbing the linestatus register, which
-- 
2.34.1

