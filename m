Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5D6122AB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ2MEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2MEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B87748E0;
        Sat, 29 Oct 2022 05:04:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so9719985wrb.4;
        Sat, 29 Oct 2022 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ym++Yr1RANQjZT5Dn6yHeaV4FACrpo9YTFn69L+Enh8=;
        b=QXMOjfGhEpdMNZo0kR9PJngxq2Pmha+ffBPgIGkJVREcHLGf6RXkIv9+qMvi3NluLB
         XHhFTwZa/pY7CNAZPqxy80FGf9t8KMRddVAy/1suRdzyKNcisz3IFqsSb7fDNMO7dveQ
         pqDNU5ljR0eMm/0ovmyyf11rmY/uZBHQqhGVT4ISi2kyXMMKcihpcAwu+LrigktoSJcu
         WhH1pzjuBaR6Lk5wNy4Uu7ORcqJdcAFgBAo4u8nYKJexzH0xnbJcjagXz7HZAYtyaAEY
         /aGYGZvJ+Q14+V6GqHEUfPkyBv9QmyvRLL5p1CKPydIy9Zjd6qzBRxIB9DaNUEE7EeoQ
         A2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym++Yr1RANQjZT5Dn6yHeaV4FACrpo9YTFn69L+Enh8=;
        b=lso361JemLgQXZjJ2VdRRR1gS95P4c8jW/JDk2ls3WOW7c//souirqo6k/lUD/+1EC
         RLaVzlF0i2A0A/uP0fc7AHui/S9x1KLjzrQt76HCDhErosa9maov4PsvEdJrHyXTE+vL
         cBR3xhL69fC59BUJrDdweMgS6j0JS0EBA+/DxWSoxm4VZr0MAl1tCY+nJec1osgNCluR
         OQcYZdIltNEinNOiQajkHQdI/qRZPsE76uIwRSzlxU3F5fP+3qCQZQecJlt2jJffzffW
         Uzv8Vpukvj9aSLQnylKtxVRgIsEKjFQ7VOaKqLLvzQtAgYmIVGODsgo+R5K4uZxQgzxr
         nztw==
X-Gm-Message-State: ACrzQf3+zJfvwcWNil0OFvLfOsxZOYKnBm0z26o+1u2OqGqDZtnrPthR
        nevB8RVJUk7lZ0hOE9Tx9LNucRPwevhS+A==
X-Google-Smtp-Source: AMsMyM6XEDab62Li5uM4KcE5jmlz5PKL9YIfwI//k97j+QSA8z1j9k0hqmK5ajxYKaj2p5lKSNfJqA==
X-Received: by 2002:adf:dc4a:0:b0:236:5ba2:df2b with SMTP id m10-20020adfdc4a000000b002365ba2df2bmr2224530wrj.260.1667045057287;
        Sat, 29 Oct 2022 05:04:17 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:16 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 0/7] Add camera access keys, IdeaPad driver improvements
Date:   Sat, 29 Oct 2022 15:03:05 +0300
Message-Id: <20221029120311.11152-1-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Nowadays many laptops have camera access keys, yet there is no usage codes
mapped to them, even though it's introduced in HUTRR72. Start point of
this patch series was adding it and making IdeaPads send it to userspace.
But later I discovered that camera_power attribute of ideapad-laptop
driver on my IdeaPad 520-15IKB doesn't work, so I can't toggle it with
that. I managed to find a way to check whether an IdeaPad supports
camera_power attribute (which sends VPCCMD_W_CAMERA to EC), don't expose
it to sysfs so userspace will know that it can't toggle camera access via
camera_power, in my case, after receiving KEY_CAMERA_ACCESS_TOGGLE.

Along the way I discovered that old IdeaPads, like S10-3, may not be able
to toggle their touchpad as a regression of a commit aimed for newer
IdeaPads, so I reverted it.

Also I noticed that I can get/set the state of my keyboard light,
so one of the patches also adds supports for this kind of keyboard lights,
which I call "partially supported keyboard lights". I expect that commit
to add keyboard light support for 520-15IKB, 330-17ICH, 5 (15) and more.
Currently only tested on 520-15IKB.
---
Changes in v2:
  - Added Dmitry Torokhov's Acked-By to patch 2
  - Applied Barnabás Pőcze's recommendations to patch 5:
    - strncmp -> strstarts
    - static global "CAM" string -> inlined "CAM" string
    - move new variables to the scope they're used, and order them
  - Added patch 7, which removes "touchpad" attr for SYNA2B33

Eray Orçunus (7):
  Revert "platform/x86: ideapad-laptop: check for touchpad support in
    _CFG"
  HID: add mapping for camera access keys
  platform/x86: ideapad-laptop: Report KEY_CAMERA_ACCESS_TOGGLE instead
    of KEY_CAMERA
  platform/x86: ideapad-laptop: Add new _CFG bit numbers for future use
  platform/x86: ideapad-laptop: Expose camera_power only if supported
  platform/x86: ideapad-laptop: Keyboard backlight support for more
    IdeaPads
  platform/x86: ideapad-laptop: Don't expose touchpad attr on IdeaPads
    with SYNA2B33

 drivers/hid/hid-debug.c                |   3 +
 drivers/hid/hid-input.c                |   3 +
 drivers/platform/x86/ideapad-laptop.c  | 170 ++++++++++++++++++++++---
 include/uapi/linux/input-event-codes.h |   3 +
 4 files changed, 162 insertions(+), 17 deletions(-)


base-commit: d9db04c1dec6189413701c52b9498a7a56c96445
-- 
2.34.1

