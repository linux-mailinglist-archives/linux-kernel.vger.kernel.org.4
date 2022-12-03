Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68C86418FB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLCUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLCUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:50 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E031F2F5;
        Sat,  3 Dec 2022 12:23:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so8951855wmb.2;
        Sat, 03 Dec 2022 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng1bKkojgaZBk5rLU45vjhP1sZYVUf1LqX6cIkBxsJc=;
        b=UeadT1kX/inuhL51JdFbh9ovVNFxt9nj/NYmOURLHK+IGmPpLcFqiwtHqnpvHimJVr
         lRlCgGabLO1nKRIMPA/OVgANk1sJ5eTgZrjymmKgEY6x/H7Q2XI49/wF8Z1mgNSr/AhJ
         izqWYf5PfCaG67mud3L9ZvW3DwNeOkfNcM/79lITO7A1TcZY2yLFVyGiMyu3NMa+Y0zI
         Mfs58M/FleapjFNJwzSiuLVmdSgTBdXfj4yW4p2u87S/zmhNsNmxGwT1dcFmNidHhPjh
         p9bJKoc1kNQ1Bi21SWR0/4IQ/jZ7OtIgd6xyFqCPKPcU8X49QGZVJ6uCjij+yVDErgpF
         HmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng1bKkojgaZBk5rLU45vjhP1sZYVUf1LqX6cIkBxsJc=;
        b=2rxidmBkpX1+XiF9Hswi2ft6HPKI+TageWnp0b4Dl4kq4zzpA+0g2oSll0Ig5AReCV
         cbyH7OBrtA9Yiou6TAMfMXb7jReIkitYf+NqcNt8sGWu+uKORzPQFlRWT9pIwxR6DYUb
         UrSyzU4fZ6Wf1m+RK4XZnM2/PQFbO6xd8DbT3n5hK7GjtcTHyds2V3MomDzRii+qO+fP
         lH5S/SoTtuJUbPF1HW6jtpqYVSmRuJ8s6SB5cs11Gm1l7kv/nJVPXFIfstEcoPLjgiA0
         pzOe60HAT7JZPAgIs8fuxndklZMIzfZmob3JoyoJu60aaJ4GzuqkJtr57f3vjMFIgPMR
         pOFA==
X-Gm-Message-State: ANoB5pl8IAQlRcicjvOqCHP7dERVRkXmyGS2uRV9DNZ+zcSis0KOhXuq
        xlyBvMhZ1w1CZtpSzqFLxWMGNb7mJwU=
X-Google-Smtp-Source: AA0mqf7uzSWnn+VLZcJANXSIJZ4wRuBwpcZFmKPOr+4rGQpS5F05ggjB/vXLcorqXdGSA6k6FaDA1g==
X-Received: by 2002:a05:600c:4fcd:b0:3cf:a11a:c775 with SMTP id o13-20020a05600c4fcd00b003cfa11ac775mr46389561wmq.153.1670099027515;
        Sat, 03 Dec 2022 12:23:47 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:47 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/41] utime.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:14 +0100
Message-Id: <20221203202317.252789-39-alx@kernel.org>
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
 man2/utime.2 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man2/utime.2 b/man2/utime.2
index cee165344..c364c4390 100644
--- a/man2/utime.2
+++ b/man2/utime.2
@@ -18,11 +18,13 @@ .SH SYNOPSIS
 .nf
 .B #include <utime.h>
 .PP
-.BI "int utime(const char *" filename ", const struct utimbuf *" times );
+.BI "int utime(const char *" filename ,
+.BI "          const struct utimbuf *_Nullable " times );
 .PP
 .B #include <sys/time.h>
 .PP
-.BI "int utimes(const char *" filename ", const struct timeval " times [2]);
+.BI "int utimes(const char *" filename ,
+.BI "          const struct timeval " times "[_Nullable 2]);"
 .fi
 .SH DESCRIPTION
 .B Note:
-- 
2.38.1

