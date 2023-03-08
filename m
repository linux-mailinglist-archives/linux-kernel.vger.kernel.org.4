Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA296B065D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCHLxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjCHLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:52:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AAA35AA;
        Wed,  8 Mar 2023 03:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50BE361773;
        Wed,  8 Mar 2023 11:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6CAC4339C;
        Wed,  8 Mar 2023 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276375;
        bh=7uyUzsavvn0QEnswHAxVeA6k/NagrwixLEe+w1g1YW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWpx5u4w/WjzWIG3/mhevYhQqttiYoDbw8Gck4AhykT5ME6A4HZwlOw79m8o0wIfz
         NllFc4NOksNjqZF1AnOuCqof2kGwz+OH51Hm7wOC5Y4EeryGCt801KOBx0aKsLS4hO
         p2e5U+P1cm0xAylP3gOPGuV1G6xWuvNsLsrqHRVhkGnMhb5tYOYakx1eA4wVulOLIA
         g0fzYfdu4aXmMh6d2YXNXW2R+oNCp2qT+ICAvHcXYBv5oac8qchWmLZVPDbp9xGtbq
         zlG/gAOFRidhaliuwGqHTXTMIlY+TnNeZ9NURu68d8vHCTXRohJmqbooGNh2BrkXiE
         q7XsYZFdH57mg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/8] scripts/mksysmap: remove comments described in nm(1)
Date:   Wed,  8 Mar 2023 20:52:37 +0900
Message-Id: <20230308115243.82592-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308115243.82592-1-masahiroy@kernel.org>
References: <20230308115243.82592-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not think we need to repeat what is written in 'man nm'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mksysmap | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 16a08b8ef2f8..697fc6653953 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -10,25 +10,6 @@
 #####
 # Generate System.map (actual filename passed as second argument)
 
-# $NM produces the following output:
-# f0081e80 T alloc_vfsmnt
-
-#   The second row specify the type of the symbol:
-#   A = Absolute
-#   B = Uninitialised data (.bss)
-#   C = Common symbol
-#   D = Initialised data
-#   G = Initialised data for small objects
-#   I = Indirect reference to another symbol
-#   N = Debugging symbol
-#   R = Read only
-#   S = Uninitialised data for small objects
-#   T = Text code symbol
-#   U = Undefined symbol
-#   V = Weak symbol
-#   W = Weak symbol
-#   Corresponding small letters are local symbols
-
 # For System.map filter away:
 #   a - local absolute symbols
 #   U - undefined global symbols
-- 
2.34.1

