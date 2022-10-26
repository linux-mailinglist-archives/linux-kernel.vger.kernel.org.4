Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7360E829
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiJZTDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiJZTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:02:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873C107CEC;
        Wed, 26 Oct 2022 12:01:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a67so43123821edf.12;
        Wed, 26 Oct 2022 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVp9n/kVER+VHvkwBhBhQyKmLv1czPmLLZnhVZn4h0I=;
        b=jdQ6bWUp4ihIWn2iY8KJ5prz7qe0slVPLJmvONt/mg44/xJl25jLht/uzJ32nhMJd1
         0YIpx+E5JbTOvMSuly03TMyuKZRLDfRErR2838Q57vaneEYJh2H3nV2mofc40KRQf/a4
         VdeiCkNwEoU/5ni2Xc64+YyIUUxqazOdZhxUZK3i7r2HMICDW3WkWJHK4ZpnZGOqXJfG
         6c3rrzPNYxjwLSHKBzTxhbPh7J/fMsv9Z/YTMlGzwh+cjdgpq675eYq/zUP4tgyoEeS7
         Cs+aNgjploAjbcod/brMVnxoFdIvpzM2xxbyqc+TE46ALmD58Izzkdd79PFQ9NxY7R9v
         SjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVp9n/kVER+VHvkwBhBhQyKmLv1czPmLLZnhVZn4h0I=;
        b=L4ES4ce5ii3bVV20BjzzyhBVs0LbaUekIfhqSIE53fZZvmyqi3Tfkejj3bOleXuEYt
         kTaOGcFounVaIHzgrlwCoa6jXygd5GkWpEUKhNaFy1cjltM5k9o0p1LVQjj+dZXb6AmX
         UqcAg6K5mfantPARW5mamZnlVA1wYrdFyRZwG0ZdIDPp/1GQxhtUyufENlZy4CJ4sXg2
         zoo+UYQ5SwiZ25Dy561Ud/mRtTfNUAAus6uZL9j/s2MC/pnSqR1krVF2/7CYe+udYqLO
         OW9R4rWzbjKKLamYCmlPVt1TSy9drJZZPoSr/lxEU33iusRoklHGr1qJL+ruQZpo523c
         0qrA==
X-Gm-Message-State: ACrzQf27Zl4Xq7f9zb7i7XVFqHuJEmI0sl09UmaGZSmSbRfyGJcW9kLn
        Fn8uenpoONSP4BG1CDfhsBskV734ROvo0A==
X-Google-Smtp-Source: AMsMyM55kmHvDms5/QjkRR4qr7fMryms40WqN7L1WYcBTxSRQ16lW3j1dns6IlaHk8mUUQQGGR1sLg==
X-Received: by 2002:a05:6402:280a:b0:461:9845:d9c9 with SMTP id h10-20020a056402280a00b004619845d9c9mr20967169ede.268.1666810868749;
        Wed, 26 Oct 2022 12:01:08 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id r18-20020a1709063d7200b0076ff600bf2csm3342945ejf.63.2022.10.26.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:01:08 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH 0/6] Add camera access keys, IdeaPad driver improvements
Date:   Wed, 26 Oct 2022 22:01:00 +0300
Message-Id: <20221026190106.28441-1-erayorcunus@gmail.com>
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

Eray Orçunus (6):
  Revert "platform/x86: ideapad-laptop: check for touchpad support in
    _CFG"
  HID: add mapping for camera access keys
  platform/x86: ideapad-laptop: Report KEY_CAMERA_ACCESS_TOGGLE instead
    of KEY_CAMERA
  platform/x86: ideapad-laptop: Add new _CFG bit numbers for future use
  platform/x86: ideapad-laptop: Expose camera_power only if supported
  platform/x86: ideapad-laptop: Keyboard backlight support for more
    IdeaPads

 drivers/hid/hid-debug.c                |   3 +
 drivers/hid/hid-input.c                |   3 +
 drivers/platform/x86/ideapad-laptop.c  | 163 ++++++++++++++++++++++---
 include/uapi/linux/input-event-codes.h |   3 +
 4 files changed, 157 insertions(+), 15 deletions(-)


base-commit: d9db04c1dec6189413701c52b9498a7a56c96445
-- 
2.34.1

