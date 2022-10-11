Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277185FBAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJKTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJKTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:01:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A388844E1;
        Tue, 11 Oct 2022 12:00:58 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id B6B9D845;
        Tue, 11 Oct 2022 19:00:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B6B9D845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665514858; bh=RQjiDw6MALWVNaPpx7GNcchSIXCX/ensCVvHPIlQ7jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLjUrv2P4sOQpSCifH8LOLPv1gnfW8VvZRl+pZYD327yMNUvF/gO7ZtphJGq3N9DB
         2wnHhz8nWbOSogiNqIMq6atANuPDKcg1/Byc4j8DCWI0ioIQ5KuEF/5yqnomzK21Us
         cGujxMxou1a7U5JjxkbmnaTHlhHNhu/zTukqOoeCXzbOnp2wbW93e+3ZWqrf/3HX3A
         chfxoz1XX2uAbCDR6iSE7RpuxOit11oEMzkLYPHsySmqt1YQrG669JidGdDXT6AsEb
         HyC4vGh4zCtBMsCo8gbwz0c6xBrzr1dU2GxdCptTXV9bfLgSdUgM8yfjKsnD44gYVG
         U/oH9D7z2B2FA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/6] docs: tweak some Alabaster style parameters
Date:   Tue, 11 Oct 2022 13:00:43 -0600
Message-Id: <20221011190047.749145-3-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221011190047.749145-1-corbet@lwn.net>
References: <20221011190047.749145-1-corbet@lwn.net>
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

This is just the beginning: tighten up the layout a bit to improve the
information density in the browser.  Also reconfigure the page width in
terms of character units (em) rather than pixels, making it more
display-independent.  To that end, add a custom.css file to
tweak Alabaster CSS settings.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py                  |  3 +++
 Documentation/sphinx-static/custom.css | 14 ++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 Documentation/sphinx-static/custom.css

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 629f4afeb0eb..1dbf3d6a55de 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -345,6 +345,9 @@ if  html_theme == 'classic':
 else:
     html_theme_options = {
         'description': get_cline_version(),
+        'font_size': '10pt',
+        'page_width': '65em',
+        'sidebar_width': '15em',
     }
 
 sys.stderr.write("Using %s theme\n" % html_theme)
diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
new file mode 100644
index 000000000000..6b0e554cea0a
--- /dev/null
+++ b/Documentation/sphinx-static/custom.css
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CSS tweaks for the Alabaster theme
+ */
+
+/* Shrink the headers a bit */
+div.body h1 { font-size: 180%; }
+div.body h2 { font-size: 150%; }
+div.body h3 { font-size: 130%; }
+
+/* Tighten up the layout slightly */
+div.body { padding: 0 15px 0 10px; }
+div.document { margin: 20px 10px 0 10px; }
+div.sphinxsidebarwrapper { padding: 1em 0.4em; }
-- 
2.37.2

