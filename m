Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327896A9799
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCCMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCCMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:52:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479D1728;
        Fri,  3 Mar 2023 04:52:43 -0800 (PST)
Received: from localhost.localdomain (unknown [182.179.171.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FE9F6602FA9;
        Fri,  3 Mar 2023 12:52:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677847962;
        bh=MI7FdBdM8TqrBaHLqEEIyTk6tGzLUhwM06htrA3FuKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MosHtu0UFNL1PVbnoVQZgkaIqYcwautrG+VVMiyDkfU0HpnGRGp7/+5wGtBFOZXG4
         oDxSCFTJKPatp4yH7o2cmlk0wbAyDWJsnmme0qtoGgklHsB/HzFlf6m4bSOz7Ufp5Q
         Qkexbc2so44q/SlvCMfiihkMGaiOTIurkrmmaZ6xT7NAY1jwO29+O0FWC8NuYZjwzQ
         kq3aDFKoejV/Kpp7Ljz/zsOYSiwknqRfdZ3WijTYDxMNsvFCYuo+QtoaSP6MpZCdEh
         VFwg8I/KXTlM+dCWbE4Dkai3wZ9jHGVKqSN8gLaDJDoROf320nRpp8pjrPQSlegIvU
         5tE1g7WC/8u/w==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accessibility: speakup: remove linux/version.h
Date:   Fri,  3 Mar 2023 17:51:51 +0500
Message-Id: <20230303125152.2030241-1-usama.anjum@collabora.com>
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
./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.

So remove linux/version.h from both of these files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/accessibility/speakup/genmap.c      | 1 -
 drivers/accessibility/speakup/makemapdata.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0125000e00d9..0882bab10fb8 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <libgen.h>
 #include <string.h>
-#include <linux/version.h>
 #include <ctype.h>
 #include "utils.h"
 
diff --git a/drivers/accessibility/speakup/makemapdata.c b/drivers/accessibility/speakup/makemapdata.c
index d7d41bb9b05f..55e4ef8a93dc 100644
--- a/drivers/accessibility/speakup/makemapdata.c
+++ b/drivers/accessibility/speakup/makemapdata.c
@@ -10,7 +10,6 @@
 #include <stdio.h>
 #include <libgen.h>
 #include <string.h>
-#include <linux/version.h>
 #include <ctype.h>
 #include "utils.h"
 
-- 
2.39.2

