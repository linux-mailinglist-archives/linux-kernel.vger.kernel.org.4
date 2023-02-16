Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B4698971
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBPAq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBPAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:46:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FA40C3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:46:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d40so677271eda.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 16:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuxSle/7VvyyEfqb3L8hKgbEW79fzi/M20PQmmhhCGI=;
        b=BczsKBMIsMXi+vcypGU+kFU34+YcUgAav5jjaYwXx+TYEtH7pqgM6jcvxJlSR9OehH
         eMLAinNikuUFoM+n5Mcyh2jY1+gO3UF3rsv2zA4qZmmPKnKPdSkRzFTAKfahGkfqjHbk
         GjcXAVQe9KDvS56Mz7yF0CqSzh2nj2HKy9HhML1qlVfiMjGuzo9hNCrjvACTFt2KicOL
         qQSESD8QfFoovHxtS7jUpGczBhpiIMUAXnTQ1BK6OpvBa55owheH0ima1Ad2LrLbSAYc
         hzkAGxIKboE/wKbV4QvCKIPkAkSD7CPSlQFWAQuXXlRgZeaqWPKcZ/Ob8KrEy2z8CxIe
         JZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuxSle/7VvyyEfqb3L8hKgbEW79fzi/M20PQmmhhCGI=;
        b=eS9hsUt6YfCjCivKDZ4Btt5pVo9uSBDq2ZnI6UbfntQ/zJzp4hgMdCZC7ErUy1EtaL
         BSilQu3oYBLV+N7jLmDG4HpybEnNqs1TRBFnTs9vXhi/QWupEOpWf1PzxZ+HULd+Ambj
         +YeWj2qNAmUb8eomQoFfa9iH0lKTZSfMjZiTEExbWgTeK2WdeCjKtLVkF4yE5VVqqN8R
         jZUk/sUPNJsG3YcF+sjPz9YGaAYCKmmG5bsJM0jzEqQBFyMT8IVpjER+Zk8OQIzmHaW5
         qLAacemy4G8IvNIAdmtxav5hoiM5EsmLar4ZpXNvx1iLLSPHMbcKXLjzfH8zKpty+mHr
         ra/Q==
X-Gm-Message-State: AO0yUKWZLBWacDUbpeiLMPFdXJArpDaZ9jKXjQk/2qJA3mu4SoGdmrrS
        dLZYsD503IMIvwCZfHJ7uI+CMmPFRlls8g==
X-Google-Smtp-Source: AK7set/ZvRzMA0RVZ0aGLObzJGvgbUbY8uFJaTY484R7V8/RtvEDwGlXhatBMFhbvZdwtb898I22WQ==
X-Received: by 2002:a05:6402:e94:b0:4aa:dedd:41e0 with SMTP id h20-20020a0564020e9400b004aadedd41e0mr510729eda.8.1676508414823;
        Wed, 15 Feb 2023 16:46:54 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id r15-20020a50aacf000000b004acbe846b8fsm119459edc.34.2023.02.15.16.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 16:46:54 -0800 (PST)
Date:   Thu, 16 Feb 2023 01:46:30 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org
Subject: [Patch] [drivers/accessibility] Remove unneeded version.h
Message-ID: <ce52283d-7fbe-cb9e-de8d-069fcb0af916@gmail.com>
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

From bf38cc9d1c32d3debdc846d30ae6a0523c5a64d3 Mon Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:44:01 +0100
Subject: [PATCH 01/12] [drivers/accessibility] Remove unneeded version.h
  includes found by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  drivers/accessibility/speakup/genmap.c      | 1 -
  drivers/accessibility/speakup/makemapdata.c | 1 -
  2 files changed, 2 deletions(-)

diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
index 0125000e00d9..0882bab10fb8 100644
--- a/drivers/accessibility/speakup/genmap.c
+++ b/drivers/accessibility/speakup/genmap.c
@@ -10,7 +10,6 @@
  #include <stdio.h>
  #include <libgen.h>
  #include <string.h>
-#include <linux/version.h>
  #include <ctype.h>
  #include "utils.h"

diff --git a/drivers/accessibility/speakup/makemapdata.c b/drivers/accessibility/speakup/makemapdata.c
index d7d41bb9b05f..55e4ef8a93dc 100644
--- a/drivers/accessibility/speakup/makemapdata.c
+++ b/drivers/accessibility/speakup/makemapdata.c
@@ -10,7 +10,6 @@
  #include <stdio.h>
  #include <libgen.h>
  #include <string.h>
-#include <linux/version.h>
  #include <ctype.h>
  #include "utils.h"

-- 
2.39.2

