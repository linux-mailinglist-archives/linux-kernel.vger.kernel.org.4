Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DEF6B5B46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCKLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCKLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:43:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C2199D3;
        Sat, 11 Mar 2023 03:43:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y4so1429950edo.2;
        Sat, 11 Mar 2023 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678534987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D71/O6XT3CiIUnyuH8xQ8ENUScY89MVb0jVzlc2a7Q=;
        b=q4K6gdMDvO5YUhohxfUi17YD9TvFxUUWGJq9bqgCJNtOY6oYHHS2bf42UYD/m3TqB7
         0JUwCPSojAxODI2JfzW8Q0WRb4qcNqIvA7E2YZHaNolsOXheJLX3Amwtaqk6DSrcL2YC
         UFjhVqEwyYetn9V56R+uvdSuzGKWJtkGwyXQboBb3HInjxG6mNiraXY73dNe7nna3YYY
         o20aKA/S4bvieCykYVN8uOb5I0suwOPRwnn2LELqoCsudJp/yr9M9ZjzVXX/OP6mVXQw
         HEpGRt1kXlRwbAuD+Twe5SJNKNRB7oqrmf4ff7gq6+3ZGaVvnOCE6Qzfa++d8st8ubQb
         recQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678534987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D71/O6XT3CiIUnyuH8xQ8ENUScY89MVb0jVzlc2a7Q=;
        b=PrHXinztmv1dYBrqldiP31o2SPlRHTfwMEL6MybF++AVJ4FJybcpW9lG78DJRFMB+x
         fkW6FPXUpNs1mn3FkVXOqMrKZukHbeAmtBW1YQJvipGPrcz99l4m3Dgy3q//xXkgq5fV
         bAVj/fCp09gZmu0lWc2cV311ErlvuQdv+FmIL+SJ3SE59M1wt0aPnInZn8r1/22JLj20
         wbYs0uWz3+6iLbaE7xtebb2sVqDOq+KIhfDrD+fT1ujUjmu8P4S0XBozmSfCAC5ctgUD
         UV9RNguh37HP9BHtnr6UO48rHrcViiOhLEL4K0x4b9gU/NxErrwKwotuPL+nc1mMQDRY
         JPUQ==
X-Gm-Message-State: AO0yUKWpHiFDwJM63C2Ykn5UqOMdd6Rsz94TnfhWRgQERoTXRMBsMBUW
        0ySPkPHRpo4qNZwIiClYqg==
X-Google-Smtp-Source: AK7set/MUcPdeVh55td7iQQ8Habh/syYbtLF/GCfO+hGAu8ToRvXBKqmsic6w+8D9N1xLS8fVB06TA==
X-Received: by 2002:aa7:c1c4:0:b0:4c5:bc48:d422 with SMTP id d4-20020aa7c1c4000000b004c5bc48d422mr23184335edp.7.1678534987480;
        Sat, 11 Mar 2023 03:43:07 -0800 (PST)
Received: from localhost.localdomain ([46.53.248.97])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm1088440ede.24.2023.03.11.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:43:07 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     masahiroy@kernel.org
Cc:     adobriyan@gmail.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] menuconfig: reclaim vertical space
Date:   Sat, 11 Mar 2023 14:42:48 +0300
Message-Id: <20230311114248.36587-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311114248.36587-1-adobriyan@gmail.com>
References: <20230311114248.36587-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig has lots of vertical space wasted: on my system there are
17 lines of useful information about config options and 14 lines of
useless fluff: legend, horizontal separators and shadows.

Sitation is even worse on smaller terminals because fixed vertical
lines do not go away, but config option lines do, further decreasing
informational density. Minimum reasonable 80×24 text console has only
10(!) lines of menus presented which is less than half of the screen.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 scripts/kconfig/lxdialog/menubox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 5eb67c04821f..dc608914c636 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -183,14 +183,14 @@ int dialog_menu(const char *title, const char *prompt,
 	if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 
-	height -= 4;
+	height -= 2;
 	menu_height = height - 10;
 
 	max_choice = MIN(menu_height, item_count());
 
 	/* center dialog box on screen */
-	x = (getmaxx(stdscr) - width) / 2;
-	y = (getmaxy(stdscr) - height) / 2;
+	x = 0;
+	y = 2;
 
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
-- 
2.39.2

