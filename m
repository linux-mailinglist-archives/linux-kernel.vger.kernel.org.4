Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841526308C4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiKSBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKSBvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:51:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BBABF588;
        Fri, 18 Nov 2022 17:26:38 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so6441149pgh.4;
        Fri, 18 Nov 2022 17:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b13YnJSN+Dro2FOesT9TTNasbIlBrkbmQwEz7zWWNSg=;
        b=UJDfM/MjB6gKPirL+rTWVIwRJvkomxu0q7M3eFzwCMhDXKZnNJFCh9UJyjyQzTGsew
         SNY3hFPNUMEvMrhUQf73So7TC/bHvQVV1hH8q8Uytg+EWPsodWo4CVT8W3q/anAizaKa
         s1V8tI3hy1vRN9JJQM9modnDZ5Nf7Oej49G9bhN1Fcdvci9Hl23N8tttJuBP29XN/FIG
         QYvKQWNyusE40UjEVh4ZuMjdjVKoirQi4EXr91KwSKopUCrbt0DadnLf3xkEYivUrFkO
         dtfjRH0UAzi+7clf0LMvXg5TTTVTRiPRek16bBgzze2GZ/BkJo+SiwVe/L3MtZw7poWw
         aEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b13YnJSN+Dro2FOesT9TTNasbIlBrkbmQwEz7zWWNSg=;
        b=AP15r5O6Xq/mP1IEpYzsO7CMNB7KL7+UF+c7qYUAJTW9o3Tuh2ImZcAeb/9NkKaNxQ
         nqcfm3O0sIJkzWFPU4uxZ8z/4Op+iiVHUr0YOxPuTDd+rpULz+2ZIAjDcsO7uKQ1vLaK
         X4MQS2RGfhKr2m3UCo5W3vnzDT2inxNE7tOewksPvvNJXsfmJKOLVYoC5vuxqfz1JIoh
         TFTAe18/0/y1g02wLEBTsx4mvxeB+N+U3btRgSRbDpmB1wWCAwEESHJkiyl8NjW0SFfl
         GVpVojuxufpAwdmhnr4iNLhDOQqB7FOp3pREoqjxCerTj5LlUNqhdZcblvxdybc50ir1
         w8iQ==
X-Gm-Message-State: ANoB5pnDHx7MUC+JTyoL+EFk+0mr15adEk7NTTZ+zWtm9E03pg1tU38j
        tikBrwAkSq4IUp88a30+K5XcHfUS40U=
X-Google-Smtp-Source: AA0mqf5CO2z6QTJdSBKwQNlvXhefGikS98CFDAqX9AzWHh7QA4reJFqNablT7JpxWsxczEvVSr/Wtg==
X-Received: by 2002:a63:64b:0:b0:43c:2e57:9636 with SMTP id 72-20020a63064b000000b0043c2e579636mr8933800pgg.81.1668821197595;
        Fri, 18 Nov 2022 17:26:37 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6aac:8482:2371:80a3])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001745662d568sm4288018plk.278.2022.11.18.17.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 17:26:36 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:26:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.1-rc5
Message-ID: <Y3gwySzRvhCwdSgW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc5

to receive updates for the input subsystem. You will get:

- a fix for 8042 to stop leaking platform device on unload
- a fix for Goodix touchscreens on devices like Nanote UMPC-01 where we
  need to reset controller to load config from firmware
- a workaround for Acer Switch to avoid interrupt storm from home and
  power buttons
- a workaround for more ASUS ZenBook models to detect keyboard cnotroller
- a fix for iforce driver to properly handle communication errors
- touchpad on HP Laptop 15-da3001TU switched to RMI mode

Changelog:
---------

Aman Dhoot (1):
      Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode

Chen Jun (1):
      Input: i8042 - fix leaking of platform device on module removal

Hans de Goede (3):
      Input: goodix - try resetting the controller when no config is set
      Input: soc_button_array - add use_low_level_irq module parameter
      Input: soc_button_array - add Acer Switch V 10 to dmi_use_low_level_irq[]

Sheng-Liang Pan (1):
      dt-bindings: input: touchscreen: Add compatible for Goodix GT7986U chip

Takashi Iwai (1):
      Input: i8042 - apply probe defer to more ASUS ZenBook models

Tetsuo Handa (1):
      Input: iforce - invert valid length check when fetching device IDs

Diffstat:
--------

 .../devicetree/bindings/input/goodix,gt7375p.yaml          |  5 ++++-
 drivers/input/joystick/iforce/iforce-main.c                |  8 ++++----
 drivers/input/misc/soc_button_array.c                      | 14 +++++++++++++-
 drivers/input/mouse/synaptics.c                            |  1 +
 drivers/input/serio/i8042-acpipnpio.h                      |  8 ++++----
 drivers/input/serio/i8042.c                                |  4 ----
 drivers/input/touchscreen/goodix.c                         | 11 +++++++++++
 7 files changed, 37 insertions(+), 14 deletions(-)

Thanks.


-- 
Dmitry
