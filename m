Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AF6418C9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLCUX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLCUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D171CB39;
        Sat,  3 Dec 2022 12:23:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m19so5926135wms.5;
        Sat, 03 Dec 2022 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo4PuuGlZjIDX8OoQNd/kpvQDjajBgbFeWG8xmSL+08=;
        b=FrbiAGKdfGsKM3qMItwtI25tm19bClEHW151TD+x62x2qsyYe6k7a3QTrLeF8trbWG
         0YeG7n54IGWV4NUQwxjAueHatxNcgbUck5iIID05Q+Jlz16S6M6xnzrVCozGyjVQNJD6
         3zXkeTiOglFDbOoNxTn7/IwRPAo6FXfuihf248Pt2nBEfAs82s6Mu3gbvFpdXIa8CL0B
         RftnQudlbODI22UIpC7sviHtneCF1WsWqxXxdVxrY61YJ3iE6/pb3yA9GdcWUsym3vFV
         YSM89lpGtFXfd8PJ9hB6Rw1DEVb4lv6FnXOIN1cn7w65FVnXpbQqoo5CJ1zIGb5iADFO
         kMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo4PuuGlZjIDX8OoQNd/kpvQDjajBgbFeWG8xmSL+08=;
        b=bslMgDMT6iKgavYKNIrz8ef/QyCr/wTKo4YK5bHqFVR4OjbfISmX/QUn9rVElcz+H3
         X9ylSmicBYmf8bCwYLGkN2SyIE/r1WAtx0If1PWYLIPp6NaDDQkHAEyHHttzNFAV1/+t
         iNSbrvV+QpnkPXNOPnusHRXsxqPggjU+pHslZFeWnh/zm3NTozfee/YUXuzYl/V4P7nm
         GCAArBxjdd36rRnFVnp3lhs7evTdCf7MZmeXr+w/WXFcnC1Ui1tMaMT2QxFdn94w7uhq
         1RXb9D0cyiZgRnU/i+Pr81faMoCAY5e2hAsfkIbJ/MnOkt2nuqqZrpRYDr9g1lVJjFYU
         c6yQ==
X-Gm-Message-State: ANoB5plyRmWfuOejptk2k6jizhqTxvs5sPGN7c++ngKMMT17LDYUmZ3O
        QQf3nDQdOVHJOHiu9cOBpPVl2o5ttjs=
X-Google-Smtp-Source: AA0mqf7PkRs3Z+n277w1pTUu7avDUmySGqQpIRobVlwYGImpP/t5BAy+q1auUrr7sal2Uch6L4OITA==
X-Received: by 2002:a05:600c:35c7:b0:3cf:7dc1:f432 with SMTP id r7-20020a05600c35c700b003cf7dc1f432mr57454379wmq.148.1670099006539;
        Sat, 03 Dec 2022 12:23:26 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:26 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/41] execve.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:45 +0100
Message-Id: <20221203202317.252789-10-alx@kernel.org>
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
 man2/execve.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/execve.2 b/man2/execve.2
index 54c2d0040..35eba65f1 100644
--- a/man2/execve.2
+++ b/man2/execve.2
@@ -24,8 +24,8 @@ .SH SYNOPSIS
 .nf
 .B #include <unistd.h>
 .PP
-.BI "int execve(const char *" pathname ", char *const " argv [],
-.BI "           char *const " envp []);
+.BI "int execve(const char *" pathname ", char *const _Nullable " argv [],
+.BI "           char *const _Nullable " envp []);
 .fi
 .SH DESCRIPTION
 .BR execve ()
-- 
2.38.1

