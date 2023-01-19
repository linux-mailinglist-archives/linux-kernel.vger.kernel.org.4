Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07102674562
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjASWBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjASWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:01:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEBA17154
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:39:35 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h21so2674121qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diUS7SbW+4cNCdAZHjd5Rb9WzsMVmloUYnR4biBBhXI=;
        b=xZayoIa34oX8jpXw5WEG7a1XwkbdqXP7TWyTJXPzHmxAgsQgZyCK7miSfSHLuTxwQT
         IePLF8SK3U8Hx6tl9ole8Op4kDgozndWjmtij8TNRJqqLxJxZBwnFkAbOOhmO6vGXBX+
         KnpvRquWY/6tESSK+Tk2lFB3MRz77pHkdJMHIINmXV3Xi8Em81/fRMqeaEQUnixeqDfB
         IggX6yHiULbL/z9Ws62zZLdVMG2pzKnHL5ACRNw7y86yfD9ekSmnlX1l5GNV2hZkj5du
         P1j14kebMDOU4+Wwwth2PUCBi0ZhUYYdILBwxgYz8ZRJXRkq4ZGZ72j2njvmqnlzwa/m
         8Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diUS7SbW+4cNCdAZHjd5Rb9WzsMVmloUYnR4biBBhXI=;
        b=c7JT+M956hxsn3Xl6fOf/zBMwntKZllMesTL4aLHMgCZkaaFwoZa0J1WGRTlsqFxeG
         Q6Aqvby6KnF1UbcaoU6gagxdvp1Y5BsPl/hAK3gUMm7H9UR8agE4joiNhu4iyyL/t//R
         /kstm/AYApZEgGLvFkLXnweGzwlE3P52ew7TjprBv5idxw8kRrp26Y4FqD87d2daxccx
         +KhA2BraN8OBSKdyedPh5zC9nSOje6X2l6ZPX1aVyRgNbwt7sZMN1k9hrrwvDrDyW/9R
         CaIhs0Ub65r8ha8f5cECRq06UwH2D1394MEd8BLdoDYwgc/7Odlpg9C538p0qIWQoGsx
         o8Zg==
X-Gm-Message-State: AFqh2kpBYtUaPgbBLbnc31sC4AUtwL9+5/Qw8IJ5F4ClEBAKqlK2Bumn
        BPgOS5hijZ0iCBEpEsp+acsAIf6QW3zGyv4f40U=
X-Google-Smtp-Source: AMrXdXu20D+eAnx/j7BRIFAVfNKdOhXio7U6ZSQzIOr1FUFoa4y0uo3eY/M2amHQ3H0kkH8huV7Q8Q==
X-Received: by 2002:ac8:66da:0:b0:3a7:e9a2:4f4a with SMTP id m26-20020ac866da000000b003a7e9a24f4amr18376043qtp.8.1674164367865;
        Thu, 19 Jan 2023 13:39:27 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b0070531c5d655sm2600676qkp.90.2023.01.19.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:39:27 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Cc:     =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH v3 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance from DT
Date:   Thu, 19 Jan 2023 21:39:00 +0000
Message-Id: <20230119213903.899756-1-dennis@sparkcharge.io>
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

Other than adding a sign-off to one of the changelogs, this is a RESEND.

Alexandre Belloni, what do you need for this before you'd want to apply
it? In case it's additional reviewers, I have CC'd some more
potentially-interested parties this time and updated Atsushi Nemoto's
email address to one that's hopefully more current.

I think the original author listed in the header for this driver,
Alexander Bigga, is inaccurate. It looks to me like his name got copied
over by Atsushi Nemoto when he created m41t82.c by deriving it from a
similar driver. At any rate, Alexander Bigga's listed email address
bounces, I didn't find a newer one for him, and he doesn't show up in
the kernel commit log after 2007. I don't think he can be considered the
maintainer for this driver anymore if he ever was.

Changes in v3:
* dt-bindings: added Krzysztof Kozlowski sign-off to changelog

Changes in v2:
* dt-bindings: remove accidental wakeup-sources line
    suggested by Krzysztof Kozlowski
* spelling fixes in changelogs

The m41t82 and m41t83 have an adjustable internal capacitance that
defaults to 25 pF per xtal pin. This patch series adds the ability to
configure it via the devicetree.

Patch 1 just changes `#ifdef CONFIG_OF` to `if (IS_ENABLED(CONFIG_OF))`
in m41t80_probe() so that I don't need to use __maybe_unused on my new
functions and variables.

Patch 2 is the dt-bindings.

Patch 3 is the actual feature implementation.

The desired capacitance comes from the quartz-load-femtofarads property,
following the example of two other RTC ICs that have adjustable internal
load capacitance, the NXP pcf85063 and pcf8523. The m41t82 and m41t83
support much finer-grained control over the capacitance than those
chips, and ST calls the feature "analog calibration", but it looks to me
like it's essentially the same kind of thing.

My use case for this is:

ST specifies not to add any additional external load capacitance[1], but
the MikroElektronika RTC 9 Click board[2] has a 22 pF cap on each xtal
pin[3]. The resulting combined capacitance appears to be outside of the
operating range of the xtal, because when power is removed from the
boards I'm testing with, the RTC reports an Oscillator-Fail flag on the
next power on.

I found I could work around the problem by reducing the internal load
capacitance as low as it will go.

References:
[1] https://www.st.com/resource/en/application_note/an3060-applications-guide-for-serial-realtime-clocks-rtcs-stmicroelectronics.pdf
[2] https://www.mikroe.com/rtc-9-click
[3] https://download.mikroe.com/documents/add-on-boards/click/rtc-9/rtc-9-click-schematic-v100.pdf

Previous versions:
v1: https://lore.kernel.org/linux-rtc/20221219190915.3912384-1-dennis@sparkcharge.io/T/

Dennis Lambe Jr (3):
  rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
  dt-bindings: m41t80: add xtal load capacitance
  rtc: m41t80: set xtal load capacitance from DT

 .../devicetree/bindings/rtc/st,m41t80.yaml    | 16 ++++
 drivers/rtc/rtc-m41t80.c                      | 84 +++++++++++++++++--
 2 files changed, 92 insertions(+), 8 deletions(-)

-- 
2.25.1

