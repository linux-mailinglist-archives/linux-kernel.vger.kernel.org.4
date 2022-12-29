Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B41658A31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiL2IIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2II1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:08:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7573C12;
        Thu, 29 Dec 2022 00:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18D1CCE1626;
        Thu, 29 Dec 2022 08:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BFC433EF;
        Thu, 29 Dec 2022 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672301302;
        bh=sm+R17qklIAzzueLKed0KwWpx39W6KMlkozX2GsMfMk=;
        h=From:To:Cc:Subject:Date:From;
        b=XtsshrjfGOR37AUqV4A2y2OVbUyZ1Sn/469r5X+BAkzIl+VdBDwO+ItmV6f/Gf8rP
         qyvneuivjIdjsJlbR3OJCBx/IwJwhlszhELBhop+cOk/E7hf4IfO152E8/BUzEVWIS
         LgjQW+pJ75m1njtMESvdFWL6Uv+nvmTkOecGdsPrvWoBNLW5L2ozeFknn4+TQ8y7j1
         Xx4ishTf7f/kk9tC3rIp6t5rgRldQ/MNzTJWCfYLnnp4qwHmeGwll3/tMsesyCfFUz
         4bH4UDioiGbO9T7naRGvtoPKHWkpT0GJ+7Khrve7JWe9hfj6KAeQxffJHCI3Pd460i
         YINIlOHD8m6Yg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: sort single-targets alphabetically again
Date:   Thu, 29 Dec 2022 17:08:13 +0900
Message-Id: <20221229080813.908450-1-masahiroy@kernel.org>
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
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c0d7c75d8f14..563ec1d8dd2f 100644
--- a/Makefile
+++ b/Makefile
@@ -289,7 +289,7 @@ no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
 			headers_install modules_install kernelrelease image_name
 no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \
 			  image_name
-single-targets := %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
+single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.rsi %.o %.s %.symtypes %/
 
 config-build	:=
 mixed-build	:=
-- 
2.34.1

