Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18BD6418EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLCUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiLCUYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAE1F2E3;
        Sat,  3 Dec 2022 12:23:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o5so12987819wrm.1;
        Sat, 03 Dec 2022 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVswvjB2s5zxHDLCycMMfq9EkZt6Qbq33jEI6ganwss=;
        b=Ju3daQfZkgTU4bebukLM6+Zhk0Jrkpk58L2o6A8WayqyBFTofmLEK8od4Ks2qPWU4w
         MKBZ1IxkbH7MdJCa2eXyDG9ff7VVRnjQA7AEj5njocAWT2wfO+HvzLM4Qis+w8BzVJ96
         QB0yKGrfXqe2WyOXWtsbTShirFHSUMkJpqRKjm/Xzk6FMhb5bOhjBtymz7n0lTlyscRv
         g9UOnrs5wde52DxCJ0INEyau/K9lY3TrEfoa4/aeNKEkm40W7tu+tIGqE54AMPmTseSW
         f3m+c2tSCFWIZzNxQqFscdRZaEzOPSr3MkLc9PFVQX1dK9inCxkfIiCHRQE+rkRlKxIJ
         e3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVswvjB2s5zxHDLCycMMfq9EkZt6Qbq33jEI6ganwss=;
        b=mJf32qqffqlNFqIKgJ+WSupd7/v2mStuul3B6PferMl27np4+j5kKQ3t7r5E25RLDG
         FGCnla834sgDOU7VK6R7+oyqEQU4n3KSh5LznP2kX2h5SJaKOOV4IyymxTO3D7TrjUiT
         x4d29Y0dpEmLEmEtkrrlTgVCf/er+FsjoQjus6eE8BBcOWCrKNGlmFlc9IOPLJoVypjd
         7R2ErZcNfrxLPwOyn8f2NYVUjdCgOTdwF6VOk5C7+cB93D3HqfW9psc5OT5nn47VVMFQ
         44GloAqe3IsNsb/My92jPYxA2UoRrpnL+/AHW3cbc7YPsvsi6lw7iHwVMSgEQnFCI50H
         yjwQ==
X-Gm-Message-State: ANoB5pmg9opVwoT2cvH0iY54vMMqyLR0vfYIQ/bEBAjxC+mPi3bt2rtt
        YSKJA8UAj7l/9B8jSU2Mk7dK5XaB7H8=
X-Google-Smtp-Source: AA0mqf63P7yXbVPXdszgOp8t7ekbAwqKSz/Sg12Axnk6SPAhoRc9b15NbXeSYbvUOvkaUGXcBui62g==
X-Received: by 2002:adf:e848:0:b0:242:11f1:ed1 with SMTP id d8-20020adfe848000000b0024211f10ed1mr20368879wrn.61.1670099023167;
        Sat, 03 Dec 2022 12:23:43 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:42 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 32/41] sigwaitinfo.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:08 +0100
Message-Id: <20221203202317.252789-33-alx@kernel.org>
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
 man2/sigwaitinfo.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/sigwaitinfo.2 b/man2/sigwaitinfo.2
index 96cf54e9a..42209c180 100644
--- a/man2/sigwaitinfo.2
+++ b/man2/sigwaitinfo.2
@@ -14,9 +14,9 @@ .SH SYNOPSIS
 .B #include <signal.h>
 .PP
 .BI "int sigwaitinfo(const sigset_t *restrict " set ,
-.BI "                siginfo_t *restrict " info );
+.BI "                siginfo_t *_Nullable restrict " info );
 .BI "int sigtimedwait(const sigset_t *restrict " set ,
-.BI "                siginfo_t *restrict " info ,
+.BI "                siginfo_t *_Nullable restrict " info ,
 .BI "                const struct timespec *restrict " timeout );
 .fi
 .PP
-- 
2.38.1

