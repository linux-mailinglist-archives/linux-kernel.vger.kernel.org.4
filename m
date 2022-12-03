Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886516418E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLCUZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiLCUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FCE1EC70;
        Sat,  3 Dec 2022 12:23:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so12904428wrv.10;
        Sat, 03 Dec 2022 12:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/mv8JF3JdZsVDLdzMdT4AyXYKFhIcdn+TNy+4OBT5s=;
        b=jJLrKqmM7mXzsWVd60hWH7wUNLHisEJ3sIsVTbQjGEjyYZMhvEpHTgBYtLSTyj9gRt
         Vp087K57PC7r2xfpu0CiY13f6fhKz+Hccvaoq/QJ/dmM1+dIXdVnpb0QLUn+Z7SB5whT
         je+8GQcMaZ5l1wnYl8D4awStKld+y173nrot9hkHKd53q2RIQNRuoeXNTym4o+sGNbFS
         kibT97dlE8F38h+6kfMzfbp6RfG2w58XVOYhiFiJEG1NN9meqy/z0uM7s7aak0Sq3ewp
         hKNZPf6tpc5COdlemTgBGATF8x9EFIjUbkT/Iq80NtpXAfpXJmb2vgfUTJ0aSig8ZdX/
         DVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/mv8JF3JdZsVDLdzMdT4AyXYKFhIcdn+TNy+4OBT5s=;
        b=VPfUCQSIYrRYL0dSdHJ+I6AYOMeDK/49YnBtAhEuYWb+we5XHCTvFRwiuXJ8nHoz37
         ve4fArO+RqzWejyna4JJmdWi2IycNfr1miiYxRbXIAsD0UyLWOF0Gt6tvpNfX1hdldU+
         kHv66108sp9f/Lesm/PddLvm292LHs5F/RYFvU3dmE3AhyIzJaYN6kYQSc0KP1soPZK4
         yl9dySTjnTDJfXFe1sCY8g1L2dmwsEQuYERuKsJQJGXFLqH+tXOEv4KE6jX04H8i3XJT
         r4QSAthAxbxjqItQUB3WJ2KeJ1dsYWoV1npstnk63MzEN13YSwGwjsAO+tejalFC72EK
         gr5g==
X-Gm-Message-State: ANoB5pneLc6UVydxkHQiwLbECgQYfFwwA0negFxXdWQQqQPlNG870SOs
        ztASnzC18CqNC6UJx7+4LkyL9XPmSN4=
X-Google-Smtp-Source: AA0mqf5clPu7WX9kfiIRY5BGsPuIdiTIc6qs2PTzPRt8luY57y9DvrtRtDl4lAObzFvWvnQ7NPy08A==
X-Received: by 2002:adf:e94c:0:b0:242:41e0:5e55 with SMTP id m12-20020adfe94c000000b0024241e05e55mr5689820wrn.104.1670099017385;
        Sat, 03 Dec 2022 12:23:37 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:37 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/41] request_key.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:00 +0100
Message-Id: <20221203202317.252789-25-alx@kernel.org>
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
 man2/request_key.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/request_key.2 b/man2/request_key.2
index 78493b640..b9c4f2a00 100644
--- a/man2/request_key.2
+++ b/man2/request_key.2
@@ -15,7 +15,7 @@ .SH SYNOPSIS
 .B #include <keyutils.h>
 .PP
 .BI "key_serial_t request_key(const char *" type ", const char *" description ,
-.BI "                         const char *" callout_info ,
+.BI "                         const char *_Nullable " callout_info ,
 .BI "                         key_serial_t " dest_keyring );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

