Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDAF6418C5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLCUXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiLCUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1CD1B9CC;
        Sat,  3 Dec 2022 12:23:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u12so11988061wrr.11;
        Sat, 03 Dec 2022 12:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcOzxfVUIjeAxulrAa+VJqksZIEwezSj0SGLfMAddjU=;
        b=HiOFmBBDt+26syw96lnG8oiLKaVxmzLoMp+QQ0WhvPaJzNse7bWBfZJfzuGOQt3V2K
         vM2UFKVxO2dcWH1R6EqjNSxRD/fxjeAokD5A271XVAIDpUNSvEwTJpJ5lO/MLASqfOwJ
         ZwaHfOybIx0vSVhf783tJwBChRBAr7O1tQOOhjh6jnh4SVkxuSNv8vJiI8rqzC308n1B
         N3C5o9S4QE7E+FcPPY6V6cJcp9lTcKw0Dm3HT2BsrbL2zgPZozKwz3LoaLtIDKO19UaI
         uZObTUT1Wo6mKj4C8y+3H+v2pd7wRlOKmliiN65SadzuMgufF8Uu1iOok0L0lwiQR8y7
         rv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcOzxfVUIjeAxulrAa+VJqksZIEwezSj0SGLfMAddjU=;
        b=NFldRKtoFNwGVrJezb9e109geCj2+lYXulvKBmUlun1KnXbMi4nvTm0BeisnzmBPRP
         +Dhb3pS85YSHVu4a+toD8mwnVvOJaWQiQI2YZNRdzgyRVwFuW2ZMFiLiZRfc7x50cAis
         1rMraIJN778oqQvn6KTynkJZwndSrEMIRi6Ky1ch7XYfCm7YdrEN/1PGUqD0FbjWv6wb
         RMRiQtAT7Xd3vdarLiAuACZbyZqiI2uRUdI/HaLCHH0z4xHvRLHJdHOL+eR/yFTWSq8M
         YsA5cy1QSb/PeddLXsmB83GrLn9xBZU0IsqioeLM5n1JOn6u5ykcO0HDaeC4L3PwtzQM
         S5dA==
X-Gm-Message-State: ANoB5pmJ2l+mEqNdRv35py+MnSnxW8Evq8lgBw6WnWncy6rfGnz3pFZu
        1bZFq4XJR3ZVXNKUygf+KMlx8jdpi9Y=
X-Google-Smtp-Source: AA0mqf4b14teh/jGSyfDuyFFtmw4lP4i0JI3nvvgbNHHuPgPaNVfspLA7mWF3A4R9WKsLqiMjuZtfA==
X-Received: by 2002:adf:f182:0:b0:241:d820:8996 with SMTP id h2-20020adff182000000b00241d8208996mr37274937wro.562.1670099005145;
        Sat, 03 Dec 2022 12:23:25 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:24 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/41] epoll_ctl.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:43 +0100
Message-Id: <20221203202317.252789-8-alx@kernel.org>
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
 man2/epoll_ctl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/epoll_ctl.2 b/man2/epoll_ctl.2
index 4da081159..dbe6c0bb2 100644
--- a/man2/epoll_ctl.2
+++ b/man2/epoll_ctl.2
@@ -15,7 +15,7 @@ .SH SYNOPSIS
 .B #include <sys/epoll.h>
 .PP
 .BI "int epoll_ctl(int " epfd ", int " op ", int " fd \
-", struct epoll_event *" event );
+", struct epoll_event *_Nullable " event );
 .fi
 .SH DESCRIPTION
 This system call is used to add, modify, or remove
-- 
2.38.1

