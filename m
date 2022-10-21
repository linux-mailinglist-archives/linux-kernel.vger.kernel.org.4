Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CE60752D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJUKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:41:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F725E0AD;
        Fri, 21 Oct 2022 03:41:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q19so4166349edd.10;
        Fri, 21 Oct 2022 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjxcafGWrauqZd0fEmIdtp/vqvcHr+/qDD5jFBmpYSk=;
        b=IfHdA4TUmIXeow9zPub6tVQE4cDw6PmQosjAFF5fZrhDFvTpiq6VpPqyQll92MBbih
         ZKiZ6Yc+NvX6NuNzXfgo3kGOFvciBht2dzWXJh/S7p9IBkd9Zm0tjp62TqCUr9HxgF+x
         awme+2dfKXhgVngTJctj+bFwq2BF8pwG0HZfkQL8PY2njyENGnP9wsfCeBFZWjRnkaLH
         8JOURCX8Txk59mnM6XFMMsUiTgafJoThSjcXi7KkD+XRU4sRq82gNcKpLXeMWGQN3c8G
         2wGBWlnk6znzHMnEqncMkCWlaNBy9g1+hjAqrsyw9yvL6RS0qOhlM/XvR8MP7FsJRFJq
         8kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjxcafGWrauqZd0fEmIdtp/vqvcHr+/qDD5jFBmpYSk=;
        b=orLBPC6iignJd8+/vF3EEYFoNEsEoZkFHNoKz/dmQJxFp2ydhHVsfGIuVwPVcaSH7T
         9LXG77CIM02F73pNUsBcrfwDYfBq9XupZyiOO7DODrk2NyPeM5L+UgbinzE3Rs4cs0CM
         BsYHT63BndNKFrclraAAHSgshQ8TaBsezUSV1l/OnbvnippSWHoYkmP0ZVqzu63aQXuX
         c5PsMLCFGWeQklGUOOmMMCkjcPRXGAy9/FVvj3rWZEGZpJAORQt7cqpk0KlrZrwi0nUj
         RDv09xHMzHMFfHrFVVF2NncGpE+Fnb22DKzv7lAHN1mI0jF1DbSiGaXyWGjSuLQJnY8g
         8PqQ==
X-Gm-Message-State: ACrzQf0IB1XiUhc/fHgIpcFP7XagSK/ewGf3NP1sdzZMJh9oQoEFCI3+
        7Kpue0kcpW17J5YbHqmux+w=
X-Google-Smtp-Source: AMsMyM6GKdDIRzcJy+S4gbRYClIguBKeFcEewmEAZyku/eQNwbkm7/AQMqMt7r1gCZnM2aCnQkc+5w==
X-Received: by 2002:a17:907:75c4:b0:78e:176e:f62e with SMTP id jl4-20020a17090775c400b0078e176ef62emr14908847ejc.736.1666348885481;
        Fri, 21 Oct 2022 03:41:25 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id da3-20020a056402176300b004615bea1d5bsm121290edb.35.2022.10.21.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:41:25 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v10 0/2] AD4130
Date:   Fri, 21 Oct 2022 13:41:13 +0300
Message-Id: <20221021104115.1812486-1-demonsingur@gmail.com>
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

AD4130-8 is an ultra-low power, high precision, measurement solution for
low bandwidth battery operated applications.

The fully integrated AFE (Analog Front-End) includes a multiplexer for up
to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
selectable filter options, smart sequencer, sensor biasing and excitation
options, diagnostics, and a FIFO buffer.

