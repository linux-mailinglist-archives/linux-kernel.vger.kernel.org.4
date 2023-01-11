Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD776657DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAKJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjAKJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:42:00 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D165A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:38:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so22602245lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGfMmti0tcBk849TNctDrJD/DdViE/kGegRrFRXF0+w=;
        b=I3JGGYF0CKdLgr0kR0RGhC3r/euBYQNKc8KfzPB5an77JOrlD49a9Tzv+Xmqt0WkIk
         OVu590V2GiOYsDVJzpnK6yJbZF/Bb/idJ2NfdfOI+pDCqZ7k8j94BsSsFZyw0+OuizZR
         9tsvVYM646h4AdSE/qcrbCsRhckqU2aRC7J6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGfMmti0tcBk849TNctDrJD/DdViE/kGegRrFRXF0+w=;
        b=45bSfvCsJrnyNj4PtU4oxewIgGD8rf8IgNTaavRGP/f20Jopu1Y5OoRD5iWouYfy2y
         yVd62hWyyZQz4IuYqun7ePDOhDAwrNJlAIlkyZqw84B4l3QUWIMyTsoRaY+SdNz3eZ9Q
         MUvf/KJbrtdDBZ13gHNeYgc8PpShWHegNDX1/5Si7Y7fXBn4Tvdq6cZ5aPpZ0kfyvBGL
         MCwACxRiK2B5KI+UQyX0AqcfqjuekrtAEfUBWde5P2Aw3D1H2DHt4M3E/0ZTqeyWH+DQ
         RraFFYWUXexMF+trJkEaBEMhTPYYJdHmCYF4vUAW4KBgbbAkPuOWlLv8Bmqg/1w2s7Xl
         q9AA==
X-Gm-Message-State: AFqh2kqQtH1YiFl6fv5N5jX8SGi2ZZKCw2lP7NcuLp7k3KpfDX+xqcTZ
        6jOjuuq0OB/G1wbyT7uf5ZBhCQ==
X-Google-Smtp-Source: AMrXdXvh0xS7e+f9Wp/CykjfBN+JGmD9WQs0lCPI6x10zh52KTtTGHOaV21u8KP9yLr/zWf/JTn5Rg==
X-Received: by 2002:a05:6512:220c:b0:4cc:7140:7de3 with SMTP id h12-20020a056512220c00b004cc71407de3mr2438410lfu.8.1673429907559;
        Wed, 11 Jan 2023 01:38:27 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w19-20020a2e1613000000b00284448243e0sm1278619ljd.87.2023.01.11.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:38:27 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] init/Kconfig: fix LOCALVERSION_AUTO help text
Date:   Wed, 11 Jan 2023 10:38:22 +0100
Message-Id: <20230111093822.2934184-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was never guaranteed to be exactly eight, but since commit
548b8b5168c9 ("scripts/setlocalversion: make git describe output more
reliable"), it has been exactly 12.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 0958846b005e..015dbb63b61a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -204,7 +204,7 @@ config LOCALVERSION_AUTO
 	  appended after any matching localversion* files, and after the value
 	  set in CONFIG_LOCALVERSION.
 
-	  (The actual string used here is the first eight characters produced
+	  (The actual string used here is the first 12 characters produced
 	  by running the command:
 
 	    $ git rev-parse --verify HEAD
-- 
2.37.2

