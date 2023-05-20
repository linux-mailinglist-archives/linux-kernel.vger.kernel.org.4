Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83A770AA30
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjETSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjETSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD92EE50;
        Sat, 20 May 2023 11:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 712B360F11;
        Sat, 20 May 2023 18:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0541BC433D2;
        Sat, 20 May 2023 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606985;
        bh=+c/hg+pn6YqJJKirv+KPqU8DGCISXulUy2B44R/iVk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ER6+eNDu+neXYN1LpV4HfqosTz4IbqeG6jP5HaSRmg51uWLrdnWyObaRoFp/TmSHA
         bEKHHp2O+y3FHJKOKQIvvoZ4ogONzk2Ta7xJHjhW3JsfcDReqI8j8NUjZfnV9xizRG
         H/YMBXwnSliq5bDypuoscypWMrRCt//sIde84PTmwuwFC/PP76v6hQ4tB3MWklDH2I
         GxdniEETh044KXIw1F3Dmn4u6GIt6W5V5z9piU9zmiaYTkBMnZ/5V37dOPZWE8Veic
         mgRStWUAn9SeDA8X2LJ49x0X7UgzKzywOeXkIgs8wdZH6b2SdI7+JXIbzPsLh1j92o
         WoCiM5blsKssQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        daniel@ffwll.ch, tzimmermann@suse.de, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 08/11] fbdev: modedb: Add 1920x1080 at 60 Hz video mode
Date:   Sat, 20 May 2023 14:22:11 -0400
Message-Id: <20230520182215.845131-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182215.845131-1-sashal@kernel.org>
References: <20230520182215.845131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit c8902258b2b8ecaa1b8d88c312853c5b14c2553d ]

Add typical resolution for Full-HD monitors.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/modedb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 6473e0dfe1464..e78ec7f728463 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -257,6 +257,11 @@ static const struct fb_videomode modedb[] = {
 	{ NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3, 0,
 		FB_VMODE_DOUBLE },
 
+	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		FB_VMODE_NONINTERLACED },
+
 	/* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
 	{ NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-- 
2.39.2

