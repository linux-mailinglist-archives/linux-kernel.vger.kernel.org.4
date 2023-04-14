Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC986E24E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDNN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:58:02 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74FBB;
        Fri, 14 Apr 2023 06:58:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id jg21so45431053ejc.2;
        Fri, 14 Apr 2023 06:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480680; x=1684072680;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9McAPUtQ4wyOQZnb9f0/u2YiMiGyJU422JGspd0jX2g=;
        b=Cbr+ANfGYbbt/NvfhpY3db1rtk6MSxCea3gelp15ajOO/EhRSxPFuOSe2SVDPXoqAO
         lTEqye+v9/JTnQZoULVYuFCkpijjwWgOmXPSeZ65KYaOn9wmBtyIf2643uX6fHn8cVjs
         PF3m0gUmi7+XneBQJg9apq+uFldD0F5/taadxhDPq4xj7B9Yuee6ZLqOBgBYd4ZHkatu
         xFuUv18e5dWzk90fAwviZNH1AoHxNG0WOXaRDfViIdV/hiEdjnnnMMrNz1+nWXHX59BS
         dCzzkSh41v4WZ8hx0SiS9d0ckx6BeuR4gDRUhSbWbDRCveFTlcACDc1Os8LsOgHKibQp
         QlBg==
X-Gm-Message-State: AAQBX9cNNiuhyJdoz8KhOz7Urk5RUmkSxcnTs9YaGwQ5zfDzISm87+ON
        W68VHKywvebdyyjG3jNJm6HAzdU3R+CGpwVHr9zXfgAP93o=
X-Google-Smtp-Source: AKy350YtTO8PZixXKyq5XWALpgvl39l9Ru9+tNzYLKqbDk9wIw77y2O7ap4obkS529kQpjEnICT/W3GBDdr9y13wMnA=
X-Received: by 2002:a17:906:37d3:b0:94e:fd2c:f829 with SMTP id
 o19-20020a17090637d300b0094efd2cf829mr358715ejc.2.1681480680130; Fri, 14 Apr
 2023 06:58:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Apr 2023 15:57:49 +0200
Message-ID: <CAJZ5v0jVJ+7XLZtv6YE0O0PUB9OSzf7c2qN=eESVHUCni8xjrQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.3-rc7

with top-most commit 4654e9f9f43993eb9ce383fa7c88d14b052b8cc3

 amd-pstate: Fix amd_pstate mode switch

on top of commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

 Linux 6.3-rc6

to receive a power management fix for 6.3-rc7.

Make the amd-pstate cpufreq driver take all of the possible combinations
of the "old" and "new" status values correctly while changing the
operation mode via sysfs (Wyes Karny).

Thanks!


---------------

Wyes Karny (1):
      amd-pstate: Fix amd_pstate mode switch

---------------

 drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)
