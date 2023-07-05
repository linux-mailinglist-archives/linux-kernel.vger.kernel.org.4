Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFD748AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjGERrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjGERq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:46:57 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAB18E;
        Wed,  5 Jul 2023 10:46:55 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-783549ef058so322844939f.2;
        Wed, 05 Jul 2023 10:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688579215; x=1691171215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BPKw1fgvoqcgb7LOTZbCw+b3XPpLnIAGkcuOY8+t6M=;
        b=WPuEnMo4mDQZsCc575NVN+q4+K2fHKE41LlJl5rw3aQgaWInRNpt2agUSFMm7Brq0U
         YGC6o0d01U5t6TBvTsDnIGyJkCZe9yTCr+oEHrz2wKr6RIhYFuOw6MFISAJEDTaM+L3J
         XG49PQFuANSdCKPW8C45QaAcw5dQuzc+5LU+3eKD3hRSNDqdJAz+uDeTQlQR0he3k3Cm
         tkO25iK+O0Nn1lArtcHtTz9q3egsJD8igvoCEl6VpdJaEXqhmjPlUewgyPy8Z2bTN7j1
         5WYZAjqR+00IkaEOTTyObfDDo8q0yGH0cHNoR7uwYIEPMNpMEuX9IvsAVBl14aZRjpFA
         2SfQ==
X-Gm-Message-State: AC+VfDzRDXxoTmWj5ilIbiVk0Uhbti06UDVrfq40P3rmArpMoSppDoBG
        ZAYkQNBXWxzNjeKtB2QBdw==
X-Google-Smtp-Source: ACHHUZ6h9L57pYKCTfEUv5ZD9+83UQnqH5g92h5DJquZ8TzckmjiP98XIO8kLy2+W89cZYfeCJim6g==
X-Received: by 2002:a05:6602:19d1:b0:786:2498:40f0 with SMTP id ba17-20020a05660219d100b00786249840f0mr19797877iob.10.1688579214796;
        Wed, 05 Jul 2023 10:46:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p3-20020a02b383000000b0042b17c66fe4sm4095090jan.6.2023.07.05.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:46:54 -0700 (PDT)
Received: (nullmailer pid 1268296 invoked by uid 1000);
        Wed, 05 Jul 2023 17:46:52 -0000
Date:   Wed, 5 Jul 2023 11:46:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL] Devicetree updates for v6.5, part 2
Message-ID: <20230705174652.GA1203382-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few more DT updates. It's mostly things that fell thru the 
cracks. Not sure what happened, but seems no watchdog changes got queued 
up for this cycle.

Rob


The following changes since commit ecdb004843ed91222be38ed838e7ce7167018222:

  dt-bindings: interrupt-controller: add Ralink SoCs interrupt controller (2023-06-27 08:14:38 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.5-2

for you to fetch changes up to 31e9f406efae513156c129e9f7ad16b9f0ec7a65:

  dt-bindings: soc: qcom: stats: Update maintainer email (2023-07-05 09:54:53 -0600)

----------------------------------------------------------------
Devicetree updates for v6.5, part 2:

- Whitespace clean-ups in binding examples

- Restrict node name suffixes to "-[0-9]+" for cases of multiple
  instances which don't have unit-addresses

- Convert brcm,kona-wdt and cdns,wdt-r1p2 watchdog bindings to DT schema

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      dt-bindings: watchdog: restrict node name suffixes
      dt-bindings: slimbus: restrict node name suffixes
      dt-bindings: timestamp: restrict node name suffixes
      dt-bindings: cleanup DTS example whitespaces

Maulik Shah (1):
      dt-bindings: soc: qcom: stats: Update maintainer email

Nikita Bondarenko (1):
      dt-bindings: watchdog: brcm,kona-wdt: convert txt file to yaml

Srinivas Neeli (1):
      dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence watchdog to yaml

 .../devicetree/bindings/arm/arm,coresight-cti.yaml | 18 +++----
 .../devicetree/bindings/arm/keystone/ti,sci.yaml   |  8 +--
 .../devicetree/bindings/display/msm/gmu.yaml       |  2 +-
 .../bindings/display/panel/samsung,s6e8aa0.yaml    |  2 +-
 .../bindings/display/rockchip/rockchip-vop.yaml    |  4 +-
 .../devicetree/bindings/iio/adc/ti,adc108s102.yaml |  2 +-
 .../bindings/media/renesas,rzg2l-cru.yaml          |  4 +-
 .../devicetree/bindings/media/renesas,vin.yaml     |  4 +-
 .../devicetree/bindings/mtd/mtd-physmap.yaml       |  2 +-
 .../devicetree/bindings/net/mediatek-dwmac.yaml    |  2 +-
 .../bindings/perf/amlogic,g12-ddr-pmu.yaml         |  4 +-
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |  2 +-
 .../remoteproc/amlogic,meson-mx-ao-arc.yaml        |  2 +-
 .../devicetree/bindings/slimbus/slimbus.yaml       |  2 +-
 .../devicetree/bindings/soc/qcom/qcom-stats.yaml   |  2 +-
 .../timestamp/hardware-timestamps-common.yaml      |  2 +-
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |  2 +-
 .../devicetree/bindings/usb/ti,am62-usb.yaml       |  2 +-
 .../devicetree/bindings/watchdog/brcm,kona-wdt.txt | 15 ------
 .../bindings/watchdog/brcm,kona-wdt.yaml           | 41 ++++++++++++++
 .../devicetree/bindings/watchdog/cadence-wdt.txt   | 23 --------
 .../bindings/watchdog/cdns,wdt-r1p2.yaml           | 62 ++++++++++++++++++++++
 .../devicetree/bindings/watchdog/watchdog.yaml     |  4 +-
 23 files changed, 138 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml
