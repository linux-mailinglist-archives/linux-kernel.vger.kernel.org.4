Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FB6418F5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiLCUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLCUYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B31F61B;
        Sat,  3 Dec 2022 12:23:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m19so5926416wms.5;
        Sat, 03 Dec 2022 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef04MEi04LrCEedSfKxL4rs7BnKpg4NBQUeuW6ejwXw=;
        b=JQyn9CNxjpRMBk12aH9G4r5s26RmNeuAf+wpvblYFPSxc2Tkf4eKP6XGVwO8r9wJYa
         OKZ1VmnCwpGfgbeqpOFEOB6s9tSrqdUuH6dqOxEPG/PkOU1Y6TYBOO53dOjuQSK8Ijzs
         kaUkMdCFp7TMhQVOq9FReSchw88o06+jKWaUYJ0u6S2i2TjdEAfrFlocxcPe5OxHuHCx
         tMI59lRuRBAzh2lGmR9PbPfRk+hfdxRk8BaNakYhQlMg918GkwxWfIV9o66IpI4RIzAb
         sYIZFkywewxTUOJnyBNuZpCh4VTk6Neb0UQ+C5t6etDVS8WaO7KEy0cGLYFMagmGgdwR
         wy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef04MEi04LrCEedSfKxL4rs7BnKpg4NBQUeuW6ejwXw=;
        b=pmYNC8SrYWmwEoEqvuQSaVldu2pfVO2T95DbtfhZu4V7zROuxjCCeu/CifgAfsxKM+
         vQ6Tivh9IX7t4vlOhLFFtNT7ogbYlK/QCFKj3Fj7WiMNkdaIJYjLIOAhAlRiQDDEfB7V
         15zalUQbJew6cj1gwYb1Q9ptGXVOtWvhm99L+z4HMOBRruhTiJK4ONZI1JCUCg8SI6XG
         WbAv2qB2eZeomA7SIehH386zMUR9mOkJ7LuTesnbeRDeRKao6gMUKK/wuXZC3nHBLv8o
         xn/Em++P98mZSQNQIIqn6a9fFYBynLSIYFgWEERJwJRh/PiyfsFg23RMpr7Xu4XQ/BoI
         hwKQ==
X-Gm-Message-State: ANoB5pnSiHIJzNGiE6Jq/jQZqX5ocT3loHPariEp9eHxvb2DRZYAsF41
        wlNUR7XqI0EPDE0OhWcH11M8nRky8Vk=
X-Google-Smtp-Source: AA0mqf5T2Wef18zNNcpwFtPGyN77AOhK9NeqSIC4ITPJWCkfiHYRiUVCLtjpjHcy8HBz7fT6crAc1Q==
X-Received: by 2002:a05:600c:54c2:b0:3d0:734d:ed7 with SMTP id iw2-20020a05600c54c200b003d0734d0ed7mr12567985wmb.201.1670099022473;
        Sat, 03 Dec 2022 12:23:42 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:42 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/41] sigprocmask.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:07 +0100
Message-Id: <20221203202317.252789-32-alx@kernel.org>
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
 man2/sigprocmask.2 | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/man2/sigprocmask.2 b/man2/sigprocmask.2
index 6fa655fea..ae65e3400 100644
--- a/man2/sigprocmask.2
+++ b/man2/sigprocmask.2
@@ -17,22 +17,23 @@ .SH SYNOPSIS
 .PP
 .nf
 /* Prototype for the glibc wrapper function */
-.BI "int sigprocmask(int " how ", const sigset_t *restrict " set ,
-.BI "                           sigset_t *restrict " oldset );
+.BI "int sigprocmask(int " how ", const sigset_t *_Nullable restrict " set ,
+.BI "                           sigset_t *_Nullable restrict " oldset );
 .PP
 .BR "#include <signal.h>" "           /* Definition of " SIG_* " constants */"
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
 /* Prototype for the underlying system call */
-.BI "int syscall(SYS_rt_sigprocmask, int " how ", const kernel_sigset_t *" set ,
-.BI "                           kernel_sigset_t *" oldset \
-", size_t " sigsetsize );
+.BI "int syscall(SYS_rt_sigprocmask, int " how ,
+.BI "                           const kernel_sigset_t *_Nullable " set ,
+.BI "                           kernel_sigset_t *_Nullable " oldset ,
+.BI "                           size_t " sigsetsize );
 .PP
 /* Prototype for the legacy system call */
 .BI "[[deprecated]] int syscall(SYS_sigprocmask, int " how ,
-.BI "                           const old_kernel_sigset_t *" set ,
-.BI "                           old_kernel_sigset_t *" oldset );
+.BI "                           const old_kernel_sigset_t *_Nullable " set ,
+.BI "                           old_kernel_sigset_t *_Nullable " oldset );
 .fi
 .PP
 .RS -4
-- 
2.38.1

