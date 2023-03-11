Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931F6B5C35
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCKNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCKNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:23:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196522CFDA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:23:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i28so10227231lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678541033;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=XBmMuGEITMXGT4vIMrLlkPv20iPUnhel4rNCGhgDg8PyE7PQyd1F4ssP5Ddq074kz1
         RxE6yG/RmU6gsP9vqfxN4EzM+Xc6e6GtCZdEETouD5eJF3YfcAEtQyJCXGwtxByCE+VO
         pFtuqFy+JCW/rmYETGugqzrjtSMVfBmsH4QTxP86xDhNC4gAPzCSgrbWm4bKJ4wAtSzt
         We9Kmo/GMm2xBsJAaV/frhkMZw1dvLPgkeHZlESpsMQ5ZTE75XnrB7jvo2gy3/t4f8Rg
         +mcC0KCOVwU7i4lDBqeoJJ66BCh79xitc5TV+XsEpzC6mXWC7m+CHV3W5KDkuwhgsJzZ
         2FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678541033;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwysB/HxtkhvD1Lkzv8uYufq7BInyVs0XV9o2nsB4rY=;
        b=YaJqLET1QYAZchHo3IZCbhRjwwqD8RsAi8+M4Rc9Oqn9hb0tjpuOkAKhN3yEuTsKoT
         GozXYL4ApoYy+e+0CYnltbt4MQbLHtGeDUXnFu/HMJ3Na+/sPS43lVQyBVcSUhMpcKnz
         Xq1vTQJPsUY+1ACTeS2C/6O+yxzDWtdHJVdXs2+UA6P7HKZvAteR0A8lOAe2I7pQCqV6
         qT+7ZjLJ/1mcEUC4y43yJ/2sFW74Jv7Y3jfH/I3HOjhpNNyd222SjRqWH4ccUo0ndZjk
         traYRaK2h39Au1YSWF52xxR9t+NdQVx/w9Axk5O/7G1CyNe2d804qYzISN5FIkhqPv89
         PPFA==
X-Gm-Message-State: AO0yUKUOi5RuBvZwCF0+OuJIKgDfLpEi/Sx0AkJo6hWm6YLd4lVBg6fF
        CRE4o1IJO8uRQ+lndF3A/5nq2wd8z94XEJz14XA=
X-Google-Smtp-Source: AK7set/6zxovDFLWB2s4iPKzbH238n3y9l4dMn038oTfhEYOfVroy13XyCCvLHHviV/Tkljs3FT7yQ==
X-Received: by 2002:a19:c217:0:b0:4dd:af72:b20d with SMTP id l23-20020a19c217000000b004ddaf72b20dmr7263625lfc.42.1678541033200;
        Sat, 11 Mar 2023 05:23:53 -0800 (PST)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512376f00b004d58bf6a61asm310990lft.230.2023.03.11.05.23.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:23:52 -0800 (PST)
Message-ID: <640c80e8.050a0220.2cfb3.0ba7@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 15:54:59 +0300
Subject: [PATCH 0/2] *** SUBJECT HERE ***
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs 64-bit
accesses is the FIFO. The symptom is that the DW MMC core never receives a read
on the second half of the register, does not register the datum as being read,
and thus not advancing its internal FIFO pointer, breaking further reads. It
also seems that this FIFO is only used for small (less than 16 bytes)
transfers, which probably means that only some SDIO cards are affected.

Sergey Lisov (2):
  devicetree: synopsys-dw-mshc-common: add "fifo-access-32bit" property
  dw_mmc: add an option to force 32-bit accesses to 64-bit device
    registers

 .../bindings/mmc/synopsys-dw-mshc-common.yaml |   6 +
 drivers/mmc/host/dw_mmc.c                     | 125 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 3 files changed, 131 insertions(+), 2 deletions(-)

-- 
2.38.3


