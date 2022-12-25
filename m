Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C4655DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiLYQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLYQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:56:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF7219F;
        Sun, 25 Dec 2022 08:56:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i7so8552922wrv.8;
        Sun, 25 Dec 2022 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKSqG/HJfk7EMkIlt3NPe0GCcNup8Td9YliDtZjfqvw=;
        b=enBJu3HxPffXruE6QnuHjd5KGX9mEafWooZkX3mBnWmB8mWcpbMVzT3nhYlbmfDTZo
         6pUKg6rHm8/L9rjntWZIWNL+4cc8bC/PH2gsXhBNcOMZRSFCsiTU5PGh3zre5/znpH2w
         cTOVPtb3ul5vNrI6IwaUc0bk1zvu6hRFmIFdLbrbCi9410J9LaYpDI8E+jaYnyTp2ScR
         +YCCqKDZ74buxOepr/0mXn4srReKyJDLiswgm7Nw+vP07sG13oqZnbXtf2ERoJ3WFp6D
         wchsyWduh6En8zxT7Bj+puDeriuSQl7i4dyUrceX8uwRgoCmYhX2B2xWK6mS5FUm21xn
         KeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKSqG/HJfk7EMkIlt3NPe0GCcNup8Td9YliDtZjfqvw=;
        b=1S6ciONcnTs+oqNnTwj5BA+6pv1phBb0Nrto1gUIYXokvhFC8tjizfJlZ/z/KKcHXQ
         aqlYVFJzgxN1C9OR2x0MGZUrfhajN+O9RRzmEkyG/8ETRZE8klz2E1lF+pBWjiyqFMlG
         sW34ZtTk0oxzLwlmUSp1P4ovJo6BLvNPtajcGai4PvIt34xbCHCBuM8G/7KTkcJUlLtF
         ZVXLf/WsHeTX5ITx4CMJDhXpPa8zcQcD6dtl52Qs4+Gvq77wdnmWtpRRYGtnQpvSmOgo
         TItGBrHoHQJRFHWkEiSeM0pbIw7RBnmM+NBeoS2XRcPQmtFeLDxTKf2dDconZt2D16Km
         8bag==
X-Gm-Message-State: AFqh2kpQH2lXsZJr38iU0Ens1oqfUPcmx4iDlWhZufq1u5+gYu/oI3G7
        9m5NjmBZ6RV5wQbY16thzVBlutNHk2Q=
X-Google-Smtp-Source: AMrXdXsyk2aWDLifDWvGx4eNtVdvR0lk0UuGc41MMF+rraQGcCpiv31pKMzdVtAa7YmV9wo8uuvfgA==
X-Received: by 2002:a5d:5642:0:b0:242:5728:8f2b with SMTP id j2-20020a5d5642000000b0024257288f2bmr10651634wrw.44.1671987361362;
        Sun, 25 Dec 2022 08:56:01 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b002422bc69111sm9875243wro.9.2022.12.25.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:56:01 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Add support for pressure sensor Bosch BMP580
Date:   Sun, 25 Dec 2022 17:55:28 +0100
Message-Id: <cover.1671986815.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
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

This patchset adds support for the new pressure sensors BMP580 extending
the bmp280 driver.

Patch 1 introduces a variant enumeration and refactors sensor verification
logic adding a chip_id field to the chip_info struct. This change is
required because BMP380 and BMP580 have the same chip_id and values would
collide using the chip_id as the driver_data value.
Patch 2 introduces new preinit callback and unifies init logic across all
supported variants.
Patch 3 adds the logic to read measurements and configure operations params
of the BMP580 pressure sensor.
Patch 4 updates the devicetree binding docs with the new sensor id
Patch 5 adds the NVMEM operations to read and program the NVM user range
contained in the non-volatile memory of the BMP580 sensors.

Angel Iglesias (5):
  iio: pressure: bmp280: Add enumeration to handle chip variants
  iio: pressure: bmp280: Add preinit callback
  iio: pressure: bmp280: Add support for new sensor BMP580
  dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
  iio: pressure: bmp280: Add nvmem operations for BMP580

 .../bindings/iio/pressure/bmp085.yaml         |   2 +
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 617 +++++++++++++++++-
 drivers/iio/pressure/bmp280-i2c.c             |  33 +-
 drivers/iio/pressure/bmp280-regmap.c          |  60 ++
 drivers/iio/pressure/bmp280-spi.c             |  23 +-
 drivers/iio/pressure/bmp280.h                 | 115 ++++
 7 files changed, 815 insertions(+), 41 deletions(-)


base-commit: e807541c2b273677e82ef50b5747ec7ae7d652b9
-- 
2.39.0

