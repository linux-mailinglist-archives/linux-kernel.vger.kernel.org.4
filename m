Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F56654F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLWKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiLWKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:21:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56454D2DE;
        Fri, 23 Dec 2022 02:21:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m4so4599438pls.4;
        Fri, 23 Dec 2022 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mccO5ilouRfJn5sBNa6schD4KBFUl4BO3DNqcpmuMnU=;
        b=H8nrQFqZ+dBwnGND8DBOmO3s+dREzXShgUWq+kar0WMMWgJ1rGjuVbUTveyNz27MZ2
         kBjWGRuI5VwMY/Crx28FT2bemzzM4PErFE2eVwD5J/Z+7dWiOWjcgbJD4Bf8xiNv+6sN
         0O0yRG1uao1Vs9Sx1seGVGAg9Vfd8PsSDnxkDh4y7iHv8GeoNXKdxcSPt0Q7Q1rS4+Ln
         SJAN+ZXvxmYcXp0RLivWvLqbn/w0Ic9EMXzJLkP+HDkp//Sabl7j7oAyDmnR1RH/up7f
         fmuGuAJPJjQXi7iw9C9p6ETe+c4kDmnUdF0lSikLhyy6c8c3tWuPN8ttQyyiUmv4Kr8H
         zqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mccO5ilouRfJn5sBNa6schD4KBFUl4BO3DNqcpmuMnU=;
        b=pARLbdBYXE+2NqUhvJ253YEK+3YKBz+I66hGW63DWXF8LxDCB0f0cithCzuVAN/PBC
         VdfBBneoj36AKjNtVMfH6Maz9PyPPFYnZpJVEfLwK/OIhW3OwF07snGi2qfi0YyD0fSO
         NQPvEaoSwpkeM7eE5AL54gZqsT9vkQNu4WiAka5KTw4JRbbCijtC4BWtcT4iViQK3yxf
         4zapwqM1uvmwXyxd930QrlrPDpPSf603dhMGefpeOeXbWaqzqIv7ZLDPO+CuhSKwnRsz
         R79n7BZmdcNSOfvoeeVVQjywFXg1irW6lXdPTrtM88prpKT52BjDQBmwvUnIt2mAtWoe
         Dk5A==
X-Gm-Message-State: AFqh2kqRkqT/8IpUARTpH/6yFjnL2itxlUG4W4RbXtT1bqMo9n8xwyGG
        ypNYaJVI21BBuk8fMvcEDkUrNdu3Qvo=
X-Google-Smtp-Source: AMrXdXtLPTS/mQ/11Q80UKTLmZyxHRNWRCOQkcZiw97vrTTj2Oc51xgkiTPKmeflg806mQUgeUbyug==
X-Received: by 2002:a17:902:d647:b0:189:cc58:7784 with SMTP id y7-20020a170902d64700b00189cc587784mr7658369plh.45.1671790863848;
        Fri, 23 Dec 2022 02:21:03 -0800 (PST)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b001754fa42065sm2054878plh.143.2022.12.23.02.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:21:03 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id 969DE23603AD; Fri, 23 Dec 2022 19:21:00 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, pkshih@realtek.com,
        linux-wireless@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] wifl: rtw89: Fix a typo in debug message
Date:   Fri, 23 Dec 2022 19:20:58 +0900
Message-Id: <20221223102058.162179-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in debug message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 582ff0d3a9ea..cd6c39b7f802 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -1643,7 +1643,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
-		    "[IQK]==========IQK strat!!!!!==========\n");
+		    "[IQK]==========IQK start!!!!!==========\n");
 	iqk_info->iqk_times++;
 	iqk_info->kcount = 0;
 	iqk_info->version = RTW8852A_IQK_VER;
-- 
2.38.1

