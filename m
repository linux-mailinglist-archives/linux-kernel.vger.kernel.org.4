Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D792D70AE39
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjEUNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjEUN2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C10FD;
        Sun, 21 May 2023 06:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFB460ACA;
        Sun, 21 May 2023 13:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DAAC4339B;
        Sun, 21 May 2023 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684675484;
        bh=VfAYprLgD0rcez7J0B6F6vcJGPi6jx1GfUu+qYJ2n/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUXBYSgs+j1rQeijprLejFg690S0YKQjjSOjy6VIig8y2SSrk4O3uGRuyOttwBWN4
         vN5l3iZyIP1x8SSu0u5i0DlLXKP4oJFWDNDZ+7KexwLfaBjr4r00GpMD5sb87lbl9a
         OC/BOroK6vgM6cnC5/MfO0x+CFImFY2FGkPbxWIDMi1k0Dk2hHZ7zHTLfktH0ipvbp
         COML9KaYpbnf4oc2l/uqnRUBKHZUlVvjLFLetL5NeVunhBqnl0lSL4T7IGWOe+xmU6
         zLOSmJRlGyanca4PE7TP3dNIG0u/RySYVQTZ4+jNASfjIO/szdrlJqzMnJTtQMpG/X
         Oi/bEIUKZfMGA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] doc: Add tar requirement to changes.rst
Date:   Sun, 21 May 2023 22:23:36 +0900
Message-Id: <20230521132336.1279523-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521132336.1279523-1-masahiroy@kernel.org>
References: <20230521132336.1279523-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tar is used to build the kernel with CONFIG_IKHEADERS.

GNU tar 1.28 or later is required.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/process/changes.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index a9ef00509c9b..3c0074214d75 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl version
 bc                     1.06.95          bc --version
 Sphinx\ [#f1]_         1.7              sphinx-build --version
 cpio                   any              cpio --version
+GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
 ====================== ===============  ========================================
 
@@ -175,6 +176,12 @@ You will need openssl to build kernels 3.7 and higher if module signing is
 enabled.  You will also need openssl development packages to build kernels 4.3
 and higher.
 
+Tar
+---
+
+GNU tar is needed if you want to enable access to the kernel headers via sysfs
+(CONFIG_IKHEADERS).
+
 gtags / GNU GLOBAL (optional)
 -----------------------------
 
-- 
2.39.2

