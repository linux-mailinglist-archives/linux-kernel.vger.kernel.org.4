Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E870169424D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBMKIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjBMKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:08:17 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B9C166;
        Mon, 13 Feb 2023 02:08:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so10334738pjk.3;
        Mon, 13 Feb 2023 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElAU4CorO8bAZ8rKYwIlcUT8ZfpT8t881iGNYaHkIfg=;
        b=aMC4eto4PA34P9BDSmXpGxoYzfXGmN2U/yxW4+d6JyrBmu4utFRI5V+JBHGNbbbKH/
         cWiQEaQT8Es+nwPwMu5sWt5AH0NH10j5R9z6tNuhPPOAWmpgfAqReCqqjsfD++5pLy8h
         x8e/WVdPGW8V6Ax4bfJEjg7BtjaRHV6IWd0oyNyYVbMTZZKA4J08wOH+uGCbVSyxWtzR
         XJs9oUo3y/j12ywDwloWzPDsOwQD/TPP06z36CBGkokqeJ3OY+B+XtIaDbelnXCAvgy/
         RPRKRAZiYUszUo5Wbdd32C+QKa07nu7zl95m7pjUvKEvZ7tJ+1FkbopONMgLS7F/ezp2
         fdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElAU4CorO8bAZ8rKYwIlcUT8ZfpT8t881iGNYaHkIfg=;
        b=J97EgXOxvFIBzV68Z2/68BRTOIs1HQvYmL1pGop1O+LBDaHPv7xMPMVJ4RkXCoXChW
         gfi9JwH5nFK7/ZvPBv3NpVveFXPjgBGiijM3IWYg47tpqwodt2wo+kahYoHisM1AkXVz
         0Rr6kLZK20JOae8Hhum3KE2ML5oaQWzmZjTJwQgPRohq48qM5b60c/Fw4Lwn0kUXGNpk
         xrpVbnpDXpom1zaV8O7xARoTCvQ7UtrPKwxwTuk88qIYb9O9XcB+JS4Bk4ZXppVMLd9+
         e3AIQXq6AS63dDSoSHpFTKo4FBsSqNVncXX3cC5uAjzfHyIOzCbeCcgt1OLMMEQikw0i
         N44g==
X-Gm-Message-State: AO0yUKUlPKZToY4sAGr4qMRD2WdLMzJbaRlpaeQ78w0L+v4D1e5LTQcB
        1XGVTxBJj7GvjfbKyklzaBI=
X-Google-Smtp-Source: AK7set+yN2kUpLMvpm4uaucix/KMo1xOt9agM3NWlktkI391dCm40tZOelWolIy9Xuq35E6Ijp2fQQ==
X-Received: by 2002:a17:903:2308:b0:196:6162:1a76 with SMTP id d8-20020a170903230800b0019661621a76mr28923221plh.0.1676282894939;
        Mon, 13 Feb 2023 02:08:14 -0800 (PST)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id ji3-20020a170903324300b0019a9b73f229sm2088011plb.300.2023.02.13.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 02:08:14 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 54E3910558E; Mon, 13 Feb 2023 17:08:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] Documentation: admin-guide: Add toctree entry for thermal docs
Date:   Mon, 13 Feb 2023 17:07:59 +0700
Message-Id: <20230213100800.28333-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213100800.28333-1-bagasdotme@gmail.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=bagasdotme@gmail.com; h=from:subject; bh=+d0cgl/LUXYVN5X4ZZz4OWLihJeYOaWifkPF9BOwx3E=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMmveBhiq6sm2E+e55R8JDGZYdpKsWvV35ad2XjhwEP7k2sj Gq5Id5SyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiceoM/3Onrpf8v2vS3u97lKu5j7 FGaYrpVXesnxw0/yrX0btTduYz/OG9HV4guk94rU7m3J8Mu7hE2JdO+56sEJQ284wD046vZWwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warnings:

Documentation/admin-guide/index.rst:62: WARNING: toctree contains reference to nonexisting document 'admin-guide/thermal'
Documentation/admin-guide/thermal/intel_powerclamp.rst: WARNING: document isn't included in any toctree

Add toctree entry for thermal/ docs to fix these warnings.

Link: https://lore.kernel.org/linux-doc/202302121759.MmJgDTxc-lkp@intel.com/
Fixes: 707bf8e1dfd51d ("Documentation: admin-guide: Move intel_powerclamp documentation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/index.rst         | 2 +-
 Documentation/admin-guide/thermal/index.rst | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/thermal/index.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c872a8a1ddfa28..0571938ecdc868 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -116,7 +116,7 @@ configure specific aspects of kernel behavior to your liking.
    svga
    syscall-user-dispatch
    sysrq
-   thermal
+   thermal/index
    thunderbolt
    ufs
    unicode
diff --git a/Documentation/admin-guide/thermal/index.rst b/Documentation/admin-guide/thermal/index.rst
new file mode 100644
index 00000000000000..193b7b01a87d7e
--- /dev/null
+++ b/Documentation/admin-guide/thermal/index.rst
@@ -0,0 +1,8 @@
+=================
+Thermal Subsystem
+=================
+
+.. toctree::
+   :maxdepth: 1
+
+   intel_powerclamp
-- 
An old man doll... just what I always wanted! - Clara

