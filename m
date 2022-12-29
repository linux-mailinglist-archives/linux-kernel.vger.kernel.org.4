Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7E658C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiL2MQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiL2MQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:16:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5006510B5B;
        Thu, 29 Dec 2022 04:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0314CB8191A;
        Thu, 29 Dec 2022 12:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472AAC433EF;
        Thu, 29 Dec 2022 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672316207;
        bh=TX8G1KV/y28/WouPtDwI6OooJOomGW1Xb8CNPc+bzpM=;
        h=From:To:Cc:Subject:Date:From;
        b=iGN6g+7kEwTx8vhPyEGpKEvL2e8q5Ha+ll/QBunugvztvY9YLjzu4N2klzN6ioRic
         VW03/91CDts6rvEZ9r5JyZihVGPRBg0LwQfGDqvKFxD+8HVFhIYdJeJdG+bRsYLLAk
         2F6in4dh8QSsfNbJnIIfj4iMCNndyfMNGD+71DnVYFuSzm7HugNtUHeSrXAyJDesWL
         0xCmwIRDFaLc3HPeL7AdLqUALFfAfao0FWtagcFzhhr7IAWP8KrIAwKdcNSYq5c8Ih
         mQfejy+dNlfKjaJ/K+pHWMqH4loB/dYHKeHWLrbJM1W4BY4zzqGGjKeTegsGlgONEb
         7R0yVjJVmBheg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH v2] kbuild: sort single-targets alphabetically again
Date:   Thu, 29 Dec 2022 21:16:42 +0900
Message-Id: <20221229121642.1046890-1-masahiroy@kernel.org>
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

This was previously alphabetically sorted. Sort it again.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
---

Changes in v2:
  - Move %.rsi after %.o to make it really sorted

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c0d7c75d8f14..8daf1be6a2e4 100644
--- a/Makefile
+++ b/Makefile
@@ -289,7 +289,7 @@ no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
 			headers_install modules_install kernelrelease image_name
 no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \
 			  image_name
-single-targets := %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
+single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
 
 config-build	:=
 mixed-build	:=
-- 
2.34.1

