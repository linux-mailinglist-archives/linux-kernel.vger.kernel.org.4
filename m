Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7E5B4FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIKQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIKQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:20:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D313CDA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b16so9529953edd.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7Js629KccG6US13KeuTls+//WPiM69Qewjdm7oxTyss=;
        b=exh23MC1wmkoMevZsAfh6BeY6VdclumO4+EVDAW5TaAhleMQFIv46cC/14CfNbIoQL
         7PEEyzocz3AqrNvKZIJYYqLbDM5z5GXkb/cSWfaOjey9UkJLEvvAYLU+eUPNtYiQjL+8
         lkzPSpxYK1xXSFgI8iuI9UEX8TVE4JUU9AfIdtNppK5VyKImmw7MCzLWwlwRwcKD4pRm
         EgpITl9WhNURF7hcrNoqDeB1XYfz5lYvBoyBiwJrIBwh3bjedGWBBIVfa6o/Z/3yUbwQ
         /9IHBILTcp+57nxTEPRv9cO0FsL/s92dzLK9UKELTxE39a38L6d4ZJJ1K5jo3IEBETUf
         umdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7Js629KccG6US13KeuTls+//WPiM69Qewjdm7oxTyss=;
        b=479k2wYamiz+IwqoZFXvm83qTDnEoEPusajSAAVAvkTqV+B6B73G05cWzBrpjruB3M
         F3TE6vvCxY7YJYtv/0YM1pl36EpNIzAIqFWvNoIlYue96zRfEmSLBIzMBttSC1MyUuGC
         SjfGOr7YV6h6shJ1T5XRaFfi5rZeIM06XUPfZ9lncw7P9kiZjRbzJeevttAC/b3K20BV
         RQmYs7zBwdeTIGI8tU2Ciq3nSXZifZ5QKWL+rBQPID5NicAXsf93kjRN0dEkS0w39ezV
         JVbcsUxMKYASN0Ez75V8fbHBLW65IW9E7Kq/L2pTM9ToVYtbdsGJDWO3ApV1ebn0Pmel
         SZKA==
X-Gm-Message-State: ACgBeo0ZtZZ5EaKF4eFUSSkgJ+7MkDBik1zPYmys46hAQ9TGvoofi0kt
        66TqQfg1vCN0X0mqYGuU3RQ=
X-Google-Smtp-Source: AA6agR6ZemwosBaG90ca0b8HEp0c1KwbAyNmsaPG+GhcgveHCkzeBHVx/aLKeAMWtdIWbWSKH+UegA==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr5403672edb.102.1662913203984;
        Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id bt6-20020a170906b14600b00779dc23be62sm3055346ejb.120.2022.09.11.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:20:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: r8188eu: clean up camel case in odm_query_rxpwrpercentage()
Date:   Sun, 11 Sep 2022 18:19:48 +0200
Message-Id: <20220911161949.11293-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911161949.11293-1-straube.linux@gmail.com>
References: <20220911161949.11293-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the variable 'AntPower' in odm_query_rxpwrpercentage() to avoid
camel case.

AntPower -> antpower

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_HWConfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 8b292644b38c..a870973395f6 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -3,14 +3,14 @@
 
 #include "../include/drv_types.h"
 
-static u8 odm_query_rxpwrpercentage(s8 AntPower)
+static u8 odm_query_rxpwrpercentage(s8 antpower)
 {
-	if ((AntPower <= -100) || (AntPower >= 20))
+	if ((antpower <= -100) || (antpower >= 20))
 		return	0;
-	else if (AntPower >= 0)
+	else if (antpower >= 0)
 		return	100;
 	else
-		return 100 + AntPower;
+		return 100 + antpower;
 }
 
 static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
-- 
2.37.3

