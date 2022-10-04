Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D65F4398
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiJDMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJDMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:52:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20FC12AD4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:49:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so1271067wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=V6sEgywP+y9yheTpj3XS7gZeAORICObdhjMK1hQwQH0=;
        b=UNCyNy/uQbmaf+a5bFt/wwCjNe+8ckO5I00XcarVRYdU/0+2AbaKhTqgnBp0mmc0xp
         EZX4m7hyq3k78BPT1dcXHQDdeh/RYKXPkvEYv5zG7IpXG8hDBRfcMHA24itGqpCklLAl
         8gM3E6imoX53vdSJpYNYi3If8fX+Q1EXQgZza2mSA9gE8soba2La01iK/llsVkhH/gH6
         bxzMwX5lbrh6xWkEh/g9Aw9mYxsWOVJlTyfpZ1qVcF5CF32//7fSrUvawNxbyeakyj0/
         DYZJ81RoQ7QbKct2jdy35Y2cFxOmzVvzO5IVtLCDIrPw0YIA4v2yNQTgmUP09v8VotRY
         1F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=V6sEgywP+y9yheTpj3XS7gZeAORICObdhjMK1hQwQH0=;
        b=Cqxal1BtH1U9CRzJLWuIi8aDlMLeg8HCEPA70G/1ZneJo188pQklmCUqbfLs/fXUau
         4ANUcSnfwEI0T8w66QaGa4WGfMYe1IIv6T5gYBlA+CHgyAWl0yjoxMcT2BLUn10LWby4
         Lw7g7sQDU2kxKk327eSBOnsoH3Q2weOjgNh4XMxhHgR3C1KHs3oGXyQXNPRey34NWhA5
         Dj7JhUbZC0MGCiTYtwACZwnUmVaGHgoMExan5S1uQSMevUZ5QjkvtyJLuRTjzYxujqCz
         SLPOw1bn5meF4y8E61KY9szIF2HT8YdFMeOzP4UWW/ro3DGZsNYcPtyi1wWM4RQvJB87
         bm/g==
X-Gm-Message-State: ACrzQf3hj9NUJC1dmw0cMXAXJTaVJelVyhd4fP1yIEka+vIdX8azDL7C
        hHWPyZyHkd/8msXuynEY8+eTug==
X-Google-Smtp-Source: AMsMyM6EJ42LcsBYww87M4wWF5Z5ivNc97E+YQcn9Lp3ldFUxmk6rm39W+PbkVcapyDG8JSuaZe3Cg==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr16042378wry.303.1664887755585;
        Tue, 04 Oct 2022 05:49:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d56cc000000b0022e58c14588sm353659wrw.85.2022.10.04.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:49:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com, akiyks@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v5 1/1] Documentation/process: Be more explicit about who to mail on patch submission
Date:   Tue,  4 Oct 2022 13:48:58 +0100
Message-Id: <20221004124858.640349-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004124858.640349-1-bryan.odonoghue@linaro.org>
References: <20221004124858.640349-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently when submitting a yaml change I found that I had omitted the
maintainer whose tree the change needed to go through.

The reason for that is the path in MAINTAINERS is marked as Supported not
Maintained. Reading MAINTAINERS we see quote:

           Supported:   Someone is actually paid to look after this.
           Maintained:  Someone actually looks after it.

The current submitting-patches.rst only says to mail maintainers though not
supporters. Discussing further on the list the suggestion was made to state
that the following are the right addresses to mail:

- Maintainers
- Supporters
- Reviewers
- Dedicated lists
- LKML as a fallback when there is no dedicated list

Add in a two sentences to capture that statement.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/process/submitting-patches.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be49d8f2601b4..90fda3367a405 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -227,8 +227,11 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
 to code that they maintain; look through the MAINTAINERS file and the
 source code revision history to see who those maintainers are.  The
 script scripts/get_maintainer.pl can be very useful at this step (pass paths to
-your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
-maintainer for the subsystem you are working on, Andrew Morton
+your patches as arguments to scripts/get_maintainer.pl).  In the output of
+get_maintainer.pl the recommendation is to mail every maintainer, supporter,
+reviewer and dedicated mailing list. If get_maintainer doesn't indicate a
+dedicated mailing list linux-kernel@vger.kernel.org should be included. If you
+cannot find a maintainer for the subsystem you are working on, Andrew Morton
 (akpm@linux-foundation.org) serves as a maintainer of last resort.
 
 You should also normally choose at least one mailing list to receive a copy
-- 
2.37.3

