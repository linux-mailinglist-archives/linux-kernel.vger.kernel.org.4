Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D086418DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLCUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiLCUYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104D11EAD0;
        Sat,  3 Dec 2022 12:23:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8935025wme.5;
        Sat, 03 Dec 2022 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwStuZtIagDZr61niOnMDXzs3hg7FwwXQo8+xuNygIw=;
        b=fMSYvvmkV6c+cbrX0VhF++WGIsHR9CymkIk+qWplj9qiqcFRZzxSXrWnxYqHBpV7wM
         2KK6VdHcBgbeIZNRsjcZKsrt1cFxhkc46VRdnqnctjunVZP3N/y0vKDDWRHT9zAXva4w
         vSNzuKZmhsXTeuUbS1Ztx2JqtCSlEYEjM2AREirUCEppxC1Xk6mCfTem5HIUfA5W/pZz
         yRT1wz67jXvwwGHCvkoeNTn+cK67AehFKGnYXAaSLr81f5ST0yeYDbHUDPfLflgz1bL4
         iqcYkZaGlsQToPii7DOgvrpe4uDiLl/p5GrswUg+BT/a3Vf2B09zyzyUa5AzDVcJn2qr
         m93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwStuZtIagDZr61niOnMDXzs3hg7FwwXQo8+xuNygIw=;
        b=CIOtwkNABfvc0+AtOBi4+voAls/l8JILCNxq48oQGlq3IIBeNVLHay3FJA1IPzoNig
         bc3K1QfGNlKCUSCiw9Vng0DpEYGQfHdgiH2fGivW3hYEir4Eb6y0R0FHIrE7WuUr4gad
         1AcSMmm/QhGm9omkm+Ltq3Jb+7b0ylGAY/5xLo9gx4lefybpbjgUBK7XVtJks/oX/4ze
         czt0xD9vuDcfYDl7OyUoJSQJUMagojjXiU/UmpWiBnle4/Sa/B0TZH+oUYsoG7ED8DD8
         u+14eoCkzrDiaydkzXgrJ4u20SiEkP7iGCNxccReZP8be7K1DdVBhBcO8Vq3l81A+PMB
         CU4A==
X-Gm-Message-State: ANoB5pl2O5XBI8CtnGJHJHow2NXipVBm+jfVPKU7OociBAUZl1AzMJMZ
        b8aUSdQFu9mrzyAEna4HEl1FWjxcbuE=
X-Google-Smtp-Source: AA0mqf497vJZ/1Uz4VViPTMuXVzA1+c8mWdipaZkMfa6F0eFMiZBscDdMHxqTKEg/T3xSIGfNk6oOg==
X-Received: by 2002:a1c:c90f:0:b0:3c6:c1cc:e96f with SMTP id f15-20020a1cc90f000000b003c6c1cce96fmr41755715wmb.174.1670099014555;
        Sat, 03 Dec 2022 12:23:34 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:34 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/41] pidfd_send_signal.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:56 +0100
Message-Id: <20221203202317.252789-21-alx@kernel.org>
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
 man2/pidfd_send_signal.2 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/man2/pidfd_send_signal.2 b/man2/pidfd_send_signal.2
index 93d0c90cf..2a60ced93 100644
--- a/man2/pidfd_send_signal.2
+++ b/man2/pidfd_send_signal.2
@@ -15,9 +15,8 @@ .SH SYNOPSIS
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
-.BI "int syscall(SYS_pidfd_send_signal, int " pidfd ", int " sig \
-", siginfo_t *" info ,
-.BI "                      unsigned int " flags );
+.BI "int syscall(SYS_pidfd_send_signal, int " pidfd ", int " sig ,
+.BI "            siginfo_t *_Nullable " info ", unsigned int " flags );
 .fi
 .PP
 .IR Note :
-- 
2.38.1