V1 -> V2
 * add kernel version to ABI file
 * merge ABI patch into driver patch
 * make copyright header similar to other drivers
 * rearrange includes
 * use units.h defines where possible and add unit sufix to
   SOFT_RESET_SLEEP define
 * remove ending comma to last members of enums / lists
 * remove unused FILTER_MAX define
 * use BIT macro for PIN_FN_*
 * rearrange SETUP_SIZE definition
 * group bools in ad4130_state and ad4130_chan_info
 * put scale_tbls definition on one line
 * remove newline before reg size == 0 check
 * put mask used as value in a variable
 * remove useless ret = 0 assignment
 * make buffer attrs oneline
 * use for_each_set_bit in update_scan_mode
 * use if else for internal reference voltage error checking
 * inline reference voltage check
 * check number of vbias pins
 * remove .has_int_pin = false
 * remove avail_len for IIO_AVAIL_RANGE
 * remove useless enabled_channels check in unlink_slot
 * remove unused AD4130_RESET_CLK_COUNT define
 * only call fwnode_handle_put for child in case of error
 * default adi,reference-select to REFIN1
 * default adi,int-ref-en to false
 * of_irq_get_byname -> fwnode_irq_get_byname
 * P1 -> P2 as interrupt pin options
 * add missing comma in db3_freq_avail init
 * cast values to u64 to make math using units.h work
 * add datasheet reference to IRQ polarity
 * add comment about disabling channels in predisable
 * add part number prefix find_table_index
 * return voltage from get_ref_voltage
 * add datasheet reference for internal reference voltage selection
 * add comment explaining AIN and GPIO pin sharing
 * parse channel setup before parsing excitation pins
 * only validate excitation pin if value is not off
 * use FIELD_PREP for bipolar and int_ref_en
 * put devm_regmap_init call on one line
 * introduce a slot_info struct to contain setup_info for each slot
 * enable internal reference automatically if needed
 * decide mclk sel based on adi,ext-clk-freq and adi,int-clk-out
 * dt-bindings: use internal reference explicitly
 * dt-bindings: set type for adi,excitation-pin-0
 * dt-bindings: set $ref for adi,vbias-pins
 * dt-bindings: remove minItems from interrupts property
 * dt-bindings: remove adi,int-ref-en default value
 * dt-bindings: remove adi,bipolar default value
 * dt-bindings: inline adi,int-ref-en description
 * dt-bindings: default adi,reference-select to REFIN1
 * dt-bindings: clean up description for diff-channels and
   adi,reference-select
 * dt-bindings: add more text to interrupt-names description
 * dt-bindings: turn interrupt-names into a single string
 * dt-bindings: add maxItems to adi,vbias-pins

V2 -> V3
 * dt-bindings: add interrupt controller include to example
 * dt-bindings: remove $ref in diff-channels

V3 -> V4:
  * handle watermark value as number of datum
  * DOUT_OR_INT -> INT
  * AD4130_8_NAME -> AD4130_NAME
  * return early in case of failure when parsing fw channel
  * use IIO_DMA_MINALIGN for aligning buffer
  * add comments for fs_to_freq and freq_to_fs
  * remove support for other variants because of unavailability of model
    ids for future chip variants
  * remove support for db3 frequency because of inaccuracy when calculating
  * remove ternary where possible
  * refactor defines
  * dt-bindings: add unevaluatedProperties: true to channel node

V4 -> V5:
 * simplify get_ref_voltage function and move print statement to first user
 * inline statements not going over the 80 cols limit
 * simplify scale table filling
 * determine table length inside find table index macro
 * current_na -> tmp inside ad4130_parse_fw_setup
 * define full register set
 * put range register size definitions on one line
 * nanoamps -> nanoamp
 * adi,ext-clk-freq -> adi,ext-clk-freq-hz
 * return directly in ad4130_validate_vbias_pins
 * place comment regarding irq_trigger at assignment
 * inversed -> inverted inside irq_trigger comment
 * do not initialize int_clk_out
 * return directly in ad4130_validate_diff_channels
 * add () after reference to update_scan_mode in comment
 * use BIT() for channel offset
 * comment nitpicks on slot finding
 * return -EINVAL out of reg read for invalid sizes
 * place regmap at start of ad4130_state
 * place bools at the end of ad4130_setup_info
 * remove commas after terminators
 * dt-bindings: only allow one element in reg
 * dt-bindings: inline reg description
 * dt-bindings: remove $ref from adi,ext-clk-freq-hz

V5 -> V6:
 * bump KernelVersion
 * use IIO_DEVICE_ATTR_RO
 * nitpick inside mutex comment
 * use valid_mask for validating gpios
 * improve DMA comment

V6 -> V7:
 * remove $ref from -nanoamp properties (to be added to dtschema)
 * use hexadecimal numbers for channel unit-addresses

V7 -> V8:
 * pick up Reviewed-By tags
 * bump KernelVersion

V8 -> V9:
 * bump KernelVersion
 * enable internal clock output via CCF
 * remove unused AD4130_MCLK_SEL_MAX
 * remove unused AD4130_STATUS_POR_FLAG_MASK
 * remove unused ad4130_id
 * remove double new line

V9 -> V10:
 * Fix unsafe buffer attributes
 * fix KernelVersion indent
 * bump KernelVersion
 * handle null of_node
 * depend on COMMON_CLK
 * dt-bindings: make sure minItems is not equal to maxItems
 * dt-bindings: add clock provider properties
 * add ABI to MAINTAINERS

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  259 ++
 MAINTAINERS                                   |    9 +
 drivers/iio/adc/Kconfig                       |   14 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2100 +++++++++++++++++
 6 files changed, 2419 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.38.1

