Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B631A69CA49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBTLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjBTLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:52:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC419F1C;
        Mon, 20 Feb 2023 03:52:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pt11so1721649pjb.1;
        Mon, 20 Feb 2023 03:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2TPfbnlNgSvn1ZvA1J1UerZgXPq6+WBvVASakrBm5D8=;
        b=UzTKs9k0xcxuS/x5awRg4ZuYmEF+nloykjmTIywOe5k8fLm/CPfzsCH6pl1m2zE/zo
         6Nh7bG/iEcbF4ocMe2agfNVtnchwlsRELooKQV70IjwFr8gNNDuOAZE5yg4+nRE5C4fC
         /+1Q17Y93dx0VcPv4/qo5PTL/TZbWkII6Q7Mxp+P7UPVUTXj/47PgIErwtLl/qKBeoL2
         qZqJp+ggnuMN0KEY2oDmVfr/c30DKtw9ug85d5h5MZWtU6OQt9uqIR77jqeDuGXHl2K0
         hnKbRqwvO2ccYq5AUdR12jaMS6mFe2NcNMOWiiOMZlJ6jQo+45Md3NiwqIAWXt2QCdR1
         mrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TPfbnlNgSvn1ZvA1J1UerZgXPq6+WBvVASakrBm5D8=;
        b=wQdRkXuxr640VYRIpVESuFZW3mUWY+eDrl26p8USbbMbOhOAPd1mi6k4EcNNVMaFv/
         b4VprW9XF+/3mDnIXMvOh3UOFRFGl8uJJj7mvvq8oaabaZ1v1aMVUVH3rhyfjWgI8Xe7
         sGCY19ODOjj+smBzfCnIe1dBEV3osXfi+gycQiRYWFe6EOwA2nq7H7llH2GLQpYMpiNa
         CHba60tms+Gwjud5z3INbaUbpuyGOy2QpRMIA+LaXSLltqZ10AHTWMdsaJS8Bprmxkf+
         ibp+d1qBRCz28P13X5qnley14qts6BwSPvPdw97uIh3emmId74VxR/KYTAz5KnZZT+Ik
         OYLQ==
X-Gm-Message-State: AO0yUKWjkh6hltPHkEFPkFlGo9HigEQ+VhT64BycVMsprsK7XBLSsgnY
        IMHTu7Q77KRahOlGCMU6EoIB4TI6NkCaKg==
X-Google-Smtp-Source: AK7set/9k7Y8Y2oq5eU9PjyaH1rAUy/D+03vpYNIjYokEvclF0cp4j7pNu+QETv6AuN9nOegSVXYhg==
X-Received: by 2002:a17:903:7c6:b0:19a:a815:2869 with SMTP id ko6-20020a17090307c600b0019aa8152869mr2192376plb.4.1676893946444;
        Mon, 20 Feb 2023 03:52:26 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b001962858f990sm955297plb.164.2023.02.20.03.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:52:26 -0800 (PST)
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
Subject: [PATCH v5 0/2] Apple Magic Keyboard Backlight
Date:   Mon, 20 Feb 2023 22:52:01 +1100
Message-Id: <20230220115203.76154-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
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

v4->v5:
- use <tab><space><space> for help in Kconfig
- prepend "hid-" to filename in MAINTAINERS

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
v4: https://lore.kernel.org/linux-input/20230218090709.7467-1-orlandoch.dev@gmail.com/

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
2.39.2

