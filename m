Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F374659631
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiL3IR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiL3IQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:16:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4729B;
        Fri, 30 Dec 2022 00:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71E0BCE1732;
        Fri, 30 Dec 2022 08:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C6C433D2;
        Fri, 30 Dec 2022 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672388209;
        bh=X7rWCwfTU0kbYHKOs6RfE7hguYCBOBzdaoj6xLU1408=;
        h=From:To:Cc:Subject:Date:From;
        b=sJRlhu/mWb01zmA59tqUQX2RRdBGgYskdDAsQHtFreE8asMD+PGkrKrB4TVDPVfzs
         VPy3WDgixoKMDHQy28ZrIIKGLtTZgmyFRO8Uryul0hATtoPSGaKBm1N9PKQ7/BUtaY
         bU5YTYSD2POfm61x65qZpooVEtlMMlHq3xHbdtvslGjQbzrsEtx/1sCqig60fC7rDk
         XUW445ce0KT7Sz8LkTsWRTFGAy8Pl/tfGLvEym1oNdnGjzj++aJUXWrkZXTdhcse7V
         lZTf/D0SOzQM4NSgbJQHEdlufaXX9T/hTv+TSYTuErDbzi+xTKtTjMvCJGKKcHH6tu
         MgHbnNQ4NL0gw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] fixdep: remove unneeded <stdarg.h> inclusion
Date:   Fri, 30 Dec 2022 17:16:42 +0900
Message-Id: <20221230081642.1297675-1-masahiroy@kernel.org>
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

This is unneeded since commit 69304379ff03 ("fixdep: use fflush() and
ferror() to ensure successful write to files").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/basic/fixdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 7a408bb97478..37782a632494 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -94,7 +94,6 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <ctype.h>
-- 
2.34.1

