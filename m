Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF26CBBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC1KIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjC1KH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:07:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CB476BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so15081485lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vihcq/k4IphXmmDPczsMKLScylUcV4iaLrrzgEXWQM=;
        b=ceiVM2AoRDGx9xcuj73XTgbvjrqa+G4s6+Cd7aMKBe6aIEeki+ZUuRJfg/AduOEnIC
         n2yL6Q7yXuKqOwECt2YcBdP6RQm67q7BqwTjLu+TrtXE1gSPqeg4gd+H3/uiUYYtwcab
         nba+0d2i+U7rlOrOW1w8X041d+bZWUVGAopUplWBWy1/1leW4+3iUnMpNww/iulgdTEU
         qrDsmtsgRyufIDEN5kuLu1AhnplWxoq+IPKLTmjJHuSB+u310rkDSoBVM9pHtoKbImuz
         /w6ZoC/DV5rrZ6lRWn9/FC5CCkcPilrA8XQD4De0KnUZD7e/o/azBcFE81mssR6RVqyB
         BTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Vihcq/k4IphXmmDPczsMKLScylUcV4iaLrrzgEXWQM=;
        b=6YgtIcKo1SLviGkizrdcTzidfFP33IKKw7P7lbjIVwDd6iwrFk87E0PB7JxdZX+5lb
         xbM6P8XVLl84s89AzMqZqtSpvHYtlYH7UEYzMk34hijr2+2XDa0peLsmebTcJhNrnvEA
         b7OafmCG9/Idy6m5Y5yppdoxjFcZv8FGslvAPn1mpffpqMyxbGOc8MJjP95lfv/zg5IC
         U8QoIq/NM87ZbZR8vS9gkhaCnf21RxevQ0BHz2bmk5ggBbCqODT0UaPmCSgEgcAvcHPw
         8ELLDAK89iDLuvOx0BdhsnbcaUs6acBA6KXqdgiyjWEUvveblRCy7L3bThm3MfjNG1r8
         6aYw==
X-Gm-Message-State: AAQBX9eFLya2hi2dQXT26i6KElHdT3GvHqwAgBEi5jBD+KlpLasVuoLf
        Qvuld/zgpz3W/vvA+QlIiUY/TA==
X-Google-Smtp-Source: AKy350YRIKQf6D9RKazZnx6FJqNfHtL58afqzqWIbaovg4t6Cacg/KFup73+AShC6U7eY3ANq25CXg==
X-Received: by 2002:a19:f501:0:b0:4ea:c83b:256e with SMTP id j1-20020a19f501000000b004eac83b256emr3762278lfb.32.1679998047315;
        Tue, 28 Mar 2023 03:07:27 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004db2ac3a522sm5039572lfp.62.2023.03.28.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:07:26 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/4] ARM: dts: at91: Set sst26vf064b SPI NOR flash at its maxumum frequency
Date:   Tue, 28 Mar 2023 10:07:19 +0000
Message-Id: <20230328100723.1593864-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nicolas!

I just compiled tested this with sama5_defconfig and at91_dt_defconfig.
Would you please do a simnple test on your side to make sure everything
is in place? A test on a single board would suffice
(maybe sama5d27-wlsom1-ek?):

#!/bin/sh

dd if=/dev/urandom of=./qspi_test bs=1M count=6
mtd_debug write /dev/mtd5 0 6291456 qspi_test
mtd_debug erase /dev/mtd5 0 6291456
mtd_debug read /dev/mtd5 0 6291456 qspi_read
hexdump qspi_read
mtd_debug write /dev/mtd5 0 6291456 qspi_test
mtd_debug read /dev/mtd5 0 6291456 qspi_read
sha1sum qspi_test qspi_read

Cheers,
ta

Changes in v2: update value of spi-cs-setup-ns as it was changed to u32
since the first proposal.
v1 at: https://lore.kernel.org/linux-mtd/20221117105249.115649-1-tudor.ambarus@microchip.com/

---
SPI NOR flashes have specific cs-setup time requirements without which
they can't work at frequencies close to their maximum supported frequency,
as they miss the first bits of the instruction command. Unrecognized
commands are ignored, thus the flash will be unresponsive. Introduce the
spi-cs-setup-ns property to allow spi devices to specify their cs setup
time.

Tudor Ambarus (4):
  ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its
    maximum frequency
  ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its
    maximum frequency

 arch/arm/boot/dts/at91-sam9x60ek.dts        | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 3 ++-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
 arch/arm/boot/dts/at91-sama5d2_icp.dts      | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

