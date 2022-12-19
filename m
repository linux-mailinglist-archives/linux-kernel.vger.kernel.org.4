Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6148651260
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiLSTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiLSTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:09:27 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7697645
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:09:25 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g7so9100095qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bt+7Tt3o+8BEAMqMOB9mE5Ei3bYGSWfShEIE2EXWhpo=;
        b=O5J1MFkjtu2DK19SHsxcO3VrHhhB8EpVDYNdgzjZ0zHbqHMUFfbZQvk08Dy3DgzZVm
         37ZKzj8XwRFcDuOPGtx1aale3ohpUFIkWjH1lXmMnBgZUZdaJceu0P52qw9ItMISuktB
         Gbu81ooJyEzMpklfqyM258OjRg8CJZ1cK9zthDBV7sWVWv/DxuKEbaacQp1SvGzq214i
         OpGYIy7XS5tvowHg4eA8fUkjf/hu2zBLkbvRG03ZOJuXtBDyTgJhg3kKHTJz/BBeKcuq
         AOsduwgkcJ3vczfR/KZMUI7uAy3o5W+oCRi2xIbkYiwRDOP3HHmPcWv2ocA68gneMNjM
         t71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bt+7Tt3o+8BEAMqMOB9mE5Ei3bYGSWfShEIE2EXWhpo=;
        b=oQ41FSxFrnNqZIM8RkNbtkjWY0IwsITxjF74PhF+wMTRgqe1dU3iCGot+yEBegpU1S
         yF9lGXjsSq206LdTalseYwC/J5ho7m+KQtDtl5l29LCJ6u1DqQxIj5qV4ftfuk4eqlH7
         z8Urg8S/dieEy2kgXB9xLGLhgORA4bzV5xrHOs2B+5k3Cik1gLHrGsB3MxnIZ9/jj+o6
         YqWbtUwBZvJjEbQ+/F29yU9QQFPZQnH5OuteH9fLHhbslk7fCkOTYSaZnB81BtUeLZTF
         Q6QIdqvNBjMr1UpZzR2eVh5q3M5zP5xARpgOG7LJfQq91ia/6VAlAoeSvmpmUP3fhUBb
         nt+w==
X-Gm-Message-State: AFqh2kpCzKZyPWPM19LRLcqbSxb4+lhKHu2TS+2ScIl/5BpdvJXP7olX
        wuZfOVN9NS7/MTa3vk6pkdSGKA==
X-Google-Smtp-Source: AMrXdXtqIvJprjFkBeCepzDnuDDIM8nlR+euxdUGloYM4/cmVIT1oBBjJWppDGM+nV9Gmx+hG6Zcfg==
X-Received: by 2002:ac8:538f:0:b0:3a9:89f1:828 with SMTP id x15-20020ac8538f000000b003a989f10828mr5685143qtp.14.1671476964289;
        Mon, 19 Dec 2022 11:09:24 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a249000b006fa9d101775sm7503743qkn.33.2022.12.19.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:09:23 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alexander Bigga <ab@mycable.de>,
        Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH 0/3] rtc: m41t80: set xtal load capacitance from DT
Date:   Mon, 19 Dec 2022 19:09:12 +0000
Message-Id: <20221219190915.3912384-1-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m41t82 and m41t83 have an adjustable internal capacitance that 
defaults to 25 pF per xtal pin. This patch series adds the ability to 
configure it via the devicetree.

Patch 1 just switches the CONFIG_OF-dependent block in m41t80_probe() 
from an ifdef guard to an if(IS_ENABLED(...)) guard, so that I don't 
need to use __maybe_used on my new functions and variables.

Patch 2 is the DeviceTree YAML changes.

Patch 3 is the actual added functionality.

The desired capacitance comes from quartz-load-capacitance property, 
following the example of two other RTC ICs that have adjustable internal 
load capacitance, the NXP pcf85063 and pcf8523.

The m41t82 supports much finer-grained control over the capacitance than 
those chips and calls the feature "analog calibration", but it looks to 
me like it's essentially the same kind of thing.

My use case for this is:

ST specifies not to add any additional external load capacitance[1], but 
the MikroElektronika RTC 9 Click board[2] has a 22 pF cap on each xtal 
pin[3]. The resulting combined capacitance appears to be outside of the 
operating range of the xtal, because when power is removed from the 
boards I'm testing with, the RTC reports an Oscillator-Fail flag on the 
next power on.

I found I could work around the problem by reducing the internal load 
capacitance as low as it will go.

I have tested on the VersaLogic Zebra, an NXP i.MX6 ARM. I made sure it 
compiles cleanly on amd64 with CONFIG_OF=no.

References:
[1] https://www.st.com/resource/en/application_note/an3060-applications-guide-for-serial-realtime-clocks-rtcs-stmicroelectronics.pdf
[2] https://www.mikroe.com/rtc-9-click
[3] https://download.mikroe.com/documents/add-on-boards/click/rtc-9/rtc-9-click-schematic-v100.pdf

Dennis Lambe Jr (3):
  rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
  dt-bindings: m41t80: add xtal load capacitance
  rtc: m41t80: set xtal load capacitance from DT

 .../devicetree/bindings/rtc/st,m41t80.yaml    | 18 ++++
 drivers/rtc/rtc-m41t80.c                      | 84 +++++++++++++++++--
 2 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.25.1

