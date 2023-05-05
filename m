Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB396F83CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjEENUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjEENUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:20:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A72688;
        Fri,  5 May 2023 06:20:19 -0700 (PDT)
Received: from localhost ([31.220.113.235]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6KMR-1qJ7Bu324H-016cR9; Fri, 05 May 2023 15:19:59 +0200
Date:   Fri, 5 May 2023 15:19:59 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <ZFUCf059+PSR+3Wb@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:LvWwahpDxbW5ietDton1MeJ49tRciW1sgnT3RH04aGs3/1qpbKX
 eZBZd34zYne/ZVfSfg6QPVXmfqdBEqkhuZ2rvDSFdzgnp8XpxMB2BcAIquVJPhDs5eQqIyS
 U7zoINps68Fhft5D3djciOI2CIX37ihSe+r3lkUcHaIHtWQSF3HBiDjHgAPabDPzEmeNLct
 ocQCQ0T/fqVXejTPiHeVQ==
UI-OutboundReport: notjunk:1;M01:P0:TMie43ZwBSE=;ueCGyBUvD621qQ8q/ae9m/jhKK7
 r0QAp574iP8Pbpc3pnVlWtP3Eq8QHL8X5OE4eVUzAWdTLV2hEXnfFN2W85v57Vk10E0kv/gct
 eEKVft6teWgu/0NU6sokfXvw55h4rSYfepJB8yyQh0OoIx4rEfJvvzAY7lSGnQTbHcN5s4sys
 hQzdG0UP/ej/hlAr1ySeNKzVBGHVZcddIdMYyJ0kMNpQAO7PUfenFg5AUIe+apan3mIIXiNmT
 K2GZg/ZdtWHfW/+rmylUjTWVhmCNKEFofwjSTFb6fl5GoX1rnHN+iLgrQIZSvz5UjVvcrIpVG
 j7w/vehxVvh3LTqwmegVtxsgtAxJJp2PyiN391Li3rjPuf7N927dOH3Z/AgiFyn+eeHlR4mNU
 JpDD2tWypSZcLv5QHxdZLkd77TqmNEWivhpYzWsVDM4WuSO6z2qfjF4nqqPrZi7kTXISBAG8j
 ZeuCpWjF0OdM9uCP7+bc0cIeFwaWnpo7idiodJeo6uP2I/fYMHVc83hfXH2aFYE3GOCbLXzMZ
 B7GTvOYUWICj3TgKtQMdtqP20DjLTg+9NvNkMX9aWLtEVWVbQz5jXHQN6LlFN/gBiGNua1tW/
 HYZ2LSjLtTRJSXiKwbaAXE2L4tK6zbZFr9Tjs44TRy78t6VgQvArtlnjJrKhFKYX5dhnZAfkt
 Y3Hzmhal6/cNYN9f59eOkATAiuAAoSGsr5rP6VDJCw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Honeywell mprls0025pa pressure sensor.

This patch series adds support for Honeywell mprls0025pa pressure sensor series.
There are a variety of sensors with different pressure ranges supported.

Changes in v4:
- Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
  - change line length to 80 characters
  - make vdd-supply mandatory
- Patch 2: "iio: pressure: Honeywell mprls0025pa pressure sensor"
  - change line length to 80 characters
  - change regulator vcc to devm_regulator_get_enable()
  - switch to probe_new
  - many changes from the review
- Patch 3: "MAINTAINERS: Add Honeywell mprls0025pa sensor"
  - no changes

Changes in v3:
- Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
  - fix errors while doing dt_binding_check
  - add vdd-supply
- Patch 2: "iio: pressure: Honeywell mpr pressure sensor"
  - change to _RAW interface
  - add transfer function
  - add regulator
  - move to device_property_xxx functions
  - many more changes from the feedbacks
- Patch 3: "MAINTAINERS: Add Honeywell mpr sensor"
  - change file names

Changes in v2:
- Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
  - change the global sensor decription of mpr to the specific sensor
    mprls0025pa
  - change compatible string
  - rename the file to honeywell,mprls0025pa.yaml
  - honeywell,pmin-pascal and honeywell,pmax-pascal: add unit pascal to property
    names 
  - add new property honeywell,transfer-function
- Patch 2: "iio: pressure: Honeywell mpr pressure sensor"
  - no change so far
  - will be changed and send out as new version when the dt definition is
    settled down
- Patch 3: "MAINTAINERS: Add Honeywell mpr sensor"
  - no change so far

Andreas Klinger (3):
  dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor
  iio: pressure: Honeywell mprls0025pa pressure sensor
  MAINTAINERS: Add Honeywell mprls0025pa sensor

 .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  13 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/mprls0025pa.c            | 441 ++++++++++++++++++
 5 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 create mode 100644 drivers/iio/pressure/mprls0025pa.c


base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
2.30.2
