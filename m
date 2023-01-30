Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BBE680767
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjA3I3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjA3I3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:29:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51356298EA;
        Mon, 30 Jan 2023 00:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D596360EEB;
        Mon, 30 Jan 2023 08:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE83C433EF;
        Mon, 30 Jan 2023 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675067340;
        bh=VyDYTZSiegSjXwVzMVTkiXbtZEt3qyMN0l/K/V+Ukzc=;
        h=From:To:Cc:Subject:Date:From;
        b=VZuRc7+oOJRgoP9t7MwkubH/uhgoCk85zOkUlRBa+lOljAKXkjmthn/QktswKpMZ1
         So1szTyqt6+Ho96xJVTjBvomj8bfqMYJBroY5HNuze8hq9VmXJGdj0iRV2EGhTiRVA
         39WPZw9ilce3xLnJkIpcDrqVitJUndCAkUYdArN1zGKriKZAxwh5CGZu3MbVPSES/3
         XeWt6r9suGdF0VeyThg2JZsbEwTxu3HxI1nMjTJbkyYLDezM9Db4mxkicGuqrQrPJy
         crJoKFTOhFk4zOegiahOKpPFNByIhFw15p8Hl+iTpVUnreBqL8Yus/q5QoF2wmf/7U
         /nbol7bSviaEA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] .gitignore: ignore *.cover and *.mbx
Date:   Mon, 30 Jan 2023 17:28:49 +0900
Message-Id: <20230130082849.65737-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'b4' command creates a *.mbx file, and also a *.cover file if the
patch set has a cover-letter. Ignore them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
  - ignore *.cover (Nocolas)

 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 22984d22d29e..8fe465f251c0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,7 @@
 *.bin
 *.bz2
 *.c.[012]*.*
+*.cover
 *.dt.yaml
 *.dtb
 *.dtbo
@@ -33,6 +34,7 @@
 *.lz4
 *.lzma
 *.lzo
+*.mbx
 *.mod
 *.mod.c
 *.o
-- 
2.34.1

