Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7A6D2F2F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDAJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:09:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432ED1DF90;
        Sat,  1 Apr 2023 02:09:36 -0700 (PDT)
Received: from localhost ([31.220.113.145]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6DrU-1pp7sm3o9w-006fUD; Sat, 01 Apr 2023 11:09:21 +0200
Date:   Sat, 1 Apr 2023 11:09:20 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Support Honeywell mpr pressure sensor
Message-ID: <ZCf0wM4RT5bFWlhF@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:zgK+ygCVCXelTMtxUNUbxPQkWEUqky6UIddEf/3OxztOxS/sadi
 dz4idOyCKysgFLqhWCjJ0Sa55bmSxV6s5yNhqMrYRZxZS8HyYl+LZywvJF2YumLKACO29/N
 wVR6qcGTGgNz6aQHnqB7CbdP2LjIJFt2fy3o4ymG2hSq226+dmAzm1j3A4smJ1yYU6uU7ny
 hi0MOCz7f7jKrvjJrDvNg==
UI-OutboundReport: notjunk:1;M01:P0:wlNVorxbB08=;BadEdK7XXimWzepSUbpO9RoqmTj
 9d7JigPJ9GT3ENAnYwIBuFPmAjNXC84063jgTa9HrhqiCj5PoHPIFDuicZpNMacKQbg7RKUFR
 Ryjs2a4Q+jxhDuhYUagnhCuvIuuhK9THl4Y3v3pBRHg6RsSPosNuwfQPVDacR1oVQgrz9qPb2
 JZj37yh6+n6z2QbXdBqHscSw4KN9ClOXG3zAps2DAmhw5I56M2t3/f98LO2NtQ30bGA+8YoTV
 aLFkuka1I4KV+AFMMSLCV/Nrhsgm0pLArOjCcNNufpFM4tawRCuRf42db2flecB6PcMOrPuQp
 UAVwYwr/8K9bFVuT72rmwBUUGDvqPwueeiVQnYbJq5qMIEUWmQ4m6ojcVwP4dHyvPGqQJsxxU
 XvRCwYiOhHC4g9gR1Jx4viyQ0E6KykEgJOZ2tJAfG1HE+BtRzYSMJVZbLpwbh6/jvD7sSu5RC
 LS4IjaWtyVghWO5Pt4HA+wI4x/fJmrIUPq4CbMuJbSKjkq1kX/Ok6E08QjJoY2rKTlkfMUpBZ
 WSRFBPDhac+oCYZwvw2CR9jU2dbnOqsC1h5rAhK3+F21vMh8zOcCu9ITWwsLWmfdr465IHzz0
 //e1T0Hqv9uvtcmHBdvhKcejotGlU0Jm0fg2xDIORIbn4D7lzZXX8wS9jGDq7Fg+sKYWime+4
 2TIH9iUsGUgUWHufzNoQiKsXnKjYnSHxXkhGjzr8vg==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Honeywell mpr pressure sensor.

This patch series adds support for Honeywell mpr pressure sensors. There are a variety of sensors
with different pressure range supported. The pressure range needs to be set up in the device tree as
minimum and maximum pressure in Pascal.


Andreas Klinger (3):
  dt-bindings: iio: pressure: Support Honeywell mpr sensors
  iio: pressure: Honeywell mpr pressure sensor
  MAINTAINERS: Add Honeywell mpr sensor

 .../bindings/iio/pressure/honeywell,mpr.yaml  |  74 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  12 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/mpr.c                    | 307 ++++++++++++++++++
 5 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
 create mode 100644 drivers/iio/pressure/mpr.c

-- 
2.30.2
