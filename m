Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD596418D0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLCUYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiLCUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551011C11F;
        Sat,  3 Dec 2022 12:23:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx10so13017099wrb.0;
        Sat, 03 Dec 2022 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X5cczScoJwWo6pYAorZfC4d9KAmYpNe0qZkfHI6UHw=;
        b=N1tmC+PIkfwA6v4xls18IqWMxs/dkKG4/lyeL631AjouLTJ5Znq2fI6kLcXhzoLib9
         RwvL7d5S6+yXh1bFKnlO5UVi5PbSMILiPnxY7g9QtkPB8EDF0EBY9+TX33ohESh5u9zl
         G946fWmWz031hOJkI8gXWFRr/8iTL/h3PoDBCbqFPV5etorlNoJXaA/XfNABoezsaeX8
         RC432Nl+2YKbYyK4FqYensSTXlvw7XUXFujyS2XsMKfamiphLYXZXMF9nM0TDEzkduu0
         Q6Ioz8jG5FwXtJe6RipVmsSMYOC6oPsRgtGyVzkqMtvoLlexgySQu6O9s4z6NfMxT8ub
         AJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X5cczScoJwWo6pYAorZfC4d9KAmYpNe0qZkfHI6UHw=;
        b=02F0B5GsR/mwMDpZ1AvOj41dWC8l9lMwOvxFxL7XtOzuefiBtmeIynlqE4kLBY0eQM
         kv3pB+TwctVco2zEn9wGeXO2fziTvWYn36SjvxzraGeFUZP8nCSlCJbha+wNOdTZ8XP1
         Y/wNdYzAbLEGKWfrJwenuJSRrEssMqZeKTsbbLvOVI8596qhknXQ7suBzFQHLL5Nnl+M
         y0G9C/2+Hs3yjj0yw+P8YghUA5tik6rBJBA9LcP2wGBxHq5sV1/Q6gegV89wVMnPyye2
         eIJVMKOOu0svqm6EUmRqfXkqeOychs0KNaFz9IUMN8qGFTgzFI+AQbg6h2RZ3AdwX3hQ
         mIoQ==
X-Gm-Message-State: ANoB5pmdJmaYwQcF9Lb7hIMvNODqFkMa7IO9536dK8ouatF5mYPioAt7
        vWA0dmDpFbObhTBn5AxKl6NngdX3Z7U=
X-Google-Smtp-Source: AA0mqf46qKsvuHx6LGdHgSj+R8oIly1y6dU7R+T+jyo+nO0N0GpHV5h2TOz7POEb0zWbM9/8f94Vkw==
X-Received: by 2002:adf:e2c3:0:b0:236:65f2:eade with SMTP id d3-20020adfe2c3000000b0023665f2eademr33753858wrj.608.1670099010776;
        Sat, 03 Dec 2022 12:23:30 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:30 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/41] getrlimit.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:51 +0100
Message-Id: <20221203202317.252789-16-alx@kernel.org>
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
 man2/getrlimit.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/getrlimit.2 b/man2/getrlimit.2
index c27709e18..56003da49 100644
--- a/man2/getrlimit.2
+++ b/man2/getrlimit.2
@@ -54,8 +54,9 @@ .SH SYNOPSIS
 .BI "int getrlimit(int " resource ", struct rlimit *" rlim );
 .BI "int setrlimit(int " resource ", const struct rlimit *" rlim );
 .PP
-.BI "int prlimit(pid_t "  pid ", int " resource ", const struct rlimit *" new_limit ,
-.BI "            struct rlimit *" old_limit );
+.BI "int prlimit(pid_t "  pid ", int " resource ,
+.BI "            const struct rlimit *_Nullable " new_limit ,
+.BI "            struct rlimit *_Nullable " old_limit );
 .fi
 .PP
 .RS -4
-- 
2.38.1

