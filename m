Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7075A69B8EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBRJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBRJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:07:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2F4C18;
        Sat, 18 Feb 2023 01:07:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id rm14-20020a17090b3ece00b00229ca6a4636so417543pjb.0;
        Sat, 18 Feb 2023 01:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVt5UANgc6tLsktStaJAbQ/XwBhkjW3Xxa7yXJVY9D4=;
        b=QYQkld1A4LFg739vmqOTG+Ws03s1QeTr8znvv9f1lnc69KodmvDdLaLmwNG6arSLak
         13sC4hZIPZjIHTSRIOYj4f/WXFQxX136js5Kryu5NjcIER1WJAcy/CPuuzpVjLeSo1tX
         u1X3Rzw0lCun2xZgoGu2EBopz02aVMPnaNBoVN+WZMDq3DVEiVFkOjwAFByxZ39aIHpI
         lFsPF5D5EHy84n9BcNdYuBoPMCkX6YENCze3QN7q7qT7rZOU8oRsjyt9lhP2MlwEHpTr
         GFVD4QYCKte+Chyi5TOPwEjXP5qSNH5EU//fiKM1R4ffIYYXqvzryB42L7n7R3lpYRHL
         JpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVt5UANgc6tLsktStaJAbQ/XwBhkjW3Xxa7yXJVY9D4=;
        b=Bsp5cLppjMeEApYK7kmpBR4eEnM68nxiCLob9T+KWsadkX3tiH4fx4XKYrrIsdGdqx
         pToj+0/UvDjfZsNDvGG4hnWzCb35/bis4Z0B83ZRmsSp9LrJUAvow8g6IV7Q4+jMhIh1
         w6nMhBUM5iDJBq3Y8oi1Sc4T0mDIUmBkbqJWtn/7mzCMnAG36fXRaUIvuopYRGbV/7b8
         RAR4iOADhq7H2H+i8SXttIFeG+7HGoTnKQPLYrE5mCp8VcteBcP4qZmhVacvU4031YZ6
         UxZih1vGRjYbLJg7mQX5CqZNSZ0tBeUJcPrWf7RHai2d/AKztcmCB5Ut1HXyedK8Hi8Y
         nn3g==
X-Gm-Message-State: AO0yUKXA8srgSPuII1ekKZHSnvuf9dOOPVtZKW14Kys3IJt8B9FlDwz1
        grGe3bvyh3eI1sjp37raSKPWdA5IC7oxKg==
X-Google-Smtp-Source: AK7set/o1AMODyx2MAiI/TbbaIjJ+q/zajcDQTqfBY+Yet42WJuvqsNayb0+R23VjD/4szv+WWcrHA==
X-Received: by 2002:a05:6a21:339b:b0:c1:2027:f4a2 with SMTP id yy27-20020a056a21339b00b000c12027f4a2mr2647046pzb.49.1676711271534;
        Sat, 18 Feb 2023 01:07:51 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id m192-20020a633fc9000000b004faf33e2758sm3945135pga.40.2023.02.18.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 01:07:51 -0800 (PST)
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
Subject: [PATCH v4 0/2] Apple Magic Keyboard Backlight
Date:   Sat, 18 Feb 2023 20:07:07 +1100
Message-Id: <20230218090709.7467-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This patchseries adds support for the internal keyboard backlight of
Macs with Apple's "Magic" keyboard (MacBookPro16,* and MacBookAir9,1),
and also documents what names should be used for keyboard backlight
leds in Documentation/leds/well-known-leds.txt.

v3->v4:
- collect reviews from Andy and Thomas
- remove now unused hdev member of apple_magic_backlight

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
v3: https://lore.kernel.org/linux-input/20230217102319.3419-1-orlandoch.dev@gmail.com/

Orlando Chamberlain (2):
  Documentation: leds: standardise keyboard backlight led names
  HID: hid-apple-magic-backlight: Add driver for keyboard backlight on
    internal Magic Keyboards

 Documentation/leds/well-known-leds.txt  |   8 ++
 MAINTAINERS                             |   6 ++
 drivers/hid/Kconfig                     |  13 +++
 drivers/hid/Makefile                    |   1 +
 drivers/hid/hid-apple-magic-backlight.c | 120 ++++++++++++++++++++++++
 5 files changed, 148 insertions(+)
 create mode 100644 drivers/hid/hid-apple-magic-backlight.c

-- 
2.39.1

