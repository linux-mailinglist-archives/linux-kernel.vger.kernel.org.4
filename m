Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE976FF566
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjEKPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEKPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:04:34 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB127B9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1683817468; bh=SZkbWReKqWHbxLJTgUABgPfKsJuaROBOS/3JVks8fJc=;
        h=From:To:Cc:Subject:Date;
        b=qWKn6tbjg7ry2xQ0jU5WagO5QwxZFkwh2DLRy8KQJskZwE/fpXKhbb0LmlXHntBSx
         NiGFU8IMPtWA80xJJtgD/SpZgZdmAz9cSSRJdzGy44Q/q46vX6vGNv0LvRGeyXAx+K
         6+aVesVFo2CkJOYlAcFHO+RnLdRcU9hO+M0kSkFM=
Received: from localhost.localdomain ([183.52.244.212])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 11B02440; Thu, 11 May 2023 23:04:27 +0800
X-QQ-mid: xmsmtpt1683817467tx253doz2
Message-ID: <tencent_3C6819728B6704C39A864762FB0BB77DF509@qq.com>
X-QQ-XMAILINFO: Mw5V7KuSxHjfkjSDlu99BTpn5WVbqV6wg93bmfxlxPfXuKKlSjUudBcZLj3ixm
         AZ5gY26eroTYrbBx1H0KFCmJA1KP/kjv8c+d2YoUwKQ8RBUONge+tt7jYGc2qvyytlv0qgt8NbXZ
         VnBpeMi6BWCfoYdSYPSz4kI+vycm5T3EJgZW7tITIQfRn1ZzK0n5HGZhLea4Va6er0Epy9WEALzA
         0c66TKKhHJssRl1IIlK8VKbto58sTqCW8dtu1nb+AtulNh8I5vPL04T37vto5jgKu8K/41lpfYrx
         mPGTDGTG4Mpc5xkiwRZdtwdUrL/jS1h2QboGwVrGS+QKBFyg/ZIMRKkxffjMDMZl0lWptKNMP24K
         eRwoHNZvelZA8UYcKxVxMFmsEwOwdMhX3tKcqjKGadxUD/scFUOK2xAROMSzPDsoaGYajVn7oP5h
         AvQ7uUhE9pnSGN28GvzLqom/T4YVCVv6+HWLBSmTtRVtGfHWotojB5dE4XhRjtX9kfCZVyvDAABb
         qEtLNLqQLC1As2K6GNJEegax0FH3FoyDa652/2plqlUC5R5y3t0z1ugPJgsaeOEPOlQO0a3IWeK5
         DN79F30uz4gOhVRIOHONQ/E7vEZtcEEEf8gFxg5/sEv4paTP/PYklZGlwrUWPW+sszUVHb8/3i9t
         vemAHKa2ZQlnXa7u0D4+MmPO8Le5Glu08Ia6oTB4u3E9CjU0zAmN1/rSS7eLXEGBzmGvrtp8luI3
         SqOx/KxqFpW7E/BFmdMHNqDYnMzE/qAto3U8BsYDjzImFQPChPP5vS3jns2BPu1f4W73bwIlqtlq
         z1vuKeC56u/S8qV1Ibr4KWCuy+oyOGVGf4P4eSRYsQEG5+mSJw0R6QOxtFmmigEb+Cr69zZbP8L4
         6KEC2Rbkb5JLhnt670oZpB+f8UzuivWpo37el6kjhJKrUs6UBCFvohNu8Jhq0LWplbG5T/zeSu6h
         7UdxGqQz73TwIJDZEcFevZYLfsQcEWbH9zqiht4hK9XrTqT19j22KLpqrFXt4KHLgMaVZOeYz3CV
         xuQ99zXohGNxRBSx1G
From:   Rsplwe <i@rsplwe.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, Rsplwe <i@rsplwe.com>
Subject: [PATCH] ASoC: amd: yc: Add MECHREVO Jiaolong Series MRID6 into DMI table
Date:   Thu, 11 May 2023 23:04:11 +0800
X-OQ-MSGID: <20230511150411.2087-1-i@rsplwe.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Rsplwe <i@rsplwe.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0bc6e4066..a134eba4d 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -311,6 +311,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MECHREVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
+		}
+	},
 	{}
 };
 
-- 
2.40.1

