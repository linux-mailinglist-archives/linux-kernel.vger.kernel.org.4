Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067B76A5B82
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjB1PRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjB1PRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:17:13 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F60305EC;
        Tue, 28 Feb 2023 07:16:52 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id t129so4148869iof.12;
        Tue, 28 Feb 2023 07:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qiodHOalcxGf8K4hBKSYGSAd7AoMbD2MMYCxsDBycs0=;
        b=OWxgA4KAnMBqLFrkgSwnbM6abdK6p4NVS8P0iAoJs88nRB2/6wloExy3xUCtxhQJC2
         ogd7sqhZJnz8qLVibnhDxojDKIA9z4tlkMFhUb3apNfSRyQM72qXWRNZifG76Y/Hq6IW
         3CCyD1zvTY47Edr0pw5qGh+IXiBMbhKjobsQ89xS+3+t3NF+cSLpOGPnDK5xzScvHMLb
         LLHfHgjqhkwZaDU3sSQl+vhR3oe5QHGMOss+JBOKIFeIQyV+59G6S49kLSZ+cEXQW+1+
         ubWSkD5/OG9MeFGKaFkD2AKRdb6aIG0FPQKkGA0RpD9Vwl2JBMKXuxeM2Q/yQ9c5/Ci1
         Z4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiodHOalcxGf8K4hBKSYGSAd7AoMbD2MMYCxsDBycs0=;
        b=8QyaPaMM7hCJwao7S1hLgq3/VBck351QcAjPtg2uqmINqSlF9sUTLKwT9tObLAStqv
         9fFJc91mfGJ+/qrSrfZsKIK0Kgiu6OTQriyVf5SbzO2WPq0/CKlO0fiMalbnuqRVj2it
         dhon6XFOD39YMqzZRSV1RVcMMHejRNJ8Rkq7p7tdIoseS06PsgI3uzu8LFu7tBcolhXr
         /xy72jaI2Y9moM80iMluusLoW2/0r9AFQjWvEg1N1aya6wIbnsJf/owB+b1jbPMGdvdj
         rCZuoYb2kZ7zzZxIXaJXep/aRt24Jueo9TJ/04LoMzyUXf9za3rcW9L6FsUAcnwMsUXA
         aZaQ==
X-Gm-Message-State: AO0yUKVj/sOLPxaWyFzJ3/rGwC+nPJmDk/7SUvT8BOyLOZ+PS4tP4/QB
        8CVZ5eaorvymRM7p+SOYijOTlj7+2GQ=
X-Google-Smtp-Source: AK7set+23itn809L6aK0fTFAvKGW28scVtuC9g81AHun47A8WQD4iQ6C/oyxrHZ2Fw37C8p+Se3b3A==
X-Received: by 2002:a6b:e912:0:b0:74c:c218:5007 with SMTP id u18-20020a6be912000000b0074cc2185007mr2218498iof.21.1677597411538;
        Tue, 28 Feb 2023 07:16:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d21-20020a05660225d500b00704c767ead9sm3224050iop.28.2023.02.28.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:16:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andrej Picej <andrej.picej@norik.com>
Subject: [PATCH] watchdog: imx2_wdg: Declare local symbols static
Date:   Tue, 28 Feb 2023 07:16:48 -0800
Message-Id: <20230228151648.4087637-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day complains:

drivers/watchdog/imx2_wdt.c:442:22: sparse:
	symbol 'imx_wdt' was not declared. Should it be static?
drivers/watchdog/imx2_wdt.c:446:22: sparse:
	symbol 'imx_wdt_legacy' was not declared. Should it be static?

Declare as static variables.

Fixes: e42c73f1ef0d ("watchdog: imx2_wdg: suspend watchdog in WAIT mode")
Cc: Andrej Picej <andrej.picej@norik.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/imx2_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 19ab7b3d286b..6fcc3596103c 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -439,11 +439,11 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
 			 imx2_wdt_resume);
 
-struct imx2_wdt_data imx_wdt = {
+static struct imx2_wdt_data imx_wdt = {
 	.wdw_supported = true,
 };
 
-struct imx2_wdt_data imx_wdt_legacy = {
+static struct imx2_wdt_data imx_wdt_legacy = {
 	.wdw_supported = false,
 };
 
-- 
2.39.1

