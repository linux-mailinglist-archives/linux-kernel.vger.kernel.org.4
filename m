Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F4716382
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjE3ORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjE3ORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:17:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540011C;
        Tue, 30 May 2023 07:17:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso6669803a12.3;
        Tue, 30 May 2023 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456233; x=1688048233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GI3jhV+Vj7XpnF0lh8amuDJfzIo0HvGNKEWD6ZzT4hk=;
        b=InHsCi99/gMi1BBPKYIhmcEGOct3pxWnS2wKLY42I0CbMyqFx6ma+JjiZJ3QZB+iMZ
         Ds+CXOqrRnKCTP7WAhGCmL+xLS5Diu3AIoon10Q3uOBgjBNRYbqBy+xBgXpep4hXS8E4
         RtiGV1g5l0/tkM8rCp2TtmdP2PJ+F5urls5NAr8elczFfPnhHATqbpaTk3Z10gHKPttl
         5X/UUCB3YRQ1zp/Kw5FBqU12/muJuYEVTw4o8KwnhSQbT7HoqUCgNABXPYrzI5R4Laa2
         p+3zqcVmATGucC8RLZqdwA6KZJarDPF3nJOxGUlrzWhg8IXDoQZzdIqN7OyEhyOAT/sR
         /Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456233; x=1688048233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI3jhV+Vj7XpnF0lh8amuDJfzIo0HvGNKEWD6ZzT4hk=;
        b=cmEg8aLGOJr8ZshbEaiu2fl2/onr8W+fhyPS1BqAgkPwQ3B2Wo9Y2TIOkwwhj3gEAw
         t4yPpK+03NfEuWdlvHraCZzKy4LpLl97hNbht4eiTUWfiZCOqfALWwaYVICj+IFdMEQY
         vIPl3Cck0FpXESPLa/ohCJijUnuaemZBiTZ68uDNwQ8uU3d7d/5nFsMRvV6hSXspKLps
         XBmEPzU8Qe8gVTngCaK7XmLezGA00g5w4HnWRse7H9zWQ42ybmH/aVO8Fvn/FFI7P7dk
         XKHYuguKb4iJIGTSkglK1JGfLJYMZZ9UglnZz0vY2DPJGW6c/XU3Tb4DiBulc/WtbswT
         m47Q==
X-Gm-Message-State: AC+VfDx1WH3JZf4E7sMq8gR2IahkF1sN/aJUpPAQZfsbRa1vfXhe6P/g
        TF7tI0BFRqgJz2sMweiE4yg=
X-Google-Smtp-Source: ACHHUZ5htGFef6Q921aVNSnqK3yVVjnGL91bR0YghMLaO2Prvqo7GUT3xS6fLQnHhSCxy6YCop7OQg==
X-Received: by 2002:a17:906:fe48:b0:96f:4927:7a96 with SMTP id wz8-20020a170906fe4800b0096f49277a96mr2397732ejb.70.1685456232630;
        Tue, 30 May 2023 07:17:12 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900796a998533c043af.dip0.t-ipconnect.de. [2003:c7:8700:c900:796a:9985:33c0:43af])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b0094e96e46cc0sm7354359eje.69.2023.05.30.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:17:12 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Tue, 30 May 2023 16:16:36 +0200
Message-Id: <20230530141641.1155691-1-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

---

Link for versions:
  v1 and v2: https://lore.kernel.org/linux-spi/20230511135632.78344-1-bstruempfel@ultratronik.de/
  v3: https://lore.kernel.org/linux-spi/20230517103007.26287-1-boerge.struempfel@gmail.com/T/#t
  v4: https://lore.kernel.org/linux-spi/CAEktqctboF3=ykVNtPsifcmHzF6dWwoEcVh+O4H1u-R=TT6gHg@mail.gmail.com/T/#t
  v5: https://lore.kernel.org/linux-spi/20230520190856.34720-1-boerge.struempfel@gmail.com/T/#t
  v6: https://lore.kernel.org/linux-spi/20230524091948.41779-1-boerge.struempfel@gmail.com/T/#t

Changes from V6:
  - Adjusted the patches for next/master

Changes from V5:
  - Added a patch to reorder the command line options for
    spidev_test in order to increase usability. The indentation
    fixes were also done in this patch.

Changes from V4:
  - Added the SPI_3WIRE_HIZ mode bit to spidev
  - Added the SPI_MOSI_IDLE_LOW mode bit to the spidev_test
    userspace tool and added the two other missing spi mode
    bits (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) to it as well.

Changes from V3:
  - Added missing paranthesis which caused builderrors

Changes from V2:
  - Removed the device-tree binding since this should not be managed by
    the DT but by the device itself.
  - Replaced all occurences of spi->chip_select with the corresponding
    macro spi_get_chipselect(spi,0)

Changes from V1:
  - Added patch, introducing the new devicetree binding flag
  - Split the generic spi part of the patch from the imx-spi specific
    part
  - Replaced SPI_CPOL and SPI_CPHA by the combined SPI_MODE_X_MASK bit
    in the imx-spi.c modebits.
  - Added the SPI_MOSI_IDLE_LOW bit to spidev

Boerge Struempfel (5):
  spi: add SPI_MOSI_IDLE_LOW mode bit
  spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
  spi: spidev: add two new spi mode bits
  spi: spidev_test: Sorted the options into logical groups
  spi: spidev_test Add three missing spi mode bits

 drivers/spi/spi-imx.c        |   9 ++-
 drivers/spi/spidev.c         |   3 +-
 include/uapi/linux/spi/spi.h |   3 +-
 tools/spi/spidev_test.c      | 107 +++++++++++++++++++++--------------
 4 files changed, 76 insertions(+), 46 deletions(-)

-- 
2.40.1

