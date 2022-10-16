Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8096000EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJPPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJPPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:49:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFEE7A;
        Sun, 16 Oct 2022 08:49:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q9so8461978pgq.8;
        Sun, 16 Oct 2022 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WlEL88T/8gonzqhH6cO2E6CR0UGDLwIIZCf+umnGgY=;
        b=MyZk3IohuTtTDLI6wNP9DdVpZRD6zLm0z7Q8+C1R+Laa0hBg2kYFEzO5uVjgjShW1f
         cEONri1vztKjmt2J0fLLiXTlxwF7io/T/W375c4k9LOJTW2x+SIS0j1ZIxiF8nnPm+kS
         6YbXuvWMh7do/vNc0v1+/Gp2sSjW8LbKMfP4r1EIW/6MUnTvRpMn6iyh6/U+xqCPXKmx
         mAWSzjGwOaYRLjhT5DpzpkScKBN+3GuUu5k0aFZ9VGv7D2P+bK5ht7ofPxhBOgOEdZga
         mtAf5Ig+sJcIubtBePpx434glcRyXEw6URWAc/ekx4jnXXBmu0qRVh1r9pSg6kvOAGBF
         D/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WlEL88T/8gonzqhH6cO2E6CR0UGDLwIIZCf+umnGgY=;
        b=xq0bakoR43gg9h1INT8VXufd0KycSxhOiYKHIQOGSZ+WVQrAkWXBTMLJuk7cwj6xyW
         JfF1qoI0Octg1FIFss7lsLTkdI3puNLnjsZmgUhzu3p53qdi/FPOIpRB45mDVV6rLEH8
         QUgG2ZluQVj/6xfPBwBAz4ix6W6NTccDKOjV6qi+1HMkte/Nzhyv+YYnM5YnvK3fNC6a
         paQhquyiwNy5r6i+zr+Nxtms0wJECX1FYi3iB9t0c9T20ssaVOFyW2swItkix/wm4TJh
         AmGyQqXsPwjmfnINB6mj3OEd8CekTtx99dijnQIztLaYZemQIhPqG7rGn+2XtFmk99AI
         o5qA==
X-Gm-Message-State: ACrzQf276GnR0vuORHj4u2CAkGAl3pbUeXyYNqNM2dw0cFwUOR66u9aS
        HxPPC1GDJO0/iJRbXgPA5X4=
X-Google-Smtp-Source: AMsMyM6YXA2lbc2XeJ/c4G6hx6QxmOnVTh+E7N+iQZVL8cwfnU7wa2AgaCcv8teuEHmKMvjrdMbTpQ==
X-Received: by 2002:a63:f806:0:b0:439:d86e:1f6e with SMTP id n6-20020a63f806000000b00439d86e1f6emr6994658pgh.46.1665935361660;
        Sun, 16 Oct 2022 08:49:21 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id w14-20020a63fb4e000000b0041a6638b357sm4595222pgj.72.2022.10.16.08.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:49:21 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com
Subject: [PATCH v10 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Sun, 16 Oct 2022 23:48:30 +0800
Message-Id: <cover.1665931914.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |  62 ++
 MAINTAINERS                                        |   7 +
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sunplus-mmc.c                     | 959 +++++++++++++++++++++
 5 files changed, 1038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

