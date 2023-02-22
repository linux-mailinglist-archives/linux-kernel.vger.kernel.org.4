Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588AA69FF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBVXVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBVXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:21:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB991ADCF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:21:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso6699891pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKgIXq4R4qwwHvnnkCCR3F6D7+hmpmuU9+roFWO8rBw=;
        b=c6NM/7LOFlLxszwmELru+zN73WjU6aGQAD/D/FEdzc9YzCEBYzZ1MfE0UkBHueHRTI
         bm7WTe2J2R8QnpqLIKXyLudD5OR28lpd945WZYxlQMxeiBshqhcgMttKdmqfjXnpb7hL
         3GvdGQ3xQeFM9bkHhLcer7dxvNbcG8X6E75FXyZNSmIWJnvp8XUkqCovBYk3nY1EFVU5
         W5yA649+th6fIuwFyWJq+aPpntXx+N7dk0tjpVLmclGHYtoC2njGRXmab2rSt+HF2nJZ
         jQOEf6ktyNx6XBT6cmEeOMTGMS5A9TCjlyNq3S5x89si29sTS1yOgrNMr6/QY9Zedrd4
         JpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKgIXq4R4qwwHvnnkCCR3F6D7+hmpmuU9+roFWO8rBw=;
        b=RNZGQfwRbY3gpYXaYBjbpC3U5T4OhlQDJqPdKztqwVkgYhhUecFvbIjmzx7X+q1vMl
         Un9g4+ByKpUKI4oOOXEo4mWedlJ3CTcT7JiaesaM5QXavXPLn9/NQoHBv6rWQUA4zc8x
         99Zai7PSSqWnT5Od9O+0PeVeD0eHm/VfOMEnE4HXfPmCh91HEgEazkQbETmn3FycOEpj
         jtHxkJgYOY//5xxTQnUxux2IKuweDUTkUEfDzs4W5vnzzN4ci4oGynsSyRPGvSEwQ9A0
         ol7MPt3grFGd3Pxc8DczxSCa446FI7uFsyzDdcH3X5taP3ga+sMg/GKw9kkqCshO+qrk
         2niA==
X-Gm-Message-State: AO0yUKWh/tEboryf2EGCNOuqrXRQjxuNVJnkTwQ34avQTbjg8THnBYeE
        XOcx0QU791/rLekMI7Vfvv0=
X-Google-Smtp-Source: AK7set+Mfk3X09eVolkIvbMyO46djaFV41w6qRa2hw54luh+oRYy3tPI8xgVWDF4PBspJAmeJEcwZA==
X-Received: by 2002:a05:6a20:698f:b0:c7:13bf:3fd1 with SMTP id t15-20020a056a20698f00b000c713bf3fd1mr11187511pzk.8.1677108064675;
        Wed, 22 Feb 2023 15:21:04 -0800 (PST)
Received: from vernon-pc.. ([49.67.183.195])
        by smtp.gmail.com with ESMTPSA id n7-20020a6543c7000000b00502ea97cbc0sm1626640pgp.40.2023.02.22.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:21:04 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] mm/slub: fix help comment of SLUB_DEBUG[_ON]
Date:   Thu, 23 Feb 2023 07:20:58 +0800
Message-Id: <20230222232058.66971-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Since commit 081248de0a02 ("kset: move /sys/slab to /sys/kernel/slab"),
the SYSFS path of slab was modified, so fix up the help comment of
SLUB_DEBUG to use the correct one.

And now the "slub_debug" parameter on boot that is support for more
fine grained debug control, so fix up help comment of SLUB_DEBUG_ON
for "no support" to "support".

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index fca699ad1fb0..732043bf56c6 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -61,8 +61,8 @@ config SLUB_DEBUG
 	help
 	  SLUB has extensive debug support features. Disabling these can
 	  result in significant savings in code size. This also disables
-	  SLUB sysfs support. /sys/slab will not exist and there will be
-	  no support for cache validation etc.
+	  SLUB sysfs support. /sys/kernel/slab will not exist and there
+	  will be no support for cache validation etc.
 
 config SLUB_DEBUG_ON
 	bool "SLUB debugging on by default"
@@ -73,10 +73,10 @@ config SLUB_DEBUG_ON
 	  Boot with debugging on by default. SLUB boots by default with
 	  the runtime debug capabilities switched off. Enabling this is
 	  equivalent to specifying the "slub_debug" parameter on boot.
-	  There is no support for more fine grained debug control like
-	  possible with slub_debug=xxx. SLUB debugging may be switched
-	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
-	  "slub_debug=-".
+	  There is support for more fine grained debug control like
+	  possible with slub_debug=xxx, details in Documentation/mm/slub.rst.
+	  SLUB debugging may be switched off in a kernel built with
+	  CONFIG_SLUB_DEBUG_ON by specifying "slub_debug=-".
 
 config PAGE_OWNER
 	bool "Track page owner"
-- 
2.34.1

