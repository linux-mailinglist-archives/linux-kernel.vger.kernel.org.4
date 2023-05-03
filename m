Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68A6F59EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjECOZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjECOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:25:52 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A3E9B;
        Wed,  3 May 2023 07:25:51 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-95227e5164dso148574766b.1;
        Wed, 03 May 2023 07:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123949; x=1685715949;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIP7Bnp4xK0LFUf9sFfF4T86SZTayeCYfaCUxKklfzk=;
        b=iJ89LdS9fTiMTNBksYoA5rpvX92xIhKSnznfMquDhoyde4WQ8nztuu4WmTw7PdLj2v
         9mJ6QwmGSd7O+6nEgOeZAh4TN2bQSL+qpgluJT7gLdcposfxrpzBNNFwR7liy6/+RzSq
         4V/+sM4ajyetfoaSuPUEUCoijWdgU27PnNFkBpM6cAzhvRc7tPx2P895et2jNtJY/GW2
         HiQJVmlwtpBDPmGx5LWdMynCQNBfU6mDGbvZYX03ONNs4NxWfbsqtNvtuGh4WfoHYJ3n
         ar+fRogzw4U567UN8aOfT7nyNOMGeo60GkShVJJnnxP3LjOGxrk/CRBaw/S1Z7U84fsu
         q3Cg==
X-Gm-Message-State: AC+VfDwAKjBYWovDtC87ElQfiRRuBiJ43Jnk1CTblwVi7jWOo8dNfuL9
        NI+5WfvJ64z9n3hOVSwthF24bLN5tBlhxOsTspX37TrAmXU=
X-Google-Smtp-Source: ACHHUZ52qffEbYqlPr1CeP1L0eu02iInuR0otx0ELGAqSWtsR6xIypgcQlzb265c2fKzdCFsIlsws04xQp4cdLsxJkw=
X-Received: by 2002:a17:906:64db:b0:94f:4122:28f5 with SMTP id
 p27-20020a17090664db00b0094f412228f5mr5009455ejn.2.1683123949504; Wed, 03 May
 2023 07:25:49 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 May 2023 16:25:38 +0200
Message-ID: <CAJZ5v0hv3CrvnrY=7NrpxMeUyoupB43Bu2Cv_4CD7asPFTU-cw@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.4-rc1-2

with top-most commit 53389edd4020514b876b01d05e851fb7d46eb51f

 Merge branch 'thermal-core'

on top of commit 5e0ca0bfc33b7196ae3a5cbe26289a4025618f5a

 Merge tag 'thermal-6.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.4-rc1.

These are mostly cleanups on top of the previously merged thermal
control changes plus some driver fixes and the removal of the Intel
Menlow thermal driver.

Specifics:

 - Add compatible DT bindings for imx6sll and imx6ul to fix a dtbs check
   warning (Stefan Wahren).

 - Update the example in the DT bindings to reflect changes with the
   ADC node name for QCom TM and TM5 (Marijn Suijten).

 - Fix comments for the cpuidle_cooling_register() function to match the
   function prototype (Chenggang Wang).

 - Fix inconsistent temperature read and some Mediatek variant board
   reboot by reverting a change and handling the temperature
   differently (AngeloGioacchino Del Regno).

 - Fix a memory leak in the initialization error path for the Mediatek
   driver (Kang Chen).

 - Use of_address_to_resource() in the Mediatek driver (Rob Herring).

 - Fix unit address in the QCom tsens driver DT bindings (Krzysztof
   Kozlowski).

 - Clean up the step-wise thermal governor (Zhang Rui).

 - Introduce thermal_zone_device() for accessing the device field of
   struct thermal_zone_device and two drivers use it (Daniel Lezcano).

 - Clean up the ACPI thermal driver a bit (Daniel Lezcano).

 - Delete the thermal driver for Intel Menlow platforms that is not
   expected to have any users (Rafael Wysocki).

Thanks!


---------------

AngeloGioacchino Del Regno (2):
      Revert "thermal/drivers/mediatek: Add delay after thermal banks
initialization"
      thermal/drivers/mediatek: Add temperature constraints to validate read

Chenggang Wang (1):
      thermal/drivers/cpuidle_cooling: Delete unmatched comments

Daniel Lezcano (4):
      thermal: core: Encapsulate tz->device field
      thermal: intel: pch_thermal: Use thermal driver device to write a trace
      ACPI: thermal: Use thermal_zone_device()
      ACPI: thermal: Move to dedicated function sysfs extra attr creation

Kang Chen (2):
      thermal/drivers/mediatek: Use devm_of_iomap to avoid resource
leak in mtk_thermal_probe
      thermal/drivers/mediatek: Change clk_prepare_enable to
devm_clk_get_enabled in mtk_thermal_probe

Krzysztof Kozlowski (1):
      dt-bindings: thermal: qcom-tsens: Correct unit address

Marijn Suijten (1):
      dt-bindings: thermal: Use generic ADC node name in examples

Rafael J. Wysocki (1):
      thermal: intel: menlow: Get rid of this driver

Rob Herring (1):
      thermal/drivers/mediatek: Use of_address_to_resource()

Stefan Wahren (1):
      dt-bindings: imx-thermal: Add imx6sll and imx6ul compatible

Zhang Rui (2):
      thermal: gov_step_wise: Delete obsolete comment
      thermal: gov_step_wise: Adjust code logic to match comment

---------------

 .../devicetree/bindings/thermal/imx-thermal.yaml   |  14 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   4 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   9 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   4 +-
 drivers/acpi/thermal.c                             |  45 +-
 drivers/thermal/cpuidle_cooling.c                  |   3 -
 drivers/thermal/gov_step_wise.c                    |  28 +-
 drivers/thermal/intel/Kconfig                      |   9 -
 drivers/thermal/intel/Makefile                     |   1 -
 drivers/thermal/intel/intel_menlow.c               | 521 ---------------------
 drivers/thermal/intel/intel_pch_thermal.c          |   3 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |  89 ++--
 drivers/thermal/thermal_core.c                     |   6 +
 include/linux/thermal.h                            |   1 +
 14 files changed, 110 insertions(+), 627 deletions(-)
