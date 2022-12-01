Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE863E963
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLAFjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLAFi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:38:59 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE959A1A3A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:58 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z17so900032pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRfrpCcdqhoeRuzp0v0IXZ5eoT0+P8wQNToDtSeombQ=;
        b=B1o+NjOouQZew+heE6cm5PhgsIcyy1P3Hsc8vVzE0C/9e3esOd6qr+Qc3h+rzm8PS/
         PJmO4eSqErWMiypt13e3lWSpO9WHbPSLvrij11cWHOSp6enEvg4hAwHcWFSCB1Dxutgl
         z3pYnMa6PRethsqm68NXIaS99oRI0qzb7yyopvR6VjM2yiG2I5U09x99JsAWptmrkeHc
         w32uQgTH1LWQaV0sPkvnDH9eYc6Y+qTbY36Qnvttw6wvvuUlltEZuHZKgx3jk33r3FPZ
         37GP3yowNEGApdcLw2YSka5I9xbXqCO5zZWQrUtcQrs/lWx7hXOaWYkTRx/I0vObK15+
         rsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRfrpCcdqhoeRuzp0v0IXZ5eoT0+P8wQNToDtSeombQ=;
        b=niWsq53nOh9OIYRP9HTdGo2Qi9H7X6ytSO6IHZIvN3TNZfVXe4bzBqI3hfErLxjqbZ
         zQSdWGBEi5zafqdR00aOB36HW1IbqxMhz5d1cf2kawqZk3RaHhNLXnPssPfbKAK1+gRO
         Xp5ZYZkjsIxrmCxaMITTVL9b5tld27l7fJy+Pe7rAZY81yxPlsUn+MNvEPm6ogGG+fmk
         DAy1sLWvEHxGl5Fr8kyLjAyG7TcwrlWd41TtQ302MtbcCv0B6Z6HvHAY9NYT4cPwycEQ
         nRZLxbLmVlDvClu7wDCOlJNk3Di5j/Vx34pr/pxXqHqAlTPmX/nNV/pzVNgM5M3Tz7Cy
         3SDw==
X-Gm-Message-State: ANoB5plMWqHjwYarj3lL/eW4Uc6Wptt/Esq4+isCz77S1rak0h467QBh
        u06c+erGO7UiOR3MciFLH2SVkA==
X-Google-Smtp-Source: AA0mqf5LPxEjAzNgW88Jnl+1oVaRnxxuYa8oFMCErDjxgH0BduX8j7GonuWToggh9lLYlQMtaVjQ3Q==
X-Received: by 2002:a63:4d49:0:b0:46f:b030:7647 with SMTP id n9-20020a634d49000000b0046fb0307647mr39012597pgl.13.1669873138369;
        Wed, 30 Nov 2022 21:38:58 -0800 (PST)
Received: from ubu ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id d77-20020a621d50000000b00575fea99db9sm1282958pfd.27.2022.11.30.21.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 21:38:58 -0800 (PST)
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jack Schofield <schofija@oregonstate.edu>
Subject: [PATCH 3/3] staging: greybus: loopback_test: Remove extra blank lines
Date:   Wed, 30 Nov 2022 21:38:52 -0800
Message-Id: <51edbcc7583d64d3fe5a203d3a8649a695ef4a75.1669872193.git.schofija@oregonstate.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669872193.git.schofija@oregonstate.edu>
References: <cover.1669872193.git.schofija@oregonstate.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up extra uses of blank lines that do not follow the kernel coding
style. Issue reported by checkpatch.

Signed-off-by: Jack Schofield <schofija@oregonstate.edu>
---
 drivers/staging/greybus/tools/loopback_test.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 7c1697304ab4..d7ad51ff60c5 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -239,7 +239,6 @@ static void show_loopback_devices(struct loopback_test *t)
 
 	for (i = 0; i < t->device_count; i++)
 		printf("device[%d] = %s\n", i, t->devices[i].name);
-
 }
 
 int open_sysfs(const char *sys_pfx, const char *node, int flags)
@@ -274,7 +273,6 @@ float read_sysfs_float_fd(int fd, const char *sys_pfx, const char *node)
 	char buf[SYSFS_MAX_INT];
 
 	if (read(fd, buf, sizeof(buf)) < 0) {
-
 		fprintf(stderr, "unable to read from %s%s %s\n", sys_pfx, node,
 			strerror(errno));
 		close(fd);
@@ -367,7 +365,6 @@ static int get_results(struct loopback_test *t)
 			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
 		r->gbphy_firmware_latency_jitter =
 			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
-
 	}
 
 	/*calculate the aggregate results of all enabled devices */
@@ -407,7 +404,6 @@ static int get_results(struct loopback_test *t)
 			r->apbridge_unipro_latency_max - r->apbridge_unipro_latency_min;
 		r->gbphy_firmware_latency_jitter =
 			r->gbphy_firmware_latency_max - r->gbphy_firmware_latency_min;
-
 	}
 
 	return 0;
@@ -536,7 +532,6 @@ static int log_results(struct loopback_test *t)
 			fprintf(stderr, "unable to open %s for appending\n", file_name);
 			abort();
 		}
-
 	}
 	for (i = 0; i < t->device_count; i++) {
 		if (!device_enabled(t, i))
@@ -550,10 +545,8 @@ static int log_results(struct loopback_test *t)
 			if (ret == -1)
 				fprintf(stderr, "unable to write %d bytes to csv.\n", len);
 		}
-
 	}
 
-
 	if (t->aggregate_output) {
 		len = format_output(t, &t->aggregate_results, "aggregate",
 				    data, sizeof(data), &tm);
@@ -741,7 +734,6 @@ static int wait_for_complete(struct loopback_test *t)
 		ts = &t->poll_timeout;
 
 	while (1) {
-
 		ret = ppoll(t->fds, t->poll_count, ts, &mask_old);
 		if (ret <= 0) {
 			stop_tests(t);
@@ -781,7 +773,6 @@ static void prepare_devices(struct loopback_test *t)
 		if (t->stop_all || device_enabled(t, i))
 			write_sysfs_val(t->devices[i].sysfs_entry, "type", 0);
 
-
 	for (i = 0; i < t->device_count; i++) {
 		if (!device_enabled(t, i))
 			continue;
@@ -824,7 +815,6 @@ static int start(struct loopback_test *t)
 	return 0;
 }
 
-
 void loopback_run(struct loopback_test *t)
 {
 	int i;
@@ -853,7 +843,6 @@ void loopback_run(struct loopback_test *t)
 	if (ret)
 		goto err;
 
-
 	get_results(t);
 
 	log_results(t);
@@ -881,10 +870,8 @@ static int sanity_check(struct loopback_test *t)
 			fprintf(stderr, "Bad device mask %x\n", (1 << i));
 			return -1;
 		}
-
 	}
 
-
 	return 0;
 }
 
-- 
2.25.1

