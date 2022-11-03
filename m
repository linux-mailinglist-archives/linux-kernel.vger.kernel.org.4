Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98BF617A29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKCJoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:44:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87347DFFE;
        Thu,  3 Nov 2022 02:44:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so3727707ejr.2;
        Thu, 03 Nov 2022 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuqkrLTytBY0zJgq9oR0Y8x55rikGLMvFyeibYwb2mw=;
        b=lrchAMHbp9fzzf/Qa0/T7F3lRe+phpqDcOrhIcUWNjcSOeldWmTcC0AQhE93h3VepR
         Zhudtj9QoTLvRWnP6Yyci180kAL6uQ7hcgwtuzywRY4Wd5AeeE4j8Qxj8quiPSSkAoIT
         CSgEpjYMuSTcFFpDvP25U4QcXRwyQIOl9pFOJHl3IXKQWf60qNxzOC/d4Lh0Uv0lT3CO
         fKxOYmH/39hCPy9pZTf7PMunRaHmPi+ITWbCoo9B2fiVfIsDTaGi77lLLg3ZV1Mig2NQ
         6g0rm9OP4Q6xj5uK4wrLHV/y8nHYLNxrMc2EfTkeDf5tBk4G2xgY2xO8fkcWYa3t7SYd
         XM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuqkrLTytBY0zJgq9oR0Y8x55rikGLMvFyeibYwb2mw=;
        b=Xf/yERmFJbXV4iBy2LmqQBece375GLeRWkUIKl2U+DgnkzLelGaRJT6B2Q0OSATCPT
         vu0Ji4UuKwa2ZBGzvQOgGrfTuiH/INf+4F4Uau2HTktkeTo2onxBsTVZ+1Ia5VaplbW0
         vo6222YHe+Pk1Yc92tH5dWbKnWkWpOt/G6YIPvW6h0TPLDt0LJEKPDF4RvawNvED6gVI
         w0GICnBGWWGWn/vjf7k8Z8zb5+yv1oLvIx5sK2pr/lYTiZQnYePJPBxtHBdX4qrl1mqZ
         MUbGAYSVEuUlrG+a2v1qCEBOXcaOjzdeLdInhIil2Qc/K/tWuY+rYbSgF99BwbhcQgDd
         A9DQ==
X-Gm-Message-State: ACrzQf3QIjUjg5cJ5eUbuHcNf0DE2XNPMEO/Y9X8E+udkng+DZXbZGht
        l49r/YR+uGEfPRnc6VT4pIc=
X-Google-Smtp-Source: AMsMyM5txx7kE0bRIzxoPan1JVazHqsP7V2lUgzuibp9WSTjSE3zFNXx1LEhbC4VenbveX53kQyflA==
X-Received: by 2002:a17:906:cc47:b0:7ad:d0de:3ce1 with SMTP id mm7-20020a170906cc4700b007add0de3ce1mr20376947ejb.329.1667468689994;
        Thu, 03 Nov 2022 02:44:49 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906538e00b00788c820e630sm269688ejo.121.2022.11.03.02.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:44:49 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v2 0/2] AD74115
Date:   Thu,  3 Nov 2022 11:44:34 +0200
Message-Id: <20221103094436.2136698-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD74115H is a single-channel, software-configurable, input and
output device for industrial control applications. The AD74115H
provides a wide range of use cases, integrated on a single chip.

These use cases include analog output, analog input, digital output,
digital input, resistance temperature detector (RTD), and thermocouple
measurement capability. The AD74115H also has an integrated HART modem.

A serial peripheral interface (SPI) is used to handle all communications
to the device, including communications with the HART modem. The digital
input and digital outputs can be accessed via the SPI or the
general-purpose input and output (GPIO) pins to support higher
speed data rates.

The device features a 16-bit, sigma-delta analog-to-digital converter
(ADC) and a 14-bit digital-to-analog converter (DAC).
The AD74115H contains a high accuracy 2.5 V on-chip reference that can
be used as the DAC and ADC reference.

V1 -> V2:
 * dt-bindings: add spi peripheral allOf
 * dt-bindings: remove cs-gpios
 * dt-bindings: remove refin supply from example
 * dt-bindings: remove status
 * sort includes
 * ad74115_parse_fw_prop -> ad74115_apply_fw_prop
 * ad74115_setup_{comp,}_gc -> ad74115_setup_{comp,}_gpio_chip
 * gpiod_get_optional -> devm_gpiod_get_optional
 * add support for reset-gpios
 * add support for running without an interrupt
 * fix comma after terminating member
 * fix order of rate and range masks
 * fix reset pin wait time and out of reset time
 * fix rtd mode reading
 * pass chan spec only where needed
 * remove -en suffix
 * remove default 0 values
 * remove diag support
 * remove unecessary prop storage
 * reorder switch cases to match enum
 * set burnout enable bit based on burnout current
 * set default value for props
 * simplify dac hart slew usage
 * simplify prop value validation
 * use bool for 4 wire rtd mode
 * use bool for burnout current polarity
 * use bool for dac sc current limit
 * use bool for debounce mode
 * use bool for din sink range
 * use bool for din threshold mode
 * use devm_regulator_bulk_get_enable
 * use IIO_VAL_FRACTIONAL for resistance offset
 * use struct assignment for gpiochip
 * warn on empty prop mask

Cosmin Tanislav (2):
  dt-bindings: iio: addac: add AD74115
  iio: addac: add AD74115 driver

 .../bindings/iio/addac/adi,ad74115.yaml       |  370 ++++
 MAINTAINERS                                   |    8 +
 drivers/iio/addac/Kconfig                     |   14 +
 drivers/iio/addac/Makefile                    |    1 +
 drivers/iio/addac/ad74115.c                   | 1901 +++++++++++++++++
 5 files changed, 2294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 create mode 100644 drivers/iio/addac/ad74115.c

-- 
2.38.1

