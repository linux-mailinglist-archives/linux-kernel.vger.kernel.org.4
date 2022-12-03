Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D36418BD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLCUXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLCUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F651A207;
        Sat,  3 Dec 2022 12:23:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so8951449wmb.2;
        Sat, 03 Dec 2022 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDQ5IOrBnh1rn1Tp4pjDIxVfc8wxi8Cacb/j77csH9I=;
        b=eeU5OTarw9ItsM089fdkrXitUVLWC7wyMiP22/UKgbFULN5ydK4K8HA19N/jxr2HnD
         Js6WZihdmPAgfH8gv9XM9nhDlm6suEI7eUKJiAvv9ymVX1yXGQtFqdVQYv4VhfQupzcW
         ajBuE4bXTHlynNCUeY9/b8QHsuWSY//BCn0yEscuT68oduPvlKDg0pEwzhCEEg7IhYus
         35Da2pnuz9f2PHABlbBkDCTrIt4BOLy0alereuzN06FCN04FfpOUul79W3XzZfrBP0tR
         ZwdikttqItWgzj7JgIg0gNBbqheaWSiR/R3pyZPxVnxl/+nyQasv3MuOBZv0XX7VgFTO
         rTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDQ5IOrBnh1rn1Tp4pjDIxVfc8wxi8Cacb/j77csH9I=;
        b=4TgEff9SxviARNzV3iFQ3w1rqUXDRCi1u1li7ToLOPAradhrYaAc62YDulgtMiHTDH
         br2G/8Ixvk63RsMP8dMAkS2xngaCtj8CGBrD4LZXrb68EN3idAafJvn+LL2KG5+Sae45
         In0NnLbi6uxEqrZznqFTgGYY61tgaiwpbUI+AHayDl/ozXna8NugGNQAOfVh4kPzcyBO
         zZeKafTk9OrMwd6JevrupXIy78+AyUUL+tT6X6sIqvx6Gs2HUwEdUenC7I9gv0ctfXny
         f1y3lfyT62EtLX2x1lSO5ewCJx/XaEgdOe0CVfnyzFj8t79er6jkmKELb06Jd6EOQy20
         chHA==
X-Gm-Message-State: ANoB5pmwt3riA2htVQmpz02778grPcegFUdjdV70VTVcDD9tkXEFtRRU
        LD3CFMDTaTvh2XexlnCH3SK/a9HhANM=
X-Google-Smtp-Source: AA0mqf4CLcbJYyVhXH25b1AfnkGfFuKhbohJ/nTqteZBuOtQuUYa4MUfSiENXJ1Ae20mXMdBr9Ouqw==
X-Received: by 2002:a05:600c:5389:b0:3cf:a343:9a28 with SMTP id hg9-20020a05600c538900b003cfa3439a28mr45227383wmb.186.1670099002257;
        Sat, 03 Dec 2022 12:23:22 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:21 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/41] clock_getres.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:39 +0100
Message-Id: <20221203202317.252789-4-alx@kernel.org>
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
 man2/clock_getres.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
index 228d21467..23c5b71c8 100644
--- a/man2/clock_getres.2
+++ b/man2/clock_getres.2
@@ -23,7 +23,7 @@ .SH SYNOPSIS
 .nf
 .B #include <time.h>
 .PP
-.BI "int clock_getres(clockid_t " clockid ", struct timespec *" res );
+.BI "int clock_getres(clockid_t " clockid ", struct timespec *_Nullable " res );
 .PP
 .BI "int clock_gettime(clockid_t " clockid ", struct timespec *" tp );
 .BI "int clock_settime(clockid_t " clockid ", const struct timespec *" tp );
-- 
2.38.1

