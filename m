Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2801704C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjEPLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjEPLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:31:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EFA3;
        Tue, 16 May 2023 04:31:06 -0700 (PDT)
Received: from localhost ([31.220.116.19]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjSLi-1qR1tm3nb8-00kxiO; Tue, 16 May 2023 13:30:45 +0200
Date:   Tue, 16 May 2023 13:30:44 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <ZGNpZM137jF5yzie@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:cuJ/hjWHsow+mdx6wrGYPyytnGBpB+Zd0/DOI6U/oIqhk9jvo4f
 PAh4zEOTYkpDhpsI7JesdcNb410QJHZVy3Bf03BNhj6ULjj2flxCdO7DCHfUdDMOpwom98S
 zux/oE3/XO+yhjUryFKsZgAFL7ApNpG+r0XW2qLC9Legj9N6BvGpqe+jw/YtzVyoOm1/Rbr
 wotpPhcxJ9qdXHVWVFr+Q==
UI-OutboundReport: notjunk:1;M01:P0:6fCnHimARAE=;Dmk1XRyKRN34Tnn2XfwUIfchPpF
 u+DpNpUbFuscVUq4EIC+fmsB05VIO1nc5qWyS6R0CZZAj+X/sfRmUG7Ord2kWSpaued4sh6lL
 jEZA3Ukncozm696ybyqFQ/v0z7zka+XcZMZSbjyGQZ29B6swz7WXuapTGLULTARWIr3FNTkkz
 PymiccSfd4+SbsOL7y/FNO9WQnlwfYY1tgYsFySpOXZ910BNe9p+Bfa9mAeXW/ZMKRnEU5pmj
 LdkBGQPh4iT0SSab3xaRO1ndNwOE8QIjwCa+CFXLeO2qw6Rj55QmBygWKHch+TL2O/ZHokhG+
 NX5jkI9TKyysox6Xkys6L1XHh9bDpLJstk2IG/Ie2NKyEMfUbSnqDW85hjDVx+sQ3pZD9JyvT
 RybjfSMdnxnZSG/nvsNIZbBB/XALnJND7qeQEUwdzmekf1ULbOgQhfbvzs+rd9aBfEWGxEH2N
 zOmpN8XxLMpm8SBhtb2pjl+Dob8obQuKcq7Mgy94xUiT4aisvP3DjZXXPx5kgOnKIAxeYwi1t
 dH4GSW5J+D79SxKuB/rxxDcCgNnWknYXMQCvAT23v42IaA30cGI3NIDqyNao4Q66zSdJw4cjy
 W69xHADnhtNeg3aXVbBfEOT+V5DO+M+iGSmtH+3OyZ7h3nQzced0UFGpIhcdRNgPXQnAD4KL+
 iTWAUY/PSFogSRrV6te/mk3eJ2wFiSnaxqSgmK+f/g==
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

Changes in v5:
- Patch 1: "dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor"
  - add Reviewd-by tag
  - preserve formating in description
- Patch 2: "iio: pressure: Honeywell mprls0025pa pressure sensor"
  - make use of div_s64_rem()
  - document calculation
  - reorder includes
  - use NANO from units.h
- Patch 3: "MAINTAINERS: Add Honeywell mprls0025pa sensor"
  - no changes

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

 .../iio/pressure/honeywell,mprls0025pa.yaml   | 104 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  13 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/mprls0025pa.c            | 450 ++++++++++++++++++
 5 files changed, 575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 create mode 100644 drivers/iio/pressure/mprls0025pa.c


base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
2.30.2
