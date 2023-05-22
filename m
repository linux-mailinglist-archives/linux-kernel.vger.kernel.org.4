Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113DC70B840
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjEVJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjEVI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:59:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF410C;
        Mon, 22 May 2023 01:59:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3093eb8cd1fso3524853f8f.1;
        Mon, 22 May 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684745967; x=1687337967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQYLXnCTilOxJ77UwcOMpt/eXPlHQvWzLQDM7UFaS3k=;
        b=Vxjw+bb9HpwuZljuluDbKZi7+EgGXB9kGNjY+dbljvHB9uK+++frhbun49lBk7mD2t
         5L7Kwh7zdR9u70dmpF8SUy8k5KSfaIJEwqj73RPT8dnVsRbcOxOoIT6aFJNCn+Rao6m6
         yxmonnHZFY1h+305q+sejkjVJ/K2A0plUe85I9lbeOx12dCypPyfr6A0sTOpygojVCsi
         xsem47CJepifVanvICA+4016LoxH3FI5tpxlNHv+sGGS8bG9pQh4kEvY8QtHlrKeSXPQ
         6Rq3saUt214Dd2HF40W1nmhec8YW0iIkzatg9gMTbZAT9RsVEGyC1N+04XpMpOi09/9h
         /d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745967; x=1687337967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQYLXnCTilOxJ77UwcOMpt/eXPlHQvWzLQDM7UFaS3k=;
        b=iYSf13tfs7IZn7Vp+x4xIhYnO8wx4o4N02zljPgCFIiGxm4helUKRj+DVis7amIgAe
         zpK4j0yCcqcONCKBwTVy82c4/khhlPYQTm5F6q3GMmFgIbKpfwrCgxz54mdFb0titnCb
         blhPEGRPEbWuPjiC412DplAbBp7C9T/1QPEM1wdKApOojs11BVW4nAWDHqNE44EKsUey
         Pml1GORhm3i9sPj4eS2uQMi2aGtfoD/yYbCTsfw6kxprzCqX6qYFdW+j5MPyUEeWPKNg
         X5w+RiKopfgpk/ecS3iOo1FhLrNqu7J5mzM/JnST1GOmbsowHUcjCOgXxiIjk9sxIzBk
         +oIw==
X-Gm-Message-State: AC+VfDw3YYBIYWxfNLb1150YeZRswa4MVSnqKmtYTlaDdc1V6/cxQpu+
        EQxv+m13xhVM78qTUn1UBvw=
X-Google-Smtp-Source: ACHHUZ6njTQwoE1we+ut07OHl+COhScuDx56NuV2wiF3vCfIRPQCaqmWKWDyymm7oKsLT5E93nvadQ==
X-Received: by 2002:a5d:4243:0:b0:307:9f8:4f30 with SMTP id s3-20020a5d4243000000b0030709f84f30mr5819717wrr.70.1684745967094;
        Mon, 22 May 2023 01:59:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0030771c6e443sm7038292wrs.42.2023.05.22.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 01:59:26 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtw89: 8851b: rfk: Fix spelling mistake KIP_RESOTRE -> KIP_RESTORE
Date:   Mon, 22 May 2023 09:59:24 +0100
Message-Id: <20230522085924.913649-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index d58d6935e7b8..1899a5d69a81 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -1705,7 +1705,7 @@ static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		    id == 0x2c ? "GAIN_LOSS" :
 		    id == 0x2d ? "MDPK_IDL" :
 		    id == 0x2f ? "DPK_GAIN_NORM" :
-		    id == 0x31 ? "KIP_RESOTRE" :
+		    id == 0x31 ? "KIP_RESTORE" :
 		    id == 0x6 ? "LBK_RXIQK" : "Unknown id",
 		    dpk_cmd);
 }
-- 
2.30.2

