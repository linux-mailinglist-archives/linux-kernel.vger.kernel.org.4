Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F75F6960
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJFOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiJFOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:10:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F24AE862;
        Thu,  6 Oct 2022 07:08:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a13so3043661edj.0;
        Thu, 06 Oct 2022 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkO3k9R82gQbgYROlR+6Ut5bGkG/fl+3i1H1lOKlGzk=;
        b=eP/6wbAJe4WzXF8Ynwv3HtIbfzKPnnzuDzXLhxCFpe5TPGF+sq/bQZ88Psg3rvxkpn
         bjLphhG825hDatshoISg7zlFgTKIxnAhNv64DFIsqIN4LjbxxdpZ3wbE4pP5ejks4tX4
         85tc8fsGMLxfZJogLD2+Bme/ty0hDrr7cQA675tVzeg0vBoLYXZ1uzUlVKbpjNl4luQ/
         /Bx+5MhPaSrADC8GM/txdTV5sz4QUl51ZL44HI8zYpTQr0HG6csvjin2pOzFnv0oZP87
         TQzSktsRl91cmai9VguJqQbudEeUFa7RZL1K8zJn2yDoZjykX8SgOAR3cgEO+XZsPO2C
         qsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkO3k9R82gQbgYROlR+6Ut5bGkG/fl+3i1H1lOKlGzk=;
        b=wE6zlIwoFArY+X3rMvDFYkvJUpW189ctZkIa9IcNtUt1IyuuV3yF4/z3FqpT7Rv3iJ
         23+pTsuZHSmMPN9im3yosK5GWWOJG5WaIPCw2j6pOuFRJQJlOa704SAVX/nw/PVgRse9
         1Zgm1tsB0gv3NTLn2N8T8z4L322tBeXwK6hvpTGMD+E05yVYVkrNl76hu2UCJHgSkfpl
         18z40KiQfeAPg+qIoj3Ky5s1ZfGWcjTh8olcfs0/PK8eboY0K5br5arhajzWsN91hZRn
         Om3Yx2EPhSb65D4ykJvyfSgJSmEgkyckWQGHdrFD+5ntlyAqGdmVBqKephaJH3prLdu0
         +XHA==
X-Gm-Message-State: ACrzQf0EB2VLFBNg3BnN3JtqPgzQRs1mZoXlv1W2WFSpcdyasf8VLsTd
        PNgsb3vWxj4fWXHLIphj8Lw=
X-Google-Smtp-Source: AMsMyM51kPih2uZwa1n13R+JMrjcdJRrUXOsGbjpOxxBrYTzZ3AYJ+Wwf8lLYL9QRI8rAVWdSNOejQ==
X-Received: by 2002:a05:6402:1e8e:b0:459:f7cd:7c09 with SMTP id f14-20020a0564021e8e00b00459f7cd7c09mr1639252edf.405.1665065268286;
        Thu, 06 Oct 2022 07:07:48 -0700 (PDT)
Received: from demon-pc.localdomain ([86.123.72.23])
        by smtp.gmail.com with ESMTPSA id l3-20020a170906644300b0077a201f6d1esm10358210ejn.87.2022.10.06.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:47 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v9 0/2] AD4130
Date:   Thu,  6 Oct 2022 17:07:35 +0300
Message-Id: <20221006140737.12396-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.0
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

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  256 ++
 MAINTAINERS                                   |   17 +-
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2084 +++++++++++++++++
 6 files changed, 2398 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.38.0

