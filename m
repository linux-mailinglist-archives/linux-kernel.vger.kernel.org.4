Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7360555C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiJTCOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiJTCOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:14:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F75AC4B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l6so17938121pgu.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cxlbEVDeF4plEeh62JkmWpXJNLBpkyMDDpLc8c5MkU=;
        b=i/ZHwd6vtO8tnDAAAmZSyChgftK9wsSwRMKMhPJZoaiURvJ8gEdumCl6AOR1lR5ZKf
         KiSg3hanIqMlz291v/w0umgZzgIlR2uzUcVqDvwEixzgGYYzFsSMdrIaIuQlV6Rw6F53
         xPstk3O+7bTDGXwmtBKvBDzmThnbs3TbXKwf927+rJ53uQ2sN/9sRQUSqFF2vlWe+TW0
         IDpScgosPWp7njzSoz9BBlkhTkXfAIyb7j0ZGWvQir9/DCt8HA9tw0YwQ958YU3pyPk+
         x00xiEredWYJvKcyy8BxPhMoxSrwqcywKSGxXYxgemgV3tJp8+lcglLt5p1gphgCPvMM
         Rldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cxlbEVDeF4plEeh62JkmWpXJNLBpkyMDDpLc8c5MkU=;
        b=x+OZ7E0piVGC7n3949j0yuM4Q3BHCgGOVyoHooH2TZsqZjBRprLZx0W/hz6ETCmFAq
         om+kJhDEIpSaYI603HNmXA2E0e5UbMk793RNZJ3mAetduYDiIZKXZU6eagm5zQv11IUr
         FS6ngxyTX3B0d/h6lbALwrZqzV2QC1GQo+LNYVr0tZnhIpuKyQQo86hmvLyVbPDZ8wwS
         Pk3uWJ+ru4eQwm0IdVeKVEMHrtMe4uqJW82qFJMc4RTSp+dp63Og9RDOUj8R/N1059Sd
         UvUbFfh/UJci5wH5kgvzq4kWnbqb5qA10tQ2KRVUTQ/ASJbQqAXiyTHcQmJXgBMi0UZD
         kNxg==
X-Gm-Message-State: ACrzQf3eVr6VMQ0fJ2zkCwi7tUXFA9eDyxH222HNnkSiBMntny72TCf+
        fHFppof6+iD6Gy8ArAc3bfU=
X-Google-Smtp-Source: AMsMyM6w3Kn9m+GCRlAqC2fbXBLFG9tRtOfO2XMsER+YC571XMz1GzczedPWGtvXX0+kFvqmMtE5Qw==
X-Received: by 2002:a63:2c8:0:b0:46e:9da9:8083 with SMTP id 191-20020a6302c8000000b0046e9da98083mr456343pgc.186.1666232083946;
        Wed, 19 Oct 2022 19:14:43 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm11942936pfq.182.2022.10.19.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:14:43 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove unnecessary parenthesis
Date:   Wed, 19 Oct 2022 19:10:53 -0700
Message-Id: <a08a440eabddd8e78d045ca9898a415d81f6f6d7.1666230736.git.eperi1024@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666230736.git.eperi1024@gmail.com>
References: <cover.1666230736.git.eperi1024@gmail.com>
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

Remove extra parenthesis in conditional statement in rtw_ioctl_set.
Issue found by checkpatch.

Signed-off-by: Emily Peri <eperi1024@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index ac957035bf1a..32194dabd587 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -160,7 +160,7 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 	if (check_fwstate(pmlmepriv, _FW_LINKED|WIFI_ADHOC_MASTER_STATE) == true) {
 		if ((pmlmepriv->assoc_ssid.ssid_length == ssid->ssid_length) &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.ssid, ssid->ssid, ssid->ssid_length))) {
-			if ((check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false)) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == false) {
 				if (rtw_is_same_ibss(padapter, pnetwork) == false) {
 					/* if in WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE, create bss or rejoin again */
 					rtw_disassoc_cmd(padapter, 0, true);
-- 
2.34.1

