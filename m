Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC296A981F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCCNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCCNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:04:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141E1630D;
        Fri,  3 Mar 2023 05:04:11 -0800 (PST)
Received: from localhost.localdomain (unknown [182.179.171.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 779206602FCA;
        Fri,  3 Mar 2023 13:04:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677848650;
        bh=pKUjjC88O8uUy9xkj/ixqWa3CHLtn+R9H2P6Mhch7m8=;
        h=From:To:Cc:Subject:Date:From;
        b=OWPBzPG9n6nr0oMR7LuZdeSUXKQSZcCF14SnodONMzIC+4K5sKrxANmDpPr3J4OuC
         dBTGXXLliqYfrDo7XDGYkCVRaeBCaHsVEGWOdw74UYEkFvXgbrrCYYjvRsnnXMT/52
         mxVbF2ulAetxgsUtPSVi7SjSrezYdqwrtdSauHn7wbQttInHU7RJmNXPHTyi1yLe+t
         Kl18UdqgjQkFNV11EHZRMdg9J1RdiB0ZnuLaXP5wDnEIbVSqPv9luF6ed2XWhnWWy6
         B4YUhd2O63sa9gxbxBoVd7JHI0PnYXXsYpMOMCm9LeLG2j4WaEBgHzE/0+7UZrc1pJ
         xBE/DCNf9Fs/A==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc/tegra: cbb: remove linux/version.h
Date:   Fri,  3 Mar 2023 18:03:46 +0500
Message-Id: <20230303130346.2062989-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make versioncheck reports the following:
./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.

So remove linux/version.h from these files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/soc/tegra/cbb/tegra-cbb.c    | 1 -
 drivers/soc/tegra/cbb/tegra194-cbb.c | 1 -
 drivers/soc/tegra/cbb/tegra234-cbb.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index a8566b9dd8de..bd96204a68ee 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -16,7 +16,6 @@
 #include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/version.h>
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/tegra-cbb.h>
 
diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index d4112b683f00..a05fc2caff3b 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -23,7 +23,6 @@
 #include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/version.h>
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/tegra-cbb.h>
 
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index f33d094e5ea6..e23e8acfd7c7 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -24,7 +24,6 @@
 #include <linux/of_address.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/version.h>
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/tegra-cbb.h>
 
-- 
2.39.2

