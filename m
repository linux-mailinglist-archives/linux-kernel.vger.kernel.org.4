Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F195FDEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiJMR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJMR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:29:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E805C3541;
        Thu, 13 Oct 2022 10:29:27 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        by ms.lwn.net (Postfix) with ESMTPA id CAB5A7DE;
        Thu, 13 Oct 2022 17:29:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CAB5A7DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665682167; bh=sf2YcBaC8BulfV1gLC66FnN/Vr7mvopLL1hXvmP/Wiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqTyH8aSX2v/yn/lGIScRydi6QzAMazqsuDtDXFp4Tlpbs9GQggtulozm8WAnRhpR
         XVHtJwd1uAP6kBb1CGSe91z/O8NRNhy/4jbeyKTK2+8oF6v8WVmwIxqxnC2+CZdVQR
         E+UZcJyCDPWbj+VcnjnFlS0bWVWNY7wyafOXuA9B3CBpkTdehkbbvC8td7lSRf6Dgi
         doW6lPY/TXPwq57q9mw3ll4k8eP/wz+4Z7T0jPEeq9IVD8PJBF86aAQ6ToGozzlB24
         3OiTsbGTpMH4KRAGzD8lI0zYBpy0vlbGFBp7sAGOGqBegzAhdgyktKAoPNQEwfwa3q
         /YvJYPTHWkNdA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] docs: tweak some Alabaster style parameters
Date:   Thu, 13 Oct 2022 11:29:14 -0600
Message-Id: <20221013172918.846856-3-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013172918.846856-1-corbet@lwn.net>
References: <20221013172918.846856-1-corbet@lwn.net>
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

This is just the beginning: tighten up the layout a bit to improve the
information density in the browser.  Also reconfigure the page width in
terms of character units (em) rather than pixels, making it more
display-independent.  To that end, add a custom.css file to
tweak Alabaster CSS settings.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
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

