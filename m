Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E36418FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiLCU0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLCUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:25:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2941F9CE;
        Sat,  3 Dec 2022 12:23:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n7so5919329wms.3;
        Sat, 03 Dec 2022 12:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymKeD1N5QNeWV0y2RZQ5r4pJdjGA+fIld0iMPljb1iE=;
        b=Dithp3K/iz1KvNJd/3sGsAAr//WQC7Nd03/BnJb5bJgumM1pSIWnkH0mpoDt00Kz5U
         bR0F2Dt5jb5CgxJ9RhnRlMp8N2LqsnvbttJmgJ0YKJXu1zFvELz+ArQxJkEP3ebrCLIo
         C4nZ0SMlOFhSniultxZDishkdesnJrFO5UkfU6pEuxf+0HCnbwgKn3jP+Bh4K+jJXgQ5
         U/dCDdRlsxPVQxQ+T6ZFrE72T/1D0YCor1aBIA77WCyTZBGgJXpnT8Uv/VmrboilzvRN
         3qTQnTW9CG49Hp6HyBUXLSK5fsFc2U2cr1z4DY2W3spCEO1YF/Y8bK4kDSo3YV7S4PM/
         FQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymKeD1N5QNeWV0y2RZQ5r4pJdjGA+fIld0iMPljb1iE=;
        b=XaMx2Njfd/RRQI+BEG0Qml70sRp23dQIgMxM0uwq1ojw3Kk9mu3AfL48uwKpDRT5/K
         FkxfNpwQJXfygoi8/v0AcPQhe7frnsJP1KvPYq6FSb83ZxqO94W7+Lvar4+ZeQLtTDjN
         /YTPv6v8R6RcwhijC3tRo33YCmTw/RqVBeoCVlAd5hRtROUXhcaQjZ2q8ms39OVy0QZS
         uqh48fcEXUm4DbdXFKucd/5kXmRzTtbQ3KluEchnjRK+xVWVkZ8vXvWMx4ihbD3Dbpsh
         4PiIItviOTkKG28awu9ZpRyr8TaW/oONToRZSXWpexC2nHu0LbEoHXAXOF8uSVpEamnU
         67zA==
X-Gm-Message-State: ANoB5pm62nHXGox1HPRLr09CFMBfFOacXwcDZ/lZnWkGUxhh0Cbg9I3f
        +HzuA40LCl+Zql3N+shPCvYOWGYrVw4=
X-Google-Smtp-Source: AA0mqf6LK9pvAemMoSXMTQ0Oz9y4Gtrpr+0/og30GjM8dCuCapd6GueXXIGjK/vD3AomZPeYtuSEfA==
X-Received: by 2002:a7b:c456:0:b0:3a5:f600:502e with SMTP id l22-20020a7bc456000000b003a5f600502emr46857294wmi.39.1670099023914;
        Sat, 03 Dec 2022 12:23:43 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:43 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/41] splice.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:09 +0100
Message-Id: <20221203202317.252789-34-alx@kernel.org>
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
 man2/splice.2 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man2/splice.2 b/man2/splice.2
index 4e6582f71..b5c453771 100644
--- a/man2/splice.2
+++ b/man2/splice.2
@@ -14,9 +14,9 @@ .SH SYNOPSIS
 .BR "#define _GNU_SOURCE" "         /* See feature_test_macros(7) */"
 .B #include <fcntl.h>
 .PP
-.BI "ssize_t splice(int " fd_in ", off64_t *" off_in ", int " fd_out ,
-.BI "               off64_t *" off_out ", size_t " len \
-", unsigned int " flags );
+.BI "ssize_t splice(int " fd_in ", off64_t *_Nullable " off_in ,
+.BI "               int " fd_out ", off64_t *_Nullable " off_out ,
+.BI "               size_t " len ", unsigned int " flags );
 .\" Return type was long before glibc 2.7
 .fi
 .SH DESCRIPTION
-- 
2.38.1

