Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2F668E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbjAMG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbjAMG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:56:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B1714BC;
        Thu, 12 Jan 2023 22:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=v/GT59MkBIStouZ5bA5ISsCi2iWAi8szvTx0tj4+hnE=; b=u46K34HSQykmz5ADBnh7XhiyLl
        CHm6l4VLByZQ7/AFNniSg7YA/7YYjApUmgoePYCPHUzAOt42W5p2Za5CgxiLQFit+nF/Qk1nYxCAV
        v3QvD7SB8GcNrGIzMVdQwI1fhcAbHHw9jV9WnxqExJL5T12sH0cQamk2QJjcDlShsQNFpxGwuJkF2
        nZKMGKJh5vzdTO1nCHPeclhsqMCKyd20eMXnSfXdDORoqSHfw4WhZWuae21MmlBt+a75qRhGkz63H
        6xkLIKaiBeP0/NfICbbxStr6D7fl0mecpLCq4zPIMMOwJsJOJYgp35YdwRiGvXnM+2iUP9unSiJzJ
        yhwwe1Hg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDkd-000qs4-Kc; Fri, 13 Jan 2023 06:41:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: sky81452: fix sky81452_bl_platform_data kernel-doc
Date:   Thu, 12 Jan 2023 22:41:18 -0800
Message-Id: <20230113064118.30169-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the struct name and add a short struct description to fix the
kernel-doc notation.

Prevents this kernel-doc warning:
drivers/video/backlight/sky81452-backlight.c:64: warning: expecting prototype for struct sky81452_platform_data. Prototype was for struct sky81452_bl_platform_data instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/sky81452-backlight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -41,7 +41,7 @@
 #define SKY81452_MAX_BRIGHTNESS	(SKY81452_CS + 1)
 
 /**
- * struct sky81452_platform_data
+ * struct sky81452_bl_platform_data - backlight platform data
  * @name:	backlight driver name.
  *		If it is not defined, default name is lcd-backlight.
  * @gpiod_enable:GPIO descriptor which control EN pin
