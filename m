Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7369238B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjBJQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjBJQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:42:09 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAAB212A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:42:08 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n132so4887912oih.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMJ7uAX19pvn9GHU3WGBuvGewsnf8KH32mzIuSOhG5g=;
        b=Zn7RcGSwJXUpdwIh15VhnqpuGwnIqvjVgQEBd2I0S7w0BXJ2BAOP8B5bAnQBouKuuP
         8aWtfo0VN9T89zJy1ffyIF+af77Gv877UbVtHsoxrEGljPKmSj9iDdFmmIMmSmV1vIrO
         GB6yntl3JzC+htOc6iXYQPMEqzZLZpPPpE38R5XHAbrTMV7GRUAdZwHyBdZeZ5HD03El
         o9gUShsnQZy2QfHQLtxU0hPfky5eIYEWDb/+xJptyE7dIAErUROmPuL2wHmjOAESpqFa
         SWGjD8FAwEhXLgFlL97s3ypN6QaJCQMV39pauN6rJ/5NpAYIrrr4bS0u9CM/od04Hl31
         QiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMJ7uAX19pvn9GHU3WGBuvGewsnf8KH32mzIuSOhG5g=;
        b=PbqEellyA2AD9Ewj9SjBN+ANEF4R5IPXNiPLUnxZaPTxfJeIXfuwah7T8WYroxmT70
         YMsoUg03bZC0C76X+iZlebVZwmm0No3BfpzvUA4kGw09WGMm6G4thYu0vp0MWYFGKary
         ziFSc6DDNB81EuhIJ1OuwXDQTH8cFbNmF951JjKA7ye/ZfVskwY6p3FqavOE+bAdIza0
         RvQuXvyq1rmPdxA1zRYJK60JF0bf8j8LFkf8/4PQNLc/5QNrKPjm1fuku8MO2gpGZJMi
         1B6CBJIZyIQ555Kll+HyyevsCZt9D+m7WjCCWBO4Gd8YIu0rm7+d6sHqtUdVv/lxUh/w
         o1Vg==
X-Gm-Message-State: AO0yUKVVyzOSs+Ia8ecUlBLWqQJTF19PlPvdN3S5LnKtpwE7/Islsvjv
        YIFRtSuX3Jo5rZbM5xk9duJfpM8LvNRsX+bO
X-Google-Smtp-Source: AK7set8mjb1oJEGkHioN1SiQWsv4iXzqOCin4K9oklh/IRzjY0TUiFPNJe0JRQdw2+tGYFZ1eRViFA==
X-Received: by 2002:a05:6808:7cf:b0:35e:de13:2dea with SMTP id f15-20020a05680807cf00b0035ede132deamr7655535oij.7.1676047327866;
        Fri, 10 Feb 2023 08:42:07 -0800 (PST)
Received: from fedora.. ([186.122.48.201])
        by smtp.gmail.com with ESMTPSA id m128-20020acabc86000000b0037880fdb1f6sm2308896oif.24.2023.02.10.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:42:07 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH v2] spi: intel: Update help text of PCI and Platform drivers
Date:   Fri, 10 Feb 2023 13:41:58 -0300
Message-Id: <20230210164158.211065-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern intel hardware uses controllers that work in hardware
sequencing mode. In this mode, the controller exposes a subset
of operations, like read, write and erase, making it easier
and less error-prone for use.
On the other hand, most of the controllers handled by the
platform driver use software sequencing that exposes the
entire set of operations i.e. exposes the low level SPI-NOR
opcodes to the software for use.
Update PCI and Platform help text with this information.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 For the record of the base commit:

 Given that the PCI driver handles controllers that only work with
 hardware sequencing, we can remove the dangerous tag.
 This patch is the second part of Mika's suggestion [1].
 The first part was accepted in [2].

 [1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
 [2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/

 This patch continues the work addressing the comments in the previous
 patch adding information about hardware and software sequencing.
 Discussion: https://lore.kernel.org/r/20230206183143.75274-1-mauro.lima@eclypsium.com/

 v1->v2:
 Addressing comments from the review of v1
 Link:
 https://lore.kernel.org/r/20230208175253.117714-1-mauro.lima@eclypsium.com/

 drivers/spi/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a362c450cb6..db033d424bb5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -454,13 +454,12 @@ config SPI_INTEL_PCI
 	select SPI_INTEL
 	help
 	  This enables PCI support for the Intel PCH/PCU SPI controller in
-	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. This
-	  driver only supports hardware sequencing mode. Using this
-	  driver it is possible to upgrade BIOS directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
+	  master mode. This controller is used to hold BIOS and other
+	  persistent settings. Controllers present in modern Intel hardware
+	  only work in hardware sequencing mode, this means that the
+	  controller exposes a subset of operations that makes it safer to
+	  use. Using this driver it is possible to upgrade BIOS directly
+	  from Linux.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called spi-intel-pci.
@@ -473,9 +472,10 @@ config SPI_INTEL_PLATFORM
 	help
 	  This enables platform support for the Intel PCH/PCU SPI
 	  controller in master mode that is used to hold BIOS and other
-	  persistent settings. Most of these controllers are using
-	  software sequencing mode. Using this driver it is possible to
-	  upgrade BIOS directly from Linux.
+	  persistent settings. Most of these controllers work in
+	  software sequencing mode, which means that the controller
+	  exposes the low level SPI-NOR opcodes to the software. Using
+	  this driver it is possible to upgrade BIOS directly from Linux.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.

base-commit: 7db738b5fea4533fa217dfb05c506c15bd0964d9
-- 
2.39.1

