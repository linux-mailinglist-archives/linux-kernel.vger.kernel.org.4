Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949D36B8C44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCNH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCNH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:56:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCFF15C90;
        Tue, 14 Mar 2023 00:56:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j11so58340689edq.4;
        Tue, 14 Mar 2023 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678780572;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi12WzjuQCkHoF5aCI0aFBZsJiAVj1ejY+SxDt56Xek=;
        b=Gxgdb76sbzumXF4XQ4wypK9zBjXdKm5LIaebpkIzgTBWYiRFRGHdStsrXqhmz/XE7O
         yR2aXrkGgsH26e9zVf2iOTXbBQ9VVNaznq1g2xcOEznd3l+p8UqM3CPB/GrLw87IlLxR
         i998eUeM0qBooC6IyRslczmkrZtuim58IkmGRebFoT44eK37S9tLy5c57X62Ip1ysdmW
         9O4bbnfQARqRTYednuUiQNK+WG3+9RDZe2UmnSywjXZsSCIHtvqJSu70Jtpex/A0yzRN
         HWEyvI6WCKxQmfsEgsH7EJ4Q3DCfvdntxNR/lxTvmLgzPA7rOsFvXma2uMHo+uvPYlgs
         wzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780572;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi12WzjuQCkHoF5aCI0aFBZsJiAVj1ejY+SxDt56Xek=;
        b=nx72HLWrDqvv4JXwK8JS9PpFuWxPvy+e6Cc7flKRvEsi6uCs34ioF6eaKczWSc4YcW
         3jBuUGZPdx2iC+4YsuzeKyk7X7b30dic5J9FQSZkA+Fv9ws9e+MJExxH6Y7cBImZ0ilV
         uUM8ZJYgjFvIJI7UhBsE/0Sj5t9+UWC3kMPTGqX9kJbniUx1jhUEiiLyy6CAUWNTY78F
         e5Z02idj6R4vFUK7j2ubbKxM8vk90bc+YQEMTUx82WWYS7IoUv3JRzEagYVnjMN9N0vm
         t4S2ipiLSATA3CgNQAIuBp4+YnwZ9JJlHAxT8I7CCX+671VZNwBf+8cYcVTE0OhN+uPS
         UBww==
X-Gm-Message-State: AO0yUKV2n2uWOAKiPx9zr+Lvp39Q9qZWj/hda7xMxasy2NayIwU/s/jo
        UxmTyK85KVSwlGPphf1sFRbkdwPkU3B0Fg==
X-Google-Smtp-Source: AK7set+rDgDEXDrR7EgrWRSIl+HDTTQBpqb+BuGuCSOLx7Yw3uTbhNpgh+HxPaVo6GiEOzTSsonhtg==
X-Received: by 2002:a17:907:78c2:b0:8b1:4516:238 with SMTP id kv2-20020a17090778c200b008b145160238mr1179270ejc.26.1678780571975;
        Tue, 14 Mar 2023 00:56:11 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:7d6a:d375:818d:da90])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709064e4c00b008df7d2e122dsm769663ejw.45.2023.03.14.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:56:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED removal
Date:   Tue, 14 Mar 2023 08:56:09 +0100
Message-Id: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and
CONFIG_SYSFS_DEPRECATED_V2"), ./scripts/checkkconfigsymbols.py indicated
an unresolved reference to the config SYSFS_DEPRECATED in the SPI summary
documentation.

Simply, delete the sentence referring to the removed config there. Also
update the documentation, as these sys/class entries should always be
symlinks, as the commit message of the commit above suggests.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mark, Greg, Jens, please confirm that these sys/class entries now always
are symlinks. That is simply my guess after reading a bit on sysfs_deprecated
also changed compared to the normal setup, but I am not the expert here.

 Documentation/spi/spi-summary.rst | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 3c95ae322fb1..33f05901ccf3 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -178,10 +178,10 @@ shows up in sysfs in several locations::
 
    /sys/bus/spi/drivers/D ... driver for one or more spi*.* devices
 
-   /sys/class/spi_master/spiB ... symlink (or actual device node) to
-	a logical node which could hold class related state for the SPI
-	master controller managing bus "B".  All spiB.* devices share one
-	physical SPI bus segment, with SCLK, MOSI, and MISO.
+   /sys/class/spi_master/spiB ... symlink to a logical node which could hold
+	class related state for the SPI master controller managing bus "B".
+	All spiB.* devices share one physical SPI bus segment, with SCLK,
+	MOSI, and MISO.
 
    /sys/devices/.../CTLR/slave ... virtual file for (un)registering the
 	slave device for an SPI slave controller.
@@ -191,16 +191,13 @@ shows up in sysfs in several locations::
 	Reading from this file shows the name of the slave device ("(null)"
 	if not registered).
 
-   /sys/class/spi_slave/spiB ... symlink (or actual device node) to
-	a logical node which could hold class related state for the SPI
-	slave controller on bus "B".  When registered, a single spiB.*
-	device is present here, possible sharing the physical SPI bus
-	segment with other SPI slave devices.
+   /sys/class/spi_slave/spiB ... symlink to a logical node which could hold
+	class related state for the SPI slave controller on bus "B".  When
+	registered, a single spiB.* device is present here, possible sharing
+	the physical SPI bus segment with other SPI slave devices.
 
-Note that the actual location of the controller's class state depends
-on whether you enabled CONFIG_SYSFS_DEPRECATED or not.  At this time,
-the only class-specific state is the bus number ("B" in "spiB"), so
-those /sys/class entries are only useful to quickly identify busses.
+At this time, the only class-specific state is the bus number ("B" in "spiB"),
+so those /sys/class entries are only useful to quickly identify busses.
 
 
 How does board-specific init code declare SPI devices?
-- 
2.17.1

