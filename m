Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53616410A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiLBWdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiLBWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82504B2751;
        Fri,  2 Dec 2022 14:33:38 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so8324337edn.0;
        Fri, 02 Dec 2022 14:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LthvsFA3uIpPeqEsqymC8dZfIMWYhUwLsZlEoJ0BTkk=;
        b=n/Vghe9upjOsF6LwurV4lq9TyyVrgieFNfscFY6ux1kxDlV1lifno0WwUA3W3j/yMm
         sFWJfJszC41AiIKxMz7bxl4cqWgaQ4ofFrGrlJv6PJZFdAMe7sAdj7MtA37iA4iaJ3Z6
         tH9iRcJ/nTi2doR1GSVmy01Jz7L4klm/31dlBMDLGfg1dV+bUQIQTVreJ3qzHZB3SkXX
         6KWB5XmeJjBBZnesGCO4z3E/NyMhL1wNrwxqZOq1NerLqwJ1bV4m6VKka6JYCEYCPkWJ
         UT2sJ1Gd79zilIhgM74LmP1CQCplxfpkL2YhmLux6FpwEnpl1oeJGvRvp8bzQc7ZjX4d
         8paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LthvsFA3uIpPeqEsqymC8dZfIMWYhUwLsZlEoJ0BTkk=;
        b=7Vy28ooBDN1CPXaKpFj7SOt/iCrQWjifqdVZbCo4gtR0gMZytUN1bzQoj2HeFj0tFf
         ARp4dCWsv4DLl+3JfG0ANZL82YKWzy18g+C9jgoU12eeUub89vmunZOHUxnxQArJYAmw
         6u73qLmIN+NccFbaEm5ZfkOp6fJdvNva7azRH/+Myl03J847PRXPyz5qYp+JYex0KBAe
         0UczCY9rsiSnWK+3muJQ+EKiD+lo4EaFHMB09jTOnZUzw4JYw1hE0TJQXLBNBlE1wlL2
         JVZQa+KQuX75jJ9Fw/kQI2e32Xkrxw0ZqMZgYYWjvPcdq1z4JPzoBD4sIQOd6KhDKEKz
         xXvA==
X-Gm-Message-State: ANoB5pk9bdcQbfcjziHAfr9mE5AaaX/xKga+/WxSQyM7nbRC9d+Ox8oX
        XcQsLE3xgOcRcecaHUj8jGE=
X-Google-Smtp-Source: AA0mqf6HUUrFzheW72d2FhqqR2nNUAOq0Ke5eowpfK/U+FuBAgma/Ew9i2DQWNPXGwHu2bCxys45zQ==
X-Received: by 2002:a05:6402:104b:b0:461:7d1f:1a7b with SMTP id e11-20020a056402104b00b004617d1f1a7bmr47054751edu.400.1670020416848;
        Fri, 02 Dec 2022 14:33:36 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:36 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] platform/surface: aggregator: Improve target/source handling in SSH messages
Date:   Fri,  2 Dec 2022 23:33:18 +0100
Message-Id: <20221202223327.690880-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
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

We have some new insights into the Serial Hub protocol, obtained through
reverse engineering. In particular, regarding the command structure. The
input/output target IDs actually represent source and target IDs of
(what looks like) physical entities (specifically: host, SAM EC, KIP EC,
debug connector, and SurfLink connector).

This series aims to improve handling of messages with regards to those
new findings and, mainly, improve clarity of the documentation and usage
around those fields.

See the discussion in

    https://github.com/linux-surface/surface-aggregator-module/issues/64

for more details.

There are a couple of standouts:

- Patch 1 ensures that we only handle commands actually intended for us.
  It's possible that we receive messages not intended for us when we
  enable debugging. I've kept it intentionally minimal to simplify
  backporting. The rest of the series patch 9 focuses more on clarity
  and documentation, which is probably too much to backport.

- Patch 8 touches on multiple subsystems. The intention is to enforce
  proper usage and documentation of target IDs in the SSAM_SDEV() /
  SSAM_VDEV() macros. As it directly touches those macros I
  unfortunately can't split it up by subsystem.

- Patch 9 is a loosely connected cleanup for consistency.

Hans, Jiri, Benjamin, Sebastian: While patch 8 ("platform/surface:
aggregator: Enforce use of target-ID enum in device ID macros") touches
multiple subsystems, it should be possible to take the whole series
through the pdx86 tree. The changes in other subsystems are fairly
limited.


Maximilian Luz (9):
  platform/surface: aggregator: Ignore command messages not intended for
    us
  platform/surface: aggregator: Improve documentation and handling of
    message target and source IDs
  platform/surface: aggregator: Add target and source IDs to command
    trace events
  platform/surface: aggregator_hub: Use target-ID enum instead of
    hard-coding values
  platform/surface: aggregator_tabletsw: Use target-ID enum instead of
    hard-coding values
  platform/surface: dtx: Use target-ID enum instead of hard-coding
    values
  HID: surface-hid: Use target-ID enum instead of hard-coding values
  platform/surface: aggregator: Enforce use of target-ID enum in device
    ID macros
  platform/surface: aggregator_registry: Fix target-ID of base-hub

 .../driver-api/surface_aggregator/client.rst  |  4 +-
 .../driver-api/surface_aggregator/ssh.rst     | 36 ++++-----
 drivers/hid/surface-hid/surface_hid.c         |  2 +-
 drivers/hid/surface-hid/surface_kbd.c         |  2 +-
 .../platform/surface/aggregator/controller.c  | 12 +--
 .../platform/surface/aggregator/ssh_msgb.h    |  4 +-
 .../surface/aggregator/ssh_request_layer.c    | 15 ++++
 drivers/platform/surface/aggregator/trace.h   | 73 +++++++++++++++++--
 .../platform/surface/surface_aggregator_hub.c |  8 +-
 .../surface/surface_aggregator_registry.c     |  2 +-
 .../surface/surface_aggregator_tabletsw.c     | 10 +--
 drivers/platform/surface/surface_dtx.c        | 20 ++---
 .../surface/surface_platform_profile.c        |  2 +-
 drivers/power/supply/surface_battery.c        |  4 +-
 drivers/power/supply/surface_charger.c        |  2 +-
 include/linux/surface_aggregator/controller.h |  4 +-
 include/linux/surface_aggregator/device.h     | 50 ++++++-------
 include/linux/surface_aggregator/serial_hub.h | 40 ++++++----
 18 files changed, 191 insertions(+), 99 deletions(-)

-- 
2.38.1

