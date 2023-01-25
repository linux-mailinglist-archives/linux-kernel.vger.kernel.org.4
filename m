Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DC67ABE2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjAYIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjAYIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:35:56 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Jan 2023 00:35:55 PST
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084296A77;
        Wed, 25 Jan 2023 00:35:54 -0800 (PST)
Received: from sas2-ffeb92823cb1.qloud-c.yandex.net (sas2-ffeb92823cb1.qloud-c.yandex.net [IPv6:2a02:6b8:c08:6803:0:640:ffeb:9282])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id C648F10AAF53;
        Wed, 25 Jan 2023 11:30:31 +0300 (MSK)
Received: by sas2-ffeb92823cb1.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id UUKCeP8ZA4Y1-fXis0HZR;
        Wed, 25 Jan 2023 11:30:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1674635431;
        bh=vMqQxoLJ0OjTyTvK+N3TACsOXvm5uWLcaMM3em0scfI=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=h57w1pwdXDfOgFlMXJmd0nrUDrwmLoZ8bV/PehuPKirn9G5jQTU/Dk+FZKlTrzcCA
         HR81ibZqhTTSlXu2xLCat4johVr6Rp1bUHH44fw2XNuIicUoTMxZ0XoChqUttN/Ht8
         QqwmlOi2Fdjs/XjD3ECiYcQ4fg3Bg9beUCj2HKCc=
Authentication-Results: sas2-ffeb92823cb1.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     linux-gpio@vger.kernel.org
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] gpio-ep93xx: prepare for dt, fixes
Date:   Wed, 25 Jan 2023 11:30:23 +0300
Message-Id: <20230125083026.5399-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230117100845.16708-1-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce fixes and DT conver preparations:

- fix F port irq numbers out of sync
- make immutable
- prepare for DT conversion


Nikita Shubin (3):
  gpio: ep93xx: Fix port F hwirq numbers in handler
  gpio: ep93xx: Make irqchip immutable
  gpio: ep93xx: split device in multiple

 arch/arm/mach-ep93xx/core.c          | 121 ++++++++-
 arch/arm/mach-ep93xx/edb93xx.c       |   2 +-
 arch/arm/mach-ep93xx/simone.c        |   4 +-
 arch/arm/mach-ep93xx/ts72xx.c        |   4 +-
 arch/arm/mach-ep93xx/vision_ep9307.c |  10 +-
 drivers/gpio/gpio-ep93xx.c           | 357 +++++++++++----------------
 6 files changed, 258 insertions(+), 240 deletions(-)

-- 
2.37.4

