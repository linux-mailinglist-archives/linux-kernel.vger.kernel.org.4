Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AB6E2069
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDNKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjDNKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002AC4C3C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681467077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/1QlXpdfAcoxJFAV8x4J/Rw5Xo/ViKHKPnwtGvKhjoU=;
        b=PkZxDjAPBw+NoQvgBPuwy95M6ZoNaIM6mxAfwvedLj3If9oLONW6+/I1PO0DJnAn/vyLZ5
        QRQ1YeZjTlXTvY7dL4hjHE+UQzDXxKkWDOQlPWEbcqCet9Uas3/i+w1Xvn/wOynzqyusEV
        uyfkwVN6SR8mvlMgVcbJf8uCf0yoTdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-rIwxkIbLNU2MscZq_krH_A-1; Fri, 14 Apr 2023 06:11:12 -0400
X-MC-Unique: rIwxkIbLNU2MscZq_krH_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5542C185A791;
        Fri, 14 Apr 2023 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 228551121320;
        Fri, 14 Apr 2023 10:11:09 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH v3] Add .editorconfig file for basic formatting
Date:   Fri, 14 Apr 2023 12:10:52 +0200
Message-Id: <20230414101052.11012-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EditorConfig is a specification to define the most basic code formatting
stuff, and it's supported by many editors and IDEs, either directly or
via plugins, including VSCode/VSCodium, Vim, emacs and more.

It allows to define formatting style related to indentation, charset,
end of lines and trailing whitespaces. It also allows to apply different
formats for different files based on wildcards, so for example it is
possible to apply different configs to *.{c,h}, *.py and *.rs.

In linux project, defining a .editorconfig might help to those people
that work on different projects with different indentation styles, so
they cannot define a global style. Now they will directly see the
correct indentation on every fresh clone of the project.

See https://editorconfig.org

Link: https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
Link: https://lore.kernel.org/lkml/20230404075540.14422-1-ihuguet@redhat.com/
Co-developed-by: Danny Lin <danny@kdrag0n.dev>
Signed-off-by: Danny Lin <danny@kdrag0n.dev>
Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
v2:
 - added special rule for patch files so it doesn't remove
   trailing whitespaces, making them unusable.
v3:
 - moved all rules from [*] section to all the individual
   sections so they doesn't affect to unexpected files.
 - added some extensions and files from a patch from Danny
   Lin that didn't get to be merged:
   https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/
   However, the following file types hasn't been added
   because they don't have a clear common style:
   rst,pl,cocci,tc,bconf,svg,xsl,manual pages
---
 .editorconfig                          | 30 ++++++++++++++++++++++++++
 .gitignore                             |  1 +
 Documentation/process/4.Coding.rst     |  4 ++++
 Documentation/process/coding-style.rst |  4 ++++
 4 files changed, 39 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..dce20d45c246
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+root = true
+
+# 8 width tabs
+[{*.{c,h},Kconfig,Makefile,Makefile.*,*.mk}]
+charset = utf-8
+end_of_line = lf
+trim_trailing_whitespace = true
+insert_final_newline = true
+indent_style = tab
+indent_size = 8
+
+# 4 spaces
+[{*.{json,pm,py,rs},tools/perf/scripts/*/bin/*}]
+charset = utf-8
+end_of_line = lf
+trim_trailing_whitespace = true
+insert_final_newline = true
+indent_style = space
+indent_size = 4
+
+# 2 spaces
+[{*.{rb,yaml},.clang-format}]
+charset = utf-8
+end_of_line = lf
+trim_trailing_whitespace = true
+insert_final_newline = true
+indent_style = space
+indent_size = 2
diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..e4b3fe1d029b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,7 @@ modules.order
 #
 !.clang-format
 !.cocciconfig
+!.editorconfig
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 1f0d81f44e14..c2046dec0c2f 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -66,6 +66,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
 See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
 for more details.
 
+Some basic editor settings, such as indentation and line endings, will be
+set automatically if you are using an editor that is compatible with
+EditorConfig. See the official EditorConfig website for more information:
+https://editorconfig.org/
 
 Abstraction layers
 ******************
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 007e49ef6cec..ec96462fa8be 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -735,6 +735,10 @@ for aligning variables/macros, for reflowing text and other similar tasks.
 See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
 for more details.
 
+Some basic editor settings, such as indentation and line endings, will be
+set automatically if you are using an editor that is compatible with
+EditorConfig. See the official EditorConfig website for more information:
+https://editorconfig.org/
 
 10) Kconfig configuration files
 -------------------------------
-- 
2.39.2

