Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7506418D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLCUYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLCUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038321DDFC;
        Sat,  3 Dec 2022 12:23:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h10so3415078wrx.3;
        Sat, 03 Dec 2022 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTeh/nwMuqCIxYt3v55lpJUafAS9U4WS4w7k5QALkX8=;
        b=QvPMBwfHMpLfgmuRWhM5u46z0+Soqe0v4OIY11JxOMtHQlCXj7WkTGfriKC01YmyO5
         Z11pX8qttPZmI1KS3hE4HRjK2IbS4stbcOkE6H0k0Ill8VQuqtbZeyaWivbY6qd1MLqX
         2ABS8RfdTLyAlN7iCPAMZJCsN+DFG+IarkADGB2I/xvnhRuw6QGG9mbxo+WxLLcmrN7O
         ogJ42OYZqslVhCJQ7BJW0StiUe8STgk+MYbep3ptOmAm5MyS5MR/ixNwRMcKF4xSXQ02
         dsSiODiE7unS8ENHe8icrQ3SS7O0le93aApT2mreYxk0ydQJsqlzpfJbJ+niHHnHggGo
         RzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTeh/nwMuqCIxYt3v55lpJUafAS9U4WS4w7k5QALkX8=;
        b=1RhMW8jBKrIZnVGDzouXYSChu3jLw2ZKC0W9zpqzmDVZZfkSWQ4pw1VhkNKN6KF9/H
         WlyqwpiHmEXCJ1DYWHsALiIfDsaQTtfhODCTTVKYlVg1GTCYFbpgmD9K4ra1eUZV9NGV
         lD28CTfpoIUa7GoNMHxbupjb18wyPOmO9prs+0as2AveQSh6tpX80Sk9j+Nz5So21iLn
         1b5qYcHkzbX3hPh05/gWPzjz6Ro73zlXd2O7eW3saYrWxKLcsPB20WWIo40g6IUE2ki9
         vtI2XHGg+MZlNJkn+JJpQKECdCZOAd0i7ccQHH3I5kz6/Zpl/bk0o1SJmheYQEzRK6rh
         CyTg==
X-Gm-Message-State: ANoB5pmiLOKDHTQQVdm7GaHom35x6h/Xb4eGd61oY5MD7eDReO8edMDu
        Q1KgmBwPJkhGgqMlkrcMPBGnpOeeYlA=
X-Google-Smtp-Source: AA0mqf6jzLDOCxIGUaZwu7nGYesrp2WX3ukq3HuYVZfA0tjKgVhFGWT9HZsQjTrb9Zhb/pn+ZFEPTA==
X-Received: by 2002:adf:fd45:0:b0:242:48df:b4e4 with SMTP id h5-20020adffd45000000b0024248dfb4e4mr4063409wrs.660.1670099011541;
        Sat, 03 Dec 2022 12:23:31 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:31 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/41] gettimeofday.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:52 +0100
Message-Id: <20221203202317.252789-17-alx@kernel.org>
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
 man2/gettimeofday.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/gettimeofday.2 b/man2/gettimeofday.2
index 1c9775820..8ef5ac271 100644
--- a/man2/gettimeofday.2
+++ b/man2/gettimeofday.2
@@ -28,9 +28,9 @@ .SH SYNOPSIS
 .B #include <sys/time.h>
 .PP
 .BI "int gettimeofday(struct timeval *restrict " tv ,
-.BI "                 struct timezone *restrict " tz );
+.BI "                 struct timezone *_Nullable restrict " tz );
 .BI "int settimeofday(const struct timeval *" tv ,
-.BI "                 const struct timezone *" tz );
+.BI "                 const struct timezone *_Nullable " tz );
 .fi
 .PP
 .RS -4
-- 
2.38.1

