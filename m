Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8C772FE53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbjFNMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbjFNMTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:19:47 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E29391FF5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:19:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8CxOupbsIlk2h8FAA--.11096S3;
        Wed, 14 Jun 2023 20:19:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMpasIlkRJgaAA--.1367S4;
        Wed, 14 Jun 2023 20:19:38 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn, mengyingkun@loongson.cn
Subject: [PATCH v3 0/3] Add Loongson I2S controller support
Date:   Wed, 14 Jun 2023 20:18:37 +0800
Message-Id: <20230614121837.3402734-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPMpasIlkRJgaAA--.1367S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQACDGSIXIIYSwAIsm
X-Coremail-Antispam: 1Uk129KBj93XoWxuF48Jw4fWr43urWUGrWDZFc_yoW5Xw17pa
        nxC393Wr45tr1ayFn3AFy8GFWrAryrCrsxGa17Xw1UGr9Fy3W8u343tF1UZFW3Ary8Jryq
        9ryrGrW8G3ZxG3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
        JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxU466zUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds support for Loongson I2S controller, and
introduce a ASoC machine driver for loongson platform.

The Loongson I2S controller is available on Loongson
7a2000/2k2000 chips, works as a PCI device. It has two
private DMA controllers used to playback and capture.
Each DMA controller has one channel.

The ASoC machine driver adds support for audio device which
using loongson I2S controller to tranfser the audio data.
The audio device uses "PRP0001" as its ACPI device ID, which
provides a means to use the existing DT-compatible device
identification in ACPI.


Thanks.

---
Changes v2 -> v3
  - Patch 1
    Split the driver into PCI driver and component driver.
    Move interrupt requesting from pcm_open to pcm_create.
    Use pcim_xxx() API to get iomap of I2S register.
    Add condition checking for the number of periods.
    Add set_fmt() callback for DAI ops.
    Add volatile registers for regmap of I2S.
    Remove redundant condition checking.
    Update comment style.

  - Patch 2
    Remove redundant SoC DAI link.
    Update comment style.

  - Patch 3
    No change.


Changes v1 -> v2
  - Patch 1
    Replace pci_xxx() APIs with pcim_xxx() APIs.
    Fix build errors from lkp@intel.com.
    Minor changes in log printing.

  - Patch 2
    Use ACPI bindings to reference I2S and codec nodes.
    
  - Patch 3
    Add chip model restriction for title and description.
    Add 'required' option for sound-dai property.

Yingkun Meng (3):
  ASoC: Add support for Loongson I2S controller
  ASoC: loongson: Add Loongson ASoC Sound Card Support
  ASoC: dt-bindings: Add support for Loongson audio card

 .../sound/loongson,ls-audio-card.yaml         |  70 ++++
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/loongson/Kconfig                    |  26 ++
 sound/soc/loongson/Makefile                   |   8 +
 sound/soc/loongson/loongson_card.c            | 230 ++++++++++++
 sound/soc/loongson/loongson_dma.c             | 350 ++++++++++++++++++
 sound/soc/loongson/loongson_dma.h             |  16 +
 sound/soc/loongson/loongson_i2s.c             | 269 ++++++++++++++
 sound/soc/loongson/loongson_i2s.h             |  71 ++++
 sound/soc/loongson/loongson_i2s_pci.c         | 171 +++++++++
 11 files changed, 1213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
 create mode 100644 sound/soc/loongson/Kconfig
 create mode 100644 sound/soc/loongson/Makefile
 create mode 100644 sound/soc/loongson/loongson_card.c
 create mode 100644 sound/soc/loongson/loongson_dma.c
 create mode 100644 sound/soc/loongson/loongson_dma.h
 create mode 100644 sound/soc/loongson/loongson_i2s.c
 create mode 100644 sound/soc/loongson/loongson_i2s.h
 create mode 100644 sound/soc/loongson/loongson_i2s_pci.c


base-commit: a11e6515b019da62266b731ff20bc6863f00df4d
-- 
2.33.0

