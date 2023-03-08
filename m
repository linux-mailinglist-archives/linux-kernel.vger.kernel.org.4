Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9616B01BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCHIlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCHIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:40:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC21EFC7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678264809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=X0KoJnquJwCBewFQWK8K8R7qBNk2GV9aWNYG4njGess=;
        b=FzU3Nz8lEI+8zC7E5HQc5AVVnBHyGi3wso+zvkP2NkER+D12v2sIjUKf2wyZ4aXNwUG86f
        8sBr/jxp0pfisDzu4UT8++ydIg7UuTfMii0JzYEY3n5YYHHP/QYsgiFPuj0OVpUvtJ3RAc
        iWT7isrsR8EMnyN/BDWM23+aQ3HJygY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-nTc6oYKJN3K9945J8dK-Aw-1; Wed, 08 Mar 2023 03:34:00 -0500
X-MC-Unique: nTc6oYKJN3K9945J8dK-Aw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE3503C02190;
        Wed,  8 Mar 2023 08:33:59 +0000 (UTC)
Received: from ihuguet-laptop.redhat.com (unknown [10.39.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 332D14024CA1;
        Wed,  8 Mar 2023 08:33:59 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH resend] Add .editorconfig file for basic formatting
Date:   Wed,  8 Mar 2023 09:33:56 +0100
Message-Id: <20230308083356.6229-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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

