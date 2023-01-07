Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B38660F89
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAGOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAGOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41D52766;
        Sat,  7 Jan 2023 06:38:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7B0360010;
        Sat,  7 Jan 2023 14:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10682C433EF;
        Sat,  7 Jan 2023 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673102288;
        bh=+AcQ9WJVPan1G0rYOTucA63bgMfL6ndtCecaiiPwGU8=;
        h=From:To:Cc:Subject:Date:From;
        b=WnUbZ1JQ+9BIe/fAr06jMYtSbfOig2tcyMdMKe4zZ0R27tWtJUUWP/tQfwOe7bOGm
         QVVGSdrvLKwX0SfMz44PycAY1bwwM/ggYSCbqV73oG4ipDOuX+JHoXdHKpv8Bns9Z2
         0mHaM3GhllUdFwdGU2fwElTLLX6nVZc6jG2/5hcKKE6gzqi/CE0GKaVZO9jPbMNe1c
         1w2hUw4rXJx55itSrDyTHLvdXYqAaPD0vv6aK5RYD4anubeZtlPnS9N73ffbYJ6OYA
         XQv9iNvE6YXOmxCB86HqdscMt9AHKF9cVCa9PtpxO8GPdeNc4BA+7ZTUstluvWPWEO
         XawH9Xlz44jlA==
From:   ojeda@kernel.org
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] docs: kbuild: remove mention to dropped $(objtree) feature
Date:   Sat,  7 Jan 2023 15:37:47 +0100
Message-Id: <20230107143747.64802-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Ojeda <ojeda@kernel.org>

Commit 8d613a1d048c ("kbuild: drop $(objtree)/ prefix support
for clean-files") dropped support for prefixing with $(objtree).

Thus update the documentation to match that change.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/kbuild/makefiles.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 6b7368d1f516..38bc74eaa547 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1042,7 +1042,7 @@ $(clean-files).
 
 When executing "make clean", the file "crc32table.h" will be deleted.
 Kbuild will assume files to be in the same relative directory as the
-Makefile, except if prefixed with $(objtree).
+Makefile.
 
 To exclude certain files or directories from make clean, use the
 $(no-clean-files) variable.

base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
-- 
2.39.0

