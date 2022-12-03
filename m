Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7326418C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLCUXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLCUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F41A814;
        Sat,  3 Dec 2022 12:23:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so12966632wrm.2;
        Sat, 03 Dec 2022 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyDg22eEntoQuVi3mrgb1OuG/M/oWKciPWScITkeflM=;
        b=c8td1UUQrrGyTDnpaS8D6mbb/naT8zJjLOozUv20Q81HxA3NfzxT6NzowFpHNJ+LiK
         oXgv+Osc1es3qTFhmxKI8k+b0D6K75GPF/LaZF/+ZgFmLVhokl3qteNhPec6RIkdTsiD
         dn/I/1EgfS31YI7nsrZSzd50bP0n6MTM6BunBN/SFLkxrnToe2YGAKXVKx6QG2V1TFOM
         MHXxWZgIFqS6SSIrwkh4Ai3oNJYHPKxBTap0AHoteZFXDvPqzhuf7bM3nzwZunR6o0g4
         6uqz6eXT0/2rW2dNnebFbx/vxNZv0J9kuwwJLk15kkiesTiIUMTfui71XXCZqvszYUaa
         ASvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyDg22eEntoQuVi3mrgb1OuG/M/oWKciPWScITkeflM=;
        b=tfx0y6DN1oM29Ajpbwwwzq4HXCGKGWfd3ixxecZHJDpTcVAktSXawok0DccnOHpOI+
         dXVr0qEaBpFy+qYCkO6GGbvvT4dMMVwySBYfAm1AzQrqBB3KekJIvVObes2/zjuZUk4Z
         4saIbw+pyT6FOOcfptKLN1WOgcQp1autZ6mVe3QOK5I1hYPatXADUupggrSf42/D0Ckz
         LTzKguta4nliz8eZUbrGvhyyhjLq6RpEek8hY5aRTvrAp6dedyOYq6+ABzZakAQp7aTy
         sU/gHcODEXhFt9w1lve906wWxZhrodQ+HhkjqpJm9U+xFZiUqi2AvzuuuvwXybYwl6Bz
         d/2A==
X-Gm-Message-State: ANoB5pnzdhQb/GYH6XTskd5sxFH273fYXvCZhr0PDxIq9LSP4+/qalvC
        568sfXGtj5jrOlnypCzIyXP5Zf/+UQ4=
X-Google-Smtp-Source: AA0mqf5lCQw6U2P725PuGJEO9z1fC7cM+lTfLPqW/gMFPhWRqcWZsgu7a2OPzsZNCEhK0lk10XjjZA==
X-Received: by 2002:a5d:490d:0:b0:242:fa5:6f6c with SMTP id x13-20020a5d490d000000b002420fa56f6cmr21618576wrq.246.1670099003706;
        Sat, 03 Dec 2022 12:23:23 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:23 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/41] clone.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:41 +0100
Message-Id: <20221203202317.252789-6-alx@kernel.org>
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
 man2/clone.2 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/man2/clone.2 b/man2/clone.2
index 093630859..a3e6188fd 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -50,10 +50,12 @@ .SH SYNOPSIS
 .B #define _GNU_SOURCE
 .B #include <sched.h>
 .PP
-.BI "int clone(int (*" "fn" ")(void *), void *" stack \
-", int " flags ", void *" "arg" ", ..."
-.BI "          /* pid_t *" parent_tid ", void *" tls \
-", pid_t *" child_tid " */ );"
+.BI "int clone(int (*" "fn" ")(void *_Nullable), void *" stack \
+", int " flags ,
+.BI "          void *_Nullable " "arg" ", ..." \
+"  \fR/*\fP" " pid_t *_Nullable " parent_tid ,
+.BI "                                       void *_Nullable " tls ,
+.BI "                                       pid_t *_Nullable " child_tid " \fR*/\fP );"
 .PP
 /* For the prototype of the raw clone() system call, see NOTES */
 .PP
-- 
2.38.1

