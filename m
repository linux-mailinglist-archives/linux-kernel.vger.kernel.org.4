Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7E6418CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLCUYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLCUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CF1B9E8;
        Sat,  3 Dec 2022 12:23:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d1so12916142wrs.12;
        Sat, 03 Dec 2022 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skZbmTtYE58nKq4QcqMRf9qO9L8ldgMw3Cb8bJTrhSc=;
        b=Sq162+4qU3TDsaLqLJRaBv8+WSZ0TlsxQHhiOjWzLkP1IOGDwaEjjOkF9Ybk78a6ik
         dGgoC2zYtvHE8iD0mFw4Z25//nr2UjMKBgo7zj/fuSJDia7aquFRtiUgRNTbm0EdEXC+
         ymBIhFmHmqCKv2LLvJdhiP4hC/+S7fL5ykUC2P2UJU/hUWLa1QwxFtZilqj0T8QjQeHh
         bdxriDlEpbIa2koLw/Hld9sXWMR5diw2P7QvvFU75eI0NIiSKNzT9X6VDhrofoRnXAxV
         euDOcPaq7UGC5Wt0YnWX6141iWn4v+1Ui+YAY7GAXFJRSHlj2Utp+yq7Y9wrd1WqMPwp
         O3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skZbmTtYE58nKq4QcqMRf9qO9L8ldgMw3Cb8bJTrhSc=;
        b=Jd9th/O+3mWy9/EmP3cL/UqZzvMf1vts6jpz5LUELbMfprSkgs2z3ZVrAnKtRb49E6
         2KKFvfqXjw+lN7daHnt/+7R7o/gaPss1uwsQMCnCIqN05OrYOwOIlQnvvCfrjew5ZfRn
         sQILvSbZ6RKgMf/0NcG7huMCg3xHUhskvEUT0FIdFNSZvBnrewlX3i9m8uQGh9QcUyYd
         dqVmqWCE22CrDnd9rYeRhJvnEzlyLn0jM/got+qIHKweupVnMp3JLSNakX1SUC/rKat5
         7dB1SH0BdKaCGAcEpvmsFXc5pPR0Q74HJnaF4FLNtCgUINoOBr17YlBwUtG/rTIYkG0K
         jvSw==
X-Gm-Message-State: ANoB5pnU62Aa+qxU7jBqy5jDso2cuSR4qa9EuRMY1s3DS5FafOxFIVcz
        Z+MNkn0u8GWmcjfr5US1ACQyCihtHyE=
X-Google-Smtp-Source: AA0mqf5XjALaS+tnN7aa00c/fi1fBtpZZzb0M59UgPIJNid1scKg/v5KOpUs+82sV+H80rvMlEAoMg==
X-Received: by 2002:adf:d232:0:b0:242:2b3e:4019 with SMTP id k18-20020adfd232000000b002422b3e4019mr10893836wrh.449.1670099010026;
        Sat, 03 Dec 2022 12:23:30 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/41] getitimer.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:50 +0100
Message-Id: <20221203202317.252789-15-alx@kernel.org>
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
 man2/getitimer.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/getitimer.2 b/man2/getitimer.2
index 0736837a4..3c86acfd5 100644
--- a/man2/getitimer.2
+++ b/man2/getitimer.2
@@ -22,7 +22,7 @@ .SH SYNOPSIS
 .PP
 .BI "int getitimer(int " which ", struct itimerval *" curr_value );
 .BI "int setitimer(int " which ", const struct itimerval *restrict " new_value ,
-.BI "              struct itimerval *restrict " old_value );
+.BI "              struct itimerval *_Nullable restrict " old_value );
 .fi
 .SH DESCRIPTION
 These system calls provide access to interval timers, that is,
-- 
2.38.1

