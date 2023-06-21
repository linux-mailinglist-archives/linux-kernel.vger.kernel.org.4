Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A7738E12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFUSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjFUSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:04:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E53010F2;
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988b75d8b28so456542766b.3;
        Wed, 21 Jun 2023 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370646; x=1689962646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTylxiI+GIwq+JVOZHsCs4o5xuZjm16M7iT9zqJy3cw=;
        b=mwFGac07BdpNduSivqMdJxeosLcJ9zxvwYqcCYHRB664p/lzhjH1k1ry1Y1dzfx6Fl
         yKZQYppXTFrumXGn/1Qlkz+yO5d0F+XbmZ8Lov0qvypgpfgI8uK/SOV7pbneo7Xe4bdT
         I0s1fd8KolTMfofBNi/cQhJPRrv4l0pWSbkUgRiXZXScGbbfDfhDCWIKcnkvrzaHApD3
         OmTsnCD2IPBofe3dfkBX0ErG4hmi4KbWEwR6oXY/qE7bNqQmUh+PA/gCaMxm7bXJya6N
         ldkMBKq0VWwNhmJWqoLawMz+pn78J+Q6WnV8RrPLZ/n5M5+YwwddL40jAVDPWu3dwAbP
         B/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370646; x=1689962646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTylxiI+GIwq+JVOZHsCs4o5xuZjm16M7iT9zqJy3cw=;
        b=BsgMKmqZh3T4o71poNocXterwitI0gm8CNiID74p1psj3Jl1uuIKJRTQpiaGJIh1dh
         pLKO7xdrK4J+BmpwT6U6p62aP3URZxgeqJ8Z++tSnFUu6h0ZhdKPdgMb2yD0fZEjgf3p
         dm6fx/VvIe7TtQDJvgWTAujf+xkDuAH3tJtQGkx/JsJwFcfVzjONeo33QPNZSKcBt8dI
         eg7Nw1mQQOIDPA4ot0fbpQNQ/hTejqZ7s8UGlhr70eaLduqPc3MMmreUi5cRbkljP/j2
         8U9LrXGCP9rdHtgCtyu3eQLoVMOWNMhUAp20qd5nZDLqKZxWFRWOtMJcOl8h4qHg6VF0
         JCxw==
X-Gm-Message-State: AC+VfDw56xD2330Ep7+jjFSzTq5o+YfSVWrymdaBK5TvO5bBvTYmoZo8
        xy2HJXlKqhj+ALABPCtZ9Bb7+dqJEToM9A==
X-Google-Smtp-Source: ACHHUZ5F7xcs0YICL+F5PLYvJGTy8r8FinnNjfOfGrDJlDXO8tmi8UAbajG73AolChtxOXg/wbKoQQ==
X-Received: by 2002:a17:907:a406:b0:98c:e0b5:f0bd with SMTP id sg6-20020a170907a40600b0098ce0b5f0bdmr1776165ejc.76.1687370646348;
        Wed, 21 Jun 2023 11:04:06 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00988955f7b5esm3460779ejy.157.2023.06.21.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:04:06 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v4 0/3] usb: misc: onboard_usb_hub: add support for Cypress
 HX3 USB 3.0 family
Date:   Wed, 21 Jun 2023 20:04:02 +0200
Message-Id: <20230620-hx3-v4-0-e56b3c6db60b@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJI7k2QC/23NTQ6CMBAF4KuQrq0pnQLiynsYF9MfbKOCaZFgC
 Hd3YEdk+V7mezOx5GJwiZ2ziUU3hBS6loI6ZMx4bO+OB0uZSSFBlFJwPwI3uoZCq8baqmR0qTE
 5riO2xtNt+3k+qXxH14Rxnb7eKPuQ+i5+109DvrTb0SHnggOWqtagzKnQl/QIFns8mu7FloVB7
 ihJqiqxAEWqyuFfwY4CUhKNNgIM1qreqnmef2KWdNkZAQAA
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series adds support for the Cypress HX3 USB 3.0 family (2/3). For
now, it just contains the USB-related aspects and ignores the option to
connect it via i2c (3/3).

As the HX3 family operates with two power supplies, multiple power
supply support is implemented (1/3).

Thanks & best regards,
Benjamin

---
Changes in v4:
- 1/3: set num_supplies=1 for the existing hubs
- 1/3: drop duplicate num_supplies in onboard_hub struct
- 1/3: clarify connection between supply_names and MAX_SUPPLIES
- Link to v3: https://lore.kernel.org/r/20230620-hx3-v3-0-2acbc03ca949@skidata.com

Changes in v3:
- 1/3: fix nits mentioned by Matthias
- Link to v2: https://lore.kernel.org/r/20230620-hx3-v2-0-76a53434c713@skidata.com

Changes in v2:
- don't re-order by VID/PID (thanks to Matthias)
- 1/3: replace (err != 0) with (err)
- Link to v1: https://lore.kernel.org/r/20230620-hx3-v1-0-3a649b34c85b@skidata.com

---
Benjamin Bara (3):
      usb: misc: onboard-hub: support multiple power supplies
      usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family
      dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family

 .../devicetree/bindings/usb/cypress,hx3.yaml       | 77 ++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.c                 | 45 ++++++++++---
 drivers/usb/misc/onboard_usb_hub.h                 | 14 ++++
 3 files changed, 128 insertions(+), 8 deletions(-)
---
base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
change-id: 20230620-hx3-cb935b4fdd76

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

