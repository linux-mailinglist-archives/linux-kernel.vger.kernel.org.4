Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA36418C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiLCUX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLCUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954401C920;
        Sat,  3 Dec 2022 12:23:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h11so12906617wrw.13;
        Sat, 03 Dec 2022 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghWwaWEuIAMENFFedwgVxMdBiogHqtj6RpZQ1NkhhcM=;
        b=SMuvd9hcr+KuaJmMxpqyhLm493I/C3+kn1kYlRuGhOzRsf6R+8x+ckBoe2Rdb5g0Ti
         JRb0+UQwT8KdTxocNZjcW1dwsUETcP5YCHRqr80tBdPjXDKx5Ys6Q94Ey82inmNjU8er
         +2U8Jjyatd8c31QS4+myXf1VlGnZ2ljQRaW5E2ih0T5CDFoWZZlRUVeqyBUozk+93AeC
         G4pSpmTj88kUcW8oWD5BdE2Om1STldLTEWWi6MIDfoluNl+nHYaFZD6KUquLyOJCfgG4
         wvLsZ6caHRHnRxNZKUwUxwLb0d2WjMwmJIZF6AZsRYs+0VLYdmsh8mZEXfhtkKENqH55
         brsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghWwaWEuIAMENFFedwgVxMdBiogHqtj6RpZQ1NkhhcM=;
        b=mpDJBaDfGe461oLlLFhGYiUAmL9uDVyuH2ABWACBykNN47Dr+cTtjx8oQaNbEM1KRw
         jAZ00CrkXIYBdv5jJDImKkcuk8xUb2GXKlJYOIrPsE5H4hSf6yPiugyGjYhNkFkhTk94
         tsNl1FMHoxcvMtJHHag/1yB23P3LcMD2lg9o1NkgKS2KeGDB7bjWokaRRIOp3IItLTNG
         frQSVndjzYPPIUKIq73lQkD5XF3Xk86UeSPDQmpN92u+xpyX5QJkd30ousS3KxilhRz6
         ygy3u/Q+SscMk0fgLdD/CPiZMM4W5OWCI7PNZOpdXtpxmkTqsc/1nnp/SuSK1k0erSj7
         Hz+A==
X-Gm-Message-State: ANoB5pmhzSsQzxnJ8Yj2xW0bPM4Mr/OGOmoqx47I5qDAPOvyyRcIcJVw
        wJmHxdLfMmemIF8aZ4pxr5+m+EKRhxE=
X-Google-Smtp-Source: AA0mqf7srF+OBwrTBV2ZVRrKfVP251JIku/9QiQ2H1atkE1U23g7lfD2vlppCDn80sHzdB0QHaIJIw==
X-Received: by 2002:a5d:63d1:0:b0:242:1d01:16fd with SMTP id c17-20020a5d63d1000000b002421d0116fdmr16396345wrw.682.1670099007224;
        Sat, 03 Dec 2022 12:23:27 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:26 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/41] execveat.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:46 +0100
Message-Id: <20221203202317.252789-11-alx@kernel.org>
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
 man2/execveat.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/execveat.2 b/man2/execveat.2
index c54d30996..b8c3be237 100644
--- a/man2/execveat.2
+++ b/man2/execveat.2
@@ -15,7 +15,8 @@ .SH SYNOPSIS
 .B #include <unistd.h>
 .PP
 .BI "int execveat(int " dirfd ", const char *" pathname ,
-.BI "             const char *const " argv "[], const char *const " envp [],
+.BI "             const char *const _Nullable " argv [],
+.BI "             const char *const _Nullable " envp [],
 .BI "             int " flags );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

