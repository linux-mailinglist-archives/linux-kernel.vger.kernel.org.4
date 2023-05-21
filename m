Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3170ACE6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEUHvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUHvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 03:51:18 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB911A;
        Sun, 21 May 2023 00:51:16 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3318961b385so6809955ab.1;
        Sun, 21 May 2023 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684655476; x=1687247476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x45JB6d8uRh2jZVynsLC/k+HQt3mBQZgQCZkixZARFg=;
        b=VQ4tV0C9VCY6EIUoCRmK6hTXDcgNrmDtcOU4DRqRZBwe/R+Y1D3vB+HsFZuPuDGYEo
         UmLwKlXb8D+AI6pxHoCh+uVdASK6VqRAOHEx+5RuEsVMvbJblbHpXjlYz/PLGTBbnLbS
         bWxDDE84fK0R1ZIV9Odien/s5U3W/SxH7uqzqPRitw14lmD46eNiq4hJDFG1i+n5+pzw
         wrEtKzxnAw7TmXHUshz0yGZnZTUgbrbcEv8C+VXUqrND4mWZw1lyfd0edIMSdv3M+vvK
         BllAXALdTFKWzzTQG7qpHs2U0hp2rJBuOwTfSxEMiMUkPnQuHxiCR86g0XsZBHIJXZ+U
         2CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684655476; x=1687247476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x45JB6d8uRh2jZVynsLC/k+HQt3mBQZgQCZkixZARFg=;
        b=P3QEpAIwBqEXikCzNewYdSO0EcuQdJCKZJVfefFF6U2JkYLk5X1+Sau+ECE7qcyKdy
         6qp/X/B56TspWQ4AJqddNSkKxEIUPN+YU0PRNbfUuGU4pxtUnTqZX4nLbDjAjKkzmoxU
         RoEccE83EroY8PXl7QZRVAUQoGI4USvlkUXRht4z4ftGhbFdHFNnKM7x45XmkSpb4Pce
         2qMVpsgCBv8U4MSwZygJiovEJloztuUwF/xWoaQZuJqaZeYajqkiUCh+dc6MR9dIskIH
         Z8faDucIedkIl/IRRgQIP8E67Pz+RiUS/DN5omQ+yZN/XKRiOKrEZIE0rRbRro22DaXE
         iQLw==
X-Gm-Message-State: AC+VfDwITHIVEo7q/8U9MRpUauAlNOZFnDwp4u7X2/GlY03GMjek7itj
        1bjbsWeFAHbvmyWnDypzqBreQEik1EAc3w==
X-Google-Smtp-Source: ACHHUZ4kO3A4LSMn8r0tJSgqoFhl/AJXddkmZVS+t70JE1+81DFQtxfpjtTR5REcKERu4r+2+Z0Bpg==
X-Received: by 2002:a92:c24e:0:b0:331:7885:3300 with SMTP id k14-20020a92c24e000000b0033178853300mr9821417ilo.12.1684655475800;
        Sun, 21 May 2023 00:51:15 -0700 (PDT)
Received: from james-x399.localdomain (71-33-144-241.hlrn.qwest.net. [71.33.144.241])
        by smtp.gmail.com with ESMTPSA id bv26-20020a056638449a00b0041627abe120sm424jab.160.2023.05.21.00.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 00:51:15 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: Indicate fintek option may also be required for RS232 support
Date:   Sun, 21 May 2023 01:50:44 -0600
Message-Id: <20230521075046.3539376-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current config comment for SERIAL_8250_FINTEK implies that this
option is only needed when one wants to support RS485. As it turns
out we also need to enable this option for RS232 support to function
correctly on some variants.

For example for variants such as the F71869AD attempting to use
multiple RS232 ports simultaneously without this option enabled can
result in data corruption.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..cf33e858b0be 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -71,14 +71,16 @@ config SERIAL_8250_16550A_VARIANTS
 	  console, you can say N here.
 
 config SERIAL_8250_FINTEK
-	bool "Support for Fintek F81216A LPC to 4 UART RS485 API"
+	bool "Support for Fintek variants"
 	depends on SERIAL_8250
 	help
-	  Selecting this option will add support for the RS485 capabilities
-	  of the Fintek F81216A LPC to 4 UART.
+	  Selecting this option will add support for the RS232 and RS485
+	  capabilities of the Fintek F81216A LPC to 4 UART as well similar
+	  variants.
 
 	  If this option is not selected the device will be configured as a
-	  standard 16550A serial port.
+	  standard 16550A serial port, however the device may not function
+	  correctly without this option enabled.
 
 	  If unsure, say N.
 
-- 
2.34.1

