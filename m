Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA97B6418F8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLCUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLCUYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F91F2DD;
        Sat,  3 Dec 2022 12:23:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3166964wmb.5;
        Sat, 03 Dec 2022 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzCQj1vYc0rQAUR5/LjGiTVeqqPjnOYMVn62iD1gcN4=;
        b=EBfCfVeGhoWgCzR06lLE45xF+nZBVFbCxWwNYJiEmaxBSa84G9E7L8F9EqmwiEn0qh
         mBuDFAyxnvGffU/TEO9w6NIq6v7Xn8CdPwP1JE1Lx974QYSN2VCGSukZUhIn6n/7pRSe
         0MWTxvWNkO77wIMzfSghwoQtmdMkH933kIaOWJaRHyjs+ZyXTU7ypAjeJgW+Rc/pDXOT
         TJs6JvTf1pemWav4ieLMTBO06caXZAJPomESs+vzG8ONSwo26UcWdEn2F8yCP5qCoCZX
         55ezTlqFQS1paX6Ay/+GPig3Si/Meg07N1RoflnhzdIATLoil/WEyU9GmIOTnK/oGBI2
         zwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzCQj1vYc0rQAUR5/LjGiTVeqqPjnOYMVn62iD1gcN4=;
        b=JvxpwmDQm7Yo1+Sm2gsI0V8Kyu802SjzCHlBHKxf3IGYKZmbDEDsTA8HfgBDhVDJr8
         ojA32vfr2tsiizxNkWhtQ9Aj3tJ6Faa8cYkh3kmBpk1IqsVZdY6NHYQLSP5xHBpTZDp7
         C9snfx6szxqbg2WHnXVwZEMvYeXStld0oniryTE9slXIHGlNEhz8t+4o9VIhYiOVWlfM
         r9OQrQL6k5gXTHe5NZ+Ia17TZ8jvZQcSETfFTPPd09sZ1MKrbeM0XtmKORMb8RR82kBw
         RmTXVIBfis890ntFc191DTDR94cORJqF/kkRSj9v7dXwNifhAoqvoGbjGYAgxY5JX9h8
         rBXA==
X-Gm-Message-State: ANoB5pmn22EZ9okdS/q4eBGcdL8OyiUnM82BnDBvsU1QyvZC3h/eVu94
        eCu9taOWvwzCtxc6XRfxNfLJNeNiSjk=
X-Google-Smtp-Source: AA0mqf6wQQsKz2AYWx37HRnvUF34hzV9OWNVQErVFjDEuPZrWwZJohINdfe8nMFh2ChyWj+wxmJihg==
X-Received: by 2002:a05:600c:1d24:b0:3cf:6fd0:8168 with SMTP id l36-20020a05600c1d2400b003cf6fd08168mr41645317wms.206.1670099029096;
        Sat, 03 Dec 2022 12:23:49 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:48 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 40/41] wait.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:16 +0100
Message-Id: <20221203202317.252789-41-alx@kernel.org>
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
 man2/wait.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/wait.2 b/man2/wait.2
index 7f958ea71..6a5a1309f 100644
--- a/man2/wait.2
+++ b/man2/wait.2
@@ -36,8 +36,8 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/wait.h>
 .PP
-.BI "pid_t wait(int *" "wstatus" );
-.BI "pid_t waitpid(pid_t " pid ", int *" wstatus ", int " options );
+.BI "pid_t wait(int *_Nullable " "wstatus" );
+.BI "pid_t waitpid(pid_t " pid ", int *_Nullable " wstatus ", int " options );
 .PP
 .BI "int waitid(idtype_t " idtype ", id_t " id \
 ", siginfo_t *" infop ", int " options );
-- 
2.38.1

