Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC6666BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjALICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjALIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:01:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334F5F52;
        Thu, 12 Jan 2023 00:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E8F0B81D91;
        Thu, 12 Jan 2023 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC57C433F0;
        Thu, 12 Jan 2023 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510503;
        bh=CuXBLE/czGJvRweLf+zsexxRo7z7VpvR+CuQ+9RVh8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2vlR8rbs6xbEznS0QD6/gtkQNxmGonMZhbkZ8czy6dZPS/BYBPnZxHONKYYY8GFa
         09AG6H80lRtGHti2MC7ERf2g2XYE7ChuSiztg4aSdoe0WMdhoTcJOxonkQVt/YxzA3
         uZgu2GzYWytIWMsF8bssNpd6/c0gUhhE9KHXLAMW3x/d6S/IMIzHO7SRUB7np2iuAU
         qW6tADz6TAhhJin7r4+xaOMTzAM0afJ8pu0pNxxqNTBq+/lzcnhGlbgcX746F8H/ae
         oqQ1wNaoLSEpnQVpaYmv/ZG4ZjvNhYgWoJaoiL5tyRFcIxMxd4zBuAq203kKZ18Sap
         Y4+3hJ6+JxiPw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/11] tty: vt: remove reference to undefined NO_VC_UNI_SCREEN
Date:   Thu, 12 Jan 2023 09:01:28 +0100
Message-Id: <20230112080136.4929-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
References: <20230112080136.4929-1-jirislaby@kernel.org>
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

NO_VC_UNI_SCREEN is defined nowhere. Remove the last reference to it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7e5baf9f8ad8..561c82e120cf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -495,9 +495,6 @@ int vc_uniscr_check(struct vc_data *vc)
 	unsigned short *p;
 	int x, y, mask;
 
-	if (__is_defined(NO_VC_UNI_SCREEN))
-		return -EOPNOTSUPP;
-
 	WARN_CONSOLE_UNLOCKED();
 
 	if (!vc->vc_utf)
-- 
2.39.0

