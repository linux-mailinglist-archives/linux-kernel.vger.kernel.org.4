Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453565F584
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjAEVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjAEVJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:09:45 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C7392C2;
        Thu,  5 Jan 2023 13:09:44 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id ud5so93007423ejc.4;
        Thu, 05 Jan 2023 13:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJeXqQs7pj8w9JbxIzmfQWQdjE54Pr1mrK4c4Lz7kh4=;
        b=oHuELAuEWsRajUGegTNXAIdECVziRvWE8z+Mnnu6U6AjmIHn2oP/Tlntvfk7Vy59Iv
         t091tESDhegLNSFFp0cTJL9h+VB2btlPM3tZZCAE1pq1rwJi7reGJNJ8ozNqaqu2Fq6W
         KPYk/ytNKXk4LGi0F4hC4Q5LWD96uk4vHmCIvFBpWaPq8KUuNrBZN/isnkWOSn6PRcEU
         fuoPYk1RItyy09L+M5uL3UpAoAaiVUiJoQJe1T3HWNvD0w1JH0REnqGyZJtluY/Jsw3e
         83yOVsXUtSwaK4BJgdv6LwEDOgx6B62xxTHDj3AIZuDuVl69iMNKoZZ4T27JmlMebm01
         Pujw==
X-Gm-Message-State: AFqh2kqt0EF/4qag7kr8cEpllgj6dKDYQ455UkXrlBGgQp8HbOmUqQ1S
        Hnl6F4vzBrPIvNH9Nx87erVG4n25oQmxPEtekXI=
X-Google-Smtp-Source: AMrXdXs7pAC6LKgr3R8qrSr8LCt2e7fTAuaQw6P2jZE9QBvRm2HWoqyNT0l2zq1RemgFK2jTL97QKE6aq2xjVEbmONI=
X-Received: by 2002:a17:906:50c:b0:836:9bcf:1702 with SMTP id
 j12-20020a170906050c00b008369bcf1702mr6724440eja.509.1672952982522; Thu, 05
 Jan 2023 13:09:42 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jan 2023 22:09:31 +0100
Message-ID: <CAJZ5v0iXQzV-rbAAAOSALTCiT1nX6e-F3BarTSG7kZ32z9HL2g@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.2-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.2-rc3

with top-most commit b878d3ba9bb41cddb73ba4b56e5552f0a638daca

 thermal: int340x: Add missing attribute for data rate base

on top of commit 1b929c02afd37871d5afb9d498426f83432e71c2

 Linux 6.2-rc1

to receive a thermal control fix for 6.2-rc3.

This adds a missing sysfs attribute to the int340x thermal control
driver (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: int340x: Add missing attribute for data rate base

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c | 4 ++++
 1 file changed, 4 insertions(+)
