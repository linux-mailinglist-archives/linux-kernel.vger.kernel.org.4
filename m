Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A95F4A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJDUMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJDUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:12:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B60222A9;
        Tue,  4 Oct 2022 13:12:36 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id EA911221;
        Tue,  4 Oct 2022 20:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EA911221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664914356; bh=aPqqsdVIL1nw4hjRuQ5Hp50KWG5DPegY2KATgxVsOfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIp72KlxY8nvdrCjzlqAYUjLBaIdLqA+vVQYFomi3NdGgIP2Fu6u/Kz5iybQCgMqe
         +m20jUUFfHCZKbEHrJJ7kuetP8IwngSmF+BILKf3uZtq6Fv0naPhCrvUVgQyFsg6oT
         ka414QfhzBc54PeJsZCv01AoVxMq7ggi5ku7c8R7pYedW8ygrhyUvwCyPwXxuJzH2k
         GId2LMx3NlM65CtwVz27W5u+WFElqewbesl5iwEnBWyL633cEwRhz6KW6NwZgIGNQ4
         hr84dtt5uCbRBTERMMZGkBJQilpQV1egdJ0/OCg6bGHR5pkYEVY67H791+4N+X0Pid
         e0dPwXm4hCriQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/5] docs: tweak some Alabaster style parameters
Date:   Tue,  4 Oct 2022 14:12:19 -0600
Message-Id: <20221004201222.281845-3-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221004201222.281845-1-corbet@lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
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
information density in the browser.  To that end, add a custom.css file to
tweak Alabaster CSS settings.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py                  |  1 +
 Documentation/sphinx-static/custom.css | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 Documentation/sphinx-static/custom.css

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 629f4afeb0eb..b924b266a70f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -345,6 +345,7 @@ if  html_theme == 'classic':
 else:
     html_theme_options = {
         'description': get_cline_version(),
+        'font_size': '14px',
     }
 
 sys.stderr.write("Using %s theme\n" % html_theme)
diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
new file mode 100644
index 000000000000..c465251e840a
--- /dev/null
+++ b/Documentation/sphinx-static/custom.css
@@ -0,0 +1,12 @@
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
-- 
2.37.2

