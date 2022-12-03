Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6046418D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLCUYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiLCUYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F7B1C920;
        Sat,  3 Dec 2022 12:23:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso6564152wmb.0;
        Sat, 03 Dec 2022 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzXqzWobh0OjpISysLes5y3o4sF2aHQfURbmeNAp/Yc=;
        b=JqABa9qABVqFLNY+rVML9DzdWudVVsIngMsURZcp7aV5iAmdbMA4M3jBMg9RygD+fp
         3gta+hpOdARcaPclOVp8KJEKDq1u7p6ReTOKIMpYTfpIq5TlbPmr10YTy1t0g89Nuybk
         hFf6IUISabe1KdJds+0ZqQuQIcExOLVgvA/8Bw61cOOVolkfvB6+mt0N/Dfh2LAuGL5U
         FT5hjjWr9U/gDG/S2AXsZMub4phy3hOHu5zqJmtQ5ydAYqbLqQxSdinN6GjZluw8dOXt
         J0R64sVLj578TpmuY+hYbXUZE/duI5oWApIzTP2b5BSOOZ0DuK5oboyxMIYwGFeG+ZX+
         YK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzXqzWobh0OjpISysLes5y3o4sF2aHQfURbmeNAp/Yc=;
        b=WuyUDW0k8eTDOU+JWL9BPSuVg1Je4dXFrqWT19kXVKI6Q1XZ7luP10M515PaFph6Yt
         CwjVwXHxa6boH1RvzN8yy+huA4UGwwt3ohgVl+RkfQKctZa25Ixv19m8YCqbH2g8gN9S
         ZeDUGU5Mm6EbTeUAnLDXALBhJRtpWa+bLECOzm1n/qR5fUhuiP5MrgPnCw0Yq6ba5Qis
         MypD+SfBTpmjaGKcp4ZQcUAVKhY4JkKKhYqvc+7TiDCSyrnAJHyNuUMb0I89j/yicymx
         zQsUwoWLDJI9w7Imv4YPmGYr1Ijv6usqguOdFqFi4aGoNBV7CzhCEDptYoMmLPiL6A2c
         EprA==
X-Gm-Message-State: ANoB5pkp5qY9rZM0E86O4yTfmMvDO8csaCsDyvMNssbRvIDlsy5GcCHr
        8Ci6QbRvycIVsGxiZbznFXBVzfj4Ops=
X-Google-Smtp-Source: AA0mqf4x6uSPhkrg0A1ccP1zzUVtdHWrmscWrJspnReXGnSk5YP6hwAaTO+ZvfmH443DAjlmtpjk/A==
X-Received: by 2002:a05:600c:3ba8:b0:3cf:59c9:4a4e with SMTP id n40-20020a05600c3ba800b003cf59c94a4emr44486706wms.17.1670099013071;
        Sat, 03 Dec 2022 12:23:33 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:32 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/41] mount.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:54 +0100
Message-Id: <20221203202317.252789-19-alx@kernel.org>
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
 man2/mount.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/mount.2 b/man2/mount.2
index 1ef0cdd06..9e89c16ef 100644
--- a/man2/mount.2
+++ b/man2/mount.2
@@ -29,7 +29,7 @@ .SH SYNOPSIS
 .PP
 .BI "int mount(const char *" source ", const char *" target ,
 .BI "          const char *" filesystemtype ", unsigned long " mountflags ,
-.BI "          const void *" data );
+.BI "          const void *_Nullable " data );
 .fi
 .SH DESCRIPTION
 .BR mount ()
-- 
2.38.1

