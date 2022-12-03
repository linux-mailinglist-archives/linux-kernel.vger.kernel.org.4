Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA3641904
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLCU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiLCUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:25:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90E20190;
        Sat,  3 Dec 2022 12:24:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so7036159wms.0;
        Sat, 03 Dec 2022 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq0YIKvs91EloqBLVURHY7ywGGevAv8YL1HQCUUv+ec=;
        b=nNjtdAW6v+qNWz45/GQ+eIMRt0Ye0ZVpi7NmsW3w+INBxmBxrFghFY9OJiUjA4b86h
         gafKxouu4uQLc1l9TqRShydi4N9xYXd6vXKvJTWWg89AZUsfoNlbLAPeW0bz0n+TGE+C
         xNE0td57G8yEGdPv5fFuKuuNfsMHLmto2iu4e502k4aO+sCUNgz8XDmlShEALUXkPX+t
         chSgDwcWILrmXTnGPrzZOBfkb08+bj06VThaJYvrX7Cflj/5vAHqlb6h+G+K9fx0xrBB
         Vfp4kfSpLUdHY8/e/lU6KSQy/1uzsS65UQU93aCbgSvfeQD9bFv/kZCIi172DLJO515u
         Pyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq0YIKvs91EloqBLVURHY7ywGGevAv8YL1HQCUUv+ec=;
        b=kK0EaGIYycfl5sEpsFRxzZQPzBVc/K4XNt/pQDoiSkeCpooeayuUPpLz6TUK+SXv4E
         gHIJKQUsTvGzdX7F4X9A2fIlMdMSbotsTgNdxiBMrWbUZvZkEDaffPB683Jkm9txbjer
         rMZm6BDVtL9d64n+mk1ClXOanNTHtgwqrlBsZdNDhm7oSCefJQKcteDCCjgbC+nMc3fE
         nHwJvZPKn371Wojd1bceg3o9nr8XBPGa54IBD/hDMfC7qWqfsfRpo94GmyPlyWMi4PQq
         5AIXppyYpHM4vOASMRzksjWTI1WdNUJxVvkiVXiuyakp9UG/IjPPqPGOp2rggiRmjuG2
         gDWw==
X-Gm-Message-State: ANoB5pnIWO7m6bTwYU3qjAoPT5aDWGX9rvroAyx8JVm9b4zm7kAUMfhR
        5pYswiGIynQwRzh3R+rFoJoXRGMtoo8=
X-Google-Smtp-Source: AA0mqf6JMw5eS/bODt3/Sm/QHCjFs5BzbCCBeZertB2bEQt7bCv86xn84FWjiIZdngoip/uzwxVMbw==
X-Received: by 2002:a05:600c:a14:b0:3c7:a5:6113 with SMTP id z20-20020a05600c0a1400b003c700a56113mr45486913wmp.129.1670099029805;
        Sat, 03 Dec 2022 12:23:49 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:49 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 41/41] wait4.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:17 +0100
Message-Id: <20221203202317.252789-42-alx@kernel.org>
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
 man2/wait4.2 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/man2/wait4.2 b/man2/wait4.2
index 82983ac0b..6f011fe0e 100644
--- a/man2/wait4.2
+++ b/man2/wait4.2
@@ -20,9 +20,10 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/wait.h>
 .PP
-.BI "pid_t wait3(int *" "wstatus" ", int " options ", struct rusage *" rusage );
-.BI "pid_t wait4(pid_t " pid ", int *" wstatus ", int " options ,
-.BI "            struct rusage *" rusage );
+.BI "pid_t wait3(int *_Nullable " "wstatus" ", int " options ,
+.BI "            struct rusage *_Nullable " rusage );
+.BI "pid_t wait4(pid_t " pid ", int *_Nullable " wstatus ", int " options ,
+.BI "            struct rusage *_Nullable " rusage );
 .fi
 .PP
 .RS -4
-- 
2.38.1

