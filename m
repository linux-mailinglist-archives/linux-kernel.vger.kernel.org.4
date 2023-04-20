Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2326E93F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjDTMOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjDTMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:14:11 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B637261BD;
        Thu, 20 Apr 2023 05:13:47 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id EA035100009;
        Thu, 20 Apr 2023 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681992826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FKmU07mRpe487AegOhAsJpXczZ7sjGPeDkciIDCToaI=;
        b=noHygQNFQScaDJcJSMzqZFuYOS79Hx85BeoxnrkA4xCXODc3a1XRWFuldyn7B+siYwTENM
        wneHvdwsQ8KKC8yI41P4Fs+3am6d0vvMkuHC1r/Bok5PGPYTP1jLQhwy5yRl48pHllgfzl
        5DfqdHxftW0TVBuMwXbUzD3s8RXjS/XlvDM2OHfxAu3A9SM0B9fpXXBoMu7xtavJ+SFGOu
        1HucqXtMCyWvYT+fGX8y6REl+nVm4XgIcnfWVgxInsKpTWtjMEtGOnUIo5hTK20nfhKgQq
        95SpV/b4LhXNmule1bqjGY5Z2desclgWvQkCNtA/cZeCsxZl/uir+LqkJ7KBng==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Add the Renesas X9250 potentiometers IIO support
Date:   Thu, 20 Apr 2023 14:13:17 +0200
Message-Id: <20230420121320.252884-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Renesas X9250 integrated four digitally controlled potentiometers.
On each potentiometer, the X9250T has a 100 kOhms total resistance and
the X9250U has a 50 kOhms total resistance.

Best regards,
Herve Codina

Herve Codina (3):
  dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
  iio: potentiometer: Add support for the Renesas X9250 potentiometers
  MAINTAINERS: add the Renesas X9250 driver entry

 .../iio/potentiometer/renesas,x9250.yaml      |  56 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/potentiometer/Kconfig             |  10 +
 drivers/iio/potentiometer/Makefile            |   1 +
 drivers/iio/potentiometer/x9250.c             | 233 ++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 create mode 100644 drivers/iio/potentiometer/x9250.c

-- 
2.39.2

