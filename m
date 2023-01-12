Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE292666A72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjALEky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbjALEkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:40:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5934FD47
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:39:22 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bp44so15757050qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEOWdQVxD3a1NmDdQqe9Em9HTeFWiNoMcPhg7ZjUSi0=;
        b=kZ3gUdF3t426aQ3Iawl9KZNoYBAmnN7p76PJFf9uJMFmTruw6820R3gyruGsRlpJZT
         PP70FlnOe/QKv52euDkwoTl3qQx7LmkF1mz1ZgIxz1WBZTvV99OxHiHbtA9+1mGddT16
         KkQvIVgpQQs3K8gHyuy1TNRf13DBr1TAC/wSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEOWdQVxD3a1NmDdQqe9Em9HTeFWiNoMcPhg7ZjUSi0=;
        b=EMkeT1Pb32PR0OAvl07xOwoH3/qJIHZM8wjMOTvpOmvfxVh/pINZokJ91DIwdibwNy
         dHBTr63Z+omkZ7TMIupPkowwrHyupenLW3+eFf5TFBtLqYutzl9WEScPUmfnrihWqG1V
         DSh7amhNF8wCT76LmN6WkSlljlExzh0hwgg+wPbeI+a4bFjIZjRjgEtwPfcuwcpbYm4w
         pe6Z84cQfP1vnN4jmx1XPY5zO0GUcZfnRP6R0VU7SajVpiQqyrhYnVIYdzzMvJ4pixIT
         OxQy0ZvXbq2zpAyedxoEUToedH5EGGWmYJW/iyT5oy/PkqPLS4Q2R7Mqgq1Wq0UlbbKV
         wlaw==
X-Gm-Message-State: AFqh2krmvq0m4wwBGHXRMGmlBTSRNwiqPmH1ciDvnCZ+AUq9bG+dKG11
        2QHHf2KnnjMzDFPpjVIklKyF2HiQzNw+rhYfPsI=
X-Google-Smtp-Source: AMrXdXtpFRHAFxAfQAdiCKMn0OSl0VZUuMY9uZQnWZiSR2X2JjQxLd1hdmQnSdYOeLhXeWeO+pOj8g==
X-Received: by 2002:a05:622a:1a19:b0:3af:a8d8:e56f with SMTP id f25-20020a05622a1a1900b003afa8d8e56fmr14616280qtb.57.1673498361599;
        Wed, 11 Jan 2023 20:39:21 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006cbe3be300esm10166147qko.12.2023.01.11.20.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:39:21 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Wed, 11 Jan 2023 23:39:12 -0500
Subject: [PATCH] kconfig: Update all declared targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-kconfig-v1-1-a921f03670f0@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAPCOv2MC/x2NQQqDMBAAvyJ7biCrjWC/Ij3EuEkWaZTdUgTx7
 8YehxmYA5SESeHVHCD0Y+W1VMBHAyH7ksjwXBla23YWEc0S1hI5GXJD6NE9o7M91HrySmYSX0K+
 +4/XL8ktNqHI+38xvs/zAuZsBa1yAAAA
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673498361; l=2368;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=eZ217i7SRnCD4kBDITr/vA6la8yTXh9brXv1zsXg0hE=;
 b=4MjI4j364lvYSPTIAjrQcc/Ps9e5ollqPgf42JPljyvYWYFHrGPwaDWsvUvplgREb9I7U9ahC7rk
 gLmK1llrCxVOWj8wblL+oDRvPn6t8gEYgrAPJekRZo5HIxpf18wc
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently qconf-cfg.sh is the only script that touches the "-bin"
target, even though all of the conf_cfg rules declare that they do.
Make the other scripts touch all declared targets to avoid
incompatibilities with upcoming versions of GNU make:
https://lists.gnu.org/archive/html/info-gnu/2022-10/msg00008.html

e.g.
scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/nconf-bin'.
scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/mconf-bin'.
scripts/kconfig/Makefile:215: warning: pattern recipe did not update peer target 'scripts/kconfig/gconf-bin'.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 scripts/kconfig/gconf-cfg.sh | 2 ++
 scripts/kconfig/mconf-cfg.sh | 3 +++
 scripts/kconfig/nconf-cfg.sh | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
index 040d8f3388202..d98c2ed09b158 100755
--- a/scripts/kconfig/gconf-cfg.sh
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -3,6 +3,7 @@
 
 cflags=$1
 libs=$2
+bin=$3
 
 PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
 
@@ -31,3 +32,4 @@ fi
 
 ${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
 ${HOSTPKG_CONFIG} --libs ${PKG} > ${libs}
+touch ${bin}
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index 1e61f50a59050..3719e1607d34a 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -3,10 +3,13 @@
 
 cflags=$1
 libs=$2
+bin=$3
 
 PKG="ncursesw"
 PKG2="ncurses"
 
+touch ${bin}
+
 if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	if ${HOSTPKG_CONFIG} --exists $PKG; then
 		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index f871a2160e363..a0edc427719f0 100755
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -3,10 +3,13 @@
 
 cflags=$1
 libs=$2
+bin=$3
 
 PKG="ncursesw menuw panelw"
 PKG2="ncurses menu panel"
 
+touch ${bin}
+
 if [ -n "$(command -v ${HOSTPKG_CONFIG})" ]; then
 	if ${HOSTPKG_CONFIG} --exists $PKG; then
 		${HOSTPKG_CONFIG} --cflags ${PKG} > ${cflags}

---
base-commit: e8f60cd7db24f94f2dbed6bec30dd16a68fc0828
change-id: 20230111-kconfig-e59c6154f506

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
