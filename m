Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437D6267F5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKLIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:10:29 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8EDF84;
        Sat, 12 Nov 2022 00:10:19 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.85]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MtOT0-1p7ahU0wSU-00upPz; Sat, 12 Nov 2022 09:07:26 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id B90403C0CA;
        Sat, 12 Nov 2022 09:07:23 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 2AB5D974; Sat, 12 Nov 2022 09:07:22 +0100 (CET)
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
Date:   Sat, 12 Nov 2022 09:07:15 +0100
Message-Id: <20221112080717.17914-2-nicolas@fjasle.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221112080717.17914-1-nicolas@fjasle.eu>
References: <20221112080717.17914-1-nicolas@fjasle.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yKj3ZP75Gdj5YImIX6eR/DV7AIoyVVngCfnzPfMP29FALDHNzL/
 rBKQaLB+I8TufxOStiBMCzVf1EUPSejmuOKK3hbJbsqRUlOexQdvZcwx3vLKB00Q9j0c/kK
 I7U2ZQQHx+qSVWoveu72UM0vrczAn5AaBHIoLt1lqKrLugnXzqvbY8d7pO5YAAhjyCJHHVo
 wq9g7La2g0OFtXc0GoA8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CRxcBf8k/s4=:XOaSSCAfq8gZ0g+rQrF2PZ
 cs923H5tnBTKLYoFpUMvsYypTY3sZSJrFlJaWHOPtWaT4y1VZ5TYsS2rumJp4jraSbjixHRqr
 u1rmhR/8M9xwHqz82APlXGVFMpTzm2PQwAilBhOKgx7YGQEswqNJ+MKwkFdSEE5n1kF86Qf90
 9siN6WkvHzMiPMSKjve8+szskjO2D3d70f6/Nahw4cP6GstOVYrR1lZm5YgACjaidl5S3Bm4M
 568vTAdOPFtovXKCyIT1P41K9/0zPKtQkZuNhRuWLrxOTBTGYdcmy8SrxAU3s1tgNUq10JKOp
 PuIE+7cpdQITXh03+15dCYlLt9ERqcQhOytV5w0aS0jD/1wcwrehsknhNpzOD8f0QKLlcyjqY
 KiIbxR3ABxfT5JoDkOU09TxuLJDGJHCCFqdo4ET/lW9N/blpJEOhLdLZhgEtiJgzrUWchmyGO
 Olojip0+TnfqF/WfGy1dbhPRKNUTQ+aWOEYJsz4AC3yOawKRpEj0jCY/s74UTONl4LuLGP/Ok
 2mM9CabI2ISr8rmBJb4r0sYW4YhFChdegAfwQJ0MmIs5XDxHMO/4StMMP2VUY9cE0ZdjZFgNt
 wfCcXY6GZA8q9UfRtEH7Y7Y07cGDWO9UNvt5bWpBCW/4aFm8+7K00LSyu9wqYa/vESf6Wul5y
 NQxkI17spz4M1BtNQh3zHlNS9Xivcv+UK3NJZ+x+PBu3V3Cx/NMJ5a4KX3ydkODC7cUyrrXfn
 BADFgoCVudIM2zLLKWnK1F8XC4oOLi90UNaCsNhr3FDEriPvszFl3ZnXVzyGRhv+AM4o/1ocw
 LlHxm+B
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Nick, add Nathan and myself to Kbuild reviewers to share more
review responsibilities.

Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Nathan Chancellor <nathan@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

Changes since v1:
  * Also add Nathan to Kbuild reviewers (Nick, Nathan), and update commit msg

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..f37c6a9a8fac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11084,7 +11084,9 @@ F:	fs/autofs/
 KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
 M:	Masahiro Yamada <masahiroy@kernel.org>
 M:	Michal Marek <michal.lkml@markovi.net>
+R:	Nathan Chancellor <nathan@kernel.org>
 R:	Nick Desaulniers <ndesaulniers@google.com>
+R:	Nicolas Schier <nicolas@fjasle.eu>
 L:	linux-kbuild@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
-- 
2.37.2

