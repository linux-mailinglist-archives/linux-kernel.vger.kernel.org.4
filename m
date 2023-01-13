Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA5668E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjAMGxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240292AbjAMGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:53:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E887FEFC;
        Thu, 12 Jan 2023 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CZndrX7FEURWHOAwiYu3xHuWh6ssA4eMw3Z0SplkeKQ=; b=sOA5L4ut9cOcIFBpFJdOQ963PB
        SGu+ocjoZj98fbqNzwKUeHXUPTbFl+R+TsQsUPRo9u0bF7mlU25KzrTsyW5s9XBfAA5uDIrnJ/H9b
        Fekyjp3yACowDObROPD5qbGopILE2/bZV7LwZo2mGax17NrSdIBXIGlb9tANrvtW86XRU+wirRzIO
        HXyj4x3MwJciFVB2WqM9c5JD5AJsNF30QJgXGu5m7wyZOO0YyUTgm5+NOJSRHnqZLdqcHZcLYtF3R
        R9NQzL3sDIczM681J0e44Ol1mMB2qpLfvH2zt9fMaJB9Hs1F/BSEvPpAxa5CcBxPa1/aGTHvDW0Ka
        5Ul0g2FQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGDg7-000qB2-N2; Fri, 13 Jan 2023 06:36:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: fbmon: fix function name in kernel-doc
Date:   Thu, 12 Jan 2023 22:36:39 -0800
Message-Id: <20230113063639.6940-1-rdunlap@infradead.org>
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

Fix a kernel-doc warning by correcting the function name in the
kernel-doc comment:

drivers/video/fbdev/core/fbmon.c:1073: warning: expecting prototype for fb_get_hblank_by_freq(). Prototype was for fb_get_hblank_by_hfreq() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1050,7 +1050,7 @@ static u32 fb_get_vblank(u32 hfreq)
 }
 
 /**
- * fb_get_hblank_by_freq - get horizontal blank time given hfreq
+ * fb_get_hblank_by_hfreq - get horizontal blank time given hfreq
  * @hfreq: horizontal freq
  * @xres: horizontal resolution in pixels
  *
