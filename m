Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815F6418D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLCUYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLCUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A821E705;
        Sat,  3 Dec 2022 12:23:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg10so5935795wmb.1;
        Sat, 03 Dec 2022 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvKsTE2ELC8RlKIJMb2Y18bej0kvuum/K7S3H5SxpuM=;
        b=IwgXj3P772JiCZbxbv9Ltsx9HgosvxG38cXjCL5dO5p08KCcMo2BtIxVk3PCf4uGcN
         aTiQB0QGOQLRBlRn6yqmF70cwwWqqyXPjK5aOF/w3AcWzEes3F0VqnKMX3f4qQ/XaKYb
         qhKzJ9M9W2KJjTMS/R08bvbGT3DusF/bdp/pmUyNICYAvcKGElT144lmDNf+rK5fBP5b
         bwfupRETFmhpTquzLpsdhFMWKuQv/RPYOJKkqWppphB/X8Ba/e623GOFBEtNknE8AkWb
         G52FkD8ZJqDXaGAHLIU3BK4he7kxWOUCfGqN3F1ZlR7GJbXM1+I+fsC7MexNKAseN0vu
         exYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvKsTE2ELC8RlKIJMb2Y18bej0kvuum/K7S3H5SxpuM=;
        b=5kStim5Ujy7blT/tn9ZK0pFgBEl4StWKMYNMdjH+AI9jIs9mfbH8oS4xkn1VpkkdZS
         ek4MVLHy/YJfZs6Us+BXK0naXP3EsCZtYGmOhKo4jVmWd7tvO04YPxAzDTlhkQHLqemh
         OggMsF8oywV0d/DMx5IArR/GTCvTPj7ARj/L8MFZVOStLmpcl2OwB2EnQLye52WVUiTL
         mFrvSwT1UpUo4S4SwGGftvbmBvrZHIv7EpGjR7VrRGz/DmXyTjVqiZMKgXM74xvkYyZE
         KgZwOLle+5tPSxW4PQ2Clwm017/2Pa1H6kj9TGdI4nH2zAmtM0wvf0387yaMfsu6Tlf7
         /dIQ==
X-Gm-Message-State: ANoB5pkIargn+uvqKvObuEyhluVBkLtrmFcltsesMqztcY2Lw4OoYi66
        owmvv9RAz2Q0wMJxNqE0Boe3djKSXQo=
X-Google-Smtp-Source: AA0mqf7jT77XNP4xeoIffTHOlQuEZ06tr+0kASMkpesPzIc1Fc4iD2xiroyO3fzwe03KOympPyJ0tQ==
X-Received: by 2002:a05:600c:54e5:b0:3d0:7aea:2299 with SMTP id jb5-20020a05600c54e500b003d07aea2299mr9953533wmb.128.1670099013801;
        Sat, 03 Dec 2022 12:23:33 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:33 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/41] nanosleep.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:55 +0100
Message-Id: <20221203202317.252789-20-alx@kernel.org>
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
 man2/nanosleep.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/nanosleep.2 b/man2/nanosleep.2
index 63603971c..969c34609 100644
--- a/man2/nanosleep.2
+++ b/man2/nanosleep.2
@@ -22,7 +22,8 @@ .SH SYNOPSIS
 .nf
 .B #include <time.h>
 .PP
-.BI "int nanosleep(const struct timespec *" req ", struct timespec *" rem );
+.BI "int nanosleep(const struct timespec *" req ,
+.BI "              struct timespec *_Nullable " rem );
 .fi
 .PP
 .RS -4
-- 
2.38.1

