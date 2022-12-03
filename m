Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130406418F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiLCUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLCUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D761EEF1;
        Sat,  3 Dec 2022 12:23:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m19so5926400wms.5;
        Sat, 03 Dec 2022 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RzYX7Ax2Zl2UWc+VkPGhDYHK63svLNa9yvGdo6sIqc=;
        b=fVkWSAcUhp7EW8jwZF3Z0gkjBZa6wzq+UiMsS7Duiit2iQ26mBax18rUaxvcWub+FT
         Y4NH4BgK/8DLPlkHpTGaOQ5OJ/OtfOA4nXS3pHasg6R+m7ibmiBCeOP5jKrNTsnIZwnr
         TeYkXRPUEauChUEJk48xhOwFRrOidwxf+G/otjk0ORPOEDC9aBgwOd/fPwsJqui2srUd
         68c5pdO3yLeWyXwD0mUyt6BBqPUSv4LXnU0fnwNKcLTw+krL9UU0qEyJ7zXXVbBYgCNR
         3naDfQCqx2w3xCWoHa8648yKEyxmLQehx5tuptz32BGHJq7fYh5jLgl6AphWMYRyA9KY
         I8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RzYX7Ax2Zl2UWc+VkPGhDYHK63svLNa9yvGdo6sIqc=;
        b=VjEwjn1R2hZ0HLQ84I+3p+MreDlHB3Xv8yloy+iS1YeaKyRnL2JEyNwZvHdkPAy8Mf
         WhtbmDAKscH1r9Pnm9npw2USeOLloan0ks5gzaxT0agjKlBO6wJdgDIMDLK3ASmKaT57
         XiyVryD+Mkfnq61V30OG+Qm3Fai56qFHbMoGGt6tO71AQnpbfZ+pujUSVz+2HDCmG68a
         dQK5DhOzHx2hoJQ6TzA65XSrkLXH+xAy7XXoA7SvirkHVRCM48aRhvc6t7JYYroz0xzV
         ek6fTkqodwmEip56VJBjZX7ysHgdQgi0hgVsk4MJLkNzts56PMOB92I2DfYofuukyh2s
         aRzQ==
X-Gm-Message-State: ANoB5pkOBT4XwZgENPtjl4iB6lI+extZLMt7Kg9flmRcoB9U4UpB5WVD
        0aNkSNb8mI7J1Xw8tmTiBQi7lYx8Ngw=
X-Google-Smtp-Source: AA0mqf4LV9pCocrP8xgPBWjOHzECPKKKGcLDDmfEeTXxiMOIekH5fmVn9DDkEnV9BkVEUEYncdNYGw==
X-Received: by 2002:a05:600c:3d99:b0:3cf:cab4:a42b with SMTP id bi25-20020a05600c3d9900b003cfcab4a42bmr41879179wmb.36.1670099021707;
        Sat, 03 Dec 2022 12:23:41 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:41 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/41] sigaltstack.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:06 +0100
Message-Id: <20221203202317.252789-31-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/sigaltstack.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/sigaltstack.2 b/man2/sigaltstack.2
index ca41491eb..a448da43c 100644
--- a/man2/sigaltstack.2
+++ b/man2/sigaltstack.2
@@ -13,8 +13,8 @@ .SH SYNOPSIS
 .nf
 .B #include <signal.h>
 .PP
-.BI "int sigaltstack(const stack_t *restrict " ss \
-", stack_t *restrict " old_ss );
+.BI "int sigaltstack(const stack_t *_Nullable restrict " ss ,
+.BI "                stack_t *_Nullable restrict " old_ss );
 .fi
 .PP
 .RS -4
-- 
2.38.1

