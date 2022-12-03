Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188376418EE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLCUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiLCUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAC1EEEF;
        Sat,  3 Dec 2022 12:23:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w15so12943390wrl.9;
        Sat, 03 Dec 2022 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0s52S2JC0MhYvepWYRB9l+MR5Vkzxl4dABEchKbHOA=;
        b=CfWxpFIZ8beGlD5DkhvO0TDb0uK2IMQANInbZzHPv2sfp2/kcvif1potOYzU7GMJ2w
         OKQKJm8QsjgzhxmDZ+x5hkNfAqffJVTmlg0VorrSGWKkKdAkZ4E2UO4p4u98JffUwE/Q
         EJiYzqXf74xBEybyhKVKvXG3dOEksSMp2gufe5EdZCRDW40SfYMe+VfD0/LQmcnM8AN0
         PtqgbFvY6p7yDPS4TNzSMFKWu9p205Bp4LYX8HLh7svuY+dQYBhAdQxHCUf/P/uabspy
         gW7NfZ0RV3oWaxzMZih/9bu/bGRZby1m1h8D43aHk2tbIiwl+rm5j8RLM/LY0aSCjIlk
         6ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0s52S2JC0MhYvepWYRB9l+MR5Vkzxl4dABEchKbHOA=;
        b=6i1Zsflz2WgKk6vWBZU5Zn66Toot660ESL9zCb7eJOrYkDmt5eaE7Fb6BhH/oRGfdj
         en+ybMX/u8Ul8iFPxqzbnpSYM8F1L5DdbJXCwAr2tqzT0+uDAmQGI+2b8/aAHUT5HYuP
         ys+ytYfzzWmZ8+0XjlZXAsD1IhG8xJAm/OV9cK9SPDmI9jdtrjbTPSdAWs1r1Z9PZG8q
         ukneb2qjZJUqlpfMtffm8JbmIc1MJgdsQOgOAFsht6PvdDgThzthbBobh5mtSVrnXnke
         AH30/JqAgteP3zfEr02GGBv19JFNdjUI4h9tai5ITcKPqLGz87rm40OiO1RA1hgIc7FW
         VjWw==
X-Gm-Message-State: ANoB5pkJZua04T2zPaRmqRSOAEI249ip08kfJ8wRFbq0NyK9VS1omHRa
        +h1wqPiJ2p9EEQH8BkzIbCmf8vvQLCc=
X-Google-Smtp-Source: AA0mqf5niEBsMCravbQnU8BH58Z4oxQDHIqElPGuhhEcDX2WxnCUEQanZR3ee8rWwPCBk62oBhThEQ==
X-Received: by 2002:a5d:4247:0:b0:241:a82b:5dee with SMTP id s7-20020a5d4247000000b00241a82b5deemr35311654wrr.425.1670099019511;
        Sat, 03 Dec 2022 12:23:39 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:39 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/41] sendfile.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:03 +0100
Message-Id: <20221203202317.252789-28-alx@kernel.org>
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
 man2/sendfile.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/sendfile.2 b/man2/sendfile.2
index a50f2797a..9dbe1691c 100644
--- a/man2/sendfile.2
+++ b/man2/sendfile.2
@@ -26,8 +26,9 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/sendfile.h>
 .PP
-.BI "ssize_t sendfile(int" " out_fd" ", int" " in_fd" ", off_t *" \
-                      offset ", size_t" " count" );
+.BI "ssize_t sendfile(int" " out_fd" ", int" " in_fd" ", \
+off_t *_Nullable " offset ,
+.BI "                 size_t" " count" );
 .\" The below is too ugly. Comments about glibc versions belong
 .\" in the notes, not in the header.
 .\"
-- 
2.38.1

