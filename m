Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8668822A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBBP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjBBP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:28:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866A71991;
        Thu,  2 Feb 2023 07:27:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so2095723wrv.0;
        Thu, 02 Feb 2023 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zXuFALYGSZNiLfpSFyxIQQMRAOLQQA0KedSdkeUSjs=;
        b=oycBZ/KXioTJcaItzlY27p8AXDdC5RoZnJBmQwgMGa2CFZ5lSMCOty3GrdP3r7dQ8Q
         Wed/LBPPfR6ZCBAoSgieGbs6hSIHU2KNMPljdOX9ralygqsnl7/ZqF7PuHTX5Yj+YGCj
         O9Gtqu+wORnQ8Es8Sy40HSiG/HZKn0ThhLSGQuxKnS7ShaSm9UgCHjpcaXY3aSle0NPu
         HLGuC8hjb0ijyf9+ZP/yH1OMXzDnyb5Jyzd5kz4lkQ9memKbxQPV1mJKeU9zi5R+/pd6
         NsPuKrmz4iEVybr2k/YSmtlFhtI3kHM7NunwG9tTf3O9qQc1FDPZ3V+uNGWfzjk/oO2f
         Q9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zXuFALYGSZNiLfpSFyxIQQMRAOLQQA0KedSdkeUSjs=;
        b=jOUcbbj57Xv3pGin5gjaGXUr74n/JpTBhI3A/+hXwInnkePAoXOTcjzzMH6v1Pclbz
         BkS+MxLkCwTFKO++E/pFAW4LvwJO4NBaEJTYnC7o42G4tjzAtFRQudl6BTfAKcxfPPSV
         U1bXbbuSR8tJvIL35TkZ+0N7xmjNIj+P6+Rk1oZLy12tONukarsrLDP8TFw0G0zoOqQy
         JjFECotihKjflKwSwjwMLkb9NwjmHGvMHQXNKnv6vcfqEvDQATCyyvdzXYTPJPUVc/q9
         TQokaX9Rio/9rC+Kf8bD8F9PZ0pPpuyte3PFvoA8uMpZThwe+2gPiHTbP/BCp0wqRxuB
         l8Hg==
X-Gm-Message-State: AO0yUKUjgtR6SG7pF0PKPo6TRVEbWukcxMofJw4jTqyMoWQm6C/xsmjp
        zVGM3DahjJKphWXx8jR4v4Cbbv00yLSjDHGQ
X-Google-Smtp-Source: AK7set/io3O+6FmyprUDN4VOemX48j2E8gNULZFPMCCwmhYInRf8fZ9hAbFmXmmafkQWU3GAw5kx4Q==
X-Received: by 2002:a05:6000:185:b0:2bf:b77c:df72 with SMTP id p5-20020a056000018500b002bfb77cdf72mr6208951wrx.25.1675351663258;
        Thu, 02 Feb 2023 07:27:43 -0800 (PST)
Received: from localhost.localdomain (staticline-31-182-169-137.toya.net.pl. [31.182.169.137])
        by smtp.gmail.com with ESMTPSA id d10-20020adffbca000000b00287da7ee033sm19668463wrs.46.2023.02.02.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:27:43 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:27:16 +0100
From:   Sebastian Grzywna <swiftgeek@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Hang Zhang" <zh.nvgt@gmail.com>
Subject: [PATCH] ACPI / Documentation: update ACPI customize method feature
 doc
Message-ID: <20230202162716.2ef29dd4@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add one more warning to ignore with iasl 20221020

Link: https://lore.kernel.org/lkml/CAJZ5v0hbFNGugDJ3PGLzfNm7h7f8vTesUOZ0R_vkYGaxBWFCdQ@mail.gmail.com/
Reported-by: "Rafael J . Wysocki" <rafael@kernel.org>
Reported-by: "Zhang, Rui" <rui.zhang@intel.com>
Signed-off-by: Sebastian Grzywna <swiftgeek@gmail.com>
---
 .../firmware-guide/acpi/method-customizing.rst        | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/method-customizing.rst b/Documentation/firmware-guide/acpi/method-customizing.rst
index de3ebcaed4cf..e813608cbdd9 100644
--- a/Documentation/firmware-guide/acpi/method-customizing.rst
+++ b/Documentation/firmware-guide/acpi/method-customizing.rst
@@ -55,10 +55,13 @@ d) package the new file (psr.asl) to an ACPI table format.
 
    Note that the full pathname of the method in ACPI namespace
    should be used.
-e) assemble the file to generate the AML code of the method.
-   e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
-   If parameter "-vw 6084" is not supported by your iASL compiler,
-   please try a newer version.
+e) assemble the file to generate the AML code of the method,
+   ignoring missing prefix scopes and objects. e.g.
+   "iasl -vw 6084 -vw 6160 psr.asl" (psr.aml is generated as
+   a result). If parameters "-vw 6084" and "-vw 6160" are
+   not supported by your iASL compiler, please try a newer version.
+   In the future it might be necessary to ignore more error
+   messageids.
 f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
 g) override the old method via the debugfs by running
    "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
-- 
2.39.1

