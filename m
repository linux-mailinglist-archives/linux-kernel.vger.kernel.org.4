Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A711698B58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBPEPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPEPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:15:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6234035;
        Wed, 15 Feb 2023 20:15:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d2so677993pjd.5;
        Wed, 15 Feb 2023 20:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKu/tCqMWpC3njjVXAIhON9nLECE9a/6QQav2GblfJc=;
        b=ZkfsZjXgTv+D4litlZpKtObGQpofrWp7Ug7tGDjWGWdKPW0Vfj1iQOfZPSrpDKAX4G
         LHOY8IoBjjpC5fOY6N2rzPDziuJKDvukZ9yiuC7czBRTFxPHZvPkglmEq/zQsJFAv7yz
         rPm/IV4C1SoLhloCOnFNZNfxFgwq/jSnQkkZjRjKlSBAkBTRqQ8eRz5/z3Q9IXmtMZLI
         LC7iOJMhP9ZtfT6hjlgyZavrympLOm/5R2V9+bitBfbfnHz/ymS8tM8A+Mjxc1oh/AGL
         Bpncn5ghth8c+ipTjyhPKmKc6XSUOAtOKUxrsXcOZE8jl4HiOfMBQ3a/BTyg+mMHuAXB
         T9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKu/tCqMWpC3njjVXAIhON9nLECE9a/6QQav2GblfJc=;
        b=N2wL9qj3c9AsgdvKkBM6/6kOE3nd+sXG1ZJGTraDtuMoIGRjHsGLUD4mEk7PgvuMqr
         ILf3pdP3yPAgCS26rtMu4mbeplppKoCSHuAHfZ450ugwzg2mMkjvByKcCF9UCeG9Oo4e
         f7MWlmWvUhxfaFoPxzu5mE3UlPSrSpsmhvCuvynJ+UqXO24jIX6olRsdcnA7YEofESsC
         eWntrQUSWyRdGrHzaihUFMn95yT7aqKUu9iDEhNaDAh/kJ7p5ZUBEgSG9Gpg1GtQh6Rx
         vIhGEvpQW8A8jsyBVdmWgB7lTlk+jj3bJ72iOcWx7qtZC/sz/Np+UrNTOK+x6ZoXt4/p
         WLyw==
X-Gm-Message-State: AO0yUKUkb9G1jjxgpNZ2eZMlnlYr44ahd9cPGvYrwaMVr+9ncYRBl5hX
        mIOYP110ADYlU8T4L6JHP03Kl8nEaAmJxw==
X-Google-Smtp-Source: AK7set+yAVOk5FCg/3h3SDyr1GOelZEMqf8+yM5bDTUpJHkKPm3+Blm7V8Rv3alCMniph3eRP069Hw==
X-Received: by 2002:a17:902:f688:b0:19a:eef0:33a4 with SMTP id l8-20020a170902f68800b0019aeef033a4mr807064plg.62.1676520943077;
        Wed, 15 Feb 2023 20:15:43 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id ij21-20020a170902ab5500b00198d1993b4esm157539plb.69.2023.02.15.20.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 20:15:42 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCHv2 0/2] Apple Magic Keyboard Backlight
Date:   Thu, 16 Feb 2023 15:12:24 +1100
Message-Id: <20230216041224.4731-1-orlandoch.dev@gmail.com>
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

A previous version of this patch was sent alongside some other drivers
here[1] but for v2 I'm submitting it separately to make upstreaming
easier.

v1->v2:
- drop unneeded remove function
- combine set functions
- add missing header inclusions
- avoid char as argument in favour of u8
- handful of style/formatting fixes
- use standard led name ":white:kbd_backlight"
- rename USAGE_MAGIC_BL to HID_USAGE_MAGIC_BL
- New patch documenting preferred keyboard backlight names

[1]: https://lore.kernel.org/linux-input/7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com/

Orlando Chamberlain (2):
  Documentation: leds: standardise keyboard backlight led names
  HID: apple-magic-backlight: Add driver for keyboard backlight on
    internal Magic Keyboards

 Documentation/leds/well-known-leds.txt |   8 ++
 MAINTAINERS                            |   6 ++
 drivers/hid/Kconfig                    |  13 +++
 drivers/hid/Makefile                   |   1 +
 drivers/hid/apple-magic-backlight.c    | 125 +++++++++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 drivers/hid/apple-magic-backlight.c

-- 
2.39.1

