Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132016254ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKKIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:10:38 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F30F365874;
        Fri, 11 Nov 2022 00:10:36 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:10:36 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5D84D20584CE;
        Fri, 11 Nov 2022 17:10:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:10:36 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B48BCB62A4;
        Fri, 11 Nov 2022 17:10:35 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/6] mmc: sdhci-fujitsu: Add some features and support for F_SDH30_E51
Date:   Fri, 11 Nov 2022 17:10:27 +0900
Message-Id: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds some additional features such as reset control,
non-removable media, and quirks for broken timeout clock.

And this adds support for F_SDH30_E51 IP that is a higher version
of F_SDH30 and supports eMMC 5.1.

The above features are not specific to this IP directly, but are
affected by IP configuration and external wiring.

Changes since v1:
- Add conversion and additional compatible patch for DT bindings
- Add description for F_SDH30_E51 to the commit message
- Append vendor name to MODULE_AUTHOR

Kunihiko Hayashi (6):
  dt-bindings: mmc: Convert sdhci-fujitsu to JSON schema
  mmc: f-sdh30: Add reset control support
  dt-bindings: sdhci-fujitsu: Add compatible string for F_SDH30_E51
  mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
  mmc: f-sdh30: Add support for non-removable media
  mmc: f-sdh30: Add quirks for broken timeout clock capability

 .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml   | 57 +++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 -----------
 drivers/mmc/host/sdhci_f_sdh30.c              | 31 +++++++++-
 drivers/mmc/host/sdhci_f_sdh30.h              |  3 +
 4 files changed, 89 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt

-- 
2.25.1

