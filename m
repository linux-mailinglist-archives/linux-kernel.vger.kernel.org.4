Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A026B0669
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCHLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCHLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510A52F59;
        Wed,  8 Mar 2023 03:53:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C5ABB81C29;
        Wed,  8 Mar 2023 11:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4362C4339C;
        Wed,  8 Mar 2023 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276392;
        bh=RlcQhO5rWzvu7PX3sD59EssaFFcnUCBgUHUQxZyhWsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6U9siEDWTuj0SQayayih0dyDBDWbCu77vDCqqe10QDjsbtKNmOD1An87V5wwo+go
         FxYNHht+qzF/y8yXmnhB+blJKTnAgvkKSq3Qt9wbGE/E9yllDxAej+3x1O/iqabHUM
         xqksXI6gtI61p0SNKHgif2V7K4hvd9rgZnN5OZs2TEgCAveqfyihlNjIiSZw/b0b9I
         Y6Jd/4YJW3ke9f63zwYfUXplFqf+1nndy8psyLVOSrkhFGpFsX1ZS/C4KJuLmfYSiX
         CoBTakNBvoFVDNloQ+sQokSUH66LkpYiN9tiF9/UwH0dBqpoTPZhDmHlkrVIfErhqT
         /DYwTyl43djtw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH 8/8] scripts/kallsyms: update the usage in the comment block
Date:   Wed,  8 Mar 2023 20:52:43 +0900
Message-Id: <20230308115243.82592-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308115243.82592-1-masahiroy@kernel.org>
References: <20230308115243.82592-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 010a0aad39fc ("kallsyms: Correctly sequence symbols when
CONFIG_LTO_CLANG=y") added --lto-clang, and updated the usage()
function, but not the comment. Update it in the same way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 937900823fa8..0d2db41177b2 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -6,7 +6,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * Usage: kallsyms [--all-symbols] [--absolute-percpu]
- *                         [--base-relative] in.map > out.S
+ *                         [--base-relative] [--lto-clang] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
-- 
2.34.1

