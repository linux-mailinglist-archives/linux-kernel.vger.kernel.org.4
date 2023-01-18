Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106196712FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjARFG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjARFFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:05:49 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81158293;
        Tue, 17 Jan 2023 21:05:47 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1674018345;
        bh=M3t04Zy0atCE902Fgh2y0DAwQB2wVMBSJD6MkTZ6bYg=;
        h=From:Subject:Date:To:Cc:From;
        b=uHq8lr1w8OKaj6aQrz0gf3la4jxZedCggkK9vJIMPpJkXJe6CJkABMHzZSIfwd8E+
         MBG0FgGjkcUceLul5DY1AbzUCjZTDULwRIm8TPkCl9D9cU3Gl4X8wd4Us3MHRWdUmS
         +sPfOsEvwunUcvQMBJjj8eoEZ6Sj6HU6ycDEeHGE=
Subject: [PATCH v3 0/2] kheaders: use standard naming for the temporary directory
Date:   Wed, 18 Jan 2023 05:05:34 +0000
Message-Id: <20230117-kernel-kheaders-gitignore-v3-0-e686b93b0732@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB9+x2MC/42Nyw6CMBBFf4V0bU0fCNGV/2Fc9DHQCaSYDqCG8
 O8Wtm5YnpvccxZGkBCI3YqFJZiRcIgZ9KlgLpjYAkefmSmhtJCy5h2kCD3vAhgPiXiLI7ZxSMAb
 4WtdXipnK8vy3xoCbpOJLmRDnPo+j68EDX724OOZOSCNQ/ru/Vlu65HULLnkymgjagGNF/7+BiQ
 iF6ZwjjCyTT2rwzqVddKpq9XGN6I0f7p1XX9JATEJKwEAAA==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nicolas Schier <n.schier@avm.de>,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674018337; l=1205;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=M3t04Zy0atCE902Fgh2y0DAwQB2wVMBSJD6MkTZ6bYg=;
 b=+zr84N0ScXh1Wz0ia9akK7zR2TsVqvF99SU7tYzp7zzh/e0ZP4i9kObbUtQChPzklPZV0c1WuHZb
 pWSOHkhXC9IWIoLjV5ZjoPczHKEWDtivK3P52zPE0bUbFvGTX+9N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To: Masahiro Yamada <masahiroy@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Use standard naming schema for temporary directories
- Modify toplevel Makefile to also clean temporary directories
- Link to v2: https://lore.kernel.org/r/20230117-kernel-kheaders-gitignore-v2-1-1c29b3adf04a@weissschuh.net

Changes in v2:
- Also add the directory to clean-files
- Link to v1: https://lore.kernel.org/r/20230117-kernel-kheaders-gitignore-v1-1-2a3a070efd0d@weissschuh.net

---
Thomas Weißschuh (2):
      kbuild: also delete temporary directories
      kheaders: use standard naming for the temporary directory

 Makefile               | 5 +++--
 kernel/gen_kheaders.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55
change-id: 20230117-kernel-kheaders-gitignore-f0d73456cb6b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
