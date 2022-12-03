Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B36418C3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLCUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLCUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654171AD8A;
        Sat,  3 Dec 2022 12:23:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3166428wmb.5;
        Sat, 03 Dec 2022 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFwY4eQ8dWQ5Jyj/XIOoJNG8sFpiGBTyYfIENSQEkAM=;
        b=pCB6s197RCxmvW3w8d1tYzn0qpvaoagw3wZk2mICNuoR3RhgAqpuorzm3xyJDSpmYj
         xZSibsYlJZv/hkcpsWngYNHG70hkil6gVVaSxKCp1DwRbBCyFCOwV52nP2hcmA9JMq9M
         RJyM7qFx6u3Bna3PHYAyvylbNX6eQfXx4OzRAs+IFDBWwzC/aJ6lQjdlgD4P+32P0HJi
         ExeBSNqTOemDkydasND2PAWbS4wD5uROlROHNCva+w1Fg48iutOCYy7/boycBQOQO39c
         sjex0A/oX/UDlvKxZqta8tXdLE+kG+BaJTWSZfOYb4MfBcQSZz3XfZWhEabY0AB7cvWy
         +BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFwY4eQ8dWQ5Jyj/XIOoJNG8sFpiGBTyYfIENSQEkAM=;
        b=C2WbjHwrK4EeDh/gkYGE+vraIgFQ1uGY9/P7kvtkuaUYIt+p+gCctxjeXBQ6iNDUsC
         0dFWdC0p/5t79Skok67Xn6E8mdlb/GhuRY6y4QY8InI5skLwvEdBiM2OBXqt4YIXEmZr
         FCusS2tfM8exmd7fl9Nn8K/JNeXkoUdIW5bPhyoq6JHqfZfVc7jX13fMYWjKb+U7yl8Z
         TyDxZG0fp2dsDKM4lRFLdAFWB5/8x+JLap1NLfuZ/CXYEhBPTphj4fohldGLXexxVJ0m
         iusSq/MfGio9y/3gXuyTOh7a9y1TQ9RL/3R6JlCH3YXRsQvLiUkic5WKjsanpy/D2EnF
         V+0Q==
X-Gm-Message-State: ANoB5plHCLVr+GpIf/1uOYalgdWZlFNnxPPjymqrk5+DC1qGdSuyHbz/
        PYrtj8Uu7kW5BvwSGRhqNrJzm+tqmRo=
X-Google-Smtp-Source: AA0mqf4nPPHWckLGsYsEO5uz6Hpt6em29GW0MDDc+a6ak/k+7M7LeOhqUCzlxykJ5RAj2XgNNX5cRw==
X-Received: by 2002:a05:600c:5118:b0:3d0:7026:49eb with SMTP id o24-20020a05600c511800b003d0702649ebmr13438855wms.53.1670099002957;
        Sat, 03 Dec 2022 12:23:22 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:22 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/41] clock_nanosleep.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:40 +0100
Message-Id: <20221203202317.252789-5-alx@kernel.org>
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
 man2/clock_nanosleep.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/clock_nanosleep.2 b/man2/clock_nanosleep.2
index b5cd3e980..e74ca616f 100644
--- a/man2/clock_nanosleep.2
+++ b/man2/clock_nanosleep.2
@@ -20,7 +20,7 @@ .SH SYNOPSIS
 .PP
 .BI "int clock_nanosleep(clockid_t " clockid ", int " flags ,
 .BI "                    const struct timespec *" request ,
-.BI "                    struct timespec *" remain );
+.BI "                    struct timespec *_Nullable " remain );
 .fi
 .PP
 .RS -4
-- 
2.38.1

