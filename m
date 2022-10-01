Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202675F1F65
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJAUbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJAUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:30:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6D43145;
        Sat,  1 Oct 2022 13:30:54 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 291KSpu6001629;
        Sun, 2 Oct 2022 05:28:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 291KSpu6001629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664656132;
        bh=WVaRutAdMwkgqQFDUdeEzlxZSqRe3cLAvSUNcchojDA=;
        h=From:To:Cc:Subject:Date:From;
        b=j6kmEy224q8ZfOfuLzGoOWgSoT8FuglYZUZiuTOOjJZKYSXpgdY6lKAmX77OZOE4G
         o6TsfYF7eUy3AS0HkiVjztHgf3bXgib2OvhBKj6EC9ISoLCeCpQWfytUknRumCkOHm
         K8FbecrmhsvMFdUUkBL9QYb2al60AKRp+KHSh5N905HJz1N3Jw28+RsU5cpn6ps4zr
         u47JKN3lzT7bfMQv0b9osivN1ISqxdkKUM+DqKYVib8rGRrxauoFQlydLEH3TCEJAA
         wmkwT/y1uuXGcPXBq8w0tTiDJetSclHGnlYwUaidFZWZe/jRhK9Ei7QNLtUXfGH7N8
         wIjYL+RwFEknQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] docs: bump minimal GNU Make version to 3.82
Date:   Sun,  2 Oct 2022 05:28:35 +0900
Message-Id: <20221001202836.3110985-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU Make 3.81 fails in CONFIG_RUST=y builds.

  rust/Makefile:105: *** multiple target patterns.  Stop.
  make[1]: *** [prepare] Error 2
  make: *** [__sub-make] Error 2

The error message looks weird, but the reason is that the 'private'
keyword is only supported since GNU Make 3.82.

GNU Make 3.81 is still able to build the kernel if CONFIG_RUST is
disabled, but it might be a good timing to bump the minimal GNU Make
version. Perhaps, I am the last person who was testing GNU Make 3.81.

GNU Make 3.81 was released in 2006, GNU Make 3.82 in 2010.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/process/changes.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 19c286c23786..26a7fd875cfa 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-GNU make               3.81             make --version
+GNU make               3.82             make --version
 bash                   4.2              bash --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version
@@ -83,7 +83,7 @@ docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 Make
 ----
 
-You will need GNU make 3.81 or later to build the kernel.
+You will need GNU make 3.82 or later to build the kernel.
 
 Bash
 ----
-- 
2.34.1

