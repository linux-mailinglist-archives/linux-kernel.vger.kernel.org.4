Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E346F4F50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjECDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjECDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:54:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B741730;
        Tue,  2 May 2023 20:54:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf2ede38fso32476155ad.2;
        Tue, 02 May 2023 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683086063; x=1685678063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6q3+C/O6BV/0gC+jrMbg3MwoGAyt7Cv6nHU3v3zys3I=;
        b=rDNoWnGhJwAj76Ge80sW8/InyLnBi7jwU23z97T9EoARIFUNIbUaF+GQ2D6DSU+vll
         BsowuuPL6I9xhwUYyaiYWWm3C01pX1qNTK7LzYk/ZiqHGEhsel0iJBK5GbeC5O/cIUkL
         dryGwMTYB0/Lsxn6sOHxgqg0DWg6rCzHVtKM6OfSmGKsvLXR1l6emV6kQY8nKt6ppTM8
         K/k1e28rmsxf4toOeLGhuN/YtinfmiH6IjLZGLmiYE4+q512hzPS9bGYvhb2la5246Ka
         cdqT1bMUPyYmrk6CgHTVwxzc7wR1NU2mAmSVJgTUU9GMskLiEM/Lfa3XUrwrP6/sBLay
         ErgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683086063; x=1685678063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q3+C/O6BV/0gC+jrMbg3MwoGAyt7Cv6nHU3v3zys3I=;
        b=TMu3lRfxienkkazSMuH+fqtcuixaxCO60VNn6qZhk0L4dztKHMbafn8zWN9l0k0LwN
         V0nHfCSTCi/x/e6BxTGFdbfaiJ4zn29wFuTpZ2X2al6UB/UqikYqn/5OfpVu0bkjKTa4
         fqySOsZgncq/vrdsVWzaPavqcC4KTTZOZ5U54cTKMxZdDBJt0DMoi2QN1qkGd47WyeG0
         K/tcMlwoFgjGCQMP69a0VDt4feNYPPESbxvVMvOim4hk6KUndktCrY8hpMuvcHJyiQ44
         iuoMaA9WfAvJAX4WnUEPM/mZs1wpptLgBW+HuyBRHRiVfDLtyn2gtk3Mau6FN27rcndH
         xsuA==
X-Gm-Message-State: AC+VfDwKN3iuzbpJpKS+ZPwoELnvNvtlEK4L7GWsGTbOCnrikSnhWj6Q
        oKXAaHyGV1PsDk5M8pSdfPM=
X-Google-Smtp-Source: ACHHUZ4FXkEzCEQcEM1H8rckNkqvjTZZ1HLLDrm2ZrxU2DPEZFArr8JYzLEEi7yxud81InKVTsb4jg==
X-Received: by 2002:a17:902:e88d:b0:1a6:6fe3:df8d with SMTP id w13-20020a170902e88d00b001a66fe3df8dmr899006plg.8.1683086063246;
        Tue, 02 May 2023 20:54:23 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-11.three.co.id. [180.214.233.11])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902aa4700b001a1faeac240sm20512918plr.186.2023.05.02.20.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 20:54:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EA49D10622E; Wed,  3 May 2023 10:54:19 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux ALSA Subsystem Development <alsa-devel@alsa-project.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ALSA: docs: Fix code block indentation in ALSA driver example
Date:   Wed,  3 May 2023 10:54:16 +0700
Message-Id: <20230503035416.62722-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=bagasdotme@gmail.com; h=from:subject; bh=6LXELRL34BN4LPhBXSHO4pfAXrYd4OlwOyi8Y9pLNbI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCmBt16EPVP9HMJw1cC8qGTVAZcZf8692rCv/c3y4A//r 828EGOb3FHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJqLcz/HdaG928N+2fsO23 7GWPuuIr9ObPqFrxL47fLLTKoTT8rQzD//LruWeVlM387uu+VpnT0rnkSfrzML3a7PZ5HdJPUph mMQIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reports htmldocs warnings:

Documentation/sound/kernel-api/writing-an-alsa-driver.rst:3997: WARNING: Literal block expected; none found.
Documentation/sound/kernel-api/writing-an-alsa-driver.rst:4004: WARNING: Literal block expected; none found.
Documentation/sound/kernel-api/writing-an-alsa-driver.rst:4009: WARNING: Unexpected indentation.
Documentation/sound/kernel-api/writing-an-alsa-driver.rst:4035: WARNING: Literal block expected; none found.

These are due to indentation of example driver snippets which is outside
the code block scope.

Fix these by indenting code blocks in question to the scope.

Fixes: 4d421eebe1465d ("ALSA: docs: writing-an-alsa-driver.rst: polishing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/linux-doc/202305021822.4U6XOvGf-lkp@intel.com/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../kernel-api/writing-an-alsa-driver.rst     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index c0f97b5e424969..4335c98b3d828f 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3994,21 +3994,21 @@ Driver with A Single Source File
 
    Suppose you have a file xyz.c. Add the following two lines::
 
-  snd-xyz-objs := xyz.o
-  obj-$(CONFIG_SND_XYZ) += snd-xyz.o
+     snd-xyz-objs := xyz.o
+     obj-$(CONFIG_SND_XYZ) += snd-xyz.o
 
 2. Create the Kconfig entry
 
    Add the new entry of Kconfig for your xyz driver::
 
-  config SND_XYZ
-    tristate "Foobar XYZ"
-    depends on SND
-    select SND_PCM
-    help
-      Say Y here to include support for Foobar XYZ soundcard.
-      To compile this driver as a module, choose M here:
-      the module will be called snd-xyz.
+     config SND_XYZ
+       tristate "Foobar XYZ"
+       depends on SND
+       select SND_PCM
+       help
+         Say Y here to include support for Foobar XYZ soundcard.
+         To compile this driver as a module, choose M here:
+         the module will be called snd-xyz.
 
 The line ``select SND_PCM`` specifies that the driver xyz supports PCM.
 In addition to SND_PCM, the following components are supported for
@@ -4032,7 +4032,7 @@ located in the new subdirectory, sound/pci/xyz.
 1. Add a new directory (``sound/pci/xyz``) in ``sound/pci/Makefile``
    as below::
 
-  obj-$(CONFIG_SND) += sound/pci/xyz/
+     obj-$(CONFIG_SND) += sound/pci/xyz/
 
 
 2. Under the directory ``sound/pci/xyz``, create a Makefile::

base-commit: 348551ddaf311c76b01cdcbaf61b6fef06a49144
-- 
An old man doll... just what I always wanted! - Clara

