Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050BC6FD152
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEIVY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjEIVY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6797DB3;
        Tue,  9 May 2023 14:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E08E763724;
        Tue,  9 May 2023 21:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC24DC433EF;
        Tue,  9 May 2023 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667255;
        bh=4knAG3RUm6soJKDwALrqcaCFg+q9W4kn1/iRmmyAGQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Baq3phak4Vn55erawpMcn2EnMot/Dn7mBRK7/oAi1hqbluXJyqFSmuABNOwuxBJrX
         DoY9FVwwssi7jNfSr8mDnewcujRWwHCACKHtqEGKryOd3hS4ceK+hYTj0dmWHi0aeo
         vG8hHY91GaXX97gSwR/muGriTzMtPvItLiRooA/1M8DwD/lO0degtA3FtrDi2mzKF2
         62h94YklSmccY6GpHOkMlHFwa2QSapiHg0KL1Fyyh9eeH8RBlDVDl1ImMZhY+jpJY9
         RjMEm7PyySSATEy31HCl2LKVWiVcIkXeL/rkwyqFcFFX49vUH8bmVRdSr+Gadwg7gb
         BDMCOLQaQeMgA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vicki Pfau <vi@endrift.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, rojtberg@gmail.com,
        nate@yocom.org, mkorpershoek@baylibre.com,
        pgriffais@valvesoftware.com, chaorace@gmail.com,
        s.demassari@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/5] Input: xpad - add constants for GIP interface numbers
Date:   Tue,  9 May 2023 17:20:41 -0400
Message-Id: <20230509212044.22294-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212044.22294-1-sashal@kernel.org>
References: <20230509212044.22294-1-sashal@kernel.org>
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

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit f9b2e603c6216824e34dc9a67205d98ccc9a41ca ]

Wired GIP devices present multiple interfaces with the same USB identification
other than the interface number. This adds constants for differentiating two of
them and uses them where appropriate

Signed-off-by: Vicki Pfau <vi@endrift.com>
Link: https://lore.kernel.org/r/20230411031650.960322-2-vi@endrift.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 70dedc0f7827c..0bd55e1fca372 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -489,6 +489,9 @@ struct xboxone_init_packet {
 	}
 
 
+#define GIP_WIRED_INTF_DATA 0
+#define GIP_WIRED_INTF_AUDIO 1
+
 /*
  * This packet is required for all Xbox One pads with 2015
  * or later firmware installed (or present from the factory).
@@ -1813,7 +1816,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	if (xpad->xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+	    intf->cur_altsetting->desc.bInterfaceNumber != GIP_WIRED_INTF_DATA) {
 		/*
 		 * The Xbox One controller lists three interfaces all with the
 		 * same interface class, subclass and protocol. Differentiate by
-- 
2.39.2

