Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5D9641900
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLCU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiLCUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:25:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D21FCF2;
        Sat,  3 Dec 2022 12:24:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q7so12953148wrr.8;
        Sat, 03 Dec 2022 12:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnt9AfNaORuOhspSBEzC93RhtiBKbIOqpI9Y+D1VDIU=;
        b=SX0Ubt1AfoPoDtGj4KvNDSwXzzBW2xsgwvJnOgEWYJLCiH+lZq23XxP4m3TGbiIZjR
         a+LKwD1bD8D+A/0l10KANIrUbLWDu17Z79eu6ataNrfAEjATHmshUfqSJLIqBcVqvUX7
         guZZxwM123hisBhxJG4gZ3ZE1oZkulfTEaHhSUNY+KvJ/c4p6+grCIb2WyeH19oA4fXe
         e0S2XX3hj4MPlsXeJ0RyusXZSAk6rvsdy6WeDEinHYUUOIZXWmQkXq5e3A4MfmZTpExR
         RT74y7JK28PRaSK/F9am8IftAH7279v6xloy6isykkzwpUei34v8Mpvnc6IMn1vHmSRv
         +oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnt9AfNaORuOhspSBEzC93RhtiBKbIOqpI9Y+D1VDIU=;
        b=SH16Wi760fMqk5KjrxG8uf2smmp85M6GKoBoDRcbNUciHfXQEX4JP0D/ajjmhJF4Cv
         ze0VeEFSAqgxt5A7dZRH99ZYu2hoMbFPq8+7mWI04xBtdrOkz46V0ez4X4FJXn3gCrlo
         uhwIRtKKaD5096PhrEHqamKW8SJiAe70sm1Kv6UMKiA2MIZJxxV2470a8YuylCJYBAru
         NOWlFAu/wSg9vfqN+pDtL6Zde4ES9dvNOTM1he9iXCoCiUF3u81ZtOozIDhCnphcXiqj
         vjN+q8jpDRDPjpjqUSf060EXgMeZeNc8MuxNen4OF6i4VeA9E9se7gh0TQqcoQG/UjB7
         DGcQ==
X-Gm-Message-State: ANoB5plKRnKqgknMFNW0/SZBQ2CmNuclLbcloI5fdCUpV1D8j7Sqyyzb
        UObXjgywSbxzmwvXcCiha9BetMCs3hE=
X-Google-Smtp-Source: AA0mqf4tjjFgQ/1GUXXDXt7aKvXUQFb7HFjZtGPOrh+84lUCOJMZpcquP3aizkcGA1nuUZvmRz948A==
X-Received: by 2002:adf:e852:0:b0:242:2390:15c with SMTP id d18-20020adfe852000000b002422390015cmr13115902wrn.381.1670099025307;
        Sat, 03 Dec 2022 12:23:45 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:45 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 35/41] timer_create.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:11 +0100
Message-Id: <20221203202317.252789-36-alx@kernel.org>
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
 man2/timer_create.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/timer_create.2 b/man2/timer_create.2
index f17ef4a8a..bb5e6e238 100644
--- a/man2/timer_create.2
+++ b/man2/timer_create.2
@@ -14,7 +14,8 @@ .SH SYNOPSIS
 .BR "#include <signal.h>" "           /* Definition of " SIGEV_* " constants */"
 .B  #include <time.h>
 .PP
-.BI "int timer_create(clockid_t " clockid ", struct sigevent *restrict " sevp ,
+.BI "int timer_create(clockid_t " clockid ,
+.BI "                 struct sigevent *_Nullable restrict " sevp ,
 .BI "                 timer_t *restrict " timerid );
 .fi
 .PP
-- 
2.38.1

