Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312576F4847
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjEBQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjEBQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A0198C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9471E61E72
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5372CC433D2;
        Tue,  2 May 2023 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044899;
        bh=ADhr+3T1qXNBf/zy8DWor3A+/0w9EcJfOw97xFX7B3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmIh6bkXYptSX+s4l+dOG28rlSMD4hWGHV8ZyRWHce9vnzowI78LVxWuUHkR44kCh
         oYgJ7ZcKpYwPVDSIsn+RgL5kX05wztY9Enqq5UWcJAxBUqHqxtuu8o/kirdktcErCy
         bRL+fq2lmPZGoSAipWOMHarNk11Z9j3TqJTd93VGBQpNCCVEdzIWTubnX3POisabl/
         pTcsnswtWz2BaSNCWwDDdRW4dt5c294ZWqNRUgVDixTj3gBoSJoIEpaF+xlma8NJM5
         pWf+EY6/xVkiqmlNVlyyLtV1QslZGxAlPv7hKojaAQUXLNPIE0spGbAMeQf5LaQfFH
         LplqFZL+yGQWw==
Date:   Tue, 2 May 2023 17:28:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] LEDs for v6.4
Message-ID: <20230502162815.GK620451@google.com>
References: <20230502162524.GJ620451@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502162524.GJ620451@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, this is obviously LEDs, not MFD - long day!

On Tue, 02 May 2023, Lee Jones wrote:

