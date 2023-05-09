Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473D86FD160
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjEIVZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjEIVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9003C0D;
        Tue,  9 May 2023 14:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FDA363732;
        Tue,  9 May 2023 21:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C05C4339C;
        Tue,  9 May 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667274;
        bh=NlewJOv8ex2UPdvCvopsZ7X2dnQYkcPRexAAO0sTHEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCISQLa2IGFO3cfkafTWVvg2yX5CT9C73xXMT8cXGdDAVgc+M9q6NOqXjKQQ/YK94
         BQftRB0wSHti7GsRGie3+lkt5s469iZy1b9WujtCE5DomlR45/8gPPQClE/t5ZLMgy
         WlU3OfM1HHmNfCuMExpqKnteVTBg6MWJPzFV8mTPOn+wbvwRtIsu1X8Vdh0LlhCOmN
         7yv3agHOX+8KkQuk9O25xM4GH6PWY51vV86iU3g8pggasGimi/TswQlI2MohHkGPOm
         /w0BkOcWf8hscJ//q7TOsmwrp8Qe26jFE4ryoz+542792a5WFIQBxZ2c2yQGzac6Hi
         X46O6nSNgwjJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vicki Pfau <vi@endrift.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, rojtberg@gmail.com,
        nate@yocom.org, mkorpershoek@baylibre.com,
        matthias.benkmann@gmail.com, chaorace@gmail.com,
        s.demassari@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/2] Input: xpad - add constants for GIP interface numbers
Date:   Tue,  9 May 2023 17:21:10 -0400
Message-Id: <20230509212110.22736-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212110.22736-1-sashal@kernel.org>
References: <20230509212110.22736-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index c125cd42faee7..0a85f0817662a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -503,6 +503,9 @@ struct xboxone_init_packet {
 	}
 
 
+#define GIP_WIRED_INTF_DATA 0
+#define GIP_WIRED_INTF_AUDIO 1
+
 /*
  * This packet is required for all Xbox One pads with 2015
  * or later firmware installed (or present from the factory).
@@ -1827,7 +1830,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	}
 
 	if (xpad->xtype == XTYPE_XBOXONE &&
-	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
+	    intf->cur_altsetting->desc.bInterfaceNumber != GIP_WIRED_INTF_DATA) {
 		/*
 		 * The Xbox One controller lists three interfaces all with the
 		 * same interface class, subclass and protocol. Differentiate by
-- 
2.39.2

