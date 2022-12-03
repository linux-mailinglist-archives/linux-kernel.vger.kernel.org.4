Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A6C641901
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLCU0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiLCUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:25:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6D1F9F1;
        Sat,  3 Dec 2022 12:24:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so6283460wmc.0;
        Sat, 03 Dec 2022 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voxU9IuPLXyoFtziucHMf2sp8sw2xmdG+uPwM77MCgo=;
        b=iGJkGsJEafEpWxwRi0msBtWJGa4TVEPg16qW4KY0pKzxNivZLDOPvvMdqgb8GbMgqX
         vPCYU2H4eDHo6f4ycM7ZvhUuI5x7TtQs9t9l9hNa5PrFRXNlesjNNjnARwiKZ3E6bGuk
         2nUr5+M0m1QHmQ4vJDmIYbU6C0riVmDSxIaYxupRug2Y1TsMxKhOHfvFgRJnA8FWpmlq
         NjMz6nH+4lzFav1sw+vP/Qq5mOEumO4AsFdrvJ5ARmw0ZRQtV6aUNBIdwYiHbE/KpHsN
         /MWeWF+HnB5kMW7YSjsWohnG7vCthreVtPOKiR2IzBPELYGiM0mFRipIHHBmlWM6bzqw
         9fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voxU9IuPLXyoFtziucHMf2sp8sw2xmdG+uPwM77MCgo=;
        b=wo+r3+kxHYlKQetdpP0gN9St0IN73z7F/qewrzeoMG6cOqs6qo7wbYNgUDloSrmxUa
         DQcmjkWh3g2xznrg4YCDMcHjHOiAVudnlBMWuL4ALGKCb/lRNJDDgNiyZ68KOIb7KK7h
         GGWS1srt8ntQFaNiwiNYxmpY59r4PHo2n1hLTApIbQA5mDyXHTvHe4SNbHUywRsHATyI
         VkmLmZPvvbtc9eaPG2vmU0CXuOSZYruGTaAjxo5RTzpe7g7/SH1dGrxIPpJODlii29xC
         BDLG+ailB6lTOVqqEUG+YzEH3hGXtw+rb8uFP5wYWw/DXUrKtx2FqhyMj0oX7rUyti4T
         b0cA==
X-Gm-Message-State: ANoB5pkXXHOvcNPgX74hNmcopfbNBr9owEk1DKEyJ4mllvtvvBCNci1L
        lPwqrloRpLs0k2GqSLgJmMrLAQS7F/8=
X-Google-Smtp-Source: AA0mqf5uY+rPF1QGgFfVAsf/iLaA6dosavPzb2bSh6ccjXbNJmgtzWyxUapWJDK9lFVt6FXr1LNq7g==
X-Received: by 2002:a05:600c:4a09:b0:3cf:b545:596 with SMTP id c9-20020a05600c4a0900b003cfb5450596mr40947423wmp.49.1670099026003;
        Sat, 03 Dec 2022 12:23:46 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:45 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 36/41] timer_settime.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:12 +0100
Message-Id: <20221203202317.252789-37-alx@kernel.org>
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
 man2/timer_settime.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/timer_settime.2 b/man2/timer_settime.2
index c52768be0..29d9ed4d2 100644
--- a/man2/timer_settime.2
+++ b/man2/timer_settime.2
@@ -16,7 +16,7 @@ .SH SYNOPSIS
 .PP
 .BI "int timer_settime(timer_t " timerid ", int " flags ,
 .BI "                  const struct itimerspec *restrict " new_value ,
-.BI "                  struct itimerspec *restrict " old_value );
+.BI "                  struct itimerspec *_Nullable restrict " old_value );
 .BI "int timer_gettime(timer_t " timerid ", struct itimerspec *" curr_value );
 .fi
 .PP
-- 
2.38.1