> Good afternoon Linus,
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.4
> 
> for you to fetch changes up to 8325642d2757eba80210dec727bb0bcffb837ff1:
> 
>   leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver (2023-04-27 17:42:33 +0100)
> 
> ----------------------------------------------------------------
>  - New Drivers
>    - Add support for MediaTek MT6370 LED Indicator
>    - Add support for MediaTek MT6370 Flashlight
>    - Add support for QCOM PMIC Flash
>    - Add support for Rohm BD2606MVV Charge Pump LED
> 
>  - New Device Support
>    - Add support for PMK8550 PWM to QCOM LPG
> 
>  - New Functionality
>    - Add support for high resolution PWM to QCOM LPG
> 
>  - Fix-ups
>    - Kconfig 'depends' and 'select' dependency changes
>    - Remove unused / irrelevant includes
>    - Remove unnecessary checks (already performed further into the call stack)
>    - Trivial: Fix commentary, simplify error messages
>    - Rid 'defined but not used' warnings
>    - Provide documentation
>    - Explicitly provide include files
> 
>  - Bug Fixes
>    - Mark GPIO LED as BROKEN
>    - Fix Kconfig entries
>    - Fix various Smatch staticify reports
>    - Fix error handling (or a lack there of)
> 
> ----------------------------------------------------------------
> Alexander Dahl (1):
>       docs: leds: ledtrig-oneshot: Fix spelling mistake
> 
> Andreas Kemnade (2):
>       dt-bindings: leds: Add ROHM BD2606MVV LED
>       leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver
> 
> Andy Shevchenko (2):
>       leds: lp8860: Remove unused of_gpio,h
>       leds: lp8860: Remove duplicate NULL checks for gpio_desc
> 
> Anjelique Melendez (3):
>       dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
>       leds: rgb: leds-qcom-lpg: Add support for high resolution PWM
>       leds: rgb: leds-qcom-lpg: Add support for PMK8550 PWM
> 
> Bagas Sanjaya (4):
>       Documentation: leds: Add MT6370 doc to the toctree
>       Documentation: leds: mt6370: Properly wrap hw_pattern chart
>       Documentation: leds: MT6370: Use bullet lists for timing variables
>       MAINTAINERS: Add entry for LED devices documentation
> 
> ChiYuan Huang (4):
>       leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support
>       leds: flash: mt6370: Add MediaTek MT6370 flashlight support
>       docs: leds: Add MT6370 RGB LED pattern document
>       leds: rgb: mt6370: Fix implicit declaration for FIELD_GET
> 
> Christophe JAILLET (1):
>       leds: pwm-multicolor: Simplify an error message
> 
> Fenglin Wu (2):
>       leds: flash: Add driver to support flash LED module in QCOM PMICs
>       dt-bindings: leds: Add QCOM flash LED controller
> 
> H. Nikolaus Schaller (1):
>       leds: tca6507: Fix error handling of using fwnode_property_read_string
> 
> Krzysztof Kozlowski (1):
>       leds: tlc591xx: Mark OF related data as maybe unused
> 
> Linus Walleij (1):
>       leds: Mark GPIO LED trigger broken
> 
> Luca Weiss (1):
>       dt-bindings: leds: spmi-flash-led: Add pm6150l compatible
> 
> Lukas Bulwahn (1):
>       leds: rgb: mt6370: Correct config name to select in LEDS_MT6370_RGB
> 
> Manivannan Sadhasivam (1):
>       dt-bindings: leds: Document commonly used LED triggers
> 
> Rafał Miłecki (1):
>       dt-bindings: leds: Add "usbport" trigger
> 
> Randy Dunlap (1):
>       leds: TI_LMU_COMMON: select REGMAP instead of depending on it
> 
> Thomas Weißschuh (1):
>       leds: Fix reference to led_set_brightness() in doc
> 
> Tom Rix (1):
>       leds: flash: Set variables mvflash_{3,4}ch_regs storage-class-specifier to static
> 
> Wadim Egorov (1):
>       dt-bindings: leds: Convert PCA9532 to dtschema
> 
>  Documentation/devicetree/bindings/leds/common.yaml |   35 +-
>  .../devicetree/bindings/leds/leds-pca9532.txt      |   49 -
>  .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |    1 +
>  .../devicetree/bindings/leds/nxp,pca953x.yaml      |   90 ++
>  .../bindings/leds/qcom,spmi-flash-led.yaml         |  117 +++
>  .../devicetree/bindings/leds/rohm,bd2606mvv.yaml   |   81 ++
>  Documentation/leds/index.rst                       |    1 +
>  Documentation/leds/leds-mt6370-rgb.rst             |   64 ++
>  Documentation/leds/ledtrig-oneshot.rst             |    2 +-
>  MAINTAINERS                                        |    1 +
>  drivers/leds/Kconfig                               |   16 +-
>  drivers/leds/Makefile                              |    1 +
>  drivers/leds/flash/Kconfig                         |   28 +
>  drivers/leds/flash/Makefile                        |    2 +
>  drivers/leds/flash/leds-mt6370-flash.c             |  573 +++++++++++
>  drivers/leds/flash/leds-qcom-flash.c               |  773 +++++++++++++++
>  drivers/leds/leds-bd2606mvv.c                      |  160 ++++
>  drivers/leds/leds-lp8860.c                         |   10 +-
>  drivers/leds/leds-tca6507.c                        |    5 +-
>  drivers/leds/leds-tlc591xx.c                       |    2 +-
>  drivers/leds/rgb/Kconfig                           |   13 +
>  drivers/leds/rgb/Makefile                          |    1 +
>  drivers/leds/rgb/leds-mt6370-rgb.c                 | 1011 ++++++++++++++++++++
>  drivers/leds/rgb/leds-pwm-multicolor.c             |    4 +-
>  drivers/leds/rgb/leds-qcom-lpg.c                   |  160 +++-
>  drivers/leds/trigger/Kconfig                       |    1 +
>  include/linux/leds.h                               |    2 +-
>  27 files changed, 3091 insertions(+), 112 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
>  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst
>  create mode 100644 drivers/leds/flash/leds-mt6370-flash.c
>  create mode 100644 drivers/leds/flash/leds-qcom-flash.c
>  create mode 100644 drivers/leds/leds-bd2606mvv.c
>  create mode 100644 drivers/leds/rgb/leds-mt6370-rgb.c
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
