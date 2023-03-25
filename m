Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE996C8EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCYPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCYPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:18:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D4EFBC;
        Sat, 25 Mar 2023 08:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D18BB8069F;
        Sat, 25 Mar 2023 15:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC28C4339B;
        Sat, 25 Mar 2023 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679757505;
        bh=tkTD9Qnj5tYLcNVdDjFqSCc+FFZm5ICwkNKYESjvPsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOLqNfQ9egGUy2ohUakVYFVvreOhZDOQZYaMBXZcfSO1PPtTbDOLUT6A6zvkHc3CU
         mE/PZh3uK8Gwh4r9WNeHmAHVwipExlJ6udVHLvev8mG1+2+DBbEZTayYSyZt7JcD2q
         PbmRNwfZq0x5DNoxpcC+MkpEWY6c0nUsHb3RF8KmHy1Exp49syzfydhZdJf+CdPbHc
         X1Apl3mDGcXitE+thNEvdgJtgaGoMGY52oix+62lq15wYSB6YE4+vnx7PtOot0P+D5
         7F/ZA/vp6QcZHDMIVTmqm3K3A/Fypt66u3TYXlIhRlFUYmQby15YDdhPz6keFRj0Ao
         Ng/tabBRYRgXw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] kconfig: menuconfig: remove unused M_EVENT macro
Date:   Sun, 26 Mar 2023 00:18:16 +0900
Message-Id: <20230325151817.2651544-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230325151817.2651544-1-masahiroy@kernel.org>
References: <20230325151817.2651544-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not used anywhere.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lxdialog/dialog.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index bd2da3a928a7..347daf25fdc8 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -209,14 +209,3 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 		     int width, int list_height);
 int dialog_inputbox(const char *title, const char *prompt, int height,
 		    int width, const char *init);
-
-/*
- * This is the base for fictitious keys, which activate
- * the buttons.
- *
- * Mouse-generated keys are the following:
- *   -- the first 32 are used as numbers, in addition to '0'-'9'
- *   -- the lowercase are used to signal mouse-enter events (M_EVENT + 'o')
- *   -- uppercase chars are used to invoke the button (M_EVENT + 'O')
- */
-#define M_EVENT (KEY_MAX+1)
-- 
2.34.1

