Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFE69A909
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBQKYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:24:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D0627EE;
        Fri, 17 Feb 2023 02:24:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j6so1027319plh.1;
        Fri, 17 Feb 2023 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJsG7O5tTCs41MEzjTy+yVNOTt2BE6FSiradkkgB6LY=;
        b=qRe/SGrZbP7S0qB9hiMc5M1htwbpekmT/G5x9ZA0EQu3n9VLPMX+5QJItPSWqtrBRX
         rCm0ewMrretrkegnrYkYrIHzvRsNN0CPNgcQ9uCKORPISWhwlhJAaTq1xioliLffKeJy
         0Cd/Gpq18fvdCsqtB9ZTsjxj5VWMdnYWV9VTBmrhWKDYdtzJAuVZcE0P9RsqoPIx02oS
         Pz8BeK7GBmmDWSQZSpkusQWRH1v0s+RAKzcrHM+HHHzu7V+eutlJBCDw7f1SDruqNtTU
         3Xz2eDC+V3UVd16CcUfpCNbOGQP74SQ6t4SFJylmcON6nnhR04ebKh/8nz2oB8x78ihO
         UO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJsG7O5tTCs41MEzjTy+yVNOTt2BE6FSiradkkgB6LY=;
        b=T14qo4+uKxG+YQeakYAJ2R+i6b+1Q0gp1wcL9PCRv1A3La+9DbYSqRjA2B5GIxxIDd
         Phn1C3MCyhnsUS20UuJw5lJ4zRVDYz/ud1nOkHN4W03R5LmDZgIP3WEggcqiB0TIKZ17
         yzlftdFAgpgJaAP+J7iuGxDbqHtRSM69PfmR3KviXamIOYETDCQyB+ggcrp40VZ3+tIh
         A+2j+U5kloh4PKge5tjUXhnA/Y/ZfQvN9y4nq+yGOnYoKlIm1uomxUt/SAcC+WiNkvuy
         MvX054d2AufOvY7/qiGEUAx1dUjTL82uKY3DJauU2LgA7+q05DjHRmQwOLQTxJTdOwq6
         xPRQ==
X-Gm-Message-State: AO0yUKWFlreUko8X067svxqAqKcLlSp85yPE8B/dKan4aGGADnWIOi0k
        G14V0Pmshn2yM7UI2sN81rOsyor+xHDECA==
X-Google-Smtp-Source: AK7set9vt5v4O8ePLcY+Cudv/NZc+8bmvEwJ6/BoQFq+EY+rOWj8nx1HEZHd92QgK/VGJWVdYgQzQg==
X-Received: by 2002:a17:903:110e:b0:199:3683:5410 with SMTP id n14-20020a170903110e00b0019936835410mr422558plh.50.1676629442237;
        Fri, 17 Feb 2023 02:24:02 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019aaba5c90bsm2832538plp.84.2023.02.17.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:24:01 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     linux-doc@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v3 0/2] Apple Magic Keyboard Backlight
Date:   Fri, 17 Feb 2023 21:23:18 +1100
Message-Id: <20230217102319.3419-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This patchseries adds support for the internal keyboard backlight of
Macs with Apple's "Magic" keyboard (MacBookPro16,* and MacBookAir9,1),
and also documents what names should be used for keyboard backlight
leds in Documentation/leds/well-known-leds.txt.

v2->v3:
- remove unneeded header inclusion
- use s32 for report value type
- remove unneeded null check
- don't set drvdata as its never used
- prepend "hid-" to module name

v1->v2:
- drop unneeded remove function
- combine set functions
- add missing header inclusions
- avoid char as argument in favour of u8
- handful of style/formatting fixes
- use standard led name ":white:kbd_backlight"
- rename USAGE_MAGIC_BL to HID_USAGE_MAGIC_BL
- New patch documenting preferred keyboard backlight names

v1: https://lore.kernel.org/linux-input/7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com/
v2: https://lore.kernel.org/linux-input/20230216041224.4731-1-orlandoch.dev@gmail.com/

Orlando Chamberlain (2):
  Documentation: leds: standardise keyboard backlight led names
  HID: hid-apple-magic-backlight: Add driver for keyboard backlight on
    internal Magic Keyboards

 Documentation/leds/well-known-leds.txt  |   8 ++
 MAINTAINERS                             |   6 ++
 drivers/hid/Kconfig                     |  13 +++
 drivers/hid/Makefile                    |   1 +
 drivers/hid/hid-apple-magic-backlight.c | 122 ++++++++++++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 drivers/hid/hid-apple-magic-backlight.c

-- 
2.39.1

