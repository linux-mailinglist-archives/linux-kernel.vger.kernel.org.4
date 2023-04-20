Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEE6E9CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjDTT6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDTT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:58:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C5B2;
        Thu, 20 Apr 2023 12:58:50 -0700 (PDT)
Received: from localhost ([185.104.138.31]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYHO-1qbKQp06ZS-00m0Ex; Thu, 20 Apr 2023 21:58:33 +0200
Date:   Thu, 20 Apr 2023 21:58:26 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Support Honeywell mprls0025pa pressure sensor
Message-ID: <ZEGZYiS0znC2/fZC@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:0RdDq5hj+rqhLGKh3tScDOe0f+IURDleBqsVJ0ab2ideUlEI6Ic
 OzpRtBvPTED7+CeoMPkq2WtVvrbft4aX8KXSFdcWfX0QAyeH3jU15F2LuaRHBPmK/wtYSBn
 DcphjEQ8M7pvhLOOjFbXq5rAhtNzoqeXDemo+OZ93fbSDAl8EXiCsl5jTqm+JOT/Mn+/5XA
 okOX6BdaNmgObNvJNp+RA==
UI-OutboundReport: notjunk:1;M01:P0:LtZiKkPcRTs=;0XaQIH/BrbVYWKmEVh9gBx8maiw
 JHslhfOZLfaQNYe2vcmDr8+6J8UhMik4GKiA9c9HEzpAZsgpwNQqebEhg2ZldfwliiArvxsX4
 8W9G8Il9tBE72+I2GlTTtoTCObvN9opoQKG1YL3gWpu4mF95qbNt3Y5Oo5IM3dYJfG5Pa7PZo
 y5SEadTwEfJA5NG5Iq0/aZbeZqeMMG5KEuv0WLuKEJ6JVyLdZjg4BvtjgNJNeN7A9vOnMz8SR
 Wfrk4kakAm7YoKG60Obz3n+DPhWRh0bG52xS3r+m/H9eNAO7AsyG1XyFyxGx+7UIDsWBH3ZE6
 h083E1qgeLzS3hWS5rmitiRYj4J0mJMk2+KmSs0JMb8w+dvJhrV+21yHktfKBze7Hi/lNm28i
 DMR0flpoumfpXsywGxZ0HBg3OoBpwO0q1v+hp2v4Pw45SKpBLm28c2jFHWK+VAO0elgN/tpIB
 CUsWQXr5kRSVbzKLYRlln/DxlxLUY1tbMwuD6v0X9lo40MnX8eY1zvcpjBwdnVpF/PyNgxBo4
 S0fIEHDsPY3XQ/Ea9onJLxnC9k9K22dIFqetu4pCrDjFys/YtuKaGX11DR1OJ+5KhYSztIqrO
 wBC+PE7z7XYP9HAhVCO488fqhW6gVyYY6SO2h9P7p533pFK4UDyG/G4+HwcW33mzn2On6GASW
 uD615gQB2dQxrPiw1xlQF5/isErTlpc9bPBeKll0fw==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Honeywell mprls0025pa pressure sensor.

This patch series adds support for Honeywell mprls0025pa pressure sensor series.
There are a variety of sensors with different pressure ranges supported.

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
  iio: pressure: Honeywell mpr pressure sensor
  MAINTAINERS: Add Honeywell mpr sensor

 .../iio/pressure/honeywell,mprls0025pa.yaml   |  98 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  12 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/mprls0025pa.c            | 429 ++++++++++++++++++
 5 files changed, 547 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 create mode 100644 drivers/iio/pressure/mprls0025pa.c


base-commit: e0ee50101346ca9cef52da75e3fb4380c27c042a
-- 
2.30.2
