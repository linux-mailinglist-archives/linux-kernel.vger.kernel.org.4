Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1501B6D5A17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjDDH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjDDH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3335F10EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680594947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=61Hxm9VC0xuIO7eIbK3Lu7CsZ074JxVGx8+9s/MrGA4=;
        b=e5bkFL9SvT87bb+zZHXSq4IXZn98pA3exiqZdmQy18ecc/YTz4fmAQAmP1LnvXrzCreGqc
        se6qu9CgGST7OtJUIUIBncOFzM/lEtXCKhX4zh3AP0DGC8RNgNVHFe6cpCVUlCLDK0NLWN
        gRB180TPAJcUD6qbnm7Zz5sF4SmxJco=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-iIju49tWM2O3MvZ4TNBNdg-1; Tue, 04 Apr 2023 03:55:44 -0400
X-MC-Unique: iIju49tWM2O3MvZ4TNBNdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94EF63814944;
        Tue,  4 Apr 2023 07:55:43 +0000 (UTC)
Received: from ihuguet-laptop.redhat.com (unknown [10.39.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58BB9C084B2;
        Tue,  4 Apr 2023 07:55:42 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH v2] Add .editorconfig file for basic formatting
Date:   Tue,  4 Apr 2023 09:55:40 +0200
Message-Id: <20230404075540.14422-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
v2: added special rule for patch files so it doesn't remove
trailing whitespaces, making them unusable.
---
 .editorconfig | 22 ++++++++++++++++++++++
 .gitignore    |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..082d81bd0475
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,22 @@
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
+
+[*.{patch,diff}]
+trim_trailing_whitespace = false
diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..c68f8f247379 100644
--- a/.gitignore
+++ b/.gitignore
@@ -105,6 +105,7 @@ modules.order
 !.gitignore
 !.mailmap
 !.rustfmt.toml
+!.editorconfig
 
 #
 # Generated include files
-- 
2.39.2

