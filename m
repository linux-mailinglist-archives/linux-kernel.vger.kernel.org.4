Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE96418C6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiLCUXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLCUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9E1ADA5;
        Sat,  3 Dec 2022 12:23:27 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o30so5932761wms.2;
        Sat, 03 Dec 2022 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctoSoc2PxyhUpH4yMOeDv8hnsvwHw2aiOmkuFn2RzDg=;
        b=pZ06+8iQUkPXZuFQLv6a+zZ/Od7BaNFSo370npsZYX31GRutVLZcJlr7iB4oh8TL2I
         PnlNSuWDSM4J9g6dG23uqa8EXEELdJPU39OS4p74qFzK5rkV9ZFAvSnTEA9KnHT7IX8z
         zQGJWX/fRKi6XfwnmX+4U3kfYDQ5YiVRWcj0LmuXamxE4AXoShzJiL9M60fgCrBe0a/L
         X/2nEvGG5cT/Cw4AKlW9rbI9Ji95sWpzZYeSgMb8Ot8zcUd/XPTIJnO/4b1ET4wWPwjW
         EVGsI4s8oORBoyJRwtS7Are0SWq7VtwY/Ksz1xFli7wC6bAVDBoX+S+UeS1dCHQTcKQZ
         lvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctoSoc2PxyhUpH4yMOeDv8hnsvwHw2aiOmkuFn2RzDg=;
        b=R434blcIzHbAv94BGsCKqBKolblhZlUTLSXs3l054UG1C0Zlyl+Myd0zDk12ynq3+S
         +1gs/uwZeyTHv72FfhJbJLavOIepz1l/+OQXN+kMLm2vk0rwMdJOpBvOQJ2e5cidCNGc
         u5YvD62eBNqUGN/oyKJHzQfPwr9xe2gCYV/EL4R4EtjvXf117/xJIXucuAC/a1SQVq/f
         8Y1Wz1488Y6eM7FCx0JG1QhCiGjjXOIm+vX16QDm6SgFHhHNsZA3EBcQuzIn2nTR5IXK
         boViQmq8af4KcmYtjO+ycXNT0W/X0O6Fo8DibmsnReg4D4oGWPFDTZ8w4aEURe5jl07J
         D2zQ==
X-Gm-Message-State: ANoB5pkdlSPEnU6COc1A7xZLd8V5QIIHkImqmkCHAR7KbdFPBe7zAcsi
        ymbnsxTbH9yp52/jLW3uycXFiMHWypg=
X-Google-Smtp-Source: AA0mqf4g43wmFr6HM3Wz1ZVfmhYlYjZK0WTvY3p5u7oKN/UYoNuWBYWt/1ADs37adQYNv0PKDqKw1w==
X-Received: by 2002:a1c:7709:0:b0:3cf:6a83:c7a3 with SMTP id t9-20020a1c7709000000b003cf6a83c7a3mr15762038wmi.21.1670099005837;
        Sat, 03 Dec 2022 12:23:25 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:25 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/41] epoll_wait.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:44 +0100
Message-Id: <20221203202317.252789-9-alx@kernel.org>
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
 man2/epoll_wait.2 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man2/epoll_wait.2 b/man2/epoll_wait.2
index 100a9211e..59ad4fa3f 100644
--- a/man2/epoll_wait.2
+++ b/man2/epoll_wait.2
@@ -21,10 +21,11 @@ .SH SYNOPSIS
 .BI "               int " maxevents ", int " timeout );
 .BI "int epoll_pwait(int " epfd ", struct epoll_event *" events ,
 .BI "               int " maxevents ", int " timeout ,
-.BI "               const sigset_t *" sigmask );
+.BI "               const sigset_t *_Nullable " sigmask );
 .BI "int epoll_pwait2(int " epfd ", struct epoll_event *" events ,
-.BI "               int " maxevents ", const struct timespec *" timeout ,
-.BI "               const sigset_t *" sigmask );
+.BI "               int " maxevents ", \
+const struct timespec *_Nullable " timeout ,
+.BI "               const sigset_t *_Nullable " sigmask );
 .fi
 .SH DESCRIPTION
 The
-- 
2.38.1

