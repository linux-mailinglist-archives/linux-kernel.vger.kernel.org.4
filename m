Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9006418D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLCUY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiLCUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEF61DDF4;
        Sat,  3 Dec 2022 12:23:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so2317873wms.4;
        Sat, 03 Dec 2022 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOu2KhQpO+4qdvGsqITXVC4GbRJMLiqUjUwKx6g/DNs=;
        b=YaHaE6vmidu2f7WF/O68oe11t7TkH8nu4GDd9ZcoGqym1TM1Bh2RuakwBaJLCh8dDw
         Y+3a/xy9Ox1xnLD+hZ+puN9uwqPLdMzUPtr97+ZjoKwQpt5bFPhEAGaCaSuAKMojrEX5
         sb5hkXV+Y0vn60/XIvg6JY6wrvxsDtKYQZKcgoipkDT5SwKCQoujk+7IlUUpWiAn6ODt
         U9ITRtRHdDHcs7U4coVcRp7jA+Pz+fRgq2XZc5k+xLZCn9cW7mwuMSXrR40lFwiSXcBy
         P30wPHtg/pqQvFg/EvlWhI9vIgbq6wVjGUcZhrhXnxVPlED295VDvQcVrICnZnUk8o2Z
         AAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOu2KhQpO+4qdvGsqITXVC4GbRJMLiqUjUwKx6g/DNs=;
        b=mdRSV8EH0/u6BpBJu06h27HtjP6JjAZKU8Yxp/76aSjFAAzduxpgr5BIPiY/RdDsys
         z7u0hQ5HGJ4dX4NBvBLBg8nxlYUtgRtIczVy3SCjZjctdvIi9ZUBf+1x9GT90/tg5vvM
         7v/Sm5Ts075kyc95JxcYYP1sz9yqL7Bj+g/olQodgJQX7ZLmfEWRMar4vpuDLOkqt592
         7A5oqR2jg/WR6dYaQcQxnr+j/25PEP/OJp+o7kmEpsZr2vRuD/k3yCPqKgvKjADrmhsa
         npn6aqJ1fTTq3xvNZh0i74FO2XENmVMhzJFVDJk/5uU3ShunzYPEmx2o04hbq38jNRFg
         D7SA==
X-Gm-Message-State: ANoB5pllLF5dyRieJWWQ+NKfG5y/AazWGXQU0WFSHIc4CiFPcTqw8yja
        myOh8baU4wtHJElzjrN7Q7Zjjv/euBc=
X-Google-Smtp-Source: AA0mqf71GmwCzZyZF8+CPwuQZFaKoyBHVfEEor9+hoGMDKF8ieghrFtcK9WSUaPAeS6pC/mzj8H2DA==
X-Received: by 2002:a05:600c:3ac9:b0:3cf:cfc8:9450 with SMTP id d9-20020a05600c3ac900b003cfcfc89450mr42085437wms.99.1670099012246;
        Sat, 03 Dec 2022 12:23:32 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:31 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/41] listxattr.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:53 +0100
Message-Id: <20221203202317.252789-18-alx@kernel.org>
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
 man2/listxattr.2 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man2/listxattr.2 b/man2/listxattr.2
index 87b49ebb8..8ca1b7f58 100644
--- a/man2/listxattr.2
+++ b/man2/listxattr.2
@@ -14,11 +14,11 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/xattr.h>
 .PP
-.BI "ssize_t listxattr(const char *" path ", char *" list \
+.BI "ssize_t listxattr(const char *" path ", char *_Nullable " list \
 ", size_t " size );
-.BI "ssize_t llistxattr(const char *" path ", char *" list \
+.BI "ssize_t llistxattr(const char *" path ", char *_Nullable " list \
 ", size_t " size );
-.BI "ssize_t flistxattr(int " fd ", char *" list ", size_t " size );
+.BI "ssize_t flistxattr(int " fd ", char *_Nullable " list ", size_t " size );
 .fi
 .SH DESCRIPTION
 Extended attributes are
-- 
2.38.1

