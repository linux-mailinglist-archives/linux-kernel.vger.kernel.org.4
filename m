Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D06418CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLCUYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiLCUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1561D65A;
        Sat,  3 Dec 2022 12:23:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u12so11988159wrr.11;
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQH8dl7sP+5v2RcfjUHr+xfYOMGtiuaV4DnkJihSDfU=;
        b=Y+VboNC3MXdNOZJPSIifVuyVEfSSYNfGyZw6U+sAUw9krzuBqEdFoKyOe3Ht5GMOd3
         nt8NerSzR4K7uL2mgYwRAsmsgcy8enZS00fpllQhjePKFHkqc2ja+OPwHKXZFOODcGsk
         Mbc3KiFnDJTnx/F8sF1OBGCEeQdjWhnEyTS2ozQoYxyB4HPUU/HLt7GJxUaiOvXrjGn2
         /+b2zdJJItXzq3Q8FTeIhMCJYtSyZotVGQH2UVbIYvEqfPDT+Sm3JSitqAtzTD+UduXX
         zsQ+xheXoVd3yL+s/d/UCwEL7id4iSwSExOD3cDkIegOkugOVy5jan+9xv0YvHueBvQ9
         avbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQH8dl7sP+5v2RcfjUHr+xfYOMGtiuaV4DnkJihSDfU=;
        b=GDcaLCEYDC6Emmt+BKk2C0aUMBb/M6VGb04gqwqwCC6g13kIebEhgJLWLlxhW7XDEZ
         1wIrpriIgNglU3IN1G01C64LvkT4PdNWPKTuictyh15A+UgKKvrxqL8p5uaymC2GodVw
         KYT7Rz3+gTaa/T2VbekNO/FHG5rxlSUzJ0jQ739054xweUGTH2cicTt7iS9sP/Wiwuxd
         3/FVlVp4Lh7qZWHNi7dA7qQ504ns9ru1Oahil3ArJTeoKIa8YivxIeYrKkgpChzL0Jb2
         kstBA0DTWD/fMlSa0OSmVvScTFEEOaW3TviBBkwZpTflMIKwp9TVcmFN1rAx89tOplOw
         2n4w==
X-Gm-Message-State: ANoB5pmwLwDdvrJLQTzu/28w9v7qph88fJmcElhHz6ZSLB3Tz4niaY5m
        XtIXQPfgtZv+DHBZwiPd1b4SXHnOIek=
X-Google-Smtp-Source: AA0mqf5jGxVd9rRi2AoDlU2D26cUC7yhOROkdToAfBqX3bJ8z5BgWP2Snsh/2KDt0TrpzOrjlkw7KQ==
X-Received: by 2002:adf:dc10:0:b0:242:286e:f311 with SMTP id t16-20020adfdc10000000b00242286ef311mr12617622wri.360.1670099007919;
        Sat, 03 Dec 2022 12:23:27 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:27 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/41] fanotify_mark.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:47 +0100
Message-Id: <20221203202317.252789-12-alx@kernel.org>
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
 man2/fanotify_mark.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
index 6cd3ae2ae..f49759ed4 100644
--- a/man2/fanotify_mark.2
+++ b/man2/fanotify_mark.2
@@ -13,8 +13,8 @@ .SH SYNOPSIS
 .B #include <sys/fanotify.h>
 .PP
 .BI "int fanotify_mark(int " fanotify_fd ", unsigned int " flags ,
-.BI "                  uint64_t " mask ", int " dirfd \
-", const char *" pathname );
+.BI "                  uint64_t " mask ", int " dirfd ,
+.BI "                  const char *_Nullable " pathname );
 .fi
 .SH DESCRIPTION
 For an overview of the fanotify API, see
-- 
2.38.1

