Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0E698984
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBPAyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBPAyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:54:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7A22CFCE;
        Wed, 15 Feb 2023 16:54:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq19so715785edb.5;
        Wed, 15 Feb 2023 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Gw9QX7RE3l11rZTdHQJ4q7TrnGKJ9yItj3rNg7/Cyw=;
        b=hmtJYth4qv8Dfpo2jd+z7ds8pPh8okO2eUjGAMrBaBGyHjqY14W79EBGUldzkRZ98W
         ct8sIe6UtKRRpeOl+AzFtV0GYaz8I4DIdYGC19wkhAX/VpTEA/bYOxzoWzheghbFcDz/
         Nb7KrpwGg1lslNbOghY/TBIar5IT26XpzIVqabW5zx9AHE/o74L6h7y9QCFWL3I41FUg
         fr9UTsJbbHVv14V0SYsQ3GMzp1Cv6IDB8OyIWbgRw6re353Vh0qum/8gEmEGpDzE2HI/
         HeRbNZQqm/kb6cWQ6aaBoTKoilQTFMl2gO59TWf5JBZvUUAhXNroTR6aD6ch7kWJ2amd
         XAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Gw9QX7RE3l11rZTdHQJ4q7TrnGKJ9yItj3rNg7/Cyw=;
        b=rSD3S69HLb1KUVqzFBBdrOb6k7yfWesRgtCQ/1Cso04pmMqnPoNLQ9fPjkclFrcUIg
         scNOtbeKFPZSrTLTwKZCG8focO8uTOR0KzIkyWaEqHUaJFkPuEf6niNIN5XtgOmi3zU3
         5OHmjPgyDUGZlrrfx0O7tLGxHFUehQKhdjAe2kkmspiDe6O46QmXIGjg+g2cVoim/eHb
         umqkjcrc2YplWxQ8htaZPqba4b3g+ruenfWd+RnClVcRe1DMo+AeyMctGj+1VbzSThgp
         zY25sWOxmpFe89KCyCkMX5np4vV08MJofZ2v0aAIWVu5TUbb/cjlcabYvLfgvwiHmaem
         gzqQ==
X-Gm-Message-State: AO0yUKVsHdZGcYvqShSzGxe+JNF3OHHa25sNTgKsOGYnaS7opkPcNWC7
        ZA0NdmGf1i6ewYY4JIHbp8RGQUUTA9XIqCHY
X-Google-Smtp-Source: AK7set8x+9HjUcBC8t/4D8jsSIBwRWqVTGMwWlPjYPaaoJaen5OZmOBk2Fpwg7dU81Mn6wH+NOPloQ==
X-Received: by 2002:aa7:d9c5:0:b0:4aa:a9c7:4224 with SMTP id v5-20020aa7d9c5000000b004aaa9c74224mr4007856eds.30.1676508845188;
        Wed, 15 Feb 2023 16:54:05 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id i5-20020a50c3c5000000b004aad8d2158dsm111897edf.66.2023.02.15.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:54:04 -0800 (PST)
Date:   Thu, 16 Feb 2023 01:53:42 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [Patch] [tegra] Remove unneeded version.h includes pointed out by
 'make versioncheck'
Message-ID: <8611b610-a21b-6037-52ad-9439c4f44995@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 7264ec7d00ece4b56fe9fafa3237d4870cbe6785 Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:49:50 +0100
Subject: [PATCH 04/12] [tegra] Remove unneeded version.h includes pointed out
  by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/soc/tegra/cbb/tegra-cbb.c    | 1 -
  drivers/soc/tegra/cbb/tegra194-cbb.c | 1 -
  drivers/soc/tegra/cbb/tegra234-cbb.c | 1 -
  3 files changed, 3 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index a8566b9dd8de..bd96204a68ee 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -16,7 +16,6 @@
  #include <linux/of_address.h>
  #include <linux/interrupt.h>
  #include <linux/ioport.h>
-#include <linux/version.h>
  #include <soc/tegra/fuse.h>
  #include <soc/tegra/tegra-cbb.h>

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index d4112b683f00..a05fc2caff3b 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -23,7 +23,6 @@
  #include <linux/of_address.h>
  #include <linux/interrupt.h>
  #include <linux/ioport.h>
-#include <linux/version.h>
  #include <soc/tegra/fuse.h>
  #include <soc/tegra/tegra-cbb.h>

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index f33d094e5ea6..e23e8acfd7c7 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -24,7 +24,6 @@
  #include <linux/of_address.h>
  #include <linux/interrupt.h>
  #include <linux/ioport.h>
-#include <linux/version.h>
  #include <soc/tegra/fuse.h>
  #include <soc/tegra/tegra-cbb.h>

-- 
2.39.2

