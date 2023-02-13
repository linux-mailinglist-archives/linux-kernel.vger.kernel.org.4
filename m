Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73357695012
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBMS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBMS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:47 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D347126E5;
        Mon, 13 Feb 2023 10:57:46 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-16a7f5b6882so16261768fac.10;
        Mon, 13 Feb 2023 10:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHyn+Iq5kDFceNl3I1U0GgQ46vN33MHSRz9J5NGp5vU=;
        b=U7JpZQ1g9CQpoTz6vURu+kEOjs3644ilNrBedisqBKcqVEJHUBlupRfJwgqLsatmsW
         nZHnilMgjXEPezYlYBRISCkAKZGV+fgpAIUhvbUZi5HT8luC7CAgOVKsFgGrnIF6c0cI
         cxtvgvmk2o+ln4w1Uibo3ZNNoLaTgt+emFpNFbhSZFeDsDX643H6GaXxD0icFkiZozpT
         dlPqzwIHj46a3GTF/SxKI+xJeTQsttNdKdswDP2Ld7K+FMPbs76kTRln7sIrob3ptVNc
         NsEXnOu9SXViqe+DPs2TdQq88esSxvTWT+WDv9jHUohu+p2n6DPxGQJ+JWfmV4AtOy3w
         ajGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHyn+Iq5kDFceNl3I1U0GgQ46vN33MHSRz9J5NGp5vU=;
        b=3cAdeUm0TkH4fEzm0wuLTl1Gy/GRN//C7I5q0RxJAitSNCdFQyxee62JUIFXFbd8pH
         G75qmT3mG5x4NUm3PKH2lerBZVSx/O4V8XvhRdb3BK78JEilQFZ1DZc5kkId8BRiuaq1
         i20V6XHz38+UDqQRbRNclm3QdYHoh6gJjh3TNaDzvqmgbdUJXSO6ojaQPVoOMfvTTE1j
         ad76h5rGF+LNoTDKw2PfgldzV6WMwOyFSVBpM6w5SHwYkcIXLjrYRXfBAfVPAtJPXPsB
         hvfoW4Xhnz0xkGdYGdX0ucIwlP0UaxYn0WaDVn9kHOp8xa+EEQRPS5BptsnFVzIs8SYW
         Znhg==
X-Gm-Message-State: AO0yUKU+5aN5wmH38b2gxrPXg2yq2WtJ2nAU2lgZ0av7VTs9oZxJXKp3
        dGEpuBHE5yEmkRv+dxOLQmE=
X-Google-Smtp-Source: AK7set+2LBWf35QE6xiy+azV7ia9bEwuLtOMhN18OWjoNN6uPJXsvHXV3Rw4TohnNyc7Bof3k4snHw==
X-Received: by 2002:a05:6870:470e:b0:16a:a965:87e0 with SMTP id b14-20020a056870470e00b0016aa96587e0mr10937388oaq.54.1676314665730;
        Mon, 13 Feb 2023 10:57:45 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:45 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] of: update kconfig unittest help
Date:   Mon, 13 Feb 2023 12:56:58 -0600
Message-Id: <20230213185702.395776-4-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
References: <20230213185702.395776-1-frowand.list@gmail.com>
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

Add more information about the impact the of unittests have on the
live devicetree and why the tests should only be enabled for developer
kernels.

Add information about processing the test output such that the
results are more complete and comprehendable.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..644386833a7b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -23,7 +23,19 @@ config OF_UNITTEST
 	  that are executed once at boot time, and the results dumped to the
 	  console.
 
-	  If unsure, say N here, but this option is safe to enable.
+	  This option should only be enabled for a development kernel. The tests
+	  will taint the kernel with TAINT_TEST. The tests will cause ERROR and
+	  WARNING messages to print on the console. The tests will cause stack
+	  traces to print on the console.  It is possible that the tests will
+	  leave the devicetree in a corrupted state.
+
+	  The unittest output will be verbose.  Copy the output to a file
+	  via capturing the console output or via the dmesg command.  Process
+	  this file with scripts/dtc/of_unittest_expect to reduce the
+	  verbosity, test whether expected output is present, and to
+	  summarize the results.
+
+	  If unsure, say N here. This option is not safe to enable.
 
 config OF_ALL_DTBS
 	bool "Build all Device Tree Blobs"
-- 
Frank Rowand <frowand.list@gmail.com>

