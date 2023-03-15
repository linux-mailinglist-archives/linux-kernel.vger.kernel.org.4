Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51F76BB4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjCONmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjCONmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:42:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423389F1D;
        Wed, 15 Mar 2023 06:42:39 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 938C140012;
        Wed, 15 Mar 2023 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678887758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lkbd/cMcUoVpR7mZNnJF/IQksNBSfHqKCVF1aGbKTv4=;
        b=jteQ23KpMC/4DMU4NbvaKyUlORaE526KRPOUjR7RBSlDQWCR3om0eaUdrRpue01MOuBeJ0
        euObGPgo9oC6NnCd+RhetWgQlX13jdgQbreYd8NxnJMGn0A4/qZyYfiOmcHpExriAB45cN
        XMdm4SqikxtAgCVIKxbhEcMeo/TDAPxbF5G0K01ElYRetC4ItJ1RwKNAFn50fH/im5VBow
        /urKE46D76M/gEUGAZ2oDKTHAffw1xyJXdqq1JsxYv6lAQxmI844rZ27rbJHKyuT0bVV4K
        jzOL1LtUcTb0NHfGhTX0+8WHgmu8evdWtWONr/1suDWDIuG6hVLTHVZAMzaDmg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/7] Add the Lantiq PEF2256 audio support
Date:   Wed, 15 Mar 2023 14:42:24 +0100
Message-Id: <20230315134231.233193-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for audio using the Lantiq PEF2256 framer.

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

The first part of this series (patches 1 to 4) adds the Lantiq PEF2256
driver core.
The second part (patches 5 to 7) adds the audio support using the Lantiq
PEF2256 driver core.

The consumer/provider relation between the codec and the driver core
allows to use the PEF2256 framer for other purpose than audio support.

Best regards,
Herve Codina

Herve Codina (7):
  dt-bindings: misc: Add the Lantiq  PEF2466 E1/T1/J1 framer
  drivers: misc: Add support for the Lantiq PEF2256 framer
  Documentation: sysfs: Document the Lantiq PEF2256 sysfs entry
  MAINTAINERS: Add the Lantiq PEF2256 driver entry
  dt-bindings: sound: Add support for the Lantiq PEF2256 codec
  ASoC: codecs: Add support for the Lantiq PEF2256 codec
  MAINTAINERS: Add the Lantiq PEF2256 ASoC codec entry

 .../sysfs-bus-platform-devices-pef2256        |   10 +
 .../bindings/misc/lantiq,pef2256.yaml         |  190 +++
 .../bindings/sound/lantiq,pef2256-codec.yaml  |   57 +
 MAINTAINERS                                   |   15 +
 drivers/misc/Kconfig                          |   16 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/pef2256.c                        | 1441 +++++++++++++++++
 include/linux/pef2256.h                       |   36 +
 sound/soc/codecs/Kconfig                      |   14 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pef2256-codec.c              |  395 +++++
 11 files changed, 2177 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-devices-pef2256
 create mode 100644 Documentation/devicetree/bindings/misc/lantiq,pef2256.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
 create mode 100644 drivers/misc/pef2256.c
 create mode 100644 include/linux/pef2256.h
 create mode 100644 sound/soc/codecs/pef2256-codec.c

-- 
2.39.2

