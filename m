Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8966126BD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 02:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ3Av2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 20:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Av0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 20:51:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6694D3FED1;
        Sat, 29 Oct 2022 17:51:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v28so7642925pfi.12;
        Sat, 29 Oct 2022 17:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHQuh6qQJ1NJnTL3APPWFBBH9J7/L91Isi4wqc9nEYw=;
        b=mVD7X1NEQZy21Y5Vp5lEpL3K9hrCoysaaidlwOuzeeh68Wr0+HJgS72LN+qad0iCbQ
         WU+b1XOLbw8oB1qbzTS62oFY0db29buW7ibDOHXvo/5nsgUg4vQ7wd8QU+qtDBmPdjRA
         29N5COIbSAzU9nwUeB/17qOssFySIqScstY5OJD8ZoBOzQc487SRQEYO90USRtuvdOU1
         ogPxsM9+i3B6F1QhB2kvorQm95BozVTvs/5xJSh/OfTF3sIKdlS/farV9Z4t3x+iZFh/
         FQNgOklqiVqlBkorrG/GU5Mt14/4gSTSsTBZ4YHxUjb6o4Yzi30E35Ciz3yvQkZ9m/YM
         mbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHQuh6qQJ1NJnTL3APPWFBBH9J7/L91Isi4wqc9nEYw=;
        b=R/vP1/vQUczeTM9iaD+kQWQn6zuNJkoL4Fvw577cRwBQZC0GSfVzzKWAMr+YPOKmOU
         WjV60CDyFe2Bxo+8pLJxdopH8717ByZOlxYiwj3nU83tPCGled6du5um011ZWcYWdh/b
         VbTz13qZ30v8h/Bfjaf/Z5Vj5nPjawHrd1tCXVkd2KkKDPFD+JUbeiqgLC7mvbB5Fh/Y
         0GIlA9pcQqgZKLnLgZdhfg3ZI6BWpYp3ingBgXUe4YdFz67RZIAPNdbHHEqJZmGmKyOY
         bD1xu65cJSC5NKLJKPWHbc3mF2KYFvvT0pb5TKjjqXpXkApvOHioon92tHFCtYxn1qx0
         Jsfw==
X-Gm-Message-State: ACrzQf13nWUCfBMKZ47eQy+66nFsIFdCjSl8E5gdd1U0geRp/FkXPVw5
        7UmreENnmp1hsvAlr3NUbwO7YV6nQew=
X-Google-Smtp-Source: AMsMyM619K/M3GiTGoTR8so3V7uu3Sy5nA9GcUlBs8NrPnAnUuattcHYHWaGYP98OMVaB4nP/JlbYQ==
X-Received: by 2002:a63:fb0b:0:b0:46f:a98b:5685 with SMTP id o11-20020a63fb0b000000b0046fa98b5685mr810721pgh.393.1667091084611;
        Sat, 29 Oct 2022 17:51:24 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b14-20020a170902650e00b00176dd41320dsm1836744plk.119.2022.10.29.17.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 17:51:24 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernle.org, krzk+dz@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wells.lu@sunplus.com
Subject: [PATCH v11 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Sun, 30 Oct 2022 08:50:48 +0800
Message-Id: <cover.1667087353.git.tonyhuang.sunplus@gmail.com>
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
 drivers/mmc/host/sunplus-mmc.c                     | 976 +++++++++++++++++++++
 5 files changed, 1055 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

