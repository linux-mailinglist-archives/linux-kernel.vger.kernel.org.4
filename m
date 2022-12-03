Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB56418E9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLCUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiLCUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4CE1EEC0;
        Sat,  3 Dec 2022 12:23:39 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n16-20020a05600c3b9000b003d08febff59so2234358wms.3;
        Sat, 03 Dec 2022 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GaIXDtBbV20KozeERajGOhceV7IwDabqvs06lwVtd8=;
        b=nu4M1blYUkxqL3Lx1EqkpSLHQE2NReYKQubtMQkQskf+RrVAhMo9rNNbN7HWRCsnWS
         1AeCKZsmJsgzckfS32UTR+50xQs32/Bg26GG0TnLXmdEdOD245nwd0gmbDUjtej2lBH/
         yfITEN3foxvKAac0drIEejY649wX7kbtmz6FjMmKU5/tG1H0hHRV07BfeH1yCyWaod2S
         /Bdy47+D5yFSCKImcZdB6amJbanH1aSrc3ZZMP90buW66KOrU+xPSQl8dDn6lUXY+cd9
         RW+MsHCofcd+/F1/kIm64PNikcsh5RuLqkG/Yufn6HMULavtk37o+rajmT4PpFiyQ9A0
         /xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GaIXDtBbV20KozeERajGOhceV7IwDabqvs06lwVtd8=;
        b=Nk1bMSxNsQKTQvlrd9H++7uK8NDleaqDtjhy488uRlVpmR59/lk2D06EbQilA1MAFM
         i0ngKPbOY9RaVkA6E40oKEYVkEjd4aDcBZozeA5wWHHxgKGVIM3vyGEqpGRHKxN0H26L
         Mh0neRJihZsveS5JvYsucvSaKLx4AL3hQd+7r99bfOVGB2MAjl8ZA51d3X+yNR/A9ZHQ
         YOM32RIAC2O4yLuF2LZg/aRe9z0MZm4gK2DIiDQ6jDnos4GVQNmiIV4HGTkPdj7p4lLl
         OILhqJ8nu7OKKs3qFy5URohoxF1z55P+zpvGHNV9Hm8wJ1ujGodqA3PDtUTvXsMzoNY5
         4RzA==
X-Gm-Message-State: ANoB5pnJwys/VfoPzEtTFFV5dD/Xg1LAFeggbugZpkH16j6MmrDAfbYu
        goB9QZlcpTU7CnpICC7Mr/OL+CZeCkk=
X-Google-Smtp-Source: AA0mqf6VusSEH+u/4XLTl27yYNFxs9L8PyuYvOCR2UeLQPe9FkKW7I/8BqhX2uCP2MVyHbkNaMyU5g==
X-Received: by 2002:a05:600c:31a3:b0:3cf:4757:fc3 with SMTP id s35-20020a05600c31a300b003cf47570fc3mr56710605wmp.172.1670099018096;
        Sat, 03 Dec 2022 12:23:38 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:37 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/41] select.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:01 +0100
Message-Id: <20221203202317.252789-26-alx@kernel.org>
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
 man2/select.2 | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/man2/select.2 b/man2/select.2
index 199522a01..f13d20420 100644
--- a/man2/select.2
+++ b/man2/select.2
@@ -30,19 +30,21 @@ .SH SYNOPSIS
 .PP
 .BR typedef " /* ... */ " fd_set;
 .PP
-.BI "int select(int " nfds ", fd_set *restrict " readfds ,
-.BI "           fd_set *restrict " writefds ", fd_set *restrict " exceptfds ,
-.BI "           struct timeval *restrict " timeout );
+.BI "int select(int " nfds ", fd_set *_Nullable restrict " readfds ,
+.BI "           fd_set *_Nullable restrict " writefds ,
+.BI "           fd_set *_Nullable restrict " exceptfds ,
+.BI "           struct timeval *_Nullable restrict " timeout );
 .PP
 .BI "void FD_CLR(int " fd ", fd_set *" set );
 .BI "int  FD_ISSET(int " fd ", fd_set *" set );
 .BI "void FD_SET(int " fd ", fd_set *" set );
 .BI "void FD_ZERO(fd_set *" set );
 .PP
-.BI "int pselect(int " nfds ", fd_set *restrict " readfds ,
-.BI "           fd_set *restrict " writefds ", fd_set *restrict " exceptfds ,
-.BI "           const struct timespec *restrict " timeout ,
-.BI "           const sigset_t *restrict " sigmask );
+.BI "int pselect(int " nfds ", fd_set *_Nullable restrict " readfds ,
+.BI "           fd_set *_Nullable restrict " writefds ,
+.BI "           fd_set *_Nullable restrict " exceptfds ,
+.BI "           const struct timespec *_Nullable restrict " timeout ,
+.BI "           const sigset_t *_Nullable restrict " sigmask );
 .fi
 .PP
 .RS -4
-- 
2.38.1

