Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD56BDD25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCPXsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCPXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:48:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B223D81;
        Thu, 16 Mar 2023 16:48:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so14005178edb.12;
        Thu, 16 Mar 2023 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679010527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6CcKQfQ3li/OQy0XLK7pgN4pP6FbzFrSofkOie9NH4=;
        b=ARhQMkkcRHRju2Mco0fL2F9mLgQuG1l9gUzuIIwO1ajhxS1dK6kT5sg2NAQD/8j747
         NMYhTn0uPfX/NcuGFX5CPYsSb2JxeqNPBDI9njH3whLXXutoo28MIFqkqqrE+XYisqhV
         prndGKEgEcijBj5JcJisDrtreOWSgIMsG4jxV5cvInqJfueZCP00tIPzm4dnX4S1I86r
         3gfTEAXFvRtqbmpu8oS6wkrPAP4Un+1wjTRA0eUeBNh4hquDiMK05rH6rJD/PI9bxvNn
         TRNOPTSULk04cgXr244le466heWOwi8YI9ruQrJjHo/XjdAZSrcAA5SrpQTK3UxcfURv
         V/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6CcKQfQ3li/OQy0XLK7pgN4pP6FbzFrSofkOie9NH4=;
        b=WC018x2zFndQcrp591thK9iIUuOh//z7loXMD+tMYncsSgXAwSNUYMCzmyLOeU5XwO
         8TbjX5e+QQDtabwM2kCSPkG4fWpOzANfyx7P7ldS30ovr0wb2n7HL2i7sIU5jBrcLsge
         PRkCrYdI1wdTE07PlxxLZNTEGtatvZ9kEGpqRGfQ8V9Imuh34NZQYttCj8uXCQYYWBPw
         DlrJFLJ0IHKFyUywmsfdhO1BOPFIiPPtqFWT0HkUsQOX/Gz/FBEKoeEOBQ8UUFPK1Jrw
         pCmJm7q1GZaSl23CcEtXk4h+MTJk4d4r4udmJ1HToIhyv+qbKAMVTorFcVEoz7tL2ztI
         w9BA==
X-Gm-Message-State: AO0yUKWCkA8Ya7ksZ5x9t+LxQdbRPvbNyITXBLQO2F3uaj0ugA5GkQNe
        0ONTmeqsKiJtjlob3TI4qoQ=
X-Google-Smtp-Source: AK7set88K1g3guSHAqEW0yiw3gxUkxpaqyAds3f35L8epGGiQzX6te7ztmZ2sYhw6qeIG0lwLJIOHA==
X-Received: by 2002:a17:906:f2c9:b0:931:bc4a:ce08 with SMTP id gz9-20020a170906f2c900b00931bc4ace08mr468010ejb.36.1679010526637;
        Thu, 16 Mar 2023 16:48:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::a442])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709062dd800b008db605598b9sm226896eji.67.2023.03.16.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:48:46 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132 accelerometer 
Date:   Fri, 17 Mar 2023 00:48:34 +0100
Message-Id: <cover.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
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

KX132 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132 accelerometer is very similair to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.

A complete list of differences is listed in [1]


[1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1

Mehdi Djait (3):
  dt-bindings: iio: Add KX132 accelerometer
  iio: accel: kionix-kx022a: Add chip_info structure
  iio: accel: Add support for Kionix/ROHM KX132 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  13 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  21 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  24 +-
 drivers/iio/accel/kionix-kx022a.c             | 413 +++++++++++-------
 drivers/iio/accel/kionix-kx022a.h             | 181 +++++++-
 5 files changed, 464 insertions(+), 188 deletions(-)

-- 
2.30.2

