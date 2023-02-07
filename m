Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54FA68DDAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjBGQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBGQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:12:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962276A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:12:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so16107602plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=20K67K9edwRh0ZAf2p1ADQD2Xsmwqcm4t/xw8k9j5dk=;
        b=AoF+pK17KeWga6/gfHCf5yHbKRSGJFnueL7IsWIbszgBvma2IhRB52/8yoPorV3frY
         0tz93kpERxaUv//F2L5fpiY6l2QIZbFFUkipoOSwguDJluQgAMUzqDoXam4zbwgixYZX
         a8Q/34uIhjyoJ7hHEh9NbFk4EvLT4Nk6wMybk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20K67K9edwRh0ZAf2p1ADQD2Xsmwqcm4t/xw8k9j5dk=;
        b=c3gCTVERsg5o9O7Y+lPHC5GBMb7mi7aonKwNx6WtwwLkdsN0eLcvWmNrka/cuAvQsr
         eT2myeynEo3j0of3p1UU4VG3rMogDFbcQDba0s/fBG5046WhzhnPo8K5V2Dv1sYCK4bG
         maLD/EcrJkqAN5QstjApizmuIap7Dc/BdDCgJdlz7H6plw1uc14a/bcOCscu8HqYNLL1
         WISIh/yI2Xd8iTXrBWmtl+tETCnn0mFHz2eKQyLqX+Ps0f8WotAGuPuXC9BPojYjd4iH
         L75ynuTmC6CgHTENJdYPjJe+cbMqzQnRscdYpshKI5Gd0aCN9cSfXz5Xgzic2FQvehvl
         MyfQ==
X-Gm-Message-State: AO0yUKW6vd8h+pEIzSBd80NDI+X03PJnyozZHs9EmUGg7J1zHd+7Lnzp
        Yb5Nb317Jv5wNWWrjk2XJkkZFg==
X-Google-Smtp-Source: AK7set/18UhSh4y8tsQvk2Wb2TNH4BmdUcUYZKUCiuZ1gvdK/0bx2qtjXyO98XA9L1w3+ObchL8DFA==
X-Received: by 2002:a17:903:1252:b0:198:adc4:22a2 with SMTP id u18-20020a170903125200b00198adc422a2mr17215569plh.29.1675786358610;
        Tue, 07 Feb 2023 08:12:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:29fb:a635:f0df:f45a])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b00186a2dd3ffdsm9082889plc.15.2023.02.07.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:12:38 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        David Gow <davidgow@google.com>,
        Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF Kconfig entries
Date:   Tue,  7 Feb 2023 08:12:00 -0800
Message-Id: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since commit a28aad66da8b ("firmware: coreboot: Collapse platform
drivers into bus core") the Kconfig entries GOOGLE_COREBOOT_TABLE_OF
and GOOGLE_COREBOOT_TABLE_ACPI have been dead. They have no "help"
text and thus aren't user choosable. They also aren't "select"ed by
anything. They also control the compilation of no code.

Let's remove them.

Fixes: a28aad66da8b ("firmware: coreboot: Collapse platform drivers into bus core")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/firmware/google/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 9f190eab43ed..1bc7cbf2f65d 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -44,14 +44,6 @@ config GOOGLE_COREBOOT_TABLE
 	  device tree node /firmware/coreboot.
 	  If unsure say N.
 
-config GOOGLE_COREBOOT_TABLE_ACPI
-	tristate
-	select GOOGLE_COREBOOT_TABLE
-
-config GOOGLE_COREBOOT_TABLE_OF
-	tristate
-	select GOOGLE_COREBOOT_TABLE
-
 config GOOGLE_MEMCONSOLE
 	tristate
 	depends on GOOGLE_MEMCONSOLE_X86_LEGACY || GOOGLE_MEMCONSOLE_COREBOOT
-- 
2.39.1.519.gcb327c4b5f-goog

