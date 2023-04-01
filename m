Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C086D33E9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDAUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDAUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:50:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A2C27025;
        Sat,  1 Apr 2023 13:50:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c18so24621905ple.11;
        Sat, 01 Apr 2023 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680382214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yhlt01rmfqv/N0e0lfCalA3RD/GpEPMqDpbr8AQ2EyU=;
        b=KevLesbwoHD4q2Tpv/ZbnpLchhu3GlfYkuT3swWN/yn0XKNNxlMYm2lqdGl62C/dvu
         p5TPAqb4vsb5t4bMZ41D/pv/WYMRKVWWLHKAJbAk0ZonXjUe/uIHvEuc9epekdHLoP0I
         Qd84br1mqI0JiIT6b7NbwbYOsNpBBf/A+VD5WJpenpIBKLo9yhcpzh+/RMssmaADvYB2
         N6fWD1vmm+LCJK9TPl+UzXBP1iyZXH3+Mswf/7HqFtMfkr1J+lOf2+kRkXpIID+miqQc
         /Zub6+5PmWNe9jmz8EXD/U5rShUGUs/ThbRCnmON6B3tkHhTTRO9WjRXF/bVbTM0ttm2
         P8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680382214;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yhlt01rmfqv/N0e0lfCalA3RD/GpEPMqDpbr8AQ2EyU=;
        b=C7Fn+p7jFr26mWeK2GBHxgkbZ8l9kmoz0+UeoRjgG1WLI8W0jfB5jaKq1Vl1Q67A9v
         Kj4TtOqfZjAS3tEH72/aKubX3iLoVKkSxNgA+Ap1MFUSsDDm8uYLrN1A5NuNGeG33Uep
         h7oK+Zt5OonQL0Bp8kQfS0QxzfM8nvM1w8M6qJ3ZvOgy5rja0PaXkyncVgkmyk44u7++
         ZuLdhxW2n1RXZo6sYnpA94VrJj4HNe67jeOBUH9xQHqeJhb/8hJnCwJ7qVmXg4rAHhvW
         X1A3CXYx0WqIhRu6ZMSmE1EdNS+4sZapkdtYl+lK95z0Um6x7ROeoGOJ67PvS6BxV8Th
         aGdg==
X-Gm-Message-State: AAQBX9fZmVGP+9f4NrvC5luY24XbE5OLa3Qa+YDXAcqQCFS+rczTognZ
        wpNSZBYwEVtLJ9C/O1kPNPGAXrTm+HU=
X-Google-Smtp-Source: AKy350Z5tDURpch0dJhpcto9cnrLq+/FUl4J7HwQbxh+OaU3s0+USyI+NLVcigwk8TrTxxCJ4VEUoA==
X-Received: by 2002:a17:903:7c3:b0:19c:b4e3:c65b with SMTP id ko3-20020a17090307c300b0019cb4e3c65bmr25790153plb.8.1680382214219;
        Sat, 01 Apr 2023 13:50:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ac04:c59e:2de:5791])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b0019a74841c9bsm3720989plk.192.2023.04.01.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 13:50:13 -0700 (PDT)
Date:   Sat, 1 Apr 2023 13:50:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.3-rc4
Message-ID: <ZCiZArzK41q5/IDR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc4

to receive updates for the input subsystem. You will get:

- fixes to ALPS and Focaltech PS/2 drivers dealing with the breakage of
  switching to -funsigned-char
- quirks to i8042 to better handle Lifebook A574/H and TUXEDO devices
- a quirk to Goodix touchscreen driver to handle Yoga Book X90F
- a fix for incorrectly merged patch to xpad game controller driver

Changelog:
---------

Hans de Goede (1):
      Input: goodix - add Lenovo Yoga Book X90F to nine_bytes_report DMI table

Jason A. Donenfeld (1):
      Input: focaltech - use explicitly signed char type

Jonathan Denose (1):
      Input: i8042 - add quirk for Fujitsu Lifebook A574/H

Matthias Benkmann (1):
      Input: xpad - fix incorrectly applied patch for MAP_PROFILE_BUTTON

Werner Sembach (1):
      Input: i8042 - add TUXEDO devices to i8042 quirk tables for partial fix

msizanoen (1):
      Input: alps - fix compatibility with -funsigned-char

Diffstat:
--------

 drivers/input/joystick/xpad.c         |  7 ++++---
 drivers/input/mouse/alps.c            | 16 ++++++++--------
 drivers/input/mouse/focaltech.c       |  8 ++++----
 drivers/input/serio/i8042-acpipnpio.h | 36 +++++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/goodix.c    | 14 +++++++++++---
 5 files changed, 63 insertions(+), 18 deletions(-)

Thanks.


-- 
Dmitry
