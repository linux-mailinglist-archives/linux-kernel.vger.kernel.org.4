Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8F631DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKUKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiKUKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:07:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AF6A3422;
        Mon, 21 Nov 2022 02:07:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so10179223pli.0;
        Mon, 21 Nov 2022 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANC5vOtSH3iFR9ReC7ihlapXLCWk3GPZKq86c4BIU6M=;
        b=At+TDhJCawuix6CTkEs1nXlAMAa3TBvb7168siGKcRpoHnrCI2BbWKcT/uboq4ZUar
         9Ek3XFNA2gtUXkDZywxJP52/nDwd4+oVDmslGnCb/QehMqyHuPInMciLpLSIzXFIE9lE
         h01TX6bzk3M6dRV64+pGoVFeWXYtTAKDX+VT8Ljd2sJ+x3Ca2j7ZcDrUC22WcOFwvYkb
         Ov6Vg+oWhylgDWSaocjqzefDNiTn/nnaIwLH4w774lmnKAmapqbvEER/z3AeKFOjL0Cf
         e6NqqGm0+6awWSOXe6YbAV9hcc6pY5yl2N71y2EUrDlnMIhUWKKFEEKHFI8M2hIT0ofy
         EmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANC5vOtSH3iFR9ReC7ihlapXLCWk3GPZKq86c4BIU6M=;
        b=AzarhifrUZFMbNEXDs9O845Co2EUED81hZJbgkAVG7v5Mdl5sJ1KJv3WZhJctCGyeP
         RqMxM8aXp0el8fhfLrRT/adY/+YEPBUDZNW7GpwUvgXPKgfM2voc+vhVlcfUICtPMk1I
         L/065u1PJP8dwE6Tsj1ImK1OpO2KofnRSVxCyQak1NHQQ2lSzBNCiQwnNWNJcdKgHF4l
         IeVkkqqDZgHTiUpq0hpc6TQ0RVqdbn7unA1inpzgnTcK9Zg0lEgCMBC2DpmpXKFsmfdx
         FeHv18WxGnCNsLdXJt55zPI4R4raTirhpjGU9QvVbwgnz0MVg7P5ZTGqp+kw96eeRpO2
         W5hw==
X-Gm-Message-State: ANoB5plvz6Iwi+RC91pTSi8dBnnXuKukjDzrBWfyjOxkRJl/UO1d5lky
        Px05n6JS9M34MA3fev1L2Hg=
X-Google-Smtp-Source: AA0mqf4f+iw/lpeuE6+czXXBuE7VH9bAhq9QcerhyRt7+alS6LP6PLLlB1bng7Cf5I+AZ9sd7zDu8A==
X-Received: by 2002:a17:903:300c:b0:188:f663:e2e7 with SMTP id o12-20020a170903300c00b00188f663e2e7mr1580107pla.121.1669025225849;
        Mon, 21 Nov 2022 02:07:05 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oj8-20020a17090b4d8800b001df264610c4sm23069042pjb.0.2022.11.21.02.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:07:05 -0800 (PST)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com
Subject: [PATCH v12 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Mon, 21 Nov 2022 18:06:47 +0800
Message-Id: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
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

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   62 ++
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus-mmc.c                     | 1000 ++++++++++++++++++++
 5 files changed, 1079 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

