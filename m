Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0C6564B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLZSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLZSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:55:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A1E61;
        Mon, 26 Dec 2022 10:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83FDBCE0B98;
        Mon, 26 Dec 2022 18:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD7EC433D2;
        Mon, 26 Dec 2022 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672080899;
        bh=tNiS+6Ae9paO1qljI9N1dUVY+7Nxk5GQhQRPNeRIfA8=;
        h=From:To:Cc:Subject:Date:From;
        b=B1wAH7qlxms6zfSw0k/uVYOqOlPj6dqbAjqUIx7M+UMCT6wRLidMu5+IJYCvTMlsI
         CNBvtPUxgAsOVBt5bXoHV9ql41MBOuVFAW6BScYAGBPJQyvliR/XhpNnRJ/J66wsGg
         Gy63iaqD+GbY3PNs9aLiAB1TI48+l9DNlL3580MM14vzQC7uHmWTtoyRfqtODy5oqo
         qV/oS5CUuAbHPkmdAMqsKgqDR0OdIE9UfflZk04I+bbetkDvDm2CRKpvyzTrdh/3z5
         gaM12lTePRy1ck1nl1jmu2FLDWtBdXQ8K9oVgEbbJ9uTF7Y/8G7AF3/jQbzmqB8xpD
         FUUlYzqAiS6dw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH] .gitignore: ignore *.rpm
Date:   Tue, 27 Dec 2022 03:54:44 +0900
Message-Id: <20221226185444.745831-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Previously, *.rpm files were created under $HOME/rpmbuild/, but since
commit 8818039f959b ("kbuild: add ability to make source rpm buildable
using koji"), srcrpm-pkg creates the source rpm in the kernel tree
because it sets '_srcrpmdir'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2e2e3d1eeaee..22984d22d29e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,6 +39,7 @@
 *.o.*
 *.patch
 *.rmeta
+*.rpm
 *.rsi
 *.s
 *.so
-- 
2.34.1

