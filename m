Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7264F44D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLPW7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPW7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:59:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA446E9FE;
        Fri, 16 Dec 2022 14:59:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so7531313pjr.3;
        Fri, 16 Dec 2022 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FhOEzYNEcDxMyM3XQ/fnbGxtfJieZvNSyymdAKevlVM=;
        b=pn0juEODsf7EPl5bNEVJWQoFRwgGlEJg4rivi/utRvU3MtqMAINckElS0Op8E0rKc+
         dehWDXkgc6f5pUvnvZypE1nJEckZSB7HKuHJsO7yDJGqiqV/1ontppw5ltmYnuJDXJaR
         Oh/6C0y8aaKgc+6hTowIH9009/5XSdHfBdg//y8BZv1wEMMpNQCXIBadTpzOlvSpzhkn
         BOyEar0mEk6Y0wR31k9Lr2YeAnfFEEyf//x/XSHyIApeTReeRGjyvE9groveD/RYaQhj
         ON9rjY45hpwIzcJ1f7LKNhPlVfd3bzMS4v7PUr5Ln+jr0H2i9dQ3fAh53OERu4t+bk2G
         lx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhOEzYNEcDxMyM3XQ/fnbGxtfJieZvNSyymdAKevlVM=;
        b=O+JJImMol1WolAbkwsoCifwy24ye/ZvI80B++4z24Pd8zbXpK48ioen15nKkINdkej
         n7VeGNVb3RpSP6gCTIXa0LKqYFtJ4onnD8+u6q4wrw4MWHNFestGgSWZLGzVBq1hAVdR
         O/+lV1DF5r1jaBLmm2iv+9a0MhdBx7ct+X57QeLtRJWhbLrWBCu6Zsm8y50I7F/y0sZj
         +DVhUigsCAK8GkOibqjkwbdgiWIdcCxIySNE+me6A512UOHu9JWtsu4STC3wRhh4Nw5S
         kwN0C2m2pff2Bew/unlbfa1pqXGqB0dot/zN/JsOyntJx+EyrIswaT1gYY/4NGiia4uS
         sZiA==
X-Gm-Message-State: ANoB5pmUDNBNqsXvuwnhcRfUmb73doqoBviR/oj8bwhhjiLkMdu0SOZw
        hpnQEsXR52HP7S0ck6SNQKo=
X-Google-Smtp-Source: AA0mqf6HR5+0yj1K5jj9x9JnQ4H5m2yNHX9frE8GbSDXISlgUIRw3gzcs5dOHUIdtBH3OAeVDutSJQ==
X-Received: by 2002:a05:6a20:2d09:b0:ad:f140:79a3 with SMTP id g9-20020a056a202d0900b000adf14079a3mr4956375pzl.6.1671231553754;
        Fri, 16 Dec 2022 14:59:13 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00188f8badbcdsm2132409plg.137.2022.12.16.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:59:13 -0800 (PST)
Date:   Sat, 17 Dec 2022 11:59:06 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v3] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <Y5z4Og3XmCGQwTO9@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5uN9Rr3v1uWH765@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct RXBUF and refactor the rest of the code
accordingly. While at it, fix an edge case which could cause
rx_buf_count to be 0 when max_frame_size was set to the maximum
allowed value (65535).

It's worth mentioning that struct RXBUF was allocating 1 byte "too much"
for what is required (ignoring bytes added by padding).

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v3:
  fix size calculation mistakes using overflow.h macros: (Req: Andy
  Shevchenko, Kees Cook)
  add notes struct RXBUF size (Kees Cook)

- v2: removed changes to how the size of RXBUF was calculated. I
  changed my mind after thinking about the existing padding in the
  struct. Happy to discuss it if anyone sees it differently.

- v1: https://lore.kernel.org/lkml/Y5mMWEtHWKOiPVU+@mail.google.com/
---
 drivers/char/pcmcia/synclink_cs.c | 33 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index b2735be81ab2..eee6772a0978 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
 typedef struct {
 	int count;
 	unsigned char status;
-	char data[1];
+	char data[];
 } RXBUF;
 
 /* The queue of BH actions to be performed */
@@ -229,12 +229,18 @@ typedef struct _mgslpc_info {
 } MGSLPC_INFO;
 
 #define MGSLPC_MAGIC 0x5402
+#define MGSLPC_MAX_FRAME_SIZE 65535
+#define MGSLPC_MIN_FRAME_SIZE 4096
 
 /*
  * The size of the serial xmit buffer is 1 page, or 4096 bytes
  */
 #define TXBUFSIZE 4096
 
+/*
+ * RXBUF accommodates at least 1 buffer (header+data) of MGSLPC_MAX_FRAME_SIZE
+ */
+#define RXBUF_MAX_SIZE (sizeof(RXBUF) + MGSLPC_MAX_FRAME_SIZE)
 
 #define CHA     0x00   /* channel A offset */
 #define CHB     0x40   /* channel B offset */
@@ -529,7 +535,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	tty_port_init(&info->port);
 	info->port.ops = &mgslpc_port_ops;
 	INIT_WORK(&info->task, bh_handler);
-	info->max_frame_size = 4096;
+	info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
 	init_waitqueue_head(&info->status_event_wait_q);
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
@@ -2611,19 +2617,20 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
 static int rx_alloc_buffers(MGSLPC_INFO *info)
 {
 	/* each buffer has header and data */
-	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
+	if (check_add_overflow(sizeof(RXBUF), info->max_frame_size, &info->rx_buf_size))
+		return -EINVAL;
 
-	/* calculate total allocation size for 8 buffers */
-	info->rx_buf_total_size = info->rx_buf_size * 8;
+	/* try to alloc as many buffers that can fit within RXBUF_MAX_SIZE (up to 8) */
+	if (check_mul_overflow(info->rx_buf_size, 8, &info->rx_buf_total_size))
+		return -EINVAL;
 
-	/* limit total allocated memory */
-	if (info->rx_buf_total_size > 0x10000)
-		info->rx_buf_total_size = 0x10000;
+	if (info->rx_buf_total_size > RXBUF_MAX_SIZE)
+		info->rx_buf_total_size = RXBUF_MAX_SIZE;
 
 	/* calculate number of buffers */
 	info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
 
-	info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
+	info->rx_buf = kcalloc(info->rx_buf_count, info->rx_buf_size, GFP_KERNEL);
 	if (info->rx_buf == NULL)
 		return -ENOMEM;
 
@@ -2695,10 +2702,10 @@ static int mgslpc_add_device(MGSLPC_INFO *info)
 		current_dev->next_device = info;
 	}
 
-	if (info->max_frame_size < 4096)
-		info->max_frame_size = 4096;
-	else if (info->max_frame_size > 65535)
-		info->max_frame_size = 65535;
+	if (info->max_frame_size < MGSLPC_MIN_FRAME_SIZE)
+		info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
+	else if (info->max_frame_size > MGSLPC_MAX_FRAME_SIZE)
+		info->max_frame_size = MGSLPC_MAX_FRAME_SIZE;
 
 	printk("SyncLink PC Card %s:IO=%04X IRQ=%d\n",
 		info->device_name, info->io_base, info->irq_level);
-- 
2.38.1

