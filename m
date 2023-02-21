Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67069E418
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBUP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBUP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C471DB98
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676995100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X0KoJnquJwCBewFQWK8K8R7qBNk2GV9aWNYG4njGess=;
        b=TNBf0Y7cPL6SHbYlxAwb6Pppb/IhFbAnVppBBZfXWmA/wycA3nSzAvn452JvDA6q3+KD0y
        pq/eFTeTmVBtYM7eNMrbUDYtcumfBKx1awTuYQ256yjr3rCTTZxI0dCvSwB8CcvV5hO66o
        bllW/x5WAMmDerL09oR7/0jCZVjbO3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-1haXqrYFPiW387mwV_klzw-1; Tue, 21 Feb 2023 10:57:55 -0500
X-MC-Unique: 1haXqrYFPiW387mwV_klzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44CF3811E6E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A865D2026D3E;
        Tue, 21 Feb 2023 15:57:50 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH] Add .editorconfig file for basic formatting
Date:   Tue, 21 Feb 2023 16:57:40 +0100
Message-Id: <20230221155740.27572-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EditorConfig is a specification to define the most basic code formatting
stuff, and it's supported by many editors and IDEs, either directly or
via plugins, including Vim and emacs.

It allows to define formatting style related to indentation, charset,
end of lines and trailing whitespaces. It also allows to apply different
formats for different files based on wildcards, so for example it is
possible to apply different configs to *.{c,h}, *.py and *.rs.

In linux project, defining a .editorconfig might help to those people
that work on different projects with different indentation styles, so
they cannot define a global style. Now they will directly see the
correct indentation on every fresh clone of the project.

See https://editorconfig.org

Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
 .editorconfig | 19 +++++++++++++++++++
 .gitignore    |  1 +
 2 files changed, 20 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..0791a12a20f0
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,19 @@
+root = true
+
+[*]
+charset = utf-8
+end_of_line = lf
+trim_trailing_whitespace = true
+insert_final_newline = true
+
+[*.{c,h}]
+indent_style = tab
+indent_size = 8
+
+[{Makefile,Makefile.*,*.mk}]
+indent_style = tab
+indent_size = 8
+
+[*.{py,rs}]
+indent_style = space
+indent_size = 4
diff --git a/.gitignore b/.gitignore
index 20dce5c3b9e0..6d09f3003484 100644
--- a/.gitignore
+++ b/.gitignore
@@ -102,6 +102,7 @@ modules.order
 !.gitignore
 !.mailmap
 !.rustfmt.toml
+!.editorconfig
 
 #
 # Generated include files
-- 
2.34.3

